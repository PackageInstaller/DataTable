local FogNightSeasonResultRankCell = class("FogNightSeasonResultRankCell", require("app.fairyGUI.fogNightmare.UI_FogNightSeasonResultRankCell"))

function FogNightSeasonResultRankCell:ctor()
	self.getSharedTrans(self, "enter_down", "CommonShortCellList", self)
end

function FogNightSeasonResultRankCell:updateCell(arg_2_1)
	if not arg_2_1 then
		return
	end

	self.m_rankText:setText(arg_2_1.rank or 0)
	self.m_stageText:setText(tostring(arg_2_1.score or 0))

	local var_2_0 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, arg_2_1.id)

	if var_2_0 then
		self.m_isMeController:setSelectedIndex(g.core.model.User:isSelfById(var_2_0.id) and 1 or 0)
		self.m_userNameText:setText(var_2_0.name or "")
		self.m_userIcon:updateAsUser(var_2_0)

		if (var_2_0.guild_id or 0) > 0 then
			self.m_hasGuildController:setSelectedIndex(1)
			self.m_guildNameText:setText(var_2_0.guild_name or "")
		else
			self.m_hasGuildController:setSelectedIndex(0)
		end

		self.m_userIcon:setVisible(true)
	else
		self.m_isMeController:setSelectedIndex(0)
		self.m_userNameText:setText("")
		self.m_guildNameText:setText("")
		self.m_userIcon:setVisible(false)
		self.m_hasGuildController:setSelectedIndex(0)
	end
end

return FogNightSeasonResultRankCell
