class = var_0_10000

local var_0_0 = "SummerFeastNavigationAgent"

require = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.main.NavalAcademyStudent"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.onTransEdge = nil
	arg_1_0.needOneScale = arg_1_2

	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_1.init(arg_2_0)
	return
end

var_0_1.normalSpeed = 15
var_0_1.normalScale = 0.5
var_0_1.oneScale = 1

function var_0_1.SetOnTransEdge(arg_3_0, arg_3_1)
	arg_3_0.onTransEdge = arg_3_1

	return
end

function var_0_1.setCurrentIndex(arg_4_0, arg_4_1)
	if not arg_4_1 then
		return
	end

	local var_4_0 = arg_4_0.pathFinder

	arg_4_0.currentPoint = var_2.getPoint(var_4_0, arg_4_1)

	return
end

function var_0_1.SetPositionTable(arg_5_0, arg_5_1)
	arg_5_0.posTable = arg_5_1

	return
end

function var_0_1.updateStudent(arg_6_0, arg_6_1)
	if arg_6_1 == nil or arg_6_1 == "" then
		setActive = var_1_10002

		var_1_10002(arg_6_0._go, false)

		return
	end

	setActive = var_1_10002

	var_1_10002(arg_6_0._go, true)

	if arg_6_0.prefabName ~= arg_6_1 then
		if arg_6_0.model then
			local var_6_0 = arg_6_0.model

			var_2.Dispose(var_6_0)
		end

		arg_6_0.prefab = arg_6_1

		local var_6_2

		if not arg_6_0.currentPoint then
			local var_6_1 = arg_6_0.pathFinder

			var_6_2 = var_2.getRandomPoint(var_6_1)
		end

		arg_6_0.currentPoint = var_6_2
		arg_6_0.targetPoint = arg_6_0.currentPoint

		local var_6_3 = arg_6_0.currentPoint.id

		arg_6_0._tf.anchoredPosition = arg_6_0.currentPoint

		if arg_6_0.onTransEdge then
			arg_6_0.onTransEdge(arg_6_0, var_6_3, var_6_3)
		end

		local var_6_4 = arg_6_0.prefab

		SpineAnimChar = var_4
		arg_6_0.model = var_4.New()

		local var_6_5 = arg_6_0.model

		var_4.SetPaint(var_6_5, var_6_4)

		local var_6_6 = arg_6_0.model

		var_4.Load(var_6_6, true, function(arg_7_0)
			if var_6_4 ~= arg_6_0.prefab then
				arg_7_0:Dispose()

				return
			end

			local var_7_0 = arg_6_0.model
			local var_7_1 = var_1.SetLocalScale

			Vector3 = var_2_10003

			var_7_1(var_7_0, var_2_10003(0.5, 0.5, 1))

			local var_7_2 = arg_6_0.model
			local var_7_3 = var_1.SetLocalPosition

			Vector3 = var_3

			var_7_3(var_7_2, var_3.zero)

			local var_7_4 = arg_6_0.model

			var_1.SetParent(var_7_4, arg_6_0._tf)

			local var_7_5 = arg_6_0

			var_1.updateState(var_7_5, var_0_1.ShipState.Idle)

			return
		end)
	end

	arg_6_0.prefabName = arg_6_1

	return
end

function var_0_1.updateLogic(arg_8_0)
	arg_8_0:clearLogic()

	if arg_8_0.state == var_0_1.ShipState.Walk then
		local var_8_0 = arg_8_0.currentPoint
		local var_8_1 = arg_8_0.targetPoint
		local var_8_2 = arg_8_0.normalSpeed

		Vector2 = var_1_10004

		local var_8_3 = var_1_10004.Distance(var_8_0, var_8_1) / var_8_2

		if arg_8_0.posTable[arg_8_0.currentPoint.id] == arg_8_0 then
			arg_8_0.posTable[arg_8_0.currentPoint.id] = nil
		end

		local var_8_4

		if not var_8_0.scale then
			var_8_4 = var_0_1.normalScale
		end

		if arg_8_0.needOneScale then
			var_8_4 = arg_8_0.oneScale
		end

		local var_8_5 = arg_8_0._tf

		Vector2 = var_1_10007
		var_8_5.localScale = var_8_4 * var_1_10007.one

		local var_8_6 = arg_8_0.pathFinder
		local var_8_7 = var_6.getEdge(var_8_6, var_8_0, var_8_1)

		LeanTween = var_8_6

		local var_8_8 = var_8_6.value(arg_8_0._go, 0, 1, var_8_3)
		local var_8_9 = var_7.setOnUpdate

		System = var_9

		local var_8_10 = var_8_9(var_8_8, var_9.Action_float(function(arg_9_0)
			local var_9_0
			local var_9_2

			if var_8_7 and var_8_7.bezier_control_point then
				local var_9_1 = arg_8_0.pathFinder

				var_9_2 = var_9_2.getPoint(var_9_1, var_8_7.bezier_control_point)
				var_9_0 = var_0_1.GetBeziersPoints(var_8_0, var_8_1, var_9_2, arg_9_0)
			else
				Vector2 = var_9_2
				var_9_0 = var_9_2.Lerp(var_8_0, var_8_1, arg_9_0)
			end

			local var_9_3 = arg_8_0._tf

			var_9_3.anchoredPosition = var_9_0
			math = var_9_3

			local var_9_4 = var_9_3.lerp
			local var_9_5

			if not var_8_0.scale then
				var_9_5 = var_0_1.normalScale
			end

			local var_9_6

			if not var_8_1.scale then
				var_9_6 = var_0_1.normalScale
			end

			local var_9_7 = var_9_4(var_9_5, var_9_6, arg_9_0)

			Vector2 = var_9_5

			local var_9_8 = var_9_7 * var_9_5.one
			local var_9_9 = var_8_1.x > var_8_0.x and 1 or -1

			if var_8_0.id == var_8_1.id then
				math = var_4
				var_9_9 = var_4.random(0, 1) == 1 and 1 or -1
			end

			if var_8_0.fixedDirection then
				math = var_4
				var_9_9 = var_4.sign(var_8_0.fixedDirection)
			end

			local var_9_10

			if arg_8_0.needOneScale then
				var_9_10 = arg_8_0.oneScale
				Vector2 = var_5
				var_9_8 = var_9_10 * var_5.one
			end

			math = var_9_10
			var_9_8.x = var_9_10.abs(var_9_8.x) * var_9_9
			arg_8_0._tf.localScale = var_9_8

			return
		end))
		local var_8_11 = var_7.setOnComplete

		System = var_9

		var_8_11(var_8_10, var_9.Action(function()
			arg_8_0.currentPoint = arg_8_0.targetPoint

			local var_10_0 = arg_8_0.currentPoint.id
			local var_10_1 = arg_8_0.currentPoint.nexts

			math = var_2_10002

			local var_10_2 = var_10_1[var_2_10002.random(1, #var_10_1)]

			if arg_8_0.onTransEdge and var_10_2 then
				local var_10_3 = arg_8_0
				local var_10_4 = arg_8_0.pathFinder

				var_10_3.targetPoint = var_4.getPoint(var_10_4, var_10_2)

				arg_8_0.onTransEdge(arg_8_0, var_10_0, var_10_2)
			end

			local var_10_5 = arg_8_0

			var_3.updateState(var_10_5, var_0_1.ShipState.Idle)

			return
		end))
	elseif arg_8_0.state == var_0_1.ShipState.Idle then
		if arg_8_0.posTable[arg_8_0.currentPoint.id] == nil then
			arg_8_0.posTable[arg_8_0.currentPoint.id] = arg_8_0
		else
			arg_8_0:updateState(var_0_1.ShipState.Walk)

			return
		end

		if arg_8_0.currentPoint.isBan then
			arg_8_0:updateState(var_0_1.ShipState.Walk)

			return
		end

		math = var_1

		local var_8_12 = var_1.random(10, 20)

		Timer = var_2
		arg_8_0.idleTimer = var_2.New(function()
			local var_11_0 = arg_8_0

			var_0.updateState(var_11_0, var_0_1.ShipState.Walk)

			return
		end, var_8_12, 1)

		local var_8_13 = arg_8_0.idleTimer

		var_2.Start(var_8_13)
	elseif arg_8_0.state == var_0_1.ShipState.Touch then
		arg_8_0:onClickShip()
	end

	return
end

function var_0_1.GetBeziersPoints(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = arg_12_0:Clone()
	local var_12_1 = var_4.Mul(var_12_0, (1 - arg_12_3) * (1 - arg_12_3))
	local var_12_2 = arg_12_2:Clone()
	local var_12_3 = var_5.Mul(var_12_2, 2 * arg_12_3 * (1 - arg_12_3))
	local var_12_4 = arg_12_1:Clone()
	local var_12_5 = var_6.Mul(var_12_4, arg_12_3 * arg_12_3)
	local var_12_6 = var_12_1:Add(var_12_3)

	return var_7.Add(var_12_6, var_12_5)
end

return var_0_1
