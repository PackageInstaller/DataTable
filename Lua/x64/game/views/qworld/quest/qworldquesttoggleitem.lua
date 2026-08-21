local var_0_0 = class("QWorldQuestToggleItem", ReduxView)

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

	arg_3_0.selectController = arg_3_0.conEx_:GetController("select")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddToggleListener(arg_4_0.toggle_, function(arg_5_0)
		if arg_5_0 and arg_4_0.callback_ then
			arg_4_0.callback_()
		end

		arg_4_0:SetValue(arg_5_0)
	end)
end

function var_0_0.SetValue(arg_6_0, arg_6_1)
	arg_6_0.selectController:SetSelectedState(arg_6_1 and "true" or "false")
end

function var_0_0.SetToggleValue(arg_7_0, arg_7_1)
	arg_7_0.toggle_.isOn = arg_7_1
end

function var_0_0.SetCallback(arg_8_0, arg_8_1)
	arg_8_0.callback_ = arg_8_1
end

function var_0_0.Dispose(arg_9_0)
	var_0_0.super.Dispose(arg_9_0)
end

return var_0_0
