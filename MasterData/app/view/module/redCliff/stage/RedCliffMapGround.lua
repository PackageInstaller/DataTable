local var_0_0 = g.core.const.ConstMgr.RedCliffConst
local RedCliffMapCommon = require("app.view.module.redCliff.common.RedCliffMapCommon")
local MapConst = require("app.core.ksmap.MapConst")
local RedCliffMapGround = class("RedCliffMapGround", require("app.core.ksmap.MapGround"))

function RedCliffMapGround:ctor(arg_1_1)
	if not config.SHOW_DEBUG_BTN then
		if config.DEBUG_VERSION then
			var_0_0.MAP_DEBUG_TILED = require("app.view.module.debug.common.DebugCommon").getDebugGlobalValueByKey("redCliff_map_btn")
		end
	end

	RedCliffMapGround.super.ctor(self, arg_1_1)

	self._gridLine = nil
	self._gridTxt = nil
	self._gridView = nil
end

function RedCliffMapGround:checkAndLoadParts(arg_2_1)
	return
end

function RedCliffMapGround:coordToPixel(arg_3_1, arg_3_2)
	return (arg_3_1 - arg_3_2) * self._MAP_TILE_HW, -(arg_3_1 + arg_3_2) * self._MAP_TILE_HH
end

function RedCliffMapGround:_initTiledMap()
	RedCliffMapGround.super._initTiledMap(self)
	RedCliffMapCommon.setMapTiledSize((self._tiledMap:getTileSize()))
end

function RedCliffMapGround:doBasePath()
	return "maps/redCliff/"
end

function RedCliffMapGround:_doTiledLayer()
	return {
		"ground"
	}
end

function RedCliffMapGround:doAttachNode()
	return {
		"ground"
	}
end

function RedCliffMapGround:initGround()
	self:_initTiledMap()
	self:_initAttachNode()

	if var_0_0.MAP_DEBUG_TILED then
		self:_initDebugGrid()
		self:_initDebugGridText()
	end
end

function RedCliffMapGround:_initDebugGrid()
	self._gridView = cc.Node:create()

	self:addChild(self._gridView)

	self._gridLine = cc.DrawNode:create()

	self._gridView:addChild(self._gridLine)

	local var_9_0 = {
		cc.p(-self._MAP_TILE_HW, 0),
		cc.p(0, self._MAP_TILE_HH),
		cc.p(self._MAP_TILE_HW, 0),
		cc.p(0, -self._MAP_TILE_HH)
	}

	local function var_9_1(arg_10_0, arg_10_1, arg_10_2)
		for iter_10_0, iter_10_1 in pairs(arg_10_0) do
			iter_10_1.x = iter_10_1.x + arg_10_1
			iter_10_1.y = iter_10_1.y + arg_10_2
		end

		return arg_10_0
	end

	for iter_9_0 = 0, self._MAP_GRID_MAXX - 1 do
		for iter_9_1 = 0, self._MAP_GRID_MAXY - 1 do
			local var_9_2, var_9_3 = self:coordToPixel(iter_9_0, iter_9_1)

			var_9_0 = var_9_1(var_9_0, var_9_2, var_9_3)

			self._gridLine:drawPoly(var_9_0, 4, true, MapConst.DEBUG_COLORF)

			var_9_0 = var_9_1(var_9_0, -var_9_2, -var_9_3)
		end
	end
end

function RedCliffMapGround:_initDebugGridText()
	self._gridTxt = cc.Node:create()

	self._gridView:addChild(self._gridTxt)

	for iter_11_0 = 0, self._MAP_GRID_MAXX - 1 do
		for iter_11_1 = 0, self._MAP_GRID_MAXY - 1 do
			local var_11_0, var_11_1 = self:coordToPixel(iter_11_0, iter_11_1)
			local var_11_2 = ccui.Text:create(iter_11_0 .. "," .. iter_11_1, "", 16)

			var_11_2:setTextColor(cc.c4b(0, 0, 0, 255))
			var_11_2:setPosition(var_11_0, var_11_1)
			var_11_2:setGlobalZOrder(10000)
			self._gridTxt:addChild(var_11_2)
		end
	end
end

return RedCliffMapGround
