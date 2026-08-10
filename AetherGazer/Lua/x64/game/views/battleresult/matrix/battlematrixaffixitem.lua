local var_0_0 = class("BattleMatrixAffixItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:initUI()
end

function var_0_0.initUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.nullController = ControllerUtil.GetController(arg_2_0.transform_, "null")
end

function var_0_0.SetData(arg_3_0, arg_3_1)
	if arg_3_1 then
		arg_3_0.nullController:SetSelectedIndex(0)

		arg_3_0.m_lab.text = GetI18NText(getAffixName(arg_3_1))
		arg_3_0.m_icon.sprite = getAffixSprite(arg_3_1)
	else
		arg_3_0.nullController:SetSelectedIndex(1)

		arg_3_0.m_lab.text = ""
	end
end

return var_0_0
