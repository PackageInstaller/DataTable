local HomeInfoRemindBtnChooseComp = class("HomeInfoRemindBtnChooseComp", require("app.fairyGUI.home.UI_HomeInfoRemindBtnChooseComp"))

function HomeInfoRemindBtnChooseComp:setState(arg_1_1)
	self.m_chooseTypeController:setSelectedIndex(arg_1_1 - 1)
end

return HomeInfoRemindBtnChooseComp
