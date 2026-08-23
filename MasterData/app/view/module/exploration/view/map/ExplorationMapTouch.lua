local ExplorationConst = require("app.view.module.exploration.const.ExplorationConst")
local ExplorationMapTouch = class("ExplorationMapTouch")

function ExplorationMapTouch:ctor(arg_1_1)
	self._ownerWorld = arg_1_1
	self._beginGL = nil
	self._lastGL = nil
	self._lastOffGL = nil
end

function ExplorationMapTouch:getMapWorld()
	return self._ownerWorld
end

function ExplorationMapTouch:onMatchBegan(arg_3_1)
	self._beginGL = arg_3_1:getLocation()

	if not arg_3_1 then
		return false
	end

	self._beginGL = arg_3_1:getLocation()

	return true
end

function ExplorationMapTouch:onMatchMoved(arg_4_1)
	self._lastGL = arg_4_1:getLocation()

	local var_4_0 = arg_4_1:getDelta()

	self._lastOffGL = var_4_0

	self:getMapWorld():doDragWorld(cc.p(var_4_0.x * ExplorationConst.MAP_DRAG_RATIO, var_4_0.y * ExplorationConst.MAP_DRAG_RATIO))
end

function ExplorationMapTouch:onMatchEnded(arg_5_1)
	local var_5_0, var_5_1 = self:_checkClick()

	if var_5_0 then
		self:getMapWorld():mapMoveEnd()

		return
	end

	local var_5_2 = cc.p(self._lastOffGL.x / var_5_1, self._lastOffGL.y / var_5_1)

	self._lastOffGL = nil
end

function ExplorationMapTouch:onMatchClicked(arg_6_1)
	self:getMapWorld():onSingleClick((arg_6_1:getLocation()))
end

function ExplorationMapTouch:_checkClick()
	if not self._lastOffGL then
		return true
	end

	local var_7_0 = self._lastOffGL.x
	local var_7_1 = math.sqrt(var_7_0 * var_7_0 + self._lastOffGL.y * self._lastOffGL.y)

	return var_7_1 < 5, var_7_1
end

return ExplorationMapTouch
