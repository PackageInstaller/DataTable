local AttributeItem = class("AttributeItem", ReduxView)
local var_0_1 = {
	HeroConst.HERO_ATTRIBUTE.ATK,
	HeroConst.HERO_ATTRIBUTE.ARM,
	HeroConst.HERO_ATTRIBUTE.STA,
	HeroConst.HERO_ATTRIBUTE.CRITICAL
}

function AttributeItem:OnCtor(arg_1_1, arg_1_2)
	self.data_ = arg_1_1
	self.gameObject_ = arg_1_2
	self.transform_ = arg_1_2.transform

	self:InitUI()
end

function AttributeItem:RefreshData(arg_2_1, arg_2_2, arg_2_3)
	self.data_ = arg_2_1
	self.info_ = arg_2_2
	self.isSingleEquip_ = arg_2_3

	self:Render()
end

function AttributeItem:InitUI()
	self:BindCfgUI()
end

function AttributeItem:Render()
	self:RefreshUI(self.info_)
end

function AttributeItem:RefreshUI(arg_5_1)
	local var_5_0 = {}
	local var_5_1 = 0

	if self.isSingleEquip_ then
		var_5_0 = PublicAttrCfg[arg_5_1.key]
		var_5_1 = math.floor(arg_5_1.value)
	else
		var_5_0 = PublicAttrCfg[var_0_1[arg_5_1.index]]
		var_5_1 = arg_5_1.attrS[var_0_1[arg_5_1.index]] and math.floor(arg_5_1.attrS[var_0_1[arg_5_1.index]]) or 0
	end

	if var_5_0.percent and var_5_0.percent == 1 then
		var_5_1 = var_5_1 / 10 .. "%"
	end

	self.addText_.text = var_5_1
	self.numNoAdd_ = var_5_1
	self.valStr_ = var_5_1
	self.name_.text = GetI18NText(var_5_0.name)
	self.icon_.sprite = getSprite("Atlas/SystemCommonAtlas", var_5_0.icon)
end

function AttributeItem:ShowAdd(arg_6_1)
	if self.isSingleEquip_ then
		self:GetAddValueStr()

		self.addText_.text = arg_6_1 and self.numAdd_ or self.numNoAdd_
	end
end

function AttributeItem:GetAddValueStr()
	if self.info_.race == self.info_.heroId then
		local var_7_0 = math.floor(self.info_.value * (GameSetting.equip_hero_strengthen_num.value[1] - 1) + FLOAT_DELTA)

		self.numAdd_ = string.format("%s<color=#e78300>+%s</color>", self.valStr_, (PublicAttrCfg[self.info_.key].percent and PublicAttrCfg[self.info_.key].percent == 1 or nil) and math.floor(self.info_.value * (GameSetting.equip_hero_strengthen_num.value[1] - 1) / 10 + FLOAT_DELTA) .. "%")
	elseif self.info_.race and self.info_.race ~= 0 then
		local var_7_1 = math.floor(self.info_.value * 0.2 + FLOAT_DELTA)

		self.numAdd_ = string.format("%s<color=#e78300>+%s</color>", self.valStr_, (PublicAttrCfg[self.info_.key].percent and PublicAttrCfg[self.info_.key].percent == 1 or nil) and math.floor(self.info_.value / 10 * 0.2 + FLOAT_DELTA) .. "%")
	else
		self.numAdd_ = self.valStr_
	end
end

function AttributeItem:Show(arg_8_1)
	SetActive(self.gameObject_, arg_8_1)
end

function AttributeItem:Dispose()
	self:RemoveAllListeners()
	AttributeItem.super.Dispose(self)
end

return AttributeItem
