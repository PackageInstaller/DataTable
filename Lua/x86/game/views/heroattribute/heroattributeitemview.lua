local var_0_0 = class("HeroAttributeItemView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()

	arg_1_0.textName_.text = GetI18NText(PublicAttrCfg[arg_1_4].name)

	SetActive(arg_1_0.attributeImg_.gameObject, arg_1_4 >= 151 and arg_1_4 <= 158)

	if arg_1_4 >= 151 and arg_1_4 <= 158 then
		local var_1_0 = arg_1_4 % 151 * 2

		arg_1_0.attributeImg_.sprite = HeroTools.GetSkillAttributeIcon(var_1_0)
	end

	arg_1_0.controller_ = ControllerUtil.GetController(arg_1_0.transform_, "name")

	if arg_1_3 % 2 == 1 then
		arg_1_0.controller_:SetSelectedState("0")
	else
		arg_1_0.controller_:SetSelectedState("1")
	end

	arg_1_0.attributeID_ = arg_1_4
end

function var_0_0.SetData(arg_2_0, arg_2_1)
	if PublicAttrCfg[arg_2_0.attributeID_].percent == 1 then
		arg_2_0.textNum_.text = string.format("%.2f%%", arg_2_1 / 10)
	else
		arg_2_0.textNum_.text = math.floor(arg_2_1)
	end
end

function var_0_0.Dispose(arg_3_0)
	var_0_0.super.Dispose(arg_3_0)
	Object.Destroy(arg_3_0.gameObject_)

	arg_3_0.transform_ = nil
	arg_3_0.gameObject_ = nil
end

return var_0_0
