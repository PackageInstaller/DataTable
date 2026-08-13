class = var_0_10000

local var_0_0 = "SixInvitePage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".FifthInvitePage"))

function var_0_1.OnDataSetting(arg_1_0)
	LaunchBallActivityMgr = var_1_10001
	arg_1_0.ultimate = var_1_10001.GotInvitationFlag(arg_1_0.activity.id) and 1 or 0
	LaunchBallActivityMgr = var_1
	arg_1_0.usedtime = var_1.GetRoundCount(arg_1_0.activity.id)
	LaunchBallActivityMgr = var_1
	arg_1_0.maxtime = var_1.GetRoundCountMax(arg_1_0.activity.id)

	return
end

function var_0_1.OnFirstFlush(arg_2_0)
	onButton = var_1_10001

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.goBtn

	local function var_2_2()
		pg = var_2_10000

		local var_3_0 = var_2_10000.m02
		local var_3_1 = var_0.sendNotification

		GAME = var_2_10003

		local var_3_2 = var_2_10003.GO_SCENE

		SCENE = var_2_10004

		var_3_1(var_3_0, var_3_2, var_2_10004.SIXTH_ANNIVERSARY_JP_DARK)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_2_0, var_2_1, var_2_2, var_1_10006)

	setActive = var_1_10001

	var_1_10001(arg_2_0.helpBtn, false)

	return
end

function var_0_1.CheckGet(arg_4_0)
	if arg_4_0.ultimate == 0 then
		if arg_4_0.maxtime > arg_4_0.usedtime then
			return
		end

		LaunchBallActivityMgr = var_1_10003

		var_1_10003.GetInvitation(arg_4_0.activity.id)
	end

	return
end

return var_0_1
