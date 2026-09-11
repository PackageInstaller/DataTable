local ChallengeRogueTeamSectionHeroInfoView = class("ChallengeRogueTeamSectionHeroInfoView", (import("game.views.newHero.HeroInfoView")))

function ChallengeRogueTeamSectionHeroInfoView:Init()
	self:InitUI()
	self:AddUIListener()

	self.skillItemList_ = {}

	for iter_1_0 = 1, 5 do
		self.skillItemList_[iter_1_0] = ChallengeRogueTeamHeroSkillItem.New(self, self["skillItemGo" .. iter_1_0 .. "_"])
	end
end

function ChallengeRogueTeamSectionHeroInfoView:UpdateUnlockedView()
	ChallengeRogueTeamSectionHeroInfoView.super.UpdateUnlockedView(self)

	local var_2_0 = self.heroViewProxy_:GetHeroSkillInfo(self.heroInfo_.id)

	for iter_2_0 = 1, 5 do
		self.skillItemList_[iter_2_0]:RefreshData(self, var_2_0[iter_2_0], self.heroViewProxy_, iter_2_0)
	end

	self.proficiencyText_.text = HeroTools.GetHeroProficiency(self.heroInfo_.id) .. "/" .. GameSetting.mastery_level_max.value[1]
	self.nowLevelText_.text = (self.heroInfo_.modifyLevel or self.heroInfo_.tempID) and "<color=#3596ED>" .. self.heroInfo_.level .. "</color>" or self.heroInfo_.level

	if self.heroInfo_.modifyStar or self.heroInfo_.tempID then
		SetActive(self.starBgGo_, true)
	else
		SetActive(self.starBgGo_, false)
	end

	if self.heroInfo_.modifyServant or self.heroInfo_.tempID then
		SetActive(self.weaponBgGo_, true)
	else
		SetActive(self.weaponBgGo_, false)
	end
end

function ChallengeRogueTeamSectionHeroInfoView:UpdateModuleView()
	SetActive(self.moduleView_.gameObject, false)

	local var_3_0 = self.heroInfo_.servantInfo

	self.weaponName_.text = HeroCfg[self.heroInfo_.id].weapon_name
	self.weaponLevel_.text = (self.heroInfo_.modifyWeapon or self.heroInfo_.tempID) and GetTips("LEVEL") .. "<color=#3596ED>" .. self.heroInfo_.weapon_info.level .. "</color>" or GetTips("LEVEL") .. self.heroInfo_.weapon_info.level

	if var_3_0.id == 0 then
		print("不应该出现 钥从ID为0")
	else
		self.servantName_.text = ItemTools.getItemName(var_3_0.id)
	end

	self.servantStage_.text = string.format(GetTips("ROGUE_TEAM_SERVANT_LEVEL"), var_3_0.stage)
	self.servantIcon_.sprite = ItemTools.getItemSprite(var_3_0.id, nil, true)
end

function ChallengeRogueTeamSectionHeroInfoView:UpdateView()
	ChallengeRogueTeamSectionHeroInfoView.super.UpdateView(self)
	self.isSelfController_:SetSelectedState(tostring(self.heroInfo_.tempID == nil))
end

function ChallengeRogueTeamSectionHeroInfoView:UpdateUnlockBtnState()
	self.levelStateController_:SetSelectedState("maxLevel")
end

function ChallengeRogueTeamSectionHeroInfoView:Dispose()
	ChallengeRogueTeamSectionHeroInfoView.super.Dispose(self)

	if self.skillItemList_ then
		for iter_6_0, iter_6_1 in ipairs(self.skillItemList_) do
			iter_6_1:Dispose()
		end

		self.skillItemList_ = nil
	end
end

return ChallengeRogueTeamSectionHeroInfoView
