local Student = class("Student", import(".BaseVO"))

Student.WAIT = 1
Student.ATTEND = 2
Student.CANCEL_TYPE_AUTO = 0
Student.CANCEL_TYPE_MANUAL = 1
Student.CANCEL_TYPE_QUICKLY = 2

function Student:Ctor(arg_1_1)
	self.id = arg_1_1.id or arg_1_1.room_id
	self.skillId = arg_1_1.skill_pos
	self.skillIdIndex = nil
	self.lessonId = arg_1_1.lessonId
	self.shipId = arg_1_1.ship_id
	self.finishTime = arg_1_1.finish_time
	self.startTime = arg_1_1.start_time
	self.time = arg_1_1.time
	self.exp = arg_1_1.exp
	self.state = arg_1_1.state or Student.ATTEND

	return
end

function Student:IsFinish()
	return pg.TimeMgr.GetInstance():GetServerTime() >= self:getFinishTime()
end

function Student:updateSkillId(arg_3_1)
	self.skillId = arg_3_1

	return
end

function Student:setSkillIndex(arg_4_1)
	self.skillIdIndex = arg_4_1

	return
end

function Student:getSkillId(arg_5_1)
	if self.skillId then
		return self.skillId
	else
		return arg_5_1:getSkillList()[self.skillIdIndex]
	end

	return
end

function Student:setLesson(arg_6_1)
	self.lessonId = arg_6_1

	return
end

function Student:setFinishTime(arg_7_1)
	self.finishTime = arg_7_1

	return
end

function Student:setTime(arg_8_1)
	self.time = arg_8_1

	return
end

function Student:getTime()
	return self.time or self.finishTime - self.startTime
end

function Student:getFinishTime()
	return self.finishTime
end

function Student:getState()
	return self.state
end

function Student:getSkillDesc(arg_12_1, arg_12_2)
	return (getSkillDescLearn(self, arg_12_1, arg_12_2))
end

function Student:getSkillName()
	return getSkillName(self:getSkillId((getProxy(BayProxy):getShipById(self.shipId))))
end

function Student:getShipVO()
	return (getProxy(BayProxy):getShipById(self.shipId))
end

return Student
