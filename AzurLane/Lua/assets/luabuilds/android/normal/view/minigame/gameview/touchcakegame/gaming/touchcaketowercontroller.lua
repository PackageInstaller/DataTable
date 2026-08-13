class = var_0_10000

local var_0_0 = var_0_10000("TouchCakeTowerController")
local var_0_1

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	TouchCakeGameVo = var_1_10003
	var_0_1 = var_1_10003
	arg_1_0._content = arg_1_1
	arg_1_0._event = arg_1_2
	findTF = var_1_10003
	arg_1_0._cakeContainer = var_1_10003(arg_1_0._content, "container")
	arg_1_0.cakeItems = {}

	local var_1_0 = 1

	TouchCakeGameConst = var_4

	for iter_1_0 = var_1_0, var_4.max_cake_count do
		local var_1_1 = var_0_1.GetTplItemFromPool("CakeTpl", arg_1_0._cakeContainer)

		TouchCakeItem = var_8

		local var_1_2 = var_8.New(var_1_1, arg_1_0._event)

		table = var_9

		var_9.insert(arg_1_0.cakeItems, var_1_2)
	end

	findTF = var_1_0
	arg_1_0._cakeContainerPool = var_1_0(arg_1_0._content, "containerPool")
	arg_1_0.cakeItemPool = {}

	return
end

function var_0_0.start(arg_2_0)
	arg_2_0.touchAble = true
	arg_2_0._moveBottomCallback = nil
	Vector2 = var_1
	TouchCakeGameConst = var_1_10002

	local var_2_0 = var_1_10002.cake_init_pos[1]

	TouchCakeGameConst = var_1_10003
	arg_2_0._cakeBottomPos = var_1(var_2_0, var_1_10003.cake_init_pos[2])
	arg_2_0._cakeContainer.anchoredPosition = arg_2_0._cakeBottomPos
	arg_2_0._cakeTargetHeight = arg_2_0._cakeBottomPos.y
	arg_2_0._cakeDownHeight = 0
	arg_2_0.removeTimeTick = nil
	arg_2_0.removeTimeTickCallback = nil

	for iter_2_0 = #arg_2_0.cakeItemPool, 1, -1 do
		local var_2_1 = arg_2_0

		if arg_2_0.getItemFromPool(var_2_1) then
			table = var_2_1

			var_2_1.insert(arg_2_0.cakeItems, var_5)
		end
	end

	arg_2_0.weightTotal = nil

	arg_2_0:randomCakeData()
	arg_2_0:updateCakePos()

	return
end

function var_0_0.step(arg_3_0)
	if arg_3_0.removeTimeTick and arg_3_0.removeTimeTick >= 0 then
		arg_3_0.removeTimeTick = arg_3_0.removeTimeTick - var_0_1.deltaTime

		if arg_3_0.removeTimeTick <= 0 then
			arg_3_0.removeTimeTick = nil

			if arg_3_0.removeTimeTickCallback then
				arg_3_0.removeTimeTickCallback()
			end
		end
	end

	if arg_3_0._cakeBottomPos.y ~= arg_3_0._cakeTargetHeight then
		math = var_1

		local var_3_0 = var_1.sign(arg_3_0._cakeBottomPos.y - arg_3_0._cakeTargetHeight)

		TouchCakeGameConst = var_2

		local var_3_1 = var_2.cake_down_speed * var_0_1.deltaTime

		math = var_3

		local var_3_2 = var_3_1 * var_3.sign(arg_3_0._cakeBottomPos.y - arg_3_0._cakeTargetHeight)
		local var_3_3 = arg_3_0._cakeBottomPos

		var_3_3.y = arg_3_0._cakeBottomPos.y - var_3_2
		math = var_3_3

		if var_3_3.sign(arg_3_0._cakeBottomPos.y - arg_3_0._cakeTargetHeight) ~= var_3_0 then
			arg_3_0._cakeBottomPos.y = arg_3_0._cakeTargetHeight
		end

		arg_3_0._cakeContainer.anchoredPosition = arg_3_0._cakeBottomPos
	end

	if arg_3_0._moveBottomCallback and arg_3_0._cakeBottomPos.y == arg_3_0._cakeTargetHeight then
		arg_3_0._moveBottomCallback()

		arg_3_0._moveBottomCallback = nil
	end

	return
end

function var_0_0.randomCakeData(arg_4_0)
	for iter_4_0 = 1, #arg_4_0.cakeItems do
		local var_4_0 = arg_4_0.cakeItems[iter_4_0]
		local var_4_1 = arg_4_0:getRandCakeData()
		local var_4_2
		local var_4_3

		if iter_4_0 ~= 1 then
			var_4_2, var_4_3 = arg_4_0:getRandPropDataByRate()
		end

		var_4_0:setData(var_4_1, var_4_2, var_4_3)
	end

	return
end

function var_0_0.getRandCakeData(arg_5_0)
	Clone = var_1_10001
	TouchCakeGameConst = var_1_10002

	local var_5_0 = var_1_10002.cake_data

	TouchCakeGameConst = var_1_10003

	local var_5_1 = var_1_10003.cake_data.all

	math = var_1_10004

	local var_5_2 = var_1_10004.random
	local var_5_3 = 1

	TouchCakeGameConst = var_1_10006

	return var_1_10001(var_5_0[var_5_1[var_5_2(var_5_3, #var_1_10006.cake_data.all)]])
end

function var_0_0.getItemFromPool(arg_6_0)
	if #arg_6_0.cakeItemPool > 0 then
		table = var_1

		local var_6_0 = var_1.remove(arg_6_0.cakeItemPool, 1)

		var_1.setParent(var_6_0, arg_6_0._cakeContainer)

		print = var_2

		var_2("从pool中拿取item, pool长度 =" .. #arg_6_0.cakeItemPool)

		return var_1
	end

	return nil
end

function var_0_0.addItemPool(arg_7_0, arg_7_1)
	table = var_1_10002

	var_1_10002.insert(arg_7_0.cakeItemPool, arg_7_1)
	arg_7_1:setParent(arg_7_0._cakeContainerPool)

	print = var_2

	var_2("item放入pool  pool长度 =" .. #arg_7_0.cakeItemPool)

	return
end

function var_0_0.getRandPropDataByRate(arg_8_0)
	if not arg_8_0.weightTotal then
		arg_8_0.weightTotal = 0
		arg_8_0.weightData = {}
		ipairs = var_1
		TouchCakeGameConst = var_1_10002

		for iter_8_0, iter_8_1 in var_1(var_1_10002.prop_rate) do
			arg_8_0.weightTotal = arg_8_0.weightTotal + iter_8_1.weight

			local var_8_0 = 0

			TouchCakeGameConst = var_7

			if var_7.prop_times then
				TouchCakeGameConst = var_7

				if var_7.prop_times[iter_8_1.id] then
					TouchCakeGameConst = var_7
					var_8_0 = var_7.prop_times[iter_8_1.id].times
				end
			end

			table = var_7

			var_7.insert(arg_8_0.weightData, {
				weight = arg_8_0.weightTotal,
				id = iter_8_1.id,
				times = var_8_0
			})
		end
	end

	if not arg_8_0.propDirectPool or #arg_8_0.propDirectPool == 0 then
		Clone = var_1
		TouchCakeGameConst = var_1_10002

		local var_8_1 = var_1_10002.prop_random_direct

		math = var_1_10003

		local var_8_2 = var_1_10003.random
		local var_8_3 = 1

		TouchCakeGameConst = iter_8_1
		arg_8_0.propDirectPool = var_1(var_8_1[var_8_2(var_8_3, #iter_8_1.prop_random_direct)])
	end

	table = var_1

	if var_1.remove(arg_8_0.propDirectPool, 1) == 0 then
		return nil
	end

	math = var_2

	local var_8_4 = var_2.random(1, arg_8_0.weightTotal)
	local var_8_5

	ipairs = var_4

	for iter_8_2, iter_8_3 in var_4(arg_8_0.weightData) do
		if not var_8_5 and var_8_4 <= iter_8_3.weight then
			if iter_8_3.times < 1000 then
				iter_8_3.times = iter_8_3.times - 1
			end

			if iter_8_3.times < 0 then
				print = var_9

				var_9("道具id " .. iter_8_3.id .. "次数用尽")

				break
			end

			var_8_5 = iter_8_3.id

			break
		end
	end

	if var_8_5 and var_8_5 ~= 0 then
		Clone = var_4
		TouchCakeGameConst = var_5

		return var_4(var_5.prop_data[var_8_5]), var_1
	end

	return nil
end

function var_0_0.updateCakePos(arg_9_0)
	Vector2 = var_1_10001

	local var_9_0 = var_1_10001(0, 0)

	for iter_9_0 = 1, #arg_9_0.cakeItems do
		local var_9_1 = arg_9_0.cakeItems[iter_9_0]

		var_6.setPosition(var_9_1, var_9_0)

		var_9_0 = var_6:getTopPos()
	end

	for iter_9_1 = 1, #arg_9_0.cakeItems do
		local var_9_2 = arg_9_0.cakeItems[iter_9_1]

		var_6.setLayerFirst(var_9_2)
	end

	return
end

function var_0_0.touchBottomCake(arg_10_0, arg_10_1, arg_10_2)
	if not arg_10_0:getTouchAble() then
		return
	end

	arg_10_0.touchAble = false
	seriesAsync = var_3

	var_3({
		function(arg_11_0)
			local var_11_0 = arg_10_0

			var_1.removeBottomCake(var_11_0, arg_10_1, arg_11_0)

			local var_11_1 = arg_10_0

			TouchCakeGameConst = var_11_0
			var_11_1.removeTimeTick = var_11_0.remove_time
			arg_10_0.removeTimeTickCallback = arg_11_0

			return
		end,
		function(arg_12_0)
			local var_12_0 = arg_10_0

			var_1.activeCakeProp(var_12_0, arg_12_0)

			return
		end,
		function(arg_13_0)
			local var_13_0 = arg_10_0

			var_1.moveCakeToBottom(var_13_0, arg_13_0)

			return
		end
	}, function()
		arg_10_0.touchAble = true

		return
	end)

	return
end

function var_0_0.getTouchAble(arg_15_0)
	return arg_15_0.touchAble
end

function var_0_0.removeBottomCake(arg_16_0, arg_16_1, arg_16_2)
	table = var_1_10003

	local var_16_0 = var_1_10003.remove(arg_16_0.cakeItems, 1)

	arg_16_0:addItemPool(var_16_0)
	var_16_0:touchAction(arg_16_1, function()
		local var_17_0 = arg_16_0

		var_0.addCakeToTop(var_17_0)

		return
	end)

	arg_16_0._cakeDownHeight = arg_16_0._cakeDownHeight - var_16_0:getCakeConfig("height")

	return
end

function var_0_0.moveCakeToBottom(arg_18_0, arg_18_1)
	arg_18_0._cakeTargetHeight = arg_18_0._cakeDownHeight
	arg_18_0._moveBottomCallback = arg_18_1

	return
end

function var_0_0.addCakeToTop(arg_19_0)
	if arg_19_0:getItemFromPool() then
		local var_19_0 = arg_19_0.cakeItems[#arg_19_0.cakeItems]
		local var_19_1 = var_2.getTopPos(var_19_0)
		local var_19_2 = var_2:getPropDirect()

		var_1:setPosition(var_19_1)

		local var_19_3, var_19_4 = arg_19_0:getRandPropDataByRate()

		var_1:setData(arg_19_0:getRandCakeData(), var_19_3, var_19_4)

		table = var_7

		var_7.insert(arg_19_0.cakeItems, var_1)

		for iter_19_0 = 1, #arg_19_0.cakeItems do
			local var_19_5 = arg_19_0.cakeItems[iter_19_0]

			var_11.setLayerFirst(var_19_5)
		end
	end

	return
end

function var_0_0.activeCakeProp(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_0.cakeItems[1]
	local var_20_1 = var_2.propAction(var_20_0)

	if arg_20_1 then
		arg_20_1()
	end

	return
end

function var_0_0.onKeyCode(arg_21_0)
	return
end

function var_0_0.stop(arg_22_0)
	for iter_22_0 = 1, #arg_22_0.cakeItems do
		local var_22_0 = arg_22_0.cakeItems[iter_22_0]

		var_5.stop(var_22_0)
	end

	for iter_22_1 = 1, #arg_22_0.cakeItemPool do
		local var_22_1 = arg_22_0.cakeItemPool[iter_22_1]

		var_5.stop(var_22_1)
	end

	return
end

function var_0_0.resume(arg_23_0)
	for iter_23_0 = 1, #arg_23_0.cakeItems do
		local var_23_0 = arg_23_0.cakeItems[iter_23_0]

		var_5.resume(var_23_0)
	end

	for iter_23_1 = 1, #arg_23_0.cakeItemPool do
		local var_23_1 = arg_23_0.cakeItemPool[iter_23_1]

		var_5.resume(var_23_1)
	end

	return
end

function var_0_0.clear(arg_24_0)
	return
end

function var_0_0.dispose(arg_25_0)
	return
end

return var_0_0
