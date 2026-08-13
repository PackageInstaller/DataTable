class = var_0_10000

local var_0_0 = "BuildingBuffActivity"

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
	return arg_4_0:getConfig("config_data")
end

function var_0_1.GetMaterialCount(arg_5_0, arg_5_1)
	local var_5_0

	if not arg_5_0.data1KeyValueList[1][arg_5_1] then
		var_5_0 = 0
	end

	return var_5_0
end

return var_0_1
