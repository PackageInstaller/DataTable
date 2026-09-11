local ChallengeRogueTeamSkillInfoView = class("ChallengeRogueTeamSkillInfoView", ReduxView)

function ChallengeRogueTeamSkillInfoView:UIName()
	return "Widget/System/Activity_Roulike/RogueSkillInfoUI"
end

function ChallengeRogueTeamSkillInfoView:UIParent()
	return manager.ui.uiMain.transform
end

function ChallengeRogueTeamSkillInfoView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.stateController_ = self.btnController_:GetController("state")
	self.selectHandler_ = handler(self, self.OnSelectSkill)
end

function ChallengeRogueTeamSkillInfoView:OnEnter()
	self.templateID_ = ChallengeRogueTeamData:GetCacheTemplateID()
	self.skillID_ = self.params_.skillID
	self.handler_ = self.params_.handler

	self:RefreshUI()
	self:RegistEventListener(CHALLENGE_ROGUE_TEAM_UNLOCK_SKILL, function()
		self:RefreshUI()
	end)
	manager.notify:RegistListener(CHALLENGE_ROGUE_TEAM_SELECT_SKILL_ITEM, self.selectHandler_)
end

function ChallengeRogueTeamSkillInfoView:OnSelectSkill(arg_6_1)
	self.skillID_ = arg_6_1

	self:RefreshUI()
end

function ChallengeRogueTeamSkillInfoView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		RogueTeamCfg[self.templateID_].tech_item
	})
	manager.windowBar:SetGameHelpKey("ROGUE_TEAM_SKILLTREE_DESC")
	manager.windowBar:RegistBackCallBack(function()
		JumpTools.Back()
	end)
end

function ChallengeRogueTeamSkillInfoView:OnExit()
	manager.windowBar:HideBar()
end

function ChallengeRogueTeamSkillInfoView:RefreshUI()
	self.nameText_.text = RogueTeamSkillTreeCfg[self.skillID_].name
	self.descText_.text = RogueTeamSkillTreeCfg[self.skillID_].description
	self.icon_.sprite = pureGetSpriteWithoutAtlas(RogueTeamSkillTreeCfg[self.skillID_].icon)
	self.costIcon_.sprite = ItemTools.getItemSprite(RogueTeamCfg[self.templateID_].tech_item)
	self.cost_.text = RogueTeamSkillTreeCfg[self.skillID_].cost

	local var_10_0 = ChallengeRogueTeamData:GetCacheTemplateID()

	self.cost_.color = ItemTools.getItemNum(RogueTeamCfg[self.templateID_].tech_item) < tonumber(RogueTeamSkillTreeCfg[self.skillID_].cost) and Color.red or Color.white

	if ChallengeRogueTeamData:IsHasSkill(var_10_0, self.skillID_) then
		self.stateController_:SetSelectedState("unlock")
	elseif ChallengeRogueTeamData:CanSelectSkill(var_10_0, self.skillID_) then
		self.stateController_:SetSelectedState("canUnlock")
	else
		self.stateController_:SetSelectedState("lock")
	end
end

function ChallengeRogueTeamSkillInfoView:OnExit()
	manager.ui:ResetMainCamera()
	manager.notify:RemoveListener(CHALLENGE_ROGUE_TEAM_SELECT_SKILL_ITEM, self.selectHandler_)
end

function ChallengeRogueTeamSkillInfoView:Dispose()
	self:RemoveAllListeners()
	ChallengeRogueTeamSkillInfoView.super.Dispose(self)
end

function ChallengeRogueTeamSkillInfoView:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if ItemTools.getItemNum(RogueTeamCfg[self.templateID_].tech_item) < tonumber(RogueTeamSkillTreeCfg[self.skillID_].cost) then
			ShowTips("CHALLENGE_ROGUE_TEAM_ERROR_ITEM_NOT_ENOUGH_CURRENCY")

			return
		end

		if ChallengeRogueTeamData:GetSelectDifficultyID(self.templateID_) ~= 0 then
			ShowTips("ERROR_GAME_NOT_END")

			return
		end

		ChallengeRogueTeamAction.UnLockSkill(self.templateID_, self.skillID_)
	end)
end

return ChallengeRogueTeamSkillInfoView
