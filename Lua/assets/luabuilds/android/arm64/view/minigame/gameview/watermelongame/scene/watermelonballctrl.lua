local var_0_0 = class("WatermelonBallCtrl")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._content = arg_1_1
	arg_1_0._contextData = arg_1_2
	arg_1_0._event = arg_1_3
	arg_1_0._startPos = findTF(arg_1_0._content, "start_pos")
	arg_1_0._rayTf = findTF(arg_1_0._startPos, "ray")
	arg_1_0._left = findTF(arg_1_0._content, "left")
	arg_1_0._right = findTF(arg_1_0._content, "right")
	arg_1_0._container = findTF(arg_1_0._content, "container")
	arg_1_0._megerEffect = findTF(arg_1_0._content, "meger_effect")

	if arg_1_0._megerEffect then
		setActive(arg_1_0._megerEffect, false)
	end

	arg_1_0._tempRect = findTF(arg_1_0._container, "temp_rect")
	arg_1_0.leftPos = arg_1_0._left.anchoredPosition.x
	arg_1_0.rightPos = arg_1_0._right.anchoredPosition.x
	arg_1_0._balls = {}
	arg_1_0._layerMask = LayerMask.GetMask("UI")

	print("log ball ctrl init complete")

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
		arg_4_0.nextBallId = arg_4_0:getRandomIdByWeight()

		arg_4_0._event:emit(WatermelonGameEvent.UPDATE_NEXT_BALL, arg_4_0.nextBallId)
	end

	if not arg_4_0.readyBall then
		if not arg_4_0.createBallCd then
			arg_4_0:setCreateCd()
		end

		if arg_4_0.createBallCd and arg_4_0.createBallCd >= 0 then
			arg_4_0.createBallCd = arg_4_0.createBallCd - arg_4_0._gameVo.deltaTime

			if arg_4_0.createBallCd <= 0 then
				arg_4_0.createBallCd = nil

				arg_4_0:createReadyBall()
			end
		end
	else
		arg_4_0.readyBall.tf.anchoredPosition = arg_4_0._startPos.anchoredPosition

		local var_4_0 = Physics2D.Raycast(arg_4_0._startPos.position, Vector2(0, -1))

		if var_4_0 and var_4_0.transform then
			arg_4_0._rayTf.sizeDelta = Vector2(arg_4_0._rayTf.sizeDelta.x, math.abs(arg_4_0._startPos:InverseTransformPoint(Vector2(var_4_0.point.x, var_4_0.point.y, 0)).y))
		end
	end

	local var_4_1 = not not arg_4_0.readyBall

	if isActive(arg_4_0._rayTf) ~= not not arg_4_0.readyBall then
		setActive(arg_4_0._rayTf, var_4_1)
	end

	if arg_4_0.tickToOver then
		arg_4_0.tickToOver = arg_4_0.tickToOver - arg_4_1

		if arg_4_0.tickToOver and arg_4_0.tickToOver <= 0 then
			arg_4_0._event:emit(WatermelonGameEvent.GAME_OVER, true)

			arg_4_0.tickToOver = nil
		end
	end

	return
end

function var_0_0.clear(arg_5_0)
	arg_5_0.countId = WatermelonGameConst.ball_count_id
	arg_5_0.tickToOver = nil

	if arg_5_0._megerEffect then
		setActive(arg_5_0._megerEffect, false)
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
		local var_9_0 = arg_9_0._content:InverseTransformPoint(arg_9_1.pos)

		if var_9_0.x < arg_9_0.leftPos + arg_9_0.readyBall.size then
			var_9_0.x = arg_9_0.leftPos + arg_9_0.readyBall.size
		elseif var_9_0.x > arg_9_0.rightPos - arg_9_0.readyBall.size then
			var_9_0.x = arg_9_0.rightPos - arg_9_0.readyBall.size
		end

		arg_9_0._startPos.anchoredPosition = Vector2(var_9_0.x, arg_9_0._startPos.anchoredPosition.y)

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
		table.insert(arg_11_0._balls, arg_11_0.readyBall)

		arg_11_0.readyBall = nil

		arg_11_0:setCreateCd()
	end

	return
end

function var_0_0.createReadyBall(arg_12_0)
	local var_12_0, var_12_1 = arg_12_0._gameVo:getTplItemFromPool("ball", arg_12_0._container)

	arg_12_0._startPos.anchoredPosition = Vector2(0, arg_12_0._startPos.anchoredPosition.y)
	var_12_0.anchoredPosition = arg_12_0._startPos.anchoredPosition

	local var_12_2 = arg_12_0:initBallData(var_12_0, arg_12_0.nextBallId)

	arg_12_0.nextBallId = nil
	arg_12_0.readyBall = var_12_2

	arg_12_0:setBallEvent(var_12_2)
	arg_12_0:setBallPhysics(arg_12_0.readyBall, false)

	return
end

function var_0_0.createMegerBall(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0, var_13_1 = arg_13_0._gameVo:getTplItemFromPool("ball", arg_13_0._container)

	var_13_0.position = Vector3(arg_13_2.x, arg_13_2.y, 0)

	if arg_13_0._megerEffect then
		arg_13_0._megerEffect.position = var_13_0.position

		setActive(arg_13_0._megerEffect, false)
		setActive(arg_13_0._megerEffect, true)
	end

	local var_13_2 = arg_13_0:initBallData(var_13_0, arg_13_1)

	arg_13_0:setBallEvent(var_13_2)
	table.insert(arg_13_0._balls, var_13_2)

	return
end

function var_0_0.setBallEvent(arg_14_0, arg_14_1)
	arg_14_0.physics2DItem = GetComponent(arg_14_1.tf, "Physics2DItem")

	arg_14_0.physics2DItem.CollisionEnter:AddListener(function(arg_15_0)
		arg_14_0:checkCollisionBall(arg_15_0)

		return
	end)
	arg_14_0.physics2DItem.TriggerEnter:AddListener(function(arg_16_0)
		arg_14_0:checkCollisionTop(arg_16_0, true)

		return
	end)
	arg_14_0.physics2DItem.TriggerExit:AddListener(function(arg_17_0)
		arg_14_0:checkCollisionTop(arg_17_0, false)

		return
	end)

	return
end

function var_0_0.checkCollisionBall(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0:getBallByTf(arg_18_1.collider.transform)
	local var_18_1 = arg_18_0:getBallByTf(arg_18_1.otherCollider.transform)
	local var_18_2 = arg_18_0:checkColliderBall(var_18_0, var_18_1)

	if var_18_2 then
		arg_18_0:removeBall(var_18_0)
		arg_18_0:removeBall(var_18_1)
		arg_18_0:createMegerBall(var_18_0.next, arg_18_1:GetContact(0).point)
		arg_18_0._event:emit(WatermelonGameEvent.ADD_SCORE, {
			num = WatermelonGameConst.ball_data[var_18_0.next].score
		})
	elseif not var_18_2 then
		-- block empty
	end

	return
end

function var_0_0.checkCollisionTop(arg_19_0, arg_19_1, arg_19_2)
	print(arg_19_1.transform.name)

	if arg_19_1.transform.name == "top" then
		arg_19_0.tickToOver = arg_19_2 and (arg_19_0.tickToOver or WatermelonGameConst.enter_top_over_time) or nil
	end

	return
end

function var_0_0.setBallPhysics(arg_20_0, arg_20_1, arg_20_2)
	GetComponent(arg_20_1.tf, "Rigidbody2D").simulated = arg_20_2

	return
end

function var_0_0.removeBall(arg_21_0, arg_21_1)
	for iter_21_0 = #arg_21_0._balls, 1, -1 do
		if arg_21_0._balls[iter_21_0] == arg_21_1 then
			local var_21_0 = table.remove(arg_21_0._balls, iter_21_0)

			GetComponent(arg_21_1.tf, "Physics2DItem").CollisionEnter:RemoveAllListeners()
			Destroy(var_21_0.tf)

			return true
		end
	end

	warning("移除ball失败 name = " .. arg_21_1.name)

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
			return arg_23_0._balls[iter_23_0]
		end
	end

	return nil
end

function var_0_0.getBallByName(arg_24_0, arg_24_1)
	for iter_24_0 = 1, #arg_24_0._balls do
		if arg_24_0._balls[iter_24_0].name == arg_24_1 then
			return arg_24_0._balls[iter_24_0]
		end
	end

	return nil
end

function var_0_0.clearBallContainer(arg_25_0)
	for iter_25_0 = 1, #arg_25_0._balls do
		GetComponent(arg_25_0._balls[iter_25_0].tf, "Physics2DItem").CollisionEnter:RemoveAllListeners()
		Destroy(arg_25_0._balls[iter_25_0].tf)
	end

	arg_25_0._balls = {}

	return
end

function var_0_0.setCreateCd(arg_26_0)
	arg_26_0.createBallCd = arg_26_0._gameVo.createBallCd

	return
end

function var_0_0.initBallData(arg_27_0, arg_27_1, arg_27_2)
	setActive(arg_27_1, true)

	local var_27_0 = arg_27_2 and arg_27_2 or arg_27_0:getRandomIdByWeight()
	local var_27_1 = WatermelonGameConst.ball_data[var_27_0]

	GetComponent(arg_27_1, typeof(UnityEngine.CircleCollider2D)).radius = WatermelonGameConst.ball_data[var_27_0].size

	arg_27_0:setChildVisible(findTF(arg_27_1, "size_image"), false)
	setActive(findTF(arg_27_1, "size_image/" .. var_27_0), true)

	arg_27_0.countId = arg_27_0.countId + 1
	arg_27_1.name = "ball_" .. arg_27_0.countId

	return {
		id = var_27_1.id,
		tf = arg_27_1,
		rigidbody = GetComponent(arg_27_1, "Rigidbody2D"),
		count = arg_27_0.countId,
		name = arg_27_1.name,
		next = var_27_1.next_id,
		size = var_27_1.size
	}
end

function var_0_0.getRandomIdByWeight(arg_28_0)
	if not arg_28_0.weightTotal then
		arg_28_0.weightTotal = 0
		arg_28_0.weightList = {}
		arg_28_0.weightIdList = {}

		for iter_28_0 = 1, #WatermelonGameConst.drop_ball_ids do
			arg_28_0.weightTotal = arg_28_0.weightTotal + WatermelonGameConst.drop_ball_ids[iter_28_0].weight

			table.insert(arg_28_0.weightList, arg_28_0.weightTotal)
			table.insert(arg_28_0.weightIdList, WatermelonGameConst.drop_ball_ids[iter_28_0].id)
		end
	end

	local var_28_0 = math.random(1, arg_28_0.weightTotal)

	for iter_28_1 = 1, #arg_28_0.weightList do
		if var_28_0 <= arg_28_0.weightList[iter_28_1] or iter_28_1 == #arg_28_0.weightList then
			return arg_28_0.weightIdList[iter_28_1]
		end
	end

	return nil
end

function var_0_0.setChildVisible(arg_29_0, arg_29_1, arg_29_2)
	for iter_29_0 = 1, arg_29_1.childCount do
		setActive(arg_29_1:GetChild(iter_29_0 - 1), arg_29_2)
	end

	return
end

function var_0_0.dispose(arg_30_0)
	return
end

return var_0_0
