local MonopolyPtMediator = class("MonopolyPtMediator", import("view.base.ContextMediator"))

function MonopolyPtMediator:register()
	return
end

function MonopolyPtMediator:listNotificationInterests()
	return {
		ActivityProxy.ACTIVITY_UPDATED,
		ActivityProxy.ACTIVITY_ADDED,
		GAME.ACT_NEW_PT_DONE,
		GAME.BEGIN_STAGE_DONE
	}
end

function MonopolyPtMediator:handleNotification(arg_3_1)
	local var_3_0 = arg_3_1:getName()
	local var_3_1 = arg_3_1:getBody()
	local var_3_2 = arg_3_1:getType()

	if var_3_0 == ActivityProxy.ACTIVITY_UPDATED or var_3_0 == ActivityProxy.ACTIVITY_ADDED then
		self:updateGameUI(var_3_1)
	elseif var_3_0 == GAME.ACT_NEW_PT_DONE then
		self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_3_1.awards, var_3_1.callback)
	elseif var_3_0 == GAME.BEGIN_STAGE_DONE then
		self:sendNotification(GAME.GO_SCENE, SCENE.COMBATLOAD, var_3_1)
	end

	return
end

function MonopolyPtMediator:updateGameUI(arg_4_1)
	self.viewComponent:updataActivity(arg_4_1)

	return
end

function MonopolyPtMediator:remove()
	return
end

return MonopolyPtMediator
