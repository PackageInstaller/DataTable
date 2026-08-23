local OutpostMapWorld = require("app.view.module.outpost.view.stage.OutpostMapWorld")
local OutpostVirtualWorld = require("app.view.module.outpost.simulationWorld.OutpostVirtualWorld")
local GveMapComp = class("GveMapComp", require("app.fairyGUI.outpost.UI_OutpostMapComp"))

function GveMapComp:ctor()
	self._stage = nil

	self:_initTiledMap()
	self:_initRegisterUI()
end

function GveMapComp:_initRegisterUI()
	self:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchBegin))
	self:addEventListener(fgui.UIEventType.TouchMove, handler(self, self._onTouchMove))
	self:addEventListener(fgui.UIEventType.TouchEnd, handler(self, self._onTouchEnd))
	self:addClickListener(handler(self, self._onTouchClick))
end

function GveMapComp:_onTouchBegin(arg_3_1)
	arg_3_1:captureTouch()
	self._mapWorld:onCoverTouchBegan((arg_3_1:getInput():getTouch()))
end

function GveMapComp:_onTouchMove(arg_4_1)
	self._mapWorld:onCoverTouchMoved((arg_4_1:getInput():getTouch()))
end

function GveMapComp:_onTouchEnd(arg_5_1)
	self._mapWorld:onCoverTouchEnded((arg_5_1:getInput():getTouch()))
end

function GveMapComp:_onTouchClick(arg_6_1)
	arg_6_1:captureTouch()
	self._mapWorld:onCoverClicked((arg_6_1:getInput():getTouch()))
end

function GveMapComp:setStage(arg_7_1)
	self._stage = arg_7_1

	self.m_floorComp:setStage(arg_7_1)
end

function GveMapComp:onLoad()
	return
end

function GveMapComp:_initTiledMap()
	self._mapWorld = OutpostMapWorld.new(self, "outpost_map")

	self.m_tiledHolder:addNode(self._mapWorld)
end

function GveMapComp:getMapWorld()
	return self._mapWorld
end

function GveMapComp:showDropFinger(arg_11_1)
	self.m_floorComp:showDropFinger(arg_11_1)
end

function GveMapComp:playItemFlyEff(arg_12_1)
	self.m_floorComp:playItemFlyEff(arg_12_1)
end

function GveMapComp:moveToPoint(arg_13_1, arg_13_2)
	self._mapWorld:moveCell2SC({
		x = arg_13_1,
		y = arg_13_2
	})
	self:onMapMoveEnd()
end

function GveMapComp:updateViewEntityRender()
	self.m_floorComp:updateViewEntity()
end

function GveMapComp:showKnightDrop(arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	self.m_floorComp:showKnightDrop(arg_15_1, arg_15_2, arg_15_3, arg_15_4)
end

function GveMapComp:showKnightExp(arg_16_1)
	self.m_floorComp:showKnightExp(arg_16_1)
end

function GveMapComp:getScreenCenterPoint()
	local var_17_0 = self:getMapWorld():convertToNodeSpace({
		x = display.cx,
		y = display.cy
	})
	local var_17_1, var_17_2 = self:getMapWorld():getMapGround():pixelToCoord(var_17_0.x, var_17_0.y)

	return {
		x = var_17_1,
		y = var_17_2
	}
end

function GveMapComp:updateFloorCompPos(arg_18_1, arg_18_2)
	self.m_floorComp:setPosition(arg_18_1 + display.cx, arg_18_2 + display.cy)
end

function GveMapComp:onSingleClick(arg_19_1, arg_19_2)
	self:setTargetPosTiledId(cc.p(arg_19_1, arg_19_2))
end

function GveMapComp:onMapMoveEnd()
	return
end

function GveMapComp:getEntityObject(arg_21_1)
	return self.m_floorComp:getEntityObject(arg_21_1)
end

return GveMapComp
