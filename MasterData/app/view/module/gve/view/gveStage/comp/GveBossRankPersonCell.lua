local GveBossRankPersonCell = class("GveBossRankPersonCell", require("app.fairyGUI.gve.UI_GveBossRankPersonCell"))

function GveBossRankPersonCell:updateCell(arg_1_1, arg_1_2)
	self.m_indexRank:updateRankIndex({
		rank = arg_1_2
	})
	self.m_damageText:setText(arg_1_1.first)

	local var_1_0 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, arg_1_1.id)

	if not var_1_0 then
		self.m_snapShotStateController:setSelectedIndex(0)

		return
	end

	self.m_userIcon:updateAsUser(var_1_0)
	self.m_userNameText:setText(var_1_0.name)
	self.m_serverNameText:setText(var_1_0.server_name)
	self.m_guildNameText:setText((var_1_0.alliance_name ~= "" or nil) and (var_1_0.alliance_name or g.core.lang:get(302055)))
	self.m_snapShotStateController:setSelectedIndex(2)
end

return GveBossRankPersonCell
