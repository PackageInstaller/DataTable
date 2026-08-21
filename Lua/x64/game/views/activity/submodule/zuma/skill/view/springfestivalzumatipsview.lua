local var_0_0 = class("SpringFestivalZumaTipsView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/CORGUI_SandPlay_Com/SandPlay_Com/SandPlay_Com_PopUI"
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
	arg_4_0:AddBtnListener(arg_4_0.reBattleBtn_, nil, function()
		if arg_4_0.params_.battleAction then
			arg_4_0.params_.battleAction()
		end
	end)
	arg_4_0:AddBtnListener(arg_4_0.confirmBtn_, nil, function()
		if arg_4_0.params_.sureCallback then
			arg_4_0.params_.sureCallback()
		end
	end)
end

function var_0_0.OnEnter(arg_8_0)
	local var_8_0 = arg_8_0.params_

	arg_8_0.contentText_.text = var_8_0.textContent
	arg_8_0.titleText_.text = var_8_0.titleContent

	if arg_8_0.params_.battleAction then
		SetActive(arg_8_0.reBattleBtn_, true)
	else
		SetActive(arg_8_0.reBattleBtn_, false)
	end
end

function var_0_0.OnExit(arg_9_0)
	return
end

function var_0_0.Dispose(arg_10_0)
	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
