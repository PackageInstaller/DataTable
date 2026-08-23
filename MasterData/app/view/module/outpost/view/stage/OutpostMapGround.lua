local var_0_0 = g.core.const.ConstMgr.outpostConst
local OutpostMapGround = class("OutpostMapGround", function()
	return cc.Node:create()
end)

function OutpostMapGround:ctor(arg_2_1)
	self._fatherWorld = arg_2_1
	self._MAP_GRID_MAXX = 0
	self._MAP_GRID_MAXY = 0
	self._MAP_WIDTH = 0
	self._MAP_HEIGHT = 0
	self._MAP_TILE_HW = 0
	self._MAP_TILE_HH = 0
	self._tiledMap = nil
	self._gridView = nil
	self._gridLine = nil
	self._gridTxt = nil
	self._holdDict = nil
	self._tiledDict = {}

	self:initGround()
end

function OutpostMapGround:initGround()
	self:_initTiledMap()

	if var_0_0.MAP_DEBUG_GRID then
		self:_initDebugGrid()
		self:_initDebugGridText()
	end
end

function OutpostMapGround:getMapWorld()
	return self._fatherWorld
end

function OutpostMapGround:getMapStage()
	return self._fatherWorld:getMapStage()
end

function OutpostMapGround:getMapWidth()
	return self._MAP_WIDTH
end

function OutpostMapGround:getMapHeight()
	return self._MAP_HEIGHT
end

function OutpostMapGround:getHalfTileH()
	return self._MAP_TILE_HH
end

function OutpostMapGround:coordToPixel(arg_9_1, arg_9_2)
	return (arg_9_1 - arg_9_2) * self._MAP_TILE_HW, -(arg_9_1 + arg_9_2) * self._MAP_TILE_HH
end

function OutpostMapGround:pixelToCoord(arg_10_1, arg_10_2)
	return math.round((arg_10_1 / self._MAP_TILE_HW + -arg_10_2 / self._MAP_TILE_HH) / 2), math.round((-arg_10_2 / self._MAP_TILE_HH - arg_10_1 / self._MAP_TILE_HW) / 2)
end

function OutpostMapGround:checkCoordInvalid(arg_11_1, arg_11_2)
	if arg_11_1 < 0 or arg_11_1 >= self._MAP_GRID_MAXX or arg_11_2 < 0 or arg_11_2 >= self._MAP_GRID_MAXY then
		return true
	else
		return false
	end
end

function OutpostMapGround:doBasePath()
	return g.core.common.Path:getOutpostMapPath()
end

function OutpostMapGround:_doTiledLayer()
	return {
		"ground"
	}
end

function OutpostMapGround:doAttachNode()
	return {
		"ground"
	}
end

function OutpostMapGround:_initTiledMap()
	local var_15_0 = self:getMapWorld():getMapId()

	self._tiledMap = ccexp.TMXTiledMap:create(self:doBasePath() .. var_15_0 .. "/" .. var_15_0 .. ".tmx")
	self._tiledDict["0_0"] = self._tiledMap

	self:addChild(self._tiledMap)

	local var_15_1 = self._tiledMap:getTileSize()

	self._MAP_TILE_HW = var_15_1.width / 2
	self._MAP_TILE_HH = var_15_1.height / 2

	local var_15_2 = self._tiledMap:getMapSize()

	self._MAP_GRID_MAXX = var_0_0.MAP_BIG_CELL_NUM * var_15_2.width
	self._MAP_GRID_MAXY = var_0_0.MAP_BIG_CELL_NUM * var_15_2.height
	self._CELL_WIDTH = (var_15_2.width + var_15_2.height) * self._MAP_TILE_HW
	self._CELL_HEIGHT = (var_15_2.width + var_15_2.height) * self._MAP_TILE_HH
	self._MAP_WIDTH = (self._MAP_GRID_MAXX + self._MAP_GRID_MAXY) * self._MAP_TILE_HW
	self._MAP_HEIGHT = (self._MAP_GRID_MAXX + self._MAP_GRID_MAXY) * self._MAP_TILE_HH
	self._FIX_OFF_X = var_15_2.width * self._MAP_TILE_HW
	self._FIX_OFF_Y = self._CELL_HEIGHT - self._MAP_TILE_HH

	self._tiledMap:setPosition(-self._FIX_OFF_X, -self._FIX_OFF_Y)
	self:_updateTiledLayerPos(self._tiledMap)
end

function OutpostMapGround:checkAndLoadParts(arg_16_1)
	return
end

function OutpostMapGround:getGroundSize()
	return self._MAP_GRID_MAXX, self._MAP_GRID_MAXY, self._MAP_TILE_HW * 2, self._MAP_TILE_HH * 2
end

function OutpostMapGround:getTargetPosTiledId(arg_18_1)
	local var_18_0 = self._tiledDict[math.floor(arg_18_1.x / 58) .. "_" .. math.floor(arg_18_1.y / 58)]

	if not var_18_0 then
		return 0
	end

	return var_18_0:getLayer("ground"):getTileGIDAt(cc.p(arg_18_1.x % 58, arg_18_1.y % 58))
end

function OutpostMapGround:_updateTiledLayerPos(arg_19_1)
	for iter_19_0, iter_19_1 in pairs((self:_doTiledLayer())) do
		local var_19_0 = arg_19_1:getLayer(iter_19_1)

		if var_19_0 then
			local var_19_1 = var_19_0:getTileSet():getTileOffset()

			var_19_0:setPosition(var_19_1.x, -var_19_1.y)
		end
	end
end

function OutpostMapGround:_initDebugGrid()
	self._gridView = cc.Node:create()

	self:addChild(self._gridView)

	self._gridLine = cc.DrawNode:create()

	self._gridView:addChild(self._gridLine)

	local var_20_0 = {
		cc.p(-self._MAP_TILE_HW, 0),
		cc.p(0, self._MAP_TILE_HH),
		cc.p(self._MAP_TILE_HW, 0),
		cc.p(0, -self._MAP_TILE_HH)
	}

	local function var_20_1(arg_21_0, arg_21_1, arg_21_2)
		for iter_21_0, iter_21_1 in pairs(arg_21_0) do
			iter_21_1.x = iter_21_1.x + arg_21_1
			iter_21_1.y = iter_21_1.y + arg_21_2
		end

		return arg_21_0
	end

	for iter_20_0 = 0, self._MAP_GRID_MAXX - 1 do
		for iter_20_1 = 0, self._MAP_GRID_MAXY - 1 do
			local var_20_2, var_20_3 = self:coordToPixel(iter_20_0, iter_20_1)

			var_20_0 = var_20_1(var_20_0, var_20_2, var_20_3)

			self._gridLine:drawPoly(var_20_0, 4, true, var_0_0.MAP_DEBUG_COLORF)

			var_20_0 = var_20_1(var_20_0, -var_20_2, -var_20_3)
		end
	end
end

function OutpostMapGround:_initDebugGridText()
	self._gridTxt = cc.Node:create()

	self._gridView:addChild(self._gridTxt)

	for iter_22_0 = 0, self._MAP_GRID_MAXX - 1 do
		for iter_22_1 = 0, self._MAP_GRID_MAXY - 1 do
			if iter_22_0 % 10 == 0 and iter_22_1 % 10 == 0 then
				local var_22_0, var_22_1 = self:coordToPixel(iter_22_0, iter_22_1)
				local var_22_2 = ccui.Text:create(iter_22_0 .. "," .. iter_22_1, "", 16)

				var_22_2:setTextColor(var_0_0.MAP_DEBUG_COLORB)
				var_22_2:setPosition(var_22_0, var_22_1)
				self._gridTxt:addChild(var_22_2)
			end
		end
	end
end

return OutpostMapGround
