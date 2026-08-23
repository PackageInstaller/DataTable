local TeamBattleLordRankComp = class("TeamBattleLordRankComp", require("app.fairyGUI.teamBattle.UI_TeamBattleLordRankComp"))

function TeamBattleLordRankComp:updateKnight(arg_1_1)
	if not arg_1_1 then
		self:setVisible(false)

		return
	end

	self:setVisible(true)
	self.m_serverNameTxt:setText((g.core.platform.ServerListProxy:getServerById(arg_1_1.sid) or {
		name = ""
	}).name)
	self.m_playerNameTxt:setText(arg_1_1.name)
end

return TeamBattleLordRankComp
