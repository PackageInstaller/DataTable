local GveSeasonRankCell = class("GveSeasonRankCell", require("app.fairyGUI.gve.UI_GveSeasonRankCell"))

function GveSeasonRankCell:ctor()
	self.getSharedTrans(self, "enter_left", "CommonLongCellList", self)
end

function GveSeasonRankCell:updateSeasonRankCell(arg_2_1, arg_2_2)
	self.m_indexComp:updateRankIndex({
		rank = arg_2_2
	})
	self.m_passTimeTxt:setText(arg_2_1.bossDamage)

	local var_2_0 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.ALLIANCE, arg_2_1.id)

	if not var_2_0 then
		self.m_hasGuildController:setSelectedIndex(1)
	else
		self.m_hasGuildController:setSelectedIndex(0)
		self.m_teamIconLoader:setURL(g.core.common.Path:getAllianceFlag128(var_2_0.flag or 5))
		self.m_teamNameTxt:setText(var_2_0.name)
		self.m_serverNameTxt1:setText("")

		local var_2_1 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, var_2_0.leader_id)

		if var_2_1 then
			self.m_leaderIcon:updateAsUser(var_2_1)
			self.m_leaderNameTxt:setText(var_2_1.name)
			self.m_serverNameTxt:setText(var_2_1.server_name)
		end
	end
end

return GveSeasonRankCell
