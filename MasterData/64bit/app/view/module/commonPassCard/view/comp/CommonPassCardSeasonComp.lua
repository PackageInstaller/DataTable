local var_0_0 = g.core.model.User.commonPassCardDataMgr
local CommonPassCardSeasonComp = class("CommonPassCardSeasonComp", require("app.fairyGUI.commonPassCard.UI_CommonPassCardSeasonComp"))

function CommonPassCardSeasonComp:ctor()
	self._endTime = 0
end

function CommonPassCardSeasonComp:onLoad()
	self:_startTimer()
end

function CommonPassCardSeasonComp:onUnload()
	self:_stopTimer()
end

function CommonPassCardSeasonComp:_startTimer()
	self._timer = self._timer or self:newSchedule(handler(self, self._updateTimer), 1)
end

function CommonPassCardSeasonComp:_stopTimer()
	if self._timer then
		self:cancelSchedule(self._timer)
	end

	self._timer = nil
end

function CommonPassCardSeasonComp:updateSeasonInfo(arg_6_1)
	self._actId = arg_6_1
	self._commonPassCardData = var_0_0:getPassCardData(self._actId)

	local var_6_0, var_6_1 = self._commonPassCardData:getActivityTime()

	self._endTime = var_6_1

	self:_updateTimer()
end

function CommonPassCardSeasonComp:_updateTimer()
	local var_7_0 = self._endTime - g.core.common.ServerTime:getTime()

	if var_7_0 > 0 then
		self.m_timeTxt:setText(g.core.common.ServerTime:secondToDHMString(var_7_0))
	else
		self.m_timeTxt:setText("")
	end
end

return CommonPassCardSeasonComp
