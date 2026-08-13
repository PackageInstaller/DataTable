class = var_0_10000

local var_0_0 = var_0_10000("NavalAcademyStudent")

var_0_0.ShipState = {
	Touch = "Touch",
	Idle = "Idle",
	Walk = "Walk"
}
var_0_0.normalSpeed = 15

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform

	arg_1_0:init()

	return
end

function var_0_0.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.chat = var_1.Find(var_2_0, "chat")

	local var_2_1 = arg_2_0.chat

	arg_2_0.chatFace = var_1.Find(var_2_1, "face")

	local var_2_2 = arg_2_0.chat

	arg_2_0.chatTask = var_1.Find(var_2_2, "task")

	local var_2_3 = arg_2_0.chat

	arg_2_0.chatFight = var_1.Find(var_2_3, "fight")

	local var_2_4 = arg_2_0._tf

	arg_2_0.clickArea = var_1.Find(var_2_4, "click")
	setActive = var_1

	var_1(arg_2_0.chat, true)

	setActive = var_1

	var_1(arg_2_0.clickArea, true)

	return
end

function var_0_0.attach(arg_3_0)
	arg_3_0.exited = false
	setActive = var_1

	var_1(arg_3_0._go, true)

	pg = var_1

	var_1.DelegateInfo.New(arg_3_0)

	return
end

function var_0_0.setPathFinder(arg_4_0, arg_4_1)
	arg_4_0.pathFinder = arg_4_1

	return
end

function var_0_0.setCallBack(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.onStateChange = arg_5_1
	arg_5_0.onTask = arg_5_2

	return
end

function var_0_0.updateStudent(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1.hide then
		setActive = var_3

		var_3(arg_6_0._go, false)

		return
	end

	setActive = var_3

	var_3(arg_6_0._go, true)

	local var_6_2

	if arg_6_0.shipVO == nil or arg_6_0.shipVO.configId ~= arg_6_1.configId then
		if arg_6_0.model then
			local var_6_0 = arg_6_0.model

			var_6_2.Dispose(var_6_0)
		end

		arg_6_0.prefab = arg_6_1:getPrefab()

		local var_6_1 = arg_6_0.pathFinder

		arg_6_0.currentPoint = var_6_2.getRandomPoint(var_6_1)
		var_6_2 = arg_6_0.currentPoint.nexts
		math = var_1_10004

		local var_6_3 = var_6_2[var_1_10004.random(1, #var_6_2)]
		local var_6_4 = arg_6_0.pathFinder

		arg_6_0.targetPoint = var_5.getPoint(var_6_4, var_6_3)

		local var_6_5 = arg_6_0._tf

		Vector2 = var_6
		var_6_5.anchoredPosition = var_6.New(arg_6_0.currentPoint.x, arg_6_0.currentPoint.y)

		local var_6_6 = arg_6_0.prefab

		SpineAnimChar = var_6
		arg_6_0.model = var_6.New()

		local var_6_7 = arg_6_0.model

		var_6.SetPaint(var_6_7, var_6_6)

		local var_6_8 = arg_6_0.model

		var_6.Load(var_6_8, true, function(arg_7_0)
			if var_6_6 ~= arg_6_0.prefab then
				arg_7_0:Dispose()

				return
			end

			local var_7_0 = arg_6_0.model
			local var_7_1 = var_1.SetLocalScale

			Vector3 = var_2_10004

			var_7_1(var_7_0, var_2_10004(0.5, 0.5, 1))

			local var_7_2 = arg_6_0.model
			local var_7_3 = var_1.SetLocalPosition

			Vector3 = var_4

			var_7_3(var_7_2, var_4.zero)

			local var_7_4 = arg_6_0.model

			var_1.SetParent(var_7_4, arg_6_0._tf)

			local var_7_5 = arg_6_0.model

			var_1.SetSiblingIndex(var_7_5, 1)

			local var_7_6 = arg_6_0

			var_1.updateState(var_7_6, var_0_0.ShipState.Idle)

			onButton = var_1

			var_1(arg_6_0, arg_6_0.chat, function()
				local var_8_0 = arg_6_0

				var_0.onClickShip(var_8_0)

				return
			end)

			return
		end)
	end

	onButton = var_6_2

	var_6_2(arg_6_0, arg_6_0.clickArea, function()
		if arg_6_0.model then
			local var_9_0 = arg_6_0

			var_0.updateState(var_9_0, var_0_0.ShipState.Touch)
		end

		return
	end)

	arg_6_0.shipVO = arg_6_1
	arg_6_0.args = arg_6_2
	setActive = var_6_2

	var_6_2(arg_6_0.chatFace, false)

	setActive = var_6_2

	var_6_2(arg_6_0.chatTask, false)

	setActive = var_6_2

	var_6_2(arg_6_0.chatFight, false)

	if arg_6_0.shipVO.withShipFace then
		if arg_6_2.showTips then
			setActive = var_3

			var_3(arg_6_0.chatTask, true)
		else
			if arg_6_2.currentTask then
				local var_6_9 = arg_6_2.currentTask

				if not var_3.isFinish(var_6_9) then
					local var_6_10 = arg_6_2.currentTask

					if var_3.getConfig(var_6_10, "sub_type") == 29 then
						setActive = var_3

						var_3(arg_6_0.chatFight, true)

						goto label_6_0
					end
				end
			end

			setActive = var_3

			var_3(arg_6_0.chatFace, true)
		end
	end

	::label_6_0::

	return
end

function var_0_0.updateState(arg_10_0, arg_10_1)
	if arg_10_0.state ~= arg_10_1 then
		arg_10_0.state = arg_10_1

		arg_10_0:updateAction()
		arg_10_0:updateLogic()

		if arg_10_0.onStateChange then
			arg_10_0.onStateChange(arg_10_0.state)
		end
	end

	return
end

function var_0_0.updateAction(arg_11_0)
	if arg_11_0.model then
		if arg_11_0.state == var_0_0.ShipState.Walk then
			local var_11_0 = arg_11_0.model

			var_1.SetAction(var_11_0, "walk", 0)
		elseif arg_11_0.state == var_0_0.ShipState.Idle then
			local var_11_1 = arg_11_0.model

			var_1.SetAction(var_11_1, "stand2", 0)
		elseif arg_11_0.state == var_0_0.ShipState.Touch then
			local var_11_2 = arg_11_0.model

			var_1.SetAction(var_11_2, "touch", 0)

			local var_11_3 = arg_11_0.model

			var_1.SetActionCallBack(var_11_3, function(arg_12_0)
				local var_12_0 = arg_11_0

				var_1.updateState(var_12_0, var_0_0.ShipState.Idle)

				return
			end)
		end
	end

	return
end

function var_0_0.updateLogic(arg_13_0)
	arg_13_0:clearLogic()

	if arg_13_0.state == var_0_0.ShipState.Walk then
		Vector3 = var_1

		local var_13_0 = var_1(arg_13_0._tf.anchoredPosition.x, arg_13_0._tf.anchoredPosition.y, 0)

		Vector3 = var_2

		local var_13_1 = var_2(arg_13_0.targetPoint.x, arg_13_0.targetPoint.y, 0)
		local var_13_2 = arg_13_0.normalSpeed

		Vector3 = var_1_10004
		var_1_10004 = var_1_10004.Distance(var_13_0, var_13_1) / var_13_2
		LeanTween = var_5

		local var_13_3 = var_5.value(arg_13_0._go, 0, 1, var_1_10004)
		local var_13_4 = var_5.setOnUpdate

		System = var_8

		local var_13_5 = var_13_4(var_13_3, var_8.Action_float(function(arg_14_0)
			local var_14_0 = arg_13_0._tf

			Vector3 = var_2_10002
			var_14_0.anchoredPosition3D = var_2_10002.Lerp(var_13_0, var_13_1, arg_14_0)

			local var_14_1 = arg_13_0._tf.localScale

			var_14_1.x = arg_13_0.targetPoint.x > arg_13_0.currentPoint.x and 1 or -1
			arg_13_0._tf.localScale = var_14_1

			local var_14_2 = arg_13_0.chat.localScale

			var_14_2.x = var_2
			arg_13_0.chat.localScale = var_14_2

			local var_14_3 = arg_13_0.chat.anchoredPosition

			math = var_5
			var_14_3.x = var_2 * var_5.abs(var_14_3.x)
			arg_13_0.chat.anchoredPosition = var_14_3

			return
		end))
		local var_13_6 = var_5.setOnComplete

		System = var_8

		var_13_6(var_13_5, var_8.Action(function()
			arg_13_0.currentPoint = arg_13_0.targetPoint

			local var_15_0 = arg_13_0.currentPoint.nexts

			math = var_1

			local var_15_1 = var_15_0[var_1.random(1, #var_15_0)]
			local var_15_2 = arg_13_0
			local var_15_3 = arg_13_0.pathFinder

			var_15_2.targetPoint = var_3.getPoint(var_15_3, var_15_1)

			local var_15_4 = arg_13_0

			var_2.updateState(var_15_4, var_0_0.ShipState.Idle)

			return
		end))
	elseif arg_13_0.state == var_0_0.ShipState.Idle then
		Timer = var_1

		local var_13_7 = var_1.New

		local function var_13_8()
			local var_16_0 = arg_13_0

			var_0.updateState(var_16_0, var_0_0.ShipState.Walk)

			return
		end

		math = var_1_10004
		arg_13_0.idleTimer = var_13_7(var_13_8, var_1_10004.random(10, 20), 1)

		local var_13_9 = arg_13_0.idleTimer

		var_1.Start(var_13_9)
	elseif arg_13_0.state == var_0_0.ShipState.Touch then
		arg_13_0:onClickShip()
	end

	return
end

function var_0_0.onClickShip(arg_17_0)
	if arg_17_0.onTask then
		arg_17_0.onTask(arg_17_0.acceptTaskId, arg_17_0.currentTask)
	end

	return
end

function var_0_0.clearLogic(arg_18_0)
	LeanTween = var_1_10001

	var_1_10001.cancel(arg_18_0._go)

	if arg_18_0.idleTimer then
		local var_18_0 = arg_18_0.idleTimer

		var_1.Stop(var_18_0)

		arg_18_0.idleTimer = nil
	end

	return
end

function var_0_0.clear(arg_19_0)
	arg_19_0:clearLogic()

	if arg_19_0.model then
		local var_19_0 = arg_19_0.model

		var_1.SetActionCallBack(var_19_0, nil)

		local var_19_1 = arg_19_0.model
		local var_19_2 = var_1.SetLocalScale

		Vector3 = var_4

		var_19_2(var_19_1, var_4.one)

		local var_19_3 = arg_19_0.model

		var_1.Dispose(var_19_3)
	end

	arg_19_0.shipVO = nil
	arg_19_0.prefab = nil
	arg_19_0.model = nil
	arg_19_0.position = nil
	arg_19_0.currentPoint = nil
	arg_19_0.targetPoint = nil
	arg_19_0.state = nil

	return
end

function var_0_0.detach(arg_20_0)
	if not arg_20_0.exited then
		setActive = var_1

		var_1(arg_20_0._go, false)

		pg = var_1

		var_1.DelegateInfo.Dispose(arg_20_0)
		arg_20_0:clear()

		arg_20_0.exited = true
	end

	return
end

return var_0_0
