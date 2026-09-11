local EventTriggerStep = class("EventTriggerStep", ComponentStep)

function EventTriggerStep:Init()
	EventTriggerStep.super.Init(self)

	self._eventName = GuideStepCfg[self._stepId].params[1]
end

function EventTriggerStep:EventTrigger(arg_2_1, arg_2_2)
	if self._eventName == arg_2_1 then
		local var_2_0 = self:Component()

		if var_2_0 ~= nil and self:CheckTarget(var_2_0, arg_2_1, arg_2_2) then
			self:OnStepEnd()
		end
	end
end

function EventTriggerStep:CheckTarget(arg_3_1, arg_3_2, arg_3_3)
	if arg_3_1:GetType() == typeof(EventTriggerListener) then
		if arg_3_2 == "pointerClick" then
			arg_3_1:OnPointerClick(arg_3_3)
		elseif arg_3_2 == "pointerUp" then
			arg_3_3.dragging = false

			arg_3_1:OnPointerUp(arg_3_3)
		elseif arg_3_2 == "pointerDown" then
			arg_3_3.dragging = false

			arg_3_1:OnPointerDown(arg_3_3)
			arg_3_1:OnPointerUp(arg_3_3)
		elseif arg_3_2 == "beginDrag" then
			arg_3_1:OnBeginDrag(arg_3_3)
		elseif arg_3_2 == "drag" then
			arg_3_1:OnDrag(arg_3_3)
		elseif arg_3_2 == "endDrag" then
			arg_3_1:OnEndDrag(arg_3_3)
		elseif arg_3_2 == "onPointerEnter" then
			arg_3_3.enter = true

			arg_3_1:OnPointerEnter(arg_3_3)
		elseif arg_3_2 == "onPointerOn" then
			arg_3_3.enter = false

			arg_3_1:OnPointerExit(arg_3_3)
		elseif arg_3_2 == "onPointerExit" then
			arg_3_3.enter = false

			arg_3_1:OnPointerExit(arg_3_3)
		else
			print("未知的触发类型", arg_3_2)
		end

		return true
	end

	error("EventTriggerStep CheckTarget Component Type Error")

	return false
end

return EventTriggerStep
