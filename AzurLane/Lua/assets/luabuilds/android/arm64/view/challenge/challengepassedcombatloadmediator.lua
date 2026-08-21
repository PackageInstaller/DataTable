local var_0_0 = class("ChallengePassedCombatLoadMediator", import("..base.ContextMediator"))

var_0_0.FINISH = "ChallengePassedCombatLoadMediator:FINISH"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.FINISH, function(arg_2_0, arg_2_1)
		arg_1_0.contextData.loadObs = arg_2_1
		arg_1_0.contextData.prePause = arg_1_0._prePauseBattle

		arg_1_0:sendNotification(GAME.CHANGE_SCENE, SCENE.BATTLE, arg_1_0.contextData)

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_3_0)
	return {
		GAME.PAUSE_BATTLE,
		GAME.STOP_BATTLE_LOADING
	}
end

function var_0_0.handleNotification(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1:getName()
	local var_4_1 = arg_4_1:getBody()

	if var_4_0 == GAME.PAUSE_BATTLE then
		arg_4_0._prePauseBattle = true
	elseif var_4_0 == GAME.STOP_BATTLE_LOADING then
		ys.Battle.BattleResourceManager.GetInstance():Clear()
	end

	return
end

return var_0_0
