local var_0_0 = class("NewChessMenu", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/WarChess/WarChessMenu"
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
	arg_4_0:BindCfgUI(arg_4_0.summercontextTrs_)

	arg_4_0.themeCon_ = ControllerUtil.GetController(arg_4_0.transform_, "name")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.cancelbtnBtn_, nil, function()
		ShowMessageBox({
			content = GetTips("CONFIRM_TO_QUIT_CHESS"),
			OkCallback = function()
				NewChessTools.ExitNewChessScene(true)
			end,
			CancelCallback = function()
				return
			end
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.okbtnBtn_, nil, function()
		NewChessTools.ExitNewChessScene(false)
	end)
	arg_5_0:AddBtnListener(arg_5_0.bgmaskBtn_, nil, function()
		arg_5_0:Back()

		if arg_5_0.callback_ then
			arg_5_0.callback_()
		end
	end)
end

function var_0_0.OnEnter(arg_11_0)
	return
end

function var_0_0.RefreshUI(arg_12_0)
	return
end

function var_0_0.OnExit(arg_13_0)
	return
end

function var_0_0.Dispose(arg_14_0)
	var_0_0.super.Dispose(arg_14_0)
end

return var_0_0
