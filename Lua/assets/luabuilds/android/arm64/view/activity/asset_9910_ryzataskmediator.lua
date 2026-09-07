local RyzaTaskMediator = class("RyzaTaskMediator", import("..base.ContextMediator"))

RyzaTaskMediator.SUBMIT_TASK_ALL = "activity submit task all"
RyzaTaskMediator.SUBMIT_TASK = "activity submit task "
RyzaTaskMediator.TASK_GO = "activity task go "
RyzaTaskMediator.SHOW_DETAIL = "activity task show detail"

function RyzaTaskMediator:register()
	self:bind(RyzaTaskMediator.SUBMIT_TASK_ALL, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.SUBMIT_ACTIVITY_TASK, {
			act_id = arg_2_1.activityId,
			task_ids = arg_2_1.ids
		})

		return
	end)
	self:bind(RyzaTaskMediator.SUBMIT_TASK, function(arg_3_0, arg_3_1)
		self:sendNotification(GAME.SUBMIT_ACTIVITY_TASK, {
			act_id = arg_3_1.activityId,
			task_ids = {
				arg_3_1.id
			}
		})

		return
	end)
	self:bind(RyzaTaskMediator.TASK_GO, function(arg_4_0, arg_4_1)
		self:sendNotification(GAME.TASK_GO, {
			taskVO = arg_4_1.taskVO
		})

		return
	end)
	self:bind(RyzaTaskMediator.SHOW_DETAIL, function(arg_5_0, arg_5_1)
		self:addSubLayers(Context.New({
			mediator = AtelierMaterialDetailMediator,
			viewComponent = AtelierMaterialDetailLayer,
			data = {
				material = arg_5_1
			}
		}))

		return
	end)

	return
end

function RyzaTaskMediator:listNotificationInterests()
	return {
		GAME.SUBMIT_ACTIVITY_TASK_DONE
	}
end

function RyzaTaskMediator:handleNotification(arg_7_1)
	local var_7_0 = arg_7_1:getBody()

	if arg_7_1:getName() == GAME.SUBMIT_ACTIVITY_TASK_DONE then
		if #var_7_0.awards > 0 then
			self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_7_0.awards)
		end

		if var_7_0.callback then
			-- block empty
		end

		self.viewComponent:updateTask(true)
	end

	return
end

return RyzaTaskMediator
