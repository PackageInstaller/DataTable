class = var_0_10000

local var_0_0 = var_0_10000("SailBoatItemControl")
local var_0_1

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	SailBoatGameVo = var_1_10003
	var_0_1 = var_1_10003
	arg_1_0._tf = arg_1_1
	arg_1_0._event = arg_1_2
	arg_1_0._items = {}
	arg_1_0._itemsPool = {}
	findTF = var_3
	arg_1_0._content = var_3(arg_1_0._tf, "scene/content")

	return
end

function var_0_0.start(arg_2_0)
	arg_2_0:clear()

	arg_2_0._rules = {}

	local var_2_0 = var_0_1.GetRoundData().item_rule

	for iter_2_0 = 1, #var_2_0 do
		SailBoatGameConst = var_1_10006
		var_1_10006 = var_1_10006.item_rule[var_2_0[iter_2_0]]
		table = var_7

		var_7.insert(arg_2_0._rules, {
			time = 0,
			data = var_1_10006
		})
	end

	var_0_1.SetGameItems(arg_2_0._items)

	return
end

function var_0_0.step(arg_3_0, arg_3_1)
	local var_3_0 = var_0_1.gameTime

	for iter_3_0 = 1, #arg_3_0._rules do
		if var_3_0 > arg_3_0._rules[iter_3_0].data.create_time[1] and var_3_0 < var_8[2] and var_7.time and var_7.time >= 0 then
			var_7.time = var_7.time - arg_3_1

			if var_7.time <= 0 then
				math = var_9
				var_7.time = var_9.random(var_7.data.time[1], var_7.data.time[2])

				arg_3_0:applyRule(var_7)
			end
		end
	end

	for iter_3_1 = #arg_3_0._items, 1, -1 do
		local var_3_1 = arg_3_0._items[iter_3_1]

		var_7.step(var_3_1, arg_3_1)

		if var_7:getRemoveFlag() then
			table = var_8

			var_8.remove(arg_3_0._items, iter_3_1)
			arg_3_0:returnItem(var_7)
		end
	end

	for iter_3_2 = #arg_3_0._rules, 1, -1 do
		local var_3_2 = arg_3_0._rules[iter_3_2].data

		if var_0_1.gameTime <= var_3_2.create_time[1] then
			table = var_8

			var_8.remove(arg_3_0._rules, iter_3_2)
		end
	end

	return
end

function var_0_0.dispose(arg_4_0)
	return
end

function var_0_0.applyRule(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1.data.items
	local var_5_1 = var_2.screen_pos_x
	local var_5_2 = var_2.screen_pos_y

	math = var_1_10006

	local var_5_3 = var_5_0[var_1_10006.random(1, #var_5_0)]

	if var_0_1.GetRangePos(var_5_1, var_5_2) then
		local var_5_4 = arg_5_0
		local var_5_5 = arg_5_0.getOrCreateItem(var_5_4, var_5_3, var_7)

		table = var_5_4

		var_5_4.insert(arg_5_0._items, var_5_5)
	end

	return
end

function var_0_0.getOrCreateItem(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0

	if #arg_6_0._itemsPool > 0 then
		for iter_6_0 = 1, #arg_6_0._itemsPool do
			local var_6_1 = arg_6_0._itemsPool[iter_6_0]

			if var_8.getId(var_6_1) == arg_6_1 then
				table = var_9
				var_6_0 = var_9.remove(arg_6_0._itemsPool, 1)

				break
			end
		end
	end

	if not var_6_0 then
		SailBoatGameConst = var_4

		local var_6_2 = var_4.game_item[arg_6_1]
		local var_6_3 = var_0_1.GetGameItemTf(var_6_2.tpl)

		SailBoatItem = var_6

		local var_6_4 = var_6.New(var_6_3, arg_6_0._event)

		var_6_0.setData(var_6_4, var_6_2)
		var_6_0:setContent(arg_6_0._content)
	end

	var_6_0:start()

	if arg_6_2 then
		var_6_0:setPosition(arg_6_2)
	end

	return var_6_0
end

function var_0_0.returnItem(arg_7_0, arg_7_1)
	arg_7_1:clear()

	table = var_2

	var_2.insert(arg_7_0._itemsPool, arg_7_1)

	return
end

function var_0_0.clear(arg_8_0)
	for iter_8_0 = #arg_8_0._items, 1, -1 do
		table = var_1_10005

		local var_8_0 = var_1_10005.remove(arg_8_0._items, iter_8_0)

		var_1_10005.clear(var_8_0)

		table = var_6

		var_6.insert(arg_8_0._itemsPool, var_1_10005)
	end

	arg_8_0._rules = {}

	return
end

return var_0_0
