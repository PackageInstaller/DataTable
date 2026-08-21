local var_0_0 = class("VirtualBagActivity", import("model.vo.Activity"))

function var_0_0.getVitemNumber(arg_1_0, arg_1_1)
	return arg_1_0.data1KeyValueList[1][arg_1_1] or 0
end

function var_0_0.setVitemNumber(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_0.data1KeyValueList[1][arg_2_1] then
		arg_2_0.data1KeyValueList[1][arg_2_1] = arg_2_2
	end

	return
end

function var_0_0.addVitemNumber(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.data1KeyValueList[1][arg_3_1] = arg_3_0:getVitemNumber(arg_3_1) + arg_3_2

	return
end

function var_0_0.subVitemNumber(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.data1KeyValueList[1][arg_4_1] = math.max(0, arg_4_0:getVitemNumber(arg_4_1) - arg_4_2)

	return
end

function var_0_0.GetAllVitems(arg_5_0)
	return arg_5_0.data1KeyValueList[1]
end

function var_0_0.GetDropCfgByType(arg_6_0)
	local var_6_0 = arg_6_0 and AcessWithinNull(pg.activity_drop_type[arg_6_0], "activity_id")
	local var_6_1 = var_6_0 and AcessWithinNull(pg.activity_template[var_6_0], "type")
	local var_6_2 = {
		[ActivityConst.ACTIVITY_TYPE_ATELIER_LINK] = AtelierMaterial,
		[ActivityConst.ACTIVITY_TYPE_WORKBENCH] = WorkBenchItem
	}

	return
end

return var_0_0
