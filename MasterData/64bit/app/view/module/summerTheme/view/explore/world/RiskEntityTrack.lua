local RiskMapConst = require("app.view.module.summerTheme.view.explore.world.RiskMapConst")
local RiskEntityTrack = class("RiskEntityTrack", (import(".RiskEntity")))

function RiskEntityTrack:ctor(arg_1_1, arg_1_2, arg_1_3)
	RiskEntityTrack.super.ctor(self, arg_1_1, arg_1_2, arg_1_3)

	self._trackId = arg_1_2.param_1
	self._direction = arg_1_2.param_2
end

function RiskEntityTrack:isHoldCell()
	return self:isActivation()
end

function RiskEntityTrack:getTrackID()
	return self._trackId
end

function RiskEntityTrack:getDirection()
	return self._direction
end

function RiskEntityTrack:doCheckCanUse()
	return true
end

function RiskEntityTrack:_refreshStatusView()
	if self:getCurState() <= 0 then
		return
	end

	if self._visualIns and self._visualIns.playIdleAnim then
		self._visualIns:playIdleAnim()
	end
end

function RiskEntityTrack:_doTriggerUsed()
	if self._visualIns and self._visualIns.playUseAnim then
		self._visualIns:playUseAnim(RiskMapConst.SPECIAL_ITEM.TRACK)
	end
end

return RiskEntityTrack
