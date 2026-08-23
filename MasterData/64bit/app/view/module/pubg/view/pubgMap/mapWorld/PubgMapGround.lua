local var_0_0 = g.core.const.ConstMgr.PubgConst
local PubgMapGround = class("PubgMapGround", function()
	return cc.Node:create()
end)

function PubgMapGround:ctor(arg_2_1)
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

function PubgMapGround:initGround()
	self:_initTiledMap()

	if var_0_0.map.MAP_DEBUG_GRID then
		self:_initDebugGrid()
		self:_initDebugGridText()
	end
end

function PubgMapGround:getMapWorld()
	return self._fatherWorld
end

function PubgMapGround:getMapStage()
	return self._fatherWorld:getMapStage()
end

function PubgMapGround:getMapWidth()
	return self._MAP_WIDTH
end

function PubgMapGround:getMapHeight()
	return self._MAP_HEIGHT
end

function PubgMapGround:getHalfTileH()
	return self._MAP_TILE_HH
end

function PubgMapGround:coordToPixel(arg_9_1, arg_9_2)
	return (arg_9_1 - arg_9_2) * self._MAP_TILE_HW, -(arg_9_1 + arg_9_2) * self._MAP_TILE_HH
end

function PubgMapGround:pixelToCoord(arg_10_1, arg_10_2)
	return math.round((arg_10_1 / self._MAP_TILE_HW + -arg_10_2 / self._MAP_TILE_HH) / 2), math.round((-arg_10_2 / self._MAP_TILE_HH - arg_10_1 / self._MAP_TILE_HW) / 2)
end

function PubgMapGround:checkCoordInvalid(arg_11_1, arg_11_2)
	if arg_11_1 < 0 or arg_11_1 >= self._MAP_GRID_MAXX or arg_11_2 < 0 or arg_11_2 >= self._MAP_GRID_MAXY then
		return true
	else
		return false
	end
end

function PubgMapGround:doBasePath()
	return g.core.common.Path:getPubgBasePath()
end

function PubgMapGround:_doTiledLayer()
	return {
		"ground"
	}
end

function PubgMapGround:doAttachNode()
	return {
		"ground"
	}
end

function PubgMapGround:_initTiledMap()
	self._tiledMap = ccexp.TMXTiledMap:create(self:doBasePath() .. self:getMapWorld():getMapId() .. ".tmx")
	self._tiledDict["0_0"] = self._tiledMap

	self:addChild(self._tiledMap)

	local var_15_0 = self._tiledMap:getTileSize()

	self._MAP_TILE_HW = var_15_0.width / 2
	self._MAP_TILE_HH = var_15_0.height / 2

	local var_15_1 = self._tiledMap:getMapSize()

	self._MAP_GRID_MAXX = var_15_1.width
	self._MAP_GRID_MAXY = var_15_1.height
	self._MAP_WIDTH = (self._MAP_GRID_MAXX + self._MAP_GRID_MAXY) * self._MAP_TILE_HW
	self._MAP_HEIGHT = (self._MAP_GRID_MAXX + self._MAP_GRID_MAXY) * self._MAP_TILE_HH
	self._FIX_OFF_X = var_15_1.width * self._MAP_TILE_HW
	self._FIX_OFF_Y = self._MAP_HEIGHT - self._MAP_TILE_HH

	self._tiledMap:setPosition(-self._FIX_OFF_X, -self._FIX_OFF_Y)
	self:_updateTiledLayerPos(self._tiledMap)
end

function PubgMapGround:_updateTiledLayerPos(arg_16_1)
	for iter_16_0, iter_16_1 in pairs((self:_doTiledLayer())) do
		local var_16_0 = arg_16_1:getLayer(iter_16_1)

		if var_16_0 then
			local var_16_1 = var_16_0:getTileSet():getTileOffset()

			var_16_0:setPosition(var_16_1.x, -var_16_1.y)
		end
	end
end

function PubgMapGround:_initDebugGrid()
	self._gridView = cc.Node:create()

	self:addChild(self._gridView)

	self._gridLine = cc.DrawNode:create()

	self._gridView:addChild(self._gridLine)

	local var_17_0 = {
		cc.p(-self._MAP_TILE_HW, 0),
		cc.p(0, self._MAP_TILE_HH),
		cc.p(self._MAP_TILE_HW, 0),
		cc.p(0, -self._MAP_TILE_HH)
	}

	local function var_17_1(arg_18_0, arg_18_1, arg_18_2)
		for iter_18_0, iter_18_1 in pairs(arg_18_0) do
			iter_18_1.x = iter_18_1.x + arg_18_1
			iter_18_1.y = iter_18_1.y + arg_18_2
		end

		return arg_18_0
	end

	for iter_17_0 = 0, self._MAP_GRID_MAXX - 1 do
		for iter_17_1 = 0, self._MAP_GRID_MAXY - 1 do
			local var_17_2, var_17_3 = self:coordToPixel(iter_17_0, iter_17_1)

			var_17_0 = var_17_1(var_17_0, var_17_2, var_17_3)

			self._gridLine:drawPoly(var_17_0, 4, true, var_0_0.map.MAP_DEBUG_COLORF)

			var_17_0 = var_17_1(var_17_0, -var_17_2, -var_17_3)
		end
	end
end

function PubgMapGround:_initDebugGridText()
	self._gridTxt = cc.Node:create()

	self._gridView:addChild(self._gridTxt)

	for iter_19_0 = 0, self._MAP_GRID_MAXX - 1 do
		for iter_19_1 = 0, self._MAP_GRID_MAXY - 1 do
			if iter_19_0 % 10 == 0 and iter_19_1 % 10 == 0 then
				local var_19_0, var_19_1 = self:coordToPixel(iter_19_0, iter_19_1)
				local var_19_2 = ccui.Text:create(iter_19_0 .. "," .. iter_19_1, "", 16)

				var_19_2:setTextColor(var_0_0.map.MAP_DEBUG_COLORB)
				var_19_2:setPosition(var_19_0, var_19_1)
				self._gridTxt:addChild(var_19_2)
			end
		end
	end
end

return PubgMapGround
