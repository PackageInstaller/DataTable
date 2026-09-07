local AirForceOfDragonEmperyMediator = class("AirForceOfDragonEmperyMediator", import("view.base.ContextMediator"))

AirForceOfDragonEmperyMediator.ON_BATTLE = "AirForceOfDragonEmperyMediator ON_BATTLE"
AirForceOfDragonEmperyMediator.ON_ACTIVITY_OPREATION = "AirForceOfDragonEmperyMediator ON_ACTIVITY_OPREATION"

function AirForceOfDragonEmperyMediator:register()
	self:bind(AirForceOfDragonEmperyMediator.ON_BATTLE, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.BEGIN_STAGE, {
			system = SYSTEM_AIRFIGHT,
			stageId = arg_2_1
		})

		return
	end)
	self:bind(AirForceOfDragonEmperyMediator.ON_ACTIVITY_OPREATION, function(arg_3_0, arg_3_1)
		self:sendNotification(GAME.ACTIVITY_OPERATION, arg_3_1)

		return
	end)

	local var_1_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_AIRFIGHT_BATTLE)

	var_1_0:RecordTip()
	self.viewComponent:SetActivityData(var_1_0)

	return
end

function AirForceOfDragonEmperyMediator:listNotificationInterests()
	return {
		ActivityProxy.ACTIVITY_UPDATED,
		GAME.BEGIN_STAGE_DONE,
		ActivityProxy.ACTIVITY_SHOW_AWARDS
	}
end

function AirForceOfDragonEmperyMediator:handleNotification(arg_5_1)
	local var_5_0 = arg_5_1:getName()
	local var_5_1 = arg_5_1:getBody()

	if var_5_0 == ActivityProxy.ACTIVITY_UPDATED then
		if var_5_1:getConfig("type") == ActivityConst.ACTIVITY_TYPE_AIRFIGHT_BATTLE then
			self:getViewComponent():SetActivityData(var_5_1)
			self:getViewComponent():UpdateView()
		end
	elseif var_5_0 == GAME.BEGIN_STAGE_DONE then
		self:sendNotification(GAME.GO_SCENE, SCENE.COMBATLOAD, var_5_1)
	elseif var_5_0 == ActivityProxy.ACTIVITY_SHOW_AWARDS then
		self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_5_1.awards, var_5_1.callback)
	end

	return
end

return AirForceOfDragonEmperyMediator
