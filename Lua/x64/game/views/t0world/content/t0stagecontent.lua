local var_0_0 = class("T0StageContent", BaseView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()

	arg_1_0.actionCom = arg_1_0.action_:GetComponent("T0GlobalWaitBubbleEventController")

	arg_1_0:AddListeners()
end

function var_0_0.AddListeners(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.leftHandBtn_, nil, function()
		arg_2_0.actionCom:TriggerInteract("1")
	end)
	arg_2_0:AddBtnListener(arg_2_0.rightHandBtn_, nil, function()
		arg_2_0.actionCom:TriggerInteract("2")
	end)
	arg_2_0:AddBtnListener(arg_2_0.bothHandBtn_, nil, function()
		arg_2_0.actionCom:TriggerInteract("3")
	end)
end

function var_0_0.Show(arg_6_0)
	SetActive(arg_6_0.gameObject_, true)
end

function var_0_0.Hide(arg_7_0)
	SetActive(arg_7_0.gameObject_, false)
end

function var_0_0.Toggle(arg_8_0)
	if arg_8_0.gameObject_.activeSelf then
		arg_8_0:Hide()
	else
		arg_8_0:Show()
	end
end

return var_0_0
