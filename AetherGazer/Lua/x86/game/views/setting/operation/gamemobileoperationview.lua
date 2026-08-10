local var_0_0 = class("GameMobileOperationView", ReduxView)

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
	arg_4_0:AddBtnListener(arg_4_0.battleSetBtn_, nil, function()
		arg_4_0:Go("battleUIAdjust", {})
	end)
end

function var_0_0.AddEventListeners(arg_6_0)
	return
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0:AddEventListeners()
end

function var_0_0.SaveData(arg_8_0)
	return
end

function var_0_0.CheckDataChange(arg_9_0)
	return false
end

function var_0_0.RecoverTmpData(arg_10_0)
	return
end

function var_0_0.OnExit(arg_11_0)
	arg_11_0:RemoveAllEventListener()
end

function var_0_0.Dispose(arg_12_0)
	var_0_0.super.Dispose(arg_12_0)
end

function var_0_0.UpdatePageData(arg_13_0)
	return
end

return var_0_0
