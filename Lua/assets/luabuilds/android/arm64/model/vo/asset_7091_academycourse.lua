local AcademyCourse = class("AcademyCourse", import(".BaseVO"))

AcademyCourse.MaxStudyTime = 43200

function AcademyCourse:Ctor()
	self.proficiency = 0

	return
end

function AcademyCourse:bindConfigTable()
	return pg.class_upgrade_group
end

function AcademyCourse:getConfig(arg_3_1)
	return self:bindConfigTable()[pg.TimeMgr.GetInstance():GetServerWeek()][arg_3_1]
end

function AcademyCourse:update(arg_4_1)
	self.proficiency = arg_4_1.proficiency

	return
end

function AcademyCourse:GetProficiency()
	return self.proficiency
end

function AcademyCourse:getExtraRate()
	return pg.TimeMgr.GetInstance():GetServerWeek() == 7 and 2 or 1
end

function AcademyCourse:SetProficiency(arg_7_1)
	self.proficiency = arg_7_1

	return
end

return AcademyCourse
