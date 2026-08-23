local var_0_0 = true
local var_0_1 = cc.c4b(30, 230, 230, 255)
local var_0_2 = g.core.const.ConstMgr.FurnitureConst
local var_0_3 = g.core.const.ConstMgr.FurnitureConst.PlaneType
local FurnitureRoomGird = class("FurnitureRoomGird", function()
	return cc.Node:create()
end)

function FurnitureRoomGird:ctor(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	self._fatherWorld = arg_2_1
	self._MAP_GRID_MAXX = 0
	self._MAP_GRID_MAXY = 0
	self._MAP_WIDTH = 0
	self._MAP_HEIGHT = 0
	self._MAP_TILE_HW = 0
	self._MAP_TILE_HH = 0
	self._MAP_GRID_MAXZ = 0
	self._MAP_TILE_Z_LEN = 0
	self._MAP_Z_LENGTH = 0
	self._TILE_OFF_Z = 0
	self._gridView = nil
	self._gridLine = nil
	self._gridTxt = nil

	if arg_2_2 then
		self:initGround(arg_2_3, arg_2_4, arg_2_5)
	end
end

function FurnitureRoomGird:initGround(arg_3_1, arg_3_2, arg_3_3)
	self:_initTiled(arg_3_1, arg_3_2, arg_3_3)

	if var_0_0 then
		self:_initDebugGrid()
		self:_initDebugGridZR()
		self:_initDebugGridZL()
		self:showGridCoord(false)
	end
end

function FurnitureRoomGird:getMapWorld()
	return self._fatherWorld
end

function FurnitureRoomGird:getMapStage()
	return self._fatherWorld:getMapStage()
end

function FurnitureRoomGird:getMapWidth()
	return self._MAP_WIDTH
end

function FurnitureRoomGird:getMapHeight()
	return self._MAP_HEIGHT
end

function FurnitureRoomGird:getMapDepth()
	return self._MAP_Z_LENGTH
end

function FurnitureRoomGird:getHalfTileH()
	return self._MAP_TILE_HH
end

function FurnitureRoomGird:changeCoordToPixel(arg_10_1, arg_10_2, arg_10_3)
	if arg_10_1 == var_0_3.GROUND then
		return self:coordToPixel(arg_10_2, arg_10_3)
	elseif arg_10_1 == var_0_3.RIGHT_WALL then
		return self:coordToPixelZR(arg_10_2, arg_10_3)
	else
		return self:coordToPixelZL(arg_10_2, arg_10_3)
	end
end

function FurnitureRoomGird:changeCoordToPixelTop(arg_11_1, arg_11_2, arg_11_3)
	local var_11_0
	local var_11_1

	if arg_11_1 == var_0_3.GROUND then
		var_11_0, var_11_1 = self:coordToPixel(arg_11_2, arg_11_3)
		var_11_1 = var_11_1 + self._MAP_TILE_HH
	elseif arg_11_1 == var_0_3.RIGHT_WALL then
		var_11_0, var_11_1 = self:coordToPixelZR(arg_11_2, arg_11_3)
		var_11_0 = var_11_0 - self._MAP_TILE_HW / 2
		var_11_1 = var_11_1 - self._TILE_OFF_Z
	else
		var_11_0, var_11_1 = self:coordToPixelZL(arg_11_2, arg_11_3)
		var_11_0 = var_11_0 + self._MAP_TILE_HW / 2
		var_11_1 = var_11_1 - self._TILE_OFF_Z
	end

	return var_11_0, var_11_1
end

function FurnitureRoomGird:changePixelToCoord(arg_12_1, arg_12_2, arg_12_3)
	if arg_12_3 then
		arg_12_2 = arg_12_3 == var_0_3.GROUND and arg_12_2 - self._MAP_TILE_HH or arg_12_2 + self._TILE_OFF_Z
	end

	local var_12_0, var_12_1 = self:pixelToCoord(arg_12_1, arg_12_2)

	if var_12_0 >= 0 and var_12_1 >= 0 then
		return var_0_3.GROUND, var_12_0, var_12_1
	end

	local var_12_2, var_12_3 = self:pixelToCoordZR(arg_12_1, arg_12_2)

	if var_12_2 >= 0 and var_12_3 >= 0 then
		return var_0_3.RIGHT_WALL, var_12_2, var_12_3
	end

	local var_12_4, var_12_5 = self:pixelToCoordZL(arg_12_1, arg_12_2)

	if var_12_4 >= 0 and var_12_5 >= 0 then
		return var_0_3.LEFT_WALL, var_12_4, var_12_5
	end
end

function FurnitureRoomGird:checkCoordInvalid(arg_13_1, arg_13_2, arg_13_3)
	if arg_13_2 < 0 or arg_13_3 < 0 then
		return true
	elseif arg_13_1 == var_0_3.GROUND then
		return arg_13_2 >= self._MAP_GRID_MAXX or arg_13_3 >= self._MAP_GRID_MAXY
	elseif arg_13_1 == var_0_3.RIGHT_WALL then
		return arg_13_2 >= self._MAP_GRID_MAXX or arg_13_3 >= self._MAP_GRID_MAXZ
	else
		return arg_13_2 >= self._MAP_GRID_MAXY or arg_13_3 >= self._MAP_GRID_MAXZ
	end
end

function FurnitureRoomGird:coordToPixel(arg_14_1, arg_14_2)
	return (arg_14_1 - arg_14_2) * self._MAP_TILE_HW, -(arg_14_1 + arg_14_2) * self._MAP_TILE_HH - self._MAP_TILE_HH
end

function FurnitureRoomGird:pixelToCoord(arg_15_1, arg_15_2)
	return math.round((arg_15_1 / self._MAP_TILE_HW + -(arg_15_2 + self._MAP_TILE_HH) / self._MAP_TILE_HH) / 2), math.round((-(arg_15_2 + self._MAP_TILE_HH) / self._MAP_TILE_HH - arg_15_1 / self._MAP_TILE_HW) / 2)
end

function FurnitureRoomGird:coordToPixelZR(arg_16_1, arg_16_2)
	return arg_16_1 * self._MAP_TILE_HW + self._MAP_TILE_HW / 2, arg_16_2 * self._MAP_TILE_Z_LEN - arg_16_1 * self._MAP_TILE_HH + self._TILE_OFF_Z
end

function FurnitureRoomGird:pixelToCoordZR(arg_17_1, arg_17_2)
	return math.round((arg_17_1 - self._MAP_TILE_HW / 2) / self._MAP_TILE_HW), math.round((arg_17_2 - self._TILE_OFF_Z + (arg_17_1 - self._MAP_TILE_HW / 2) / self._MAP_TILE_HW * self._MAP_TILE_HH) / self._MAP_TILE_Z_LEN)
end

function FurnitureRoomGird:coordToPixelZL(arg_18_1, arg_18_2)
	return -(arg_18_1 * self._MAP_TILE_HW + self._MAP_TILE_HW / 2), arg_18_2 * self._MAP_TILE_Z_LEN - arg_18_1 * self._MAP_TILE_HH + self._TILE_OFF_Z
end

function FurnitureRoomGird:pixelToCoordZL(arg_19_1, arg_19_2)
	return math.round((-arg_19_1 - self._MAP_TILE_HW / 2) / self._MAP_TILE_HW), math.round((arg_19_2 - self._TILE_OFF_Z + (-arg_19_1 - self._MAP_TILE_HW / 2) / self._MAP_TILE_HW * self._MAP_TILE_HH) / self._MAP_TILE_Z_LEN)
end

function FurnitureRoomGird:_initTiled(arg_20_1, arg_20_2, arg_20_3)
	self._MAP_TILE_HW = var_0_2.FURNITURE_GRID_WIDTH / 2
	self._MAP_TILE_HH = var_0_2.FURNITURE_GRID_HEIGHT / 2
	self._MAP_GRID_MAXX = arg_20_1
	self._MAP_GRID_MAXY = arg_20_2
	self._MAP_WIDTH = (self._MAP_GRID_MAXX + self._MAP_GRID_MAXY) * self._MAP_TILE_HW
	self._MAP_HEIGHT = (self._MAP_GRID_MAXX + self._MAP_GRID_MAXY) * self._MAP_TILE_HH
	self._MAP_GRID_MAXZ = arg_20_3
	self._MAP_TILE_Z_LEN = math.sqrt(self._MAP_TILE_HW * self._MAP_TILE_HW + self._MAP_TILE_HH * self._MAP_TILE_HH)
	self._MAP_Z_LENGTH = self._MAP_TILE_Z_LEN * self._MAP_GRID_MAXZ
	self._TILE_OFF_Z = 0.5 * self._MAP_TILE_HW * self._MAP_TILE_HW / (self._MAP_TILE_Z_LEN + self._MAP_TILE_HH)
end

function FurnitureRoomGird:showGridCell(arg_21_1)
	if self._gridLine then
		self._gridLine:setVisible(arg_21_1)
	end
end

function FurnitureRoomGird:showGridCoord(arg_22_1)
	if self._gridTxt then
		self._gridTxt:setVisible(arg_22_1)
	elseif var_0_0 then
		self:_initDebugGridText()
		self:_initDebugGridTextZR()
		self:_initDebugGridTextZL()
		self._gridTxt:setVisible(arg_22_1)
	end
end

function FurnitureRoomGird:createGroundGridCell(arg_23_1, arg_23_2)
	if self._tmpGridBox == nil then
		self._tmpGridBox = {
			cc.p(-self._MAP_TILE_HW, 0),
			cc.p(0, self._MAP_TILE_HH),
			cc.p(self._MAP_TILE_HW, 0),
			cc.p(0, -self._MAP_TILE_HH)
		}
	end

	local var_23_0 = cc.DrawNode:create()

	if arg_23_2 then
		var_23_0:drawPolygon(self._tmpGridBox, 4, arg_23_1, 0, arg_23_1)
	else
		var_23_0:drawPoly(self._tmpGridBox, 4, true, arg_23_1)
	end

	return var_23_0
end

function FurnitureRoomGird:createWallGridCell(arg_24_1, arg_24_2)
	local var_24_0 = self:_getGridCellPolyZL(0, 0)
	local var_24_1 = cc.DrawNode:create()

	if arg_24_2 then
		var_24_1:drawPolygon(var_24_0, 4, arg_24_1, 0, arg_24_1)
	else
		var_24_1:drawPoly(var_24_0, 4, true, arg_24_1)
	end

	return var_24_1
end

function FurnitureRoomGird:_initDebugGrid()
	self._gridView = cc.Node:create()

	self:addChild(self._gridView)

	self._gridLine = cc.DrawNode:create()

	self._gridView:addChild(self._gridLine)

	for iter_25_0 = 0, self._MAP_GRID_MAXX - 1 do
		for iter_25_1 = 0, self._MAP_GRID_MAXY - 1 do
			local var_25_0, var_25_1 = self:changeCoordToPixel(var_0_3.GROUND, iter_25_0, iter_25_1)

			self._gridLine:drawPoly(self:_getGridCellPoly(var_25_0, var_25_1), 4, true, var_0_2.DEBUG_GRID_COLORF)
		end
	end
end

function FurnitureRoomGird:setEditMode(arg_26_1)
	self._gridView:setVisible(arg_26_1)
end

function FurnitureRoomGird:_initDebugGridText()
	self._gridTxt = cc.Node:create()

	self._gridView:addChild(self._gridTxt)

	for iter_27_0 = 0, self._MAP_GRID_MAXX - 1 do
		for iter_27_1 = 0, self._MAP_GRID_MAXY - 1 do
			local var_27_0, var_27_1 = self:coordToPixel(iter_27_0, iter_27_1)
			local var_27_2 = ccui.Text:create(iter_27_0 .. "," .. iter_27_1, "", 16)

			var_27_2:setTextColor(var_0_1)
			var_27_2:setPosition(var_27_0, var_27_1)
			self._gridTxt:addChild(var_27_2)
		end
	end
end

function FurnitureRoomGird:_getGridCellPoly(arg_28_1, arg_28_2)
	local var_28_0 = {
		cc.p(-self._MAP_TILE_HW, 0),
		cc.p(0, self._MAP_TILE_HH),
		cc.p(self._MAP_TILE_HW, 0),
		cc.p(0, -self._MAP_TILE_HH)
	}

	for iter_28_0, iter_28_1 in pairs(var_28_0) do
		iter_28_1.x = iter_28_1.x + arg_28_1
		iter_28_1.y = iter_28_1.y + arg_28_2
	end

	return var_28_0
end

function FurnitureRoomGird:_initDebugGridZR()
	for iter_29_0 = 0, self._MAP_GRID_MAXX - 1 do
		for iter_29_1 = 0, self._MAP_GRID_MAXZ - 1 do
			local var_29_0, var_29_1 = self:changeCoordToPixel(var_0_3.RIGHT_WALL, iter_29_0, iter_29_1)

			self._gridLine:drawPoly(self:_getGridCellPolyZR(var_29_0, var_29_1), 4, true, var_0_2.DEBUG_GRID_COLORF)
		end
	end
end

function FurnitureRoomGird:_getGridCellPolyZR(arg_30_1, arg_30_2)
	local var_30_0 = {
		cc.p(-(self._MAP_TILE_HW / 2), 0 - self._TILE_OFF_Z),
		cc.p(-(self._MAP_TILE_HW / 2), self._MAP_TILE_Z_LEN - self._TILE_OFF_Z),
		cc.p(self._MAP_TILE_HW / 2, self._MAP_TILE_Z_LEN - self._MAP_TILE_HH - self._TILE_OFF_Z),
		cc.p(self._MAP_TILE_HW / 2, -self._MAP_TILE_HH - self._TILE_OFF_Z)
	}

	for iter_30_0, iter_30_1 in pairs(var_30_0) do
		iter_30_1.x = iter_30_1.x + arg_30_1
		iter_30_1.y = iter_30_1.y + arg_30_2
	end

	return var_30_0
end

function FurnitureRoomGird:_initDebugGridTextZR()
	for iter_31_0 = 0, self._MAP_GRID_MAXX - 1 do
		for iter_31_1 = 0, self._MAP_GRID_MAXZ - 1 do
			local var_31_0, var_31_1 = self:coordToPixelZR(iter_31_0, iter_31_1)
			local var_31_2 = ccui.Text:create(iter_31_0 .. "," .. iter_31_1, "", 16)

			var_31_2:setTextColor(var_0_1)
			var_31_2:setPosition(var_31_0, var_31_1)
			self._gridTxt:addChild(var_31_2)
		end
	end
end

function FurnitureRoomGird:_initDebugGridZL()
	for iter_32_0 = 0, self._MAP_GRID_MAXY - 1 do
		for iter_32_1 = 0, self._MAP_GRID_MAXZ - 1 do
			local var_32_0, var_32_1 = self:changeCoordToPixel(var_0_3.LEFT_WALL, iter_32_0, iter_32_1)

			self._gridLine:drawPoly(self:_getGridCellPolyZL(var_32_0, var_32_1), 4, true, var_0_2.DEBUG_GRID_COLORF)
		end
	end
end

function FurnitureRoomGird:_getGridCellPolyZL(arg_33_1, arg_33_2)
	local var_33_0 = {
		cc.p(-(self._MAP_TILE_HW / 2), -self._MAP_TILE_HH - self._TILE_OFF_Z),
		cc.p(-(self._MAP_TILE_HW / 2), self._MAP_TILE_Z_LEN - self._MAP_TILE_HH - self._TILE_OFF_Z),
		cc.p(self._MAP_TILE_HW / 2, self._MAP_TILE_Z_LEN - self._TILE_OFF_Z),
		cc.p(self._MAP_TILE_HW / 2, 0 - self._TILE_OFF_Z)
	}

	for iter_33_0, iter_33_1 in pairs(var_33_0) do
		iter_33_1.x = iter_33_1.x + arg_33_1
		iter_33_1.y = iter_33_1.y + arg_33_2
	end

	return var_33_0
end

function FurnitureRoomGird:_initDebugGridTextZL()
	for iter_34_0 = 0, self._MAP_GRID_MAXY - 1 do
		for iter_34_1 = 0, self._MAP_GRID_MAXZ - 1 do
			local var_34_0, var_34_1 = self:coordToPixelZL(iter_34_0, iter_34_1)
			local var_34_2 = ccui.Text:create(iter_34_0 .. "," .. iter_34_1, "", 16)

			var_34_2:setTextColor(var_0_1)
			var_34_2:setPosition(var_34_0, var_34_1)
			self._gridTxt:addChild(var_34_2)
		end
	end
end

function FurnitureRoomGird:onCoverTouchBegan(arg_35_1, arg_35_2)
	local var_35_0 = self:convertToNodeSpace((arg_35_1:getLocation()))
	local var_35_1, var_35_2, var_35_3 = self:changePixelToCoord(var_35_0.x, var_35_0.y)

	return true
end

return FurnitureRoomGird
