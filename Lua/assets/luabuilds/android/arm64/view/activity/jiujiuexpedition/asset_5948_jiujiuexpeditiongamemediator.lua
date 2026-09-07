local JiuJiuExpeditionGameMediator = class("JiuJiuExpeditionGameMediator", import("...base.ContextMediator"))

JiuJiuExpeditionGameMediator.OPEN_LAYER = "OPEN_LAYER"

function JiuJiuExpeditionGameMediator:register()
	self:bind(JiuJiuExpeditionGameMediator.OPEN_LAYER, function(arg_2_0, arg_2_1)
		self:addSubLayers(arg_2_1)

		return
	end)

	return
end

function JiuJiuExpeditionGameMediator:listNotificationInterests()
	local var_3_0 = {
		ActivityProxy.ACTIVITY_UPDATED,
		GAME.BEGIN_STAGE_DONE,
		ActivityProxy.ACTIVITY_SHOW_AWARDS
	}

	table.insertto(var_3_0, JiuJiuExpeditionGameMediator.super.listNotificationInterests(self))

	return var_3_0
end

function JiuJiuExpeditionGameMediator:handleNotification(arg_4_1)
	JiuJiuExpeditionGameMediator.super.handleNotification(self, arg_4_1)

	local var_4_0 = arg_4_1:getName()
	local var_4_1 = arg_4_1:getBody()

	if var_4_0 == ActivityProxy.ACTIVITY_UPDATED and var_4_1:getConfig("type") == ActivityConst.ACTIVITY_TYPE_EXPEDITION then
		self.viewComponent:activityUpdate()
	elseif var_4_0 == GAME.BEGIN_STAGE_DONE then
		self:sendNotification(GAME.GO_SCENE, SCENE.COMBATLOAD, var_4_1)
	elseif var_4_0 == ActivityProxy.ACTIVITY_SHOW_AWARDS then
		self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_4_1.awards, var_4_1.callback)
	end

	return
end

return JiuJiuExpeditionGameMediator
