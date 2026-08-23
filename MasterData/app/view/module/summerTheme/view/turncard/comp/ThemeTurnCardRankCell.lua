local ThemeTurnCardRankCell = class("ThemeTurnCardRankCell", require("app.fairyGUI.summerThemeGame.UI_ThemeTurnCardRankCell"))

function ThemeTurnCardRankCell:updateRankCell(arg_1_1, arg_1_2)
	self.m_scoreText:setText(arg_1_1.score)
	self.m_rankIndexComp:updateRankIndex({
		rank = arg_1_1.rank
	})

	local var_1_0 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, arg_1_1.id)

	if var_1_0 then
		self.m_userHeadComp:updateAsUser(var_1_0)
		self.m_userHeadComp:setVisible(true)
		self.m_nameText:setText(var_1_0.name)
		self.m_lvText:setText(g.core.lang:get(2052, {
			level = var_1_0.level
		}))

		if not var_1_0.guild_name or var_1_0.guild_name == "" then
			self.m_guildText:setText(g.core.lang:get(1012))
		else
			self.m_guildText:setText(var_1_0.guild_name)
		end
	else
		self.m_userHeadComp:setVisible(false)
		self.m_nameText:setText("")
		self.m_lvText:setText("")
		self.m_guildText:setText("")
	end
end

return ThemeTurnCardRankCell
