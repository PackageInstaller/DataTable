local ChapterMapScrollView = class("ChapterMapScrollView", ReduxView)

function ChapterMapScrollView:Ctor(arg_1_1, arg_1_2)
	self.parentView_ = arg_1_1
	self.gameObject_ = arg_1_2
	self.transform_ = arg_1_2.transform

	self:BindCfgUI()
	self:AddListeners()

	self.windowHalfX_ = self.viewPortRect_.rect.width / 2
	self.windowHalfY_ = self.viewPortRect_.rect.height / 2
end

function ChapterMapScrollView:OnExit()
	return
end

function ChapterMapScrollView:Dispose()
	self:RemoveListeners()
	self:RemoveTween()
	ChapterMapScrollView.super.Dispose(self)
end

function ChapterMapScrollView:AddListeners()
	self.scrollViewEvent_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(function(arg_5_0, arg_5_1)
		self:EnabledScroll(true)
		self.scrollView_:OnBeginDrag(arg_5_1)
	end))
	self.scrollViewEvent_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(function(arg_6_0, arg_6_1)
		return
	end))
	self.scrollViewEvent_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.Drag, LuaHelper.EventTriggerAction1(function(arg_7_0, arg_7_1)
		local var_7_0 = self.parentView_:GetBackCnt()

		if var_7_0 > 0 then
			LeanTween.cancel(self.contentRect_.gameObject)
			JumpTools.Back(var_7_0)
		end
	end))
	self.scrollViewEvent_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerDown, LuaHelper.EventTriggerAction1(function(arg_8_0, arg_8_1)
		return
	end))
	self.scrollViewEvent_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerUp, LuaHelper.EventTriggerAction1(function(arg_9_0, arg_9_1)
		local var_9_0 = self.parentView_:GetBackCnt()

		if not arg_9_1.dragging and var_9_0 > 0 then
			JumpTools.Back()
		end

		if var_9_0 <= 1 then
			self:EnabledScroll(true)
		else
			self:EnabledScroll(false)
		end
	end))
	self.scrollView_.onValueChanged:AddListener(function(arg_10_0)
		return
	end)
end

function ChapterMapScrollView:RemoveListeners()
	self.scrollViewEvent_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.BeginDrag)
	self.scrollViewEvent_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.Drag)
	self.scrollViewEvent_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.EndDrag)
	self.scrollViewEvent_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.PointerDown)
	self.scrollViewEvent_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.PointerUp)
	self.scrollView_.onValueChanged:RemoveAllListeners()
end

function ChapterMapScrollView:ScrollToPosition(arg_12_1)
	self:RemoveTween()
	LayoutRebuilder.ForceRebuildLayoutImmediate(self.contentRect_)
	self:EnabledScroll(false)

	self.tween_ = LeanTween.moveLocal(self.contentRect_.gameObject, arg_12_1 * -1, 0.5):setOnComplete(System.Action(function()
		LayoutRebuilder.ForceRebuildLayoutImmediate(self.contentRect_)
		self:RemoveTween()
	end)):setEase(LeanTweenType.easeOutSine)
end

function ChapterMapScrollView:EnabledScroll(arg_14_1)
	self.scrollView_.enabled = arg_14_1
end

function ChapterMapScrollView:RemoveTween()
	if self.tween_ then
		self.tween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(self.tween_.id)

		self.tween_ = nil
	end
end

return ChapterMapScrollView
