local DomainStageFirstAwardIcon = class("DomainStageFirstAwardIcon", require("app.fairyGUI.domainDungeon.UI_DomainStageFirstAwardIcon"))

function DomainStageFirstAwardIcon:updateFirstCell(arg_1_1, arg_1_2)
	self.m_iconComp:updateIcon(arg_1_1)
	self.m_stateController:setSelectedIndex(arg_1_2 and 1 or 0)
end

return DomainStageFirstAwardIcon
