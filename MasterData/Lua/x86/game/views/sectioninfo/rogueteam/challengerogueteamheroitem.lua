local HeroLongHead = import("game.views.newHero.HeroLongHead")
local ChallengeRogueTeamHeroItem = class("ChallengeRogueTeamHeroItem", ReduxView)

function ChallengeRogueTeamHeroItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitProxy()
	self:Init()
end

function ChallengeRogueTeamHeroItem:InitProxy()
	self:BindCfgUI()
end

function ChallengeRogueTeamHeroItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function ChallengeRogueTeamHeroItem:InitUI()
	self.selectedController_ = self.controller_:GetController("select")
	self.recruitController_ = self.controller_:GetController("recruit")
	self.trialController_ = self.controller_:GetController("trial")
end

function ChallengeRogueTeamHeroItem:SetSectionHeroData(arg_5_1, arg_5_2)
	self.index_ = arg_5_1
	self.sectionHeroData_ = arg_5_2
	self.gameObject_.name = tostring(self.sectionHeroData_.id)

	self:SetProxy(self.sectionHeroData_.heroViewProxy)
	self:SetHeroId(self.sectionHeroData_.id, self.sectionHeroData_.type, self.sectionHeroData_.heroViewProxy.tempHeroList)
	self:RefreshSectionUI()
end

function ChallengeRogueTeamHeroItem:SetProxy(arg_6_1)
	self.heroViewProxy_ = arg_6_1 or HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.CHALLENGEROUGETEAM)
end

function ChallengeRogueTeamHeroItem:SetHeroId(arg_7_1, arg_7_2, arg_7_3)
	self.heroDataType = arg_7_2

	if arg_7_2 == HeroConst.HERO_DATA_TYPE.TRIAL or heroDataType == HeroConst.HERO_DATA_TYPE.CUSTOM then
		arg_7_1 = TempHeroData:GetHeroData(arg_7_1, arg_7_3).tempID
	end

	self:SetHeroData(arg_7_1, arg_7_2)
end

function ChallengeRogueTeamHeroItem:SetHeroData(arg_8_1, arg_8_2)
	if arg_8_2 == HeroConst.HERO_DATA_TYPE.TRIAL or arg_8_2 == HeroConst.HERO_DATA_TYPE.CUSTOM then
		self.trialID_ = arg_8_1
		self.heroId_ = HeroStandardSystemCfg[arg_8_1].hero_id
		arg_8_1 = self.heroId_
	else
		self.heroId_ = arg_8_1
		self.trialID_ = 0
	end

	self.heroDataType_ = arg_8_2
	self.heroCfg_ = HeroCfg[arg_8_1]
	self.heroInfo_ = self.heroViewProxy_:GetHeroData(arg_8_1)

	self:UpdateView()
end

function ChallengeRogueTeamHeroItem:UpdateView()
	self.heroImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/Icon/" .. self.heroViewProxy_:GetHeroBattleUsingSkinInfo(self.heroId_).id)

	self.heroImg_:SetNativeSize()

	self.campLogo_.sprite = HeroTools.GetRaceIcon(HeroCfg[self.heroId_].race)
	self.attackType_.sprite = HeroTools.GetHeroSkillAttributeIcon(self.heroId_)

	if self.heroInfo_.modifyLevel or self.heroInfo_.tempID then
		self.level_.text = "<color=#3596ED>" .. self.heroInfo_.level .. "</color>"
	elseif not self.heroInfo_.level then
		self.level_.text = 1
	end

	if self.heroInfo_.modifyStar or self.heroInfo_.tempID then
		SetActive(self.starBgGo_, true)
	else
		SetActive(self.starBgGo_, false)
	end

	self:SetRareIcon()
end

function ChallengeRogueTeamHeroItem:SetRareIcon(arg_10_1)
	self.rareImg_.sprite = arg_10_1 and HeroTools.GetRareSprite(arg_10_1) or HeroTools.GetRareSprite(math.floor(self.heroInfo_.star / 100))
end

function ChallengeRogueTeamHeroItem:RefreshSectionUI()
	if self.sectionHeroData_.type == HeroConst.HERO_DATA_TYPE.DEFAULT then
		self:SetTrial(false)
	elseif self.sectionHeroData_.type == HeroConst.HERO_DATA_TYPE.TRIAL then
		self:SetTrial(true)
	elseif self.sectionHeroData_.type == HeroConst.HERO_DATA_TYPE.CUSTOM then
		self:SetTrial(true)
	elseif self.sectionHeroData_.type == HeroConst.HERO_DATA_TYPE.ADVANCETEST then
		self:SetTrial(false)
	elseif self.sectionHeroData_.type == HeroConst.HERO_DATA_TYPE.CHALLENGEROUGETEAM then
		self:SetTrial(false)
	end
end

function ChallengeRogueTeamHeroItem:SetTrial(arg_12_1)
	self.trialController_:SetSelectedState(tostring(arg_12_1))
end

function ChallengeRogueTeamHeroItem:SetSelected(arg_13_1)
	self.selectedController_:SetSelectedState(tostring(arg_13_1))
end

function ChallengeRogueTeamHeroItem:SetRecruited(arg_14_1)
	self.recruitController_:SetSelectedState(tostring(arg_14_1 and true))

	self.recruitNum_.text = arg_14_1 or 0
end

function ChallengeRogueTeamHeroItem:RegisterClickListener(arg_15_1)
	self.clickListener_ = arg_15_1
end

function ChallengeRogueTeamHeroItem:RegisterLookListener(arg_16_1)
	self.lookListner_ = arg_16_1
end

function ChallengeRogueTeamHeroItem:AddUIListener()
	self:AddBtnListener(self.selfBtn_, nil, function()
		if self.clickListener_ ~= nil and self.heroCfg_ then
			self.clickListener_(self.index_)
		end
	end)
	self:AddBtnListener(self.lookBtn_, nil, function()
		if self.lookListner_ ~= nil and self.heroCfg_ then
			self.lookListner_(self.heroInfo_, self.heroViewProxy_:GetViewDataType())
		end
	end)
end

return ChallengeRogueTeamHeroItem
