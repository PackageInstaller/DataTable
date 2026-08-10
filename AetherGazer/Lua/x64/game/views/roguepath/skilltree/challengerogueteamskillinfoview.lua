local var_0_0 = class("ChallengeRogueTeamSkillInfoView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_Roulike/RogueSkillInfoUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.stateController_ = arg_3_0.btnController_:GetController("state")
	arg_3_0.selectHandler_ = handler(arg_3_0, arg_3_0.OnSelectSkill)
end

function var_0_0.OnEnter(arg_4_0)
	arg_4_0.templateID_ = ChallengeRogueTeamData:GetCacheTemplateID()
	arg_4_0.skillID_ = arg_4_0.params_.skillID
	arg_4_0.handler_ = arg_4_0.params_.handler

	arg_4_0:RefreshUI()
	arg_4_0:RegistEventListener(CHALLENGE_ROGUE_TEAM_UNLOCK_SKILL, function()
		arg_4_0:RefreshUI()
	end)
	manager.notify:RegistListener(CHALLENGE_ROGUE_TEAM_SELECT_SKILL_ITEM, arg_4_0.selectHandler_)
end

function var_0_0.OnSelectSkill(arg_6_0, arg_6_1)
	arg_6_0.skillID_ = arg_6_1

	arg_6_0:RefreshUI()
end

function var_0_0.OnTop(arg_7_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		RogueTeamCfg[arg_7_0.templateID_].tech_item
	})
	manager.windowBar:SetGameHelpKey("ROGUE_TEAM_SKILLTREE_DESC")
	manager.windowBar:RegistBackCallBack(function()
		JumpTools.Back()
	end)
end

function var_0_0.OnExit(arg_9_0)
	manager.windowBar:HideBar()
end

function var_0_0.RefreshUI(arg_10_0)
	local var_10_0 = RogueTeamSkillTreeCfg[arg_10_0.skillID_]

	arg_10_0.nameText_.text = var_10_0.name
	arg_10_0.descText_.text = var_10_0.description
	arg_10_0.icon_.sprite = pureGetSpriteWithoutAtlas(RogueTeamSkillTreeCfg[arg_10_0.skillID_].icon)
	arg_10_0.costIcon_.sprite = ItemTools.getItemSprite(RogueTeamCfg[arg_10_0.templateID_].tech_item)
	arg_10_0.cost_.text = var_10_0.cost

	local var_10_1 = ChallengeRogueTeamData:GetCacheTemplateID()

	if ItemTools.getItemNum(RogueTeamCfg[arg_10_0.templateID_].tech_item) < tonumber(var_10_0.cost) then
		arg_10_0.cost_.color = Color.red
	else
		arg_10_0.cost_.color = Color.white
	end

	if ChallengeRogueTeamData:IsHasSkill(var_10_1, arg_10_0.skillID_) then
		arg_10_0.stateController_:SetSelectedState("unlock")
	elseif ChallengeRogueTeamData:CanSelectSkill(var_10_1, arg_10_0.skillID_) then
		arg_10_0.stateController_:SetSelectedState("canUnlock")
	else
		arg_10_0.stateController_:SetSelectedState("lock")
	end
end

function var_0_0.OnExit(arg_11_0)
	manager.ui:ResetMainCamera()
	manager.notify:RemoveListener(CHALLENGE_ROGUE_TEAM_SELECT_SKILL_ITEM, arg_11_0.selectHandler_)
end

function var_0_0.Dispose(arg_12_0)
	arg_12_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_12_0)
end

function var_0_0.AddListeners(arg_13_0)
	arg_13_0:AddBtnListener(arg_13_0.btn_, nil, function()
		local var_14_0 = RogueTeamSkillTreeCfg[arg_13_0.skillID_]

		if ItemTools.getItemNum(RogueTeamCfg[arg_13_0.templateID_].tech_item) < tonumber(var_14_0.cost) then
			ShowTips("CHALLENGE_ROGUE_TEAM_ERROR_ITEM_NOT_ENOUGH_CURRENCY")

			return
		end

		if ChallengeRogueTeamData:GetSelectDifficultyID(arg_13_0.templateID_) ~= 0 then
			ShowTips("ERROR_GAME_NOT_END")

			return
		end

		ChallengeRogueTeamAction.UnLockSkill(arg_13_0.templateID_, arg_13_0.skillID_)
	end)
end

return var_0_0
