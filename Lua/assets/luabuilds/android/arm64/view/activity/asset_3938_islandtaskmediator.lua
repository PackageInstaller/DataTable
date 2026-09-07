local IslandTaskMediator = class("IslandTaskMediator", import("..base.ContextMediator"))

IslandTaskMediator.SUBMIT_TASK_ALL = "activity submit task all"
IslandTaskMediator.SUBMIT_TASK = "activity submit task "
IslandTaskMediator.TASK_GO = "activity task go "
IslandTaskMediator.SHOW_DETAIL = "activity task show detail"

function IslandTaskMediator:register()
	self:bind(IslandTaskMediator.SUBMIT_TASK_ALL, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.SUBMIT_ACTIVITY_TASK, {
			act_id = arg_2_1.activityId,
			task_ids = arg_2_1.ids
		})

		return
	end)
	self:bind(IslandTaskMediator.SUBMIT_TASK, function(arg_3_0, arg_3_1)
		self:sendNotification(GAME.SUBMIT_ACTIVITY_TASK, {
			act_id = arg_3_1.activityId,
			task_ids = {
				arg_3_1.id
			}
		})

		return
	end)
	self:bind(IslandTaskMediator.TASK_GO, function(arg_4_0, arg_4_1)
		self.viewComponent:closeView()
		self:sendNotification(GAME.ISLAND_TASK_GO, {
			taskVO = arg_4_1.taskVO
		})

		return
	end)
	self:bind(IslandTaskMediator.SHOW_DETAIL, function(arg_5_0, arg_5_1)
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

function IslandTaskMediator:onUIAvalible()
	return
end

function IslandTaskMediator:listNotificationInterests()
	return {
		GAME.SUBMIT_ACTIVITY_TASK_DONE
	}
end

function IslandTaskMediator:handleNotification(arg_8_1)
	local var_8_0 = arg_8_1:getBody()

	if arg_8_1:getName() == GAME.SUBMIT_ACTIVITY_TASK_DONE then
		if #var_8_0.awards > 0 then
			self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_8_0.awards)
		end

		if var_8_0.callback then
			-- block empty
		end

		self.viewComponent:updateTask(true)
	end

	return
end

return IslandTaskMediator
