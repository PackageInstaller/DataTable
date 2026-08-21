local var_0_0 = class("BuildingBuffActivity", import("model.vo.Activity"))

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
	return arg_4_0:getConfig("config_data")
end

function var_0_0.GetMaterialCount(arg_5_0, arg_5_1)
	return arg_5_0.data1KeyValueList[1][arg_5_1] or 0
end

return var_0_0
