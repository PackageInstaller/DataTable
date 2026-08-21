local var_0_0 = class("ChallengeRogueTeamSkillTreeEffectPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_Roulike/RogueSkillTreeEffectPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddListeners()

	arg_3_0.normalSkillItem_ = {}
	arg_3_0.specialSkillItem_ = {}
	arg_3_0.emptyController = arg_3_0.controller_:GetController("empty")
	arg_3_0.specialEmptyController_ = arg_3_0.controller_:GetController("titleItem")
end

function var_0_0.OnEnter(arg_4_0)
	arg_4_0.templateID_ = arg_4_0.params_.templateID

	arg_4_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_5_0)
	arg_5_0.unlockSpecialSkill_ = ChallengeRogueTeamData:GetUnlockSpecialSkill(arg_5_0.templateID_)
	arg_5_0.unlockNormalSkill_ = ChallengeRogueTeamData:GetUnlockNormalSkill(arg_5_0.templateID_)
	arg_5_0.unlockNomalSkillTemplate_ = {}

	for iter_5_0, iter_5_1 in ipairs(arg_5_0.normalSkillItem_) do
		iter_5_1.value_ = 0

		SetActive(iter_5_1.gameObject, false)
	end

	for iter_5_2, iter_5_3 in ipairs(arg_5_0.specialSkillItem_) do
		SetActive(iter_5_3.gameObject, false)
	end

	for iter_5_4, iter_5_5 in ipairs(arg_5_0.unlockNormalSkill_) do
		local var_5_0 = RogueTeamSkillTreeCfg[iter_5_5]
		local var_5_1 = table.indexof(arg_5_0.unlockNomalSkillTemplate_, var_5_0.show_temp)

		if not var_5_1 then
			table.insert(arg_5_0.unlockNomalSkillTemplate_, var_5_0.show_temp)

			var_5_1 = table.indexof(arg_5_0.unlockNomalSkillTemplate_, var_5_0.show_temp)
		end

		if not arg_5_0.normalSkillItem_[#arg_5_0.unlockNomalSkillTemplate_] then
			local var_5_2 = ChallengeRogueTeamNormalSkillEffectItem.New(arg_5_0.effectItemGo_, arg_5_0.effectContent_)

			arg_5_0.normalSkillItem_[#arg_5_0.unlockNomalSkillTemplate_] = var_5_2

			arg_5_0.normalSkillItem_[#arg_5_0.unlockNomalSkillTemplate_]:SetData(var_5_0.show_temp)
		end

		arg_5_0.normalSkillItem_[var_5_1]:UpdateValue(var_5_0.show_value[2])
	end

	for iter_5_6, iter_5_7 in ipairs(arg_5_0.unlockSpecialSkill_) do
		if not arg_5_0.specialSkillItem_[iter_5_6] then
			local var_5_3 = ChallengeRogueTeamSpeacilSkillEffectItem.New(arg_5_0.specialEffectItemGo_, arg_5_0.specialEffectContent_)

			arg_5_0.specialSkillItem_[iter_5_6] = var_5_3
		end

		arg_5_0.specialSkillItem_[iter_5_6]:SetData(iter_5_7)
	end

	arg_5_0.emptyController:SetSelectedState(tostring(#arg_5_0.unlockNormalSkill_ + #arg_5_0.unlockSpecialSkill_ == 0))
	arg_5_0.specialEmptyController_:SetSelectedState(tostring(#arg_5_0.unlockSpecialSkill_ ~= 0))
end

function var_0_0.OnExit(arg_6_0)
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_7_0)
	arg_7_0:RemoveAllListeners()

	for iter_7_0, iter_7_1 in ipairs(arg_7_0.normalSkillItem_) do
		iter_7_1:Dispose()
	end

	arg_7_0.normalSkillItem_ = nil

	for iter_7_2, iter_7_3 in ipairs(arg_7_0.specialSkillItem_) do
		iter_7_3:Dispose()
	end

	arg_7_0.normalSkillItem_ = nil

	var_0_0.super.Dispose(arg_7_0)
end

function var_0_0.InitUI(arg_8_0)
	arg_8_0:BindCfgUI()
end

function var_0_0.AddListeners(arg_9_0)
	arg_9_0:AddBtnListener(arg_9_0.backBtn_, nil, function()
		arg_9_0:Back()
	end)
end

function var_0_0.OnTop(arg_11_0)
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

return var_0_0
