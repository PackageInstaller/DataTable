local TileMapFunc = require("app.core.tilemap.TileMapFunc")
local BaseMapNode = class("BaseMapNode", function()
	return cc.Node:create()
end)

function BaseMapNode:p2s(arg_2_1)
	return self .. "_" .. arg_2_1
end

local var_0_2 = BaseMapNode.p2s

local function var_0_4(arg_4_0, arg_4_1)
	local var_4_0 = 0
	local var_4_1 = 0

	if type(arg_4_0) == "table" then
		var_4_0 = arg_4_0.x
		var_4_1 = arg_4_0.y
	else
		var_4_0 = arg_4_0
		var_4_1 = arg_4_1
	end

	return var_4_0, var_4_1
end

BaseMapNode.dealPos = var_0_4

local var_0_5 = 25
local var_0_6 = 500
local var_0_7 = 5
local var_0_8 = 200
local var_0_9 = 2
local var_0_10 = 25
local var_0_11 = {
	"_floorNode",
	"_objectNode",
	"_pathNode",
	"_topNode"
}

function BaseMapNode:ctor(arg_5_1)
	self:enableNodeEvents(true)

	self._layerList = var_0_11
	self._mapComp = arg_5_1
	self._maxScale = 1
	self._scale = 1
	self._nTouchedX = 0
	self._nTouchedY = 0
	self._nClickTouchX = 0
	self._nClickTouchY = 0
	self._nTouchBeginTime = 0
	self._isMapScrolling = false
	self._nMapScrollLeftTime = 0
	self._nMapScrollSpeed = 0
	self._tMapScrollDir = nil
	self._nMapPosX = 0
	self._nMapPosY = 0
	self._doMoveAction = false
	self._blockMap = {}
	self._canUpdateArrow = true
	self._arrowOffsetX = 0
	self._arrowOffsetY = 0
	self._borderLeftX = 0
	self._borderRightX = 0
	self._borderBottomY = 0
	self._x = 0
	self._y = 0
	self._showSize = cc.size(display.width, display.height)
	self._myRealPos = cc.p(0, 0)
	self._myPos = cc.p(0, 0)
	self._tiledMapData = {}
	self._objects = {}
	self._mapData = {}
	self._baseNodes = {}
	self._distance = math.sqrt(math.pow(TileMapFunc.getUnitCellWidth(), 2) + math.pow(TileMapFunc.getUnitCellHeight(), 2)) / 2
	self._mapNode = cc.Node:create()

	self:addChild(self._mapNode)
	self:_initTileMap()
end

function BaseMapNode:getMapNode()
	return self._mapNode
end

function BaseMapNode:onEnter()
	return
end

function BaseMapNode:addNodes()
	for iter_8_0, iter_8_1 in ipairs(self._layerList) do
		self:addLayer(iter_8_1, 10)
	end
end

function BaseMapNode:addLayer(arg_9_1, arg_9_2)
	local var_9_0 = cc.Node:create()

	var_9_0:setLocalZOrder(arg_9_2)
	self._mapNode:addChild(var_9_0)

	self[arg_9_1] = var_9_0
end

function BaseMapNode:_initTileMap()
	local var_10_0 = TileMapFunc.getConstShowNum() * TileMapFunc.getConstIncludeNum()
	local var_10_1 = TileMapFunc.getConstVerTex().TOP_LEFT
	local var_10_2 = {
		x = var_10_0 - var_10_1.x - 1,
		y = var_10_0 - var_10_1.y - 1
	}
	local var_10_3, var_10_4 = TileMapFunc.rc2p(var_10_1.x, var_10_1.y)
	local var_10_5, var_10_6 = TileMapFunc.rc2p(var_10_2.x, var_10_2.y)

	self._borderLeftX = var_10_3
	self._borderRightX = var_10_5
	self._borderBottomY = var_10_6
	self._borderTopY = var_10_4

	self:_initMapData()
end

function BaseMapNode:_initMapData()
	local function var_11_0(arg_12_0, arg_12_1)
		self._mapData[var_0_2(arg_12_0, arg_12_1)] = cc.p(arg_12_0, arg_12_1)
	end

	local var_11_1 = TileMapFunc.getConstVerTex()
	local var_11_2 = TileMapFunc.getConstShowNum() * TileMapFunc.getConstIncludeNum()
	local var_11_3 = {
		x = var_11_1.TOP_LEFT.x + 1,
		y = var_11_1.TOP_LEFT.y
	}
	local var_11_4 = ({
		x = var_11_2 - var_11_3.y - 1,
		y = var_11_2 - var_11_3.x - 1
	}).x - var_11_3.x + 1
	local var_11_5 = var_11_3.y

	for iter_11_0 = 1, var_11_4 do
		local var_11_6 = var_11_3.x + iter_11_0 - 1
		local var_11_7 = var_11_5

		for iter_11_1 = 1, var_11_3.y - var_11_3.x + 1 do
			var_11_0(var_11_6, var_11_7)

			var_11_7 = var_11_7 - 1
			var_11_6 = var_11_6 + 1
		end

		var_11_5 = var_11_5 + 1
	end

	local var_11_8 = var_11_3.y

	for iter_11_2 = 1, var_11_4 - 1 do
		local var_11_9 = var_11_3.x + iter_11_2
		local var_11_10 = var_11_8

		for iter_11_3 = 1, var_11_3.y - var_11_3.x + 1 - 1 do
			var_11_0(var_11_9, var_11_10)

			var_11_10 = var_11_10 - 1
			var_11_9 = var_11_9 + 1
		end

		var_11_8 = var_11_8 + 1
	end

	local var_11_11 = {
		x = var_11_1.VIRTUAL_LEFT.x + 1,
		y = var_11_1.VIRTUAL_LEFT.y
	}

	self._borderX = (var_11_11.y - var_11_11.x + 1) * 2 - 1
	self._borderY = (({
		x = var_11_2 - var_11_11.y - 1,
		y = var_11_2 - var_11_11.x - 1
	}).x - var_11_11.x + 1) * 2 - 1

	self:_initAStar()
end

function BaseMapNode:_initAStar()
	self._aStar = require("app.core.utils.AStar").new()

	self._aStar:setCalcNeighborFunc(handler(self, function(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
		local var_14_0 = {}

		for iter_14_0, iter_14_1 in ipairs({
			{
				x = -1,
				y = 0
			},
			{
				x = 1,
				y = 0
			},
			{
				x = 0,
				y = -1
			},
			{
				x = 0,
				y = 1
			}
		}) do
			local var_14_1 = {
				x = arg_14_1.x + iter_14_1.x,
				y = arg_14_1.y + iter_14_1.y
			}

			if self:_isMapContainPoint(var_14_1) and (not self:_isBarrier(var_14_1) or var_14_1.x == arg_14_3.x and var_14_1.y == arg_14_3.y) then
				table.insert(var_14_0, var_14_1)
			end
		end

		return var_14_0
	end))
	self._aStar:setCalcDistFunc(handler(self, function(arg_15_0, arg_15_1, arg_15_2)
		return math.abs(arg_15_1.x - arg_15_2.x) + math.abs(arg_15_1.y - arg_15_2.y)
	end))
	self._aStar:setEstimateCostFunc(handler(self, function(arg_16_0, arg_16_1, arg_16_2)
		return math.abs(arg_16_1.x - arg_16_2.x) + math.abs(arg_16_1.y - arg_16_2.y)
	end))
end

function BaseMapNode:jumpToPos(arg_17_1, arg_17_2, arg_17_3)
	local var_17_0, var_17_1 = var_0_4(arg_17_1, arg_17_2)

	if arg_17_3 then
		self:_moveRealPosToCenter(var_17_0, var_17_1, handler(self, function()
			self:_clickMapCell(var_17_0, var_17_1, nil, true)
		end))
	else
		self:_moveRealPosToCenter(var_17_0, var_17_1)
		self:_updateEyeArea()
		self:_clickMapCell(var_17_0, var_17_1, nil, true)
	end
end

function BaseMapNode:jumpToPosFinish(arg_19_1, arg_19_2, arg_19_3)
	local var_19_0, var_19_1 = var_0_4(arg_19_1, arg_19_2)

	self:_moveRealPosToCenter(var_19_0, var_19_1, arg_19_3)
end

function BaseMapNode:_jumpToPlayer(arg_20_1)
	local var_20_0 = self._myRealPos or cc.p(0, 0)
	local var_20_1, var_20_2 = TileMapFunc.rc2p(var_20_0.x, var_20_0.y)

	self:_movePosToCenter(var_20_1, var_20_2, arg_20_1)
end

function BaseMapNode:_moveRealPosToCenter(arg_21_1, arg_21_2, arg_21_3)
	local var_21_0, var_21_1 = TileMapFunc.rc2p(arg_21_1, arg_21_2)

	self:_movePosToCenter(var_21_0, var_21_1, arg_21_3)
end

function BaseMapNode:_movePosToCenter(arg_22_1, arg_22_2, arg_22_3)
	local var_22_0 = cc.Director:getInstance():getWinSize()

	self:_moveMapAndCheckBorder(((arg_22_1 + self._mapNode:getPositionX() + var_22_0.width * (1 / self._scale) / 2) * self._scale - var_22_0.width / 2) * (1 / self._scale), ((arg_22_2 + self._mapNode:getPositionY() + var_22_0.height * (1 / self._scale) / 2) * self._scale - var_22_0.height / 2) * (1 / self._scale), arg_22_3)
end

function BaseMapNode:_moveMapAndCheckBorder(arg_23_1, arg_23_2, arg_23_3)
	arg_23_1 = arg_23_1 or 0
	arg_23_2 = arg_23_2 or 0

	local var_23_0 = self._mapNode:getPositionX()
	local var_23_1 = self._mapNode:getPositionY()
	local var_23_2 = math.max(math.min(var_23_0 - arg_23_1, -self._borderLeftX - self._x), -self._borderRightX + self._showSize.width - self._x)
	local var_23_3 = math.max(math.min(var_23_1 - arg_23_2, -self._borderBottomY - self._y), -self._borderTopY + self._showSize.height - self._y)

	if var_23_0 ~= var_23_2 or var_23_1 ~= var_23_3 then
		if arg_23_3 then
			self._doMoveAction = true

			self._mapNode:runAction(cc.Sequence:create(cc.EaseOut:create(cc.MoveTo:create(0.3, cc.p(var_23_2, var_23_3)), 3), cc.CallFunc:create(handler(self, function()
				self._doMoveAction = false
				self._lastCenter = nil

				self:eventHandler("TileMap_moveMapAndCheckBorder_over")
				self:_updateMap(true)

				if type(arg_23_3) == "function" then
					arg_23_3()
				end
			end))))
		else
			self._mapNode:setPosition(cc.p(var_23_2, var_23_3))
		end
	elseif arg_23_3 and type(arg_23_3) == "function" then
		arg_23_3()
	end
end

function BaseMapNode:getCenterPos()
	return (cc.p(-self._mapNode:getPositionX(), -self._mapNode:getPositionY()))
end

function BaseMapNode:getWindowPos(arg_26_1)
	local var_26_0 = cc.p(-self._mapNode:getPositionX(), -self._mapNode:getPositionY())

	return (cc.p((arg_26_1.x - var_26_0.x) * self._scale + display.width / 2, (arg_26_1.y - var_26_0.y) * self._scale + display.height / 2))
end

function BaseMapNode:_updateMap(arg_27_1)
	local var_27_0 = cc.p(-self._mapNode:getPositionX(), -self._mapNode:getPositionY())

	self:updateArrowComp()

	if self._lastCenter and math.abs(self._lastCenter.x - var_27_0.x) <= var_0_5 * 2 and math.abs(self._lastCenter.y - var_27_0.y) <= var_0_5 * 2 then
		return
	end

	self._lastCenter = var_27_0

	self:_createEyeTileMap()

	if arg_27_1 then
		if not self:_getServerBlockInfo() then
			self:_updatePool()
		end
	else
		self:_updatePool()
	end
end

function BaseMapNode:_updateMyPos(arg_28_1)
	return
end

function BaseMapNode:_updateEyeArea()
	local var_29_0 = cc.p(-self._mapNode:getPositionX(), -self._mapNode:getPositionY())
	local var_29_1, var_29_2 = TileMapFunc.p2rc(var_29_0.x, var_29_0.y)
	local var_29_3, var_29_4 = TileMapFunc.rc2uc(var_29_1, var_29_2)

	self._tiledMapData[var_29_3] = self._tiledMapData[var_29_3] or {}

	if not self._tiledMapData[var_29_3][var_29_4] then
		self:_removeAllTileMap()
	end

	self:_updateMap(true)
end

function BaseMapNode:_createEyeTileMap()
	self._outEye = self._outEye or {}

	local var_30_0 = self:_getEyeTileMap()
	local var_30_1 = false

	if var_30_0 and next(var_30_0) then
		for iter_30_0, iter_30_1 in ipairs(var_30_0) do
			if not self._outEye[var_0_2(iter_30_1.x, iter_30_1.y)] then
				self._outEye[var_0_2(iter_30_1.x, iter_30_1.y)] = {}
				self._outEye[var_0_2(iter_30_1.x, iter_30_1.y)].pos = {
					x = iter_30_1.x,
					y = iter_30_1.y
				}
			end

			self._outEye[var_0_2(iter_30_1.x, iter_30_1.y)].ref = 0

			if self:_createTileMap(iter_30_0, iter_30_1.x, iter_30_1.y) then
				var_30_1 = true
			end
		end
	end

	if var_30_1 then
		for iter_30_2, iter_30_3 in pairs(self._outEye) do
			iter_30_3.ref = iter_30_3.ref + 1
		end

		self:_checkOutEyeTileMap()
	end
end

function BaseMapNode:_getEyeTileMap()
	local var_31_0 = cc.p(-self._mapNode:getPositionX(), -self._mapNode:getPositionY())
	local var_31_1 = TileMapFunc.getConstIncludeNum()
	local var_31_2 = TileMapFunc.getUnitCellWidth() * var_31_1 * 0.5
	local var_31_3 = TileMapFunc.getUnitCellHeight() * var_31_1 * 0.5

	if self._curArea and self:_isInArea(var_31_0, self._curArea, var_31_2, var_31_3) then
		return nil, nil
	end

	local var_31_4, var_31_5 = TileMapFunc.p2rc(var_31_0.x, var_31_0.y)
	local var_31_6, var_31_7 = TileMapFunc.rc2uc(var_31_4, var_31_5)
	local var_31_8, var_31_9 = TileMapFunc.uc2p(var_31_6, var_31_7)
	local var_31_10 = {
		cc.p(var_31_6, var_31_7),
		cc.p(var_31_6 - 1, var_31_7 + 1),
		cc.p(var_31_6 + 1, var_31_7 - 1),
		cc.p(var_31_6 - 1, var_31_7 - 1),
		cc.p(var_31_6 + 1, var_31_7 + 1),
		cc.p(var_31_6 - 1, var_31_7),
		cc.p(var_31_6 + 1, var_31_7),
		cc.p(var_31_6, var_31_7 + 1),
		cc.p(var_31_6, var_31_7 - 1)
	}
	local var_31_11 = {}
	local var_31_12 = {}

	if self:_isInArea(var_31_0, cc.p(var_31_8 - var_31_2 * 0.5, var_31_9), var_31_2, var_31_3) then
		var_31_11 = {
			var_31_10[6],
			var_31_10[2],
			var_31_10[1],
			var_31_10[8]
		}
		var_31_12 = {
			var_31_10[3],
			var_31_10[4],
			var_31_10[5],
			var_31_10[7],
			var_31_10[9]
		}
	elseif self:_isInArea(var_31_0, cc.p(var_31_8 + var_31_2 * 0.5, var_31_9), var_31_2, var_31_3) then
		var_31_11 = {
			var_31_10[9],
			var_31_10[1],
			var_31_10[3],
			var_31_10[7]
		}
		var_31_12 = {
			var_31_10[2],
			var_31_10[4],
			var_31_10[5],
			var_31_10[6],
			var_31_10[8]
		}
	elseif self:_isInArea(var_31_0, cc.p(var_31_8, var_31_9 + var_31_3 * 0.5), var_31_2, var_31_3) then
		var_31_11 = {
			var_31_10[4],
			var_31_10[6],
			var_31_10[9],
			var_31_10[1]
		}
		var_31_12 = {
			var_31_10[2],
			var_31_10[3],
			var_31_10[5],
			var_31_10[7],
			var_31_10[8]
		}
	elseif self:_isInArea(var_31_0, cc.p(var_31_8, var_31_9 - var_31_3 * 0.5), var_31_2, var_31_3) then
		var_31_11 = {
			var_31_10[1],
			var_31_10[8],
			var_31_10[7],
			var_31_10[5]
		}
		var_31_12 = {
			var_31_10[2],
			var_31_10[3],
			var_31_10[4],
			var_31_10[6],
			var_31_10[9]
		}
	end

	return var_31_11, var_31_12
end

function BaseMapNode:_checkOutEyeTileMap()
	local var_32_0 = false

	for iter_32_0, iter_32_1 in pairs(self._outEye) do
		if 4 < iter_32_1.ref then
			var_32_0 = true

			self:_removeTileMap(iter_32_1.pos.x, iter_32_1.pos.y)

			self._outEye[iter_32_0] = nil

			break
		end
	end

	if var_32_0 then
		self:_checkOutEyeTileMap()
	end
end

function BaseMapNode:_createTileMap(arg_33_1, arg_33_2, arg_33_3)
	local var_33_0 = TileMapFunc.getConstShowNum()

	if arg_33_2 < 0 or var_33_0 <= arg_33_2 or arg_33_3 < 0 or var_33_0 <= arg_33_3 then
		return false
	end

	self._tiledMapData[arg_33_2] = self._tiledMapData[arg_33_2] or {}

	if self._tiledMapData[arg_33_2][arg_33_3] then
		self._tiledMapData[arg_33_2][arg_33_3]:setLocalZOrder(arg_33_1)

		return true
	end

	local var_33_1 = TileMapFunc.getConstIncludeNum()
	local var_33_2 = TileMapFunc.getUnitCellWidth() * var_33_1
	local var_33_3 = TileMapFunc.getUnitCellHeight() * var_33_1
	local var_33_4 = cc.TMXTiledMap:create((TileMapFunc.getTiledMapPath(arg_33_2, arg_33_3)))

	if var_33_4 then
		var_33_4:setPosition(cc.p((var_33_0 / 2 - 0.5) * var_33_2 + (arg_33_2 - arg_33_3) * var_33_2 / 2, (var_33_0 - 1) * var_33_3 - (arg_33_2 + arg_33_3) * var_33_3 / 2))
		var_33_4:setLocalZOrder(arg_33_1)
		self._mapNode:addChild(var_33_4)

		self._tiledMapData[arg_33_2][arg_33_3] = var_33_4

		for iter_33_0 = 0, var_33_1 - 1 do
			for iter_33_1 = 0, var_33_1 - 1 do
				self:eventHandler("TileMap_initLayerCell", {
					data = {
						bigCell = var_33_4,
						x = arg_33_2,
						y = arg_33_3,
						xx = iter_33_0,
						yy = iter_33_1
					}
				})
			end
		end

		return true
	end

	return false
end

function BaseMapNode:_removeTileMap(arg_34_1, arg_34_2)
	local var_34_0 = TileMapFunc.getConstShowNum()

	if arg_34_1 < 0 or var_34_0 <= arg_34_1 or arg_34_2 < 0 or var_34_0 <= arg_34_2 then
		return
	end

	self._tiledMapData[arg_34_1] = self._tiledMapData[arg_34_1] or {}

	if self._tiledMapData[arg_34_1][arg_34_2] then
		self._tiledMapData[arg_34_1][arg_34_2]:removeFromParent()

		self._tiledMapData[arg_34_1][arg_34_2] = nil
	end

	if self._objects[var_0_2(arg_34_1, arg_34_2)] and self._objects[var_0_2(arg_34_1, arg_34_2)].objList and #self._objects[var_0_2(arg_34_1, arg_34_2)].objList > 0 then
		for iter_34_0, iter_34_1 in ipairs(self._objects[var_0_2(arg_34_1, arg_34_2)].objList) do
			if iter_34_1.list and iter_34_1.list.obj then
				iter_34_1.list.obj:destory()

				iter_34_1.list.obj = nil
			end

			if iter_34_1.list and iter_34_1.list.obj2 then
				iter_34_1.list.obj2:destory()

				iter_34_1.list.obj2 = nil
			end

			iter_34_1.cell:removeFromParent()
		end

		self._objects[var_0_2(arg_34_1, arg_34_2)].objList = {}
	end
end

function BaseMapNode:_removeAllTileMap()
	for iter_35_0, iter_35_1 in pairs(self._tiledMapData) do
		if iter_35_1 then
			for iter_35_2, iter_35_3 in pairs(iter_35_1) do
				iter_35_3:removeFromParent()
			end
		end
	end

	self._tiledMapData = {}

	for iter_35_4, iter_35_5 in pairs(self._objects) do
		if iter_35_5 and iter_35_5.objList then
			for iter_35_6, iter_35_7 in pairs(iter_35_5.objList) do
				if iter_35_7.list and iter_35_7.list.obj then
					iter_35_7.list.obj:destory()

					iter_35_7.list.obj = nil
				end

				if iter_35_7.list and iter_35_7.list.obj2 then
					iter_35_7.list.obj2:destory()

					iter_35_7.list.obj2 = nil
				end

				iter_35_7.cell:removeFromParent()
			end
		end
	end

	self._objects = {}
end

function BaseMapNode:_getLayerCell(arg_36_1, arg_36_2, arg_36_3, arg_36_4, arg_36_5)
	local var_36_0 = arg_36_1.x
	local var_36_1 = arg_36_1.y
	local var_36_2 = arg_36_1.bigCell:getLayer(arg_36_2)

	if var_36_2 then
		local var_36_3 = var_36_2:getTileAt(cc.p(arg_36_1.xx, arg_36_1.yy))

		if var_36_3 then
			local var_36_4 = TileMapFunc.getConstIncludeNum()
			local var_36_5 = var_36_0 * var_36_4 + arg_36_1.xx
			local var_36_6 = var_36_1 * var_36_4 + arg_36_1.yy

			if arg_36_4 then
				var_36_3:removeFromParent()

				local var_36_7, var_36_8 = TileMapFunc.rc2p(var_36_5, var_36_6)
				local var_36_9 = TileMapFunc.getUnitCellWidth()
				local var_36_10 = TileMapFunc.getUnitCellHeight()

				if arg_36_5 == 0 then
					var_36_3:setAnchorPoint(0.5, 0.5)
					var_36_3:setPosition(var_36_7 - var_36_9 / 2, var_36_8 - var_36_10 / 2)
				elseif arg_36_5 == 1 then
					var_36_3:setAnchorPoint(0.5, 0.5)
					var_36_3:setPosition(var_36_7, var_36_8 + var_36_10 / 2)
				elseif arg_36_5 == 2 then
					var_36_3:setAnchorPoint(0.5, 0)
					var_36_3:setPosition(var_36_7, var_36_8 - var_36_10 / 2)
				elseif arg_36_5 == 3 then
					var_36_3:setAnchorPoint(0.5, 0.5)
					var_36_3:setPosition(var_36_7, var_36_8)
				elseif arg_36_5 == 4 then
					var_36_3:setAnchorPoint(0.5, 0.5)
					var_36_3:setPosition(var_36_7, var_36_8 + var_36_10 / 2)
				elseif arg_36_5 == 5 then
					var_36_3:setAnchorPoint(0.5, 0.5)
					var_36_3:setPosition(var_36_7 + var_36_9 / 2, var_36_8 + var_36_10)
				elseif arg_36_5 == 6 then
					var_36_3:setAnchorPoint(0.5, 0.5)
					var_36_3:setPosition(var_36_7 + var_36_9, var_36_8 - var_36_10)
				elseif arg_36_5 == 7 then
					var_36_3:setAnchorPoint(0.5, 0.5)
					var_36_3:setPosition(var_36_7, var_36_8 + 2 * var_36_10)
				elseif arg_36_5 == 8 then
					var_36_3:setAnchorPoint(0.5, 0.5)
					var_36_3:setPosition(var_36_7, var_36_8 + var_36_10)
				elseif arg_36_5 == 9 then
					var_36_3:setAnchorPoint(0.5, 0.5)
					var_36_3:setPosition(var_36_7 + 2.5 * var_36_9, var_36_8 + 5.5 * var_36_10)
				elseif arg_36_5 == 10 then
					var_36_3:setAnchorPoint(0.5, 0.5)
					var_36_3:setPosition(var_36_7 + 2 * var_36_9, var_36_8 + 4.5 * var_36_10)
				elseif arg_36_5 == 11 then
					var_36_3:setAnchorPoint(0.5, 0.5)
					var_36_3:setPosition(var_36_7, var_36_8 + 3 * var_36_10)
				end

				var_36_3:setLocalZOrder(-var_36_8)
				arg_36_4:addChild(var_36_3)

				if arg_36_3 then
					self:eventHandler("TileMap_cacheList", {
						cellX = var_36_5,
						cellY = var_36_6
					})
					self:_addObject(var_36_3, var_36_0, var_36_1, arg_36_3)
				else
					self:_addObject(var_36_3, var_36_0, var_36_1)
				end
			end
		end
	end
end

function BaseMapNode:_addObject(arg_37_1, arg_37_2, arg_37_3, arg_37_4)
	self._objects[var_0_2(arg_37_2, arg_37_3)] = self._objects[var_0_2(arg_37_2, arg_37_3)] or {}
	self._objects[var_0_2(arg_37_2, arg_37_3)].objList = self._objects[var_0_2(arg_37_2, arg_37_3)].objList or {}

	table.insert(self._objects[var_0_2(arg_37_2, arg_37_3)].objList, {
		cell = arg_37_1,
		list = arg_37_4
	})
end

function BaseMapNode:setCustomScale(arg_38_1)
	self:_setMapScale(arg_38_1)
	self:_moveMapAndCheckBorder()
end

function BaseMapNode:_setMapScale(arg_39_1)
	self._scale = arg_39_1

	local var_39_0 = cc.Director:getInstance():getWinSize()

	self:setPosition(var_39_0.width * (1 / self._scale) / 2, var_39_0.height * (1 / self._scale) / 2)

	self._x = self:getPositionX()
	self._y = self:getPositionY()
	self._showSize = cc.size(var_39_0.width * (1 / self._scale), var_39_0.height * (1 / self._scale))

	self:_setScaleToPool(arg_39_1)
	self:_updatePool()
end

function BaseMapNode:_setScaleToPool(arg_40_1)
	return
end

function BaseMapNode:_updatePool()
	return
end

function BaseMapNode:updatePool()
	self:_updatePool()
end

function BaseMapNode:_doAutoScroll(arg_43_1)
	if self._isMapScrolling then
		self._nMapScrollLeftTime = self._nMapScrollLeftTime - arg_43_1
		self._isMapScrolling = self._nMapScrollLeftTime > 0 and self._nMapScrollSpeed > 2
		self._nMapScrollSpeed = self._nMapScrollSpeed * 0.95

		self:_moveMapAndCheckBorder(-self._tMapScrollDir.x * self._nMapScrollSpeed, -self._tMapScrollDir.y * self._nMapScrollSpeed)
		self:updateArrowComp()
	end
end

function BaseMapNode:update(arg_44_1)
	return
end

function BaseMapNode:jumpToVirtualPos(arg_45_1, arg_45_2, arg_45_3)
	local var_45_0, var_45_1 = var_0_4(arg_45_1, arg_45_2)
	local var_45_2, var_45_3 = TileMapFunc.vc2rc(var_45_0, var_45_1)

	self:jumpToPos(var_45_2, var_45_3, arg_45_3)
end

function BaseMapNode:onExit()
	g.core.event.EventManager:removeListenerWithTarget(self)

	for iter_46_0, iter_46_1 in ipairs(self._baseNodes) do
		if not tolua.isnull(iter_46_1) then
			iter_46_1:destory()
		end
	end

	self._baseNodes = {}
end

function BaseMapNode:onCleanup()
	print("onCleanup_")
end

function BaseMapNode:onRemoved()
	print("onRemoved")
	self:_removeAllTileMap()
end

function BaseMapNode:eventHandler(arg_49_1, arg_49_2)
	return
end

function BaseMapNode:setArrowComp(arg_50_1)
	self._compArrow = arg_50_1
end

function BaseMapNode:setArrowOffset(arg_51_1, arg_51_2)
	self._arrowOffsetX = arg_51_1
	self._arrowOffsetY = arg_51_2
end

function BaseMapNode:onClickArrowComp()
	self:jumpToPosFinish(self._myRealPos or cc.p(0, 0), nil, true)
end

function BaseMapNode:updateArrowComp()
	if not self._compArrow then
		return
	end

	if not self._canUpdateArrow then
		self._compArrow:setVisible(false)

		return
	end

	local var_53_0 = self._myPos or cc.p(0, 0)
	local var_53_1 = cc.Director:getInstance():getWinSize()
	local var_53_2, var_53_3, var_53_4 = self:_isShowArrowComp((cc.p((var_53_0.x + self._mapNode:getPositionX() + var_53_1.width * (1 / self._scale) / 2) * self._scale, (var_53_0.y + self._mapNode:getPositionY() + var_53_1.height * (1 / self._scale) / 2) * self._scale)))

	self._compArrow:setVisible(var_53_2)

	if var_53_3 then
		self._compArrow:setAniRotate(var_53_3)
		self._compArrow:setPosition(var_53_4)
	end
end

function BaseMapNode:_isShowArrowComp(arg_54_1)
	local var_54_0 = cc.Director:getInstance():getWinSize()

	arg_54_1.y = var_54_0.height - arg_54_1.y

	if not cc.rectContainsPoint(cc.rect(0, 0, var_54_0.width, var_54_0.height), arg_54_1) then
		local var_54_1 = cc.Director:getInstance()
		local var_54_2 = var_54_1:getSafeAreaRect()
		local var_54_3 = self._compArrow:localToGlobal(cc.p(0, 0))

		return true, math.radian2angle((cc.pToAngleSelf(cc.pSub(cc.p(var_54_1.x, var_54_3.y), arg_54_1)))) + 90, cc.p(var_54_3.x, var_54_3.y)
	else
		return false
	end
end

function BaseMapNode:_isInArea(arg_55_1, arg_55_2, arg_55_3, arg_55_4)
	if self:_inArea(arg_55_1, arg_55_2, arg_55_3, arg_55_4) then
		self._curArea = arg_55_2

		return true
	end

	return false
end

function BaseMapNode:_isInBlock(arg_56_1, arg_56_2, arg_56_3, arg_56_4)
	if self:_inArea(arg_56_1, arg_56_2, arg_56_3, arg_56_4) then
		return true
	end

	return false
end

function BaseMapNode:_inArea(arg_57_1, arg_57_2, arg_57_3, arg_57_4)
	if math.abs((arg_57_1.x - arg_57_2.x) * arg_57_4) + math.abs((arg_57_1.y - arg_57_2.y) * arg_57_3) <= arg_57_3 * arg_57_4 * 0.5 then
		return true
	end

	return false
end

function BaseMapNode:isOutOfEye(arg_58_1, arg_58_2)
	arg_58_1 = arg_58_1 or 0
	arg_58_2 = arg_58_2 or 0

	local var_58_0 = cc.Director:getInstance():getWinSize()
	local var_58_1 = cc.p((arg_58_1 + self._mapNode:getPositionX() + var_58_0.width * (1 / self._scale) / 2) * self._scale, (arg_58_2 + self._mapNode:getPositionY() + var_58_0.height * (1 / self._scale) / 2) * self._scale)
	local var_58_2 = TileMapFunc.getUnitCellWidth() / 2 + 25
	local var_58_3 = TileMapFunc.getUnitCellHeight() / 2 + 25

	return var_58_1.x < -var_58_2 or var_58_1.x > var_58_0.width + var_58_2 or var_58_1.y < -var_58_3 or var_58_1.y > var_58_0.height + var_58_3
end

function BaseMapNode:_isBarrier(arg_59_1, arg_59_2)
	if self:_getBarrierData(arg_59_1, arg_59_2) then
		return true
	end

	return false
end

function BaseMapNode:_getBarrierData(arg_60_1, arg_60_2)
	local var_60_0, var_60_1 = var_0_4(arg_60_1, arg_60_2)

	return TileMapFunc.getData():getBarrier(var_60_0, var_60_1)
end

function BaseMapNode:_isMapContainPoint(arg_61_1, arg_61_2)
	local var_61_0, var_61_1 = var_0_4(arg_61_1, arg_61_2)

	return self._mapData[var_0_2(var_61_0, var_61_1)]
end

function BaseMapNode:getRealPath(arg_62_1, arg_62_2)
	return self:getPath(arg_62_1, arg_62_2) or {}
end

function BaseMapNode:getPath(arg_63_1, arg_63_2)
	arg_63_2 = arg_63_2 or self._myRealPos or cc.p(0, 0)

	return (self._aStar:getPath(arg_63_2, arg_63_1))
end

function BaseMapNode:drawPath(arg_64_1, arg_64_2, arg_64_3, arg_64_4)
	local var_64_0 = {}

	for iter_64_0, iter_64_1 in ipairs(arg_64_1) do
		local var_64_1 = {
			pos = iter_64_1
		}
		local var_64_9

		if arg_64_2 then
			local var_64_2, var_64_3 = TileMapFunc.rc2p(iter_64_1.x, iter_64_1.y)
			local var_64_4 = cc.p(var_64_2, var_64_3)

			if nil ~= nil then
				local var_64_5 = 180 * (var_64_4.x - (nil).x > 0 and 1 or 0) - math.atan((var_64_4.y - (nil).y) / (var_64_4.x - (nil).x)) / math.pi * 180
				local var_64_6 = display.newSprite(arg_64_4 or g.core.common.Path:getGroupWarPathImg(true), nil, nil, {
					scale9 = true
				})

				var_64_6:setContentSize(self._distance, var_64_6:getContentSize().height)
				var_64_6:setPosition(cc.p(0, 0))
				var_64_6:setAnchorPoint(0, 0)

				local var_64_7 = display.newSprite(arg_64_4 or g.core.common.Path:getGroupWarPathImg(true), nil, nil, {
					scale9 = true
				})

				var_64_7:setContentSize(self._distance, var_64_7:getContentSize().height)
				var_64_7:setPosition(cc.p(self._distance, 0))
				var_64_7:setAnchorPoint(0, 0)
				var_64_6:addChild(var_64_7)

				local var_64_8 = ccui.Layout:create()

				var_64_8:setClippingEnabled(true)
				var_64_8:setContentSize(self._distance, var_64_6:getContentSize().height)
				var_64_8:addChild(var_64_6)
				var_64_8:setRotation(var_64_5)
				var_64_8:setPosition(var_64_4)
				var_64_8:setAnchorPoint(0, 0.5)

				if arg_64_3 then
					arg_64_3:addChild(var_64_8)
				else
					self._pathNode:addChild(var_64_8)
				end

				var_64_1.line = var_64_8
			end

			var_64_9 = var_64_4
		end

		table.insert(var_64_0, var_64_1)
	end

	return var_64_0
end

function BaseMapNode:_removePath()
	if not tolua.isnull(self._pathNode) then
		self._pathNode:removeAllChildren()
	end
end

function BaseMapNode:onTouchBegin(arg_66_1, arg_66_2)
	for iter_66_0, iter_66_1 in ipairs(self._baseNodes) do
		if not tolua.isnull(iter_66_1) then
			iter_66_1:onTouchBegin(arg_66_1, arg_66_2)
		end
	end

	self._nClickTouchX, self._nClickTouchY = arg_66_1, arg_66_2
	arg_66_1 = arg_66_1 * (1 / self._scale)
	arg_66_2 = arg_66_2 * (1 / self._scale)
	self._nTouchedX, self._nTouchedY = arg_66_1, arg_66_2
	self._nTouchBeginTime = cc.utils.gettime()
	self._isMapScrolling = false
end

function BaseMapNode:onTouchMove(arg_67_1, arg_67_2)
	arg_67_1 = arg_67_1 * (1 / self._scale)
	arg_67_2 = arg_67_2 * (1 / self._scale)

	self:_moveMapAndCheckBorder(self._nTouchedX - arg_67_1, self._nTouchedY - arg_67_2)

	self._nTouchedX, self._nTouchedY = arg_67_1, arg_67_2

	self:_updateMap(true)
end

function BaseMapNode:onTouchEnd(arg_68_1, arg_68_2, arg_68_3)
	for iter_68_0, iter_68_1 in ipairs(self._baseNodes) do
		if not tolua.isnull(iter_68_1) then
			arg_68_3 = iter_68_1:onTouchEnd(arg_68_1, arg_68_2)

			if arg_68_3 then
				break
			end
		end
	end

	local var_68_0 = math.abs(self._nClickTouchX - arg_68_1)
	local var_68_1 = math.abs(self._nClickTouchY - arg_68_2)

	if not arg_68_3 and var_68_0 <= var_0_7 and var_68_1 <= var_0_7 then
		if cc.utils.gettime() - self._nTouchBeginTime < var_0_6 then
			self:_onClickMapCell(arg_68_1, arg_68_2)
		else
			self:_onClickMapCell(arg_68_1, arg_68_2)
		end

		return
	end

	self._lastPos = nil

	if cc.utils.gettime() - self._nTouchBeginTime < var_0_8 and (var_68_0 >= var_0_5 or var_68_1 >= var_0_5) then
		self._nMapScrollLeftTime = var_0_9 * 1000
		self._nMapScrollSpeed = var_0_10 * (1 / self._scale)
		self._tMapScrollDir = TileMapFunc.normalize(arg_68_1 - self._nClickTouchX, arg_68_2 - self._nClickTouchY)
		self._isMapScrolling = true
	end
end

function BaseMapNode:selectCell(arg_69_1)
	if not arg_69_1 then
		-- block empty
	else
		self:_clickMapCell(arg_69_1.x, arg_69_1.y)
	end
end

function BaseMapNode:_onClickMapCell(arg_70_1, arg_70_2)
	local var_70_0 = cc.Director:getInstance():getWinSize()
	local var_70_1, var_70_2 = TileMapFunc.p2rc((arg_70_1 - var_70_0.width / 2) / self._scale - self._mapNode:getPositionX(), (arg_70_2 - var_70_0.height / 2) / self._scale - self._mapNode:getPositionY())

	g.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_CLICK_ZHULUTIANXIA)
	self:_clickMapCell(var_70_1, var_70_2)
end

function BaseMapNode:_clickMapCell(arg_71_1, arg_71_2)
	return
end

function BaseMapNode:autoSliderEnd()
	return
end

function BaseMapNode:insertBaseNode(arg_73_1)
	table.insert(self._baseNodes, arg_73_1)
end

function BaseMapNode:removeBaseNode(arg_74_1)
	for iter_74_0, iter_74_1 in ipairs(self._baseNodes) do
		if iter_74_1 == arg_74_1 then
			table.remove(self._baseNodes, iter_74_0)

			break
		end
	end
end

function BaseMapNode:_getServerBlockInfo()
	local var_75_0 = TileMapFunc.getConstIncludeNum()
	local var_75_1 = self:getCenterPos()
	local var_75_2 = TileMapFunc.getUnitCellWidth() * var_75_0
	local var_75_3 = TileMapFunc.getUnitCellHeight() * var_75_0

	self:_checkBlockData()

	if self._curBlock and self:_isInBlock(var_75_1, self._curBlock, var_75_2, var_75_3) then
		return false
	end

	for iter_75_0, iter_75_1 in pairs(self._blockMap) do
		if self:_isInBlock(var_75_1, iter_75_1.pos, var_75_2, var_75_3) then
			return false
		end
	end

	local var_75_4 = math.floor(var_75_0 / 2)
	local var_75_5, var_75_6 = TileMapFunc.p2rc(var_75_1.x, var_75_1.y)
	local var_75_7, var_75_8 = TileMapFunc.rc2p(math.floor(var_75_5 / var_75_0) * var_75_0 + var_75_4, math.floor(var_75_6 / var_75_0) * var_75_0 + var_75_4)

	self._curBlock = cc.p(var_75_7, var_75_8)
	self._blockMap[self.p2s(var_75_7, var_75_8)] = {
		pos = cc.p(var_75_7, var_75_8),
		expire = g.core.common.ServerTime:getTime()
	}

	self:eventHandler("BaseMapNode_getServerBlockInfo")

	return true
end

function BaseMapNode:_checkBlockData()
	for iter_76_0, iter_76_1 in pairs(self._blockMap) do
		if g.core.common.ServerTime:getTime() - iter_76_1.expire > 5 then
			self._blockMap[iter_76_0] = nil
		end
	end
end

return BaseMapNode
