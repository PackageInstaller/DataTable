local var_0_0 = class("TouchCakeTowerController")
local var_0_1

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1 = TouchCakeGameVo
	arg_1_0._content = arg_1_1
	arg_1_0._event = arg_1_2
	arg_1_0._cakeContainer = findTF(arg_1_0._content, "container")
	arg_1_0.cakeItems = {}

	for iter_1_0 = 1, TouchCakeGameConst.max_cake_count do
		table.insert(arg_1_0.cakeItems, (TouchCakeItem.New(var_0_1.GetTplItemFromPool("CakeTpl", arg_1_0._cakeContainer), arg_1_0._event)))
	end

	arg_1_0._cakeContainerPool = findTF(arg_1_0._content, "containerPool")
	arg_1_0.cakeItemPool = {}

	return
end

function var_0_0.start(arg_2_0)
	arg_2_0.touchAble = true
	arg_2_0._moveBottomCallback = nil
	arg_2_0._cakeBottomPos = Vector2(TouchCakeGameConst.cake_init_pos[1], TouchCakeGameConst.cake_init_pos[2])
	arg_2_0._cakeContainer.anchoredPosition = arg_2_0._cakeBottomPos
	arg_2_0._cakeTargetHeight = arg_2_0._cakeBottomPos.y
	arg_2_0._cakeDownHeight = 0
	arg_2_0.removeTimeTick = nil
	arg_2_0.removeTimeTickCallback = nil

	for iter_2_0 = #arg_2_0.cakeItemPool, 1, -1 do
		local var_2_0 = arg_2_0:getItemFromPool()

		if var_2_0 then
			table.insert(arg_2_0.cakeItems, var_2_0)
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
		arg_3_0._cakeBottomPos.y = arg_3_0._cakeBottomPos.y - TouchCakeGameConst.cake_down_speed * var_0_1.deltaTime * math.sign(arg_3_0._cakeBottomPos.y - arg_3_0._cakeTargetHeight)

		if math.sign(arg_3_0._cakeBottomPos.y - arg_3_0._cakeTargetHeight) ~= math.sign(arg_3_0._cakeBottomPos.y - arg_3_0._cakeTargetHeight) then
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
		local var_4_0 = arg_4_0:getRandCakeData()
		local var_4_1
		local var_4_2

		if iter_4_0 ~= 1 then
			var_4_1, var_4_2 = arg_4_0:getRandPropDataByRate()
		end

		arg_4_0.cakeItems[iter_4_0]:setData(var_4_0, var_4_1, var_4_2)
	end

	return
end

function var_0_0.getRandCakeData(arg_5_0)
	return Clone(TouchCakeGameConst.cake_data[TouchCakeGameConst.cake_data.all[math.random(1, #TouchCakeGameConst.cake_data.all)]])
end

function var_0_0.getItemFromPool(arg_6_0)
	if #arg_6_0.cakeItemPool > 0 then
		local var_6_0 = table.remove(arg_6_0.cakeItemPool, 1)

		var_6_0:setParent(arg_6_0._cakeContainer)
		print("从pool中拿取item, pool长度 =" .. #arg_6_0.cakeItemPool)

		return var_6_0
	end

	return nil
end

function var_0_0.addItemPool(arg_7_0, arg_7_1)
	table.insert(arg_7_0.cakeItemPool, arg_7_1)
	arg_7_1:setParent(arg_7_0._cakeContainerPool)
	print("item放入pool  pool长度 =" .. #arg_7_0.cakeItemPool)

	return
end

function var_0_0.getRandPropDataByRate(arg_8_0)
	if not arg_8_0.weightTotal then
		arg_8_0.weightTotal = 0
		arg_8_0.weightData = {}

		for iter_8_0, iter_8_1 in ipairs(TouchCakeGameConst.prop_rate) do
			arg_8_0.weightTotal = arg_8_0.weightTotal + iter_8_1.weight

			local var_8_0 = 0

			if TouchCakeGameConst.prop_times and TouchCakeGameConst.prop_times[iter_8_1.id] then
				var_8_0 = TouchCakeGameConst.prop_times[iter_8_1.id].times
			end

			table.insert(arg_8_0.weightData, {
				weight = arg_8_0.weightTotal,
				id = iter_8_1.id,
				times = var_8_0
			})
		end
	end

	if not arg_8_0.propDirectPool or #arg_8_0.propDirectPool == 0 then
		arg_8_0.propDirectPool = Clone(TouchCakeGameConst.prop_random_direct[math.random(1, #TouchCakeGameConst.prop_random_direct)])
	end

	local var_8_1 = table.remove(arg_8_0.propDirectPool, 1)

	if var_8_1 == 0 then
		return nil
	end

	local var_8_2 = math.random(1, arg_8_0.weightTotal)
	local var_8_3

	for iter_8_2, iter_8_3 in ipairs(arg_8_0.weightData) do
		if not var_8_3 and var_8_2 <= iter_8_3.weight then
			if iter_8_3.times < 1000 then
				iter_8_3.times = iter_8_3.times - 1
			end

			if iter_8_3.times < 0 then
				print("道具id " .. iter_8_3.id .. "次数用尽")

				break
			end

			var_8_3 = iter_8_3.id

			break
		end
	end

	if var_8_3 and var_8_3 ~= 0 then
		return Clone(TouchCakeGameConst.prop_data[var_8_3]), var_8_1
	end

	return nil
end

function var_0_0.updateCakePos(arg_9_0)
	local var_9_0 = Vector2(0, 0)

	for iter_9_0 = 1, #arg_9_0.cakeItems do
		arg_9_0.cakeItems[iter_9_0]:setPosition(var_9_0)

		var_9_0 = arg_9_0.cakeItems[iter_9_0]:getTopPos()
	end

	for iter_9_1 = 1, #arg_9_0.cakeItems do
		arg_9_0.cakeItems[iter_9_1]:setLayerFirst()
	end

	return
end

function var_0_0.touchBottomCake(arg_10_0, arg_10_1, arg_10_2)
	if not arg_10_0:getTouchAble() then
		return
	end

	arg_10_0.touchAble = false

	seriesAsync({
		function(arg_11_0)
			arg_10_0:removeBottomCake(arg_10_1, arg_11_0)

			arg_10_0.removeTimeTick = TouchCakeGameConst.remove_time
			arg_10_0.removeTimeTickCallback = arg_11_0

			return
		end,
		function(arg_12_0)
			arg_10_0:activeCakeProp(arg_12_0)

			return
		end,
		function(arg_13_0)
			arg_10_0:moveCakeToBottom(arg_13_0)

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
	local var_16_0 = table.remove(arg_16_0.cakeItems, 1)

	arg_16_0:addItemPool(var_16_0)
	var_16_0:touchAction(arg_16_1, function()
		arg_16_0:addCakeToTop()

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
	local var_19_0 = arg_19_0:getItemFromPool()

	if var_19_0 then
		local var_19_1 = arg_19_0.cakeItems[#arg_19_0.cakeItems]:getPropDirect()

		var_19_0:setPosition((arg_19_0.cakeItems[#arg_19_0.cakeItems]:getTopPos()))

		local var_19_2, var_19_3 = arg_19_0:getRandPropDataByRate()

		var_19_0:setData(arg_19_0:getRandCakeData(), var_19_2, var_19_3)
		table.insert(arg_19_0.cakeItems, var_19_0)

		for iter_19_0 = 1, #arg_19_0.cakeItems do
			arg_19_0.cakeItems[iter_19_0]:setLayerFirst()
		end
	end

	return
end

function var_0_0.activeCakeProp(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_0.cakeItems[1]:propAction()

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
		arg_22_0.cakeItems[iter_22_0]:stop()
	end

	for iter_22_1 = 1, #arg_22_0.cakeItemPool do
		arg_22_0.cakeItemPool[iter_22_1]:stop()
	end

	return
end

function var_0_0.resume(arg_23_0)
	for iter_23_0 = 1, #arg_23_0.cakeItems do
		arg_23_0.cakeItems[iter_23_0]:resume()
	end

	for iter_23_1 = 1, #arg_23_0.cakeItemPool do
		arg_23_0.cakeItemPool[iter_23_1]:resume()
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
