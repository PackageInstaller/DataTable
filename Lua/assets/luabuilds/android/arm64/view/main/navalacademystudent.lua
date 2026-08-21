local var_0_0 = class("NavalAcademyStudent")

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
	arg_2_0.chat = arg_2_0._tf:Find("chat")
	arg_2_0.chatFace = arg_2_0.chat:Find("face")
	arg_2_0.chatTask = arg_2_0.chat:Find("task")
	arg_2_0.chatFight = arg_2_0.chat:Find("fight")
	arg_2_0.clickArea = arg_2_0._tf:Find("click")

	setActive(arg_2_0.chat, true)
	setActive(arg_2_0.clickArea, true)

	return
end

function var_0_0.attach(arg_3_0)
	arg_3_0.exited = false

	setActive(arg_3_0._go, true)
	pg.DelegateInfo.New(arg_3_0)

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
		setActive(arg_6_0._go, false)

		return
	end

	setActive(arg_6_0._go, true)

	if arg_6_0.shipVO == nil or arg_6_0.shipVO.configId ~= arg_6_1.configId then
		if arg_6_0.model then
			arg_6_0.model:Dispose()
		end

		arg_6_0.prefab = arg_6_1:getPrefab()
		arg_6_0.currentPoint = arg_6_0.pathFinder:getRandomPoint()
		arg_6_0.targetPoint = arg_6_0.pathFinder:getPoint(arg_6_0.currentPoint.nexts[math.random(1, #arg_6_0.currentPoint.nexts)])
		arg_6_0._tf.anchoredPosition = Vector2.New(arg_6_0.currentPoint.x, arg_6_0.currentPoint.y)

		local var_6_0 = arg_6_0.prefab

		arg_6_0.model = SpineAnimChar.New()

		arg_6_0.model:SetPaint(arg_6_0.prefab)
		arg_6_0.model:Load(true, function(arg_7_0)
			if var_6_0 ~= arg_6_0.prefab then
				arg_7_0:Dispose()

				return
			end

			arg_6_0.model:SetLocalScale(Vector3(0.5, 0.5, 1))
			arg_6_0.model:SetLocalPosition(Vector3.zero)
			arg_6_0.model:SetParent(arg_6_0._tf)
			arg_6_0.model:SetSiblingIndex(1)
			arg_6_0:updateState(var_0_0.ShipState.Idle)
			onButton(arg_6_0, arg_6_0.chat, function()
				arg_6_0:onClickShip()

				return
			end)

			return
		end)
	end

	onButton(arg_6_0, arg_6_0.clickArea, function()
		if arg_6_0.model then
			arg_6_0:updateState(var_0_0.ShipState.Touch)
		end

		return
	end)

	arg_6_0.shipVO = arg_6_1
	arg_6_0.args = arg_6_2

	setActive(arg_6_0.chatFace, false)
	setActive(arg_6_0.chatTask, false)
	setActive(arg_6_0.chatFight, false)

	if arg_6_0.shipVO.withShipFace then
		if arg_6_2.showTips then
			setActive(arg_6_0.chatTask, true)
		elseif arg_6_2.currentTask and not arg_6_2.currentTask:isFinish() and arg_6_2.currentTask:getConfig("sub_type") == 29 then
			setActive(arg_6_0.chatFight, true)
		else
			setActive(arg_6_0.chatFace, true)
		end
	end

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
			arg_11_0.model:SetAction("walk", 0)
		elseif arg_11_0.state == var_0_0.ShipState.Idle then
			arg_11_0.model:SetAction("stand2", 0)
		elseif arg_11_0.state == var_0_0.ShipState.Touch then
			arg_11_0.model:SetAction("touch", 0)
			arg_11_0.model:SetActionCallBack(function(arg_12_0)
				arg_11_0:updateState(var_0_0.ShipState.Idle)

				return
			end)
		end
	end

	return
end

function var_0_0.updateLogic(arg_13_0)
	arg_13_0:clearLogic()

	if arg_13_0.state == var_0_0.ShipState.Walk then
		LeanTween.value(arg_13_0._go, 0, 1, Vector3.Distance(Vector3(arg_13_0._tf.anchoredPosition.x, arg_13_0._tf.anchoredPosition.y, 0), (Vector3(arg_13_0.targetPoint.x, arg_13_0.targetPoint.y, 0))) / arg_13_0.normalSpeed):setOnUpdate(System.Action_float(function(arg_14_0)
			arg_13_0._tf.anchoredPosition3D = Vector3.Lerp(var_0, var_0, arg_14_0)

			local var_14_0 = arg_13_0._tf.localScale
			local var_14_1 = arg_13_0.targetPoint.x > arg_13_0.currentPoint.x and 1 or -1

			var_14_0.x = arg_13_0.targetPoint.x > arg_13_0.currentPoint.x and 1 or -1
			arg_13_0._tf.localScale = var_14_0
			arg_13_0.chat.localScale.x = var_14_1
			arg_13_0.chat.localScale = arg_13_0.chat.localScale
			arg_13_0.chat.anchoredPosition.x = var_14_1 * math.abs(arg_13_0.chat.anchoredPosition.x)
			arg_13_0.chat.anchoredPosition = arg_13_0.chat.anchoredPosition

			return
		end)):setOnComplete(System.Action(function()
			arg_13_0.currentPoint = arg_13_0.targetPoint
			arg_13_0.targetPoint = arg_13_0.pathFinder:getPoint(arg_13_0.currentPoint.nexts[math.random(1, #arg_13_0.currentPoint.nexts)])

			arg_13_0:updateState(var_0_0.ShipState.Idle)

			return
		end))
	elseif arg_13_0.state == var_0_0.ShipState.Idle then
		arg_13_0.idleTimer = Timer.New(function()
			arg_13_0:updateState(var_0_0.ShipState.Walk)

			return
		end, math.random(10, 20), 1)

		arg_13_0.idleTimer:Start()
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
	LeanTween.cancel(arg_18_0._go)

	if arg_18_0.idleTimer then
		arg_18_0.idleTimer:Stop()

		arg_18_0.idleTimer = nil
	end

	return
end

function var_0_0.clear(arg_19_0)
	arg_19_0:clearLogic()

	if arg_19_0.model then
		arg_19_0.model:SetActionCallBack(nil)
		arg_19_0.model:SetLocalScale(Vector3.one)
		arg_19_0.model:Dispose()
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
		setActive(arg_20_0._go, false)
		pg.DelegateInfo.Dispose(arg_20_0)
		arg_20_0:clear()

		arg_20_0.exited = true
	end

	return
end

return var_0_0
