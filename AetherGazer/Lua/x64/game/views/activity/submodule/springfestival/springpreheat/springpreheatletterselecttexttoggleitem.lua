local var_0_0 = class("SpringPreheatLetterSelectTextToggleItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
	arg_1_0:AddUIListener()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.selController = ControllerUtil.GetController(arg_2_0.transform_, "select")
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.btn_, nil, function()
		if arg_3_0.onClickHandler_ then
			arg_3_0.onClickHandler_(arg_3_0, arg_3_0.index_)
		end
	end)
end

function var_0_0.SetClickHandler(arg_5_0, arg_5_1)
	if arg_5_1 then
		arg_5_0.onClickHandler_ = arg_5_1
	end
end

function var_0_0.SetSelected(arg_6_0, arg_6_1)
	arg_6_0.selected_ = arg_6_1

	return arg_6_0.selected_
end

function var_0_0.SetIndex(arg_7_0, arg_7_1)
	arg_7_0.index_ = arg_7_1
end

function var_0_0.RefreshUI(arg_8_0)
	local var_8_0 = string.format("SPRING_PREHEAT_SELECT_WORD_%d", arg_8_0.index_)

	arg_8_0.text_.text = GetTips(var_8_0)

	arg_8_0.selController:SetSelectedState(arg_8_0.selected_ and "true" or "false")
end

function var_0_0.Dispose(arg_9_0)
	var_0_0.super.Dispose(arg_9_0)
end

return var_0_0
