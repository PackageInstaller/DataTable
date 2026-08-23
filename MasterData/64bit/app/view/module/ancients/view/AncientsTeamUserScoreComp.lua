local AncientsTeamUserScoreComp = class("AncientsTeamUserScoreComp", require("app.fairyGUI.ancients.UI_AncientsTeamUserScoreComp"))

function AncientsTeamUserScoreComp:ctor()
	return
end

function AncientsTeamUserScoreComp:updateCell(arg_2_1)
	local var_2_0 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, arg_2_1.user_id)

	if var_2_0 then
		self.m_playerName:setText(var_2_0.name)
		self.m_playerScore:setText(arg_2_1.team_contribution)
	end
end

return AncientsTeamUserScoreComp
