local var_0_0 = class("DormLinkGameSuccessView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/Alone_LinkGame/Alone_LGPlayResult1"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListenerScale(arg_6_0.confirmBtn_, nil, function()
		DormLinkGameTools:ExitGame()
	end)
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0:RefreshView(arg_8_0.params_.data)
end

function var_0_0.RefreshView(arg_9_0, arg_9_1)
	if arg_9_1 then
		arg_9_0.scoreText_.text = string.format(GetTips("ACTIVITY_LINKGAME_SCORE") .. "<color=#76c844>(+%d)</color>", arg_9_1.totalPoint, arg_9_1.extendPoint)
		arg_9_0.timeText_.text = string.format(GetTips("ACTIVITY_LINKGAME_TIME"), manager.time:DescCDTime(arg_9_1.time))
	end
end

function var_0_0.OnExit(arg_10_0)
	return
end

function var_0_0.Dispose(arg_11_0)
	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
