class = var_0_10000

local var_0_0 = "CourtYardDragAgent"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".CourtYardAgent"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.rect = arg_1_2
	GetOrAddComponent = var_3
	arg_1_0.trigger = var_3(arg_1_0._tf, "EventTriggerListener")
	arg_1_0.dragging = false

	arg_1_0:RegisterEvent()

	return
end

function var_0_1.Enable(arg_2_0, arg_2_1)
	arg_2_0.trigger.enabled = arg_2_1

	return
end

function var_0_1.RegisterEvent(arg_3_0)
	local var_3_0 = arg_3_0.trigger

	var_1.AddBeginDragFunc(var_3_0, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_3_0

		if not var_2.CanDrag(var_4_0, arg_4_0) then
			return
		end

		arg_3_0.dragging = true

		local var_4_1 = arg_3_0

		var_2.OnBeginDrag(var_4_1)

		return
	end)

	local var_3_1 = arg_3_0.trigger

	var_1.AddDragFunc(var_3_1, function(arg_5_0, arg_5_1)
		if arg_3_0.dragging and arg_3_0._go == arg_5_0 then
			CourtYardCalcUtil = var_2

			local var_5_0 = var_2.Screen2Local(arg_3_0.rect, arg_5_1.position)

			CourtYardCalcUtil = var_3

			local var_5_1 = var_3.Local2Map(var_5_0)
			local var_5_2 = arg_3_0

			var_4.OnDragging(var_5_2, var_5_1)
		end

		return
	end)

	local var_3_2 = arg_3_0.trigger

	var_1.AddDragEndFunc(var_3_2, function(arg_6_0, arg_6_1)
		if arg_3_0.dragging and arg_6_0 == arg_3_0._go then
			local var_6_0 = arg_3_0

			var_6_0.dragging = false
			CourtYardCalcUtil = var_6_0

			local var_6_1 = var_6_0.Screen2Local(arg_3_0.rect, arg_6_1.position)

			CourtYardCalcUtil = var_3

			local var_6_2 = var_3.Local2Map(var_6_1)
			local var_6_3 = arg_3_0

			var_4.OnDragEnd(var_6_3, var_6_2)
		end

		return
	end)

	return
end

function var_0_1.CanDrag(arg_7_0, arg_7_1)
	Input = var_1_10002

	return var_1_10002.touchCount <= 1 and arg_7_0._go == arg_7_1
end

function var_0_1.UnRegisterEvent(arg_8_0)
	arg_8_0.dragging = false
	ClearEventTrigger = var_1

	var_1(arg_8_0.trigger)

	return
end

function var_0_1.Dispose(arg_9_0)
	var_0_1.super.Dispose(arg_9_0)
	arg_9_0:UnRegisterEvent()

	Object = var_1

	var_1.Destroy(arg_9_0.trigger)

	return
end

return var_0_1
