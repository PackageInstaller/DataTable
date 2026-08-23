local RedCliffClockComp = class("RedCliffClockComp", require("app.fairyGUI.redCliff.UI_RedCliffClockComp"))

function RedCliffClockComp:ctor()
	return
end

function RedCliffClockComp:updateClock(arg_2_1)
	self.m_blueClock:setFillAmount(arg_2_1)
	self.m_redClock:setFillAmount(arg_2_1)
end

return RedCliffClockComp
