class = var_0_10000

local var_0_0 = "ClassResourceField"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".BaseResourceField"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.bindConfigTable(var_1_0)

	table = var_1_0

	local var_1_2 = var_1_0.insert
	local var_1_3 = arg_1_0.attrs

	ResourceFieldAttr = var_1_10005

	local var_1_4 = var_1_10005.New
	local var_1_5 = var_1_1

	i18n = var_1_10007

	var_1_2(var_1_3, var_1_4(var_1_5, var_1_10007("class_attr_store"), "stock"))

	table = var_1_2

	local var_1_6 = var_1_2.insert
	local var_1_7 = arg_1_0.attrs

	ResourceFieldAttr = var_5

	local var_1_8 = var_5.New
	local var_1_9 = var_1_1

	i18n = var_7

	var_1_6(var_1_7, var_1_8(var_1_9, var_7("class_attr_proficiency"), "store"))

	table = var_1_6

	local var_1_10 = var_1_6.insert
	local var_1_11 = arg_1_0.attrs

	ResourceFieldPercentAttr = var_5

	local var_1_12 = var_5.New
	local var_1_13 = var_1_1

	i18n = var_7

	var_1_10(var_1_11, var_1_12(var_1_13, var_7("class_attr_getproficiency"), "proficency_get_percent", 1))

	table = var_1_10

	local var_1_14 = var_1_10.insert
	local var_1_15 = arg_1_0.attrs

	ResourceFieldProductAttr = var_5

	local var_1_16 = var_5.New
	local var_1_17 = var_1_1

	i18n = var_7

	var_1_14(var_1_15, var_1_16(var_1_17, var_7("class_attr_costproficiency"), "proficency_cost_per_min", 60))

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

	Item = var_8_0

	local var_8_2 = var_8_0.getConfigData(var_8_1).usage_arg

	tonumber = var_3

	return var_3(var_8_2)
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
	PlayerProxy = var_1_10002

	local var_13_0 = var_1_10001(var_1_10002)

	return var_1.getRawData(var_13_0).expField
end

function var_0_1.HasRes(arg_14_0)
	return arg_14_0:GetPlayerRes() >= arg_14_0:GetTarget()
end

function var_0_1.GetGenResCnt(arg_15_0)
	local var_15_0 = arg_15_0
	local var_15_1 = arg_15_0.GetTarget(var_15_0)

	getProxy = var_15_0
	PlayerProxy = var_1_10003

	local var_15_2 = var_15_0(var_1_10003)
	local var_15_3 = var_2.getData(var_15_2)
	local var_15_4 = var_2.getResource

	PlayerConst = var_1_10005

	local var_15_5 = var_15_4(var_15_3, var_1_10005.ResClassField)

	math = var_15_3

	return (var_15_3.floor(var_15_5 / var_15_1))
end

function var_0_1.GetCanGetResCnt(arg_16_0)
	local var_16_0 = arg_16_0:GetGenResCnt()
	local var_16_1 = arg_16_0
	local var_16_2 = arg_16_0.GetResourceType(var_16_1)

	Item = var_16_1

	local var_16_3 = var_16_1.getConfigData(var_16_2).max_num

	getProxy = var_4
	BagProxy = var_1_10005

	local var_16_4 = var_4(var_1_10005)
	local var_16_5 = var_16_3 - var_4.getItemCountById(var_16_4, var_16_2)

	math = var_6

	return (var_6.min(var_16_0, var_16_5))
end

function var_0_1.CanGetRes(arg_17_0)
	if arg_17_0:GetCanGetResCnt() <= 0 then
		return false
	end

	return true
end

return var_0_1
