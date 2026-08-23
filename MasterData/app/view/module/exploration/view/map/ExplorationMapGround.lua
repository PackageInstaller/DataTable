local ExplorationConst = require("app.view.module.exploration.const.ExplorationConst")
local ExplorationMapCommon = require("app.view.module.exploration.common.ExplorationMapCommon")
local ExplorationMapGround = class("ExplorationMapGround", function()
	return cc.Node:create()
end)

function ExplorationMapGround:ctor(arg_2_1)
	if not config.SHOW_DEBUG_BTN then
		if config.DEBUG_VERSION then
			ExplorationConst.MAP_DEBUG_TILED = require("app.view.module.debug.common.DebugCommon").getDebugGlobalValueByKey("exploration_map_btn")
		end
	end

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
	self._tiledDict = {}

	self:initGround()
end

function ExplorationMapGround:initGround()
	self:_initTiledMap()

	if ExplorationConst.MAP_DEBUG_TILED then
		self:_initDebugGrid()
		self:_initDebugGridText()
	end
end

function ExplorationMapGround:getMapWorld()
	return self._fatherWorld
end

function ExplorationMapGround:getMapStage()
	return self._fatherWorld:getMapStage()
end

function ExplorationMapGround:getMapWidth()
	return self._MAP_WIDTH
end

function ExplorationMapGround:getMapHeight()
	return self._MAP_HEIGHT
end

function ExplorationMapGround:getHalfTileW()
	return self._MAP_TILE_HW
end

function ExplorationMapGround:getHalfTileH()
	return self._MAP_TILE_HH
end

function ExplorationMapGround:coordToPixel(arg_10_1, arg_10_2)
	return (arg_10_1 - arg_10_2) * self._MAP_TILE_HW, -(arg_10_1 + arg_10_2) * self._MAP_TILE_HH
end

function ExplorationMapGround:pixelToCoord(arg_11_1, arg_11_2)
	return math.round((arg_11_1 / self._MAP_TILE_HW + -arg_11_2 / self._MAP_TILE_HH) / 2), math.round((-arg_11_2 / self._MAP_TILE_HH - arg_11_1 / self._MAP_TILE_HW) / 2)
end

function ExplorationMapGround:checkCoordInvalid(arg_12_1, arg_12_2)
	if arg_12_1 < 0 or arg_12_1 >= self._MAP_GRID_MAXX or arg_12_2 < 0 or arg_12_2 >= self._MAP_GRID_MAXY then
		return true
	else
		return false
	end
end

function ExplorationMapGround:getFixOFF()
	return self._FIX_OFF_X, self._FIX_OFF_Y
end

function ExplorationMapGround:doBasePath()
	return g.core.common.Path:getGveBasePath()
end

function ExplorationMapGround:_doTiledLayer()
	return {
		"ground"
	}
end

function ExplorationMapGround:doAttachNode()
	return {
		"ground"
	}
end

function ExplorationMapGround:getAttachRoot(arg_17_1)
	return self._attachDict[arg_17_1]
end

function ExplorationMapGround:addVisual(arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = self:getAttachRoot(arg_18_2)

	if var_18_0 then
		var_18_0:addChild(arg_18_1)

		if arg_18_3 then
			local var_18_1, var_18_2 = self:coordToPixel(arg_18_3.x, arg_18_3.y)

			arg_18_1:setPosBothZ(cc.p(var_18_1, var_18_2))
		end
	end
end

function ExplorationMapGround:_initTiledMap()
	local var_19_0 = g.core.model.User.explorationData:getMapData()
	local var_19_1 = var_19_0:getCurMapId()
	local var_19_2 = var_19_0:getCurMapInfo()

	self._tiledMap = ccexp.TMXTiledMap:create("maps/exploration/" .. var_19_1 .. "/" .. var_19_1 .. ".tmx")
	self._tiledDict["0_0"] = self._tiledMap

	local var_19_3 = self._tiledMap:getTileSize()

	self._MAP_TILE_HW = var_19_3.width / 2
	self._MAP_TILE_HH = var_19_3.height / 2

	local var_19_4 = self._tiledMap:getMapSize()

	var_19_4.width = var_19_4.width - 1
	var_19_4.height = var_19_4.height - 1

	ExplorationMapCommon.setMapTiledSize(var_19_3)
	ExplorationMapCommon.setRoomSize(var_19_4)

	self._MAP_GRID_MAXX = var_19_2.maxX * var_19_4.width
	self._MAP_GRID_MAXY = var_19_2.maxY * var_19_4.height
	self._CELL_WIDTH = (var_19_4.width + var_19_4.height) * self._MAP_TILE_HW
	self._CELL_HEIGHT = (var_19_4.width + var_19_4.height) * self._MAP_TILE_HH
	self._MAP_WIDTH = (self._MAP_GRID_MAXX + self._MAP_GRID_MAXY) * self._MAP_TILE_HW
	self._MAP_HEIGHT = (self._MAP_GRID_MAXX + self._MAP_GRID_MAXY) * self._MAP_TILE_HH
	self._FIX_OFF_X = (var_19_4.width + 1) * self._MAP_TILE_HW
	self._FIX_OFF_Y = self._CELL_HEIGHT - self._MAP_TILE_HH + var_19_3.height

	self._tiledMap:setPosition(-self._FIX_OFF_X, -self._FIX_OFF_Y)
	self:_updateTiledLayerPos(self._tiledMap)

	local var_19_5 = {}

	for iter_19_0, iter_19_1 in pairs(var_19_2.roomTab) do
		local var_19_6 = iter_19_1:getCfg()
		local var_19_7, var_19_8 = iter_19_1:getRoomCoordinate()
		local var_19_9 = ccexp.TMXTiledMap:create("maps/exploration/" .. var_19_6.room_id .. "/" .. var_19_6.room_id .. ".tmx")

		table.insert(var_19_5, {
			tiledMap = var_19_9,
			zOrder = iter_19_1:getRoomZOrder(),
			id = var_19_6.room_id
		})
		var_19_9:setPosition(-self._FIX_OFF_X + (var_19_7 - 1) * self._CELL_WIDTH / 2 - (var_19_8 - 1) * self._CELL_WIDTH / 2, -self._FIX_OFF_Y - (var_19_7 - 1) * self._CELL_HEIGHT / 2 - (var_19_8 - 1) * self._CELL_HEIGHT / 2)
		self:_updateTiledLayerPos(var_19_9)

		self._tiledDict[var_19_7 .. "_" .. var_19_8] = var_19_9
	end

	table.sort(var_19_5, function(arg_20_0, arg_20_1)
		if arg_20_0.zOrder ~= arg_20_1.zOrder then
			return arg_20_0.zOrder < arg_20_1.zOrder
		end

		return arg_20_0.id < arg_20_1.id
	end)

	for iter_19_2, iter_19_3 in ipairs(var_19_5) do
		self:addChild(iter_19_3.tiledMap)
	end
end

function ExplorationMapGround:checkAndLoadParts(arg_21_1)
	return
end

function ExplorationMapGround:getTargetPosTiledId(arg_22_1)
	local var_22_0 = self._tiledDict[math.floor(arg_22_1.x / 58) .. "_" .. math.floor(arg_22_1.y / 58)]

	if not var_22_0 then
		return 0
	end

	return var_22_0:getLayer("ground"):getTileGIDAt(cc.p(arg_22_1.x % 58, arg_22_1.y % 58))
end

function ExplorationMapGround:_updateTiledLayerPos(arg_23_1)
	for iter_23_0, iter_23_1 in pairs((self:_doTiledLayer())) do
		local var_23_0 = arg_23_1:getLayer(iter_23_1)

		if var_23_0 then
			local var_23_1 = var_23_0:getTileSet():getTileOffset()

			var_23_0:setPosition(var_23_1.x, -var_23_1.y)
		end
	end
end

function ExplorationMapGround:_initDebugGrid()
	self._gridView = cc.Node:create()

	self:addChild(self._gridView)

	self._gridLine = cc.DrawNode:create()

	self._gridView:addChild(self._gridLine)

	local var_24_0 = {
		cc.p(-self._MAP_TILE_HW, 0),
		cc.p(0, self._MAP_TILE_HH),
		cc.p(self._MAP_TILE_HW, 0),
		cc.p(0, -self._MAP_TILE_HH)
	}

	local function var_24_1(arg_25_0, arg_25_1, arg_25_2)
		for iter_25_0, iter_25_1 in pairs(arg_25_0) do
			iter_25_1.x = iter_25_1.x + arg_25_1
			iter_25_1.y = iter_25_1.y + arg_25_2
		end

		return arg_25_0
	end

	for iter_24_0 = 0, self._MAP_GRID_MAXX - 1 do
		for iter_24_1 = 0, self._MAP_GRID_MAXY - 1 do
			local var_24_2, var_24_3 = self:coordToPixel(iter_24_0, iter_24_1)

			var_24_0 = var_24_1(var_24_0, var_24_2, var_24_3)

			self._gridLine:drawPoly(var_24_0, 4, true, ExplorationConst.MAP.MAP_DEBUG_COLORF)

			var_24_0 = var_24_1(var_24_0, -var_24_2, -var_24_3)
		end
	end
end

function ExplorationMapGround:_initDebugGridText()
	self._gridTxt = cc.Node:create()

	self._gridView:addChild(self._gridTxt)

	for iter_26_0 = 0, self._MAP_GRID_MAXX - 1 do
		for iter_26_1 = 0, self._MAP_GRID_MAXY - 1 do
			local var_26_0, var_26_1 = self:coordToPixel(iter_26_0, iter_26_1)
			local var_26_2

			if iter_26_0 % 9 == 0 and iter_26_1 % 9 == 0 then
				var_26_2 = "room-> x: " .. math.ceil(iter_26_0 / 9) .. " y: " .. math.ceil(iter_26_1 / 9)
			elseif iter_26_0 % 9 % 2 == 0 and iter_26_1 % 9 % 2 == 0 then
				var_26_2 = string.format("x: %d y: %d", iter_26_0 % 9, iter_26_1 % 9)
			end

			if var_26_2 then
				local var_26_3 = ccui.Text:create(var_26_2, "", 16)

				var_26_3:setTextColor(ExplorationConst.MAP.MAP_DEBUG_COLORB)
				var_26_3:setPosition(var_26_0, var_26_1)
				self._gridTxt:addChild(var_26_3)
			end
		end
	end
end

function ExplorationMapGround:_testTiledMap(arg_27_1, arg_27_2, arg_27_3, arg_27_4)
	local var_27_0 = cc.Sprite:create("ui_cocos/storm/icon_zhandou.png")

	var_27_0:setPosition((cc.p(arg_27_1:getTiledWorldPosition(arg_27_2, arg_27_4))))
	table.insert(arg_27_3, var_27_0)
end

return ExplorationMapGround
