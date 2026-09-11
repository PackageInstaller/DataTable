local NewGuildBossAssistantHeadItemView = class("NewGuildBossAssistantHeadItemView", (import("game.views.heroTeamInfo.SectionHeroTeamHeadItem")))

function NewGuildBossAssistantHeadItemView:InitProxy()
	NewGuildBossAssistantHeadItemView.super.InitProxy(self)

	self.positionController_ = ControllerUtil.GetController(self.transform_, "position")
end

function NewGuildBossAssistantHeadItemView:InitUI()
	NewGuildBossAssistantHeadItemView.super.InitUI(self)

	self.headItemIsOathController = self.controller_:GetController("isOath")
end

function NewGuildBossAssistantHeadItemView:SetSectionHeroData(arg_3_1)
	self.assistantData_ = arg_3_1
	self.gameObject_.name = tostring(self.assistantData_.assist_hero_id)

	self:SetHeroData(self.assistantData_.assist_hero_id)
	self:SetRedPointEnable(false)
end

function NewGuildBossAssistantHeadItemView:SetHeroId(arg_4_1)
	self:SetHeroData(arg_4_1)
end

function NewGuildBossAssistantHeadItemView:SetHeroData(arg_5_1)
	self.heroId_ = arg_5_1
	self.trialID_ = 0
	self.heroCfg_ = HeroCfg[arg_5_1]

	self:UpdateView()
end

function NewGuildBossAssistantHeadItemView:UpdateView()
	local var_6_0 = HeroCfg[self.heroId_]
	local var_6_1 = self.assistantData_.assist_hero_skin ~= 0 and self.assistantData_.assist_hero_skin or self.heroId_

	self.headItemIsOathController:SetSelectedState(nullable(self.assistantData_, "hero_oath_display", "oath") and "true" or "false")

	self.headIcon_.sprite = HeroTools.GetHeadSprite(var_6_1)

	self.headIcon_:SetNativeSize()

	self.campLogo_.sprite = HeroTools.GetRaceIcon(var_6_0.race)
	self.attackType_.sprite = HeroTools.GetHeroSkillAttributeIcon(self.heroId_)
	self.rareImg_.sprite = HeroTools.GetRareSprite(math.floor(self.assistantData_.hero_rare / 100))

	self:SetLevel(self.assistantData_.hero_level or 1)

	self.nickLabel_.text = GetI18NText(self.assistantData_.nick)
	self.fightPowerLabel_.text = self.assistantData_.fight_capacity

	self.positionController_:SetSelectedState(tostring(self.assistantData_.member_post))

	if tostring(self.assistantData_.member_post) == "1" then
		self.clubMemberLabel_.text = GetTips("CLUB_CHAIR_MAN")
	elseif tostring(self.assistantData_.member_post) == "2" then
		self.clubMemberLabel_.text = GetTips("CLUB_VICE_CHAIR_MAN")
	elseif tostring(self.assistantData_.member_post) == "3" then
		self.clubMemberLabel_.text = GetTips("CLUB_MEMBER")
	elseif tostring(self.assistantData_.member_post) == "4" then
		self.clubMemberLabel_.text = GetTips("CLUB_NOVICIATE")
	end
end

function NewGuildBossAssistantHeadItemView:GetHeroId()
	return self.assistantData_.assist_hero_id
end

function NewGuildBossAssistantHeadItemView:GetOwnerId()
	return self.assistantData_.member_id
end

function NewGuildBossAssistantHeadItemView:SetSelected(arg_9_1)
	SetActive(self.sectionSelectGo_, arg_9_1 == true)
end

return NewGuildBossAssistantHeadItemView
