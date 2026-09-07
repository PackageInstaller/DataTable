local AmusementParkMediator = class("AmusementParkMediator", import("..TemplateMV.BackHillMediatorTemplate"))

AmusementParkMediator.MINIGAME_OPERATION = "MINIGAME_OPERATION"
AmusementParkMediator.ACTIVITY_OPERATION = "ACTIVITY_OPERATION"

function AmusementParkMediator:register()
	self:BindEvent()

	local var_1_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_BUILDING_BUFF)

	assert(var_1_0, "Building Activity Not Found")

	self.activity = var_1_0

	self.viewComponent:UpdateActivity(var_1_0)

	return
end

function AmusementParkMediator:BindEvent()
	self.super.BindEvent(self)
	self:bind(AmusementParkMediator.ACTIVITY_OPERATION, function(arg_3_0, arg_3_1)
		assert(self.activity, "Cant Initialize Activity")

		arg_3_1.activity_id = self.activity.id

		self:sendNotification(GAME.ACTIVITY_OPERATION, arg_3_1)

		return
	end)

	return
end

function AmusementParkMediator:listNotificationInterests()
	return {
		GAME.SEND_MINI_GAME_OP_DONE,
		ActivityProxy.ACTIVITY_UPDATED
	}
end

function AmusementParkMediator:handleNotification(arg_5_1)
	local var_5_0 = arg_5_1:getName()
	local var_5_1 = arg_5_1:getBody()

	if var_5_0 == GAME.SEND_MINI_GAME_OP_DONE then
		seriesAsync({
			function(arg_6_0)
				if #var_5_1.awards > 0 then
					self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_5_1.awards, arg_6_0)
				else
					arg_6_0()
				end

				return
			end,
			function(arg_7_0)
				self.viewComponent:UpdateView()

				return
			end
		})
	elseif var_5_0 == ActivityProxy.ACTIVITY_UPDATED then
		if var_5_1:getConfig("type") == ActivityConst.ACTIVITY_TYPE_BUILDING_BUFF then
			self.activity = var_5_1

			self.viewComponent:UpdateActivity(var_5_1)
		elseif var_5_1:getConfig("type") == ActivityConst.ACTIVITY_TYPE_SHOP_PROGRESS_REWARD then
			self.viewComponent:UpdateView()
		end
	end

	return
end

return AmusementParkMediator
