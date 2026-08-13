class = var_0_10000

local var_0_0 = "ClassResourceField"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".BaseResourceField"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	local var_1_0 = arg_1_0:bindConfigTable()

	table = var_1_10003

	local var_1_1 = var_1_10003.insert
	local var_1_2 = arg_1_0.attrs

	ResourceFieldAttr = var_1_10006

	local var_1_3 = var_1_10006.New
	local var_1_4 = var_1_0

	i18n = var_1_10009

	var_1_1(var_1_2, var_1_3(var_1_4, var_1_10009("class_attr_store"), "stock"))

	table = var_1_1

	local var_1_5 = var_1_1.insert
	local var_1_6 = arg_1_0.attrs

	ResourceFieldAttr = var_6

	local var_1_7 = var_6.New
	local var_1_8 = var_1_0

	i18n = var_9

	var_1_5(var_1_6, var_1_7(var_1_8, var_9("class_attr_proficiency"), "store"))

	table = var_1_5

	local var_1_9 = var_1_5.insert
	local var_1_10 = arg_1_0.attrs

	ResourceFieldPercentAttr = var_6

	local var_1_11 = var_6.New
	local var_1_12 = var_1_0

	i18n = var_9

	var_1_9(var_1_10, var_1_11(var_1_12, var_9("class_attr_getproficiency"), "proficency_get_percent", 1))

	table = var_1_9

	local var_1_13 = var_1_9.insert
	local var_1_14 = arg_1_0.attrs

	ResourceFieldProductAttr = var_6

	local var_1_15 = var_6.New
	local var_1_16 = var_1_0

	i18n = var_9

	var_1_13(var_1_14, var_1_15(var_1_16, var_9("class_attr_costproficiency"), "proficency_cost_per_min", 60))

	return
end

function var_0_1.GetKeyWord(arg_2_0)
	return "class"
end

function var_0_1.bindConfigTable(arg_3_0)
	pg = var_1_10001

	return var_1_10001.class_upgrade_template
end

function var_0_1.GetUpgradeType(arg_4_0)
	return 20
end

function var_0_1.GetResourceType(arg_5_0)
	return arg_5_0:getConfig("item_id")
end

function var_0_1.GetMaxProficiency(arg_6_0)
	return arg_6_0:getConfig("store")
end

function var_0_1.GetTranValuePreHour(arg_7_0)
	return arg_7_0:getConfig("proficency_cost_per_min") * 60
end

function var_0_1.GetTarget(arg_8_0)
	local var_8_0 = arg_8_0
	local var_8_1 = arg_8_0.GetResourceType(var_8_0)

	Item = var_1_10002

	local var_8_2 = var_1_10002.getConfigData(var_8_1).usage_arg

	tonumber = var_8_0

	return var_8_0(var_8_2)
end

function var_0_1.GetExp2ProficiencyRatio(arg_9_0)
	return arg_9_0:getConfig("proficency_get_percent")
end

function var_0_1.GetDesc(arg_10_0)
	i18n = var_1_10001

	return var_1_10001("naval_academy_res_desc_class")
end

function var_0_1.GetName(arg_11_0)
	i18n = var_1_10001

	return var_1_10001("school_title_dajiangtang")
end

function var_0_1.getHourProduct(arg_12_0)
	return 0
end

function var_0_1.GetPlayerRes(arg_13_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10003

	local var_13_0 = var_1_10001(var_1_10003)

	return var_1.getRawData(var_13_0).expField
end

function var_0_1.HasRes(arg_14_0)
	return arg_14_0:GetPlayerRes() >= arg_14_0:GetTarget()
end

function var_0_1.GetGenResCnt(arg_15_0)
	local var_15_0 = arg_15_0:GetTarget()

	getProxy = var_1_10002
	PlayerProxy = var_1_10004

	local var_15_1 = var_1_10002(var_1_10004)
	local var_15_2 = var_2.getData(var_15_1)
	local var_15_3 = var_2.getResource

	PlayerConst = var_1_10006

	local var_15_4 = var_15_3(var_15_2, var_1_10006.ResClassField)

	math = var_15_1

	return (var_15_1.floor(var_15_4 / var_15_0))
end

function var_0_1.GetCanGetResCnt(arg_16_0)
	local var_16_0 = arg_16_0
	local var_16_1 = arg_16_0.GetGenResCnt(var_16_0)
	local var_16_2 = arg_16_0
	local var_16_3 = arg_16_0.GetResourceType(var_16_2)

	Item = var_16_0

	local var_16_4 = var_16_0.getConfigData(var_16_3).max_num

	getProxy = var_16_2
	BagProxy = var_1_10006

	local var_16_5 = var_16_2(var_1_10006)
	local var_16_6 = var_16_4 - var_4.getItemCountById(var_16_5, var_16_3)

	math = var_16_5

	return (var_16_5.min(var_16_1, var_16_6))
end

function var_0_1.CanGetRes(arg_17_0)
	if arg_17_0:GetCanGetResCnt() <= 0 then
		return false
	end

	return true
end

return var_0_1
