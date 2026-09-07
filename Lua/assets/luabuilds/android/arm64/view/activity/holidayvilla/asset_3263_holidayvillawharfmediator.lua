local HolidayVillaWharfMediator = class("HolidayVillaWharfMediator", import("view.base.ContextMediator"))

HolidayVillaWharfMediator.ON_TASK_SUBMIT_ONESTEP = "HolidayVillaWharfMediator.ON_TASK_SUBMIT_ONESTEP"

function HolidayVillaWharfMediator:register()
	self:bind(HolidayVillaWharfMediator.ON_TASK_SUBMIT_ONESTEP, function(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		self:sendNotification(GAME.SUBMIT_ACTIVITY_TASK, {
			act_id = arg_2_1,
			task_ids = arg_2_2,
			callback = arg_2_3
		})

		return
	end)

	return
end

function HolidayVillaWharfMediator:listNotificationInterests()
	return {
		GAME.SUBMIT_ACTIVITY_TASK_DONE
	}
end

function HolidayVillaWharfMediator:handleNotification(arg_4_1)
	if arg_4_1:getName() == GAME.SUBMIT_ACTIVITY_TASK_DONE then
		self.viewComponent:SetAwardsShow(arg_4_1:getBody().awards)
		self.viewComponent:RefreshData()
		self.viewComponent:Show()
		self.viewComponent:ShowCompletePage()
	end

	return
end

return HolidayVillaWharfMediator
