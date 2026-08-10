local var_0_0 = class("ChallengeRogueTeamTreasureUpgradeView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_Roulike/RoulikeUptreasurepopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.originItemView_ = ChallengeRogueTeamCommonItemView.New(arg_3_0.originItemGo_)
	arg_3_0.upgradeItemView_ = ChallengeRogueTeamCommonItemView.New(arg_3_0.upgradeItemGo_)
end

function var_0_0.OnEnter(arg_4_0)
	arg_4_0.currentIndex_ = 1
	arg_4_0.triggerValue_ = arg_4_0.params_.triggerValue

	arg_4_0:RefreshUI()
end

function var_0_0.OnExit(arg_5_0)
	ChallengeRogueTeamAction.RemovePopWindowCnt()
end

function var_0_0.Dispose(arg_6_0)
	arg_6_0.originItemView_:Dispose()

	arg_6_0.originItemView_ = nil

	arg_6_0.upgradeItemView_:Dispose()

	arg_6_0.upgradeItemView_ = nil

	var_0_0.super.Dispose(arg_6_0)
end

function var_0_0.AddListeners(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.closeBtn_, nil, function()
		if arg_7_0.currentIndex_ >= #arg_7_0.triggerValue_.itemList then
			ChallengeRogueTeamData:ClearObtainData()
			ChallengeRogueTeamData:RemoveServerTriggerQueue()
			arg_7_0:Back()
			ChallengeRogueTeamAction.RemovePopWindowCnt()
		else
			arg_7_0.currentIndex_ = arg_7_0.currentIndex_ + 1

			arg_7_0:RefreshUI()
		end
	end)
end

function var_0_0.RefreshUI(arg_9_0)
	local var_9_0 = arg_9_0.triggerValue_.itemList[arg_9_0.currentIndex_]
	local var_9_1 = clone(ChallengeRogueTeamCommonItemData)

	var_9_1.id = var_9_0.id
	var_9_1.rare = var_9_0.sourceRare
	var_9_1.descRaycastFlag = true

	arg_9_0.originItemView_:SetData(var_9_1)

	local var_9_2 = clone(ChallengeRogueTeamCommonItemData)

	var_9_2.id = var_9_0.id
	var_9_2.rare = var_9_0.rare
	var_9_2.descRaycastFlag = true

	arg_9_0.upgradeItemView_:SetData(var_9_2)

	arg_9_0.titleText_.text = GetTips("ROGUE_TEAM_TREASURE_UPGRADE_TITLE")
end

return var_0_0
