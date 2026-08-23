local TilemapNodePool = class("TilemapNodePool")
local var_0_1 = 3

function TilemapNodePool:ctor(arg_1_1)
	self._pool = {}
	arg_1_1 = arg_1_1 or {}
	self._mapNode = arg_1_1.mapNode
	self._poolNum = arg_1_1.poolNum or 1
	self._poolMaxNum = self._poolNum
	self._scale = 1
end

function TilemapNodePool:_isOutOfEye(arg_2_1, arg_2_2)
	arg_2_1 = arg_2_1 or 0
	arg_2_2 = arg_2_2 or 0

	local var_2_0 = cc.Director:getInstance():getWinSize()
	local var_2_1 = cc.p((arg_2_1 + self._mapNode:getPositionX() + var_2_0.width * (1 / self._scale) / 2) * self._scale, (arg_2_2 + self._mapNode:getPositionY() + var_2_0.height * (1 / self._scale) / 2) * self._scale)
	local var_2_2 = require("app.core.tilemap.TileMapFunc").getUnitCellWidth() / 2 + 25
	local var_2_3 = require("app.core.tilemap.TileMapFunc").getUnitCellHeight() / 2 + 25

	return var_2_1.x < -var_2_2 or var_2_1.x > var_2_0.width + var_2_2 or var_2_1.y < -var_2_3 or var_2_1.y > var_2_0.height + var_2_3
end

function TilemapNodePool:_checkNode(arg_3_1)
	if self:_isOutOfEye(arg_3_1.posX, arg_3_1.posY) then
		arg_3_1.isExist = false

		return false
	end

	if arg_3_1.isExist then
		return false
	end

	arg_3_1.isExist = true

	return true
end

function TilemapNodePool:_addNode(arg_4_1, arg_4_2)
	arg_4_2 = arg_4_2 or {}

	local var_4_0 = arg_4_2.posX or 0
	local var_4_1 = arg_4_2.posY or 0
	local var_4_2 = {
		node = arg_4_1,
		posX = var_4_0,
		posY = var_4_1,
		id = arg_4_2.id,
		resId = arg_4_2.resId
	}

	var_4_2.ref = 1
	var_4_2.outEye = false
	var_4_2.liveTime = g.core.common.ServerTime:getTime()

	table.insert(self._pool, var_4_2)
	arg_4_1:setData(arg_4_2)
end

function TilemapNodePool:_updateNode(arg_5_1, arg_5_2)
	arg_5_2 = arg_5_2 or {}
	arg_5_1.posX = arg_5_2.posX or 0
	arg_5_1.posY = arg_5_2.posY or 0
	arg_5_1.id = arg_5_2.id
	arg_5_1.resId = arg_5_2.resId
	arg_5_1.ref = arg_5_1.ref < 0 and 1 or arg_5_1.ref + 1
	arg_5_1.outEye = false
	arg_5_1.liveTime = g.core.common.ServerTime:getTime()

	arg_5_1.node:setData(arg_5_2)
end

function TilemapNodePool:findNode(arg_6_1)
	if not arg_6_1 then
		return nil
	end

	for iter_6_0, iter_6_1 in ipairs(self._pool) do
		if arg_6_1.id ~= nil and arg_6_1.id == iter_6_1.id or arg_6_1.posX == iter_6_1.posX and arg_6_1.posY == iter_6_1.posY then
			return iter_6_1
		end
	end

	return nil
end

function TilemapNodePool:removeNode(arg_7_1)
	local var_7_0 = self:findNode(arg_7_1)

	if not var_7_0 then
		return
	end

	var_7_0.posX = 0
	var_7_0.posY = 0

	if var_7_0.node and var_7_0.node.setCustomVisible then
		var_7_0.node:setCustomVisible(false)
	end
end

function TilemapNodePool:_getNode(arg_8_1)
	self:_updatePool()

	local var_8_0 = self:findNode(arg_8_1)

	if var_8_0 then
		return var_8_0
	end

	if #self._pool < self._poolMaxNum then
		return nil
	end

	local var_8_1

	for iter_8_0, iter_8_1 in ipairs(self._pool) do
		if iter_8_1.outEye then
			var_8_1 = var_8_1 or iter_8_1

			if not arg_8_1.resId or arg_8_1.resId == iter_8_1.resId then
				return iter_8_1
			end
		end
	end

	if var_8_1 then
		var_8_1.ref = 0
	end

	return var_8_1
end

function TilemapNodePool:_updatePool()
	table.sort(self._pool, function(arg_10_0, arg_10_1)
		return arg_10_0.ref > arg_10_1.ref
	end)

	for iter_9_0, iter_9_1 in ipairs(self._pool) do
		if self:_isOutOfEye(iter_9_1.posX, iter_9_1.posY) then
			iter_9_1.ref = iter_9_1.ref - 1
			iter_9_1.outEye = true

			if iter_9_1.node and iter_9_1.node.setCustomVisible then
				iter_9_1.node:setCustomVisible(false)
			end
		else
			iter_9_1.outEye = false
			iter_9_1.liveTime = g.core.common.ServerTime:getTime()
		end
	end

	self:_removeBack()
end

function TilemapNodePool:_removeBack()
	if #self._pool <= self._poolMaxNum then
		return
	end

	for iter_11_0 = #self._pool, 1, -1 do
		if self._pool[iter_11_0].outEye and g.core.common.ServerTime:getTime() - ((not self._pool[iter_11_0].liveTime or nil) and 0) > var_0_1 then
			if not tolua.isnull(self._pool[iter_11_0].node) then
				self._pool[iter_11_0].node:destory()

				self._pool[iter_11_0].node = nil
			end

			table.remove(self._pool, iter_11_0)

			if #self._pool <= self._poolMaxNum then
				break
			end
		end
	end
end

function TilemapNodePool:setCustomScale(arg_12_1)
	self._scale = arg_12_1
	self._poolMaxNum = math.floor(math.pow(1 / self._scale, 2) * self._poolNum)
end

function TilemapNodePool:setClear(arg_13_1)
	self._isClear = arg_13_1
end

function TilemapNodePool:isClear()
	return self._isClear
end

function TilemapNodePool:clearPool()
	for iter_15_0, iter_15_1 in ipairs(self._pool) do
		if not tolua.isnull(iter_15_1.node) then
			iter_15_1.node:destory()

			iter_15_1.node = nil
		end
	end

	self._pool = {}
end

function TilemapNodePool:updatePosYAsZOrder()
	for iter_16_0, iter_16_1 in ipairs(self._pool) do
		if not tolua.isnull(iter_16_1.node) then
			iter_16_1.node:setLocalZOrder(-iter_16_1.posY)

			if not tolua.isnull(iter_16_1.node:getUINode()) then
				iter_16_1.node:getUINode():setLocalZOrder(-iter_16_1.posY)
			end
		end
	end
end

return TilemapNodePool
