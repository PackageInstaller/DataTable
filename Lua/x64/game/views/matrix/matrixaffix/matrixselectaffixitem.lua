local var_0_0 = class("MatrixSelectAffixItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:initUI()
	arg_1_0:AddUIListener()
end

function var_0_0.initUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.selectController_ = ControllerUtil.GetController(arg_2_0.transform_, "select")
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.m_clickBtn, nil, function()
		if arg_3_0.clickFunc then
			arg_3_0.clickFunc(arg_3_0.id)
		end
	end)
end

function var_0_0.Refresh(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.id = arg_5_1

	arg_5_0.selectController_:SetSelectedIndex(arg_5_2)

	local var_5_0 = ActivityAffixPoolCfg[arg_5_0.id].affix
	local var_5_1 = ({
		"Ⅰ",
		"Ⅱ",
		"Ⅲ",
		"Ⅳ",
		"Ⅴ",
		"Ⅵ",
		"Ⅶ",
		"Ⅷ",
		"Ⅸ"
	})[var_5_0[2]]

	arg_5_0.m_name.text = var_5_1
	arg_5_0.m_icon.sprite = getAffixSprite(var_5_0)
end

function var_0_0.RegistCallBack(arg_6_0, arg_6_1)
	arg_6_0.clickFunc = arg_6_1
end

return var_0_0
