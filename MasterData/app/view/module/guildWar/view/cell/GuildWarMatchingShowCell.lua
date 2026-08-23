local GuildWarMatchingShowCell = class("GuildWarMatchingShowCell", require("app.fairyGUI.guildWar.UI_GuildWarMatchingShowCell"))

function GuildWarMatchingShowCell:ctor()
	return
end

function GuildWarMatchingShowCell:update(arg_2_1)
	if not arg_2_1 then
		return
	end

	self.m_serverName:setText(arg_2_1.serverName or "")

	if tostring(arg_2_1.sid or 0) == tostring((g.core.platform.ServerListProxy:getCurServer() or {}).id) then
		self.m_isSelfController:setSelectedIndex(1)
	else
		self.m_isSelfController:setSelectedIndex(0)
	end
end

return GuildWarMatchingShowCell
