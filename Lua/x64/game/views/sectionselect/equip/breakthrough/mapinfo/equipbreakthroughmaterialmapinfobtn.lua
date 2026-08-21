local var_0_0 = class("EquipBreakThroughMaterialMapInfoBtn", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.toggleType_ = arg_1_2

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.controller_ = ControllerUtil.GetController(arg_1_0.transform_, "toggle")
	arg_1_0.selectToggleHandler_ = handler(arg_1_0, arg_1_0.RefreshToggle)
end

function var_0_0.OnEnter(arg_2_0, arg_2_1)
	arg_2_0:RefreshToggle(arg_2_1)
	manager.notify:RegistListener(EQUIP_BREAK_THROUGH_SELECT_TOGGLE, arg_2_0.selectToggleHandler_)
end

function var_0_0.OnExit(arg_3_0)
	manager.notify:RemoveListener(EQUIP_BREAK_THROUGH_SELECT_TOGGLE, arg_3_0.selectToggleHandler_)
end

function var_0_0.Dispose(arg_4_0)
	var_0_0.super.Dispose(arg_4_0)

	arg_4_0.selectToggleHandler_ = nil
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.button_, nil, function()
		manager.notify:Invoke(EQUIP_BREAK_THROUGH_SELECT_TOGGLE, arg_5_0.toggleType_)
	end)
end

function var_0_0.RefreshToggle(arg_7_0, arg_7_1)
	if arg_7_0.toggleType_ == arg_7_1 then
		arg_7_0.controller_:SetSelectedState("on")
	else
		arg_7_0.controller_:SetSelectedState("off")
	end
end

return var_0_0
