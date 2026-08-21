local var_0_0 = class("AmusementParkMediator", import("..TemplateMV.BackHillMediatorTemplate"))

var_0_0.MINIGAME_OPERATION = "MINIGAME_OPERATION"
var_0_0.ACTIVITY_OPERATION = "ACTIVITY_OPERATION"

function var_0_0.register(arg_1_0)
	arg_1_0:BindEvent()

	local var_1_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_BUILDING_BUFF)

	assert(var_1_0, "Building Activity Not Found")

	arg_1_0.activity = var_1_0

	arg_1_0.viewComponent:UpdateActivity(var_1_0)

	return
end

function var_0_0.BindEvent(arg_2_0)
	arg_2_0.super.BindEvent(arg_2_0)
	arg_2_0:bind(var_0_0.ACTIVITY_OPERATION, function(arg_3_0, arg_3_1)
		assert(arg_2_0.activity, "Cant Initialize Activity")

		arg_3_1.activity_id = arg_2_0.activity.id

		arg_2_0:sendNotification(GAME.ACTIVITY_OPERATION, arg_3_1)

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_4_0)
	return {
		GAME.SEND_MINI_GAME_OP_DONE,
		ActivityProxy.ACTIVITY_UPDATED
	}
end

function var_0_0.handleNotification(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1:getName()
	local var_5_1 = arg_5_1:getBody()

	if var_5_0 == GAME.SEND_MINI_GAME_OP_DONE then
		seriesAsync({
			function(arg_6_0)
				if #var_5_1.awards > 0 then
					arg_5_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_5_1.awards, arg_6_0)
				else
					arg_6_0()
				end

				return
			end,
			function(arg_7_0)
				arg_5_0.viewComponent:UpdateView()

				return
			end
		})
	elseif var_5_0 == ActivityProxy.ACTIVITY_UPDATED then
		if var_5_1:getConfig("type") == ActivityConst.ACTIVITY_TYPE_BUILDING_BUFF then
			arg_5_0.activity = var_5_1

			arg_5_0.viewComponent:UpdateActivity(var_5_1)
		elseif var_5_1:getConfig("type") == ActivityConst.ACTIVITY_TYPE_SHOP_PROGRESS_REWARD then
			arg_5_0.viewComponent:UpdateView()
		end
	end

	return
end

return var_0_0
