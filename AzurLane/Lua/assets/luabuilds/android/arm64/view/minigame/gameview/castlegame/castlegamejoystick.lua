local var_0_0 = class("CastleGameJoyStick")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._tf = arg_1_1
	arg_1_0.smoothX = 0.02
	arg_1_0.smoothY = 0.02
	arg_1_0.maxDistance = 120
	arg_1_0.minDeadNum = 0.1
	arg_1_0.maxDeadNum = 0.9
	arg_1_0.currentPos = Vector2(0, 0)
	arg_1_0.targetPos = Vector2(0, 0)
	arg_1_0.currentX = 0
	arg_1_0.currentY = 0
	arg_1_0.currentXSmooth = 0
	arg_1_0.currentYSmooth = 0
	arg_1_0.active = false
	arg_1_0.startPos = Vector2(0, 0)
	arg_1_0.dragPos = Vector2(0, 0)
	arg_1_0.uiCam = GameObject.Find("UICamera"):GetComponent("Camera")
	arg_1_0._controlTf = findTF(arg_1_0._tf, "control")
	arg_1_0._joyTf = findTF(arg_1_0._tf, "control/joy")
	arg_1_0._eventTriggerListener = GetComponent(arg_1_0._controlTf, typeof(EventTriggerListener))

	arg_1_0._eventTriggerListener:AddPointDownFunc(function(arg_2_0, arg_2_1)
		arg_1_0.active = true
		arg_1_0.startPos = Vector2(0, 0)

		return
	end)
	arg_1_0._eventTriggerListener:AddDragFunc(function(arg_3_0, arg_3_1)
		arg_1_0.dragPos = arg_1_0._controlTf:InverseTransformPoint((arg_1_0.uiCam:ScreenToWorldPoint(arg_3_1.position)))

		arg_1_0:setTargetPos(arg_1_0:getOffset(arg_1_0.dragPos, arg_1_0.startPos))

		return
	end)
	arg_1_0._eventTriggerListener:AddPointUpFunc(function(arg_4_0, arg_4_1)
		arg_1_0.active = false

		arg_1_0:setTargetPos(Vector2(0, 0))

		return
	end)
	arg_1_0:setTargetPos(Vector2(0, 0))

	return
end

function var_0_0.setTargetPos(arg_5_0, arg_5_1)
	if math.sqrt(math.pow(arg_5_1.x - arg_5_0.startPos.x, 2) + math.pow(arg_5_1.y - arg_5_0.startPos.y, 2)) > arg_5_0.maxDistance then
		local var_5_0 = math.atan(math.abs(arg_5_1.y - arg_5_0.startPos.y) / math.abs(arg_5_1.x - arg_5_0.startPos.x))
		local var_5_1 = math.sin(var_5_0) * (arg_5_1.y > arg_5_0.startPos.y and 1 or -1) * arg_5_0.maxDistance

		arg_5_0.targetPos.x = math.cos(var_5_0) * (arg_5_1.x > arg_5_0.startPos.x and 1 or -1) * arg_5_0.maxDistance
		arg_5_0.targetPos.y = var_5_1
	else
		arg_5_0.targetPos = arg_5_1
	end

	return
end

function var_0_0.getOffset(arg_6_0, arg_6_1, arg_6_2)
	return Vector2(arg_6_1.x - arg_6_2.x, arg_6_1.y - arg_6_2.y)
end

function var_0_0.show(arg_7_0, arg_7_1)
	setActive(arg_7_0._tf, arg_7_1)

	return
end

function var_0_0.step(arg_8_0)
	arg_8_0.currentPos = arg_8_0._joyTf.anchoredPosition
	arg_8_0.currentX, arg_8_0.currentXSmooth = Mathf.SmoothDamp(arg_8_0.currentPos.x, arg_8_0.targetPos.x, arg_8_0.currentXSmooth, arg_8_0.smoothX)
	arg_8_0.currentY, arg_8_0.currentYSmooth = Mathf.SmoothDamp(arg_8_0.currentPos.y, arg_8_0.targetPos.y, arg_8_0.currentYSmooth, arg_8_0.smoothY)
	arg_8_0.currentPos.x = arg_8_0.currentX
	arg_8_0.currentPos.y = arg_8_0.currentY
	arg_8_0._joyTf.anchoredPosition = arg_8_0.currentPos
	arg_8_0.distanceRate = math.sqrt(math.pow(arg_8_0.currentX - arg_8_0.startPos.x, 2) + math.pow(arg_8_0.currentY - arg_8_0.startPos.y, 2)) / arg_8_0.maxDistance
	arg_8_0.angle = math.atan(math.abs(arg_8_0.currentY - arg_8_0.startPos.y) / math.abs(arg_8_0.currentX - arg_8_0.startPos.x))
	arg_8_0.offsetX = arg_8_0.currentPos.x / arg_8_0.maxDistance
	arg_8_0.offsetY = arg_8_0.currentPos.y / arg_8_0.maxDistance

	if arg_8_0.callback then
		arg_8_0.callback(arg_8_0:getValue())
	end

	return
end

function var_0_0.setDirectTarget(arg_9_0, arg_9_1)
	if not arg_9_0.active then
		arg_9_0:setTargetPos(Vector2(arg_9_1.x * 1000, arg_9_1.y * 1000))
	end

	return
end

function var_0_0.setValueCallback(arg_10_0, arg_10_1)
	arg_10_0.callback = arg_10_1

	return
end

function var_0_0.getValue(arg_11_0)
	return {
		angle = arg_11_0.angle,
		rate = arg_11_0.distanceRate,
		x = arg_11_0.offsetX,
		y = arg_11_0.offsetY
	}
end

return var_0_0
