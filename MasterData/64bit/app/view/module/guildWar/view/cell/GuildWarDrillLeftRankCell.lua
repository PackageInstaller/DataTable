local var_0_0 = g.core.model.User.guildWarData
local GuildWarDrillLeftRankCell = class("GuildWarDrillLeftRankCell", require("app.fairyGUI.guildWar.UI_GuildWarDrillLeftRankCell"))

function GuildWarDrillLeftRankCell:ctor()
	self.getSharedTrans(self, "enter_left", "CommonLongCellList", self)
end

function GuildWarDrillLeftRankCell:updateCell(arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.GUILD, arg_2_1.guildId)

	if var_2_0 then
		self.m_serverNameText:setText(var_2_0.server_name or "")
		self.m_guildNameText:setText(var_2_0.name or "")
	else
		self.m_serverNameText:setText("")
		self.m_guildNameText:setText("")
	end

	self.m_scoreText:setText(arg_2_1.score or 0)

	local var_2_2

	if arg_2_2 then
		var_2_2 = arg_2_2 + 1 or 0
	end

	local var_2_3 = tostring(var_2_2)

	self.m_rankText:setText((var_2_2 < 10 or nil) and "0" .. var_2_2)
	self.m_groupStateController:setSelectedIndex(var_0_0:getDrillRankGroup(var_2_2) - 1)
	self.m_isDrillStateController:setSelectedIndex(arg_2_3 and 1 or 0)
end

return GuildWarDrillLeftRankCell
