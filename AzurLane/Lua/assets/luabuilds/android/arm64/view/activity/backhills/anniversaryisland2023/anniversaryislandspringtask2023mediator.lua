local var_0_0 = class("AnniversaryIslandSpringTask2023Mediator", import("view.base.ContextMediator"))

var_0_0.SUBMIT_TASK = "activity submit task "
var_0_0.TASK_GO = "activity task go "
var_0_0.SHOW_DETAIL = "activity task show detail"
var_0_0.SHOW_SUBMIT_WINDOW = "AnniversaryIslandSpringTask2023Mediator:SHOW_SUBMIT_WINDOW"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.SUBMIT_TASK, function(arg_2_0, arg_2_1)
		arg_1_0:sendNotification(GAME.SUBMIT_ACTIVITY_TASK, {
			act_id = arg_2_1.actId,
			task_ids = {
				arg_2_1.id
			}
		})

		return
	end)
	arg_1_0:bind(var_0_0.TASK_GO, function(arg_3_0, arg_3_1)
		arg_1_0:sendNotification(GAME.TASK_GO, {
			taskVO = arg_3_1.taskVO
		})

		return
	end)
	arg_1_0:bind(var_0_0.SHOW_DETAIL, function(arg_4_0, arg_4_1)
		arg_1_0:addSubLayers(Context.New({
			mediator = WorkBenchItemDetailMediator,
			viewComponent = WorkBenchItemDetailLayer,
			data = {
				material = arg_4_1
			}
		}))

		return
	end)
	arg_1_0:bind(var_0_0.SHOW_SUBMIT_WINDOW, function(arg_5_0, arg_5_1)
		arg_1_0:addSubLayers(Context.New({
			mediator = AnniversaryIslandSpringTaskSubmitWindowMediator,
			viewComponent = AnniversaryIslandSpringTaskSubmitWindow,
			data = {
				task = arg_5_1
			}
		}))

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_6_0)
	return {
		AnniversaryIslandSpringTask2023Mediator.SUBMIT_TASK,
		GAME.SUBMIT_ACTIVITY_TASK_DONE,
		ActivityProxy.ACTIVITY_UPDATED
	}
end

function var_0_0.handleNotification(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1:getName()
	local var_7_1 = arg_7_1:getBody()

	if var_7_0 == AnniversaryIslandSpringTask2023Mediator.SUBMIT_TASK then
		arg_7_0.viewComponent:emit(AnniversaryIslandSpringTask2023Mediator.SUBMIT_TASK, var_7_1)
	elseif var_7_0 == GAME.SUBMIT_ACTIVITY_TASK_DONE then
		arg_7_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_7_1.awards, function()
			existCall(var_7_1.callback)

			local var_8_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_HOTSPRING_2)
			local var_8_1 = getProxy(ActivityTaskProxy):getTaskVOsByActId((var_8_0:GetConfigID()))

			if _.all(var_8_0:GetUnlockTaskIds(), function(arg_9_0)
				local var_9_0 = _.detect(var_8_1, function(arg_10_0)
					return arg_10_0:GetConfigID() == arg_9_0
				end)

				return var_9_0 and var_9_0:isOver()
			end) then
				arg_7_0:sendNotification(GAME.CHANGE_SCENE, SCENE.ANNIVERSARY_ISLAND_SPRING)
			end

			return
		end)
	elseif var_7_0 == ActivityProxy.ACTIVITY_UPDATED then
		arg_7_0.viewComponent:BuildTaskVOs()
		arg_7_0.viewComponent:UpdateView()
	end

	return
end

function var_0_0.remove(arg_11_0)
	return
end

return var_0_0
