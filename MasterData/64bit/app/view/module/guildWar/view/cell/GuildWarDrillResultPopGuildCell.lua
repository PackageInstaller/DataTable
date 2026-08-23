local GuildWarDrillResultPopGuildCell = class("GuildWarDrillResultPopGuildCell", require("app.fairyGUI.guildWar.UI_GuildWarDrillResultPopGuildCell"))

function GuildWarDrillResultPopGuildCell:updateCell(arg_1_1)
	if not arg_1_1 then
		return
	end

	local var_1_0 = arg_1_1.rank or 0
	local var_1_1 = tostring(var_1_0)

	self.m_rankText:setText((var_1_0 < 10 or nil) and "0" .. var_1_0)
	self.m_scoreText:setText(arg_1_1.score or 0)

	local var_1_2 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.GUILD, arg_1_1.guildId)

	if var_1_2 then
		self.m_guildNameText:setText(var_1_2.name or "")
		self.m_serverNameText:setText(var_1_2.server_name or "")
	else
		self.m_guildNameText:setText("")
		self.m_serverNameText:setText("")
	end
end

return GuildWarDrillResultPopGuildCell
