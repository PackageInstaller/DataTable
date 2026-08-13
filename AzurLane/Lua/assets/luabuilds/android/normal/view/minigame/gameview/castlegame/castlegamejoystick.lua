class = var_0_10000

local var_0_0 = var_0_10000("CastleGameJoyStick")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._tf = arg_1_1
	arg_1_0.smoothX = 0.02
	arg_1_0.smoothY = 0.02
	arg_1_0.maxDistance = 120
	arg_1_0.minDeadNum = 0.1
	arg_1_0.maxDeadNum = 0.9
	Vector2 = var_2
	arg_1_0.currentPos = var_2(0, 0)
	Vector2 = var_2
	arg_1_0.targetPos = var_2(0, 0)
	arg_1_0.currentX = 0
	arg_1_0.currentY = 0
	arg_1_0.currentXSmooth = 0
	arg_1_0.currentYSmooth = 0
	arg_1_0.active = false
	Vector2 = var_2
	arg_1_0.startPos = var_2(0, 0)
	Vector2 = var_2
	arg_1_0.dragPos = var_2(0, 0)
	GameObject = var_2

	local var_1_0 = var_2.Find("UICamera")

	arg_1_0.uiCam = var_2.GetComponent(var_1_0, "Camera")
	findTF = var_2
	arg_1_0._controlTf = var_2(arg_1_0._tf, "control")
	findTF = var_2
	arg_1_0._joyTf = var_2(arg_1_0._tf, "control/joy")
	GetComponent = var_2

	local var_1_1 = arg_1_0._controlTf

	typeof = var_4
	EventTriggerListener = var_1_10005
	arg_1_0._eventTriggerListener = var_2(var_1_1, var_4(var_1_10005))

	local var_1_2 = arg_1_0._eventTriggerListener

	var_2.AddPointDownFunc(var_1_2, function(arg_2_0, arg_2_1)
		arg_1_0.active = true

		local var_2_0 = arg_1_0

		Vector2 = var_3
		var_2_0.startPos = var_3(0, 0)

		return
	end)

	local var_1_3 = arg_1_0._eventTriggerListener

	var_2.AddDragFunc(var_1_3, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0.uiCam
		local var_3_1 = var_2.ScreenToWorldPoint(var_3_0, arg_3_1.position)
		local var_3_2 = arg_1_0
		local var_3_3 = arg_1_0._controlTf

		var_3_2.dragPos = var_4.InverseTransformPoint(var_3_3, var_3_1)

		local var_3_4 = arg_1_0
		local var_3_5 = var_3.setTargetPos
		local var_3_6 = arg_1_0

		var_3_5(var_3_4, var_5.getOffset(var_3_6, arg_1_0.dragPos, arg_1_0.startPos))

		return
	end)

	local var_1_4 = arg_1_0._eventTriggerListener

	var_2.AddPointUpFunc(var_1_4, function(arg_4_0, arg_4_1)
		arg_1_0.active = false

		local var_4_0 = arg_1_0
		local var_4_1 = var_2.setTargetPos

		Vector2 = var_2_10004

		var_4_1(var_4_0, var_2_10004(0, 0))

		return
	end)

	local var_1_5 = arg_1_0
	local var_1_6 = arg_1_0.setTargetPos

	Vector2 = var_4

	var_1_6(var_1_5, var_4(0, 0))

	return
end

function var_0_0.setTargetPos(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0.startPos

	math = var_1_10003

	local var_5_1 = var_1_10003.sqrt

	math = var_1_10004

	local var_5_2 = var_1_10004.pow(arg_5_1.x - var_5_0.x, 2)

	math = var_5

	local var_5_3 = var_5_1(var_5_2 + var_5.pow(arg_5_1.y - var_5_0.y, 2))

	if arg_5_0.maxDistance < var_5_3 then
		math = var_4

		local var_5_4 = var_4.atan

		math = var_5

		local var_5_5 = var_5.abs(arg_5_1.y - var_5_0.y)

		math = var_6

		local var_5_6 = var_5_4(var_5_5 / var_6.abs(arg_5_1.x - var_5_0.x))
		local var_5_7 = arg_5_1.x > var_5_0.x and 1 or -1
		local var_5_8 = arg_5_1.y
		local var_5_9 = var_5_0.y < var_5_8 and 1 or -1

		math = var_7

		local var_5_10 = var_7.cos(var_5_6) * var_5_7 * arg_5_0.maxDistance

		math = var_8

		local var_5_11 = var_8.sin(var_5_6) * var_5_9 * arg_5_0.maxDistance

		arg_5_0.targetPos.x = var_5_10
		arg_5_0.targetPos.y = var_5_11
	else
		arg_5_0.targetPos = arg_5_1
	end

	return
end

function var_0_0.getOffset(arg_6_0, arg_6_1, arg_6_2)
	Vector2 = var_1_10003

	return var_1_10003(arg_6_1.x - arg_6_2.x, arg_6_1.y - arg_6_2.y)
end

function var_0_0.show(arg_7_0, arg_7_1)
	setActive = var_1_10002

	var_1_10002(arg_7_0._tf, arg_7_1)

	return
end

function var_0_0.step(arg_8_0)
	arg_8_0.currentPos = arg_8_0._joyTf.anchoredPosition
	Mathf = var_1

	local var_8_0, var_8_1 = var_1.SmoothDamp(arg_8_0.currentPos.x, arg_8_0.targetPos.x, arg_8_0.currentXSmooth, arg_8_0.smoothX)

	arg_8_0.currentXSmooth = var_8_1
	arg_8_0.currentX = var_8_0
	Mathf = var_8_0
	arg_8_0.currentY, arg_8_0.currentYSmooth = var_8_0.SmoothDamp(arg_8_0.currentPos.y, arg_8_0.targetPos.y, arg_8_0.currentYSmooth, arg_8_0.smoothY)
	arg_8_0.currentPos.x = arg_8_0.currentX
	arg_8_0.currentPos.y = arg_8_0.currentY

	local var_8_2 = arg_8_0._joyTf

	var_8_2.anchoredPosition = arg_8_0.currentPos
	math = var_8_2

	local var_8_3 = var_8_2.sqrt

	math = var_2

	local var_8_4 = var_2.pow(arg_8_0.currentX - arg_8_0.startPos.x, 2)

	math = var_3
	arg_8_0.distanceRate = var_8_3(var_8_4 + var_3.pow(arg_8_0.currentY - arg_8_0.startPos.y, 2)) / arg_8_0.maxDistance
	math = var_1

	local var_8_5 = var_1.atan

	math = var_2

	local var_8_6 = var_2.abs(arg_8_0.currentY - arg_8_0.startPos.y)

	math = var_3
	arg_8_0.angle = var_8_5(var_8_6 / var_3.abs(arg_8_0.currentX - arg_8_0.startPos.x))
	arg_8_0.offsetX = arg_8_0.currentPos.x / arg_8_0.maxDistance
	arg_8_0.offsetY = arg_8_0.currentPos.y / arg_8_0.maxDistance

	if arg_8_0.callback then
		arg_8_0.callback(arg_8_0:getValue())
	end

	return
end

function var_0_0.setDirectTarget(arg_9_0, arg_9_1)
	if not arg_9_0.active then
		local var_9_0 = arg_9_0
		local var_9_1 = arg_9_0.setTargetPos

		Vector2 = var_1_10004

		var_9_1(var_9_0, var_1_10004(arg_9_1.x * 1000, arg_9_1.y * 1000))
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
