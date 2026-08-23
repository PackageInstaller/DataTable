local GuildBossPersonRankCell = class("GuildBossPersonRankCell", require("app.fairyGUI.guildBoss.UI_GuildBossPersonRankCell"))

function GuildBossPersonRankCell:updateCell(arg_1_1)
	local var_1_0, var_1_1

	if arg_1_1 then
		var_1_0 = arg_1_1.rank or 1

		if arg_1_1 then
			var_1_1 = arg_1_1.score or 0
		end
	end

	local var_1_2 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, arg_1_1.id)

	if var_1_2 then
		self.m_headComp:updateAsUser({
			base_id = var_1_2.base_id,
			level = var_1_2.level,
			name = var_1_2.name,
			id = var_1_2.id
		})
		self.m_headComp:setVisible(true)
		self.m_nameTxt:setText(var_1_2.name)
		self.m_levelTxt:setText(g.core.lang:get(2052, {
			level = var_1_2.level
		}))
		self.m_fightValueTxt:setText(var_1_2.fight_value)
	else
		self.m_headComp:setVisible(false)
		self.m_nameTxt:setText("")
		self.m_levelTxt:setText("")
		self.m_fightValueTxt:setText("")
	end

	self.m_scoreTxt:setText(var_1_1)
	self.m_haveBgController:setSelectedIndex(var_1_0 % 2)

	if var_1_0 <= 3 then
		self.m_numController:setSelectedIndex(var_1_0)
	else
		self.m_numController:setSelectedIndex(0)
		self.m_numTxt:setText(var_1_0)
	end
end

return GuildBossPersonRankCell
