class = var_0_10000

local var_0_0 = "ActivityBossBuffSelectMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.ContextMediator"))

var_0_1.ON_START = "ActivityBossBuffSelectMediator:ON_START"
var_0_1.SHOW_REWARDS = "ActivityBossBuffSelectMediator:SHOW_REWARDS"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.ON_START, function(arg_2_0, arg_2_1)
		getProxy = var_2_10002
		ActivityProxy = var_2_10004

		local var_2_0 = var_2_10002(var_2_10004)
		local var_2_1 = var_2.getActivityByType

		ActivityConst = var_2_10005

		local var_2_2 = var_2_1(var_2_0, var_2_10005.ACTIVITY_TYPE_BOSS_BATTLE_MARK_2)

		getProxy = var_2_10003
		ActivityProxy = var_5

		local var_2_3 = var_2_10003(var_5)
		local var_2_4 = var_3.GetActivityBossRuntime(var_2_3, var_2_2.id)

		_ = var_2_0
		var_2_4.buffIds = var_2_0.map(arg_2_1, function(arg_3_0)
			return arg_3_0:GetConfigID()
		end)

		local var_2_5 = arg_1_0

		var_3.sendNotification(var_2_5, var_0_1.ON_START)

		local var_2_6 = arg_1_0.viewComponent

		var_3.closeView(var_2_6)

		return
	end)
	arg_1_0:bind(var_0_1.SHOW_REWARDS, function(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
		local var_4_0 = arg_1_0
		local var_4_1 = var_4.addSubLayers

		Context = var_2_10007

		local var_4_2 = var_2_10007.New
		local var_4_3 = {}

		ActivityBossScoreAwardMediator = var_2_10010
		var_4_3.mediator = var_2_10010
		ActivityBossScoreAwardLayer = var_2_10010
		var_4_3.viewComponent = var_2_10010
		var_4_3.data = {
			awards = arg_4_1,
			targets = arg_4_2,
			score = arg_4_3
		}

		var_4_1(var_4_0, var_4_2(var_4_3))

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_5_0)
	return {}
end

function var_0_1.handleNotification(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1:getName()
	local var_6_1 = arg_6_1:getBody()

	if var_6_0 == nil then
		-- block empty
	end

	return
end

function var_0_1.remove(arg_7_0)
	return
end

return var_0_1
