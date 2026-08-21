local var_0_0 = class("ChapterMapScrollView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.parentView_ = arg_1_1
	arg_1_0.gameObject_ = arg_1_2
	arg_1_0.transform_ = arg_1_2.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.windowHalfX_ = arg_1_0.viewPortRect_.rect.width / 2
	arg_1_0.windowHalfY_ = arg_1_0.viewPortRect_.rect.height / 2
end

function var_0_0.OnExit(arg_2_0)
	return
end

function var_0_0.Dispose(arg_3_0)
	arg_3_0:RemoveListeners()
	arg_3_0:RemoveTween()
	var_0_0.super.Dispose(arg_3_0)
end

function var_0_0.AddListeners(arg_4_0)
	arg_4_0.scrollViewEvent_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(function(arg_5_0, arg_5_1)
		arg_4_0:EnabledScroll(true)
		arg_4_0.scrollView_:OnBeginDrag(arg_5_1)
	end))
	arg_4_0.scrollViewEvent_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(function(arg_6_0, arg_6_1)
		return
	end))
	arg_4_0.scrollViewEvent_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.Drag, LuaHelper.EventTriggerAction1(function(arg_7_0, arg_7_1)
		local var_7_0 = arg_4_0.parentView_:GetBackCnt()

		if var_7_0 > 0 then
			LeanTween.cancel(arg_4_0.contentRect_.gameObject)
			JumpTools.Back(var_7_0)
		end
	end))
	arg_4_0.scrollViewEvent_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerDown, LuaHelper.EventTriggerAction1(function(arg_8_0, arg_8_1)
		return
	end))
	arg_4_0.scrollViewEvent_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerUp, LuaHelper.EventTriggerAction1(function(arg_9_0, arg_9_1)
		local var_9_0 = arg_4_0.parentView_:GetBackCnt()

		if not arg_9_1.dragging and var_9_0 > 0 then
			JumpTools.Back()
		end

		if var_9_0 <= 1 then
			arg_4_0:EnabledScroll(true)
		else
			arg_4_0:EnabledScroll(false)
		end
	end))
	arg_4_0.scrollView_.onValueChanged:AddListener(function(arg_10_0)
		return
	end)
end

function var_0_0.RemoveListeners(arg_11_0)
	arg_11_0.scrollViewEvent_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.BeginDrag)
	arg_11_0.scrollViewEvent_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.Drag)
	arg_11_0.scrollViewEvent_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.EndDrag)
	arg_11_0.scrollViewEvent_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.PointerDown)
	arg_11_0.scrollViewEvent_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.PointerUp)
	arg_11_0.scrollView_.onValueChanged:RemoveAllListeners()
end

function var_0_0.ScrollToPosition(arg_12_0, arg_12_1)
	arg_12_0:RemoveTween()
	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_0.contentRect_)
	arg_12_0:EnabledScroll(false)

	arg_12_0.tween_ = LeanTween.moveLocal(arg_12_0.contentRect_.gameObject, arg_12_1 * -1, 0.5):setOnComplete(System.Action(function()
		LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_0.contentRect_)
		arg_12_0:RemoveTween()
	end)):setEase(LeanTweenType.easeOutSine)
end

function var_0_0.EnabledScroll(arg_14_0, arg_14_1)
	arg_14_0.scrollView_.enabled = arg_14_1
end

function var_0_0.RemoveTween(arg_15_0)
	if arg_15_0.tween_ then
		arg_15_0.tween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(arg_15_0.tween_.id)

		arg_15_0.tween_ = nil
	end
end

return var_0_0
