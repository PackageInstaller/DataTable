local GuildFightEntranceILableComp = class("GuildFightEntranceILableComp", require("app.fairyGUI.guildFight.UI_GuildFightEntranceILableComp"))

function GuildFightEntranceILableComp:updateInfo(arg_1_1)
	self:setTitle(g.core.lang:get(arg_1_1.nameId))
	self.m_progtext:setText(g.core.lang:get(109806, {
		num = arg_1_1.id
	}))
	self.m_valueText:setText((arg_1_1.playerList[#arg_1_1.playerList] or {}).fightValue or "")
	self.m_isFinishController:setSelectedIndex(arg_1_1.isAreaFinish and 1 or 0)
end

return GuildFightEntranceILableComp
