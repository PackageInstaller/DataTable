local BountyResultSeasonRankCell = class("BountyResultSeasonRankCell", require("app.fairyGUI.bounty.UI_BountyResultSeasonRankCell"))

function BountyResultSeasonRankCell:ctor()
	self.getSharedTrans(self, "enter_left", "CommonLongCellList", self)
end

function BountyResultSeasonRankCell:updateCell(arg_2_1, arg_2_2)
	local var_2_0 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.GUILD, arg_2_1.guild_id)

	if var_2_0 then
		self.m_hasGuildController:setSelectedIndex(0)
		self.m_rankIndexComp:updateRankIndex({
			rank = arg_2_2
		})
		self.m_guildIconLoader:setURL((g.core.common.Path:getGuildMidIconById(var_2_0.icon or 5)))
		self.m_guildNameTxt:setText(var_2_0.name)

		local var_2_1 = g.core.platform.ServerListProxy:getServerById(var_2_0.sid) or {
			name = ""
		}

		self.m_serverNameTxt:setText(g.core.lang:get(307523, {
			serverName = var_2_1.name
		}))
		self.m_isOurTeamController:setSelectedIndex(var_2_0.id == g.core.model.User.guildData:getGuildId() and 1 or 0)
	else
		self.m_hasGuildController:setSelectedIndex(1)
	end

	self.m_scoreTxt:setText(g.core.lang:get(422040, {
		score = arg_2_1.score
	}))
	self.m_useTimeTxt:setText(g.core.lang:get(422041, {
		name = arg_2_1.max_score_username
	}))
	self.m_topThreeController:setSelectedIndex(arg_2_2 > 3 and 0 or 1)
end

return BountyResultSeasonRankCell
