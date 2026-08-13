class = var_0_10000

local var_0_0 = "BuildingBuff2Activity"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("model.vo.Activity"))

function var_0_1.GetBuildingConfigTable(arg_1_0, arg_1_1)
	pg = var_1_10002

	return var_1_10002.activity_event_building[arg_1_1]
end

function var_0_1.GetBuildingLevel(arg_2_0, arg_2_1)
	local var_2_0

	if not arg_2_0.data1KeyValueList[2][arg_2_1] then
		var_2_0 = 1
	end

	return var_2_0
end

function var_0_1.SetBuildingLevel(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.data1KeyValueList[2][arg_3_1] = arg_3_2

	return
end

function var_0_1.GetBuildingIds(arg_4_0)
	return arg_4_0:getConfig("config_data")[1]
end

function var_0_1.GetTotalBuildingLevel(arg_5_0)
	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.GetBuildingIds(var_5_0)
	local var_5_2 = 0

	ipairs = var_5_0

	for iter_5_0, iter_5_1 in var_5_0(var_5_1) do
		var_5_2 = var_5_2 + arg_5_0:GetBuildingLevel(iter_5_1)
	end

	math = var_3

	return var_3.floor(var_5_2 / #var_5_1)
end

function var_0_1.GetBuildingLevelSum(arg_6_0)
	local var_6_0 = arg_6_0
	local var_6_1 = arg_6_0.GetBuildingIds(var_6_0)
	local var_6_2 = 0

	ipairs = var_6_0

	for iter_6_0, iter_6_1 in var_6_0(var_6_1) do
		var_6_2 = var_6_2 + (arg_6_0:GetBuildingLevel(iter_6_1) - 1)
	end

	return var_6_2
end

function var_0_1.GetSceneBuildingId(arg_7_0)
	return arg_7_0:getConfig("config_id")
end

function var_0_1.GetLastRequestTime(arg_8_0)
	return arg_8_0.data1
end

function var_0_1.RecordLastRequestTime(arg_9_0)
	pg = var_1_10001

	local var_9_0 = var_1_10001.TimeMgr.GetInstance()

	arg_9_0.data1 = var_1.GetServerTime(var_9_0)

	return
end

function var_0_1.CanRequest(arg_10_0)
	pg = var_1_10001

	local var_10_0 = var_1_10001.TimeMgr.GetInstance()

	return var_1.GetNextTime(var_10_0, 0, 0, 0) - 0 > arg_10_0:GetLastRequestTime()
end

return var_0_1
