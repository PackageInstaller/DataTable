local ChallengeRogueTeamSkillTreeView = class("ChallengeRogueTeamSkillTreeView", ReduxView)

function ChallengeRogueTeamSkillTreeView:UIName()
	return "Widget/System/Activity_Roulike/RogueSkillTreeUI"
end

function ChallengeRogueTeamSkillTreeView:UIParent()
	return manager.ui.uiMain.transform
end

function ChallengeRogueTeamSkillTreeView:Init()
	self.lineList_ = {}
	self.skillItem_ = {}
	self.lineType_ = nil

	self:InitUI()

	self.scrollMoveView_ = ScrollMoveView.New(self, self.scrollViewGo_)

	self:AddListeners()
end

function ChallengeRogueTeamSkillTreeView:OnEnter()
	self.templateID_ = ChallengeRogueTeamData:GetCacheTemplateID()
	self.skillTemplateID_ = RogueTeamCfg[self.templateID_].tree_temp
	self.skillList_ = RogueTeamSkillTreeCfg.get_id_list_by_template_id[self.skillTemplateID_]

	self:RefreshBar()
	self:ResetSelectItem()
	self:RegistEventListener(CHALLENGE_ROGUE_TEAM_UNLOCK_SKILL, function()
		self.skillList_ = RogueTeamSkillTreeCfg.get_id_list_by_template_id[self.skillTemplateID_]

		self:RefreshUI()
	end)
	self:RefreshUI()
end

function ChallengeRogueTeamSkillTreeView:IsOpenSectionInfo()
	return false
end

function ChallengeRogueTeamSkillTreeView:RefreshBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		RogueTeamCfg[self.templateID_].tech_item
	})
	manager.windowBar:SetGameHelpKey("ROGUE_TEAM_SKILLTREE_DESC")
	manager.windowBar:SetBarCanClick(RogueTeamCfg[self.templateID_].tech_item, true)
	manager.windowBar:RegistBackCallBack(function()
		JumpTools.Back()
	end)
end

function ChallengeRogueTeamSkillTreeView:OnTop()
	self:RefreshBar()
end

function ChallengeRogueTeamSkillTreeView:RefreshUI()
	self:RefreshSkillList()
	self.scrollMoveView_:RefreshUI(self:GetScrollPos(), (self:GetScrollWidth()))

	self.effectNumText_.text = #ChallengeRogueTeamData:GetUnlockSpecialSkill(self.templateID_) + #ChallengeRogueTeamData:GetUnlockNormalSkill(self.templateID_) .. "/" .. #self.skillList_

	self:RefreshSelectItem()
end

function ChallengeRogueTeamSkillTreeView:GetScrollWidth()
	local var_11_0 = 0

	for iter_11_0, iter_11_1 in ipairs(self.skillList_) do
		if var_11_0 < RogueTeamSkillTreeCfg[iter_11_1].level then
			var_11_0 = RogueTeamSkillTreeCfg[iter_11_1].level
		end
	end

	return (var_11_0 + 1) * 400
end

function ChallengeRogueTeamSkillTreeView:GetScrollPos()
	return (RogueTeamSkillTreeCfg[self.selectSkill_] or nil) and (RogueTeamSkillTreeCfg[self.selectSkill_].level * 400 or 0)
end

function ChallengeRogueTeamSkillTreeView:OnExit()
	manager.windowBar:HideBar()
	manager.ui:ResetMainCamera()
end

function ChallengeRogueTeamSkillTreeView:Dispose()
	self:RemoveAllListeners()

	self.lineType_ = nil

	for iter_14_0, iter_14_1 in ipairs(self.skillItem_) do
		iter_14_1:Dispose()
	end

	self.skillItem_ = nil

	self:DestroyLine()

	self.lineList_ = nil
	self.scrollView_ = nil
	self.scrollViewGo_ = nil
	self.sectionItem_ = nil
	self.lineGo_ = nil

	ChallengeRogueTeamSkillTreeView.super.Dispose(self)
end

function ChallengeRogueTeamSkillTreeView:InitUI()
	self:BindCfgUI()
	self:AddListeners()
end

function ChallengeRogueTeamSkillTreeView:AddListeners()
	self:AddBtnListener(self.effectBtn_, nil, function()
		JumpTools.OpenPageByJump("challengeRogueTeamSkillTreeEffectPop", {
			templateID = self.templateID_
		})
	end)
	self:AddBtnListener(self.bgBtn_, nil, function()
		if gameContext:IsOpenRoute("challengeRogueTeamSkillInfo") then
			self:ResetSelectItem()
			JumpTools.Back()
		end
	end)
	self.scorllEvent_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerClick, LuaHelper.EventTriggerAction1(function(arg_19_0, arg_19_1)
		if arg_19_1.dragging then
			return
		end

		if gameContext:IsOpenRoute("challengeRogueTeamSkillInfo") then
			self:ResetSelectItem()
			JumpTools.Back()
		end

		arg_19_1:Use()
	end))
end

function ChallengeRogueTeamSkillTreeView:RefreshSelectItem()
	for iter_20_0, iter_20_1 in pairs(self.skillItem_) do
		iter_20_1:SelectorItem(self.selectSkill_)
	end
end

function ChallengeRogueTeamSkillTreeView:ResetSelectItem()
	self.selectSkill_ = 0

	self:RefreshSelectItem()
end

function ChallengeRogueTeamSkillTreeView:RefreshSkillList()
	for iter_22_0 = 1, #self.skillList_ do
		self.skillItem_[iter_22_0] = self.skillItem_[iter_22_0] or ChallengeRogueTeamSkillItem.New(self.nodeItem_, self.nodeParent_)

		self.skillItem_[iter_22_0]:SetData(iter_22_0, self.skillList_[iter_22_0], function()
			self.selectSkill_ = self.skillList_[iter_22_0]

			self:RefreshUI()
		end)
		self.skillItem_[iter_22_0]:SetHandler(self)
		self.skillItem_[iter_22_0]:Show(true)
	end

	self:CreateLineItemList()
end

function ChallengeRogueTeamSkillTreeView:CreateLineItemList()
	local var_24_0 = 1

	for iter_24_0, iter_24_1 in ipairs(self.skillList_) do
		if RogueTeamSkillTreeCfg[iter_24_1].level > 1 then
			local var_24_1 = self.skillItem_[iter_24_0]:GetLocalPosition() + Vector3(0, 0, 0)
			local var_24_2 = table.indexof(ChallengeRogueTeamData:GetSkillByLevel(RogueTeamSkillTreeCfg[iter_24_1].level), iter_24_1)
			local var_24_3 = ChallengeRogueTeamData:GetSkillByLevel(RogueTeamSkillTreeCfg[iter_24_1].level - 1)
			local var_24_4

			if RogueTeamSkillTreeCfg[iter_24_1].node_type == 1 then
				for iter_24_2, iter_24_3 in ipairs(var_24_3) do
					local var_24_5 = self.skillItem_[table.indexof(self.skillList_, iter_24_3)]:GetLocalPosition() + Vector3(0, 0, 0)

					self.lineList_[var_24_0] = self.lineList_[var_24_0] or self:GetLineClass(self.lineType_).New(self:GetLineGo(self.lineType_), self.nodeParent_, self:GetPointGo(self.lineType_))

					self.lineList_[var_24_0]:Show(true)
					self.lineList_[var_24_0]:RefreshUI(var_24_5, var_24_1)
					self.lineList_[var_24_0]:SetUnlockState(ChallengeRogueTeamData:IsHasSkill(self.templateID_, var_24_4))

					var_24_0 = var_24_0 + 1
				end
			else
				var_24_4 = #var_24_3 == 1 and var_24_3[1] or var_24_3[var_24_2]

				local var_24_6 = self.skillItem_[table.indexof(self.skillList_, var_24_4)]:GetLocalPosition() + Vector3(0, 0, 0)

				self.lineList_[var_24_0] = self.lineList_[var_24_0] or self:GetLineClass(self.lineType_).New(self:GetLineGo(self.lineType_), self.nodeParent_, self:GetPointGo(self.lineType_))

				self.lineList_[var_24_0]:Show(true)
				self.lineList_[var_24_0]:RefreshUI(var_24_6, var_24_1)
				self.lineList_[var_24_0]:SetUnlockState(ChallengeRogueTeamData:IsHasSkill(self.templateID_, var_24_4))

				var_24_0 = var_24_0 + 1
			end
		end
	end
end

function ChallengeRogueTeamSkillTreeView:GetLineClass(arg_25_1)
	return SectionChallengeRogueLineItem
end

function ChallengeRogueTeamSkillTreeView:GetLineGo(arg_26_1)
	return self.lineGo_
end

function ChallengeRogueTeamSkillTreeView:GetPointGo(arg_27_1)
	return self.nodeItem_
end

function ChallengeRogueTeamSkillTreeView:DestroyLine()
	for iter_28_0, iter_28_1 in pairs(self.lineList_) do
		iter_28_1:Dispose()
	end

	self.lineList_ = {}
end

return ChallengeRogueTeamSkillTreeView
