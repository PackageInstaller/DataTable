local ExpeditionGameMediator = class("ExpeditionGameMediator", import(".MiniHubMediator"))

function ExpeditionGameMediator:listNotificationInterests()
	local var_1_0 = {
		ActivityProxy.ACTIVITY_UPDATED,
		ActivityProxy.ACTIVITY_SHOW_AWARDS,
		GAME.BEGIN_STAGE_DONE
	}

	table.insertto(var_1_0, ExpeditionGameMediator.super.listNotificationInterests(self))

	return var_1_0
end

function ExpeditionGameMediator:handleNotification(arg_2_1)
	ExpeditionGameMediator.super.handleNotification(self, arg_2_1)

	local var_2_0 = arg_2_1:getName()
	local var_2_1 = arg_2_1:getBody()

	if var_2_0 == ActivityProxy.ACTIVITY_UPDATED then
		self.viewComponent:activityUpdate()
	elseif var_2_0 == ActivityProxy.ACTIVITY_SHOW_AWARDS then
		self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_2_1.awards, var_2_1.callback)
	elseif var_2_0 == GAME.BEGIN_STAGE_DONE then
		self:sendNotification(GAME.GO_SCENE, SCENE.COMBATLOAD, var_2_1)
	end

	return
end

return ExpeditionGameMediator
