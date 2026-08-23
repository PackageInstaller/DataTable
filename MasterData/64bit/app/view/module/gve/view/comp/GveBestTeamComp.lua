local var_0_3 = g.core.model.User.gveDataMgr
local GveResultSeasonRankCell = class("GveResultSeasonRankCell", require("app.fairyGUI.gve.UI_GveBestTeamComp"))

function GveResultSeasonRankCell:updateBestTeamComp()
	local var_1_0 = var_0_3:getRankWorldGuild()[1]

	if var_1_0 then
		self.m_damageTxt:setText(var_1_0.bossDamage)

		local var_1_1 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.ALLIANCE, var_1_0.id)

		if not var_1_1 then
			return
		end

		self.m_teamnNameTxt:setText(var_1_1.name)
		self.m_teamIconLoader:setURL((g.core.common.Path:getAllianceFlag128(var_1_1.flag or 5)))

		local var_1_2 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, var_1_1.leader_id)

		if var_1_2 then
			self.m_leaderNameTxt:setText(var_1_2.name)
		end
	end
end

return GveResultSeasonRankCell
