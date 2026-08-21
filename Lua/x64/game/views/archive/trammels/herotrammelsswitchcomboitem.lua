local var_0_0 = class("HeroTrammelsSwitchComboItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.level = arg_1_2

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.stateController = ControllerUtil.GetController(arg_3_0.transform_, "state")
	arg_3_0.m_lvLab.text = GetTips("LEVEL") .. arg_3_0.level
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(nil, arg_4_0.m_btn, function()
		if arg_4_0.callback_ then
			arg_4_0.callback_(arg_4_0.level)
		end
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_1 < arg_6_0.level

	if arg_6_0.level == arg_6_2 then
		arg_6_0.stateController:SetSelectedIndex(var_6_0 and 3 or 2)
	else
		arg_6_0.stateController:SetSelectedIndex(var_6_0 and 0 or 1)
	end
end

function var_0_0.SetActive(arg_7_0, arg_7_1)
	SetActive(arg_7_0.gameObject_, arg_7_1)
end

function var_0_0.RegistCallBack(arg_8_0, arg_8_1)
	arg_8_0.callback_ = arg_8_1
end

function var_0_0.Dispose(arg_9_0)
	var_0_0.super.Dispose(arg_9_0)
end

return var_0_0
