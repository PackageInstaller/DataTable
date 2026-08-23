local DailyTaskAwardIcon = class("DailyTaskAwardIcon", require("app.fairyGUI.dailyTask.UI_DailyTaskAwardIcon"))

function DailyTaskAwardIcon:ctor(arg_1_1)
	return
end

function DailyTaskAwardIcon:updateIcon(arg_2_1, arg_2_2)
	self.m_baseIcon:updateIcon(arg_2_1)
	self.m_surpriseController:setSelectedIndex(arg_2_1.isDailyTaskTimeLimit and 1 or 0)
	self.m_isGetController:setSelectedIndex(arg_2_2 and 1 or 0)
end

return DailyTaskAwardIcon
