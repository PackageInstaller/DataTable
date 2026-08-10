local var_0_0 = class("MatrixProcessIncidentItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:initUI()
	arg_1_0:AddUIListener()
end

function var_0_0.AddUIListener(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.m_clickBtn, nil, function()
		if arg_2_0.clickFunc then
			arg_2_0.clickFunc(arg_2_0.index)
		end
	end)
end

function var_0_0.initUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.selectedController_ = ControllerUtil.GetController(arg_4_0.m_controller, "selected")
end

function var_0_0.Refresh(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.id = arg_5_1
	arg_5_0.index = arg_5_2

	local var_5_0 = MatrixDescCfg[arg_5_1]

	arg_5_0.m_tipLab.text = arg_5_2
	arg_5_0.m_desLab.text = var_5_0 and GetI18NText(var_5_0.desc) or ""
end

function var_0_0.RegistCallBack(arg_6_0, arg_6_1)
	arg_6_0.clickFunc = arg_6_1
end

function var_0_0.SetSelected(arg_7_0, arg_7_1)
	arg_7_0.selectedController_:SetSelectedIndex(arg_7_1 and 1 or 0)
end

function var_0_0.GetIndex(arg_8_0)
	return arg_8_0.index
end

return var_0_0
