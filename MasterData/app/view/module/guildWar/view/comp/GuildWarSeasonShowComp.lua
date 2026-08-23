local var_0_0 = g.core.common.Path
local GuildWarSeasonShowComp = class("GuildWarSeasonShowComp", require("app.fairyGUI.guildWar.UI_GuildWarSeasonShowComp"))

function GuildWarSeasonShowComp:updateComp(arg_1_1)
	local var_1_0 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.GUILD, arg_1_1.guildId)

	if var_1_0 then
		self.m_guildNameText:setText(var_1_0.name or "")
		self.m_scoreText:setText(arg_1_1.score or 0)
		self.m_serverNameText:setText(var_1_0.server_name or "")
		self.m_guildIcon:setURL((var_0_0:getGuildMidIconById(var_1_0.icon or 5)))
	end
end

return GuildWarSeasonShowComp
