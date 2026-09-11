local StageScrollView = class("StageScrollView", ReduxView)

function StageScrollView:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
	self:AddListeners()
end

function StageScrollView:InitUI()
	self:BindCfgUI()
end

function StageScrollView:Dispose()
	self:RemoveListeners()

	self.beginDragCallback_ = nil
	self.endDragCallback_ = nil
	self.pointerDownCallback_ = nil
	self.pointerUpCallback_ = nil
	self.scrollValueChangedCallback_ = nil

	StageScrollView.super.Dispose(self)
end

function StageScrollView:AddListeners()
	self.scrollEvent_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(function(arg_5_0, arg_5_1)
		self:RemoveTween()

		if self.beginDragCallback_ then
			self.beginDragCallback_()
		end
	end))
	self.scrollEvent_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(function(arg_6_0, arg_6_1)
		if self.endDragCallback_ then
			self.endDragCallback_()
		end
	end))
	self.scrollEvent_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerDown, LuaHelper.EventTriggerAction1(function(arg_7_0, arg_7_1)
		self.scrollRect_.enabled = true

		if self.pointerDownCallback_ then
			self.pointerDownCallback_()
		end
	end))
	self.scrollEvent_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerUp, LuaHelper.EventTriggerAction1(function(arg_8_0, arg_8_1)
		self.scrollRect_.enabled = true

		if self.pointerUpCallback_ then
			self.pointerUpCallback_()
		end
	end))
	self.scrollRect_.onValueChanged:AddListener(function(arg_9_0)
		if self.scrollValueChangedCallback_ then
			self.scrollValueChangedCallback_()
		end
	end)
end

function StageScrollView:OnExit()
	self.scrollRect_.enabled = true

	self:RemoveTween()
end

function StageScrollView:RemoveListeners()
	self.scrollEvent_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.BeginDrag)
	self.scrollEvent_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.EndDrag)
	self.scrollEvent_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.PointerDown)
	self.scrollEvent_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.PointerUp)
	self.scrollRect_.onValueChanged:RemoveAllListeners()
end

function StageScrollView:RegistBeginDrag(arg_12_1)
	self.beginDragCallback_ = arg_12_1
end

function StageScrollView:RegistEndDrag(arg_13_1)
	self.endDragCallback_ = arg_13_1
end

function StageScrollView:RegistPointerDown(arg_14_1)
	self.pointerDownCallback_ = arg_14_1
end

function StageScrollView:RegistPointerUp(arg_15_1)
	self.pointerUpCallback_ = arg_15_1
end

function StageScrollView:RegistScrollValueChanged(arg_16_1)
	self.scrollValueChangedCallback_ = arg_16_1
end

function StageScrollView:MoveContentScreenPosXDelta(arg_17_1, arg_17_2)
	self.scrollRect_.enabled = false

	self:DoMoveXTween(arg_17_1 * manager.ui.canvasRate / (self.contentTrans_.rect.width - self.viewPortTrans_.rect.width) + (arg_17_2 or 0))
end

function StageScrollView:DoMoveXTween(arg_18_1)
	self:RemoveTween()

	self.originHorizontalNormalizedPosition_ = self.scrollRect_.horizontalNormalizedPosition
	self.targetHorizontalNormalizedPosition_ = self.originHorizontalNormalizedPosition_ + arg_18_1
	self.tween_ = LeanTween.value(self.gameObject_, self.originHorizontalNormalizedPosition_, self.targetHorizontalNormalizedPosition_, 0.5):setOnUpdate(LuaHelper.FloatAction(function(arg_19_0)
		self.scrollRect_.horizontalNormalizedPosition = arg_19_0
	end)):setOnComplete(System.Action(function()
		self:RemoveTween()
	end)):setEase(LeanTweenType.easeOutSine)
end

function StageScrollView:Recover()
	if self.originHorizontalNormalizedPosition_ then
		if self.targetHorizontalNormalizedPosition_ < 0 or self.targetHorizontalNormalizedPosition_ > 1 then
			self.scrollRect_.enabled = true
		end

		self.originHorizontalNormalizedPosition_ = nil
	end
end

function StageScrollView:RemoveTween()
	if self.tween_ then
		self.tween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(self.tween_.id)

		self.tween_ = nil
	end
end

return StageScrollView
