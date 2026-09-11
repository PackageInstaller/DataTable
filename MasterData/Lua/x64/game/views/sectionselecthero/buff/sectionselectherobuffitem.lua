local SectionSelectHeroBuffItem = class("SectionSelectHeroBuffItem", ReduxView)

function SectionSelectHeroBuffItem:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
end

function SectionSelectHeroBuffItem:Dispose()
	SectionSelectHeroBuffItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.transform_ = nil
	self.gameObject_ = nil
end

function SectionSelectHeroBuffItem:SetData(arg_3_1)
	self.icon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/MaedukAffix/" .. PublicBuffCfg[AffixTypeCfg[SequentialBattleBuffCfg[arg_3_1].affix_id].affix_buff_id].icon)

	self:Show(true)
end

function SectionSelectHeroBuffItem:Show(arg_4_1)
	SetActive(self.gameObject_, arg_4_1)
end

return SectionSelectHeroBuffItem
