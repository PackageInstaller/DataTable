class = var_0_10000

local var_0_0 = "Spring2Activity"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("model.vo.ActivityVOs.ITaskActivity"))

var_0_1.OPERATION_SETSHIP = 1

function var_0_1.Ctor(arg_1_0, ...)
	var_0_1.super.Ctor(arg_1_0, ...)

	for iter_1_0 = 1, arg_1_0:GetSlotCount() do
		local var_1_0 = arg_1_0.data1_list
		local var_1_1

		if not arg_1_0.data1_list[iter_1_0] then
			var_1_1 = 0
		end

		var_1_0[iter_1_0] = var_1_1
	end

	return
end

function var_0_1.GetSlotCount(arg_2_0)
	return arg_2_0:getConfig("config_data")[2]
end

function var_0_1.GetTotalSlotCount(arg_3_0)
	return arg_3_0:getConfig("config_data")[2]
end

function var_0_1.GetAvaliableShipIds(arg_4_0)
	_ = var_1_10001

	return var_1_10001.filter(arg_4_0.data1_list, function(arg_5_0)
		return arg_5_0 > 0
	end)
end

function var_0_1.GetShipIds(arg_6_0)
	return arg_6_0.data1_list
end

function var_0_1.SetShipIds(arg_7_0, arg_7_1)
	table = var_1_10002

	var_1_10002.Foreach(arg_7_1, function(arg_8_0, arg_8_1)
		arg_7_0.data1_list[arg_8_1.key] = arg_8_1.value

		return
	end)

	return
end

function var_0_1.GetEnergyRecoverAddition(arg_9_0)
	return arg_9_0:getConfig("config_data")[1]
end

function var_0_1.GetUnlockTaskIds(arg_10_0)
	_ = var_1_10001

	return var_1_10001.flatten(arg_10_0:GetTaskIdsByDay())
end

function var_0_1.GetFinishedTaskIds(arg_11_0)
	return arg_11_0.data2_list
end

function var_0_1.GetTaskIdsByDay(arg_12_0)
	return arg_12_0:getConfig("config_data")[3]
end

function var_0_1.readyToAchieve(arg_13_0)
	assert = var_1_10001
	isa = var_1_10003

	local var_13_0 = arg_13_0

	Spring2Activity = var_1_10006

	var_1_10001(var_1_10003(var_13_0, var_1_10006))

	local var_13_1 = arg_13_0
	local var_13_2 = arg_13_0.GetConfigID(var_13_1)

	getProxy = var_1_10002
	ActivityTaskProxy = var_1_10004

	local var_13_3 = var_1_10002(var_1_10004)
	local var_13_4 = var_2.getTaskVOsByActId(var_13_3, var_13_2)

	_ = var_13_1

	return var_13_1.any(var_13_4, function(arg_14_0)
		local var_14_0 = arg_14_0:isFinish()
		local var_14_1 = arg_14_0:isOver()

		return var_14_0 and not var_14_1
	end)
end

return var_0_1
