local TownWorkplace2 = class("TownWorkplace2", import("model.vo.BaseVO"))

TownWorkplace2.TYPE = {
	ROLE = 3,
	RATIO = 2,
	NUMBER = 1
}

function TownWorkplace2:Ctor(arg_1_1, arg_1_2)
	self.id = arg_1_1
	self.configId = self.id
	self.startTime = arg_1_2
	self.storedGold = 0
	self.gold_time_limit = pg.activity_town_2[ActivityConst.LiquorFloor_ACT_ID].gold_time_limit

	return
end

function TownWorkplace2:bindConfigTable()
	return pg.activity_town_work_level_2
end

function TownWorkplace2:GetType()
	return self:getConfig("type")
end

function TownWorkplace2:GetGoldUnit()
	return self:GetType() == TownWorkplace2.TYPE.NUMBER and self:GetTypeParam() or 0
end

function TownWorkplace2:GetGoldRatio()
	return self:GetType() == TownWorkplace2.TYPE.UPPER and self:GetTypeParam() or 0
end

function TownWorkplace2:GetEffectStr()
	return self:GetType() == TownWorkplace2.TYPE.NUMBER and string.format("+%s/H", TownActivity2.GoldToShow(self:GetGoldUnit() * 16)) or string.format("+%d%%", self:GetGoldRatio() / 100)
end

function TownWorkplace2:GetNextId()
	return underscore.detect(self:bindConfigTable().all, function(arg_8_0)
		local var_8_0 = self:bindConfigTable()[arg_8_0]

		return var_8_0.group == self:GetGroup() and var_8_0.level == self:GetLevel() + 1
	end)
end

function TownWorkplace2:GetLastId()
	if self:GetLevel() == 0 then
		return nil
	end

	return underscore.detect(self:bindConfigTable().all, function(arg_10_0)
		local var_10_0 = self:bindConfigTable()[arg_10_0]

		return var_10_0.group == self:GetGroup() and var_10_0.level == self:GetLevel() - 1
	end)
end

function TownWorkplace2:GetId()
	return self:getConfig("id")
end

function TownWorkplace2:GetDesc()
	return self:getConfig("desc")
end

function TownWorkplace2:GetIcon()
	return self:getConfig("pic")
end

function TownWorkplace2:GetGroup()
	return self:getConfig("group")
end

function TownWorkplace2:GetName()
	return self:getConfig("name")
end

function TownWorkplace2:GetLevel()
	return self:getConfig("level")
end

function TownWorkplace2:GetNeedTownLv()
	return self:getConfig("town_level")
end

function TownWorkplace2:GetTypeParam()
	return self:getConfig("type_param")
end

function TownWorkplace2:GetUpgrade()
	return self:getConfig("upgrade")
end

function TownWorkplace2:OnUpdateTime(arg_20_1)
	self.storedGold = self:GetGoldUnit() * (arg_20_1 - self.startTime)

	return
end

function TownWorkplace2:GetStoredGold()
	return self.storedGold
end

function TownWorkplace2:ResetStartTime(arg_22_1)
	self.startTime = arg_22_1
	self.gold_time_limit = self.gold_time_limit - arg_22_1

	return self:GetGoldUnit() * (arg_22_1 - self.startTime)
end

function TownWorkplace2:OnStartTime()
	local var_23_0 = pg.TimeMgr.GetInstance():GetServerTime() - self.startTime

	if var_23_0 >= self.gold_time_limit then
		var_23_0 = self.gold_time_limit
	end

	return self:GetGoldUnit() * var_23_0
end

return TownWorkplace2
