local BoatAdItemControl = class("BoatAdItemControl")
local var_0_1

function BoatAdItemControl:Ctor(arg_1_1, arg_1_2)
	var_0_1 = BoatAdGameVo
	self._tf = arg_1_1
	self._event = arg_1_2
	self._items = {}
	self._itemsPool = {}
	self._content = findTF(self._tf, "scene/content")

	return
end

function BoatAdItemControl:start()
	self:clear()

	self._rules = {}

	var_0_1.SetGameItems(self._items)

	return
end

function BoatAdItemControl:step(arg_3_1)
	for iter_3_0 = #self._items, 1, -1 do
		self._items[iter_3_0]:step(arg_3_1)

		if self._items[iter_3_0]:getRemoveFlag() then
			table.remove(self._items, iter_3_0)
			self:returnItem(self._items[iter_3_0])
		end
	end

	return
end

function BoatAdItemControl:dispose()
	return
end

function BoatAdItemControl:createItem(arg_5_1)
	local var_5_1 = self:getOrCreateItem(arg_5_1.id)

	var_5_1:start()
	var_5_1:setMoveCount(arg_5_1.move_count, arg_5_1.line)
	table.insert(self._items, var_5_1)

	return
end

function BoatAdItemControl:getOrCreateItem(arg_6_1, arg_6_2)
	local var_6_0

	if #self._itemsPool > 0 then
		for iter_6_0 = 1, #self._itemsPool do
			if self._itemsPool[iter_6_0]:getId() == arg_6_1 then
				var_6_0 = table.remove(self._itemsPool, iter_6_0)

				break
			end
		end
	end

	if not var_6_0 then
		if not BoatAdGameConst.game_item[arg_6_1] then
			print("不存在物品id" .. arg_6_1)
		end

		var_6_0 = BoatAdItem.New(var_0_1.GetGameTplTf(BoatAdGameConst.game_item[arg_6_1].tpl), self._event)

		var_6_0:setData(BoatAdGameConst.game_item[arg_6_1])
		var_6_0:setContent(self._content)
	end

	var_6_0:start()

	if arg_6_2 then
		var_6_0:setPosition(arg_6_2)
	end

	return var_6_0
end

function BoatAdItemControl:setMoveSpeed(arg_7_1)
	self._moveSpeed = arg_7_1

	for iter_7_0 = 1, #self._items do
		self._items[iter_7_0]:setSpeed(arg_7_1)
	end

	return
end

function BoatAdItemControl:stop()
	self.lastMoveSpeed = self._moveSpeed or 1

	self:setMoveSpeed(0)

	return
end

function BoatAdItemControl:resume()
	self:setMoveSpeed(self.lastMoveSpeed)

	return
end

function BoatAdItemControl:getMoveSpeed()
	return self._moveSpeed
end

function BoatAdItemControl:returnItem(arg_11_1)
	arg_11_1:clear()
	table.insert(self._itemsPool, arg_11_1)

	return
end

function BoatAdItemControl:clear()
	for iter_12_0 = #self._items, 1, -1 do
		local var_12_0 = table.remove(self._items, iter_12_0)

		var_12_0:clear()
		table.insert(self._itemsPool, var_12_0)
	end

	self._rules = {}

	self:setMoveSpeed(1)

	return
end

return BoatAdItemControl
