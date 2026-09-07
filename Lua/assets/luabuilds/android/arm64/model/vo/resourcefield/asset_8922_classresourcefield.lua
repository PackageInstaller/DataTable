local ClassResourceField = class("ClassResourceField", import(".BaseResourceField"))

function ClassResourceField:Ctor(arg_1_1)
	ClassResourceField.super.Ctor(self, arg_1_1)

	local var_1_0 = self:bindConfigTable()

	table.insert(self.attrs, ResourceFieldAttr.New(var_1_0, i18n("class_attr_store"), "stock"))
	table.insert(self.attrs, ResourceFieldAttr.New(var_1_0, i18n("class_attr_proficiency"), "store"))
	table.insert(self.attrs, ResourceFieldPercentAttr.New(var_1_0, i18n("class_attr_getproficiency"), "proficency_get_percent", 1))
	table.insert(self.attrs, ResourceFieldProductAttr.New(var_1_0, i18n("class_attr_costproficiency"), "proficency_cost_per_min", 60))

	return
end

function ClassResourceField:GetKeyWord()
	return "class"
end

function ClassResourceField:bindConfigTable()
	return pg.class_upgrade_template
end

function ClassResourceField:GetUpgradeType()
	return 20
end

function ClassResourceField:GetResourceType()
	return self:getConfig("item_id")
end

function ClassResourceField:GetMaxProficiency()
	return self:getConfig("store")
end

function ClassResourceField:GetTranValuePreHour()
	return self:getConfig("proficency_cost_per_min") * 60
end

function ClassResourceField:GetTarget()
	return tonumber(Item.getConfigData((self:GetResourceType())).usage_arg)
end

function ClassResourceField:GetExp2ProficiencyRatio()
	return self:getConfig("proficency_get_percent")
end

function ClassResourceField:GetDesc()
	return i18n("naval_academy_res_desc_class")
end

function ClassResourceField:GetName()
	return i18n("school_title_dajiangtang")
end

function ClassResourceField:getHourProduct()
	return 0
end

function ClassResourceField:GetPlayerRes()
	return getProxy(PlayerProxy):getRawData().expField
end

function ClassResourceField:HasRes()
	return self:GetPlayerRes() >= self:GetTarget()
end

function ClassResourceField:GetGenResCnt()
	return (math.floor(getProxy(PlayerProxy):getData():getResource(PlayerConst.ResClassField) / self:GetTarget()))
end

function ClassResourceField:GetCanGetResCnt()
	local var_16_0 = self:GetResourceType()

	return (math.min(self:GetGenResCnt(), Item.getConfigData(var_16_0).max_num - getProxy(BagProxy):getItemCountById(var_16_0)))
end

function ClassResourceField:CanGetRes()
	if self:GetCanGetResCnt() <= 0 then
		return false
	end

	return true
end

return ClassResourceField
