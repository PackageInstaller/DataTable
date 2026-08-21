local var_0_0 = class("LiquorFloorBookMediator", import("view.base.ContextMediator"))

var_0_0.ON_GET_TASK = "LiquorFloorBookMediator:ON_GET_TASK"
var_0_0.ACT_ID = ActivityConst.LiquorFloor_ACT_ID

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.ON_GET_TASK, function(arg_2_0, arg_2_1)
		arg_1_0:sendNotification(GAME.SUBMIT_TASK, arg_2_1)

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_3_0)
	return {
		GAME.SUBMIT_TASK_AWARD_DOWN
	}
end

function var_0_0.handleNotification(arg_4_0, arg_4_1)
	if arg_4_1:getName() == GAME.SUBMIT_TASK_AWARD_DOWN then
		arg_4_0.viewComponent:emit(BaseUI.ON_ACHIEVE, arg_4_1:getBody().awards, function()
			arg_4_0.viewComponent:updateAwardPanel()
			arg_4_0.viewComponent:updateTag()

			return
		end)
	end

	return
end

return var_0_0
