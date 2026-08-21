local var_0_0 = class("GiftPopUpView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Main/PackexchangepopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
	arg_4_0:GetOrAddComponent(arg_4_0.input_.gameObject, typeof(InputFieldHelper))
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.btnCancel_, nil, function()
		JumpTools.Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.bgBtn_, nil, function()
		JumpTools.Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.btnOK_, nil, function()
		local var_8_0 = arg_5_0.input_.text
		local var_8_1 = string.trim(var_8_0)

		SettingAction.ExchangeCode(var_8_1, tostring(_G.TMP_CHANNELID))
	end)
end

function var_0_0.OnExchangeCode(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_1 then
		ShowTips("SUCCESS_EXCHANGE_CODE")

		arg_9_0.input_.text = ""
	else
		ShowTips(arg_9_2 or "UNDEFINED_ERROR")
	end
end

function var_0_0.OnExit(arg_10_0)
	arg_10_0.input_.text = ""
end

function var_0_0.OnExitInput(arg_11_0)
	JumpTools.Back()

	return true
end

function var_0_0.Dispose(arg_12_0)
	arg_12_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
