local var_0_0 = g.core.model.User.releaseActivityData
local ReleaseActivityTimeComp = class("ReleaseActivityTimeComp", require("app.fairyGUI.release.UI_ReleaseActivityTimeComp"))

function ReleaseActivityTimeComp:ctor()
	self._schedule = nil
end

function ReleaseActivityTimeComp:updateTime()
	self:_onUpdateCountDown()

	self._schedule = self._schedule or self:newSchedule(handler(self, self._onUpdateCountDown), 10)
end

function ReleaseActivityTimeComp:_onUpdateCountDown()
	self.m_activityTimeTxt:setText(g.core.common.ServerTime:getLeftDHMFormat((var_0_0:getActEndTime())))
end

function ReleaseActivityTimeComp:onUnload()
	self:cancelAllSchedule()
end

return ReleaseActivityTimeComp
