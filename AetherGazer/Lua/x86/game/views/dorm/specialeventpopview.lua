local var_0_0 = class("SpecialEventPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/HouseUI/SpecialEventPop"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.maskBtn_, nil, function()
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.cancelbtnBtn_, nil, function()
		arg_5_0.params_.cancelCallback()
	end)
	arg_5_0:AddBtnListener(arg_5_0.okbtnBtn_, nil, function()
		arg_5_0.params_.okCallback()
	end)
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0.tex_contentText_.text = GetI18NText(arg_9_0.params_.content)
end

function var_0_0.OnExit(arg_10_0)
	return
end

function var_0_0.Dispose(arg_11_0)
	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
