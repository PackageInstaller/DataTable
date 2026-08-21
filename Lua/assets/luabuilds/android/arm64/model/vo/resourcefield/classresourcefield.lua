local var_0_0 = class("ClassResourceField", import(".BaseResourceField"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	local var_1_0 = arg_1_0:bindConfigTable()

	table.insert(arg_1_0.attrs, ResourceFieldAttr.New(var_1_0, i18n("class_attr_store"), "stock"))
	table.insert(arg_1_0.attrs, ResourceFieldAttr.New(var_1_0, i18n("class_attr_proficiency"), "store"))
	table.insert(arg_1_0.attrs, ResourceFieldPercentAttr.New(var_1_0, i18n("class_attr_getproficiency"), "proficency_get_percent", 1))
	table.insert(arg_1_0.attrs, ResourceFieldProductAttr.New(var_1_0, i18n("class_attr_costproficiency"), "proficency_cost_per_min", 60))

	return
end

function var_0_0.GetKeyWord(arg_2_0)
	return "class"
end

function var_0_0.bindConfigTable(arg_3_0)
	return pg.class_upgrade_template
end

function var_0_0.GetUpgradeType(arg_4_0)
	return 20
end

function var_0_0.GetResourceType(arg_5_0)
	return arg_5_0:getConfig("item_id")
end

function var_0_0.GetMaxProficiency(arg_6_0)
	return arg_6_0:getConfig("store")
end

function var_0_0.GetTranValuePreHour(arg_7_0)
	return arg_7_0:getConfig("proficency_cost_per_min") * 60
end

function var_0_0.GetTarget(arg_8_0)
	return tonumber(Item.getConfigData((arg_8_0:GetResourceType())).usage_arg)
end

function var_0_0.GetExp2ProficiencyRatio(arg_9_0)
	return arg_9_0:getConfig("proficency_get_percent")
end

function var_0_0.GetDesc(arg_10_0)
	return i18n("naval_academy_res_desc_class")
end

function var_0_0.GetName(arg_11_0)
	return i18n("school_title_dajiangtang")
end

function var_0_0.getHourProduct(arg_12_0)
	return 0
end

function var_0_0.GetPlayerRes(arg_13_0)
	return getProxy(PlayerProxy):getRawData().expField
end

function var_0_0.HasRes(arg_14_0)
	return arg_14_0:GetPlayerRes() >= arg_14_0:GetTarget()
end

function var_0_0.GetGenResCnt(arg_15_0)
	return (math.floor(getProxy(PlayerProxy):getData():getResource(PlayerConst.ResClassField) / arg_15_0:GetTarget()))
end

function var_0_0.GetCanGetResCnt(arg_16_0)
	local var_16_0 = arg_16_0:GetResourceType()

	return (math.min(arg_16_0:GetGenResCnt(), Item.getConfigData(var_16_0).max_num - getProxy(BagProxy):getItemCountById(var_16_0)))
end

function var_0_0.CanGetRes(arg_17_0)
	if arg_17_0:GetCanGetResCnt() <= 0 then
		return false
	end

	return true
end

return var_0_0
