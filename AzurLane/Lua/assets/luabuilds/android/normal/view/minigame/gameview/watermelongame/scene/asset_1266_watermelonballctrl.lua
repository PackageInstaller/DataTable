class = var_0_10000

local var_0_0 = var_0_10000("WatermelonBallCtrl")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._content = arg_1_1
	arg_1_0._contextData = arg_1_2
	arg_1_0._event = arg_1_3
	findTF = var_1_10004
	arg_1_0._startPos = var_1_10004(arg_1_0._content, "start_pos")
	findTF = var_4
	arg_1_0._rayTf = var_4(arg_1_0._startPos, "ray")
	findTF = var_4
	arg_1_0._left = var_4(arg_1_0._content, "left")
	findTF = var_4
	arg_1_0._right = var_4(arg_1_0._content, "right")
	findTF = var_4
	arg_1_0._container = var_4(arg_1_0._content, "container")
	findTF = var_4
	arg_1_0._megerEffect = var_4(arg_1_0._content, "meger_effect")

	if arg_1_0._megerEffect then
		setActive = var_4

		var_4(arg_1_0._megerEffect, false)
	end

	findTF = var_4
	arg_1_0._tempRect = var_4(arg_1_0._container, "temp_rect")
	arg_1_0.leftPos = arg_1_0._left.anchoredPosition.x
	arg_1_0.rightPos = arg_1_0._right.anchoredPosition.x
	arg_1_0._balls = {}
	LayerMask = var_4
	arg_1_0._layerMask = var_4.GetMask("UI")
	print = var_4

	var_4("log ball ctrl init complete")

	return
end

function var_0_0.setGameVo(arg_2_0, arg_2_1)
	arg_2_0._gameVo = arg_2_1

	return
end

function var_0_0.start(arg_3_0)
	arg_3_0:clear()

	arg_3_0.createBallCd = 0
	arg_3_0.nextBallId = nil

	return
end

function var_0_0.step(arg_4_0, arg_4_1)
	if not arg_4_0.nextBallId then
		var_1_10003 = arg_4_0
		arg_4_0.nextBallId = arg_4_0.getRandomIdByWeight(var_1_10003)
		var_1_10003 = arg_4_0._event

		local var_4_0 = var_2.emit

		WatermelonGameEvent = var_1_10004

		var_4_0(var_1_10003, var_1_10004.UPDATE_NEXT_BALL, arg_4_0.nextBallId)
	end

	if not arg_4_0.readyBall then
		if not arg_4_0.createBallCd then
			var_1_10003 = arg_4_0

			arg_4_0.setCreateCd(var_1_10003)
		end

		if arg_4_0.createBallCd then
			local var_4_1 = arg_4_0.createBallCd

			if 0 <= var_4_1 then
				arg_4_0.createBallCd = arg_4_0.createBallCd - arg_4_0._gameVo.deltaTime

				if arg_4_0.createBallCd <= 0 then
					arg_4_0.createBallCd = nil
					var_1_10003 = arg_4_0

					arg_4_0.createReadyBall(var_1_10003)
				end
			end
		end
	else
		local var_4_2 = arg_4_0.readyBall.tf

		var_4_2.anchoredPosition = arg_4_0._startPos.anchoredPosition
		Physics2D = var_4_2

		local var_4_3 = var_4_2.Raycast

		var_1_10003 = arg_4_0._startPos.position
		Vector2 = var_1_10004

		if var_4_3(var_1_10003, var_1_10004(0, -1)) and var_2.transform then
			var_1_10005 = arg_4_0._startPos

			local var_4_4 = var_4.InverseTransformPoint

			Vector2 = var_6

			local var_4_5 = var_4_4(var_1_10005, var_6(var_2.point.x, var_2.point.y, 0))

			var_1_10005 = arg_4_0._rayTf
			Vector2 = var_6

			local var_4_6 = arg_4_0._rayTf.sizeDelta.x

			math = var_8
			var_1_10005.sizeDelta = var_6(var_4_6, var_8.abs(var_4_5.y))
		end
	end

	local var_4_7 = arg_4_0.readyBall and true or false

	isActive = var_1_10003

	if var_1_10003(arg_4_0._rayTf) ~= var_4_7 then
		setActive = var_3

		var_3(arg_4_0._rayTf, var_4_7)
	end

	if arg_4_0.tickToOver then
		arg_4_0.tickToOver = arg_4_0.tickToOver - arg_4_1

		if arg_4_0.tickToOver and arg_4_0.tickToOver <= 0 then
			local var_4_8 = arg_4_0._event
			local var_4_9 = var_3.emit

			WatermelonGameEvent = var_1_10005

			var_4_9(var_4_8, var_1_10005.GAME_OVER, true)

			arg_4_0.tickToOver = nil
		end
	end

	return
end

function var_0_0.clear(arg_5_0)
	WatermelonGameConst = var_1_10001
	arg_5_0.countId = var_1_10001.ball_count_id
	arg_5_0.tickToOver = nil

	if arg_5_0._megerEffect then
		setActive = var_1

		var_1(arg_5_0._megerEffect, false)
	end

	arg_5_0:clearBallContainer()

	return
end

function var_0_0.stop(arg_6_0)
	return
end

function var_0_0.resume(arg_7_0)
	return
end

function var_0_0.dispose(arg_8_0)
	return
end

function var_0_0.moveWorld(arg_9_0, arg_9_1)
	if arg_9_0.readyBall then
		local var_9_0 = arg_9_0._content

		if var_2.InverseTransformPoint(var_9_0, arg_9_1.pos).x < arg_9_0.leftPos + arg_9_0.readyBall.size then
			var_2.x = arg_9_0.leftPos + arg_9_0.readyBall.size
		else
			local var_9_1 = var_2.x

			if arg_9_0.rightPos - arg_9_0.readyBall.size < var_9_1 then
				var_2.x = arg_9_0.rightPos - arg_9_0.readyBall.size
			end
		end

		local var_9_2 = arg_9_0._startPos

		Vector2 = var_4
		var_9_2.anchoredPosition = var_4(var_2.x, arg_9_0._startPos.anchoredPosition.y)

		if arg_9_1.callback then
			arg_9_1.callback(true)
		end
	elseif arg_9_1.callback then
		arg_9_1.callback(false)
	end

	return
end

function var_0_0.move(arg_10_0, arg_10_1)
	if not arg_10_0.readyBall then
		return
	end

	local var_10_0 = arg_10_0._startPos.anchoredPosition

	if arg_10_1 > 0 then
		var_10_0.x = var_10_0.x + arg_10_0._gameVo.deltaTime * 300
	elseif arg_10_1 < 0 then
		var_10_0.x = var_10_0.x - arg_10_0._gameVo.deltaTime * 300
	end

	if var_10_0.x < arg_10_0.leftPos + arg_10_0.readyBall.size then
		var_10_0.x = arg_10_0.leftPos + arg_10_0.readyBall.size
	elseif var_10_0.x > arg_10_0.rightPos - arg_10_0.readyBall.size then
		var_10_0.x = arg_10_0.rightPos - arg_10_0.readyBall.size
	end

	arg_10_0._startPos.anchoredPosition = var_10_0

	return
end

function var_0_0.dropBall(arg_11_0)
	if arg_11_0.readyBall then
		arg_11_0:setBallPhysics(arg_11_0.readyBall, true)

		table = var_1

		var_1.insert(arg_11_0._balls, arg_11_0.readyBall)

		arg_11_0.readyBall = nil

		arg_11_0:setCreateCd()
	end

	return
end

function var_0_0.createReadyBall(arg_12_0)
	local var_12_0 = arg_12_0._gameVo
	local var_12_1, var_12_2 = var_1.getTplItemFromPool(var_12_0, "ball", arg_12_0._container)
	local var_12_3 = arg_12_0._startPos

	Vector2 = var_4
	var_12_3.anchoredPosition = var_4(0, arg_12_0._startPos.anchoredPosition.y)
	var_12_1.anchoredPosition = arg_12_0._startPos.anchoredPosition

	local var_12_4 = arg_12_0:initBallData(var_12_1, arg_12_0.nextBallId)

	arg_12_0.nextBallId = nil
	arg_12_0.readyBall = var_12_4

	arg_12_0:setBallEvent(var_12_4)
	arg_12_0:setBallPhysics(arg_12_0.readyBall, false)

	return
end

function var_0_0.createMegerBall(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_0._gameVo
	local var_13_1, var_13_2 = var_3.getTplItemFromPool(var_13_0, "ball", arg_13_0._container)

	Vector3 = var_5
	var_13_1.position = var_5(arg_13_2.x, arg_13_2.y, 0)

	if arg_13_0._megerEffect then
		local var_13_3 = arg_13_0._megerEffect

		var_13_3.position = var_13_1.position
		setActive = var_13_3

		var_13_3(arg_13_0._megerEffect, false)

		setActive = var_13_3

		var_13_3(arg_13_0._megerEffect, true)
	end

	local var_13_4 = arg_13_0:initBallData(var_13_1, arg_13_1)

	arg_13_0:setBallEvent(var_13_4)

	table = var_6

	var_6.insert(arg_13_0._balls, var_13_4)

	return
end

function var_0_0.setBallEvent(arg_14_0, arg_14_1)
	GetComponent = var_1_10002
	arg_14_0.physics2DItem = var_1_10002(arg_14_1.tf, "Physics2DItem")

	local var_14_0 = arg_14_0.physics2DItem.CollisionEnter

	var_2.AddListener(var_14_0, function(arg_15_0)
		local var_15_0 = arg_14_0

		var_1.checkCollisionBall(var_15_0, arg_15_0)

		return
	end)

	local var_14_1 = arg_14_0.physics2DItem.TriggerEnter

	var_2.AddListener(var_14_1, function(arg_16_0)
		local var_16_0 = arg_14_0

		var_1.checkCollisionTop(var_16_0, arg_16_0, true)

		return
	end)

	local var_14_2 = arg_14_0.physics2DItem.TriggerExit

	var_2.AddListener(var_14_2, function(arg_17_0)
		local var_17_0 = arg_14_0

		var_1.checkCollisionTop(var_17_0, arg_17_0, false)

		return
	end)

	return
end

function var_0_0.checkCollisionBall(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0:getBallByTf(arg_18_1.collider.transform)
	local var_18_1 = arg_18_0:getBallByTf(arg_18_1.otherCollider.transform)

	if arg_18_0:checkColliderBall(var_18_0, var_18_1) then
		arg_18_0:removeBall(var_18_0)
		arg_18_0:removeBall(var_18_1)

		local var_18_2 = var_18_0.next
		local var_18_3 = arg_18_1:GetContact(0)

		arg_18_0:createMegerBall(var_18_2, var_18_3.point)

		local var_18_4 = arg_18_0._event
		local var_18_5 = var_7.emit

		WatermelonGameEvent = var_9

		local var_18_6 = var_9.ADD_SCORE
		local var_18_7 = {}

		WatermelonGameConst = var_1_10011
		var_18_7.num = var_1_10011.ball_data[var_18_2].score

		var_18_5(var_18_4, var_18_6, var_18_7)
	elseif not var_4 then
		-- block empty
	end

	return
end

function var_0_0.checkCollisionTop(arg_19_0, arg_19_1, arg_19_2)
	print = var_1_10003

	var_1_10003(arg_19_1.transform.name)

	if arg_19_1.transform.name == "top" then
		if arg_19_2 then
			if not arg_19_0.tickToOver then
				WatermelonGameConst = var_3
				arg_19_0.tickToOver = var_3.enter_top_over_time
			end
		else
			arg_19_0.tickToOver = nil
		end
	end

	return
end

function var_0_0.setBallPhysics(arg_20_0, arg_20_1, arg_20_2)
	GetComponent = var_1_10003
	var_1_10003(arg_20_1.tf, "Rigidbody2D").simulated = arg_20_2

	return
end

function var_0_0.removeBall(arg_21_0, arg_21_1)
	for iter_21_0 = #arg_21_0._balls, 1, -1 do
		if arg_21_0._balls[iter_21_0] == arg_21_1 then
			table = var_6

			local var_21_0 = var_6.remove(arg_21_0._balls, iter_21_0)

			GetComponent = var_7

			local var_21_1 = var_7(arg_21_1.tf, "Physics2DItem").CollisionEnter

			var_7.RemoveAllListeners(var_21_1)

			Destroy = var_7

			var_7(var_21_0.tf)

			return true
		end
	end

	warning = var_2

	var_2("移除ball失败 name = " .. arg_21_1.name)

	return false
end

function var_0_0.checkColliderBall(arg_22_0, arg_22_1, arg_22_2)
	if arg_22_1 and arg_22_2 then
		if arg_22_1.id == arg_22_2.id then
			if arg_22_1.next > 0 and arg_22_2.next > 0 and arg_22_1.next == arg_22_2.next then
				return true
			else
				return false
			end
		else
			return false
		end
	end

	return false
end

function var_0_0.getBallByTf(arg_23_0, arg_23_1)
	for iter_23_0 = 1, #arg_23_0._balls do
		if arg_23_0._balls[iter_23_0].tf == arg_23_1 then
			return var_6
		end
	end

	return nil
end

function var_0_0.getBallByName(arg_24_0, arg_24_1)
	for iter_24_0 = 1, #arg_24_0._balls do
		if arg_24_0._balls[iter_24_0].name == arg_24_1 then
			return var_6
		end
	end

	return nil
end

function var_0_0.clearBallContainer(arg_25_0)
	for iter_25_0 = 1, #arg_25_0._balls do
		GetComponent = var_1_10005

		local var_25_0 = var_1_10005(arg_25_0._balls[iter_25_0].tf, "Physics2DItem").CollisionEnter

		var_1_10005.RemoveAllListeners(var_25_0)

		Destroy = var_1_10005

		var_1_10005(arg_25_0._balls[iter_25_0].tf)
	end

	arg_25_0._balls = {}

	return
end

function var_0_0.setCreateCd(arg_26_0)
	arg_26_0.createBallCd = arg_26_0._gameVo.createBallCd

	return
end

function var_0_0.initBallData(arg_27_0, arg_27_1, arg_27_2)
	setActive = var_1_10003

	var_1_10003(arg_27_1, true)

	local var_27_0, var_27_1

	if not arg_27_2 or not arg_27_2 then
		::label_27_0::

		var_27_0 = arg_27_0
		var_27_1 = arg_27_0.getRandomIdByWeight(var_27_0)
	end

	WatermelonGameConst = var_27_0

	local var_27_2 = var_27_0.ball_data[var_27_1]

	GetComponent = var_5

	local var_27_3 = arg_27_1

	typeof = var_1_10007
	UnityEngine = var_1_10008

	local var_27_4 = var_5(var_27_3, var_1_10007(var_1_10008.CircleCollider2D))

	GetComponent = var_27_3

	local var_27_5 = var_27_3(arg_27_1, "Rigidbody2D")

	var_27_4.radius = var_27_2.size

	local var_27_6 = arg_27_0
	local var_27_7 = arg_27_0.setChildVisible

	findTF = var_1_10009

	var_27_7(var_27_6, var_1_10009(arg_27_1, "size_image"), false)

	setActive = var_27_7
	findTF = var_27_6

	var_27_7(var_27_6(arg_27_1, "size_image/" .. var_27_1), true)

	arg_27_0.countId = arg_27_0.countId + 1
	arg_27_1.name = "ball_" .. arg_27_0.countId

	return {
		id = var_27_2.id,
		tf = arg_27_1,
		rigidbody = var_27_5,
		count = arg_27_0.countId,
		name = arg_27_1.name,
		next = var_27_2.next_id,
		size = var_27_2.size
	}
end

function var_0_0.getRandomIdByWeight(arg_28_0)
	local var_28_0

	if not arg_28_0.weightTotal then
		arg_28_0.weightTotal = 0
		arg_28_0.weightList = {}
		arg_28_0.weightIdList = {}
		var_28_0 = 1
		WatermelonGameConst = var_1_10002

		for iter_28_0 = var_28_0, #var_1_10002.drop_ball_ids do
			local var_28_1 = arg_28_0.weightTotal

			WatermelonGameConst = var_1_10006
			arg_28_0.weightTotal = var_28_1 + var_1_10006.drop_ball_ids[iter_28_0].weight
			table = var_5

			var_5.insert(arg_28_0.weightList, arg_28_0.weightTotal)

			table = var_5

			local var_28_2 = var_5.insert

			var_1_10006 = arg_28_0.weightIdList
			WatermelonGameConst = var_7

			var_28_2(var_1_10006, var_7.drop_ball_ids[iter_28_0].id)
		end
	end

	math = var_28_0

	local var_28_3 = var_28_0.random(1, arg_28_0.weightTotal)

	for iter_28_1 = 1, #arg_28_0.weightList do
		if var_28_3 <= arg_28_0.weightList[iter_28_1] or iter_28_1 == #arg_28_0.weightList then
			return arg_28_0.weightIdList[iter_28_1]
		end
	end

	return nil
end

function var_0_0.setChildVisible(arg_29_0, arg_29_1, arg_29_2)
	for iter_29_0 = 1, arg_29_1.childCount do
		local var_29_0 = arg_29_1
		local var_29_1 = arg_29_1.GetChild(var_29_0, iter_29_0 - 1)

		setActive = var_29_0

		var_29_0(var_29_1, arg_29_2)
	end

	return
end

function var_0_0.dispose(arg_30_0)
	return
end

return var_0_0
