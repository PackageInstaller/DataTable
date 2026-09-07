local AnniversaryIslandSpringTask2023Mediator = class("AnniversaryIslandSpringTask2023Mediator", import("view.base.ContextMediator"))

AnniversaryIslandSpringTask2023Mediator.SUBMIT_TASK = "activity submit task "
AnniversaryIslandSpringTask2023Mediator.TASK_GO = "activity task go "
AnniversaryIslandSpringTask2023Mediator.SHOW_DETAIL = "activity task show detail"
AnniversaryIslandSpringTask2023Mediator.SHOW_SUBMIT_WINDOW = "AnniversaryIslandSpringTask2023Mediator:SHOW_SUBMIT_WINDOW"

function AnniversaryIslandSpringTask2023Mediator:register()
	self:bind(AnniversaryIslandSpringTask2023Mediator.SUBMIT_TASK, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.SUBMIT_ACTIVITY_TASK, {
			act_id = arg_2_1.actId,
			task_ids = {
				arg_2_1.id
			}
		})

		return
	end)
	self:bind(AnniversaryIslandSpringTask2023Mediator.TASK_GO, function(arg_3_0, arg_3_1)
		self:sendNotification(GAME.TASK_GO, {
			taskVO = arg_3_1.taskVO
		})

		return
	end)
	self:bind(AnniversaryIslandSpringTask2023Mediator.SHOW_DETAIL, function(arg_4_0, arg_4_1)
		self:addSubLayers(Context.New({
			mediator = WorkBenchItemDetailMediator,
			viewComponent = WorkBenchItemDetailLayer,
			data = {
				material = arg_4_1
			}
		}))

		return
	end)
	self:bind(AnniversaryIslandSpringTask2023Mediator.SHOW_SUBMIT_WINDOW, function(arg_5_0, arg_5_1)
		self:addSubLayers(Context.New({
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

function AnniversaryIslandSpringTask2023Mediator:listNotificationInterests()
	return {
		AnniversaryIslandSpringTask2023Mediator.SUBMIT_TASK,
		GAME.SUBMIT_ACTIVITY_TASK_DONE,
		ActivityProxy.ACTIVITY_UPDATED
	}
end

function AnniversaryIslandSpringTask2023Mediator:handleNotification(arg_7_1)
	local var_7_0 = arg_7_1:getName()
	local var_7_1 = arg_7_1:getBody()

	if var_7_0 == AnniversaryIslandSpringTask2023Mediator.SUBMIT_TASK then
		self.viewComponent:emit(AnniversaryIslandSpringTask2023Mediator.SUBMIT_TASK, var_7_1)
	elseif var_7_0 == GAME.SUBMIT_ACTIVITY_TASK_DONE then
		self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_7_1.awards, function()
			existCall(var_7_1.callback)

			local var_8_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_HOTSPRING_2)
			local var_8_1 = getProxy(ActivityTaskProxy):getTaskVOsByActId((var_8_0:GetConfigID()))

			if _.all(var_8_0:GetUnlockTaskIds(), function(arg_9_0)
				local var_9_0 = _.detect(var_8_1, function(arg_10_0)
					return arg_10_0:GetConfigID() == arg_9_0
				end)

				return var_9_0 and var_9_0:isOver()
			end) then
				self:sendNotification(GAME.CHANGE_SCENE, SCENE.ANNIVERSARY_ISLAND_SPRING)
			end

			return
		end)
	elseif var_7_0 == ActivityProxy.ACTIVITY_UPDATED then
		self.viewComponent:BuildTaskVOs()
		self.viewComponent:UpdateView()
	end

	return
end

function AnniversaryIslandSpringTask2023Mediator:remove()
	return
end

return AnniversaryIslandSpringTask2023Mediator
