local var_0_0 = class("ChallengeRogueTeamWorldLineView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_Roulike/RogueTeamStoryUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.rogueTeamSureBtnView_ = ChallengeRogueTeamButton.New(arg_3_0.sureBtnGo_, handler(arg_3_0, arg_3_0.OnClickBtn))
	arg_3_0.atmosphereController_ = arg_3_0.atmosphereCon_:GetController("Ending")
end

function var_0_0.OnEnter(arg_4_0)
	local var_4_0 = ChallengeRogueTeamData:PlotGetWorldLineID()
	local var_4_1 = RogueTeamPlotPopCfg[var_4_0]

	arg_4_0.contentText_.text = var_4_1.pop_desc
	arg_4_0.itemGo_ = Object.Instantiate(Asset.Load(var_4_1.prefab_path), arg_4_0.storyContentGo_.transform)

	arg_4_0.rogueTeamSureBtnView_:RefreshBtnState(ChallengeRogueTeamButton.ENABLE_CLICK)

	local var_4_2 = var_4_0 == ChallengeRogueTeamConst.SPECIAL_ENDING.ENDING_POP_ID

	arg_4_0.atmosphereController_:SetSelectedState(var_4_2 and "red" or "normal")

	if var_4_2 then
		manager.notify:Invoke("CHALLENGE_SPECIAL_ENDING")
	end
end

function var_0_0.OnExit(arg_5_0)
	return
end

function var_0_0.Dispose(arg_6_0)
	arg_6_0.rogueTeamSureBtnView_:Dispose()

	arg_6_0.rogueTeamSureBtnView_ = nil

	Object.Destroy(arg_6_0.itemGo_)

	arg_6_0.itemGo_ = nil

	var_0_0.super.Dispose(arg_6_0)
end

function var_0_0.AddListeners(arg_7_0)
	return
end

function var_0_0.OnClickBtn(arg_8_0)
	ChallengeRogueTeamData:RemoveServerTriggerQueue()
	arg_8_0:Back()
	ChallengeRogueTeamAction.RemovePopWindowCnt()
	manager.notify:Invoke(CHALLENGE_ROGUE_TEAM_UPDATE_WINDOW)
end

function var_0_0.Cacheable(arg_9_0)
	return false
end

return var_0_0
