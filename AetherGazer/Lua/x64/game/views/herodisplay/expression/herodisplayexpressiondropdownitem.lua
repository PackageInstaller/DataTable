local var_0_0 = class("HeroDisplayExpressionDropdownItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()
end

function var_0_0.Dispose(arg_2_0)
	var_0_0.super.Dispose(arg_2_0)
	Object.Destroy(arg_2_0.gameObject_)

	arg_2_0.transform_ = nil
	arg_2_0.gameObject_ = nil
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.button_, nil, function()
		manager.notify:Invoke(HERO_DISPLAY_EXPRESSION_ITEM, arg_3_0.index_)
	end)
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.index_ = arg_5_1
	arg_5_0.text_.text = GetI18NText(arg_5_2)

	arg_5_0:Show(true)
end

function var_0_0.SetSelect(arg_6_0, arg_6_1)
	SetActive(arg_6_0.goSelect_, arg_6_1)
end

function var_0_0.Show(arg_7_0, arg_7_1)
	SetActive(arg_7_0.gameObject_, arg_7_1)
end

return var_0_0
