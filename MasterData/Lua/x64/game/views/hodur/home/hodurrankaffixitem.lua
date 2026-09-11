local HodurRankAffixItem = class("HodurRankAffixItem", ReduxView)

function HodurRankAffixItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:initUI()
end

function HodurRankAffixItem:initUI()
	self:BindCfgUI()
end

function HodurRankAffixItem:SetData(arg_3_1)
	self.icon.sprite = getSpriteWithoutAtlas("TextureConfig/Activity_Hodur/Debufficon/" .. arg_3_1)
	self.nameText.text = AffixTypeCfg[arg_3_1].name
end

return HodurRankAffixItem
