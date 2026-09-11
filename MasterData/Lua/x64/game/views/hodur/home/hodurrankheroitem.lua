local HodurRankHeroItem = class("HodurRankHeroItem", ReduxView)

function HodurRankHeroItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:initUI()
end

function HodurRankHeroItem:initUI()
	self:BindCfgUI()

	self.typeController_ = self.controller_:GetController("state01")
end

function HodurRankHeroItem:SetData(arg_3_1, arg_3_2)
	if HeroStandardSystemCfg[arg_3_1.id] ~= nil then
		self.heroID_ = HeroStandardSystemCfg[arg_3_1.id].hero_id
		self.portraitImg_.sprite = pureGetSpriteWithoutAtlas(SpritePathCfg.HeroIcon.path .. arg_3_1.skin_id)
	else
		self.heroID_ = arg_3_1.hero_id
		self.portraitImg_.sprite = (not arg_3_1.skin_id or arg_3_1.skin_id == 0) and pureGetSpriteWithoutAtlas(SpritePathCfg.HeroIcon.path .. self.heroID_) or pureGetSpriteWithoutAtlas(SpritePathCfg.HeroIcon.path .. arg_3_1.skin_id)
	end

	self.typeController_:SetSelectedIndex(arg_3_2 and 0 or 1)

	self.nameText_.text = GetI18NText(HeroCfg[self.heroID_].name)
	self.rangeTypeText_.text = CharactorParamCfg[self.heroID_].RangeType == 0 and GetTips("RANGETYPE_CLOSE") or GetTips("RANGETYPE_LONG")
end

return HodurRankHeroItem
