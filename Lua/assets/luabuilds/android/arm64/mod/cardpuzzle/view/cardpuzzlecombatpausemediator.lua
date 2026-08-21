local var_0_0 = class("CardPuzzleCombatPauseMediator", ContextMediator)

var_0_0.QUIT_COMBAT = "QUIT_COMBAT"
var_0_0.RESUME_COMBAT = "RESUME_COMBAT"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.QUIT_COMBAT, function(arg_2_0, arg_2_1)
		arg_1_0:sendNotification(GAME.QUIT_BATTLE)

		return
	end)
	arg_1_0:bind(var_0_0.RESUME_COMBAT, function(arg_3_0, arg_3_1)
		arg_1_0:sendNotification(GAME.RESUME_BATTLE)

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_4_0)
	return {}
end

function var_0_0.remove(arg_5_0)
	return
end

function var_0_0.onBackPressed(arg_6_0, arg_6_1)
	arg_6_0:sendNotification(GAME.RESUME_BATTLE)
	var_0_0.super.onBackPressed(arg_6_0, arg_6_1)

	return
end

return var_0_0
