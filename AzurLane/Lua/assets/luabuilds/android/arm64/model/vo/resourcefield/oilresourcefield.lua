local var_0_0 = class("OilResourceField", import(".BaseResourceField"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	local var_1_0 = arg_1_0:bindConfigTable()

	table.insert(arg_1_0.attrs, ResourceFieldAttr.New(var_1_0, i18n("class_attr_store"), "store"))
	table.insert(arg_1_0.attrs, ResourceFieldLevelProductAttr.New(var_1_0, i18n("class_label_oilfield"), "production", 1))

	return
end

function var_0_0.GetKeyWord(arg_2_0)
	return "canteen"
end

function var_0_0.bindConfigTable(arg_3_0)
	return pg.oilfield_template
end

function var_0_0.GetUpgradeType(arg_4_0)
	return 8
end

function var_0_0.GetResourceType(arg_5_0)
	return PlayerConst.ResOil
end

function var_0_0.getHourProduct(arg_6_0)
	return arg_6_0:getConfig("hour_time") * arg_6_0:getConfig("production")
end

function var_0_0.GetName(arg_7_0)
	return i18n("school_title_shitang")
end

function var_0_0.GetDesc(arg_8_0)
	return i18n("naval_academy_res_desc_cateen")
end

function var_0_0.GetPlayerRes(arg_9_0)
	return getProxy(PlayerProxy):getRawData().oilField
end

return var_0_0
