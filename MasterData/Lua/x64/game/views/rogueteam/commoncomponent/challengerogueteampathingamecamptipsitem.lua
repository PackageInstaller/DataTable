local ChallengeRogueTeamPathInGameCampTipsItem = class("ChallengeRogueTeamPathInGameCampTipsItem", ReduxView)

function ChallengeRogueTeamPathInGameCampTipsItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListener()
end

function ChallengeRogueTeamPathInGameCampTipsItem:Dispose()
	ChallengeRogueTeamPathInGameCampTipsItem.super.Dispose(self)
end

function ChallengeRogueTeamPathInGameCampTipsItem:AddListener()
	self:AddBtnListener(self.btn_, nil, function()
		local var_4_0, var_4_1 = ChallengeRogueTeamTools:GetAllSuitSkillIDList()

		JumpTools.OpenPageByJump("/challengeRogueTeamBag", {
			leftTabIndex = 2,
			tabIndex = table.indexof(var_4_1, self.campID_),
			campId = self.campID_
		})
	end)
end

function ChallengeRogueTeamPathInGameCampTipsItem:SetData(arg_5_1, arg_5_2)
	self.templateID_ = ChallengeRogueTeamData:GetActiveTemplateID()
	self.campID_ = arg_5_1
	self.count_ = arg_5_2
	self.itemTemp_ = RogueTeamCfg[ChallengeRogueTeamData:GetCacheTemplateID()].item_temp
	self.campSkillID_ = ChallengeRogueTeamData:GetCampUltimateByCamp(self.itemTemp_, self.campID_)

	self:RefreshUI()
end

function ChallengeRogueTeamPathInGameCampTipsItem:RefreshUI()
	self.campImage_.sprite = pureGetSpriteWithoutAtlas(ChallengeRogueTeamTools.GetCampIcon(self.campID_))

	for iter_6_0 = 1, ChallengeRogueTeamConst.SUIT_SKILL_NEED_TREASURE_CNT do
		SetActive(self["item" .. iter_6_0 .. "_"], iter_6_0 <= self.count_)
	end

	self.starSlider_.fillAmount = math.max(self.count_ - 1, 0) / 5
end

return ChallengeRogueTeamPathInGameCampTipsItem
