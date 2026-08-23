local var_0_0 = 1240 * g.core.const.ConstMgr.GveConst.STRATEGY_SCALE
local var_0_1 = 620 * g.core.const.ConstMgr.GveConst.STRATEGY_SCALE
local var_0_2 = 290
local GveStrategyCutComp = class("GveStrategyCutComp", require("app.fairyGUI.gve.UI_GveStrategyCutComp"))

function GveStrategyCutComp:ctor()
	self._P_HEIGHT = var_0_1 / var_0_2
	self._P_WIDTH = var_0_0 / var_0_2
end

function GveStrategyCutComp:coordToPixel(arg_2_1, arg_2_2)
	return {
		x = (arg_2_1 - arg_2_2) * (self._P_WIDTH / 2),
		y = -(arg_2_1 + arg_2_2) * (self._P_HEIGHT / 2)
	}
end

function GveStrategyCutComp:updateMapPos(arg_3_1)
	local var_3_0

	if not self._size then
		self._size = self:getSize()
		var_3_0 = self:coordToPixel(arg_3_1.x, arg_3_1.y)
	end

	self.m_mapComp:setPosition(self._size.width / 2 - var_3_0.x, self._size.height / 2 + var_3_0.y)
end

function GveStrategyCutComp:updateMapState()
	self.m_mapComp:updateMapState()
end

return GveStrategyCutComp
