local ChallengePassedCombatLoadMediator = class("ChallengePassedCombatLoadMediator", import("..base.ContextMediator"))

ChallengePassedCombatLoadMediator.FINISH = "ChallengePassedCombatLoadMediator:FINISH"

function ChallengePassedCombatLoadMediator:register()
	self:bind(ChallengePassedCombatLoadMediator.FINISH, function(arg_2_0, arg_2_1)
		self.contextData.loadObs = arg_2_1
		self.contextData.prePause = self._prePauseBattle

		self:sendNotification(GAME.CHANGE_SCENE, SCENE.BATTLE, self.contextData)

		return
	end)

	return
end

function ChallengePassedCombatLoadMediator:listNotificationInterests()
	return {
		GAME.PAUSE_BATTLE,
		GAME.STOP_BATTLE_LOADING
	}
end

function ChallengePassedCombatLoadMediator:handleNotification(arg_4_1)
	local var_4_0 = arg_4_1:getName()
	local var_4_1 = arg_4_1:getBody()

	if var_4_0 == GAME.PAUSE_BATTLE then
		self._prePauseBattle = true
	elseif var_4_0 == GAME.STOP_BATTLE_LOADING then
		ys.Battle.BattleResourceManager.GetInstance():Clear()
	end

	return
end

return ChallengePassedCombatLoadMediator
