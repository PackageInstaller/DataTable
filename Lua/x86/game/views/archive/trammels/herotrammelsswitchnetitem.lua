local var_0_0 = class("HeroTrammelsSwitchNetItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.index = arg_1_2

	SetActive(arg_1_0.gameObject_, true)
	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.stateController = ControllerUtil.GetController(arg_3_0.transform_, "state")
	arg_3_0.indexController = ControllerUtil.GetController(arg_3_0.transform_, "index")

	arg_3_0.indexController:SetSelectedIndex(arg_3_0.index - 1)
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(nil, arg_4_0.m_btn, function()
		if arg_4_0.callback_ then
			arg_4_0.callback_(arg_4_0.index)
		end
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1)
	arg_6_0.stateController:SetSelectedIndex(arg_6_1)
end

function var_0_0.RegistCallBack(arg_7_0, arg_7_1)
	arg_7_0.callback_ = arg_7_1
end

return var_0_0
