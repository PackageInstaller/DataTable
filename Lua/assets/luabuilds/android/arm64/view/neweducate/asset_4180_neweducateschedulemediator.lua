local NewEducateScheduleMediator = class("NewEducateScheduleMediator", import("view.newEducate.base.NewEducateContextMediator"))

NewEducateScheduleMediator.ON_SELECTED_PLANS = "NewEducateScheduleMediator.ON_SELECTED_PLANS"
NewEducateScheduleMediator.ON_UPGRADE_PLANS = "NewEducateScheduleMediator.ON_UPGRADE_PLANS"

function NewEducateScheduleMediator:register()
	self:bind(NewEducateScheduleMediator.ON_SELECTED_PLANS, function(arg_2_0, arg_2_1, arg_2_2)
		local var_2_0 = {}

		for iter_2_0, iter_2_1 in ipairs(arg_2_2) do
			if iter_2_1.plan then
				table.insert(var_2_0, {
					key = iter_2_0,
					value = iter_2_1.plan.id
				})
			end
		end

		self:sendNotification(GAME.NEW_EDUCATE_SCHEDULE, {
			id = self.contextData.char.id,
			planKVs = var_2_0,
			isSkip = arg_2_1
		})

		return
	end)
	self:bind(NewEducateScheduleMediator.ON_UPGRADE_PLANS, function(arg_3_0, arg_3_1)
		self:sendNotification(GAME.NEW_EDUCATE_UPGRADE_PLAN, {
			id = self.contextData.char.id,
			planIds = arg_3_1
		})

		return
	end)

	return
end

function NewEducateScheduleMediator:listNotificationInterests()
	return {
		GAME.NEW_EDUCATE_UPGRADE_PLAN_DONE,
		GAME.NEW_EDUCATE_SCHEDULE_DONE
	}
end

function NewEducateScheduleMediator:handleNotification(arg_5_1)
	local var_5_0 = arg_5_1:getName()

	if var_5_0 == GAME.NEW_EDUCATE_UPGRADE_PLAN_DONE then
		self.viewComponent:OnUpgradePlans()
	elseif var_5_0 == GAME.NEW_EDUCATE_SCHEDULE_DONE then
		self.viewComponent:SetScheduleData((arg_5_1:getBody()))
		self.viewComponent:closeView()
	end

	return
end

return NewEducateScheduleMediator
