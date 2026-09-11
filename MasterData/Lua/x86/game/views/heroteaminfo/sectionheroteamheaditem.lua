local SectionHeroTeamHeadItem = class("SectionHeroTeamHeadItem", (import("game.views.newHero.HeroLongHead")))

function SectionHeroTeamHeadItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitProxy()

	self.gameObject_ = self.realGo_
	self.transform_ = self.realGo_.transform

	self:Init()

	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
end

function SectionHeroTeamHeadItem:InitProxy()
	self:BindCfgUI()
	self:InitController()
end

function SectionHeroTeamHeadItem:InitController()
	self.sectionLockTypeController_ = self.sectionController_:GetController("sectionLockType")
	self.sectionTeamMarkBgStyleController_ = self.sectionController_:GetController("sectionTeamMarkBgStyle")
	self.sectionEnergyController_ = self.sectionController_:GetController("sectionEnergy")
	self.sectionLockingController_ = self.sectionController_:GetController("sectionLocking")
	self.sectionHPController_ = self.sectionController_:GetController("sectionHP")
	self.sectionMultiPosController_ = self.sectionController_:GetController("sectionMultiPos")
end

function SectionHeroTeamHeadItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function SectionHeroTeamHeadItem:SetStageID(arg_5_1)
	self.stageID_ = arg_5_1
end

function SectionHeroTeamHeadItem:SetSectionHeroData(arg_6_1)
	self.sectionHeroData_ = arg_6_1
	self.isBattlePanel_ = true
	self.gameObject_.name = tostring(self.sectionHeroData_.id)

	self:SetProxy(self.sectionHeroData_.heroViewProxy)
	self:SetHeroId(self.sectionHeroData_.id, self.sectionHeroData_.type, self.sectionHeroData_.heroViewProxy.tempHeroList)
	self:SetRedPointEnable(false)
	self:RefreshSectionUI()
end

function SectionHeroTeamHeadItem:RefreshSectionUI()
	if self.sectionHeroData_.type == HeroConst.HERO_DATA_TYPE.DEFAULT then
		self:SetTrial(false)
	elseif self.sectionHeroData_.type == HeroConst.HERO_DATA_TYPE.TRIAL then
		self:SetTrial(true)
	elseif self.sectionHeroData_.type == HeroConst.HERO_DATA_TYPE.CUSTOM then
		self:SetTrial(true)
	elseif self.sectionHeroData_.type == HeroConst.HERO_DATA_TYPE.ADVANCETEST then
		self:SetTrial(false)
	end
end

function SectionHeroTeamHeadItem:SetEnergy(arg_8_1, arg_8_2)
	self.sectionEnergyController_:SetSelectedState(arg_8_1 and "on" or "off")

	self.sectionEnergyLabel_.text = arg_8_2
end

function SectionHeroTeamHeadItem:SetTeamMarkBg(arg_9_1)
	self.sectionTeamMarkBgStyleController_:SetSelectedState(arg_9_1)
end

function SectionHeroTeamHeadItem:SetTeamMark(arg_10_1, arg_10_2)
	SetActive(self.sectionTeamMarkGo_, arg_10_1)

	if arg_10_1 then
		self.sectionTeamMarkText_.text = GetI18NText(arg_10_2)

		LayoutRebuilder.ForceRebuildLayoutImmediate(self.sectionTeamMarkTransform_)
	end
end

function SectionHeroTeamHeadItem:SetInTeamFlag(arg_11_1, arg_11_2)
	SetActive(self.sectionTeamMarkGo_, arg_11_1)

	if arg_11_1 then
		self.sectionTeamMarkText_.text = arg_11_2 and GetTips("IS_CAPTAIN") or GetTips("IN_TEAM")
	end
end

function SectionHeroTeamHeadItem:SetInShowFlag(arg_12_1)
	SetActive(self.sectionTeamMarkGo_, arg_12_1)

	self.sectionTeamMarkText_.text = GetTips("DISPLAY")
end

function SectionHeroTeamHeadItem:SetHeroLock(arg_13_1)
	self:SetLocking(arg_13_1)
end

function SectionHeroTeamHeadItem:SetHeroLockType(arg_14_1)
	self.sectionLockTypeController_:SetSelectedState(arg_14_1)
end

function SectionHeroTeamHeadItem:SetHeroLockText(arg_15_1)
	self.sectionLockLabelText_.text = GetI18NText(arg_15_1)
end

function SectionHeroTeamHeadItem:SetChallengeFlag(arg_16_1)
	SetActive(self.sectionBossChallengeGo_, arg_16_1)
end

function SectionHeroTeamHeadItem:SetHp(arg_17_1)
	self.sectionHPController_:SetSelectedState(arg_17_1 and "on" or "off")
end

function SectionHeroTeamHeadItem:RefreshHpValue(arg_18_1)
	self.sectionHPImg_.fillAmount = arg_18_1 / 100
	self.sectionHPText_.text = arg_18_1 .. "%"
end

function SectionHeroTeamHeadItem:SetLocking(arg_19_1)
	self.sectionLockingController_:SetSelectedState(arg_19_1 and "on" or "off")
end

function SectionHeroTeamHeadItem:SetTrial(arg_20_1)
	self.trialController_:SetSelectedState(tostring(arg_20_1))
end

function SectionHeroTeamHeadItem:SetSoloChallengeIndex(arg_21_1)
	if arg_21_1 ~= -1 then
		SetActive(self.sectionTeamMarkGo_, false)
		SetActive(self.sectionTeamOrderGo_, true)

		self.sectionTeamOrderText_.text = GetTips(string.format("TEAM_%d", arg_21_1))
	else
		SetActive(self.teamOrder_, false)
	end
end

function SectionHeroTeamHeadItem:SetChallengeRogueTeamModify()
	self.levelText_.text = (self.heroInfo_.modifyLevel or self.heroInfo_.tempID) and "<color=#3596ED>" .. self.heroInfo_.level .. "</color>" or self.heroInfo_.level

	if self.heroInfo_.modifyStar or self.heroInfo_.tempID then
		SetActive(self.starBgGo_, true)
	else
		SetActive(self.starBgGo_, false)
	end
end

function SectionHeroTeamHeadItem:SetMultiPos(arg_23_1, arg_23_2, arg_23_3)
	self.sectionMultiPosController_:SetSelectedState(arg_23_1 and "on" or "off")

	if arg_23_1 then
		self.sectionMultiPosText_.text = arg_23_3
	end
end

return SectionHeroTeamHeadItem
