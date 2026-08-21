local var_0_0 = class("SpringFestivalZumaTipsView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_Skuld/Activity_Skuld_TipsPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddUIListener()
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.cancelBtn_, nil, function()
		if arg_4_0.params_.cancelCallback then
			arg_4_0.params_.cancelCallback()
		end
	end)
	arg_4_0:AddBtnListener(arg_4_0.sureBtn_, nil, function()
		if arg_4_0.params_.sureCallback then
			arg_4_0.params_.sureCallback()
		end
	end)
end

function var_0_0.OnEnter(arg_7_0)
	local var_7_0 = arg_7_0.params_

	arg_7_0.contentText_.text = var_7_0.textContent

	if var_7_0.textContent then
		arg_7_0.titleText_.text = var_7_0.titleContent
	end
end

function var_0_0.OnExit(arg_8_0)
	return
end

function var_0_0.Dispose(arg_9_0)
	var_0_0.super.Dispose(arg_9_0)
end

return var_0_0
