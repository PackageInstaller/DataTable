local var_0_0 = class("MatrixLevelItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:initUI()
	arg_1_0:AddUIListener()
end

function var_0_0.initUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.selectController_ = ControllerUtil.GetController(arg_2_0.transform_, "select")
	arg_2_0.typeController_ = ControllerUtil.GetController(arg_2_0.transform_, "type")
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.m_clickBtn, nil, function()
		if arg_3_0.clickFunc then
			arg_3_0.clickFunc(arg_3_0.level)
		end
	end)
end

function var_0_0.Refresh(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.level = arg_5_1
	arg_5_0.m_levelLab.text = "" .. arg_5_1
	arg_5_0.m_selectLab.text = "" .. arg_5_1

	if arg_5_1 <= arg_5_2 then
		arg_5_0.typeController_:SetSelectedIndex(0)
	else
		arg_5_0.typeController_:SetSelectedIndex(1)
	end
end

function var_0_0.SetChoice(arg_6_0, arg_6_1)
	arg_6_0.selectController_:SetSelectedIndex(arg_6_0.level == arg_6_1 and 1 or 0)
end

function var_0_0.RegistCallBack(arg_7_0, arg_7_1)
	arg_7_0.clickFunc = arg_7_1
end

function var_0_0.Dispose(arg_8_0)
	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
