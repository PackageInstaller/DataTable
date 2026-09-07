local SailBoatItemControl = class("SailBoatItemControl")
local var_0_1

function SailBoatItemControl:Ctor(arg_1_1, arg_1_2)
	var_0_1 = SailBoatGameVo
	self._tf = arg_1_1
	self._event = arg_1_2
	self._items = {}
	self._itemsPool = {}
	self._content = findTF(self._tf, "scene/content")

	return
end

function SailBoatItemControl:start()
	self:clear()

	self._rules = {}

	local var_2_0 = var_0_1.GetRoundData().item_rule

	for iter_2_0 = 1, #var_2_0 do
		table.insert(self._rules, {
			time = 0,
			data = SailBoatGameConst.item_rule[var_2_0[iter_2_0]]
		})
	end

	var_0_1.SetGameItems(self._items)

	return
end

function SailBoatItemControl:step(arg_3_1)
	for iter_3_0 = 1, #self._rules do
		if var_0_1.gameTime > self._rules[iter_3_0].data.create_time[1] and var_0_1.gameTime < self._rules[iter_3_0].data.create_time[2] and self._rules[iter_3_0].time and self._rules[iter_3_0].time >= 0 then
			self._rules[iter_3_0].time = self._rules[iter_3_0].time - arg_3_1

			if self._rules[iter_3_0].time <= 0 then
				self._rules[iter_3_0].time = math.random(self._rules[iter_3_0].data.time[1], self._rules[iter_3_0].data.time[2])

				self:applyRule(self._rules[iter_3_0])
			end
		end
	end

	for iter_3_1 = #self._items, 1, -1 do
		self._items[iter_3_1]:step(arg_3_1)

		if self._items[iter_3_1]:getRemoveFlag() then
			table.remove(self._items, iter_3_1)
			self:returnItem(self._items[iter_3_1])
		end
	end

	for iter_3_2 = #self._rules, 1, -1 do
		if var_0_1.gameTime <= self._rules[iter_3_2].data.create_time[1] then
			table.remove(self._rules, iter_3_2)
		end
	end

	return
end

function SailBoatItemControl:dispose()
	return
end

function SailBoatItemControl:applyRule(arg_5_1)
	local var_5_0 = var_0_1.GetRangePos(arg_5_1.data.screen_pos_x, arg_5_1.data.screen_pos_y)

	if var_5_0 then
		table.insert(self._items, (self:getOrCreateItem(arg_5_1.data.items[math.random(1, #arg_5_1.data.items)], var_5_0)))
	end

	return
end

function SailBoatItemControl:getOrCreateItem(arg_6_1, arg_6_2)
	local var_6_0

	if #self._itemsPool > 0 then
		for iter_6_0 = 1, #self._itemsPool do
			if self._itemsPool[iter_6_0]:getId() == arg_6_1 then
				var_6_0 = table.remove(self._itemsPool, 1)

				break
			end
		end
	end

	if not var_6_0 then
		var_6_0 = SailBoatItem.New(var_0_1.GetGameItemTf(SailBoatGameConst.game_item[arg_6_1].tpl), self._event)

		var_6_0:setData(SailBoatGameConst.game_item[arg_6_1])
		var_6_0:setContent(self._content)
	end

	var_6_0:start()

	if arg_6_2 then
		var_6_0:setPosition(arg_6_2)
	end

	return var_6_0
end

function SailBoatItemControl:returnItem(arg_7_1)
	arg_7_1:clear()
	table.insert(self._itemsPool, arg_7_1)

	return
end

function SailBoatItemControl:clear()
	for iter_8_0 = #self._items, 1, -1 do
		local var_8_0 = table.remove(self._items, iter_8_0)

		var_8_0:clear()
		table.insert(self._itemsPool, var_8_0)
	end

	self._rules = {}

	return
end

return SailBoatItemControl
