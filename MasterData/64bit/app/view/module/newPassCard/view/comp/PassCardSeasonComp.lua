local var_0_0 = g.core.model.User.gmPassCardData
local PassCardSeasonComp = class("PassCardSeasonComp", require("app.fairyGUI.newPassCard.UI_PassCardSeasonComp"))

function PassCardSeasonComp:ctor()
	self._endTime = 0
end

function PassCardSeasonComp:onLoad()
	self:_startTimer()
end

function PassCardSeasonComp:onUnload()
	self:_stopTimer()
end

function PassCardSeasonComp:_startTimer()
	self._timer = self._timer or self:newSchedule(handler(self, self._updateTimer), 1)
end

function PassCardSeasonComp:_stopTimer()
	if self._timer then
		self:cancelSchedule(self._timer)
	end

	self._timer = nil
end

function PassCardSeasonComp:updateSeasonInfo()
	self.m_seasonTxt:setText(var_0_0:getActivityCfg().name)

	local var_6_0, var_6_1 = var_0_0:getActivityTime()

	self._endTime = var_6_1

	self:_updateTimer()
end

function PassCardSeasonComp:_updateTimer()
	local var_7_0 = self._endTime - g.core.common.ServerTime:getTime()

	if var_7_0 > 0 then
		self.m_timeTxt:setText(g.core.common.ServerTime:secondToDHMString(var_7_0))
	else
		self.m_timeTxt:setText("")
	end
end

return PassCardSeasonComp
