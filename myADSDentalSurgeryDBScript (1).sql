create table dentist (
	id serial primary key,
	firstName varchar(50) not null,
	lastName varchar(50) not null,
	phoneNumber varchar(15),
	specialization varchar(100)
);

create table surgery (
	id serial primary key,
	name varchar(100),
	location varchar(255),
	phoneNumber varchar(15)
);

create table patient (
	id serial primary key,
	firstName varchar(50) not null,
	lastName varchar(50) not null,
	phoneNumber varchar(15),
	email varchar(100),
	mailingAddress varchar(255),
	dateOfBirth Date
);

create table appointment (
	id serial primary key,
	dentist_id int references dentist(id),
	patient_id int references patient(id),
	surgery_id int references surgery(id),
	appointmentDate Date,
	appointmentTime Time
);


INSERT INTO dentist (id, firstName, lastName, phoneNumber, email, specialization)
VALUES
    (1, 'John', 'Doe', '123-456-7890', 'john.doe@example.com', 'General Dentistry'),
    (2, 'Jane', 'Smith', '987-654-3210', 'jane.smith@example.com', 'Orthodontics'),
    (3, 'Michael', 'Johnson', '555-555-5555', 'michael.johnson@example.com', 'Pediatric Dentistry');

INSERT INTO patient (id, firstName, lastName, phoneNumber, email, mailingAddress, dateOfBirth)
VALUES
    (1, 'Alice', 'Johnson', '111-111-1111', 'alice.johnson@example.com', '123 Main St, Anytown, USA', '1990-05-15'),
    (2, 'Bob', 'Smith', '222-222-2222', 'bob.smith@example.com', '456 Elm St, Othertown, USA', '1985-10-20'),
    (3, 'Charlie', 'Brown', '333-333-3333', 'charlie.brown@example.com', '789 Oak St, Anothertown, USA', '1998-03-25');

INSERT INTO surgery (id, name, location, phoneNumber)
VALUES
    (1, 'Main Street Dental Clinic', '456 Main St, Anytown, USA', '555-123-4567'),
    (2, 'Elite Orthodontics Center', '789 Elm St, Othertown, USA', '555-987-6543'),
    (3, 'Happy Smiles Pediatric Dentistry', '101 Oak St, Anothertown, USA', '555-789-0123');

INSERT INTO appointment (id, dentist_id, patient_id, surgery_id, appointmentDate, appointmentTime)
VALUES
    (1, 1, 1, 1, '2024-02-21', '09:00:00'),
    (2, 2, 2, 2, '2024-02-22', '10:30:00'),
    (3, 1, 3, 3, '2024-02-23', '11:45:00'),
    (4, 3, 1, 1, '2024-02-24', '14:00:00'),
    (5, 2, 2, 2, '2024-02-25', '15:15:00');


-- Display the list of ALL Dentists registered in the system, sorted in ascending
-- order of their lastNames
select * from dentist order by lastName;

-- Display the list of ALL Appointments for a given Dentist by their dentist_Id
-- number. Include in the result, the Patient information. 
select a.id, a.appointmentdate, a.appointmenttime,
       p.id, p.firstName AS patient_first_name, p.lastName AS patient_last_name,
       p.phoneNumber AS patient_phone_number, p.email AS patient_email
from appointment a
join patient p ON a.patient_id = p.id
where a.dentist_id = 2;

-- Display the list of ALL Appointments that have been scheduled at a Surgery
-- Location 
select * from appointment where surgery_id = 2;

-- Display the list of the Appointments booked for a given Patient on a given Date. 
select * from appointment where patient_id = 1 and appointmentdate = '2024-02-24';