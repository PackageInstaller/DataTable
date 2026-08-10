local var_0_0 = class("StageScrollView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
	arg_1_0:AddListeners()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()
end

function var_0_0.Dispose(arg_3_0)
	arg_3_0:RemoveListeners()

	arg_3_0.beginDragCallback_ = nil
	arg_3_0.endDragCallback_ = nil
	arg_3_0.pointerDownCallback_ = nil
	arg_3_0.pointerUpCallback_ = nil
	arg_3_0.scrollValueChangedCallback_ = nil

	var_0_0.super.Dispose(arg_3_0)
end

function var_0_0.AddListeners(arg_4_0)
	arg_4_0.scrollEvent_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(function(arg_5_0, arg_5_1)
		arg_4_0:RemoveTween()

		if arg_4_0.beginDragCallback_ then
			arg_4_0.beginDragCallback_()
		end
	end))
	arg_4_0.scrollEvent_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(function(arg_6_0, arg_6_1)
		if arg_4_0.endDragCallback_ then
			arg_4_0.endDragCallback_()
		end
	end))
	arg_4_0.scrollEvent_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerDown, LuaHelper.EventTriggerAction1(function(arg_7_0, arg_7_1)
		arg_4_0.scrollRect_.enabled = true

		if arg_4_0.pointerDownCallback_ then
			arg_4_0.pointerDownCallback_()
		end
	end))
	arg_4_0.scrollEvent_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerUp, LuaHelper.EventTriggerAction1(function(arg_8_0, arg_8_1)
		arg_4_0.scrollRect_.enabled = true

		if arg_4_0.pointerUpCallback_ then
			arg_4_0.pointerUpCallback_()
		end
	end))
	arg_4_0.scrollRect_.onValueChanged:AddListener(function(arg_9_0)
		if arg_4_0.scrollValueChangedCallback_ then
			arg_4_0.scrollValueChangedCallback_()
		end
	end)
end

function var_0_0.OnExit(arg_10_0)
	arg_10_0.scrollRect_.enabled = true

	arg_10_0:RemoveTween()
end

function var_0_0.RemoveListeners(arg_11_0)
	arg_11_0.scrollEvent_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.BeginDrag)
	arg_11_0.scrollEvent_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.EndDrag)
	arg_11_0.scrollEvent_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.PointerDown)
	arg_11_0.scrollEvent_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.PointerUp)
	arg_11_0.scrollRect_.onValueChanged:RemoveAllListeners()
end

function var_0_0.RegistBeginDrag(arg_12_0, arg_12_1)
	arg_12_0.beginDragCallback_ = arg_12_1
end

function var_0_0.RegistEndDrag(arg_13_0, arg_13_1)
	arg_13_0.endDragCallback_ = arg_13_1
end

function var_0_0.RegistPointerDown(arg_14_0, arg_14_1)
	arg_14_0.pointerDownCallback_ = arg_14_1
end

function var_0_0.RegistPointerUp(arg_15_0, arg_15_1)
	arg_15_0.pointerUpCallback_ = arg_15_1
end

function var_0_0.RegistScrollValueChanged(arg_16_0, arg_16_1)
	arg_16_0.scrollValueChangedCallback_ = arg_16_1
end

function var_0_0.MoveContentScreenPosXDelta(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_1 * manager.ui.canvasRate
	local var_17_1 = arg_17_2 or 0
	local var_17_2 = var_17_0 / (arg_17_0.contentTrans_.rect.width - arg_17_0.viewPortTrans_.rect.width) + var_17_1

	arg_17_0.scrollRect_.enabled = false

	arg_17_0:DoMoveXTween(var_17_2)
end

function var_0_0.DoMoveXTween(arg_18_0, arg_18_1)
	arg_18_0:RemoveTween()

	arg_18_0.originHorizontalNormalizedPosition_ = arg_18_0.scrollRect_.horizontalNormalizedPosition
	arg_18_0.targetHorizontalNormalizedPosition_ = arg_18_0.originHorizontalNormalizedPosition_ + arg_18_1
	arg_18_0.tween_ = LeanTween.value(arg_18_0.gameObject_, arg_18_0.originHorizontalNormalizedPosition_, arg_18_0.targetHorizontalNormalizedPosition_, 0.5):setOnUpdate(LuaHelper.FloatAction(function(arg_19_0)
		arg_18_0.scrollRect_.horizontalNormalizedPosition = arg_19_0
	end)):setOnComplete(System.Action(function()
		arg_18_0:RemoveTween()
	end)):setEase(LeanTweenType.easeOutSine)
end

function var_0_0.Recover(arg_21_0)
	if arg_21_0.originHorizontalNormalizedPosition_ then
		if arg_21_0.targetHorizontalNormalizedPosition_ < 0 or arg_21_0.targetHorizontalNormalizedPosition_ > 1 then
			arg_21_0.scrollRect_.enabled = true
		end

		arg_21_0.originHorizontalNormalizedPosition_ = nil
	end
end

function var_0_0.RemoveTween(arg_22_0)
	if arg_22_0.tween_ then
		arg_22_0.tween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(arg_22_0.tween_.id)

		arg_22_0.tween_ = nil
	end
end

return var_0_0
