local AllianceTrialMapConst = require("app.view.module.allianceTrial.const.AllianceTrialMapConst")
local AllianceTrialGameTouch = class("AllianceTrialGameTouch", require("app.core.ksmap.touch.MapTouch"))

function AllianceTrialGameTouch:ctor(arg_1_1)
	AllianceTrialGameTouch.super.ctor(self, arg_1_1)

	self._lastOffGL = nil
end

function AllianceTrialGameTouch:getMapWorld()
	return self._ownerWorld
end

function AllianceTrialGameTouch:onMatchBegan(arg_3_1)
	if arg_3_1 then
		self._beginGL = arg_3_1:getLocation()

		self:getMapWorld():startInertiaWorld()

		return true
	end
end

function AllianceTrialGameTouch:onMatchMoved(arg_4_1)
	self._lastGL = arg_4_1:getLocation()

	local var_4_0 = arg_4_1:getDelta()

	self._lastOffGL = var_4_0

	self:getMapWorld():doDragWorld(cc.p(var_4_0.x * AllianceTrialMapConst.DRAG_RADIO, var_4_0.y * AllianceTrialMapConst.DRAG_RADIO))
end

function AllianceTrialGameTouch:onMatchEnded(arg_5_1)
	if self._lastOffGL == nil then
		return
	end

	local var_5_0 = self._lastOffGL

	self._lastOffGL = nil

	local var_5_1 = math.sqrt(var_5_0.x * var_5_0.x + var_5_0.y * var_5_0.y)

	if var_5_1 < 5 then
		return
	end

	var_5_0.x = var_5_0.x / var_5_1
	var_5_0.y = var_5_0.y / var_5_1

	self:getMapWorld():startInertiaWorld(var_5_0, var_5_1)
end

function AllianceTrialGameTouch:onMatchClicked(arg_6_1)
	self:getMapWorld():onSingleClick((arg_6_1:getLocation()))
end

return AllianceTrialGameTouch
