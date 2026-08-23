local GuildDungeonRankCell = class("GuildDungeonRankCell", require("app.fairyGUI.guildDungeon.UI_GuildDungeonRankCell"))

function GuildDungeonRankCell:updateCell(arg_1_1)
	local var_1_0, var_1_1

	if arg_1_1 then
		var_1_0 = arg_1_1.rank or 1

		if arg_1_1 then
			var_1_1 = arg_1_1.data or {}
		end
	end

	self.m_haveBgController:setSelectedIndex(var_1_0 % 2)

	if var_1_0 <= 3 then
		self.m_numController:setSelectedIndex(var_1_0)
	else
		self.m_numController:setSelectedIndex(0)
		self.m_numTxt:setText(var_1_0)
	end

	local var_1_2 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.GUILD, var_1_1.id)

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
		self.m_powerTxt:setText(var_1_2.fight_value)
		self.m_dmgTxt:setText(var_1_2.total_damage or 0)
	else
		self.m_headComp:setVisible(false)
		self.m_nameTxt:setText("")
		self.m_levelTxt:setText("")
		self.m_powerTxt:setText("")
		self.m_dmgTxt:setText("")
	end
end

return GuildDungeonRankCell
