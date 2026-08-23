local TeamBattleRankTeamUserIcon = class("TeamBattleRankTeamUserIcon", require("app.fairyGUI.teamBattle.UI_TeamBattleRankTeamUserIcon"))

function TeamBattleRankTeamUserIcon:updateUserIcon(arg_1_1)
	self.m_userNameTxt:setText(arg_1_1.name)
	self.m_userIcon:updateAsUser(arg_1_1)
	self.m_fightValueTxt:setText(arg_1_1.fight_value)
end

return TeamBattleRankTeamUserIcon
