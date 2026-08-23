local GuildBossGuildRankCell = class("GuildBossGuildRankCell", require("app.fairyGUI.guildBoss.UI_GuildBossGuildRankCell"))

function GuildBossGuildRankCell:updateCell(arg_1_1)
	local var_1_0, var_1_1

	if arg_1_1 then
		var_1_0 = arg_1_1.rank or 1

		if arg_1_1 then
			var_1_1 = arg_1_1.score or 0
		end
	end

	self.m_haveBgController:setSelectedIndex(var_1_0 % 2)
	self.m_scoreTxt:setText(var_1_1)

	if var_1_0 <= 3 then
		self.m_numController:setSelectedIndex(var_1_0)
	else
		self.m_numController:setSelectedIndex(0)
		self.m_numTxt:setText(var_1_0)
	end

	local var_1_2 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.GUILD, arg_1_1.id)

	if var_1_2 then
		self.m_headComp:updateInfo({
			clickShowGuild = true,
			style = 2,
			data = var_1_2
		})
		self.m_headComp:setVisible(true)
		self.m_nameTxt:setText(var_1_2.name)
		self.m_levelTxt:setText(g.core.lang:get(2052, {
			level = var_1_2.level
		}))
		self.m_personNumTxt:setText(var_1_2.boss_total_num)
	else
		self.m_headComp:setVisible(false)
		self.m_nameTxt:setText("")
		self.m_levelTxt:setText("")
		self.m_personNumTxt:setText("")
	end
end

return GuildBossGuildRankCell
