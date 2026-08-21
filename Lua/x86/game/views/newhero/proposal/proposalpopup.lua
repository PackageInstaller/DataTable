local var_0_0 = class("ProposalPopup", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Hero_equip/EquipSchemeNamePopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()

	arg_3_0.backHandler_ = handler(arg_3_0, arg_3_0.Back)
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
	arg_4_0:GetOrAddComponent(arg_4_0.input_.gameObject, typeof(InputFieldHelper))
	dealEnter(arg_4_0.input_.gameObject)
end

function var_0_0.OnEnter(arg_5_0)
	local var_5_0, var_5_1 = gameContext:GetLastHistoryAndParams()

	if string.char(string.byte(var_5_0)) == "/" then
		var_5_0 = string.sub(var_5_0, 2)
	end

	arg_5_0.lastRecord_ = var_5_0
	arg_5_0.input_.text = GetI18NText(arg_5_0.params_.defaultText) or ""

	manager.notify:RegistListener(INPUT_POP_BACK, arg_5_0.backHandler_)
end

function var_0_0.OnExit(arg_6_0)
	manager.notify:RemoveListener(INPUT_POP_BACK, arg_6_0.backHandler_)
end

function var_0_0.AddUIListener(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.cancelbtnBtn_, nil, function()
		OperationRecorder.Record(arg_7_0.lastRecord_, "proposal_cancelBtn")
		manager.notify:Invoke(INPUT_POP_CLICK_CANCEL)
		JumpTools.Back()
	end)
	arg_7_0:AddBtnListener(arg_7_0.bgmaskBtn_, nil, function()
		manager.notify:Invoke(INPUT_POP_CLICK_CLOSE, arg_7_0.input_.text, arg_7_0.input_)
		JumpTools.Back()
	end)
	arg_7_0:AddBtnListener(arg_7_0.okbtnBtn_, nil, function()
		OperationRecorder.Record(arg_7_0.lastRecord_, "proposal_okBtn")
		manager.notify:Invoke(INPUT_POP_CLICK_OK, arg_7_0.input_.text, arg_7_0.input_)
	end)
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0:RemoveAllListeners()

	arg_11_0.backHandler_ = nil

	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
