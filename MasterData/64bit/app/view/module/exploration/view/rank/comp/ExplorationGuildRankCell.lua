local ExplorationGuildRankCell = class("ExplorationGuildRankCell", require("app.fairyGUI.exploration.UI_ExplorationGuildRankCell"))

function ExplorationGuildRankCell:updateCell(arg_1_1, arg_1_2)
	self.m_hasBgController:setSelectedIndex(arg_1_1 % 2)

	if not arg_1_2 then
		self.m_hasPlayerController:setSelectedIndex(0)

		return
	end

	self.m_damageTxt:setText(arg_1_2.score)

	local var_1_0 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.GUILD, arg_1_2.id)

	if var_1_0 then
		self.m_hasPlayerController:setSelectedIndex(1)
		self.m_rankTxt:updateRankIndex({
			rank = arg_1_1
		})
		self.m_guildHeadComp:updateInfo({
			clickShowGuild = false,
			style = 2,
			data = var_1_0
		})
		self.m_guildTxt:setText(var_1_0.name)
		self.m_lvTxt:setText(g.core.lang:get(2052, {
			level = var_1_0.level
		}))
		self.m_guildHeadComp:updateInfo({
			data = var_1_0
		})
		self.m_serverTxt:setText(var_1_0.server_name)
		self.m_nameTxt:setText(var_1_0.leader_name)
		self.m_userHeadComp:updateAsUser({
			avata_id = var_1_0.leader_avata_id,
			frame_id = var_1_0.leader_frame_id,
			base_id = var_1_0.leader_base_id
		})
	else
		self.m_hasPlayerController:setSelectedIndex(0)
	end
end

return ExplorationGuildRankCell
