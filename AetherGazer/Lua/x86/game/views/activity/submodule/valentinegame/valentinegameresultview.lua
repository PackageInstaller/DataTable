local var_0_0 = class("ValentineGameResultView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return ValentineGameTools.GetResultUIName(arg_1_0.params_.activityID)
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

	arg_4_0.indexCon_ = ControllerUtil.GetController(arg_4_0.gameObject_.transform, "index")
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.bgBtn_, nil, function()
		if arg_5_0.animator_:GetCurrentAnimatorStateInfo(0).normalizedTime >= 1 then
			JumpTools.OpenPageByJump("/valentineGameTest", {
				activityID = arg_5_0.params_.mainActivityID
			})
		end
	end)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_8_0)
	local var_8_0 = ActivityCfg[arg_8_0.params_.mainActivityID]

	arg_8_0.indexCon_:SetSelectedState(table.indexof(var_8_0.sub_activity_list, arg_8_0.params_.activityID))

	local var_8_1 = arg_8_0.params_.point
	local var_8_2 = ActivityValentineCfg[arg_8_0.params_.activityID]
	local var_8_3, var_8_4 = ValentineGameTools.GetPointRule(arg_8_0.params_.mainActivityID)

	if var_8_1 <= var_8_3 then
		arg_8_0.resultText_.text = GetTips("ACTIVITY_VALENTINE_RESULT_TITLE_1")
		arg_8_0.completeText_.text = GetI18NText(var_8_2.result_desc[1])
	elseif var_8_1 <= var_8_4 then
		arg_8_0.resultText_.text = GetTips("ACTIVITY_VALENTINE_RESULT_TITLE_2")
		arg_8_0.completeText_.text = GetI18NText(var_8_2.result_desc[2])
	else
		arg_8_0.resultText_.text = GetTips("ACTIVITY_VALENTINE_RESULT_TITLE_3")
		arg_8_0.completeText_.text = GetI18NText(var_8_2.result_desc[3])
	end
end

function var_0_0.OnTop(arg_9_0)
	manager.windowBar:HideBar()
end

function var_0_0.OnExit(arg_10_0)
	arg_10_0.canvasGroup_.alpha = 0
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0:RemoveAllListeners()
	arg_11_0.super.Dispose(arg_11_0)
end

return var_0_0
