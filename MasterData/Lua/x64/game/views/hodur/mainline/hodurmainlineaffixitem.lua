local HodurMainlineAffixItem = class("HodurMainlineAffixItem", ReduxView)

function HodurMainlineAffixItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
end

function HodurMainlineAffixItem:InitUI()
	self:BindCfgUI()
end

function HodurMainlineAffixItem:SetData(arg_3_1)
	self.affixID_ = arg_3_1

	self:RefreshUI()
end

function HodurMainlineAffixItem:RefreshUI()
	self.nameText_.text = AffixTypeCfg[self.affixID_].name
	self.descText_.text = DescriptionCfg[AffixTypeCfg[self.affixID_].description[1]].description
end

function HodurMainlineAffixItem:SetActive(arg_5_1)
	SetActive(self.gameObject_, arg_5_1)
end

function HodurMainlineAffixItem:Dispose()
	HodurMainlineAffixItem.super.Dispose(self)
end

return HodurMainlineAffixItem
