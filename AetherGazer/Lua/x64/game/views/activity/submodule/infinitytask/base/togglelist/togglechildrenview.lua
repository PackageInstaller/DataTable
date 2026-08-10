local var_0_0 = class("ToggleChildrenView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.parentIndex_ = arg_1_2
	arg_1_0.index_ = arg_1_3

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.controller_ = ControllerUtil.GetController(arg_1_0.transform_, "toggle")
end

function var_0_0.AddListeners(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.toggle_, nil, function()
		manager.notify:Invoke(TOGGLE_LIST_CHILDREN_UPDATE, arg_2_0.parentIndex_, arg_2_0.index_)
	end)
end

function var_0_0.Dispose(arg_4_0)
	var_0_0.super.Dispose(arg_4_0)
end

function var_0_0.SetSelectOn(arg_5_0, arg_5_1)
	if arg_5_0.index_ == arg_5_1 then
		arg_5_0.controller_:SetSelectedState("on")
	else
		arg_5_0.controller_:SetSelectedState("off")
	end
end

return var_0_0
