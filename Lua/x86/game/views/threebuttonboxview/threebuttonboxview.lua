local var_0_0 = class("ThreeButtonBoxView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/PopUp/PopupmationUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.controller_ = ControllerUtil.GetController(arg_3_0.transformPanel_, "screenOrientation")
end

function var_0_0.OnEnter(arg_4_0)
	arg_4_0.textContent_.text = arg_4_0.params_.content

	if getScreenOrientation() then
		arg_4_0.controller_:SetSelectedState("horizontal")
	else
		arg_4_0.controller_:SetSelectedState("vertical")
	end
end

function var_0_0.OnExit(arg_5_0)
	return
end

function var_0_0.OnTop(arg_6_0)
	SetActive(arg_6_0.gameObject_, true)
end

function var_0_0.OnBehind(arg_7_0)
	SetActive(arg_7_0.gameObject_, false)
end

function var_0_0.Dispose(arg_8_0)
	var_0_0.super.Dispose(arg_8_0)
end

function var_0_0.AddListeners(arg_9_0)
	arg_9_0:AddBtnListener(arg_9_0.buttonMask_, nil, function()
		arg_9_0.params_.cancelFun()
	end)
	arg_9_0:AddBtnListener(arg_9_0.buttonCancel_, nil, function()
		arg_9_0.params_.cancelFun()
	end)
	arg_9_0:AddBtnListener(arg_9_0.buttonClose_, nil, function()
		arg_9_0:Back()
		arg_9_0.params_.closeFun()
	end)
	arg_9_0:AddBtnListener(arg_9_0.buttonOk_, nil, function()
		arg_9_0.params_.okFun()
	end)
end

return var_0_0
