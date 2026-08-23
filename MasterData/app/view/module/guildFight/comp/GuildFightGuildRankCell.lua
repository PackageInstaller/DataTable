local GuildFightGuildRankCell = class("GuildFightGuildRankCell", require("app.fairyGUI.guildFight.UI_GuildFightGuildRankCell"))

function GuildFightGuildRankCell:ctor()
	return
end

function GuildFightGuildRankCell:updateCell(arg_2_1)
	local var_2_0 = arg_2_1.index or 0

	if var_2_0 % 2 == 0 then
		self.m_bg:setVisible(true)
	else
		self.m_bg:setVisible(false)
	end

	self.m_rankController:setSelectedIndex(0)

	if var_2_0 <= 3 then
		self.m_rankController:setSelectedIndex(var_2_0)
	else
		self.m_rankTxt:setText(var_2_0)
	end

	local var_2_1 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.GUILD, arg_2_1.data.id)

	if var_2_1 then
		self.m_guildIcon:updateInfo({
			clickShowGuild = true,
			style = 2,
			data = var_2_1
		})
		self.m_guildName:setText(var_2_1.name)
		self.m_serviceTxt:setText(var_2_1.server_name)
		self.m_scoreTxt:setText(arg_2_1.data.score)
		self.m_guildIcon:setVisible(true)
	else
		self.m_guildName:setText("")
		self.m_serviceTxt:setText("")
		self.m_guildIcon:setVisible(false)
	end
end

return GuildFightGuildRankCell
