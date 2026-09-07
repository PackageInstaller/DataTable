local CombatLoadMediator = class("CombatLoadMediator", import("..base.ContextMediator"))

CombatLoadMediator.FINISH = "CombatLoadMediator:FINISH"

function CombatLoadMediator:register()
	self:bind(CombatLoadMediator.FINISH, function(arg_2_0, arg_2_1)
		self.contextData.loadObs = arg_2_1
		self.contextData.prePause = self._prePauseBattle

		self:sendNotification(GAME.CHANGE_SCENE, SCENE.BATTLE, self.contextData)

		return
	end)

	return
end

function CombatLoadMediator:remove()
	return
end

function CombatLoadMediator:listNotificationInterests()
	return {
		GAME.PAUSE_BATTLE,
		GAME.STOP_BATTLE_LOADING
	}
end

function CombatLoadMediator:handleNotification(arg_5_1)
	local var_5_0 = arg_5_1:getName()
	local var_5_1 = arg_5_1:getBody()

	if var_5_0 == GAME.PAUSE_BATTLE then
		self._prePauseBattle = true
	elseif var_5_0 == GAME.STOP_BATTLE_LOADING then
		ys.Battle.BattleResourceManager.GetInstance():Clear()
	end

	return
end

return CombatLoadMediator
