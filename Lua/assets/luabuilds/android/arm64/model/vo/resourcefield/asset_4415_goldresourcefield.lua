local GoldResourceField = class("GoldResourceField", import(".BaseResourceField"))

function GoldResourceField:Ctor(arg_1_1)
	GoldResourceField.super.Ctor(self, arg_1_1)

	local var_1_0 = self:bindConfigTable()

	table.insert(self.attrs, ResourceFieldAttr.New(var_1_0, i18n("class_attr_store"), "store"))
	table.insert(self.attrs, ResourceFieldLevelProductAttr.New(var_1_0, i18n("class_label_goldfield"), "production", 1))

	return
end

function GoldResourceField:GetKeyWord()
	return "shop"
end

function GoldResourceField:bindConfigTable()
	return pg.tradingport_template
end

function GoldResourceField:GetUpgradeType()
	return 7
end

function GoldResourceField:GetResourceType()
	return PlayerConst.ResGold
end

function GoldResourceField:getHourProduct()
	return self:getConfig("hour_time") * self:getConfig("production")
end

function GoldResourceField:GetName()
	return i18n("school_title_xiaomaibu")
end

function GoldResourceField:GetDesc()
	return i18n("naval_academy_res_desc_shop")
end

function GoldResourceField:GetPlayerRes()
	return getProxy(PlayerProxy):getRawData().goldField
end

return GoldResourceField
