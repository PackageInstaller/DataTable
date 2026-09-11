local ChallengeRogueTeamSkillTreeEffectPopView = class("ChallengeRogueTeamSkillTreeEffectPopView", ReduxView)

function ChallengeRogueTeamSkillTreeEffectPopView:UIName()
	return "Widget/System/Activity_Roulike/RogueSkillTreeEffectPopUI"
end

function ChallengeRogueTeamSkillTreeEffectPopView:UIParent()
	return manager.ui.uiPop.transform
end

function ChallengeRogueTeamSkillTreeEffectPopView:Init()
	self:InitUI()
	self:AddListeners()

	self.normalSkillItem_ = {}
	self.specialSkillItem_ = {}
	self.emptyController = self.controller_:GetController("empty")
	self.specialEmptyController_ = self.controller_:GetController("titleItem")
end

function ChallengeRogueTeamSkillTreeEffectPopView:OnEnter()
	self.templateID_ = self.params_.templateID

	self:RefreshUI()
end

function ChallengeRogueTeamSkillTreeEffectPopView:RefreshUI()
	self.unlockSpecialSkill_ = ChallengeRogueTeamData:GetUnlockSpecialSkill(self.templateID_)
	self.unlockNormalSkill_ = ChallengeRogueTeamData:GetUnlockNormalSkill(self.templateID_)
	self.unlockNomalSkillTemplate_ = {}

	for iter_5_0, iter_5_1 in ipairs(self.normalSkillItem_) do
		iter_5_1.value_ = 0

		SetActive(iter_5_1.gameObject, false)
	end

	for iter_5_2, iter_5_3 in ipairs(self.specialSkillItem_) do
		SetActive(iter_5_3.gameObject, false)
	end

	for iter_5_4, iter_5_5 in ipairs(self.unlockNormalSkill_) do
		local var_5_0 = table.indexof(self.unlockNomalSkillTemplate_, RogueTeamSkillTreeCfg[iter_5_5].show_temp)

		if not var_5_0 then
			table.insert(self.unlockNomalSkillTemplate_, RogueTeamSkillTreeCfg[iter_5_5].show_temp)

			var_5_0 = table.indexof(self.unlockNomalSkillTemplate_, RogueTeamSkillTreeCfg[iter_5_5].show_temp)
		end

		if not self.normalSkillItem_[#self.unlockNomalSkillTemplate_] then
			self.normalSkillItem_[#self.unlockNomalSkillTemplate_] = ChallengeRogueTeamNormalSkillEffectItem.New(self.effectItemGo_, self.effectContent_)

			self.normalSkillItem_[#self.unlockNomalSkillTemplate_]:SetData(RogueTeamSkillTreeCfg[iter_5_5].show_temp)
		end

		self.normalSkillItem_[var_5_0]:UpdateValue(RogueTeamSkillTreeCfg[iter_5_5].show_value[2])
	end

	for iter_5_6, iter_5_7 in ipairs(self.unlockSpecialSkill_) do
		self.specialSkillItem_[iter_5_6] = self.specialSkillItem_[iter_5_6] or ChallengeRogueTeamSpeacilSkillEffectItem.New(self.specialEffectItemGo_, self.specialEffectContent_)

		self.specialSkillItem_[iter_5_6]:SetData(iter_5_7)
	end

	self.emptyController:SetSelectedState(tostring(#self.unlockNormalSkill_ + #self.unlockSpecialSkill_ == 0))
	self.specialEmptyController_:SetSelectedState(tostring(#self.unlockSpecialSkill_ ~= 0))
end

function ChallengeRogueTeamSkillTreeEffectPopView:OnExit()
	manager.windowBar:HideBar()
end

function ChallengeRogueTeamSkillTreeEffectPopView:Dispose()
	self:RemoveAllListeners()

	for iter_7_0, iter_7_1 in ipairs(self.normalSkillItem_) do
		iter_7_1:Dispose()
	end

	self.normalSkillItem_ = nil

	for iter_7_2, iter_7_3 in ipairs(self.specialSkillItem_) do
		iter_7_3:Dispose()
	end

	self.normalSkillItem_ = nil

	ChallengeRogueTeamSkillTreeEffectPopView.super.Dispose(self)
end

function ChallengeRogueTeamSkillTreeEffectPopView:InitUI()
	self:BindCfgUI()
end

function ChallengeRogueTeamSkillTreeEffectPopView:AddListeners()
	self:AddBtnListener(self.backBtn_, nil, function()
		self:Back()
	end)
end

function ChallengeRogueTeamSkillTreeEffectPopView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ROGUE_TEAM_SKILLTREE_DESC")
	manager.windowBar:RegistBackCallBack(function()
		JumpTools.Back()
	end)
end

return ChallengeRogueTeamSkillTreeEffectPopView
