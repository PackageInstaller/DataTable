class = var_0_10000

local var_0_0 = "VirtualBagActivity"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("model.vo.Activity"))

function var_0_1.getVitemNumber(arg_1_0, arg_1_1)
	local var_1_0

	if not arg_1_0.data1KeyValueList[1][arg_1_1] then
		var_1_0 = 0
	end

	return var_1_0
end

function var_0_1.setVitemNumber(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_0.data1KeyValueList[1][arg_2_1] then
		arg_2_0.data1KeyValueList[1][arg_2_1] = arg_2_2
	end

	return
end

function var_0_1.addVitemNumber(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_0:getVitemNumber(arg_3_1)

	arg_3_0.data1KeyValueList[1][arg_3_1] = var_3_0 + arg_3_2

	return
end

function var_0_1.subVitemNumber(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0.getVitemNumber(var_4_0, arg_4_1)
	local var_4_2 = arg_4_0.data1KeyValueList[1]

	math = var_4_0
	var_4_2[arg_4_1] = var_4_0.max(0, var_4_1 - arg_4_2)

	return
end

function var_0_1.GetAllVitems(arg_5_0)
	return arg_5_0.data1KeyValueList[1]
end

function var_0_1.GetDropCfgByType(arg_6_0)
	local var_6_0

	if arg_6_0 then
		::label_6_0::

		AcessWithinNull = var_6_0
		pg = var_1_10003
		var_6_0 = var_6_0(var_1_10003.activity_drop_type[arg_6_0], "activity_id")
	end

	if var_6_0 then
		::label_6_1::

		AcessWithinNull = var_1_10002
		pg = var_1_10004
		var_1_10002 = var_1_10002(var_1_10004.activity_template[var_6_0], "type")
	end

	local var_6_1 = {}

	ActivityConst = var_1_10004

	local var_6_2 = var_1_10004.ACTIVITY_TYPE_ATELIER_LINK

	AtelierMaterial = var_1_10005
	var_6_1[var_6_2] = var_1_10005
	ActivityConst = var_6_2

	local var_6_3 = var_6_2.ACTIVITY_TYPE_WORKBENCH

	WorkBenchItem = var_1_10005
	var_6_1[var_6_3] = var_1_10005

	local var_6_4

	var_6_4 = var_1_10002 and var_6_1[var_1_10002]

	return
end

return var_0_1
