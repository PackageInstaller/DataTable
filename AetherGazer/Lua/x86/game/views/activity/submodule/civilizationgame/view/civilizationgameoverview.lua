local var_0_0 = class("CivilizationGameOverView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/V4_2_GodEaterUI/V4_2_GodEaterUI_Culture/V4_2_GodEaterUI_Culture_EndPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.stateController_ = arg_4_0.mainControllerEx_:GetController("state")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.bgBtn_, nil, function()
		JumpTools.OpenPageByJump("/civilizationGameMainView", {
			activityID = ActivityConst.ACTIVITY_CIVILIZATION
		})
	end)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_8_0)
	if arg_8_0.params_.isWin then
		arg_8_0.winTitleText_.text = GetTips("GODEATER_CIVILIZATION_GAME_WIN_TITLE")
		arg_8_0.descText_.text = GetTips("GODEATER_CIVILIZATION_GAME_WIN_TIPS")

		arg_8_0.stateController_:SetSelectedState("win")
	else
		arg_8_0.loseTitleText_.text = GetTips("GODEATER_CIVILIZATION_GAME_FAIL_TITLE")
		arg_8_0.descText_.text = GetTips("GODEATER_CIVILIZATION_GAME_FAIL_TIPS")

		arg_8_0.stateController_:SetSelectedState("lose")
	end
end

function var_0_0.OnTop(arg_9_0)
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
end

function var_0_0.OnExit(arg_10_0)
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_11_0)
	var_0_0.super.Dispose(arg_11_0)
	Object.Destroy(arg_11_0.gameObject_)
end

return var_0_0
