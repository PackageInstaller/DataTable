local var_0_0 = class("SummerFeastNavigationAgent", require("view.main.NavalAcademyStudent"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.onTransEdge = nil
	arg_1_0.needOneScale = arg_1_2

	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_0.init(arg_2_0)
	return
end

var_0_0.normalSpeed = 15
var_0_0.normalScale = 0.5
var_0_0.oneScale = 1

function var_0_0.SetOnTransEdge(arg_3_0, arg_3_1)
	arg_3_0.onTransEdge = arg_3_1

	return
end

function var_0_0.setCurrentIndex(arg_4_0, arg_4_1)
	if not arg_4_1 then
		return
	end

	arg_4_0.currentPoint = arg_4_0.pathFinder:getPoint(arg_4_1)

	return
end

function var_0_0.SetPositionTable(arg_5_0, arg_5_1)
	arg_5_0.posTable = arg_5_1

	return
end

function var_0_0.updateStudent(arg_6_0, arg_6_1)
	if arg_6_1 == nil or arg_6_1 == "" then
		setActive(arg_6_0._go, false)

		return
	end

	setActive(arg_6_0._go, true)

	if arg_6_0.prefabName ~= arg_6_1 then
		if arg_6_0.model then
			arg_6_0.model:Dispose()
		end

		arg_6_0.prefab = arg_6_1
		arg_6_0.currentPoint = arg_6_0.currentPoint or arg_6_0.pathFinder:getRandomPoint()
		arg_6_0.targetPoint = arg_6_0.currentPoint
		arg_6_0._tf.anchoredPosition = arg_6_0.currentPoint

		if arg_6_0.onTransEdge then
			arg_6_0:onTransEdge(arg_6_0.currentPoint.id, arg_6_0.currentPoint.id)
		end

		local var_6_0 = arg_6_0.prefab

		arg_6_0.model = SpineAnimChar.New()

		arg_6_0.model:SetPaint(var_6_0)
		arg_6_0.model:Load(true, function(arg_7_0)
			if var_6_0 ~= arg_6_0.prefab then
				arg_7_0:Dispose()

				return
			end

			arg_6_0.model:SetLocalScale(Vector3(0.5, 0.5, 1))
			arg_6_0.model:SetLocalPosition(Vector3.zero)
			arg_6_0.model:SetParent(arg_6_0._tf)
			arg_6_0:updateState(var_0_0.ShipState.Idle)

			return
		end)
	end

	arg_6_0.prefabName = arg_6_1

	return
end

function var_0_0.updateLogic(arg_8_0)
	arg_8_0:clearLogic()

	if arg_8_0.state == var_0_0.ShipState.Walk then
		local var_8_0 = arg_8_0.currentPoint
		local var_8_1 = arg_8_0.targetPoint

		if arg_8_0.posTable[arg_8_0.currentPoint.id] == arg_8_0 then
			arg_8_0.posTable[arg_8_0.currentPoint.id] = nil
		end

		local var_8_2 = arg_8_0.currentPoint.scale or var_0_0.normalScale

		if arg_8_0.needOneScale then
			var_8_2 = arg_8_0.oneScale
		end

		arg_8_0._tf.localScale = var_8_2 * Vector2.one

		local var_8_3 = arg_8_0.pathFinder:getEdge(arg_8_0.currentPoint, arg_8_0.targetPoint)

		LeanTween.value(arg_8_0._go, 0, 1, Vector2.Distance(arg_8_0.currentPoint, arg_8_0.targetPoint) / arg_8_0.normalSpeed):setOnUpdate(System.Action_float(function(arg_9_0)
			arg_8_0._tf.anchoredPosition = var_8_3 and var_8_3.bezier_control_point and var_0_0.GetBeziersPoints(var_8_0, var_8_1, arg_8_0.pathFinder:getPoint(var_8_3.bezier_control_point), arg_9_0) or Vector2.Lerp(var_8_0, var_8_1, arg_9_0)

			local var_9_1 = var_8_0.scale or var_0_0.normalScale
			local var_9_2 = var_8_1.scale or var_0_0.normalScale
			local var_9_3 = math.lerp(var_9_1, var_9_2, arg_9_0) * Vector2.one
			local var_9_4 = var_8_1.x > var_8_0.x and 1 or -1

			if var_8_0.id == var_8_1.id then
				var_9_4 = math.random(0, 1) == 1 and 1 or -1
			end

			if var_8_0.fixedDirection then
				var_9_4 = math.sign(var_8_0.fixedDirection)
			end

			if arg_8_0.needOneScale then
				var_9_3 = arg_8_0.oneScale * Vector2.one
			end

			var_9_3.x = math.abs(var_9_3.x) * var_9_4
			arg_8_0._tf.localScale = var_9_3

			return
		end)):setOnComplete(System.Action(function()
			arg_8_0.currentPoint = arg_8_0.targetPoint

			local var_10_0 = arg_8_0.currentPoint.nexts[math.random(1, #arg_8_0.currentPoint.nexts)]

			if arg_8_0.onTransEdge and var_10_0 then
				arg_8_0.targetPoint = arg_8_0.pathFinder:getPoint(var_10_0)

				arg_8_0:onTransEdge(arg_8_0.currentPoint.id, var_10_0)
			end

			arg_8_0:updateState(var_0_0.ShipState.Idle)

			return
		end))
	elseif arg_8_0.state == var_0_0.ShipState.Idle then
		if arg_8_0.posTable[arg_8_0.currentPoint.id] == nil then
			arg_8_0.posTable[arg_8_0.currentPoint.id] = arg_8_0
		else
			arg_8_0:updateState(var_0_0.ShipState.Walk)

			return
		end

		if arg_8_0.currentPoint.isBan then
			arg_8_0:updateState(var_0_0.ShipState.Walk)

			return
		end

		arg_8_0.idleTimer = Timer.New(function()
			arg_8_0:updateState(var_0_0.ShipState.Walk)

			return
		end, math.random(10, 20), 1)

		arg_8_0.idleTimer:Start()
	elseif arg_8_0.state == var_0_0.ShipState.Touch then
		arg_8_0:onClickShip()
	end

	return
end

function var_0_0.GetBeziersPoints(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_9001
	local var_12_9000
	local var_12_0 = arg_12_0:Clone()
	local var_12_1 = arg_12_2:Clone()

	return var_12_0.Mul(var_12_9001, (1 - arg_12_3) * (1 - arg_12_3)):Add((var_12_1.Mul(var_12_9000, 2 * arg_12_3 * (1 - arg_12_3)))).Add(var_12_1, (arg_12_1:Clone().Mul(var_12_0, arg_12_3 * arg_12_3)))
end

return var_0_0
