local BlackWhiteGridMediator = class("BlackWhiteGridMediator", import("...base.ContextMediator"))

BlackWhiteGridMediator.ON_FINISH = "VirtualSpaceMediator:ON_FINISH"
BlackWhiteGridMediator.ON_UPDATE_SCORE = "VirtualSpaceMediator:ON_UPDATE_SCORE"

function BlackWhiteGridMediator:register()
	local var_1_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_BLACKWHITE)

	self.viewComponent:setActivity(var_1_0)
	self:bind(BlackWhiteGridMediator.ON_FINISH, function(arg_2_0, arg_2_1, arg_2_2)
		self:sendNotification(GAME.BLACK_WHITE_GRID_OP, {
			cmd = 1,
			activityId = var_1_0.id,
			id = arg_2_1,
			score = arg_2_2
		})

		return
	end)
	self:bind(BlackWhiteGridMediator.ON_UPDATE_SCORE, function(arg_3_0, arg_3_1, arg_3_2)
		self:sendNotification(GAME.BLACK_WHITE_GRID_OP, {
			cmd = 2,
			activityId = var_1_0.id,
			id = arg_3_1,
			score = arg_3_2
		})

		return
	end)
	self.viewComponent:setPlayer((getProxy(PlayerProxy):getRawData()))

	return
end

function BlackWhiteGridMediator:listNotificationInterests()
	return {
		GAME.BLACK_WHITE_GRID_OP_DONE,
		ActivityProxy.ACTIVITY_UPDATED
	}
end

function BlackWhiteGridMediator:handleNotification(arg_5_1)
	local var_5_0 = arg_5_1:getName()
	local var_5_1 = arg_5_1:getBody()

	if var_5_0 == GAME.BLACK_WHITE_GRID_OP_DONE then
		seriesAsync({
			function(arg_6_0)
				self.viewComponent:playStory(arg_6_0)

				return
			end,
			function(arg_7_0)
				if #var_5_1.awards > 0 then
					self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_5_1.awards, arg_7_0)
				else
					arg_7_0()
				end

				return
			end,
			function(arg_8_0)
				self.viewComponent:updateBtnsState()
				arg_8_0()

				return
			end
		})
	elseif var_5_0 == ActivityProxy.ACTIVITY_UPDATED and self.viewComponent.activityVO.id == var_5_1.id then
		self.viewComponent:setActivity(var_5_1)
	end

	return
end

return BlackWhiteGridMediator
