local var_0_0 = class("SpringActivity", import("model.vo.Activity"))

var_0_0.ActivityType = ActivityConst.ACTIVITY_TYPE_HOTSPRING
var_0_0.OPERATION_UNLOCK = 1
var_0_0.OPERATION_SETSHIP = 2

function var_0_0.Ctor(arg_1_0, ...)
	var_0_0.super.Ctor(arg_1_0, ...)

	for iter_1_0 = 1, arg_1_0:GetSlotCount() do
		arg_1_0.data1_list[iter_1_0] = arg_1_0.data1_list[iter_1_0] or 0
	end

	return
end

function var_0_0.GetSlotCount(arg_2_0)
	return arg_2_0.data1 + arg_2_0:GetInitialSlotCount()
end

function var_0_0.AddSlotCount(arg_3_0)
	arg_3_0.data1 = arg_3_0.data1 + 1
	arg_3_0.data1_list[arg_3_0:GetSlotCount()] = 0

	local var_3_0, var_3_1 = arg_3_0:GetUpgradeCost()

	arg_3_0.data2 = math.max(0, arg_3_0.data2 - var_3_1)

	return
end

function var_0_0.GetInitialSlotCount(arg_4_0)
	return arg_4_0:getConfig("config_data")[1][5] or 0
end

function var_0_0.GetUnlockableSlotCount(arg_5_0)
	return arg_5_0:getConfig("config_data")[1][3]
end

function var_0_0.GetTotalSlotCount(arg_6_0)
	return arg_6_0:GetInitialSlotCount() + arg_6_0:GetUnlockableSlotCount()
end

function var_0_0.GetAvaliableShipIds(arg_7_0)
	return _.filter(arg_7_0.data1_list, function(arg_8_0)
		return arg_8_0 > 0
	end)
end

function var_0_0.GetShipIds(arg_9_0)
	return arg_9_0.data1_list
end

function var_0_0.SetShipIds(arg_10_0, arg_10_1)
	table.Foreach(arg_10_1, function(arg_11_0, arg_11_1)
		arg_10_0.data1_list[arg_11_1.key] = arg_11_1.value

		return
	end)

	return
end

function var_0_0.GetEnergyRecoverAddition(arg_12_0)
	return arg_12_0:getConfig("config_data")[1][4]
end

function var_0_0.GetCoins(arg_13_0)
	return arg_13_0.data2
end

function var_0_0.GetUpgradeCost(arg_14_0)
	return arg_14_0:getConfig("config_data")[1][1], arg_14_0:getConfig("config_data")[1][2]
end

return var_0_0
