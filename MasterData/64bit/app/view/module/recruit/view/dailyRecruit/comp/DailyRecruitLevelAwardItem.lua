local DailyRecruitLevelAwardItem = class("DailyRecruitLevelAwardItem", require("app.fairyGUI.recruitDaily.UI_DailyRecruitLevelAwardItem"))

function DailyRecruitLevelAwardItem:updateAwardItem(arg_1_1, arg_1_2)
	self.m_iconComp:updateIcon(arg_1_1)
	self.m_showStateController:setSelectedIndex(arg_1_2 and 1 or 0)
end

return DailyRecruitLevelAwardItem
