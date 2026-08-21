local var_0_0 = class("BuildingBuff2Activity", import("model.vo.Activity"))

function var_0_0.GetBuildingConfigTable(arg_1_0, arg_1_1)
	return pg.activity_event_building[arg_1_1]
end

function var_0_0.GetBuildingLevel(arg_2_0, arg_2_1)
	return arg_2_0.data1KeyValueList[2][arg_2_1] or 1
end

function var_0_0.SetBuildingLevel(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.data1KeyValueList[2][arg_3_1] = arg_3_2

	return
end

function var_0_0.GetBuildingIds(arg_4_0)
	return arg_4_0:getConfig("config_data")[1]
end

function var_0_0.GetTotalBuildingLevel(arg_5_0)
	local var_5_0 = arg_5_0:GetBuildingIds()
	local var_5_1 = 0

	for iter_5_0, iter_5_1 in ipairs(var_5_0) do
		var_5_1 = var_5_1 + arg_5_0:GetBuildingLevel(iter_5_1)
	end

	return math.floor(var_5_1 / #var_5_0)
end

function var_0_0.GetBuildingLevelSum(arg_6_0)
	local var_6_0 = 0

	for iter_6_0, iter_6_1 in ipairs((arg_6_0:GetBuildingIds())) do
		var_6_0 = var_6_0 + (arg_6_0:GetBuildingLevel(iter_6_1) - 1)
	end

	return var_6_0
end

function var_0_0.GetSceneBuildingId(arg_7_0)
	return arg_7_0:getConfig("config_id")
end

function var_0_0.GetLastRequestTime(arg_8_0)
	return arg_8_0.data1
end

function var_0_0.RecordLastRequestTime(arg_9_0)
	arg_9_0.data1 = pg.TimeMgr.GetInstance():GetServerTime()

	return
end

function var_0_0.CanRequest(arg_10_0)
	local var_10_0 = pg.TimeMgr.GetInstance()

	return var_10_0:GetNextTime(0, 0, 0) - 0 > arg_10_0:GetLastRequestTime()
end

return var_0_0
