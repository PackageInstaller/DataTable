class = var_0_10000

local var_0_0 = "ChallengePassedCombatLoadMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.ContextMediator"))

var_0_1.FINISH = "ChallengePassedCombatLoadMediator:FINISH"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.FINISH, function(arg_2_0, arg_2_1)
		arg_1_0.contextData.loadObs = arg_2_1
		arg_1_0.contextData.prePause = arg_1_0._prePauseBattle

		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10004

		local var_2_2 = var_2_10004.CHANGE_SCENE

		SCENE = var_2_10005

		var_2_1(var_2_0, var_2_2, var_2_10005.BATTLE, arg_1_0.contextData)

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_3_0)
	local var_3_0 = {}

	GAME = var_1_10002
	var_3_0[1] = var_1_10002.PAUSE_BATTLE
	GAME = var_2
	var_3_0[2] = var_2.STOP_BATTLE_LOADING

	return var_3_0
end

function var_0_1.handleNotification(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1:getName()
	local var_4_1 = arg_4_1
	local var_4_2 = arg_4_1.getBody(var_4_1)

	GAME = var_4_1

	if var_4_0 == var_4_1.PAUSE_BATTLE then
		arg_4_0._prePauseBattle = true
	else
		GAME = var_4

		if var_4_0 == var_4.STOP_BATTLE_LOADING then
			ys = var_4

			local var_4_3 = var_4.Battle.BattleResourceManager.GetInstance()

			var_4.Clear(var_4_3)
		end
	end

	return
end

return var_0_1
