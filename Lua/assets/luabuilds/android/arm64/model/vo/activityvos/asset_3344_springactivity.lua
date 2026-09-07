local SpringActivity = class("SpringActivity", import("model.vo.Activity"))

SpringActivity.ActivityType = ActivityConst.ACTIVITY_TYPE_HOTSPRING
SpringActivity.OPERATION_UNLOCK = 1
SpringActivity.OPERATION_SETSHIP = 2

function SpringActivity:Ctor(...)
	SpringActivity.super.Ctor(self, ...)

	for iter_1_0 = 1, self:GetSlotCount() do
		self.data1_list[iter_1_0] = self.data1_list[iter_1_0] or 0
	end

	return
end

function SpringActivity:GetSlotCount()
	return self.data1 + self:GetInitialSlotCount()
end

function SpringActivity:AddSlotCount()
	self.data1 = self.data1 + 1
	self.data1_list[self:GetSlotCount()] = 0

	local var_3_0, var_3_1 = self:GetUpgradeCost()

	self.data2 = math.max(0, self.data2 - var_3_1)

	return
end

function SpringActivity:GetInitialSlotCount()
	return self:getConfig("config_data")[1][5] or 0
end

function SpringActivity:GetUnlockableSlotCount()
	return self:getConfig("config_data")[1][3]
end

function SpringActivity:GetTotalSlotCount()
	return self:GetInitialSlotCount() + self:GetUnlockableSlotCount()
end

function SpringActivity:GetAvaliableShipIds()
	return _.filter(self.data1_list, function(arg_8_0)
		return arg_8_0 > 0
	end)
end

function SpringActivity:GetShipIds()
	return self.data1_list
end

function SpringActivity:SetShipIds(arg_10_1)
	table.Foreach(arg_10_1, function(arg_11_0, arg_11_1)
		self.data1_list[arg_11_1.key] = arg_11_1.value

		return
	end)

	return
end

function SpringActivity:GetEnergyRecoverAddition()
	return self:getConfig("config_data")[1][4]
end

function SpringActivity:GetCoins()
	return self.data2
end

function SpringActivity:GetUpgradeCost()
	return self:getConfig("config_data")[1][1], self:getConfig("config_data")[1][2]
end

return SpringActivity
