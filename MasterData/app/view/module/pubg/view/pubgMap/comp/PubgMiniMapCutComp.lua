local var_0_0 = 1072
local var_0_1 = 536
local var_0_2 = 60
local PubgMiniMapCutComp = class("PubgMiniMapCutComp", require("app.fairyGUI.pubg.UI_PubgMiniMapCutComp"))

function PubgMiniMapCutComp:ctor()
	self._P_HEIGHT = var_0_1 / var_0_2
	self._P_WIDTH = var_0_0 / var_0_2
end

function PubgMiniMapCutComp:coordToPixel(arg_2_1, arg_2_2)
	return {
		x = (arg_2_1 - arg_2_2) * (self._P_WIDTH / 2),
		y = -(arg_2_1 + arg_2_2) * (self._P_HEIGHT / 2)
	}
end

function PubgMiniMapCutComp:showInAirDropItem(arg_3_1, arg_3_2)
	self.m_mapComp:showInAirDropItem(arg_3_1, arg_3_2)
end

function PubgMiniMapCutComp:updateMapPos(arg_4_1, arg_4_2, arg_4_3)
	local var_4_0

	if not self._size then
		self._size = self:getSize()
		var_4_0 = self:coordToPixel(arg_4_1, arg_4_2)
	end

	self.m_mapComp:setPosition(self._size.width / 2 - var_4_0.x, self._size.height / 2 + var_4_0.y)
	self.m_mapComp:updateCurPositionRange(math.floor(arg_4_1), math.floor(arg_4_2), arg_4_3)
end

return PubgMiniMapCutComp
