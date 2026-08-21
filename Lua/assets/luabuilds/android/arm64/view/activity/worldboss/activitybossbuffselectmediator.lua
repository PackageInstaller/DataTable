local var_0_0 = class("ActivityBossBuffSelectMediator", import("view.base.ContextMediator"))

var_0_0.ON_START = "ActivityBossBuffSelectMediator:ON_START"
var_0_0.SHOW_REWARDS = "ActivityBossBuffSelectMediator:SHOW_REWARDS"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.ON_START, function(arg_2_0, arg_2_1)
		getProxy(ActivityProxy):GetActivityBossRuntime(getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_BOSS_BATTLE_MARK_2).id).buffIds = _.map(arg_2_1, function(arg_3_0)
			return arg_3_0:GetConfigID()
		end)

		arg_1_0:sendNotification(var_0_0.ON_START)
		arg_1_0.viewComponent:closeView()

		return
	end)
	arg_1_0:bind(var_0_0.SHOW_REWARDS, function(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
		arg_1_0:addSubLayers(Context.New({
			mediator = ActivityBossScoreAwardMediator,
			viewComponent = ActivityBossScoreAwardLayer,
			data = {
				awards = arg_4_1,
				targets = arg_4_2,
				score = arg_4_3
			}
		}))

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_5_0)
	return {}
end

function var_0_0.handleNotification(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1:getBody()

	if arg_6_1:getName() == nil then
		-- block empty
	end

	return
end

function var_0_0.remove(arg_7_0)
	return
end

return var_0_0
