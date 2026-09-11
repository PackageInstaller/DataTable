local HeroSurpassAttrItem = class("HeroSurpassAttrItem", ReduxView)

function HeroSurpassAttrItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
end

function HeroSurpassAttrItem:InitUI()
	self:BindCfgUI()
end

function HeroSurpassAttrItem:RefreshUI(arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	self:SetActive(true)

	self.num01Text_.text = arg_3_2
	self.numText_.text = arg_3_1

	if not arg_3_1 or not arg_3_2 then
		SetActive(self.arrowGo_, false)
	else
		SetActive(self.arrowGo_, true)
	end

	if arg_3_3 then
		local var_3_0 = PublicAttrCfg[arg_3_3]

		self.nameText_.text = arg_3_4 and string.format(GetTips("EQUIP_UPGRADE_ATTR_DES"), GetI18NText(var_3_0.name)) or GetI18NText(var_3_0.name)
		self.iconImg_.sprite = getSprite("Atlas/SystemCommonAtlas", var_3_0.icon)
	end
end

function HeroSurpassAttrItem:SetActive(arg_4_1)
	SetActive(self.gameObject_, arg_4_1)
end

function HeroSurpassAttrItem:Dispose()
	HeroSurpassAttrItem.super.Dispose(self)
end

return HeroSurpassAttrItem
