local var_0_0 = g.core.const.ConstMgr.PubgConst
local Pubg2MapTouch = class("Pubg2MapTouch", require("app.core.ksmap.touch.MapTouch"))

function Pubg2MapTouch:ctor(arg_1_1)
	Pubg2MapTouch.super.ctor(self, arg_1_1)

	self._lastOffGL = nil
end

function Pubg2MapTouch:onMatchBegan(arg_2_1)
	if not arg_2_1 then
		return false
	end

	self._beginGL = arg_2_1:getLocation()

	self:getMapWorld():startInertiaWorld()

	return true
end

function Pubg2MapTouch:getMapWorld()
	return self._ownerWorld
end

function Pubg2MapTouch:onMatchMoved(arg_4_1)
	self._lastGL = arg_4_1:getLocation()

	local var_4_0 = arg_4_1:getDelta()

	self._lastOffGL = var_4_0

	self:getMapWorld():doDragWorld(cc.p(var_4_0.x * var_0_0.map.MAP_DRAG_RADIO, var_4_0.y * var_0_0.map.MAP_DRAG_RADIO))
end

function Pubg2MapTouch:onMatchEnded(arg_5_1)
	if self._lastOffGL == nil then
		return
	end

	local var_5_0 = self._lastOffGL

	self._lastOffGL = nil

	local var_5_1 = math.sqrt(var_5_0.x * var_5_0.x + var_5_0.y * var_5_0.y)

	if var_5_1 < 5 then
		self:getMapWorld():mapMoveEnd()

		return
	end

	var_5_0.x = var_5_0.x / var_5_1
	var_5_0.y = var_5_0.y / var_5_1

	self:getMapWorld():startInertiaWorld(var_5_0, var_5_1)
end

function Pubg2MapTouch:onMatchClicked(arg_6_1)
	self:getMapWorld():onSingleClick((arg_6_1:getLocation()))
end

return Pubg2MapTouch
