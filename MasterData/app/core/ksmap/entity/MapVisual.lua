local KsMath = require("app.core.utils.KsMath")
local MapConst = import("..MapConst")
local MapVisual = class("MapVisual", function()
	return cc.Node:create()
end)

function MapVisual:ctor(arg_2_1, arg_2_2, arg_2_3)
	self._elemType = nil
	self._resID = arg_2_1
	self._basePath = nil
	self._realVisual = nil
	self._hitRect = nil
	self._curZIndex = 0
	self._innerScale = 1
	self._innerDir = 1
	self._innerFlip = 1
	self._attackLayName = arg_2_3
	self._bindID = arg_2_2

	self:initVisual()

	if MapConst.DEBUG_GRID then
		self:_createDebugNode()
	end
end

function MapVisual:initVisual()
	self._hitRect = cc.rect(-1, -1, 2, 2)

	self:_doInitData()

	self._realVisual = self:_doCreateView()

	self:addChild(self._realVisual)
	self:_doInitBillboard()
end

function MapVisual:rebuildModel()
	return
end

function MapVisual:getVisual()
	return self._realVisual
end

function MapVisual:setPosBothZ(arg_6_1, arg_6_2)
	if not arg_6_2 then
		self:setPosition(arg_6_1)
	end

	local var_6_0 = KsMath.countPixZOrder(arg_6_1)

	if var_6_0 == self._curZIndex then
		return
	end

	self._curZIndex = var_6_0

	self:setLocalZOrder(self._curZIndex)
end

function MapVisual:setInnerFlip(arg_7_1)
	local var_7_0 = arg_7_1 and -1 or 1

	if self._innerFlip == (arg_7_1 and -1 or 1) then
		return
	end

	self._innerFlip = var_7_0

	self._realVisual:setScaleX(self:_getInnerScaleX())
end

function MapVisual:setInnerScale(arg_8_1)
	if self._innerScale == arg_8_1 then
		return
	end

	self._innerScale = arg_8_1

	self._realVisual:setScaleX(self:_getInnerScaleX())
	self._realVisual:setScaleY(self._innerScale)
end

function MapVisual:setInnerDir(arg_9_1)
	if self._innerDir == arg_9_1 then
		return
	end

	self._innerDir = arg_9_1

	self._realVisual:setScaleX(self:_getInnerScaleX())
end

function MapVisual:setDescName(arg_10_1)
	return
end

function MapVisual:setSignIcon(arg_11_1)
	return
end

function MapVisual:realRangeCheck(arg_12_1)
	local var_12_0, var_12_1 = self:getPosition()

	if var_12_0 + self._hitRect.x > arg_12_1.x or var_12_0 + self._hitRect.x + self._hitRect.width < arg_12_1.x or var_12_1 + self._hitRect.y > arg_12_1.y or var_12_1 + self._hitRect.y + self._hitRect.height < arg_12_1.y then
		return false
	end

	return true
end

function MapVisual:_doInitData()
	return
end

function MapVisual:_doCreateView()
	return cc.Node:create()
end

function MapVisual:_doInitBillboard()
	return
end

function MapVisual:_getInnerScaleX()
	return self._innerScale * self._innerDir * self._innerFlip
end

function MapVisual:_createDebugNode()
	if self.__debugNode == nil then
		self.__debugNode = cc.DrawNode:create()

		self:addChild(self.__debugNode)
	end

	self.__debugNode:clear()

	local var_17_0

	if MapConst.DEBUG_EDIT then
		var_17_0 = {
			cc.p(-1, -1),
			cc.p(-1, 1),
			cc.p(1, 1),
			cc.p(1, -1)
		}

		self.__debugNode:drawPoly(var_17_0, 4, true, cc.c4f(0.99, 0, 0, 1))

		var_17_0 = {
			cc.p(-2, -2),
			cc.p(-2, 2),
			cc.p(2, 2),
			cc.p(2, -2)
		}
	else
		var_17_0 = {
			cc.p(self._hitRect.x, self._hitRect.y),
			cc.p(self._hitRect.x, self._hitRect.y + self._hitRect.height),
			cc.p(self._hitRect.x + self._hitRect.width, self._hitRect.y + self._hitRect.height),
			cc.p(self._hitRect.x + self._hitRect.width, self._hitRect.y)
		}
	end

	self.__debugNode:drawPoly(var_17_0, 4, true, cc.c4f(0, 0.99, 0, 1))
end

function MapVisual:setAttackLayerName(arg_18_1)
	return
end

function MapVisual:isMapAwardBox()
	if self._attackLayName ~= MapConst.MAP_FLOOR then
		if (self._bindID or 0) > 0 then
			if self:_isMapAwardBoxResource() then
				return true
			end
		end
	end

	return false
end

function MapVisual:_isMapAwardBoxResource()
	for iter_20_0, iter_20_1 in ipairs(MapConst.MAP_FLOOR_AWARD_BOX_NAME) do
		if self._resID == iter_20_1 then
			return true
		end
	end

	return false
end

function MapVisual:getIsOpen()
	return
end

function MapVisual:setOpenState(arg_22_1)
	return
end

function MapVisual:playAnim(arg_23_1, arg_23_2)
	return
end

function MapVisual:_doUpdateRoleSkin(arg_24_1)
	return
end

return MapVisual
