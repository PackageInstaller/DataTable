local IslandShipStatus = class("IslandShipStatus", import("model.vo.BaseVO"))

IslandShipStatus.COLOR_NULL = 0
IslandShipStatus.COLOR_RED = 1
IslandShipStatus.COLOR_BLUE = 2

function IslandShipStatus:Ctor(arg_1_1)
	self.id = arg_1_1.id
	self.configId = arg_1_1.id
	self.startTime = arg_1_1.start_time or 0
	self.isSkill = arg_1_1.isSkill
	self.time = 0

	self:InitEndTime()

	return
end

function IslandShipStatus:InitEndTime()
	local var_2_0 = self:GetDuration()

	self.time = var_2_0 == 0 and 0 or self.startTime + var_2_0

	return
end

function IslandShipStatus:GetEndTime()
	return self.time
end

function IslandShipStatus:GetStartTime()
	return self.startTime
end

function IslandShipStatus:IsSkillBuff()
	return self.isSkill
end

function IslandShipStatus:GetGroup()
	return self:getConfig("buff_group")
end

function IslandShipStatus:GetLevel()
	return self:getConfig("buff_level")
end

function IslandShipStatus:GetDuelTypeList()
	return self:getConfig("type_duel")
end

function IslandShipStatus:GetDuelIdList()
	return self:getConfig("buff_duel")
end

function IslandShipStatus:GetDuration()
	return self:getConfig("buff_time")
end

function IslandShipStatus:GetBuffType()
	return self:getConfig("buff_type")
end

function IslandShipStatus:GetBuffEffect()
	return self:getConfig("type_use")
end

function IslandShipStatus:bindConfigTable()
	return pg.island_buff_template
end

function IslandShipStatus:AddTime(arg_14_1)
	self.time = math.max(self.time, (pg.TimeMgr.GetInstance():GetServerTime())) + arg_14_1

	return
end

function IslandShipStatus:IsExpiration()
	if self.time == 0 then
		return false
	end

	return pg.TimeMgr.GetInstance():GetServerTime() >= self.time
end

function IslandShipStatus:GetDesc()
	return self:getConfig("buff_desc")
end

function IslandShipStatus:GetName()
	return self:getConfig("name")
end

function IslandShipStatus:IsRed()
	return self:getConfig("buff_color") == IslandShipStatus.COLOR_RED
end

function IslandShipStatus:IsBlue()
	return self:getConfig("buff_color") == IslandShipStatus.COLOR_BLUE
end

function IslandShipStatus:CanDisplay()
	return self:getConfig("buff_color") ~= IslandShipStatus.COLOR_NULL
end

return IslandShipStatus
