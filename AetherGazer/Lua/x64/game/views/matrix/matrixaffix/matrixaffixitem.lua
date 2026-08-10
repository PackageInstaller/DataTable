local var_0_0 = class("MatrixAffixItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:initUI()
end

function var_0_0.initUI(arg_2_0)
	arg_2_0:BindCfgUI()
end

function var_0_0.Refresh(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.m_icon.sprite = getAffixSprite(arg_3_1)

	local var_3_0 = {
		"Ⅰ",
		"Ⅱ",
		"Ⅲ",
		"Ⅳ",
		"Ⅴ",
		"Ⅵ",
		"Ⅶ",
		"Ⅷ",
		"Ⅸ"
	}
	local var_3_1 = getAffixName(arg_3_1)
	local var_3_2 = getAffixDesc(arg_3_1)
	local var_3_3 = var_3_0[arg_3_1[2]] or ""

	if arg_3_2 == 2 then
		arg_3_0.m_text.text = GetI18NText(var_3_1) .. var_3_3 .. "\n" .. GetI18NText(var_3_2)
	else
		arg_3_0.m_text.text = GetI18NText(var_3_1) .. var_3_3
	end
end

function var_0_0.SetActive(arg_4_0, arg_4_1)
	SetActive(arg_4_0.gameObject_, arg_4_1)
end

return var_0_0
