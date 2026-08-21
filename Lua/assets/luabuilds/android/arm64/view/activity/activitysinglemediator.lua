local var_0_0 = class("ActivityMediator", import("..base.ContextMediator"))

function var_0_0.register(arg_1_0)
	arg_1_0.contextData.singleActivity = true

	arg_1_0:bind(ActivityMediator.EVENT_OPERATION, function(arg_2_0, arg_2_1)
		arg_1_0:sendNotification(GAME.ACTIVITY_OPERATION, arg_2_1)

		return
	end)
	arg_1_0:bind(ActivityMediator.EVENT_GO_SCENE, function(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_1 == SCENE.SUMMER_FEAST then
			pg.NewStoryMgr.GetInstance():Play("TIANHOUYUYI1", function()
				arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.SUMMER_FEAST)

				return
			end)
		else
			arg_1_0:sendNotification(GAME.GO_SCENE, arg_3_1, arg_3_2)
		end

		return
	end)

	local var_1_0 = getProxy(PlayerProxy):getRawData()

	arg_1_0.viewComponent:setPlayer(var_1_0)
	arg_1_0.viewComponent:setFlagShip((getProxy(BayProxy):getShipById(var_1_0.character)))
	arg_1_0.viewComponent:selectActivity((getProxy(ActivityProxy):getActivityById(arg_1_0.contextData.id)))

	return
end

function var_0_0.listNotificationInterests(arg_5_0)
	return {
		ActivityProxy.ACTIVITY_ADDED,
		ActivityProxy.ACTIVITY_UPDATED,
		ActivityProxy.ACTIVITY_OPERATION_DONE,
		ActivityProxy.ACTIVITY_SHOW_AWARDS,
		GAME.ACT_NEW_PT_DONE,
		GAME.RETURN_AWARD_OP_DONE,
		GAME.MONOPOLY_AWARD_DONE,
		GAME.SUBMIT_TASK_DONE
	}
end

function var_0_0.handleNotification(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1:getName()
	local var_6_1 = arg_6_1:getBody()

	if var_6_0 == ActivityProxy.ACTIVITY_ADDED or var_6_0 == ActivityProxy.ACTIVITY_UPDATED then
		arg_6_0.viewComponent:updateActivity(var_6_1)
	elseif var_6_0 == ActivityProxy.ACTIVITY_OPERATION_DONE then
		-- block empty
	elseif var_6_0 == ActivityProxy.ACTIVITY_SHOW_AWARDS or var_6_0 == GAME.ACT_NEW_PT_DONE or var_6_0 == GAME.RETURN_AWARD_OP_DONE or var_6_0 == GAME.MONOPOLY_AWARD_DONE then
		arg_6_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_6_1.awards, var_6_1.callback)
	elseif var_6_0 == GAME.SUBMIT_TASK_DONE then
		arg_6_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_6_1, function()
			arg_6_0.viewComponent:updateTaskLayers()

			return
		end)
	elseif var_6_0 == GAME.SEND_MINI_GAME_OP_DONE then
		seriesAsync({
			function(arg_8_0)
				if #var_6_1.awards > 0 then
					if arg_6_0.viewComponent then
						arg_6_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_6_1.awards, arg_8_0)
					else
						arg_6_0:emit(BaseUI.ON_ACHIEVE, var_6_1.awards, arg_8_0)
					end
				else
					arg_8_0()
				end

				return
			end
		})
	end

	return
end

return var_0_0
