local GveResultSeasonRankCell = class("GveResultSeasonRankCell", require("app.fairyGUI.gve.UI_GveResultSeasonRankCell"))

function GveResultSeasonRankCell:ctor()
	self.getSharedTrans(self, "enter_left", "CommonLongCellList", self)
end

function GveResultSeasonRankCell:updateCell(arg_2_1, arg_2_2)
	local var_2_0 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.ALLIANCE, arg_2_1.id)

	self.m_rankIndexComp:updateRankIndex({
		rank = arg_2_2
	})

	if var_2_0 then
		self.m_hasGuildController:setSelectedIndex(0)
		self.m_teamIconLoader:setURL((g.core.common.Path:getAllianceFlag128(var_2_0.flag or 5)))
		self.m_teamNameTxt:setText(var_2_0.name)

		local var_2_1 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, var_2_0.leader_id)

		if var_2_1 then
			self.m_leaderNameTxt:setText(g.core.lang:get(309204) .. var_2_1.name)
			self.m_serverNameTxt:setText("(" .. var_2_1.server_name .. ")")
		end

		self.m_isOurTeamController:setSelectedIndex(var_2_0.id == g.core.model.User:getAllianceId() and 1 or 0)
	else
		self.m_hasGuildController:setSelectedIndex(1)
	end

	self.m_useTimeTxt:setText(g.core.lang:get(309191) .. arg_2_1.bossDamage)
	self.m_topThreeController:setSelectedIndex(arg_2_2 > 3 and 0 or 1)
end

return GveResultSeasonRankCell
