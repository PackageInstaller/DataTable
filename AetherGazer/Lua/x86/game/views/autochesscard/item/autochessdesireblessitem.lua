local var_0_0 = class("AutoChessDesireBlessItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.blessId_ = 0
	arg_1_0.selectHandle_ = arg_1_2

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:InitUI()
	arg_2_0:AddListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0.stateController_ = arg_3_0.controller_:GetController("state")
end

function var_0_0.AddListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		if arg_4_0.selectHandle_ then
			arg_4_0.selectHandle_(arg_4_0.blessId_)
		end
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1)
	arg_6_0.blessId_ = arg_6_1

	arg_6_0:RefreshUI()
end

function var_0_0.SetState(arg_7_0, arg_7_1)
	if arg_7_0.blessId_ == arg_7_1 then
		arg_7_0.stateController_:SetSelectedIndex(1)
	else
		arg_7_0.stateController_:SetSelectedIndex(0)
	end
end

function var_0_0.RefreshUI(arg_8_0)
	arg_8_0.txtBless_.text = GetTips(arg_8_0.blessId_)
end

function var_0_0.SetActive(arg_9_0, arg_9_1)
	SetActive(arg_9_0.gameObject_, arg_9_1)
end

function var_0_0.Dispose(arg_10_0)
	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
