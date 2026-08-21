local var_0_0 = class("MainHomeRandomTabItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.selectController = ControllerUtil.GetController(arg_3_0.transform_, "select")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		if arg_4_0.callback_ then
			arg_4_0.callback_(arg_4_0.index)
		end
	end)
end

function var_0_0.SetSelect(arg_6_0, arg_6_1)
	if arg_6_0.index == arg_6_1 then
		arg_6_0.selectController:SetSelectedIndex(0)
	else
		arg_6_0.selectController:SetSelectedIndex(1)
	end
end

function var_0_0.RegistCallBack(arg_7_0, arg_7_1)
	arg_7_0.callback_ = arg_7_1
end

function var_0_0.Dispose(arg_8_0)
	manager.redPoint:unbindUIandKey(arg_8_0.transform_)
	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
