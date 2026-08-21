local var_0_0 = class("EventTriggerStep", ComponentStep)

function var_0_0.Init(arg_1_0)
	var_0_0.super.Init(arg_1_0)

	arg_1_0._eventName = GuideStepCfg[arg_1_0._stepId].params[1]
end

function var_0_0.EventTrigger(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_0._eventName == arg_2_1 then
		local var_2_0 = arg_2_0:Component()

		if var_2_0 ~= nil and arg_2_0:CheckTarget(var_2_0, arg_2_1, arg_2_2) then
			arg_2_0:OnStepEnd()
		end
	end
end

function var_0_0.CheckTarget(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
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

return var_0_0
