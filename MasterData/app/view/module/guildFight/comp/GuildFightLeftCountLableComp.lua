local GuildFightLeftCountLableComp = class("GuildFightLeftCountLableComp", require("app.fairyGUI.guildFight.UI_GuildFightLeftCountLableComp"))

function GuildFightLeftCountLableComp:updateInfo(arg_1_1)
	if arg_1_1 then
		self:setTitle(arg_1_1)
		self.m_countLeftController:setSelectedIndex(arg_1_1 > 0 and 1 or 0)
	end
end

return GuildFightLeftCountLableComp
