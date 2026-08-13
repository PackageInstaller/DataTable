class = var_0_10000

local var_0_0 = "CardPuzzleCombatPauseMediator"

ContextMediator = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002)

var_0_1.QUIT_COMBAT = "QUIT_COMBAT"
var_0_1.RESUME_COMBAT = "RESUME_COMBAT"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.QUIT_COMBAT, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10004

		var_2_1(var_2_0, var_2_10004.QUIT_BATTLE)

		return
	end)
	arg_1_0:bind(var_0_1.RESUME_COMBAT, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.sendNotification

		GAME = var_2_10004

		var_3_1(var_3_0, var_2_10004.RESUME_BATTLE)

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_4_0)
	return {}
end

function var_0_1.remove(arg_5_0)
	return
end

function var_0_1.onBackPressed(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0
	local var_6_1 = arg_6_0.sendNotification

	GAME = var_1_10004

	var_6_1(var_6_0, var_1_10004.RESUME_BATTLE)
	var_0_1.super.onBackPressed(arg_6_0, arg_6_1)

	return
end

return var_0_1
