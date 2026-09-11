local ScrollMoveView = class("ScrollMoveView", ReduxView)

function ScrollMoveView:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self.parentView_ = arg_1_1
	self.gameObject_ = arg_1_2
	self.transform_ = arg_1_2.transform
	self.fixWidth = arg_1_3

	self:InitUI()
	self:AddListeners()

	self.needInitScroll_ = true
end

function ScrollMoveView:OnExit()
	self.scrollView_.enabled = true
	self.needInitScroll_ = true
end

function ScrollMoveView:Dispose()
	self:RemoveListeners()

	self.gameObject_ = nil
	self.transform_ = nil

	ScrollMoveView.super.Dispose(self)
end

function ScrollMoveView:InitUI()
	self:BindCfgUI()
end

function ScrollMoveView:AddListeners()
	self.scrollViewEvent_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(function(arg_6_0, arg_6_1)
		self.drag_ = true
	end))
	self.scrollViewEvent_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(function(arg_7_0, arg_7_1)
		self.drag_ = false
	end))
	self.scrollViewEvent_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerDown, LuaHelper.EventTriggerAction1(function(arg_8_0, arg_8_1)
		if not self.tween_ then
			self.scrollView_.enabled = true
		end
	end))
	self.scrollViewEvent_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerUp, LuaHelper.EventTriggerAction1(function(arg_9_0, arg_9_1)
		if not arg_9_1.dragging and self.parentView_:IsOpenSectionInfo() then
			self.isOpenInfoView_ = false

			JumpTools.Back()
		end
	end))
	self.scrollView_.onValueChanged:AddListener(function(arg_10_0)
		if self.isOpenInfoView_ and math.abs(self.horizontalNormalizedPosition_ - self.scrollView_.horizontalNormalizedPosition) >= 0.001 then
			self.isOpenInfoView_ = false

			if self.parentView_:IsOpenSectionInfo() then
				LeanTween.cancel(self.gameObject_)
				JumpTools.Back()
			end
		end

		if self.parentView_.OnScrollValueChanged then
			self.parentView_:OnScrollValueChanged()
		end
	end)
end

function ScrollMoveView:RemoveListeners()
	self.scrollViewEvent_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.BeginDrag)
	self.scrollViewEvent_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.EndDrag)
	self.scrollViewEvent_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.PointerDown)
	self.scrollViewEvent_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.PointerUp)
	self.scrollView_.onValueChanged:RemoveAllListeners()
end

function ScrollMoveView:InitScrollPosition(arg_12_1, arg_12_2)
	local var_12_0 = BattleFieldData:GetStoryBackFlag()

	if self.needInitScroll_ and self.contentRect_.rect.width < self.viewportRect_.rect.width then
		self:RemoveTween()

		if var_12_0 == true then
			self:StopMove(0)

			return
		end

		if arg_12_2 then
			self.contentRect_.localPosition = Vector3(0, self.contentRect_.localPosition.y, self.contentRect_.localPosition.z)
		else
			self.tween_ = LeanTween.value(self.gameObject_, self.viewportRect_.rect.width, 0, 0.5):setOnUpdate(LuaHelper.FloatAction(function(arg_13_0)
				if self.drag_ then
					self:RemoveTween()

					return
				end

				self.contentRect_.localPosition = Vector3(arg_13_0, self.contentRect_.localPosition.y, self.contentRect_.localPosition.z)
			end)):setOnComplete(System.Action(function()
				self:RemoveTween()
			end)):setEase(LeanTweenType.easeOutSine)
		end

		self.needInitScroll_ = false

		return
	end

	if self.needInitScroll_ then
		self.scrollView_.horizontalNormalizedPosition = 0
	end

	local var_12_1 = (arg_12_1 - self.viewportRect_.rect.width / 2 + 200) / (self.contentRect_.rect.width - self.viewportRect_.rect.width)

	if (arg_12_1 - self.viewportRect_.rect.width / 2 + 200) / (self.contentRect_.rect.width - self.viewportRect_.rect.width) < 0 then
		var_12_1 = 0

		if self.needInitScroll_ then
			self.scrollView_.horizontalNormalizedPosition = -1
		end
	elseif var_12_1 > 1 then
		var_12_1 = 1
	end

	self:RemoveTween()

	if var_12_0 == true then
		self:StopMove(var_12_1)

		return
	end

	if arg_12_2 then
		self.horizontalNormalizedPosition_ = var_12_1
		self.scrollView_.horizontalNormalizedPosition = var_12_1
	else
		self.tween_ = LeanTween.value(self.gameObject_, self.scrollView_.horizontalNormalizedPosition, var_12_1, 0.5):setOnUpdate(LuaHelper.FloatAction(function(arg_15_0)
			if self.drag_ then
				self:RemoveTween()

				return
			end

			self.horizontalNormalizedPosition_ = arg_15_0
			self.scrollView_.horizontalNormalizedPosition = arg_15_0
		end)):setOnComplete(System.Action(function()
			self:RemoveTween()
		end)):setEase(LeanTweenType.easeOutSine)
	end

	self.needInitScroll_ = false
end

function ScrollMoveView:ScrollPosition(arg_17_1, arg_17_2, arg_17_3)
	if self.parentView_:IsOpenSectionInfo() then
		if self.contentRect_.rect.width < self.viewportRect_.rect.width then
			self.contentRect_.sizeDelta = Vector2(self.viewportRect_.rect.width, 648)
		end

		local var_17_0 = arg_17_1 - self.viewportRect_.rect.width / 2 + 200

		if arg_17_3 then
			var_17_0 = var_17_0 + arg_17_3
		end

		self:RemoveTween()

		self.scrollView_.enabled = false

		if arg_17_2 then
			self.horizontalNormalizedPosition_ = var_17_0 / (self.contentRect_.rect.width - self.viewportRect_.rect.width)
			self.scrollView_.horizontalNormalizedPosition = var_17_0 / (self.contentRect_.rect.width - self.viewportRect_.rect.width)

			if self.parentView_:IsOpenSectionInfo() then
				self.isOpenInfoView_ = true
			end
		else
			self.tween_ = LeanTween.value(self.gameObject_, self.scrollView_.horizontalNormalizedPosition, var_17_0 / (self.contentRect_.rect.width - self.viewportRect_.rect.width), 0.5):setOnUpdate(LuaHelper.FloatAction(function(arg_18_0)
				self.horizontalNormalizedPosition_ = arg_18_0
				self.scrollView_.horizontalNormalizedPosition = arg_18_0

				if self.parentView_.OnScrollValueChanged then
					self.parentView_:OnScrollValueChanged()
				end
			end)):setOnComplete(System.Action(function()
				if self.parentView_:IsOpenSectionInfo() then
					self.isOpenInfoView_ = true
				end

				if self.parentView_.OnScrollValueChanged then
					self.parentView_:OnScrollValueChanged()
				end

				self:RemoveTween()
			end)):setEase(LeanTweenType.easeOutSine)
		end
	else
		if not self.fixWidth then
			self:CalcuteScrollWidth()
		end

		self.scrollView_.enabled = true
	end
end

function ScrollMoveView:ScrollVector(arg_20_1, arg_20_2, arg_20_3, arg_20_4)
	arg_20_4 = arg_20_4 or 0.5

	if self.parentView_:IsOpenSectionInfo() then
		if self.contentRect_.rect.width < self.viewportRect_.rect.width then
			self.contentRect_.sizeDelta = Vector2(0, 648)
		end

		arg_20_1.x = arg_20_1.x - self.viewportRect_.rect.width / 2 + 200
		arg_20_1 = arg_20_1 * -1

		self:RemoveTween()

		self.scrollView_.enabled = false
		self.horizontalNormalizedPosition_ = self.scrollView_.horizontalNormalizedPosition

		if arg_20_2 then
			self.contentRect_.localPosition = arg_20_1

			if self.parentView_:IsOpenSectionInfo() then
				self.isOpenInfoView_ = true
			end
		else
			self.tween_ = LeanTween.moveLocal(self.contentRect_.gameObject, arg_20_1, arg_20_4):setOnComplete(System.Action(function()
				if self.parentView_:IsOpenSectionInfo() then
					self.isOpenInfoView_ = true
				end

				self:RemoveTween()

				if arg_20_3 then
					arg_20_3()
				end
			end)):setEase(LeanTweenType.easeOutSine)
		end
	else
		if not self.fixWidth then
			self:CalcuteScrollWidth()
		end

		self.scrollView_.enabled = true
	end
end

function ScrollMoveView:ScrollVector2(arg_22_1, arg_22_2, arg_22_3, arg_22_4)
	arg_22_4 = arg_22_4 or 0.5

	self:RemoveTween()

	self.scrollView_.enabled = false
	self.horizontalNormalizedPosition_ = self.scrollView_.horizontalNormalizedPosition

	if arg_22_2 then
		self.contentRect_.localPosition = arg_22_1
		self.scrollView_.enabled = true

		if arg_22_3 then
			arg_22_3()
		end
	else
		self.tween_ = LeanTween.moveLocal(self.contentRect_.gameObject, arg_22_1, arg_22_4):setOnComplete(System.Action(function()
			self:RemoveTween()

			self.scrollView_.enabled = true

			if arg_22_3 then
				arg_22_3()
			end
		end)):setEase(LeanTweenType.easeOutSine)
	end
end

function ScrollMoveView:ScrollForceVector(arg_24_1, arg_24_2, arg_24_3)
	arg_24_3 = arg_24_3 or 0.5

	self:RemoveTween()

	self.scrollView_.enabled = false
	self.horizontalNormalizedPosition_ = self.scrollView_.horizontalNormalizedPosition

	if arg_24_1.x * -1 > self.contentRect_.rect.width - self.viewportRect_.rect.width then
		arg_24_1.x = self.contentRect_.rect.width * -1 + self.viewportRect_.rect.width
	end

	if arg_24_1.x >= 0 then
		arg_24_1.x = 0
	end

	if arg_24_2 then
		self.contentRect_.localPosition = arg_24_1
	else
		self.tween_ = LeanTween.moveLocal(self.contentRect_.gameObject, arg_24_1, arg_24_3):setOnComplete(System.Action(function()
			self.scrollView_.enabled = true

			self:RemoveTween()
		end)):setEase(LeanTweenType.easeOutSine)
	end
end

function ScrollMoveView:StopMove(arg_26_1)
	BattleFieldData:SetStoryBackFlag(false)

	self.horizontalNormalizedPosition_ = arg_26_1
	self.scrollView_.horizontalNormalizedPosition = arg_26_1
end

function ScrollMoveView:RemoveTween()
	if self.tween_ then
		self.tween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(self.tween_.id)

		self.tween_ = nil
	end
end

function ScrollMoveView:CalcuteScrollWidth()
	self.contentRect_.sizeDelta = Vector2(self.scrollWidth_ - self.viewportRect_.rect.width + self.viewportRect_.rect.width / 4, 648)
end

function ScrollMoveView:RefreshUI(arg_29_1, arg_29_2, arg_29_3)
	self.scrollWidth_ = arg_29_2

	self:CalcuteScrollWidth()
	self:InitScrollPosition(arg_29_1, arg_29_3)
	self:ScrollPosition(arg_29_1, arg_29_3)
end

function ScrollMoveView:SetHorizontalNormalizedPosition(arg_30_1, arg_30_2)
	self.needInitScroll_ = false
	self.scrollWidth_ = arg_30_2

	self:CalcuteScrollWidth()

	self.scrollView_.horizontalNormalizedPosition = arg_30_1
end

function ScrollMoveView:GetHorizontalNormalizedPosition()
	return self.scrollView_.horizontalNormalizedPosition
end

return ScrollMoveView
