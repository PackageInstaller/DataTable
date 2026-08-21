local var_0_0 = class("MiniGameJoyStick")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._tf = arg_1_1
	arg_1_0.smoothX = 0.01
	arg_1_0.smoothY = 0.01
	arg_1_0.maxDistance = 120
	arg_1_0.minDeadNum = 0.05
	arg_1_0.maxDeadNum = 1
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
		arg_1_0.dragActive = true
		arg_1_0.active = true
		arg_1_0.dragPos = arg_1_0._controlTf:InverseTransformPoint((arg_1_0.uiCam:ScreenToWorldPoint(arg_2_1.position)))

		arg_1_0:setTargetPos(arg_1_0:getOffset(arg_1_0.dragPos, arg_1_0.startPos))

		if arg_1_0.activeCallback then
			arg_1_0.activeCallback(true)
		end

		return
	end)
	arg_1_0._eventTriggerListener:AddDragFunc(function(arg_3_0, arg_3_1)
		arg_1_0.dragPos = arg_1_0._controlTf:InverseTransformPoint((arg_1_0.uiCam:ScreenToWorldPoint(arg_3_1.position)))

		arg_1_0:setTargetPos(arg_1_0:getOffset(arg_1_0.dragPos, arg_1_0.startPos))

		return
	end)
	arg_1_0._eventTriggerListener:AddPointUpFunc(function(arg_4_0, arg_4_1)
		arg_1_0:setTargetPos(Vector2(0, 0))

		arg_1_0.dragActive = false
		arg_1_0.active = false

		if arg_1_0.activeCallback then
			arg_1_0.activeCallback(false)
		end

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

function var_0_0.setting(arg_7_0, arg_7_1)
	arg_7_0.smoothX = arg_7_1.smoothX
	arg_7_0.smoothY = arg_7_1.smoothY
	arg_7_0.maxDistance = arg_7_1.maxDistance
	arg_7_0.minDeadNum = arg_7_1.minDeadNum
	arg_7_0.maxDeadNum = arg_7_1.maxDeadNum

	return
end

function var_0_0.show(arg_8_0, arg_8_1)
	setActive(arg_8_0._tf, arg_8_1)

	return
end

function var_0_0.step(arg_9_0)
	arg_9_0.currentPos = arg_9_0._joyTf.anchoredPosition
	arg_9_0.currentX, arg_9_0.currentXSmooth = Mathf.SmoothDamp(arg_9_0.currentPos.x, arg_9_0.targetPos.x, arg_9_0.currentXSmooth, arg_9_0.smoothX)
	arg_9_0.currentY, arg_9_0.currentYSmooth = Mathf.SmoothDamp(arg_9_0.currentPos.y, arg_9_0.targetPos.y, arg_9_0.currentYSmooth, arg_9_0.smoothY)
	arg_9_0.currentPos.x = arg_9_0.currentX
	arg_9_0.currentPos.y = arg_9_0.currentY
	arg_9_0._joyTf.anchoredPosition = arg_9_0.currentPos
	arg_9_0.distanceRate = math.sqrt(math.pow(arg_9_0.currentX - arg_9_0.startPos.x, 2) + math.pow(arg_9_0.currentY - arg_9_0.startPos.y, 2)) / arg_9_0.maxDistance

	if math.abs(arg_9_0.currentY - arg_9_0.startPos.y) <= 1 and math.abs(arg_9_0.currentX - arg_9_0.startPos.x) <= 1 then
		arg_9_0.angle = nil
		arg_9_0.rad = nil
	else
		arg_9_0.rad = math.atan2(arg_9_0.currentY - arg_9_0.startPos.y, arg_9_0.currentX - arg_9_0.startPos.x)
		arg_9_0.angle = arg_9_0.rad * math.rad2Deg
	end

	arg_9_0.offsetX = arg_9_0.currentPos.x / arg_9_0.maxDistance
	arg_9_0.offsetY = arg_9_0.currentPos.y / arg_9_0.maxDistance

	if math.abs(arg_9_0.offsetX) > arg_9_0.minDeadNum then
		if arg_9_0.offsetX > 0 then
			arg_9_0.directX = 1
		elseif arg_9_0.offsetX < 0 then
			arg_9_0.directX = -1
		end
	else
		arg_9_0.directX = 0
		arg_9_0.offsetX = 0
	end

	if math.abs(arg_9_0.offsetY) > arg_9_0.minDeadNum then
		if arg_9_0.offsetY > 0 then
			arg_9_0.directY = 1
		elseif arg_9_0.offsetY < 0 then
			arg_9_0.directY = -1
		end
	else
		arg_9_0.directY = 0
		arg_9_0.offsetY = 0
	end

	if arg_9_0.valueCallback then
		arg_9_0.valueCallback(arg_9_0:getValue())
	end

	return
end

function var_0_0.setDirectTarget(arg_10_0, arg_10_1)
	if arg_10_0.dragActive then
		return
	end

	if arg_10_1.x ~= 0 or arg_10_1.y ~= 0 then
		if not arg_10_0.active then
			arg_10_0.active = true

			if arg_10_0.activeCallback then
				arg_10_0.activeCallback(true)
			end
		end

		arg_10_0:setTargetPos(Vector2(arg_10_1.x * 1000, arg_10_1.y * 1000))
	elseif arg_10_0.active then
		arg_10_0.active = false

		arg_10_0:setTargetPos(Vector2(0, 0))
	end

	return
end

function var_0_0.setValueCallback(arg_11_0, arg_11_1)
	arg_11_0.valueCallback = arg_11_1

	return
end

function var_0_0.setActiveCallback(arg_12_0, arg_12_1)
	arg_12_0.activeCallback = arg_12_1

	return
end

function var_0_0.getValue(arg_13_0)
	return {
		angle = arg_13_0.angle,
		rad = arg_13_0.rad,
		rate = arg_13_0.distanceRate,
		x = arg_13_0.offsetX,
		y = arg_13_0.offsetY,
		active = arg_13_0.active,
		directX = arg_13_0.directX,
		directY = arg_13_0.directY
	}
end

return var_0_0
