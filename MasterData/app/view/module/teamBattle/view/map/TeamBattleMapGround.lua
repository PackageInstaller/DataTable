local TeamBattleConst = require("app.view.module.teamBattle.const.TeamBattleConst")
local TeamBattleMapCommon = require("app.view.module.teamBattle.common.TeamBattleMapCommon")
local TeamBattleMapGround = class("TeamBattleMapGround", function()
	return cc.Node:create()
end)

function TeamBattleMapGround:ctor(arg_2_1)
	if config.SHOW_DEBUG_BTN or config.DEBUG_VERSION then
		local DebugCommon = require("app.view.module.debug.common.DebugCommon")
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

function TeamBattleMapGround:initGround()
	self:_initTiledMap()

	if TeamBattleConst.MAP_DEBUG_TILED then
		self:_initDebugGrid()
		self:_initDebugGridText()
	end
end

function TeamBattleMapGround:getMapWorld()
	return self._fatherWorld
end

function TeamBattleMapGround:getMapStage()
	return self._fatherWorld:getMapStage()
end

function TeamBattleMapGround:getMapWidth()
	return self._MAP_WIDTH
end

function TeamBattleMapGround:getMapHeight()
	return self._MAP_HEIGHT
end

function TeamBattleMapGround:getHalfTileW()
	return self._MAP_TILE_HW
end

function TeamBattleMapGround:getHalfTileH()
	return self._MAP_TILE_HH
end

function TeamBattleMapGround:coordToPixel(arg_10_1, arg_10_2)
	return (arg_10_1 - arg_10_2) * self._MAP_TILE_HW, -(arg_10_1 + arg_10_2) * self._MAP_TILE_HH
end

function TeamBattleMapGround:pixelToCoord(arg_11_1, arg_11_2)
	return math.round((arg_11_1 / self._MAP_TILE_HW + -arg_11_2 / self._MAP_TILE_HH) / 2), math.round((-arg_11_2 / self._MAP_TILE_HH - arg_11_1 / self._MAP_TILE_HW) / 2)
end

function TeamBattleMapGround:checkCoordInvalid(arg_12_1, arg_12_2)
	if arg_12_1 < 0 or arg_12_1 >= self._MAP_GRID_MAXX or arg_12_2 < 0 or arg_12_2 >= self._MAP_GRID_MAXY then
		return true
	else
		return false
	end
end

function TeamBattleMapGround:getFixOFF()
	return self._FIX_OFF_X, self._FIX_OFF_Y
end

function TeamBattleMapGround:doBasePath()
	return g.core.common.Path:getGveBasePath()
end

function TeamBattleMapGround:_doTiledLayer()
	return {
		"ground"
	}
end

function TeamBattleMapGround:doAttachNode()
	return {
		"ground"
	}
end

function TeamBattleMapGround:getAttachRoot(arg_17_1)
	return self._attachDict[arg_17_1]
end

function TeamBattleMapGround:addVisual(arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = self:getAttachRoot(arg_18_2)

	if var_18_0 then
		var_18_0:addChild(arg_18_1)

		if arg_18_3 then
			local var_18_1, var_18_2 = self:coordToPixel(arg_18_3.x, arg_18_3.y)

			arg_18_1:setPosBothZ(cc.p(var_18_1, var_18_2))
		end
	end
end

function TeamBattleMapGround:_initTiledMap()
	local var_19_0 = g.core.model.User.teamBattleData:getMapData():getCurMapInfo()

	self._tiledMap = ccexp.TMXTiledMap:create("maps/teamBattle/" .. 1 .. "/" .. 1 .. ".tmx")

	local var_19_2 = self._tiledMap:getTileSize()

	self._MAP_TILE_HW = var_19_2.width / 2
	self._MAP_TILE_HH = var_19_2.height / 2

	local var_19_3 = self._tiledMap:getMapSize()

	TeamBattleMapCommon.setMapTiledSize(var_19_2)
	TeamBattleMapCommon.setRoomSize(var_19_3)

	self._MAP_GRID_MAXX = var_19_0.maxX * var_19_3.width
	self._MAP_GRID_MAXY = var_19_0.maxY * var_19_3.height
	self._CELL_WIDTH = (var_19_3.width + var_19_3.height) * self._MAP_TILE_HW
	self._CELL_HEIGHT = (var_19_3.width + var_19_3.height) * self._MAP_TILE_HH
	self._MAP_WIDTH = (self._MAP_GRID_MAXX + self._MAP_GRID_MAXY) * self._MAP_TILE_HW
	self._MAP_HEIGHT = (self._MAP_GRID_MAXX + self._MAP_GRID_MAXY) * self._MAP_TILE_HH
	self._FIX_OFF_X = var_19_3.width * self._MAP_TILE_HW
	self._FIX_OFF_Y = self._CELL_HEIGHT - self._MAP_TILE_HH + var_19_2.height

	self._tiledMap:setPosition(-self._FIX_OFF_X, -self._FIX_OFF_Y)
	self:_updateTiledLayerPos(self._tiledMap)
end

function TeamBattleMapGround:checkAndLoadParts(arg_20_1)
	return
end

function TeamBattleMapGround:_updateTiledLayerPos(arg_21_1)
	for iter_21_0, iter_21_1 in pairs((self:_doTiledLayer())) do
		local var_21_0 = arg_21_1:getLayer(iter_21_1)

		if var_21_0 then
			local var_21_1 = var_21_0:getTileSet():getTileOffset()

			var_21_0:setPosition(var_21_1.x, -var_21_1.y)
		end
	end
end

function TeamBattleMapGround:_initDebugGrid()
	self._gridView = cc.Node:create()

	self:addChild(self._gridView)

	self._gridLine = cc.DrawNode:create()

	self._gridView:addChild(self._gridLine)

	local var_22_0 = {
		cc.p(-self._MAP_TILE_HW, 0),
		cc.p(0, self._MAP_TILE_HH),
		cc.p(self._MAP_TILE_HW, 0),
		cc.p(0, -self._MAP_TILE_HH)
	}

	local function var_22_1(arg_23_0, arg_23_1, arg_23_2)
		for iter_23_0, iter_23_1 in pairs(arg_23_0) do
			iter_23_1.x = iter_23_1.x + arg_23_1
			iter_23_1.y = iter_23_1.y + arg_23_2
		end

		return arg_23_0
	end

	for iter_22_0 = 0, self._MAP_GRID_MAXX - 1 do
		for iter_22_1 = 0, self._MAP_GRID_MAXY - 1 do
			local var_22_2, var_22_3 = self:coordToPixel(iter_22_0, iter_22_1)

			var_22_0 = var_22_1(var_22_0, var_22_2, var_22_3)

			self._gridLine:drawPoly(var_22_0, 4, true, TeamBattleConst.MAP.MAP_DEBUG_COLORF)

			var_22_0 = var_22_1(var_22_0, -var_22_2, -var_22_3)
		end
	end
end

function TeamBattleMapGround:_initDebugGridText()
	self._gridTxt = cc.Node:create()

	self._gridView:addChild(self._gridTxt)

	for iter_24_0 = 0, self._MAP_GRID_MAXX - 1 do
		for iter_24_1 = 0, self._MAP_GRID_MAXY - 1 do
			local var_24_0, var_24_1 = self:coordToPixel(iter_24_0, iter_24_1)
			local var_24_2

			if iter_24_0 % 20 == 0 and iter_24_1 % 20 == 0 then
				var_24_2 = "room-> x: " .. math.ceil(iter_24_0 / 19) .. " y: " .. math.ceil(iter_24_1 / 19)
			elseif iter_24_0 % 20 % 2 == 0 and iter_24_1 % 20 % 2 == 0 then
				var_24_2 = string.format("x: %d y: %d \n wx:%d wy:%d", iter_24_0 % 20, iter_24_1 % 20, iter_24_0, iter_24_1)
			end

			if var_24_2 then
				local var_24_3 = ccui.Text:create(var_24_2, "", 16)

				var_24_3:setTextColor(TeamBattleConst.MAP.MAP_DEBUG_COLORB)
				var_24_3:setPosition(var_24_0, var_24_1)
				self._gridTxt:addChild(var_24_3)
			end
		end
	end
end

function TeamBattleMapGround:getRoomRange(arg_25_1, arg_25_2)
	local var_25_0 = TeamBattleMapCommon.getRoomSize()
	local var_25_1, var_25_2 = self:coordToPixel((arg_25_1 - 1) * var_25_0.width, (arg_25_2 - 1) * var_25_0.height)
	local var_25_3, var_25_4 = self:coordToPixel(arg_25_1 * var_25_0.width, arg_25_2 * var_25_0.height)
	local var_25_5, var_25_6 = self:coordToPixel((arg_25_1 - 1) * var_25_0.width, arg_25_2 * var_25_0.height)
	local var_25_7, var_25_8 = self:coordToPixel(arg_25_1 * var_25_0.width, (arg_25_2 - 1) * var_25_0.height)

	return {
		minX = -var_25_7,
		minY = -var_25_2,
		maxX = -var_25_5,
		maxY = -var_25_4
	}
end

return TeamBattleMapGround
