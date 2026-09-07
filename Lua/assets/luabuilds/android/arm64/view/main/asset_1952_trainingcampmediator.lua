local TrainingCampMediator = class("TrainingCampMediator", import("..base.ContextMediator"))

TrainingCampMediator.ON_GET = "TrainingCampMediator:ON_GET"
TrainingCampMediator.ON_GO = "TrainingCampMediator:ON_GO"
TrainingCampMediator.ON_TRIGGER = "TrainingCampMediator:ON_TRIGGER"
TrainingCampMediator.ON_SELECTABLE_GET = "TrainingCampMediator:ON_SELECTABLE_GET"
TrainingCampMediator.ON_UPDATE = "TrainingCampMediator:ON_UPDATE"

function TrainingCampMediator:register()
	self:bind(TrainingCampMediator.ON_UPDATE, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.UPDATE_TASK_PROGRESS, {
			taskId = arg_2_1.id
		})

		return
	end)
	self:bind(TrainingCampMediator.ON_SELECTABLE_GET, function(arg_3_0, arg_3_1, arg_3_2)
		self:sendNotification(GAME.SUBMIT_TASK, {
			taskId = arg_3_1.id,
			index = arg_3_2
		})

		return
	end)
	self:bind(TrainingCampMediator.ON_GET, function(arg_4_0, arg_4_1)
		self:sendNotification(GAME.SUBMIT_TASK, arg_4_1.id)

		return
	end)
	self:bind(TrainingCampMediator.ON_GO, function(arg_5_0, arg_5_1)
		local var_5_0 = arg_5_1:getConfig("scene")

		if var_5_0 and #var_5_0 > 0 then
			if var_5_0[1] == "LEVEL" and var_5_0[2] and var_5_0[2].chapterid then
				self:goToLevel(var_5_0[2].chapterid)
			elseif SCENE[var_5_0[1]] then
				self:sendNotification(GAME.GO_SCENE, SCENE[var_5_0[1]], var_5_0[2])
			end
		else
			self:sendNotification(GAME.TASK_GO, {
				taskVO = arg_5_1
			})
		end

		return
	end)
	self:bind(TrainingCampMediator.ON_TRIGGER, function(arg_6_0, arg_6_1)
		self:sendNotification(GAME.ACTIVITY_OPERATION, arg_6_1)

		return
	end)

	return
end

function TrainingCampMediator:listNotificationInterests()
	return {
		TaskProxy.TASK_UPDATED,
		TaskProxy.TASK_REMOVED,
		TaskProxy.TASK_DELETE,
		GAME.SUBMIT_TASK_DONE,
		ActivityProxy.ACTIVITY_OPERATION_DONE
	}
end

function TrainingCampMediator:handleNotification(arg_8_1)
	local var_8_0 = arg_8_1:getName()
	local var_8_1 = arg_8_1:getBody()

	if var_8_0 == TaskProxy.TASK_UPDATED or var_8_0 == TaskProxy.TASK_REMOVED or var_8_0 == TaskProxy.TASK_DELETE then
		self.viewComponent:switchPageByMediator()
		self.viewComponent:updateSwitchBtnsTag()
	elseif var_8_0 == GAME.SUBMIT_TASK_DONE then
		self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_8_1)
		self.viewComponent:switchPageByMediator()
		self.viewComponent:updateSwitchBtnsTag()
	elseif var_8_0 == ActivityProxy.ACTIVITY_OPERATION_DONE then
		self.viewComponent:tryShowTecFixTip(var_8_1)
		self.viewComponent:switchPageByMediator()
		self.viewComponent:updateSwitchBtnsTag()
	end

	return
end

return TrainingCampMediator
