local var_0_0 = class("BattleCatchDuckResultView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Summer2024/Summer2024_Duck/DuckPartyResultPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.resultController_ = arg_4_0.resultCon_:GetController("result")
	arg_4_0.endlessController_ = arg_4_0.resultCon_:GetController("endless")
	arg_4_0.btnController_ = arg_4_0.btncontentControllerexcollection_:GetController("btnState")
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.btnBack_, nil, function()
		BattleInstance.QuitBattle(arg_5_0.stageData_)
	end)
	arg_5_0:AddBtnListener(arg_5_0.btnReChallenge_, nil, function()
		BattleInstance.OnceMoreBattle(arg_5_0.params_.stageData)
	end)
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0.stageData_ = arg_8_0.params_.stageData

	local var_8_0 = BattleCatchDuckStageCfg[arg_8_0.stageData_.stageID_]

	arg_8_0.stageName_.text = var_8_0.name

	local var_8_1 = ActivityCatchDuckCfg.get_id_list_by_stage_id[arg_8_0.stageData_.stageID_][1]
	local var_8_2 = ActivityCatchDuckCfg[var_8_1]
	local var_8_3 = CatchDuckData:GetBattleResult() or {
		score = 0,
		seconds = var_8_2.limit_time
	}
	local var_8_4 = var_8_3.score >= var_8_2.target_score

	arg_8_0.resultController_:SetSelectedState(var_8_4 and "win" or "lose")

	arg_8_0.timeText_.text = var_8_4 and GetTips("CATCH_DUCK_WIN_TIME") or GetTips("CATCH_DUCK_FAIL_TIME")

	local var_8_5 = var_8_2.type == 1

	arg_8_0.endlessController_:SetSelectedState(var_8_5 and "normal" or "endless")

	arg_8_0.targetScore_.text = var_8_5 and var_8_2.limit_time .. GetTips("SECOND") or var_8_2.target_score
	arg_8_0.score_.text = var_8_5 and var_8_3.seconds .. GetTips("SECOND") or var_8_3.score

	if manager.ChessBoardManager and manager.ChessBoardManager:IsBattleBack() then
		arg_8_0.btnController_:SetSelectedState("chess")
	else
		arg_8_0.btnController_:SetSelectedState("normal")
	end
end

function var_0_0.OnExit(arg_9_0)
	return
end

function var_0_0.Dispose(arg_10_0)
	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
