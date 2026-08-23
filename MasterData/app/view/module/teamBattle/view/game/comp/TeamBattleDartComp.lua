local TeamBattleDartComp = class("TeamBattleDartComp", require("app.fairyGUI.teamBattle.UI_TeamBattleDartComp"))

function TeamBattleDartComp:setState(arg_1_1)
	self.m_stateController:setSelectedIndex(arg_1_1)
end

return TeamBattleDartComp
