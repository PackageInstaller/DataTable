local var_0_0 = g.core.const.ConstMgr.GveConst
local GveMapGround = class("GveMapGround", function()
	return cc.Node:create()
end)

function GveMapGround:ctor(arg_2_1)
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

function GveMapGround:initGround()
	self:_initTiledMap()

	if var_0_0.MAP_DEBUG_GRID then
		self:_initDebugGrid()
		self:_initDebugGridText()
	end
end

function GveMapGround:getMapWorld()
	return self._fatherWorld
end

function GveMapGround:getMapStage()
	return self._fatherWorld:getMapStage()
end

function GveMapGround:getMapWidth()
	return self._MAP_WIDTH
end

function GveMapGround:getMapHeight()
	return self._MAP_HEIGHT
end

function GveMapGround:getHalfTileH()
	return self._MAP_TILE_HH
end

function GveMapGround:coordToPixel(arg_9_1, arg_9_2)
	return (arg_9_1 - arg_9_2) * self._MAP_TILE_HW, -(arg_9_1 + arg_9_2) * self._MAP_TILE_HH
end

function GveMapGround:pixelToCoord(arg_10_1, arg_10_2)
	return math.round((arg_10_1 / self._MAP_TILE_HW + -arg_10_2 / self._MAP_TILE_HH) / 2), math.round((-arg_10_2 / self._MAP_TILE_HH - arg_10_1 / self._MAP_TILE_HW) / 2)
end

function GveMapGround:checkCoordInvalid(arg_11_1, arg_11_2)
	if arg_11_1 < 0 or arg_11_1 >= self._MAP_GRID_MAXX or arg_11_2 < 0 or arg_11_2 >= self._MAP_GRID_MAXY then
		return true
	else
		return false
	end
end

function GveMapGround:doBasePath()
	return g.core.common.Path:getGveBasePath()
end

function GveMapGround:_doTiledLayer()
	return {
		"ground"
	}
end

function GveMapGround:doAttachNode()
	return {
		"ground"
	}
end

function GveMapGround:_initTiledMap()
	local var_15_0 = self:getMapWorld():getMapId()

	self._tiledMap = ccexp.TMXTiledMap:create(self:doBasePath() .. var_15_0 .. "/" .. var_15_0 .. "_0_0.tmx")
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

	for iter_15_0 = 0, 4 do
		for iter_15_1 = 0, 4 do
			if iter_15_0 + iter_15_1 > 0 then
				local var_15_3 = ccexp.TMXTiledMap:create(self:doBasePath() .. var_15_0 .. "/" .. var_15_0 .. "_" .. iter_15_0 .. "_" .. iter_15_1 .. ".tmx")

				self:addChild(var_15_3)
				var_15_3:setPosition(-self._FIX_OFF_X + iter_15_0 * self._CELL_WIDTH / 2 - iter_15_1 * self._CELL_WIDTH / 2, -self._FIX_OFF_Y - iter_15_0 * self._CELL_HEIGHT / 2 - iter_15_1 * self._CELL_HEIGHT / 2)
				self:_updateTiledLayerPos(var_15_3)

				self._tiledDict[iter_15_0 .. "_" .. iter_15_1] = var_15_3
			end
		end
	end
end

function GveMapGround:checkAndLoadParts(arg_16_1)
	return
end

function GveMapGround:getTargetPosTiledId(arg_17_1)
	local var_17_0 = self._tiledDict[math.floor(arg_17_1.x / 58) .. "_" .. math.floor(arg_17_1.y / 58)]

	if not var_17_0 then
		return 0
	end

	return var_17_0:getLayer("ground"):getTileGIDAt(cc.p(arg_17_1.x % 58, arg_17_1.y % 58))
end

function GveMapGround:_updateTiledLayerPos(arg_18_1)
	for iter_18_0, iter_18_1 in pairs((self:_doTiledLayer())) do
		local var_18_0 = arg_18_1:getLayer(iter_18_1)

		if var_18_0 then
			local var_18_1 = var_18_0:getTileSet():getTileOffset()

			var_18_0:setPosition(var_18_1.x, -var_18_1.y)
		end
	end
end

function GveMapGround:_initDebugGrid()
	self._gridView = cc.Node:create()

	self:addChild(self._gridView)

	self._gridLine = cc.DrawNode:create()

	self._gridView:addChild(self._gridLine)

	local var_19_0 = {
		cc.p(-self._MAP_TILE_HW, 0),
		cc.p(0, self._MAP_TILE_HH),
		cc.p(self._MAP_TILE_HW, 0),
		cc.p(0, -self._MAP_TILE_HH)
	}

	local function var_19_1(arg_20_0, arg_20_1, arg_20_2)
		for iter_20_0, iter_20_1 in pairs(arg_20_0) do
			iter_20_1.x = iter_20_1.x + arg_20_1
			iter_20_1.y = iter_20_1.y + arg_20_2
		end

		return arg_20_0
	end

	for iter_19_0 = 0, self._MAP_GRID_MAXX - 1 do
		for iter_19_1 = 0, self._MAP_GRID_MAXY - 1 do
			local var_19_2, var_19_3 = self:coordToPixel(iter_19_0, iter_19_1)

			var_19_0 = var_19_1(var_19_0, var_19_2, var_19_3)

			self._gridLine:drawPoly(var_19_0, 4, true, var_0_0.MAP_DEBUG_COLORF)

			var_19_0 = var_19_1(var_19_0, -var_19_2, -var_19_3)
		end
	end
end

function GveMapGround:_initDebugGridText()
	self._gridTxt = cc.Node:create()

	self._gridView:addChild(self._gridTxt)

	for iter_21_0 = 0, self._MAP_GRID_MAXX - 1 do
		for iter_21_1 = 0, self._MAP_GRID_MAXY - 1 do
			if iter_21_0 % 10 == 0 and iter_21_1 % 10 == 0 then
				local var_21_0, var_21_1 = self:coordToPixel(iter_21_0, iter_21_1)
				local var_21_2 = ccui.Text:create(iter_21_0 .. "," .. iter_21_1, "", 16)

				var_21_2:setTextColor(var_0_0.MAP_DEBUG_COLORB)
				var_21_2:setPosition(var_21_0, var_21_1)
				self._gridTxt:addChild(var_21_2)
			end
		end
	end
end

return GveMapGround
