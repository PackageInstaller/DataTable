local var_0_0 = class("SPKailiTugResuletView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/ShashwatUI_3_6/ShashwatUI_3_6_kaliUI/ShashwatUI_3_6_TugGameresultPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddListeners()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.stateController_ = arg_5_0.shashwatui_3_6_tuggameresultpopuiControllerexcollection_:GetController("battleStatede")
end

function var_0_0.AddListeners(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.suminibtn01Btn_, nil, function()
		arg_6_0:OnOk()
	end)
	arg_6_0:AddBtnListener(arg_6_0.suminibtn02Btn_, nil, function()
		arg_6_0:OnCancel()
	end)
end

function var_0_0.ChangeBar(arg_9_0)
	return
end

function var_0_0.OnTop(arg_10_0)
	return
end

function var_0_0.OnOk(arg_11_0)
	PushTugGameGoToMain()
end

function var_0_0.OnCancel(arg_12_0)
	arg_12_0:Back()
	arg_12_0.gameManager:RestartGame()
end

function var_0_0.Cacheable(arg_13_0)
	return false
end

function var_0_0.OnEnter(arg_14_0)
	arg_14_0.gameManager = TugGame.GetInstance()

	local var_14_0 = arg_14_0.params_ and arg_14_0.params_.isWin
	local var_14_1 = arg_14_0.params_ and arg_14_0.params_.stageID or 0

	arg_14_0.stateController_:SetSelectedState(var_14_0 and "win" or "lose")

	arg_14_0.textcheckpointText_.text = ActivityKaliGameStageCfg[var_14_1] and ActivityKaliGameStageCfg[var_14_1].name

	if var_14_0 then
		manager.audio:PlayEffect("minigame_activity_3_6", "minigame_activity_3_6_1156_rope_success")
	else
		manager.audio:PlayEffect("minigame_activity_3_6", "minigame_activity_3_6_1156_rope_fail")
	end
end

function var_0_0.OnExit(arg_15_0)
	var_0_0.super.OnExit(arg_15_0)
end

function var_0_0.Dispose(arg_16_0)
	var_0_0.super.Dispose(arg_16_0)
end

return var_0_0
