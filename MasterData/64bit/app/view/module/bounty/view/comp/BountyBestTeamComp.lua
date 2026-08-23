local BountyBestTeamComp = class("BountyBestTeamComp", require("app.fairyGUI.bounty.UI_BountyBestTeamComp"))

function BountyBestTeamComp:updateBestTeamComp(arg_1_1)
	local var_1_0 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.GUILD, arg_1_1.guild_id)

	if var_1_0 then
		self.m_guildNameTxt:setText(var_1_0.name)
		self.m_guildIconLoader:setURL((g.core.common.Path:getGuildMidIconById(var_1_0.icon)))
	end

	self.m_userNameTxt:setText(arg_1_1.max_score_username)
	self.m_damageTxt:setText(arg_1_1.score)
end

return BountyBestTeamComp
