local MysterMapConst = import(".MysterMapConst")
local MysteryGameTouch = class("MysteryGameTouch", require("app.core.ksmap.touch.MapTouch"))

function MysteryGameTouch:ctor(arg_1_1)
	MysteryGameTouch.super.ctor(self, arg_1_1)

	self._lastOffGL = nil
end

function MysteryGameTouch:onMatchBegan(arg_2_1)
	if arg_2_1 then
		self._beginGL = arg_2_1:getLocation()

		self:getMapWorld():startInertiaWorld()

		return true
	end
end

function MysteryGameTouch:onMatchMoved(arg_3_1)
	self._lastGL = arg_3_1:getLocation()

	local var_3_0 = arg_3_1:getDelta()

	self._lastOffGL = var_3_0

	self:getMapWorld():doDragWorld(cc.p(var_3_0.x * MysterMapConst.DRAG_RADIO, var_3_0.y * MysterMapConst.DRAG_RADIO))
end

function MysteryGameTouch:onMatchEnded(arg_4_1)
	if self._lastOffGL == nil then
		return
	end

	local var_4_0 = self._lastOffGL

	self._lastOffGL = nil

	local var_4_1 = math.sqrt(var_4_0.x * var_4_0.x + var_4_0.y * var_4_0.y)

	if var_4_1 < 5 then
		return
	end

	var_4_0.x = var_4_0.x / var_4_1
	var_4_0.y = var_4_0.y / var_4_1

	self:getMapWorld():startInertiaWorld(var_4_0, var_4_1)
end

function MysteryGameTouch:onMatchClicked(arg_5_1)
	self:getMapWorld():onSingleClick((arg_5_1:getLocation()))
end

return MysteryGameTouch
