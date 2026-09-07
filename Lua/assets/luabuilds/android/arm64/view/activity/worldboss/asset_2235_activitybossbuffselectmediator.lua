local ActivityBossBuffSelectMediator = class("ActivityBossBuffSelectMediator", import("view.base.ContextMediator"))

ActivityBossBuffSelectMediator.ON_START = "ActivityBossBuffSelectMediator:ON_START"
ActivityBossBuffSelectMediator.SHOW_REWARDS = "ActivityBossBuffSelectMediator:SHOW_REWARDS"

function ActivityBossBuffSelectMediator:register()
	self:bind(ActivityBossBuffSelectMediator.ON_START, function(arg_2_0, arg_2_1)
		getProxy(ActivityProxy):GetActivityBossRuntime(getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_BOSS_BATTLE_MARK_2).id).buffIds = _.map(arg_2_1, function(arg_3_0)
			return arg_3_0:GetConfigID()
		end)

		self:sendNotification(ActivityBossBuffSelectMediator.ON_START)
		self.viewComponent:closeView()

		return
	end)
	self:bind(ActivityBossBuffSelectMediator.SHOW_REWARDS, function(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
		self:addSubLayers(Context.New({
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

function ActivityBossBuffSelectMediator:listNotificationInterests()
	return {}
end

function ActivityBossBuffSelectMediator:handleNotification(arg_6_1)
	local var_6_0 = arg_6_1:getBody()

	if arg_6_1:getName() == nil then
		-- block empty
	end

	return
end

function ActivityBossBuffSelectMediator:remove()
	return
end

return ActivityBossBuffSelectMediator
