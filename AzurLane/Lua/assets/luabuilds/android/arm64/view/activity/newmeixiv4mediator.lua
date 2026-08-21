local var_0_0 = class("NewMeixiV4Mediator", import("view.base.ContextMediator"))

var_0_0.ON_TASK_GO = "ON_TASK_GO"
var_0_0.ON_TASK_SUBMIT = "ON_TASK_SUBMIT"
var_0_0.GO_STORY = "GO_STORY"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.ON_TASK_GO, function(arg_2_0, arg_2_1)
		arg_1_0:sendNotification(GAME.TASK_GO, {
			taskVO = arg_2_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_TASK_SUBMIT, function(arg_3_0, arg_3_1)
		arg_1_0:sendNotification(GAME.SUBMIT_TASK, arg_3_1.id)

		return
	end)
	arg_1_0:bind(var_0_0.GO_STORY, function(arg_4_0, arg_4_1)
		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.WORLD_COLLECTION, {
			memoryGroup = arg_4_1
		})

		return
	end)
	arg_1_0.viewComponent:setPlayer(getProxy(PlayerProxy):getData())

	return
end

function var_0_0.listNotificationInterests(arg_5_0)
	return {
		ActivityProxy.ACTIVITY_UPDATED,
		PlayerProxy.UPDATED,
		GAME.SUBMIT_TASK_DONE
	}
end

function var_0_0.handleNotification(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1:getName()
	local var_6_1 = arg_6_1:getBody()

	if var_6_0 == ActivityProxy.ACTIVITY_UPDATED then
		if var_6_1.id == ActivityConst.NEWMEIXIV4_SKIRMISH_ID then
			arg_6_0.viewComponent:onUpdateTask()
		end
	elseif var_6_0 == PlayerProxy.UPDATED then
		arg_6_0.viewComponent:onUpdateRes(var_6_1)
	elseif var_6_0 == GAME.SUBMIT_TASK_DONE then
		arg_6_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_6_1, function()
			arg_6_0.viewComponent:onUpdateTask()

			return
		end)
	end

	return
end

return var_0_0
