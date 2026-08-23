local GveBossGuildRankCell = class("GveBossGuildRankCell", require("app.fairyGUI.gve.UI_GveBossGuildRankCell"))

function GveBossGuildRankCell:updateBossGuildRank(arg_1_1, arg_1_2)
	self.m_indexComp:updateRankIndex({
		rank = arg_1_2
	})
	self.m_passTimeTxt:setText(arg_1_1.first)

	local var_1_0 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.ALLIANCE, arg_1_1.id)

	if not var_1_0 then
		self.m_hasGuildController:setSelectedIndex(1)
	else
		self.m_hasGuildController:setSelectedIndex(0)
		self.m_teamIconLoader:setURL(g.core.common.Path:getAllianceFlag128(var_1_0.flag or 5))
		self.m_teamNameTxt:setText(var_1_0.name)
		self.m_serverNameTxt1:setText("")

		local var_1_1 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, var_1_0.leader_id)

		if var_1_1 then
			self.m_leaderIcon:updateAsUser(var_1_1)
			self.m_leaderNameTxt:setText(var_1_1.name)
			self.m_serverNameTxt:setText(var_1_1.server_name)
		end
	end
end

return GveBossGuildRankCell
