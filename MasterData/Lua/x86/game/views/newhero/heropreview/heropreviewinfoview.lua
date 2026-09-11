local HeroPreviewInfoView = class("HeroPreviewInfoView", ReduxView)

function HeroPreviewInfoView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function HeroPreviewInfoView:Init()
	self:InitUI()
	self:AddUIListener()
end

function HeroPreviewInfoView:InitUI()
	self:BindCfgUI()
end

function HeroPreviewInfoView:AddUIListener()
	self:AddBtnListener(self.rewardBtn_, nil, function()
		JumpTools.OpenPageByJump("raceCollectReward", {})
	end)
end

function HeroPreviewInfoView:SetHeroInfo(arg_6_1)
	manager.redPoint:bindUIandKey(self.rewardTrs_, RedPointConst.HERO_RACE_COLLECT_REWARD)

	self.heroInfo_ = arg_6_1
	self.heroCfg_ = HeroCfg[arg_6_1.id]
	self.curHeroId_ = arg_6_1.id

	self:UpdateView()
end

function HeroPreviewInfoView:UpdateView()
	self.nameText_.text = GetI18NText(self.heroCfg_.name)
	self.subNameText_.text = GetI18NText(self.heroCfg_.suffix)
	self.campLogo_.sprite = HeroTools.GetRaceIcon(self.heroCfg_.race)
	self.starImg_.sprite = getSprite("Atlas/Common", "star_" .. self.heroCfg_.rare)
	self.attackType_.sprite = HeroTools.GetHeroSkillAttributeIcon(self.heroCfg_.id)
	self.rangeTypeText_.text = CharactorParamCfg[self.heroInfo_.id].RangeType == 0 and GetTips("RANGETYPE_CLOSE") or GetTips("RANGETYPE_LONG")
	self.infoText_.text = self.heroCfg_.hero_desc

	self:RefreshChargeType()
	SetActive(self.playBtnGo_, ObtainHeroMovieCfg[self.curHeroId_] ~= nil and self.heroInfo_.unlock == 1)
end

function HeroPreviewInfoView:RefreshChargeType()
	self.chargeType_.text = HeroTools.GetChargeTextByType(self.heroCfg_.mechanism_type[1])
end

function HeroPreviewInfoView:OnExit()
	manager.redPoint:unbindUIandKey(self.rewardTrs_, RedPointConst.HERO_RACE_COLLECT_REWARD)
end

return HeroPreviewInfoView
