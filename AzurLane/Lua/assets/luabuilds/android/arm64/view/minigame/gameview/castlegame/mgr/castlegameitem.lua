local var_0_0 = class("CastleGameItem")
local var_0_1 = 70
local var_0_2 = 300
local var_0_5 = 125
local var_0_6 = "bubble_broken"
local var_0_7 = "bubble_wait"
local var_0_8 = "bubble_hold"
local var_0_9 = 130
local var_0_10 = 130

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._bubbleTpl = findTF(arg_1_1, "bubbleTpl")
	arg_1_0._carriageTpl = findTF(arg_1_1, "carriageTpl")
	arg_1_0._stoneTpl = findTF(arg_1_1, "stoneTpl")
	arg_1_0._boomTpl = findTF(arg_1_1, "boomTpl")
	arg_1_0._event = arg_1_2
	arg_1_0.carriagePool = {}
	arg_1_0.bubblePool = {}
	arg_1_0.carriages = {}
	arg_1_0.bubbles = {}
	arg_1_0.stonePool = {}
	arg_1_0.stones = {}
	arg_1_0.boomPool = {}
	arg_1_0.booms = {}

	return
end

function var_0_0.setContent(arg_2_0, arg_2_1)
	if not arg_2_1 then
		print("容器不能为nil")

		return
	end

	arg_2_0._content = arg_2_1

	return
end

function var_0_0.start(arg_3_0)
	arg_3_0.stoneDatas = {}

	for iter_3_0 = 1, #CastleGameVo.roundData.stone do
		table.insert(arg_3_0.stoneDatas, {
			time = math.random() * (CastleGameVo.roundData.stone[iter_3_0].time[2] - CastleGameVo.roundData.stone[iter_3_0].time[1]) + CastleGameVo.roundData.stone[iter_3_0].time[1],
			indexs = CastleGameVo.roundData.stone[iter_3_0].index
		})
	end

	for iter_3_1 = #arg_3_0.stones, 1, -1 do
		local var_3_0 = table.remove(arg_3_0.stones, iter_3_1)

		setActive(var_3_0.tf, false)
		arg_3_0:returnItem(var_3_0, arg_3_0.stonePool)
	end

	for iter_3_2 = #arg_3_0.carriages, 1, -1 do
		local var_3_1 = table.remove(arg_3_0.carriages, iter_3_2)

		var_3_1.ready = 0

		setActive(var_3_1.tf, false)
		arg_3_0:returnItem(var_3_1, arg_3_0.carriagePool)
	end

	for iter_3_3 = #arg_3_0.bubbles, 1, -1 do
		local var_3_2 = table.remove(arg_3_0.bubbles, iter_3_3)

		var_3_2.ready = 0
		var_3_2.broken = true
		var_3_2.brokenTime = 0
		var_3_2.hit = false

		setActive(var_3_2.tf, false)
		arg_3_0:returnItem(var_3_2, arg_3_0.bubblePool)
	end

	for iter_3_4 = #arg_3_0.booms, 1, -1 do
		local var_3_3 = table.remove(arg_3_0.booms, iter_3_4)

		var_3_3.ready = 0
		var_3_3.broken = true
		var_3_3.brokenTime = 0

		setActive(var_3_3.tf, false)
		arg_3_0:returnItem(var_3_3, arg_3_0.boomPool)
	end

	arg_3_0.floorIndexs = {}
	arg_3_0.carriageTime = CastleGameVo.roundData.carriage
	arg_3_0.bubbleTime = CastleGameVo.roundData.bubble_time
	arg_3_0.boomTimes = {}

	for iter_3_5 = 1, #CastleGameVo.roundData.boom do
		table.insert(arg_3_0.boomTimes, {
			time = CastleGameVo.roundData.boom[iter_3_5].time[math.random(1, #CastleGameVo.roundData.boom[iter_3_5].time)]
		})
	end

	return
end

function var_0_0.step(arg_4_0)
	for iter_4_0 = #arg_4_0.carriageTime, 1, -1 do
		if CastleGameVo.gameStepTime > arg_4_0.carriageTime[iter_4_0] then
			table.remove(arg_4_0.carriageTime, iter_4_0)
			arg_4_0:appearCarriage()
		end
	end

	for iter_4_1 = #arg_4_0.bubbleTime, 1, -1 do
		if CastleGameVo.gameStepTime > arg_4_0.bubbleTime[iter_4_1].time then
			arg_4_0:appearBubble(table.remove(arg_4_0.bubbleTime, iter_4_1).num)
		end
	end

	for iter_4_2 = #arg_4_0.boomTimes, 1, -1 do
		if CastleGameVo.gameStepTime > arg_4_0.boomTimes[iter_4_2].time then
			table.remove(arg_4_0.boomTimes, iter_4_2)
			arg_4_0:appearBoom()
		end
	end

	for iter_4_3 = #arg_4_0.carriages, 1, -1 do
		if arg_4_0.carriages[iter_4_3].ready and arg_4_0.carriages[iter_4_3].ready > 0 then
			arg_4_0.carriages[iter_4_3].ready = arg_4_0.carriages[iter_4_3].ready - CastleGameVo.deltaTime

			if arg_4_0.carriages[iter_4_3].ready <= 0 then
				arg_4_0.carriages[iter_4_3].ready = 0

				if arg_4_0.itemRemindCallback then
					-- block empty
				end
			end
		else
			local var_4_0 = arg_4_0.carriages[iter_4_3].tf
			local var_4_1 = Vector2(arg_4_0.carriages[iter_4_3].tf.anchoredPosition.x + arg_4_0.carriages[iter_4_3].speed.x * CastleGameVo.deltaTime * var_0_2, arg_4_0.carriages[iter_4_3].tf.anchoredPosition.y + arg_4_0.carriages[iter_4_3].speed.y * CastleGameVo.deltaTime * var_0_2)

			var_4_0.anchoredPosition = var_4_1

			if arg_4_0.carriages[iter_4_3].tf.anchoredPosition.x < arg_4_0.carriages[iter_4_3].target.x and var_4_1.x > arg_4_0.carriages[iter_4_3].target.x then
				table.remove(arg_4_0.carriages, iter_4_3)
				setActive(arg_4_0.carriages[iter_4_3].tf, false)
				arg_4_0:returnItem(arg_4_0.carriages[iter_4_3], arg_4_0.carriagePool)
			elseif arg_4_0.carriages[iter_4_3].tf.anchoredPosition.x > arg_4_0.carriages[iter_4_3].target.x and var_4_1.x < arg_4_0.carriages[iter_4_3].target.x then
				table.remove(arg_4_0.carriages, iter_4_3)
				setActive(arg_4_0.carriages[iter_4_3].tf, false)
				arg_4_0:returnItem(arg_4_0.carriages[iter_4_3], arg_4_0.carriagePool)
			end
		end
	end

	for iter_4_4 = #arg_4_0.bubbles, 1, -1 do
		local var_4_2 = arg_4_0.bubbles[iter_4_4]

		if arg_4_0.bubbles[iter_4_4].ready and arg_4_0.bubbles[iter_4_4].ready > 0 then
			arg_4_0.bubbles[iter_4_4].ready = arg_4_0.bubbles[iter_4_4].ready - CastleGameVo.deltaTime

			if arg_4_0.bubbles[iter_4_4].ready <= 0 then
				arg_4_0.bubbles[iter_4_4].ready = 0

				setActive(arg_4_0.bubbles[iter_4_4].tf, true)
			end
		elseif arg_4_0.bubbles[iter_4_4].brokenTime and arg_4_0.bubbles[iter_4_4].brokenTime > 0 then
			arg_4_0.bubbles[iter_4_4].brokenTime = arg_4_0.bubbles[iter_4_4].brokenTime - CastleGameVo.deltaTime

			if not arg_4_0.bubbles[iter_4_4].hit and CastleGameVo.bubble_broken_time - arg_4_0.bubbles[iter_4_4].brokenTime > 1 then
				arg_4_0.bubbles[iter_4_4].hit = true
			end

			if arg_4_0.bubbles[iter_4_4].brokenTime < 0 then
				arg_4_0.bubbles[iter_4_4].broken = true
				arg_4_0.bubbles[iter_4_4].brokenTime = 0
				arg_4_0.bubbles[iter_4_4].hit = false

				if arg_4_0.bubbleBrokenCallback then
					arg_4_0.bubbleBrokenCallback(arg_4_0.bubbles[iter_4_4])
				end

				arg_4_0:changeAnimAction(arg_4_0.bubbles[iter_4_4].anims, var_0_6, 1, var_0_7, function()
					setActive(var_4_2.tf, false)

					return
				end)
				arg_4_0:returnItem(arg_4_0.bubbles[iter_4_4], arg_4_0.bubblePool)
				table.remove(arg_4_0.bubbles, iter_4_4)
			end
		end
	end

	for iter_4_5 = #arg_4_0.stoneDatas, 1, -1 do
		if CastleGameVo.gameStepTime > arg_4_0.stoneDatas[iter_4_5].time then
			arg_4_0:appearStone(table.remove(arg_4_0.stoneDatas, iter_4_5).indexs)
		end
	end

	for iter_4_6 = #arg_4_0.stones, 1, -1 do
		if arg_4_0.stones[iter_4_6].ready and arg_4_0.stones[iter_4_6].ready > 0 then
			arg_4_0.stones[iter_4_6].ready = arg_4_0.stones[iter_4_6].ready - CastleGameVo.deltaTime

			if arg_4_0.stones[iter_4_6].ready <= 0 then
				arg_4_0.stones[iter_4_6].ready = 0

				setActive(arg_4_0.stones[iter_4_6].tf, true)

				if arg_4_0.floorBrokenCallback then
					arg_4_0.floorBrokenCallback(arg_4_0.stones[iter_4_6].useIndex, 0.5)
				end
			end
		elseif arg_4_0.stones[iter_4_6].brokenTime and arg_4_0.stones[iter_4_6].brokenTime > 0 then
			arg_4_0.stones[iter_4_6].brokenTime = arg_4_0.stones[iter_4_6].brokenTime - CastleGameVo.deltaTime

			if arg_4_0.stones[iter_4_6].brokenTime <= 0 then
				arg_4_0.stones[iter_4_6].broken = true
				arg_4_0.stones[iter_4_6].brokenTime = nil

				table.remove(arg_4_0.stones, iter_4_6)
				setActive(arg_4_0.stones[iter_4_6].tf, false)
				arg_4_0:returnItem(arg_4_0.stones[iter_4_6], arg_4_0.stonePool)
			end
		end
	end

	for iter_4_7 = #arg_4_0.booms, 1, -1 do
		for iter_4_8, iter_4_9 in ipairs(arg_4_0.booms[iter_4_7].bound.points:ToTable()) do
			findTF(arg_4_0.booms[iter_4_7].tf, "zPos/" .. iter_4_8 + 1).anchoredPosition = Vector2(iter_4_9.x, iter_4_9.y)

			table.insert({}, (Vector2(arg_4_0.booms[iter_4_7].tf.anchoredPosition.x + iter_4_9.x, arg_4_0.booms[iter_4_7].tf.anchoredPosition.y + iter_4_9.y)))
		end

		arg_4_0.booms[iter_4_7].boundPoints = {}

		if arg_4_0.booms[iter_4_7].ready and arg_4_0.booms[iter_4_7].ready > 0 then
			arg_4_0.booms[iter_4_7].ready = arg_4_0.booms[iter_4_7].ready - CastleGameVo.deltaTime

			if arg_4_0.booms[iter_4_7].ready <= 0 then
				arg_4_0.booms[iter_4_7].ready = 0

				setActive(arg_4_0.booms[iter_4_7].tf, true)

				if arg_4_0.floorBrokenCallback then
					arg_4_0.floorBrokenCallback(arg_4_0.booms[iter_4_7].useIndex, 0.5)
				end
			end
		elseif arg_4_0.booms[iter_4_7].brokenTime and arg_4_0.booms[iter_4_7].brokenTime > 0 then
			arg_4_0.booms[iter_4_7].brokenTime = arg_4_0.booms[iter_4_7].brokenTime - CastleGameVo.deltaTime

			if arg_4_0.booms[iter_4_7].brokenTime < 0 then
				arg_4_0.booms[iter_4_7].broken = true
				arg_4_0.booms[iter_4_7].brokenTime = 0

				setActive(arg_4_0.booms[iter_4_7].tf, false)
				arg_4_0:returnItem(table.remove(arg_4_0.booms, iter_4_7), arg_4_0.boomPool)
			end
		end
	end

	return
end

function var_0_0.appearStone(arg_6_0, arg_6_1)
	local var_6_0
	local var_6_1 = {}
	local var_6_2 = arg_6_0:getItemActiveIndex()

	for iter_6_0 = 1, #var_6_2 do
		if not table.contains(arg_6_1, var_6_2[iter_6_0]) then
			table.insert(var_6_1, var_6_2[iter_6_0])
		end
	end

	if #var_6_1 == 0 then
		return
	end

	if #arg_6_0.stonePool > 0 then
		var_6_0 = table.remove(arg_6_0.stonePool, 1)
	else
		local var_6_3 = tf(instantiate(arg_6_0._stoneTpl))

		setParent(var_6_3, arg_6_0._content)

		var_6_0 = {
			tf = var_6_3,
			bound = GetComponent(findTF(var_6_3, "zPos/anim/collider"), typeof(BoxCollider2D))
		}
	end

	local var_6_4 = findTF(var_6_0.tf, "zPos/anim/img")
	local var_6_5 = math.random(1, var_6_4.childCount) - 1

	for iter_6_1 = 0, var_6_4.childCount - 1 do
		setActive(var_6_4:GetChild(iter_6_1), iter_6_1 == var_6_5)
	end

	var_6_0.ready = CastleGameVo.item_ready_time
	var_6_0.brokenTime = CastleGameVo.stone_broken_time

	local var_6_6 = var_6_1[math.random(1, #var_6_1)]
	local var_6_7 = math.floor(var_6_6 / CastleGameVo.w_count)

	var_6_0.tf.anchoredPosition = CastleGameVo.GetRotationPosByWH(var_6_6 % CastleGameVo.w_count, var_6_7)

	setActive(var_6_0.tf, false)

	var_6_0.index = var_6_6
	var_6_0.useIndex = {
		var_6_6
	}

	if arg_6_0.itemRemindCallback then
		arg_6_0.itemRemindCallback({
			{
				w = var_6_6 % CastleGameVo.w_count,
				h = var_6_7,
				type = CastleGameRemind.remind_type_1
			}
		})
	end

	table.insert(arg_6_0.stones, var_6_0)

	return
end

function var_0_0.returnItem(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_0.itemChangeCallback then
		arg_7_0.itemChangeCallback(arg_7_1, false)
	end

	table.insert(arg_7_2, arg_7_1)

	return
end

function var_0_0.appearBubble(arg_8_0, arg_8_1)
	for iter_8_0 = 1, arg_8_1 do
		local var_8_0
		local var_8_1 = arg_8_0:getItemActiveIndex()

		if #var_8_1 == 0 then
			return
		end

		if #arg_8_0.bubblePool > 0 then
			var_8_0 = table.remove(arg_8_0.bubblePool, 1)
		else
			local var_8_2 = tf(instantiate(arg_8_0._bubbleTpl))
			local var_8_3 = findTF(var_8_2, "zPos/pos")
			local var_8_4 = GetComponent(findTF(var_8_2, "zPos/spine1"), typeof(SpineAnimUI))
			local var_8_5 = GetComponent(findTF(var_8_2, "zPos/spine2"), typeof(SpineAnimUI))
			local var_8_6 = GetComponent(findTF(var_8_2, "zPos/collider"), typeof(BoxCollider2D))
			local var_8_7 = var_8_2:InverseTransformPoint(var_8_6.bounds.min)
			local var_8_8 = var_8_2:InverseTransformPoint(var_8_6.bounds.max)

			setParent(var_8_2, arg_8_0._content)

			var_8_0 = {
				tf = var_8_2,
				anims = {
					var_8_4,
					var_8_5
				},
				bound = var_8_6,
				pos = var_8_3,
				bmin = var_8_7,
				bmax = var_8_8
			}
		end

		local var_8_9 = var_8_1[math.random(1, #var_8_1)]

		var_8_0.start = CastleGameVo.GetRotationPosByWH(var_8_9 % CastleGameVo.w_count, (math.floor(var_8_9 / CastleGameVo.w_count)))
		var_8_0.start.y = var_8_0.start.y + var_0_5
		var_8_0.tf.anchoredPosition = var_8_0.start

		setActive(var_8_0.tf, false)

		var_8_0.ready = CastleGameVo.bubble_ready_time
		var_8_0.broken = false
		var_8_0.brokenTime = CastleGameVo.bubble_broken_time
		var_8_0.useIndex = {
			var_8_9
		}
		var_8_0.index = var_8_9

		if arg_8_0.itemChangeCallback then
			arg_8_0.itemChangeCallback(var_8_0, true)
		end

		setActive(var_8_0.tf, false)
		table.insert(arg_8_0.bubbles, var_8_0)
		arg_8_0:changeAnimAction(var_8_0.anims, var_0_8, -1)
	end

	return
end

function var_0_0.appearBoom(arg_9_0)
	local var_9_0 = arg_9_0:getItemActiveIndex()

	for iter_9_0 = 1, #var_9_0 do
		if var_9_0[iter_9_0] % CastleGameVo.w_count ~= CastleGameVo.w_count - 1 then
			if table.contains(var_9_0, var_9_0[iter_9_0] + 1) and table.contains(var_9_0, var_9_0[iter_9_0] + CastleGameVo.w_count) and table.contains(var_9_0, var_9_0[iter_9_0] + 1 + CastleGameVo.w_count) then
				table.insert({}, var_9_0[iter_9_0])
			end
		end
	end

	local var_9_1 = ({})[math.random(1, #{})]

	if #{} == 0 then
		return
	end

	local var_9_2

	if #arg_9_0.boomPool > 0 then
		var_9_2 = table.remove(arg_9_0.boomPool, 1)
	else
		local var_9_3 = tf(instantiate(arg_9_0._boomTpl))

		setParent(var_9_3, arg_9_0._content)

		var_9_2 = {
			tf = var_9_3,
			bound = GetComponent(findTF(var_9_3, "zPos/collider"), typeof("UnityEngine.PolygonCollider2D"))
		}
	end

	local var_9_4 = var_9_1 % CastleGameVo.w_count
	local var_9_5 = math.floor(var_9_1 / CastleGameVo.w_count)
	local var_9_6 = CastleGameVo.GetRotationPosByWH(var_9_1 % CastleGameVo.w_count, var_9_5)

	var_9_6.x = var_9_6.x + var_0_9
	var_9_6.y = var_9_6.y + var_0_10
	var_9_2.tf.anchoredPosition = var_9_6
	var_9_2.ready = CastleGameVo.item_ready_time
	var_9_2.broken = false

	setActive(var_9_2.tf, false)

	var_9_2.index = var_9_1
	var_9_2.useIndex = {
		var_9_1,
		var_9_1 + 1,
		var_9_1 + CastleGameVo.w_count,
		var_9_1 + CastleGameVo.w_count + 1
	}
	var_9_2.brokenTime = 1.5

	if arg_9_0.itemChangeCallback then
		arg_9_0.itemChangeCallback(var_9_2, true)
	end

	if arg_9_0.itemRemindCallback then
		arg_9_0.itemRemindCallback({
			{
				w = var_9_4,
				h = var_9_5,
				type = CastleGameRemind.remind_type_2
			}
		})
	end

	table.insert(arg_9_0.booms, var_9_2)

	return
end

function var_0_0.setFloorBroken(arg_10_0, arg_10_1)
	arg_10_0.floorBrokenCallback = arg_10_1

	return
end

function var_0_0.setBubbleBroken(arg_11_0, arg_11_1)
	arg_11_0.bubbleBrokenCallback = arg_11_1

	return
end

function var_0_0.setItemChange(arg_12_0, arg_12_1)
	arg_12_0.itemChangeCallback = arg_12_1

	return
end

function var_0_0.setFloorIndexs(arg_13_0, arg_13_1)
	arg_13_0.floorIndexs = arg_13_1

	return
end

function var_0_0.getItemActiveIndex(arg_14_0)
	for iter_14_0 = 1, #arg_14_0.bubbles do
		for iter_14_1, iter_14_2 in ipairs(arg_14_0.bubbles[iter_14_0].useIndex) do
			table.insert({}, iter_14_2)
		end
	end

	for iter_14_3 = 1, #arg_14_0.booms do
		for iter_14_4, iter_14_5 in ipairs(arg_14_0.booms[iter_14_3].useIndex) do
			table.insert({}, iter_14_5)
		end
	end

	for iter_14_6 = 1, #arg_14_0.stones do
		for iter_14_7, iter_14_8 in ipairs(arg_14_0.stones[iter_14_6].useIndex) do
			table.insert({}, iter_14_8)
		end
	end

	for iter_14_9 = 1, #arg_14_0.floorIndexs do
		if not table.contains({}, arg_14_0.floorIndexs[iter_14_9]) then
			table.insert({}, arg_14_0.floorIndexs[iter_14_9])
		end
	end

	return {}
end

function var_0_0.appearCarriage(arg_15_0)
	local var_15_0

	if #arg_15_0.carriagePool > 0 then
		var_15_0 = table.remove(arg_15_0.carriagePool, 1)
	else
		local var_15_1 = tf(instantiate(arg_15_0._carriageTpl))
		local var_15_2 = GetComponent(findTF(var_15_1, "zPos/collider"), typeof(BoxCollider2D))

		setParent(var_15_1, arg_15_0._content)

		var_15_0 = {
			tf = var_15_1,
			bound = var_15_2,
			anims = {
				(GetComponent(findTF(var_15_1, "zPos/spine"), typeof(SpineAnimUI)))
			},
			bmin = var_15_1:InverseTransformPoint(var_15_2.bounds.min),
			bmax = var_15_1:InverseTransformPoint(var_15_2.bounds.max)
		}
	end

	local var_15_3 = arg_15_0:getCarriageRoadlist()

	if #var_15_3 > 0 then
		local var_15_4 = var_15_3[math.random(1, #var_15_3)]

		var_15_0.w = var_15_4.w
		var_15_0.h = var_15_4.h
		var_15_0.target_w = var_15_4.target_w
		var_15_0.target_h = var_15_4.target_h
		findTF(var_15_0.tf, "zPos").localScale = var_15_4.scale
		var_15_0.start = CastleGameVo.GetRotationPosByWH(var_15_0.w, var_15_0.h)
		var_15_0.start.y = var_15_0.start.y + var_0_1
		var_15_0.target = CastleGameVo.GetRotationPosByWH(var_15_0.target_w, var_15_0.target_h)
		var_15_0.target.y = var_15_0.target.y + var_0_1
		var_15_0.tf.anchoredPosition = var_15_0.start
		var_15_0.ready = CastleGameVo.item_ready_time

		setActive(var_15_0.tf, false)
		setActive(var_15_0.tf, true)

		local var_15_5, var_15_6 = arg_15_0:countSpeed(var_15_0.start, var_15_0.target)

		var_15_0.speed = var_15_5
		var_15_0.direct = var_15_6

		if arg_15_0.itemChangeCallback then
			arg_15_0.itemChangeCallback(var_15_0, true)
		end

		table.insert(arg_15_0.carriages, var_15_0)
	else
		print("当前不存在可以出现马车的位置")
	end

	return
end

function var_0_0.getCarriageRoadlist(arg_16_0)
	for iter_16_0 = 0, CastleGameVo.w_count - 1 do
		local var_16_0 = true

		for iter_16_1 = 0, CastleGameVo.h_count - 1 do
			if var_16_0 and not table.contains(arg_16_0.floorIndexs, iter_16_0 + iter_16_1 * CastleGameVo.w_count) then
				var_16_0 = false
			end
		end

		if var_16_0 then
			table.insert({}, {
				h = -1,
				w = iter_16_0,
				target_w = iter_16_0,
				target_h = CastleGameVo.h_count,
				scale = Vector3(-1, 1, 1)
			})
		end
	end

	for iter_16_2 = 0, CastleGameVo.h_count - 1 do
		local var_16_1 = true

		for iter_16_3 = 0, CastleGameVo.w_count - 1 do
			if var_16_1 and not table.contains(arg_16_0.floorIndexs, iter_16_3 + iter_16_2 * CastleGameVo.w_count) then
				var_16_1 = false
			end
		end

		if var_16_1 then
			table.insert({}, {
				w = -1,
				h = iter_16_2,
				target_w = CastleGameVo.w_count,
				target_h = iter_16_2,
				scale = Vector3(1, 1, 1)
			})
		end
	end

	return {}
end

function var_0_0.setItemRemindCallback(arg_17_0, arg_17_1)
	arg_17_0.itemRemindCallback = arg_17_1

	return
end

function var_0_0.countSpeed(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = math.atan(math.abs(arg_18_2.y - arg_18_1.y) / math.abs(arg_18_2.x - arg_18_1.x))
	local var_18_1 = Vector2(math.cos(var_18_0) * (arg_18_2.x > arg_18_1.x and 1 or -1), math.sin(var_18_0) * (arg_18_2.y > arg_18_1.y and 1 or -1))
	local var_18_2 = Vector2(arg_18_2.x > arg_18_1.x and 1 or -1, arg_18_2.y > arg_18_1.y and 1 or -1)
end

function var_0_0.changeAnimAction(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4, arg_19_5)
	local var_19_0 = 0

	for iter_19_0 = 1, #arg_19_1 do
		local var_19_1 = arg_19_1[iter_19_0]

		arg_19_1[iter_19_0]:SetActionCallBack(nil)
		arg_19_1[iter_19_0]:SetAction(arg_19_2, 0)
		arg_19_1[iter_19_0]:SetActionCallBack(function(arg_20_0)
			if arg_20_0 == "finish" then
				if arg_19_3 == 1 then
					var_19_1:SetActionCallBack(nil)
					var_19_1:SetAction(arg_19_4, 0)
				end

				if arg_19_5 and var_19_0 == 0 then
					var_19_0 = 1

					arg_19_5()
				end
			end

			return
		end)

		if arg_19_3 ~= 1 and arg_19_5 and 0 == 0 then
			var_19_0 = 1

			arg_19_5()
		end
	end

	return
end

function var_0_0.playerInBubble(arg_21_0, arg_21_1, arg_21_2)
	arg_21_1.char = arg_21_2

	return
end

function var_0_0.getBooms(arg_22_0)
	return arg_22_0.booms
end

function var_0_0.getBubbles(arg_23_0)
	return arg_23_0.bubbles
end

function var_0_0.getCarriages(arg_24_0)
	return arg_24_0.carriages
end

function var_0_0.clear(arg_25_0)
	return
end

return var_0_0
