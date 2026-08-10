local var_0_0 = class("CustomCenterToggle", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.selectController_ = arg_1_0.conEx_:GetController("select")
end

function var_0_0.Dispose(arg_2_0)
	var_0_0.super.Dispose(arg_2_0)
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.btn_, nil, function()
		if arg_3_0.clickFunc_ then
			arg_3_0.clickFunc_()
		end
	end)
end

function var_0_0.RegisterClickListener(arg_5_0, arg_5_1)
	arg_5_0.clickFunc_ = arg_5_1
end

function var_0_0.SetSelectedState(arg_6_0, arg_6_1)
	arg_6_0.selectController_:SetSelectedState(arg_6_1 and "on" or "off")
end

return var_0_0
