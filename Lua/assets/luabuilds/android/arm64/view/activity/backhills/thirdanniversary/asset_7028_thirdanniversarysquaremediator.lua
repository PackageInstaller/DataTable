local ThirdAnniversarySquareMediator = class("ThirdAnniversarySquareMediator", import("..TemplateMV.BackHillMediatorTemplate"))

ThirdAnniversarySquareMediator.MINIGAME_OPERATION = "MINIGAME_OPERATION"
ThirdAnniversarySquareMediator.ON_OPEN_TOWERCLIMBING_SIGNED = "ON_OPEN_TOWERCLIMBING_SIGNED"
ThirdAnniversarySquareMediator.ACTIVITY_OPERATION = "ACTIVITY_OPERATION"

function ThirdAnniversarySquareMediator:register()
	self:BindEvent()

	local var_1_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_BUILDING_BUFF)

	assert(var_1_0, "Building Activity Not Found")

	self.activity = var_1_0

	self.viewComponent:UpdateActivity(var_1_0)

	return
end

function ThirdAnniversarySquareMediator:BindEvent()
	ThirdAnniversarySquareMediator.super.BindEvent(self)
	self:bind(ThirdAnniversarySquareMediator.ON_OPEN_TOWERCLIMBING_SIGNED, function()
		self:sendNotification(GAME.GO_SCENE, SCENE.ACTIVITY, {
			id = ActivityConst.TOWERCLIMBING_SIGN
		})

		return
	end)
	self:bind(ThirdAnniversarySquareMediator.ACTIVITY_OPERATION, function(arg_4_0, arg_4_1)
		assert(self.activity, "Cant Initialize Activity")

		arg_4_1.activity_id = self.activity.id

		self:sendNotification(GAME.ACTIVITY_OPERATION, arg_4_1)

		return
	end)

	return
end

function ThirdAnniversarySquareMediator:listNotificationInterests()
	return {
		GAME.SEND_MINI_GAME_OP_DONE,
		ActivityProxy.ACTIVITY_UPDATED
	}
end

function ThirdAnniversarySquareMediator:handleNotification(arg_6_1)
	local var_6_0 = arg_6_1:getName()
	local var_6_1 = arg_6_1:getBody()

	if var_6_0 == GAME.SEND_MINI_GAME_OP_DONE then
		seriesAsync({
			function(arg_7_0)
				if #var_6_1.awards > 0 then
					self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_6_1.awards, arg_7_0)
				else
					arg_7_0()
				end

				return
			end,
			function(arg_8_0)
				self.viewComponent:UpdateView()

				return
			end
		})
	elseif var_6_0 == ActivityProxy.ACTIVITY_UPDATED and var_6_1:getConfig("type") == ActivityConst.ACTIVITY_TYPE_BUILDING_BUFF then
		self.activity = var_6_1

		self.viewComponent:UpdateActivity(var_6_1)
	end

	return
end

return ThirdAnniversarySquareMediator
