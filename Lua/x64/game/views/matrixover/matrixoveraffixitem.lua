local var_0_0 = class("MatrixOverAffixItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddBtnListener(arg_2_0.btn_, nil, function()
		local var_3_0 = arg_2_0.transform_.position

		manager.matrixPop:ShowMatrixAiffixPopItem(arg_2_0.affixData, Vector3(-1, var_3_0.y + 0.1, var_3_0.z))
	end)
end

function var_0_0.Refresh(arg_4_0, arg_4_1)
	arg_4_0.affixData = arg_4_1
	arg_4_0.m_icon.sprite = getAffixSprite(arg_4_1)

	local var_4_0 = ({
		"Ⅰ",
		"Ⅱ",
		"Ⅲ",
		"Ⅳ",
		"Ⅴ",
		"Ⅵ",
		"Ⅶ",
		"Ⅷ",
		"Ⅸ"
	})[arg_4_1[2]] or ""

	arg_4_0.m_name.text = var_4_0
end

return var_0_0
