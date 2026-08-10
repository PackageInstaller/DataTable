local var_0_0 = class("BattleWhackMoleResultView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Summer2024/Summer2024_WhackMoleUI/WhackmoleresultPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.resultController_ = arg_4_0.resultControllerEx_:GetController("result")
	arg_4_0.stageTypeController_ = arg_4_0.controllerEx_:GetController("stageType")
end

function var_0_0.AddListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.backBtn_, nil, function()
		BattleInstance.QuitBattle(arg_5_0.params_.stageData)
	end)
	arg_5_0:AddBtnListener(arg_5_0.onceMoreBtn_, nil, function()
		BattleInstance.OnceMoreBattle(arg_5_0.params_.stageData)
	end)
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0.stageData_ = arg_8_0.params_.stageData
	arg_8_0.whackMoleID_ = arg_8_0.stageData_:GetDest()

	arg_8_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_9_0)
	arg_9_0.scoreText_.text = arg_9_0.stageData_:GetScore()
	arg_9_0.targetScoreText_.text = ActivityWhackMoleCfg[arg_9_0.whackMoleID_].target_point

	arg_9_0.resultController_:SetSelectedState(arg_9_0.stageData_:GetBattleResult() == true and "win" or "lose")
	arg_9_0:RefreshStageType()
end

function var_0_0.RefreshStageType(arg_10_0)
	if ActivityWhackMoleCfg[arg_10_0.whackMoleID_].type == WhackMoleConst.STAGE_TYPE.CHESS then
		arg_10_0.stageTypeController_:SetSelectedState("chess")
	elseif ActivityWhackMoleCfg[arg_10_0.whackMoleID_].type == WhackMoleConst.STAGE_TYPE.INFINITY then
		arg_10_0.stageTypeController_:SetSelectedState("infinity")
	else
		arg_10_0.stageTypeController_:SetSelectedState("normal")
	end
end

return var_0_0
