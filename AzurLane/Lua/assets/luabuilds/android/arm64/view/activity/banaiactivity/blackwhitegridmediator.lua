local var_0_0 = class("BlackWhiteGridMediator", import("...base.ContextMediator"))

var_0_0.ON_FINISH = "VirtualSpaceMediator:ON_FINISH"
var_0_0.ON_UPDATE_SCORE = "VirtualSpaceMediator:ON_UPDATE_SCORE"

function var_0_0.register(arg_1_0)
	arg_1_0.viewComponent:setActivity((getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_BLACKWHITE)))
	arg_1_0:bind(var_0_0.ON_FINISH, function(arg_2_0, arg_2_1, arg_2_2)
		arg_1_0:sendNotification(GAME.BLACK_WHITE_GRID_OP, {
			cmd = 1,
			activityId = var_0.id,
			id = arg_2_1,
			score = arg_2_2
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_UPDATE_SCORE, function(arg_3_0, arg_3_1, arg_3_2)
		arg_1_0:sendNotification(GAME.BLACK_WHITE_GRID_OP, {
			cmd = 2,
			activityId = var_0.id,
			id = arg_3_1,
			score = arg_3_2
		})

		return
	end)
	arg_1_0.viewComponent:setPlayer((getProxy(PlayerProxy):getRawData()))

	return
end

function var_0_0.listNotificationInterests(arg_4_0)
	return {
		GAME.BLACK_WHITE_GRID_OP_DONE,
		ActivityProxy.ACTIVITY_UPDATED
	}
end

function var_0_0.handleNotification(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1:getName()
	local var_5_1 = arg_5_1:getBody()

	if var_5_0 == GAME.BLACK_WHITE_GRID_OP_DONE then
		seriesAsync({
			function(arg_6_0)
				arg_5_0.viewComponent:playStory(arg_6_0)

				return
			end,
			function(arg_7_0)
				if #var_5_1.awards > 0 then
					arg_5_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_5_1.awards, arg_7_0)
				else
					arg_7_0()
				end

				return
			end,
			function(arg_8_0)
				arg_5_0.viewComponent:updateBtnsState()
				arg_8_0()

				return
			end
		})
	elseif var_5_0 == ActivityProxy.ACTIVITY_UPDATED and arg_5_0.viewComponent.activityVO.id == var_5_1.id then
		arg_5_0.viewComponent:setActivity(var_5_1)
	end

	return
end

return var_0_0
