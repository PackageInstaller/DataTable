local TeamBattleConst = require("app.view.module.teamBattle.const.TeamBattleConst")
local TeamBattleMapTeamComp = class("TeamBattleMapTeamComp", require("app.fairyGUI.teamBattle.UI_TeamBattleMapTeamComp"))

function TeamBattleMapTeamComp:ctor()
	self._curIndex = 0
end

function TeamBattleMapTeamComp:updateTeam()
	for iter_2_0 = 1, 3 do
		self[table.concat({
			"m_player",
			iter_2_0
		})]:updateComp()
	end

	for iter_2_1, iter_2_2 in pairs((g.core.model.User.teamBattleData:getMapData():getPlayerMap())) do
		self[table.concat({
			"m_player",
			(iter_2_2:getTeamPos())
		})]:updateComp(iter_2_2)
	end
end

return TeamBattleMapTeamComp
