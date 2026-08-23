local var_0_0 = g.core.model.User.retroData
local RetroActivityTimeComp = class("RetroActivityTimeComp", require("app.fairyGUI.retro.UI_RetroActivityTimeComp"))

function RetroActivityTimeComp:ctor()
	self._schedule = nil
end

function RetroActivityTimeComp:updateTime()
	self:_onUpdateCountDown()

	self._schedule = self._schedule or self:newSchedule(handler(self, self._onUpdateCountDown), 10)
end

function RetroActivityTimeComp:_onUpdateCountDown()
	self.m_activityTimeTxt:setText(g.core.common.ServerTime:getLeftDHMFormat((var_0_0:getActEndTime((var_0_0:getRetroActId())))))
end

function RetroActivityTimeComp:onUnload()
	self:cancelAllSchedule()
end

return RetroActivityTimeComp
