local var_0_0 = class("TrainingCampMediator", import("..base.ContextMediator"))

var_0_0.ON_GET = "TrainingCampMediator:ON_GET"
var_0_0.ON_GO = "TrainingCampMediator:ON_GO"
var_0_0.ON_TRIGGER = "TrainingCampMediator:ON_TRIGGER"
var_0_0.ON_SELECTABLE_GET = "TrainingCampMediator:ON_SELECTABLE_GET"
var_0_0.ON_UPDATE = "TrainingCampMediator:ON_UPDATE"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.ON_UPDATE, function(arg_2_0, arg_2_1)
		arg_1_0:sendNotification(GAME.UPDATE_TASK_PROGRESS, {
			taskId = arg_2_1.id
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_SELECTABLE_GET, function(arg_3_0, arg_3_1, arg_3_2)
		arg_1_0:sendNotification(GAME.SUBMIT_TASK, {
			taskId = arg_3_1.id,
			index = arg_3_2
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_GET, function(arg_4_0, arg_4_1)
		arg_1_0:sendNotification(GAME.SUBMIT_TASK, arg_4_1.id)

		return
	end)
	arg_1_0:bind(var_0_0.ON_GO, function(arg_5_0, arg_5_1)
		local var_5_0 = arg_5_1:getConfig("scene")

		if var_5_0 and #var_5_0 > 0 then
			if var_5_0[1] == "LEVEL" and var_5_0[2] and var_5_0[2].chapterid then
				arg_1_0:goToLevel(var_5_0[2].chapterid)
			elseif SCENE[var_5_0[1]] then
				arg_1_0:sendNotification(GAME.GO_SCENE, SCENE[var_5_0[1]], var_5_0[2])
			end
		else
			arg_1_0:sendNotification(GAME.TASK_GO, {
				taskVO = arg_5_1
			})
		end

		return
	end)
	arg_1_0:bind(var_0_0.ON_TRIGGER, function(arg_6_0, arg_6_1)
		arg_1_0:sendNotification(GAME.ACTIVITY_OPERATION, arg_6_1)

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_7_0)
	return {
		TaskProxy.TASK_UPDATED,
		TaskProxy.TASK_REMOVED,
		TaskProxy.TASK_DELETE,
		GAME.SUBMIT_TASK_DONE,
		ActivityProxy.ACTIVITY_OPERATION_DONE
	}
end

function var_0_0.handleNotification(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1:getName()
	local var_8_1 = arg_8_1:getBody()

	if var_8_0 == TaskProxy.TASK_UPDATED or var_8_0 == TaskProxy.TASK_REMOVED or var_8_0 == TaskProxy.TASK_DELETE then
		arg_8_0.viewComponent:switchPageByMediator()
		arg_8_0.viewComponent:updateSwitchBtnsTag()
	elseif var_8_0 == GAME.SUBMIT_TASK_DONE then
		arg_8_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_8_1)
		arg_8_0.viewComponent:switchPageByMediator()
		arg_8_0.viewComponent:updateSwitchBtnsTag()
	elseif var_8_0 == ActivityProxy.ACTIVITY_OPERATION_DONE then
		arg_8_0.viewComponent:tryShowTecFixTip(var_8_1)
		arg_8_0.viewComponent:switchPageByMediator()
		arg_8_0.viewComponent:updateSwitchBtnsTag()
	end

	return
end

return var_0_0
