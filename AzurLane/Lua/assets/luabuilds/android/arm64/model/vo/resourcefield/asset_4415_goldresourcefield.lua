class = var_0_10000

local var_0_0 = "GoldResourceField"

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

	var_1_1(var_1_2, var_1_3(var_1_4, var_1_10009("class_attr_store"), "store"))

	table = var_1_1

	local var_1_5 = var_1_1.insert
	local var_1_6 = arg_1_0.attrs

	ResourceFieldLevelProductAttr = var_6

	local var_1_7 = var_6.New
	local var_1_8 = var_1_0

	i18n = var_9

	var_1_5(var_1_6, var_1_7(var_1_8, var_9("class_label_goldfield"), "production", 1))

	return
end

function var_0_1.GetKeyWord(arg_2_0)
	return "shop"
end

function var_0_1.bindConfigTable(arg_3_0)
	pg = var_1_10001

	return var_1_10001.tradingport_template
end

function var_0_1.GetUpgradeType(arg_4_0)
	return 7
end

function var_0_1.GetResourceType(arg_5_0)
	PlayerConst = var_1_10001

	return var_1_10001.ResGold
end

function var_0_1.getHourProduct(arg_6_0)
	return arg_6_0:getConfig("hour_time") * arg_6_0:getConfig("production")
end

function var_0_1.GetName(arg_7_0)
	i18n = var_1_10001

	return var_1_10001("school_title_xiaomaibu")
end

function var_0_1.GetDesc(arg_8_0)
	i18n = var_1_10001

	return var_1_10001("naval_academy_res_desc_shop")
end

function var_0_1.GetPlayerRes(arg_9_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10003

	local var_9_0 = var_1_10001(var_1_10003)

	return var_1.getRawData(var_9_0).goldField
end

return var_0_1
