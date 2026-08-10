local var_0_0 = class("DamageTestModeItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.index_ = arg_1_2

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.selectController_ = ControllerUtil.GetController(arg_1_0.transform_, "chooseItem")
	arg_1_0.lockController_ = ControllerUtil.GetController(arg_1_0.transform_, "lock")
end

function var_0_0.Dispose(arg_2_0)
	var_0_0.super.Dispose(arg_2_0)
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.button_, nil, function()
		if arg_3_0.clickFunc_ then
			arg_3_0.clickFunc_(arg_3_0.index_)
		end
	end)
end

function var_0_0.RefreshUI(arg_5_0, arg_5_1)
	arg_5_0:SetSelectMode(arg_5_0.index_ == arg_5_1)
end

function var_0_0.SetSelectMode(arg_6_0, arg_6_1)
	if arg_6_1 then
		arg_6_0.selectController_:SetSelectedState("on")
	else
		arg_6_0.selectController_:SetSelectedState("off")
	end
end

function var_0_0.RegistClickFunc(arg_7_0, arg_7_1)
	arg_7_0.clickFunc_ = arg_7_1
end

return var_0_0
