local var_0_0 = class("BoatAdItemControl")
local var_0_1

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1 = BoatAdGameVo
	arg_1_0._tf = arg_1_1
	arg_1_0._event = arg_1_2
	arg_1_0._items = {}
	arg_1_0._itemsPool = {}
	arg_1_0._content = findTF(arg_1_0._tf, "scene/content")

	return
end

function var_0_0.start(arg_2_0)
	arg_2_0:clear()

	arg_2_0._rules = {}

	var_0_1.SetGameItems(arg_2_0._items)

	return
end

function var_0_0.step(arg_3_0, arg_3_1)
	for iter_3_0 = #arg_3_0._items, 1, -1 do
		arg_3_0._items[iter_3_0]:step(arg_3_1)

		if arg_3_0._items[iter_3_0]:getRemoveFlag() then
			table.remove(arg_3_0._items, iter_3_0)
			arg_3_0:returnItem(arg_3_0._items[iter_3_0])
		end
	end

	return
end

function var_0_0.dispose(arg_4_0)
	return
end

function var_0_0.createItem(arg_5_0, arg_5_1)
	local var_5_1 = arg_5_0:getOrCreateItem(arg_5_1.id)

	var_5_1:start()
	var_5_1:setMoveCount(arg_5_1.move_count, arg_5_1.line)
	table.insert(arg_5_0._items, var_5_1)

	return
end

function var_0_0.getOrCreateItem(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0

	if #arg_6_0._itemsPool > 0 then
		for iter_6_0 = 1, #arg_6_0._itemsPool do
			if arg_6_0._itemsPool[iter_6_0]:getId() == arg_6_1 then
				var_6_0 = table.remove(arg_6_0._itemsPool, iter_6_0)

				break
			end
		end
	end

	if not var_6_0 then
		if not BoatAdGameConst.game_item[arg_6_1] then
			print("不存在物品id" .. arg_6_1)
		end

		var_6_0 = BoatAdItem.New(var_0_1.GetGameTplTf(BoatAdGameConst.game_item[arg_6_1].tpl), arg_6_0._event)

		var_6_0:setData(BoatAdGameConst.game_item[arg_6_1])
		var_6_0:setContent(arg_6_0._content)
	end

	var_6_0:start()

	if arg_6_2 then
		var_6_0:setPosition(arg_6_2)
	end

	return var_6_0
end

function var_0_0.setMoveSpeed(arg_7_0, arg_7_1)
	arg_7_0._moveSpeed = arg_7_1

	for iter_7_0 = 1, #arg_7_0._items do
		arg_7_0._items[iter_7_0]:setSpeed(arg_7_1)
	end

	return
end

function var_0_0.stop(arg_8_0)
	arg_8_0.lastMoveSpeed = arg_8_0._moveSpeed or 1

	arg_8_0:setMoveSpeed(0)

	return
end

function var_0_0.resume(arg_9_0)
	arg_9_0:setMoveSpeed(arg_9_0.lastMoveSpeed)

	return
end

function var_0_0.getMoveSpeed(arg_10_0)
	return arg_10_0._moveSpeed
end

function var_0_0.returnItem(arg_11_0, arg_11_1)
	arg_11_1:clear()
	table.insert(arg_11_0._itemsPool, arg_11_1)

	return
end

function var_0_0.clear(arg_12_0)
	for iter_12_0 = #arg_12_0._items, 1, -1 do
		local var_12_0 = table.remove(arg_12_0._items, iter_12_0)

		var_12_0:clear()
		table.insert(arg_12_0._itemsPool, var_12_0)
	end

	arg_12_0._rules = {}

	arg_12_0:setMoveSpeed(1)

	return
end

return var_0_0
