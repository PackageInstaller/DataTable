local OilResourceField = class("OilResourceField", import(".BaseResourceField"))

function OilResourceField:Ctor(arg_1_1)
	OilResourceField.super.Ctor(self, arg_1_1)

	local var_1_0 = self:bindConfigTable()

	table.insert(self.attrs, ResourceFieldAttr.New(var_1_0, i18n("class_attr_store"), "store"))
	table.insert(self.attrs, ResourceFieldLevelProductAttr.New(var_1_0, i18n("class_label_oilfield"), "production", 1))

	return
end

function OilResourceField:GetKeyWord()
	return "canteen"
end

function OilResourceField:bindConfigTable()
	return pg.oilfield_template
end

function OilResourceField:GetUpgradeType()
	return 8
end

function OilResourceField:GetResourceType()
	return PlayerConst.ResOil
end

function OilResourceField:getHourProduct()
	return self:getConfig("hour_time") * self:getConfig("production")
end

function OilResourceField:GetName()
	return i18n("school_title_shitang")
end

function OilResourceField:GetDesc()
	return i18n("naval_academy_res_desc_cateen")
end

function OilResourceField:GetPlayerRes()
	return getProxy(PlayerProxy):getRawData().oilField
end

return OilResourceField
