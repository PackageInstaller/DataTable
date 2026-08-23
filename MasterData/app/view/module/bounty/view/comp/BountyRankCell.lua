local BountyRankCell = class("BountyRankCell", require("app.fairyGUI.bounty.UI_BountyRankCell"))

function BountyRankCell:ctor()
	self.getSharedTrans(self, "enter_left", "CommonLongCellList", self)
end

function BountyRankCell:updateCell(arg_2_1, arg_2_2)
	self.m_hasBgController:setSelectedIndex(arg_2_2 % 2)
	self.m_scoreText:setText(arg_2_1.score)
	self.m_rankTxt:updateRankIndex({
		rank = arg_2_2
	})

	local var_2_0 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.GUILD, arg_2_1.guild_id)

	if var_2_0 then
		self.m_serverTxt:setText((g.core.platform.ServerListProxy:getServerById(var_2_0.sid) or {
			name = ""
		}).name)
		self.m_guildTxt:setText(var_2_0.name)
	else
		self.m_serverTxt:setText(g.core.lang:get(422047))
		self.m_guildTxt:setText(g.core.lang:get(422047))
	end
end

return BountyRankCell
