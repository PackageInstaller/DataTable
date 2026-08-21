local var_0_0 = class("ChallengeRogueTeamSkillTreeView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_Roulike/RogueSkillTreeUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0.lineList_ = {}
	arg_3_0.skillItem_ = {}
	arg_3_0.lineType_ = nil

	arg_3_0:InitUI()

	arg_3_0.scrollMoveView_ = ScrollMoveView.New(arg_3_0, arg_3_0.scrollViewGo_)

	arg_3_0:AddListeners()
end

function var_0_0.OnEnter(arg_4_0)
	arg_4_0.templateID_ = ChallengeRogueTeamData:GetCacheTemplateID()
	arg_4_0.skillTemplateID_ = RogueTeamCfg[arg_4_0.templateID_].tree_temp
	arg_4_0.skillList_ = RogueTeamSkillTreeCfg.get_id_list_by_template_id[arg_4_0.skillTemplateID_]

	arg_4_0:RefreshBar()
	arg_4_0:ResetSelectItem()
	arg_4_0:RegistEventListener(CHALLENGE_ROGUE_TEAM_UNLOCK_SKILL, function()
		arg_4_0.skillList_ = RogueTeamSkillTreeCfg.get_id_list_by_template_id[arg_4_0.skillTemplateID_]

		arg_4_0:RefreshUI()
	end)
	arg_4_0:RefreshUI()
end

function var_0_0.IsOpenSectionInfo(arg_6_0)
	return false
end

function var_0_0.RefreshBar(arg_7_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		RogueTeamCfg[arg_7_0.templateID_].tech_item
	})
	manager.windowBar:SetGameHelpKey("ROGUE_TEAM_SKILLTREE_DESC")
	manager.windowBar:SetBarCanClick(RogueTeamCfg[arg_7_0.templateID_].tech_item, true)
	manager.windowBar:RegistBackCallBack(function()
		JumpTools.Back()
	end)
end

function var_0_0.OnTop(arg_9_0)
	arg_9_0:RefreshBar()
end

function var_0_0.RefreshUI(arg_10_0)
	arg_10_0:RefreshSkillList()

	local var_10_0 = arg_10_0:GetScrollPos()
	local var_10_1 = arg_10_0:GetScrollWidth()

	arg_10_0.scrollMoveView_:RefreshUI(var_10_0, var_10_1)

	local var_10_2 = #ChallengeRogueTeamData:GetUnlockSpecialSkill(arg_10_0.templateID_) + #ChallengeRogueTeamData:GetUnlockNormalSkill(arg_10_0.templateID_)

	arg_10_0.effectNumText_.text = var_10_2 .. "/" .. #arg_10_0.skillList_

	arg_10_0:RefreshSelectItem()
end

function var_0_0.GetScrollWidth(arg_11_0)
	local var_11_0 = 0

	for iter_11_0, iter_11_1 in ipairs(arg_11_0.skillList_) do
		local var_11_1 = RogueTeamSkillTreeCfg[iter_11_1]

		if var_11_0 < var_11_1.level then
			var_11_0 = var_11_1.level
		end
	end

	return (var_11_0 + 1) * 400
end

function var_0_0.GetScrollPos(arg_12_0)
	local var_12_0 = RogueTeamSkillTreeCfg[arg_12_0.selectSkill_]

	return var_12_0 and var_12_0.level * 400 or 0
end

function var_0_0.OnExit(arg_13_0)
	manager.windowBar:HideBar()
	manager.ui:ResetMainCamera()
end

function var_0_0.Dispose(arg_14_0)
	arg_14_0:RemoveAllListeners()

	arg_14_0.lineType_ = nil

	for iter_14_0, iter_14_1 in ipairs(arg_14_0.skillItem_) do
		iter_14_1:Dispose()
	end

	arg_14_0.skillItem_ = nil

	arg_14_0:DestroyLine()

	arg_14_0.lineList_ = nil
	arg_14_0.scrollView_ = nil
	arg_14_0.scrollViewGo_ = nil
	arg_14_0.sectionItem_ = nil
	arg_14_0.lineGo_ = nil

	var_0_0.super.Dispose(arg_14_0)
end

function var_0_0.InitUI(arg_15_0)
	arg_15_0:BindCfgUI()
	arg_15_0:AddListeners()
end

function var_0_0.AddListeners(arg_16_0)
	arg_16_0:AddBtnListener(arg_16_0.effectBtn_, nil, function()
		JumpTools.OpenPageByJump("challengeRogueTeamSkillTreeEffectPop", {
			templateID = arg_16_0.templateID_
		})
	end)
	arg_16_0:AddBtnListener(arg_16_0.bgBtn_, nil, function()
		if gameContext:IsOpenRoute("challengeRogueTeamSkillInfo") then
			arg_16_0:ResetSelectItem()
			JumpTools.Back()
		end
	end)
	arg_16_0.scorllEvent_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerClick, LuaHelper.EventTriggerAction1(function(arg_19_0, arg_19_1)
		if arg_19_1.dragging then
			return
		end

		if gameContext:IsOpenRoute("challengeRogueTeamSkillInfo") then
			arg_16_0:ResetSelectItem()
			JumpTools.Back()
		end

		arg_19_1:Use()
	end))
end

function var_0_0.RefreshSelectItem(arg_20_0)
	for iter_20_0, iter_20_1 in pairs(arg_20_0.skillItem_) do
		iter_20_1:SelectorItem(arg_20_0.selectSkill_)
	end
end

function var_0_0.ResetSelectItem(arg_21_0)
	arg_21_0.selectSkill_ = 0

	arg_21_0:RefreshSelectItem()
end

function var_0_0.RefreshSkillList(arg_22_0)
	for iter_22_0 = 1, #arg_22_0.skillList_ do
		if not arg_22_0.skillItem_[iter_22_0] then
			arg_22_0.skillItem_[iter_22_0] = ChallengeRogueTeamSkillItem.New(arg_22_0.nodeItem_, arg_22_0.nodeParent_)
		end

		arg_22_0.skillItem_[iter_22_0]:SetData(iter_22_0, arg_22_0.skillList_[iter_22_0], function()
			arg_22_0.selectSkill_ = arg_22_0.skillList_[iter_22_0]

			arg_22_0:RefreshUI()
		end)
		arg_22_0.skillItem_[iter_22_0]:SetHandler(arg_22_0)
		arg_22_0.skillItem_[iter_22_0]:Show(true)
	end

	arg_22_0:CreateLineItemList()
end

function var_0_0.CreateLineItemList(arg_24_0)
	local var_24_0 = 1

	for iter_24_0, iter_24_1 in ipairs(arg_24_0.skillList_) do
		if RogueTeamSkillTreeCfg[iter_24_1].level > 1 then
			local var_24_1 = RogueTeamSkillTreeCfg[iter_24_1]
			local var_24_2 = arg_24_0.skillItem_[iter_24_0]:GetLocalPosition() + Vector3(0, 0, 0)
			local var_24_3 = RogueTeamSkillTreeCfg[iter_24_1].level
			local var_24_4 = table.indexof(ChallengeRogueTeamData:GetSkillByLevel(var_24_3), iter_24_1)
			local var_24_5 = ChallengeRogueTeamData:GetSkillByLevel(var_24_3 - 1)
			local var_24_6

			if var_24_1.node_type == 1 then
				for iter_24_2, iter_24_3 in ipairs(var_24_5) do
					local var_24_7 = table.indexof(arg_24_0.skillList_, iter_24_3)
					local var_24_8 = arg_24_0.skillItem_[var_24_7]:GetLocalPosition() + Vector3(0, 0, 0)

					arg_24_0.lineList_[var_24_0] = arg_24_0.lineList_[var_24_0] or arg_24_0:GetLineClass(arg_24_0.lineType_).New(arg_24_0:GetLineGo(arg_24_0.lineType_), arg_24_0.nodeParent_, arg_24_0:GetPointGo(arg_24_0.lineType_))

					arg_24_0.lineList_[var_24_0]:Show(true)
					arg_24_0.lineList_[var_24_0]:RefreshUI(var_24_8, var_24_2)
					arg_24_0.lineList_[var_24_0]:SetUnlockState(ChallengeRogueTeamData:IsHasSkill(arg_24_0.templateID_, var_24_6))

					var_24_0 = var_24_0 + 1
				end
			else
				if #var_24_5 == 1 then
					var_24_6 = var_24_5[1]
				else
					var_24_6 = var_24_5[var_24_4]
				end

				local var_24_9 = table.indexof(arg_24_0.skillList_, var_24_6)
				local var_24_10 = arg_24_0.skillItem_[var_24_9]:GetLocalPosition() + Vector3(0, 0, 0)

				arg_24_0.lineList_[var_24_0] = arg_24_0.lineList_[var_24_0] or arg_24_0:GetLineClass(arg_24_0.lineType_).New(arg_24_0:GetLineGo(arg_24_0.lineType_), arg_24_0.nodeParent_, arg_24_0:GetPointGo(arg_24_0.lineType_))

				arg_24_0.lineList_[var_24_0]:Show(true)
				arg_24_0.lineList_[var_24_0]:RefreshUI(var_24_10, var_24_2)
				arg_24_0.lineList_[var_24_0]:SetUnlockState(ChallengeRogueTeamData:IsHasSkill(arg_24_0.templateID_, var_24_6))

				var_24_0 = var_24_0 + 1
			end
		end
	end
end

function var_0_0.GetLineClass(arg_25_0, arg_25_1)
	return SectionChallengeRogueLineItem
end

function var_0_0.GetLineGo(arg_26_0, arg_26_1)
	return arg_26_0.lineGo_
end

function var_0_0.GetPointGo(arg_27_0, arg_27_1)
	return arg_27_0.nodeItem_
end

function var_0_0.DestroyLine(arg_28_0)
	for iter_28_0, iter_28_1 in pairs(arg_28_0.lineList_) do
		iter_28_1:Dispose()
	end

	arg_28_0.lineList_ = {}
end

return var_0_0
