local var_0_0 = class("ClickButtonNoMaskStep", ComponentStep)

function var_0_0.Init(arg_1_0)
	var_0_0.super.Init(arg_1_0)

	arg_1_0.disableBtnEvent = GuideStepCfg[arg_1_0._stepId].params[1]
end

function var_0_0.GetShowMask(arg_2_0)
	return false
end

function var_0_0.Play(arg_3_0)
	local var_3_0 = arg_3_0:Component()

	if arg_3_0.disableBtnEvent then
		arg_3_0.eventTriggerListener = var_3_0.gameObject:AddComponent(typeof(EventTriggerListener))

		arg_3_0.eventTriggerListener:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerClick, LuaHelper.EventTriggerAction1(function(arg_4_0, arg_4_1)
			arg_3_0:OnStepEnd()
		end))

		var_3_0.enabled = false
	else
		function arg_3_0.btnCallBack()
			arg_3_0:OnStepEnd()
		end

		var_3_0.onClick:AddListener(arg_3_0.btnCallBack)
	end
end

function var_0_0.OnStepEnd(arg_6_0)
	if arg_6_0.eventTriggerListener then
		arg_6_0.eventTriggerListener:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.PointerClick)
		Object.Destroy(arg_6_0.eventTriggerListener)

		arg_6_0.eventTriggerListener = nil
	end

	local var_6_0 = arg_6_0:Component()

	if arg_6_0.btnCallBack then
		var_6_0.onClick:RemoveListener(arg_6_0.btnCallBack)

		arg_6_0.btnCallBack = nil
	end

	if arg_6_0._guideComponentCfg and arg_6_0._guideComponentCfg[2] == "settlement" then
		-- block empty
	else
		var_6_0.enabled = true
	end

	var_0_0.super.OnStepEnd(arg_6_0)
end

return var_0_0
