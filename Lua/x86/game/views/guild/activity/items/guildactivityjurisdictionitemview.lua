local var_0_0 = class("GuildActivityJurisdictionItemView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_4_0)
	return
end

function var_0_0.AddEventListeners(arg_5_0)
	return
end

function var_0_0.SetData(arg_6_0, arg_6_1)
	arg_6_0.data_ = arg_6_1

	arg_6_0:UpdateView()
end

function var_0_0.UpdateView(arg_7_0)
	return
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0:AddEventListeners()
end

function var_0_0.OnExit(arg_9_0)
	arg_9_0:RemoveAllEventListener()
end

function var_0_0.OnMainHomeViewTop(arg_10_0)
	return
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0.data_ = nil

	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
