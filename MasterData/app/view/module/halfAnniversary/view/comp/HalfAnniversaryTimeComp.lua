local var_0_0 = g.core.common.ServerTime
local var_0_1 = g.core.model.User.halfAnniversaryData
local HalfAnniversaryTimeComp = class("HalfAnniversaryTimeComp", require("app.fairyGUI.halfAnniversary.UI_HalfAnniversaryTimeComp"))

function HalfAnniversaryTimeComp:updateActivityTime()
	local var_1_0 = var_0_0:getDateObject((var_0_1:getActivityStartTime()))
	local var_1_1 = var_0_0:getDateObject((var_0_1:getActivityEndTime()))

	self.m_startMonthTxt:setText(var_1_0.month)
	self.m_startDayTxt:setText(g.core.lang:get(408204, {
		num = g.core.utils.Number.getFormatNum(2, var_1_0.day)
	}))
	self.m_endMonthTxt:setText(var_1_1.month)
	self.m_endDayTxt:setText(g.core.lang:get(408204, {
		num = g.core.utils.Number.getFormatNum(2, var_1_1.day)
	}))
end

return HalfAnniversaryTimeComp
