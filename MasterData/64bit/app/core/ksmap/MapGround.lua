local KsMath = require("app.core.utils.KsMath")
local MapConst = import(".MapConst")
local MapGround = class("MapGround", function()
	return cc.Node:create()
end)

function MapGround:ctor(arg_2_1)
	self._fatherWorld = arg_2_1
	self._MAP_GRID_MAXX = 0
	self._MAP_GRID_MAXY = 0
	self._MAP_WIDTH = 0
	self._MAP_HEIGHT = 0
	self._MAP_TILE_HW = 0
	self._MAP_TILE_HH = 0
	self._FIX_OFF_X = 0
	self._FIX_OFF_Y = 0
	self._tiledMap = nil
	self._attachDict = {}
	self._gridView = nil
	self._gridLine = nil
	self._gridTxt = nil
	self._holdDict = nil

	self:initGround()
end

function MapGround:initGround()
	self:_initTiledMap()
	self:_initAttachNode()

	if MapConst.DEBUG_GRID then
		self:_initDebugGrid()
	end
end

function MapGround:getMapWorld()
	return self._fatherWorld
end

function MapGround:getMapStage()
	return self._fatherWorld:getMapStage()
end

function MapGround:getMapWidth()
	return self._MAP_WIDTH
end

function MapGround:getMapHeight()
	return self._MAP_HEIGHT
end

function MapGround:getHalfTileH()
	return self._MAP_TILE_HH
end

function MapGround:coordToPixel(arg_9_1, arg_9_2)
	return (arg_9_1 - arg_9_2) * self._MAP_TILE_HW, -(arg_9_1 + arg_9_2) * self._MAP_TILE_HH
end

function MapGround:pixelToCoord(arg_10_1, arg_10_2)
	return math.round((arg_10_1 / self._MAP_TILE_HW + -arg_10_2 / self._MAP_TILE_HH) / 2), math.round((-arg_10_2 / self._MAP_TILE_HH - arg_10_1 / self._MAP_TILE_HW) / 2)
end

function MapGround:checkCoordInvalid(arg_11_1, arg_11_2)
	if arg_11_1 < 0 or arg_11_1 >= self._MAP_GRID_MAXX or arg_11_2 < 0 or arg_11_2 >= self._MAP_GRID_MAXY then
		return true
	else
		return false
	end
end

function MapGround:getHoldType(arg_12_1, arg_12_2)
	return self._holdDict[KsMath.coord2Unified(arg_12_1, arg_12_2)]
end

function MapGround:setHoldType(arg_13_1, arg_13_2, arg_13_3)
	self._holdDict[KsMath.coord2Unified(arg_13_1, arg_13_2)] = arg_13_3
end

function MapGround:getTile(arg_14_1, arg_14_2, arg_14_3)
	local var_14_0 = self._tiledMap:getLayer(arg_14_1)

	if var_14_0 == nil then
		return nil
	end

	return var_14_0:getTileAt(cc.p(arg_14_2, arg_14_3))
end

function MapGround:showTile(arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	local var_15_0 = self:getTile(arg_15_2, arg_15_3, arg_15_4)

	if var_15_0 then
		var_15_0:setVisible(arg_15_1)
	end
end

function MapGround:changeTile(arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	local var_16_0 = self._tiledMap:getLayer(arg_16_2)

	if var_16_0 then
		var_16_0:setTileGID(arg_16_1, cc.p(arg_16_3, arg_16_4))
	end
end

function MapGround:getAttachRoot(arg_17_1)
	return self._attachDict[arg_17_1]
end

function MapGround:addVisual(arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = self:getAttachRoot(arg_18_2)

	if var_18_0 then
		var_18_0:addChild(arg_18_1)

		if arg_18_3 then
			local var_18_1, var_18_2 = self:coordToPixel(arg_18_3.x, arg_18_3.y)

			arg_18_1:setPosBothZ(cc.p(var_18_1, var_18_2))
		end
	end
end

function MapGround:delVisual(arg_19_1)
	arg_19_1:removeFromParent()
end

function MapGround:showTileLayer(arg_20_1, arg_20_2)
	local var_20_0 = self._tiledMap:getLayer(arg_20_1)

	if var_20_0 then
		var_20_0:setVisible(arg_20_2)
	end
end

function MapGround:showAttachNode(arg_21_1, arg_21_2)
	local var_21_0 = self:getAttachRoot(arg_21_1)

	if var_21_0 then
		var_21_0:setVisible(arg_21_2)
	end
end

function MapGround:showGridCell(arg_22_1)
	if self._gridLine then
		self._gridLine:setVisible(arg_22_1)
	end
end

function MapGround:showGridCoord(arg_23_1)
	if self._gridTxt then
		self._gridTxt:setVisible(arg_23_1)
	elseif MapConst.DEBUG_GRID then
		self:_initDebugGridText()
		self._gridTxt:setVisible(arg_23_1)
	end
end

function MapGround:createGridCell(arg_24_1, arg_24_2)
	if self._tmpGridBox == nil then
		self._tmpGridBox = {
			cc.p(-self._MAP_TILE_HW, 0),
			cc.p(0, self._MAP_TILE_HH),
			cc.p(self._MAP_TILE_HW, 0),
			cc.p(0, -self._MAP_TILE_HH)
		}
	end

	local var_24_0 = cc.DrawNode:create()

	if arg_24_2 then
		var_24_0:drawPolygon(self._tmpGridBox, 4, arg_24_1, 0, arg_24_1)
	else
		var_24_0:drawPoly(self._tmpGridBox, 4, true, arg_24_1)
	end

	return var_24_0
end

function MapGround:deserializeHold(arg_25_1)
	self._holdDict = arg_25_1 or {}

	self:_doInitHoldData()
end

function MapGround:serializeHold()
	return self._holdDict
end

function MapGround:doBasePath()
	return g.core.common.Path:getBioBasePath()
end

function MapGround:_doTiledLayer()
	return {
		MapConst.MAP_FLOOR,
		MapConst.MAP_DECORATE
	}
end

function MapGround:doAttachNode()
	return {
		MapConst.MAP_FLOOR,
		MapConst.MAP_DECORATE
	}
end

function MapGround:_doInitHoldData()
	return
end

function MapGround:_initTiledMap()
	local var_31_0 = self:getMapWorld():getMapId()

	self._tiledMap = ccexp.TMXTiledMap:create(self:doBasePath() .. var_31_0 .. "/" .. var_31_0 .. ".tmx")

	self:addChild(self._tiledMap)

	local var_31_1 = self._tiledMap:getTileSize()

	self._MAP_TILE_HW = var_31_1.width / 2
	self._MAP_TILE_HH = var_31_1.height / 2

	local var_31_2 = self._tiledMap:getMapSize()

	self._MAP_GRID_MAXX = var_31_2.width
	self._MAP_GRID_MAXY = var_31_2.height
	self._MAP_WIDTH = (self._MAP_GRID_MAXX + self._MAP_GRID_MAXY) * self._MAP_TILE_HW
	self._MAP_HEIGHT = (self._MAP_GRID_MAXX + self._MAP_GRID_MAXY) * self._MAP_TILE_HH
	self._FIX_OFF_X = self._MAP_GRID_MAXY * self._MAP_TILE_HW
	self._FIX_OFF_Y = self._MAP_HEIGHT - self._MAP_TILE_HH

	self._tiledMap:setPosition(-self._FIX_OFF_X, -self._FIX_OFF_Y)

	for iter_31_0, iter_31_1 in pairs((self:_doTiledLayer())) do
		local var_31_3 = self._tiledMap:getLayer(iter_31_1)

		if var_31_3 then
			local var_31_4 = var_31_3:getTileSet():getTileOffset()

			var_31_3:setPosition(var_31_4.x, -var_31_4.y)
		end
	end
end

function MapGround:_initAttachNode()
	for iter_32_0, iter_32_1 in ipairs((self:doAttachNode())) do
		local var_32_0 = iter_32_0
		local var_32_1 = self._tiledMap:getLayer(iter_32_1)

		if var_32_1 then
			var_32_0 = var_32_1:getLocalZOrder()
		end

		local var_32_2 = cc.Node:create()

		self._tiledMap:addChild(var_32_2, var_32_0)

		self._attachDict[iter_32_1] = var_32_2

		var_32_2:setPosition(self._FIX_OFF_X, self._FIX_OFF_Y)
	end
end

function MapGround:_initDebugGrid()
	self._gridView = cc.Node:create()

	self:addChild(self._gridView)

	self._gridLine = cc.DrawNode:create()

	self._gridView:addChild(self._gridLine)

	local var_33_0 = {
		cc.p(-self._MAP_TILE_HW, 0),
		cc.p(0, self._MAP_TILE_HH),
		cc.p(self._MAP_TILE_HW, 0),
		cc.p(0, -self._MAP_TILE_HH)
	}

	local function var_33_1(arg_34_0, arg_34_1, arg_34_2)
		for iter_34_0, iter_34_1 in pairs(arg_34_0) do
			iter_34_1.x = iter_34_1.x + arg_34_1
			iter_34_1.y = iter_34_1.y + arg_34_2
		end

		return arg_34_0
	end

	for iter_33_0 = 0, self._MAP_GRID_MAXX - 1 do
		for iter_33_1 = 0, self._MAP_GRID_MAXY - 1 do
			local var_33_2, var_33_3 = self:coordToPixel(iter_33_0, iter_33_1)

			var_33_0 = var_33_1(var_33_0, var_33_2, var_33_3)

			self._gridLine:drawPoly(var_33_0, 4, true, MapConst.DEBUG_COLORF)

			var_33_0 = var_33_1(var_33_0, -var_33_2, -var_33_3)
		end
	end
end

function MapGround:_initDebugGridText()
	self._gridTxt = cc.Node:create()

	self._gridView:addChild(self._gridTxt)

	for iter_35_0 = 0, self._MAP_GRID_MAXX - 1 do
		for iter_35_1 = 0, self._MAP_GRID_MAXY - 1 do
			local var_35_0, var_35_1 = self:coordToPixel(iter_35_0, iter_35_1)
			local var_35_2 = ccui.Text:create(iter_35_0 .. "," .. iter_35_1, "", 16)

			var_35_2:setTextColor(MapConst.DEBUG_COLORB)
			var_35_2:setPosition(var_35_0, var_35_1)
			self._gridTxt:addChild(var_35_2)
		end
	end
end

function MapGround:getMapGridX()
	return self._MAP_GRID_MAXX
end

function MapGround:getMapGridY()
	return self._MAP_GRID_MAXY
end

return MapGround
