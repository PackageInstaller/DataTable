local var_0_0 = class("NewEducateScheduleMediator", import("view.newEducate.base.NewEducateContextMediator"))

var_0_0.ON_SELECTED_PLANS = "NewEducateScheduleMediator.ON_SELECTED_PLANS"
var_0_0.ON_UPGRADE_PLANS = "NewEducateScheduleMediator.ON_UPGRADE_PLANS"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.ON_SELECTED_PLANS, function(arg_2_0, arg_2_1, arg_2_2)
		for iter_2_0, iter_2_1 in ipairs(arg_2_2) do
			if iter_2_1.plan then
				table.insert({}, {
					key = iter_2_0,
					value = iter_2_1.plan.id
				})
			end
		end

		arg_1_0:sendNotification(GAME.NEW_EDUCATE_SCHEDULE, {
			id = arg_1_0.contextData.char.id,
			planKVs = {},
			isSkip = arg_2_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_UPGRADE_PLANS, function(arg_3_0, arg_3_1)
		arg_1_0:sendNotification(GAME.NEW_EDUCATE_UPGRADE_PLAN, {
			id = arg_1_0.contextData.char.id,
			planIds = arg_3_1
		})

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_4_0)
	return {
		GAME.NEW_EDUCATE_UPGRADE_PLAN_DONE,
		GAME.NEW_EDUCATE_SCHEDULE_DONE
	}
end

function var_0_0.handleNotification(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1:getName()

	if var_5_0 == GAME.NEW_EDUCATE_UPGRADE_PLAN_DONE then
		arg_5_0.viewComponent:OnUpgradePlans()
	elseif var_5_0 == GAME.NEW_EDUCATE_SCHEDULE_DONE then
		arg_5_0.viewComponent:SetScheduleData((arg_5_1:getBody()))
		arg_5_0.viewComponent:closeView()
	end

	return
end

return var_0_0
