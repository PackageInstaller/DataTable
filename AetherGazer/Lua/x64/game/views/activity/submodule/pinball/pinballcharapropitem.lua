local var_0_0 = class("PinballCharaPropItem", BaseView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()
end

function var_0_0.UpdatePropValueText(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if arg_3_3 then
		arg_3_0.value_.text = GetTipsF("PINBALL_HERO_ATTRIBUTE_NEXT_LEVEL", arg_3_1, arg_3_3)
	else
		arg_3_0.value_.text = GetTipsF("PINBALL_HERO_ATTRIBUTE", arg_3_1)
	end
end

function var_0_0.SetData(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	if arg_4_1 then
		arg_4_0.name_.text = arg_4_1
	end

	arg_4_0:UpdatePropValueText(arg_4_2, arg_4_3, arg_4_4)

	arg_4_0.bar_.minValue = 0
	arg_4_0.bar_.maxValue = arg_4_3 or 200
	arg_4_0.bar_.value = arg_4_2
end

return var_0_0
