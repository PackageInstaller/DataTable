local var_0_0 = class("AutoChessFormationPosView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.statusController_ = arg_2_0.controllerEx_:GetController("status")
	arg_2_0.enterController_ = arg_2_0.controllerEx_:GetController("enter")
end

function var_0_0.GetChessContainerTrans(arg_3_0)
	return arg_3_0.chessContainerTrans_
end

function var_0_0.SetStatus(arg_4_0, arg_4_1)
	arg_4_0.statusController_:SetSelectedState(arg_4_1)
end

function var_0_0.SetEnter(arg_5_0, arg_5_1)
	arg_5_0.enterController_:SetSelectedState(arg_5_1 and "enter" or "exit")
end

return var_0_0
