local var_0_0 = class("QWorldComfirmView_4_0", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/SandPlay_QuanZhou/QuanZhou_Com/QuanZhou_ComfirmUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.cancelBtnText_.text = GetTips("CANCEL")
	arg_4_0.comfirmBtnText_.text = GetTips("ROGUE_TEAM_BUTTON_CONFIRM")
end

function var_0_0.AddListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.cancelBtn_, nil, function()
		if arg_5_0.params_.cancelCallback then
			arg_5_0.params_.cancelCallback()
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.comfirmBtn_, nil, function()
		if arg_5_0.params_.comfirmCallback then
			arg_5_0.params_.comfirmCallback()
		end
	end)
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_9_0)
	arg_9_0.titleText_.text = arg_9_0.params_.title or ""
	arg_9_0.contentText_.text = arg_9_0.params_.content or ""
end

return var_0_0
