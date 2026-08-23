local ExplorationLayerMiniRoomComp = class("ExplorationLayerMiniRoomComp", require("app.fairyGUI.exploration.UI_ExplorationLayerMiniRoomComp"))

function ExplorationLayerMiniRoomComp:ctor()
	self._moveRange = nil

	local var_1_0 = self.m_miniMapComp:getSize()
	local var_1_1 = self.m_miniMapComp:getScale()

	var_1_0.width = var_1_0.width * var_1_1.x
	var_1_0.height = var_1_0.height * var_1_1.y
	self._mapSize = var_1_0
	self._mapPos = self.m_miniMapComp:getPosition()

	self.m_miniMapComp:setRoomEffectEnable(false)
	self.m_miniMapComp:updateRoomComp()
	self.m_lineComp:updateRoomComp()
	self.m_topComp:updateRoomComp()
	self.m_miniMapComp:setRoomTouchEnable(false)
	self:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchBegin))
	self:addEventListener(fgui.UIEventType.TouchMove, handler(self, self._onTouchMove))
	self:addEventListener(fgui.UIEventType.TouchEnd, handler(self, self._onTouchEnd))
end

function ExplorationLayerMiniRoomComp:updateMiniComp(arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = cc.p(self._mapSize.width / (arg_2_2.width * arg_2_3.x), self._mapSize.height / (arg_2_2.height * arg_2_3.y))

	arg_2_1.x = arg_2_1.x * var_2_0.x / arg_2_3.x
	arg_2_1.y = arg_2_1.y * var_2_0.y / arg_2_3.y

	if g.core.model.User.explorationData:getMapData():getCurMapId() == 2 then
		arg_2_1.y = arg_2_1.y * 1.2
	end

	arg_2_1.x = -arg_2_1.x

	local var_2_1 = cc.pAdd(self._mapPos, arg_2_1)

	self.m_miniMapComp:updateRoomComp()
	self.m_lineComp:updateRoomComp()
	self.m_topComp:updateRoomComp()
	self.m_miniMapComp:setPosition(var_2_1)
	self.m_lineComp:setPosition(var_2_1)
	self.m_topComp:setPosition(var_2_1)

	local var_2_2 = self:getSize()
	local var_2_3 = cc.p(0, 0)

	var_2_3.x = var_2_2.width - self._mapSize.width
	var_2_3.y = var_2_2.height - self._mapSize.height
	self._moveRange = self.m_miniMapComp:getMoveRange()
	self._moveRange.x = self._moveRange.x + var_2_3.x
	self._moveRange.width = self._moveRange.width - var_2_3.x
	self._moveRange.y = self._moveRange.y + var_2_3.y
	self._moveRange.height = self._moveRange.height - var_2_3.y
end

function ExplorationLayerMiniRoomComp:_onTouchBegin(arg_3_1)
	arg_3_1:captureTouch()
end

function ExplorationLayerMiniRoomComp:_onTouchMove(arg_4_1)
	local var_4_0 = arg_4_1:getInput():getTouch():getDelta()

	var_4_0.y = -var_4_0.y

	local var_4_1 = cc.pAdd(self.m_miniMapComp:getPosition(), var_4_0)
	local KsMath = require("app.core.utils.KsMath")

	var_4_1.x = KsMath.rangeIn(var_4_1.x, self._moveRange.x, self._moveRange.x + self._moveRange.width)
	var_4_1.y = KsMath.rangeIn(var_4_1.y, self._moveRange.y, self._moveRange.y + self._moveRange.height)

	self.m_miniMapComp:setPosition(var_4_1)
	self.m_lineComp:setPosition(var_4_1)
	self.m_topComp:setPosition(var_4_1)
end

function ExplorationLayerMiniRoomComp:_onTouchEnd()
	return
end

return ExplorationLayerMiniRoomComp
