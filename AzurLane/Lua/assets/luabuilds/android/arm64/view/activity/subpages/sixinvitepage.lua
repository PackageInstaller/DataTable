local var_0_0 = class("SixInvitePage", import(".FifthInvitePage"))

function var_0_0.OnDataSetting(arg_1_0)
	arg_1_0.ultimate = LaunchBallActivityMgr.GotInvitationFlag(arg_1_0.activity.id) and 1 or 0
	arg_1_0.usedtime = LaunchBallActivityMgr.GetRoundCount(arg_1_0.activity.id)
	arg_1_0.maxtime = LaunchBallActivityMgr.GetRoundCountMax(arg_1_0.activity.id)

	return
end

function var_0_0.OnFirstFlush(arg_2_0)
	onButton(arg_2_0, arg_2_0.goBtn, function()
		pg.m02:sendNotification(GAME.GO_SCENE, SCENE.SIXTH_ANNIVERSARY_JP_DARK)

		return
	end, SFX_PANEL)
	setActive(arg_2_0.helpBtn, false)

	return
end

function var_0_0.CheckGet(arg_4_0)
	if arg_4_0.ultimate == 0 then
		if arg_4_0.maxtime > arg_4_0.usedtime then
			return
		end

		LaunchBallActivityMgr.GetInvitation(arg_4_0.activity.id)
	end

	return
end

return var_0_0
