local var_0_0 = class("ChessBoardTipsWindowView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Summer2024/Summer2024_ChessBoard/popUI/Summer2024_TeachingPopUI"
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
end

function var_0_0.OnEnter(arg_5_0)
	arg_5_0.tipsWindowID_ = arg_5_0.params_.tipsWindowID
	arg_5_0.callBack_ = arg_5_0.params_.callBack

	local var_5_0 = ChessBoardTipsWindowCfg[arg_5_0.tipsWindowID_]

	arg_5_0.titleText_.text = var_5_0.title
	arg_5_0.desText_.text = var_5_0.description
	arg_5_0.tipsText_.text = var_5_0.tips
	arg_5_0.isCanClick_ = false
	arg_5_0.timer_ = Timer.New(function()
		arg_5_0.isCanClick_ = true

		arg_5_0:StopTimer()
	end, 1, 1)

	arg_5_0.timer_:Start()
end

function var_0_0.OnExit(arg_7_0)
	arg_7_0:StopTimer()
end

function var_0_0.StopTimer(arg_8_0)
	if arg_8_0.timer_ then
		arg_8_0.timer_:Stop()

		arg_8_0.timer_ = nil
	end
end

function var_0_0.AddUIListener(arg_9_0)
	arg_9_0:AddBtnListener(arg_9_0.bgBtn_, nil, function()
		if arg_9_0.isCanClick_ and arg_9_0.callBack_ then
			arg_9_0.callBack_()

			arg_9_0.callBack_ = nil
		end
	end)
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0.super.Dispose(arg_11_0)
	arg_11_0:StopTimer()
end

return var_0_0
