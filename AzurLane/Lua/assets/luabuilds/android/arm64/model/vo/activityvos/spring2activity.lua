local var_0_0 = class("Spring2Activity", import("model.vo.ActivityVOs.ITaskActivity"))

var_0_0.OPERATION_SETSHIP = 1

function var_0_0.Ctor(arg_1_0, ...)
	var_0_0.super.Ctor(arg_1_0, ...)

	for iter_1_0 = 1, arg_1_0:GetSlotCount() do
		arg_1_0.data1_list[iter_1_0] = arg_1_0.data1_list[iter_1_0] or 0
	end

	return
end

function var_0_0.GetSlotCount(arg_2_0)
	return arg_2_0:getConfig("config_data")[2]
end

function var_0_0.GetTotalSlotCount(arg_3_0)
	return arg_3_0:getConfig("config_data")[2]
end

function var_0_0.GetAvaliableShipIds(arg_4_0)
	return _.filter(arg_4_0.data1_list, function(arg_5_0)
		return arg_5_0 > 0
	end)
end

function var_0_0.GetShipIds(arg_6_0)
	return arg_6_0.data1_list
end

function var_0_0.SetShipIds(arg_7_0, arg_7_1)
	table.Foreach(arg_7_1, function(arg_8_0, arg_8_1)
		arg_7_0.data1_list[arg_8_1.key] = arg_8_1.value

		return
	end)

	return
end

function var_0_0.GetEnergyRecoverAddition(arg_9_0)
	return arg_9_0:getConfig("config_data")[1]
end

function var_0_0.GetUnlockTaskIds(arg_10_0)
	return _.flatten(arg_10_0:GetTaskIdsByDay())
end

function var_0_0.GetFinishedTaskIds(arg_11_0)
	return arg_11_0.data2_list
end

function var_0_0.GetTaskIdsByDay(arg_12_0)
	return arg_12_0:getConfig("config_data")[3]
end

function var_0_0.readyToAchieve(arg_13_0)
	assert(isa(arg_13_0, Spring2Activity))

	return _.any(getProxy(ActivityTaskProxy):getTaskVOsByActId((arg_13_0:GetConfigID())), function(arg_14_0)
		return arg_14_0:isFinish() and not arg_14_0:isOver()
	end)
end

return var_0_0
