local HolidayVillaTasksMediator = class("HolidayVillaTasksMediator", import("view.base.ContextMediator"))

HolidayVillaTasksMediator.ON_TASK_SUBMIT = "HolidayVillaTasksMediator.ON_TASK_SUBMIT"
HolidayVillaTasksMediator.ON_TASK_SUBMIT_ONESTEP = "HolidayVillaTasksMediator.ON_TASK_SUBMIT_ONESTEP"
HolidayVillaTasksMediator.ON_TASK_GO = "HolidayVillaTasksMediator.ON_TASK_GO"

function HolidayVillaTasksMediator:register()
	self:BindEvent()

	return
end

function HolidayVillaTasksMediator:BindEvent()
	self:bind(HolidayVillaTasksMediator.ON_TASK_SUBMIT_ONESTEP, function(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
		self:sendNotification(GAME.SUBMIT_ACTIVITY_TASK, {
			act_id = arg_3_1,
			task_ids = arg_3_2,
			callback = arg_3_3
		})

		return
	end)
	self:bind(HolidayVillaTasksMediator.ON_TASK_GO, function(arg_4_0, arg_4_1, arg_4_2)
		self:sendNotification(GAME.TASK_GO, {
			taskVO = arg_4_1
		})

		return
	end)

	return
end

function HolidayVillaTasksMediator:listNotificationInterests()
	return {
		GAME.SUBMIT_TASK_AWARD_DOWN
	}
end

function HolidayVillaTasksMediator:handleNotification(arg_6_1)
	local var_6_0 = arg_6_1:getBody()

	if arg_6_1:getName() == GAME.SUBMIT_TASK_AWARD_DOWN and #var_6_0.awards > 0 then
		self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_6_0.awards, function()
			self.viewComponent:InitData()

			return
		end)
	end

	return
end

return HolidayVillaTasksMediator
