class = var_0_10000

local var_0_0 = var_0_10000("CastleGameScene")
local var_0_1 = 1
local var_0_2 = 2
local var_0_3 = 3
local var_0_4 = 4

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._tf = arg_1_1
	arg_1_0._event = arg_1_2
	findTF = var_1_10003
	arg_1_0.sceneMask = var_1_10003(arg_1_0._tf, "sceneMask")
	findTF = var_3
	arg_1_0.tplContent = var_3(arg_1_0._tf, "sceneMask/sceneContainer/scene/tpl")
	findTF = var_3
	arg_1_0.floorTpl = var_3(arg_1_0._tf, "sceneMask/sceneContainer/scene/tpl/floorTpl")
	findTF = var_3
	arg_1_0.charTpl = var_3(arg_1_0._tf, "sceneMask/sceneContainer/scene/tpl/charTpl")
	findTF = var_3
	arg_1_0.carriageTpl = var_3(arg_1_0._tf, "sceneMask/sceneContainer/scene/tpl/carriageTpl")
	findTF = var_3
	arg_1_0.bubbleTpl = var_3(arg_1_0._tf, "sceneMask/sceneContainer/scene/tpl/bubbleTpl")
	findTF = var_3
	arg_1_0.scoreTpl = var_3(arg_1_0._tf, "sceneMask/sceneContainer/scene/tpl/scoreTpl")
	findTF = var_3
	arg_1_0.contentBack = var_3(arg_1_0._tf, "sceneMask/sceneContainer/scene_background/content")
	findTF = var_3
	arg_1_0.contentMid = var_3(arg_1_0._tf, "sceneMask/sceneContainer/scene/content")
	findTF = var_3
	arg_1_0.contentTop = var_3(arg_1_0._tf, "sceneMask/sceneContainer/scene_front/content")
	findTF = var_3
	arg_1_0.contentEF = var_3(arg_1_0._tf, "sceneMask/sceneContainer/scene/effect_front")
	CastleGameVo = var_3

	local var_1_0 = var_3.GetRotationPosByWH(0, -1)

	CastleGameFloor = var_4
	arg_1_0.gameFloor = var_4.New(arg_1_0.floorTpl, arg_1_0._event)
	CastleGameChar = var_4
	arg_1_0.gameChar = var_4.New(arg_1_0.charTpl, arg_1_0._event)
	CastleGameItem = var_4
	arg_1_0.gameItem = var_4.New(arg_1_0.tplContent, arg_1_0._event)
	CastleGameRemind = var_4
	arg_1_0.gameRemind = var_4.New(arg_1_0.tplContent, arg_1_0._event)
	CastleGameScore = var_4
	arg_1_0.gameScore = var_4.New(arg_1_0.scoreTpl, arg_1_0._event)

	local var_1_1 = arg_1_0.gameFloor

	var_4.setContent(var_1_1, arg_1_0:getContent(var_0_2))

	local var_1_2 = arg_1_0.gameChar

	var_4.setContent(var_1_2, arg_1_0:getContent(var_0_3))

	local var_1_3 = arg_1_0.gameItem

	var_4.setContent(var_1_3, arg_1_0:getContent(var_0_3))

	local var_1_4 = arg_1_0.gameRemind

	var_4.setContent(var_1_4, arg_1_0:getContent(var_0_4))

	local var_1_5 = arg_1_0.gameScore

	var_4.setContent(var_1_5, arg_1_0:getContent(var_0_3))

	local var_1_6 = arg_1_0.gameFloor

	var_4.setFloorFallCallback(var_1_6, function(arg_2_0)
		local var_2_0 = arg_1_0

		var_1.addRemindItems(var_2_0, arg_2_0)

		return
	end)

	local var_1_7 = arg_1_0.gameFloor
	local var_1_8 = var_4.getOutLandPoint(var_1_7)
	local var_1_9 = arg_1_0.gameChar

	var_5.setOutLandPoint(var_1_9, var_1_8)

	arg_1_0.floorItems = {}

	local var_1_10 = arg_1_0
	local var_1_11 = arg_1_0.insertFloorItem
	local var_1_12 = arg_1_0.gameFloor

	var_1_11(var_1_10, var_7.getFloors(var_1_12))

	arg_1_0.items = {}
	table = var_5

	local var_1_13 = var_5.insert
	local var_1_14 = arg_1_0.items
	local var_1_15 = arg_1_0.gameChar

	var_1_13(var_1_14, var_7.getChar(var_1_15))

	local var_1_16 = arg_1_0.gameItem

	var_5.setItemRemindCallback(var_1_16, function(arg_3_0)
		local var_3_0 = arg_1_0

		var_1.addRemindItems(var_3_0, arg_3_0)

		return
	end)

	local var_1_17 = arg_1_0.gameItem

	var_5.setItemChange(var_1_17, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_1_0

		var_2.itemChange(var_4_0, arg_4_0, arg_4_1)

		return
	end)

	local var_1_18 = arg_1_0.gameItem

	var_5.setFloorBroken(var_1_18, function(arg_5_0, arg_5_1)
		ipairs = var_2_10002

		for iter_5_0, iter_5_1 in var_2_10002(arg_5_0) do
			local var_5_0 = arg_1_0.gameFloor

			var_7.setBroken(var_5_0, iter_5_1, arg_5_1)
		end

		return
	end)

	local var_1_19 = arg_1_0.gameScore

	var_5.setItemChange(var_1_19, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_1_0

		var_2.itemChange(var_6_0, arg_6_0, arg_6_1)

		return
	end)

	local var_1_20 = arg_1_0.gameItem

	var_5.setBubbleBroken(var_1_20, function(arg_7_0)
		if arg_7_0 and arg_7_0.char then
			local var_7_0 = arg_1_0

			var_1.returnPlayerBubble(var_7_0, arg_7_0, arg_7_0.char)
		end

		return
	end)
	arg_1_0:sortItems(arg_1_0.floorItems)

	return
end

function var_0_0.addRemindItems(arg_8_0, arg_8_1)
	for iter_8_0 = 1, #arg_8_1 do
		local var_8_0 = arg_8_1[iter_8_0].w
		local var_8_1 = var_6.h
		local var_8_2

		if not var_6.type or not var_6.type then
			CastleGameRemind = var_8_2
			var_8_2 = var_8_2.remind_type_1
		end

		local var_8_3 = arg_8_0.gameRemind

		var_10.addRemind(var_8_3, var_8_0, var_8_1, var_8_2)
	end

	return
end

function var_0_0.itemChange(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_2 then
		table = var_1_10003

		if var_1_10003.contains(arg_9_0.items, arg_9_1) then
			return
		end

		table = var_3

		var_3.insert(arg_9_0.items, arg_9_1)
	else
		for iter_9_0 = 1, #arg_9_0.items do
			if arg_9_0.items[iter_9_0] == arg_9_1 then
				table = var_7

				var_7.remove(arg_9_0.items, iter_9_0)

				return
			end
		end
	end

	return
end

function var_0_0.start(arg_10_0)
	arg_10_0:prepareScene()

	local var_10_0 = arg_10_0.gameFloor

	var_1.start(var_10_0)

	local var_10_1 = arg_10_0.gameChar

	var_1.start(var_10_1)

	local var_10_2 = arg_10_0.gameItem

	var_1.start(var_10_2)

	local var_10_3 = arg_10_0.gameRemind

	var_1.start(var_10_3)

	local var_10_4 = arg_10_0.gameScore

	var_1.start(var_10_4)

	return
end

function var_0_0.step(arg_11_0)
	local var_11_0 = arg_11_0.gameFloor

	var_1.step(var_11_0)

	local var_11_1 = arg_11_0.gameChar

	var_1.step(var_11_1)

	local var_11_2 = arg_11_0.gameItem

	var_1.step(var_11_2)

	local var_11_3 = arg_11_0.gameRemind

	var_1.step(var_11_3)

	local var_11_4 = arg_11_0.gameScore

	var_1.step(var_11_4)
	arg_11_0:sortItems(arg_11_0.items)
	arg_11_0:updateActiveFloor()
	arg_11_0:checkPlayerInFloor()
	arg_11_0:checkPlayerInBubble()
	arg_11_0:checkPlayerCarriage()
	arg_11_0:checkPlayerInScore()

	return
end

function var_0_0.clear(arg_12_0)
	local var_12_0 = arg_12_0.gameFloor

	var_1.clear(var_12_0)

	local var_12_1 = arg_12_0.gameChar

	var_1.clear(var_12_1)

	local var_12_2 = arg_12_0.gameItem

	var_1.clear(var_12_2)

	local var_12_3 = arg_12_0.gameRemind

	var_1.clear(var_12_3)

	return
end

function var_0_0.stop(arg_13_0)
	return
end

function var_0_0.resume(arg_14_0)
	return
end

function var_0_0.dispose(arg_15_0)
	return
end

function var_0_0.prepareScene(arg_16_0)
	arg_16_0:showContainer(true)
	arg_16_0:sortItems(arg_16_0.floorItems)

	local var_16_0 = arg_16_0.gameChar

	var_1.setContent(var_16_0, arg_16_0:getContent(var_0_3))

	CastleGameVo = var_1

	local var_16_1 = var_1.PointFootLine

	Vector2 = var_16_0

	local var_16_2 = var_16_0(0, 0)

	Vector2 = var_3

	local var_16_3 = var_3(0, 100)

	Vector2 = var_4

	var_16_1(var_16_2, var_16_3, var_4(100, 0))

	return
end

function var_0_0.updateActiveFloor(arg_17_0)
	local var_17_0 = arg_17_0.gameFloor
	local var_17_1 = var_1.getActiveIndexs(var_17_0)
	local var_17_2 = arg_17_0.gameItem

	var_2.setFloorIndexs(var_17_2, var_17_1)

	local var_17_3 = arg_17_0.gameFloor
	local var_17_4 = var_2.getFloors(var_17_3)
	local var_17_5 = arg_17_0.gameScore

	var_3.setFloor(var_17_5, var_17_4)

	return
end

function var_0_0.checkPlayerInScore(arg_18_0)
	local var_18_0 = arg_18_0.gameChar

	if var_1.getActionAble(var_18_0) then
		local var_18_1 = arg_18_0.gameChar
		local var_18_2 = var_1.getChar(var_18_1).tf.anchoredPosition
		local var_18_3 = arg_18_0.gameScore
		local var_18_4 = var_3.getScores(var_18_3)

		for iter_18_0 = 1, #var_18_4 do
			if var_18_4[iter_18_0].ready == 0 then
				local var_18_5 = var_8.tf.anchoredPosition
				local var_18_6 = var_8.bmin
				local var_18_7 = var_8.bmax

				Vector2 = var_1_10012
				var_1_10012 = var_1_10012(var_18_5.x + var_18_6.x, var_18_5.y + var_18_6.y)
				Vector2 = var_13

				local var_18_8 = var_13(var_18_5.x + var_18_7.x, var_18_5.y + var_18_7.y)

				if var_18_2.x >= var_1_10012.x and var_18_2.y >= var_1_10012.y and var_18_2.x <= var_18_8.x and var_18_2.y <= var_18_8.y then
					arg_18_0:setPlayerScore(var_8, var_1)

					return
				end
			end
		end
	end

	return
end

function var_0_0.checkPlayerInBubble(arg_19_0)
	local var_19_0 = arg_19_0.gameChar

	if var_1.getActionAble(var_19_0) then
		local var_19_1 = arg_19_0.gameChar
		local var_19_2 = var_1.getChar(var_19_1).tf.anchoredPosition
		local var_19_3 = arg_19_0.gameItem
		local var_19_4 = var_3.getBubbles(var_19_3)

		for iter_19_0 = 1, #var_19_4 do
			if var_19_4[iter_19_0].ready == 0 and not var_8.broken then
				isActive = var_9

				if var_9(var_8.tf) and var_8.hit then
					local var_19_5 = var_8.tf.anchoredPosition
					local var_19_6 = var_8.bmin
					local var_19_7 = var_8.bmax

					Vector2 = var_1_10012
					var_1_10012 = var_1_10012(var_19_5.x + var_19_6.x, var_19_5.y + var_19_6.y)
					Vector2 = var_13

					local var_19_8 = var_13(var_19_5.x + var_19_7.x, var_19_5.y + var_19_7.y)

					if var_19_2.x >= var_1_10012.x and var_19_2.y >= var_1_10012.y and var_19_2.x <= var_19_8.x and var_19_2.y <= var_19_8.y then
						arg_19_0:setPlayerBubble(var_8, var_1)

						return
					end
				end
			end
		end
	end

	return
end

function var_0_0.checkPlayerBoom(arg_20_0)
	local var_20_0 = arg_20_0.gameChar

	if var_1.getActionAble(var_20_0) then
		local var_20_1 = arg_20_0.gameChar
		local var_20_2 = var_1.getChar(var_20_1).tf.anchoredPosition
		local var_20_3 = arg_20_0.gameItem
		local var_20_4 = var_3.getBooms(var_20_3)
		local var_20_5 = false

		for iter_20_0 = 1, #var_20_4 do
			if var_20_4[iter_20_0].ready and var_9.ready == 0 and not var_9.broken and var_9.brokenTime < 1 then
				local var_20_6 = var_9.boundPoints

				if not var_20_5 then
					CastleGameVo = var_11

					local var_20_7 = var_11.PointInTriangle(var_20_2, var_20_6[1], var_20_6[2], var_20_6[3])

					CastleGameVo = var_12

					local var_20_8 = var_12.PointInTriangle(var_20_2, var_20_6[3], var_20_6[4], var_20_6[1])

					if var_20_7 then
						var_20_5 = true
					elseif var_20_8 then
						var_20_5 = true
					end
				end

				if var_20_5 then
					local var_20_9 = arg_20_0.gameChar

					var_11.setPlayerFail(var_20_9)

					return
				end
			end
		end
	end

	return
end

function var_0_0.checkPlayerCarriage(arg_21_0)
	local var_21_0 = arg_21_0.gameChar

	if var_1.getActionAble(var_21_0) then
		local var_21_1 = arg_21_0.gameChar
		local var_21_2 = var_1.getChar(var_21_1).tf.anchoredPosition
		local var_21_3 = arg_21_0.gameItem
		local var_21_4 = var_3.getCarriages(var_21_3)

		for iter_21_0 = 1, #var_21_4 do
			local var_21_5 = var_21_4[iter_21_0].bmin
			local var_21_6 = var_8.bmax
			local var_21_7 = var_8.tf.anchoredPosition

			Vector2 = var_1_10012
			var_1_10012 = var_1_10012(var_21_7.x + var_21_5.x, var_21_7.y + var_21_5.y)
			Vector2 = var_13

			local var_21_8 = var_13(var_21_7.x + var_21_6.x, var_21_7.y + var_21_6.y)

			if var_21_2.x >= var_1_10012.x and var_21_2.y >= var_1_10012.y and var_21_2.x <= var_21_8.x and var_21_2.y <= var_21_8.y then
				local var_21_9 = arg_21_0.gameChar

				var_14.setPlayerFail(var_21_9)

				return
			end
		end
	end

	return
end

function var_0_0.setPlayerScore(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = arg_22_0.gameChar
	local var_22_1 = var_3.getChar(var_22_0)
	local var_22_2 = arg_22_0.gameChar

	var_4.setScore(var_22_2, arg_22_1)

	local var_22_3 = arg_22_0.gameScore

	var_4.hitScore(var_22_3, arg_22_1)

	local var_22_4 = arg_22_0._event
	local var_22_5 = var_4.emit

	CastleGameView = var_6

	var_22_5(var_22_4, var_6.ADD_SCORE, {
		num = arg_22_1.data.score,
		pos = var_22_1.tf.position,
		id = arg_22_1.id
	})

	return
end

function var_0_0.returnPlayerBubble(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = arg_23_0.gameChar

	var_3.setContent(var_23_0, arg_23_0.contentTop)

	local var_23_1 = arg_23_0.gameChar

	var_3.setInBubble(var_23_1, false)

	arg_23_1.char = nil

	return
end

function var_0_0.setPlayerBubble(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = arg_24_0.gameChar

	var_3.setInBubble(var_24_0, true)

	local var_24_1 = arg_24_0.gameChar
	local var_24_2 = var_3.setContent
	local var_24_3 = arg_24_1.pos

	Vector3 = var_1_10006

	var_24_2(var_24_1, var_24_3, var_1_10006(0, 0, 0))

	arg_24_1.char = arg_24_2

	local var_24_4 = arg_24_0.gameItem

	var_3.playerInBubble(var_24_4, arg_24_1, arg_24_2)

	return
end

function var_0_0.checkPlayerInFloor(arg_25_0)
	local var_25_0 = arg_25_0.gameChar

	if var_1.getActionAble(var_25_0) then
		local var_25_1 = arg_25_0.gameChar
		local var_25_2 = var_1.getChar(var_25_1).tf.anchoredPosition
		local var_25_3 = arg_25_0.gameFloor
		local var_25_4 = var_3.getFloors(var_25_3)
		local var_25_5 = false

		for iter_25_0 = 1, #var_25_4 do
			local var_25_6 = var_25_4[iter_25_0].bound

			if not var_25_5 then
				CastleGameVo = var_1_10011
				var_1_10011 = var_1_10011.PointInTriangle(var_25_2, var_25_6[1], var_25_6[2], var_25_6[3])
				CastleGameVo = var_12

				local var_25_7 = var_12.PointInTriangle(var_25_2, var_25_6[3], var_25_6[4], var_25_6[1])

				if var_1_10011 then
					var_25_5 = true
				elseif var_25_7 then
					var_25_5 = true
				end
			end

			if var_25_5 then
				var_1.floor = var_25_4[iter_25_0]

				if var_9.fall == true then
					arg_25_0:setCharFall()
				end

				return
			end
		end
	end

	return
end

function var_0_0.setCharFall(arg_26_0)
	local var_26_0 = arg_26_0.gameChar

	var_1.setInGround(var_26_0, false)

	return
end

function var_0_0.insertFloorItem(arg_27_0, arg_27_1)
	for iter_27_0 = 1, #arg_27_1 do
		table = var_1_10006

		var_1_10006.insert(arg_27_0.floorItems, arg_27_1[iter_27_0])
	end

	return
end

function var_0_0.getContent(arg_28_0, arg_28_1)
	local var_28_0

	if arg_28_1 == var_0_1 then
		var_28_0 = arg_28_0.contentBack
	elseif arg_28_1 == var_0_2 then
		var_28_0 = arg_28_0.contentMid
	elseif arg_28_1 == var_0_3 then
		var_28_0 = arg_28_0.contentTop
	elseif arg_28_1 == var_0_4 then
		var_28_0 = arg_28_0.contentEF
	end

	return var_28_0
end

function var_0_0.sortItems(arg_29_0, arg_29_1)
	table = var_1_10002

	var_1_10002.sort(arg_29_1, function(arg_30_0, arg_30_1)
		local var_30_0 = arg_30_0.tf.anchoredPosition
		local var_30_1 = arg_30_1.tf.anchoredPosition

		if var_30_0.y > var_30_1.y then
			return false
		elseif var_30_0.y < var_30_1.y then
			return true
		end

		if var_30_0.x > var_30_1.x then
			return false
		elseif var_30_0.x < var_30_1.x then
			return true
		end

		return false
	end)

	for iter_29_0 = 1, #arg_29_1 do
		local var_29_0 = arg_29_1[iter_29_0].tf

		var_6.SetSiblingIndex(var_29_0, 0)
	end

	return
end

function var_0_0.compareByPosition(arg_31_0, arg_31_1, arg_31_2)
	return
end

function var_0_0.compareWithPosBound(arg_32_0, arg_32_1, arg_32_2)
	local var_32_0 = arg_32_2[1]
	local var_32_1 = arg_32_2[4]

	CastleGameVo = var_1_10005

	return var_1_10005.PointLeftLine(arg_32_1, var_32_0, var_32_1)
end

function var_0_0.showContainer(arg_33_0, arg_33_1)
	setActive = var_1_10002

	var_1_10002(arg_33_0.sceneMask, arg_33_1)

	return
end

function var_0_0.press(arg_34_0, arg_34_1)
	local var_34_0 = arg_34_0.gameFloor

	var_2.press(var_34_0, arg_34_1)
	arg_34_0:sortItems(arg_34_0.floorItems)

	return
end

return var_0_0
