local var_0_0 = class("ZumaTipsView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/NorseUI_3_0/NorseUI_3_0_ZumaUI/NorseUI_3_0_ZumaTipsPopup"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0.selectTalentID = 0

	arg_3_0:InitUI()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
	arg_4_0:AddBtnListener(arg_4_0.bgmaskBtn_, nil, function()
		if arg_4_0.cancelCallback then
			arg_4_0.cancelCallback()
		end
	end)
	arg_4_0:AddBtnListener(arg_4_0.btn_noBtn_, nil, function()
		if arg_4_0.cancelCallback then
			arg_4_0.cancelCallback()
		end
	end)
	arg_4_0:AddBtnListener(arg_4_0.btn_yesBtn_, nil, function()
		if arg_4_0.sureCallback then
			arg_4_0.sureCallback()
		end
	end)
end

function var_0_0.OnEnter(arg_8_0)
	local var_8_0 = arg_8_0.params_

	arg_8_0.sureCallback = var_8_0.sureCallback
	arg_8_0.cancelCallback = var_8_0.cancelCallback
	arg_8_0.descText_.text = var_8_0.textContent
	arg_8_0.tittleText_.text = var_8_0.titleContent
end

function var_0_0.OnExit(arg_9_0)
	return
end

function var_0_0.Dispose(arg_10_0)
	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
