local TownWorkplace = class("TownWorkplace", import("model.vo.BaseVO"))

TownWorkplace.TYPE = {
	NUMBER = 1,
	RATIO = 2
}

function TownWorkplace:Ctor(arg_1_1, arg_1_2)
	self.id = arg_1_1
	self.configId = self.id
	self.startTime = arg_1_2
	self.storedGold = 0

	return
end

function TownWorkplace:bindConfigTable()
	return pg.activity_town_work_level
end

function TownWorkplace:GetType()
	return self:getConfig("type")
end

function TownWorkplace:GetGoldUnit()
	return self:GetType() == TownWorkplace.TYPE.NUMBER and self:getConfig("gold_gain") or 0
end

function TownWorkplace:GetGoldRatio()
	return self:GetType() == TownWorkplace.TYPE.RATIO and self:getConfig("gold_gain") or 0
end

function TownWorkplace:GetEffectStr()
	return self:GetType() == TownWorkplace.TYPE.NUMBER and string.format("+%s/H", TownActivity.GoldToShow(self:GetGoldUnit() * 16)) or string.format("+%d%%", self:GetGoldRatio() / 100)
end

function TownWorkplace:GetNextId()
	return underscore.detect(self:bindConfigTable().all, function(arg_8_0)
		local var_8_0 = self:bindConfigTable()[arg_8_0]

		return var_8_0.group == self:GetGroup() and var_8_0.level == self:GetLevel() + 1
	end)
end

function TownWorkplace:GetLastId()
	if self:GetLevel() == 0 then
		return nil
	end

	return underscore.detect(self:bindConfigTable().all, function(arg_10_0)
		local var_10_0 = self:bindConfigTable()[arg_10_0]

		return var_10_0.group == self:GetGroup() and var_10_0.level == self:GetLevel() - 1
	end)
end

function TownWorkplace:GetIcon()
	return self:getConfig("pic")
end

function TownWorkplace:GetGroup()
	return self:getConfig("group")
end

function TownWorkplace:GetName()
	return self:getConfig("name")
end

function TownWorkplace:GetLevel()
	return self:getConfig("level")
end

function TownWorkplace:GetAddExp()
	return self:getConfig("exp_display")
end

function TownWorkplace:GetCostGold()
	return self:getConfig("gold")
end

function TownWorkplace:GetNeedTownLv()
	return self:getConfig("town_level")
end

function TownWorkplace:OnUpdateTime(arg_18_1)
	self.storedGold = self:GetGoldUnit() * (arg_18_1 - self.startTime)

	return
end

function TownWorkplace:GetStoredGold()
	return self.storedGold
end

function TownWorkplace:ResetStartTime(arg_20_1)
	self.startTime = arg_20_1

	return self:GetGoldUnit() * (arg_20_1 - self.startTime)
end

return TownWorkplace
