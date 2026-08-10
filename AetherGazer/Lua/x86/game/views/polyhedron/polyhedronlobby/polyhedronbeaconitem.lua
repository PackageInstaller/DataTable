local var_0_0 = class("PolyhedronBeaconItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:initUI()
	arg_1_0:AddUIListener()
end

function var_0_0.initUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.selectController_ = ControllerUtil.GetController(arg_2_0.transform_, "select")
	arg_2_0.maskController_ = ControllerUtil.GetController(arg_2_0.transform_, "mask")
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.m_clickBtn, nil, function()
		if arg_3_0.clickFunc then
			arg_3_0.clickFunc(arg_3_0.id, arg_3_0)
		end
	end)
end

function var_0_0.SetData(arg_5_0, arg_5_1)
	arg_5_0.id = arg_5_1

	local var_5_0 = PolyhedronBeaconCfg[arg_5_0.id]

	arg_5_0.m_icon.sprite = pureGetSpriteWithoutAtlas(PolyhedronConst.BEACON_ICON_PATH .. var_5_0.icon)
	arg_5_0.m_name.text = GetI18NText(var_5_0.name)
	arg_5_0.m_des.text = GetI18NText(var_5_0.desc)
end

function var_0_0.SetChoice(arg_6_0, arg_6_1)
	arg_6_0.selectController_:SetSelectedIndex(arg_6_1 and 1 or 0)
end

function var_0_0.SetMask(arg_7_0, arg_7_1)
	arg_7_0.maskController_:SetSelectedIndex(arg_7_1 and 1 or 0)
end

function var_0_0.RegistCallBack(arg_8_0, arg_8_1)
	arg_8_0.clickFunc = arg_8_1
end

return var_0_0
