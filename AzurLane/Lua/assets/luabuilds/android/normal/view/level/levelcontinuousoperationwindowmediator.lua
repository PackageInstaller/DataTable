class = var_0_10000

local var_0_0 = "LevelContinuousOperationWindowMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.ContextMediator"))

function var_0_1.register(arg_1_0)
	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.bind

	PreCombatMediator = var_1_10003

	var_1_1(var_1_0, var_1_10003.CONTINUOUS_OPERATION, function(arg_2_0)
		local var_2_0 = arg_1_0
		local var_2_1 = var_1.sendNotification

		LevelUIConst = var_2_10003

		local var_2_2 = var_2_10003.CONTINUOUS_OPERATION
		local var_2_3 = {}

		math = var_2_10005
		var_2_3.battleTimes = var_2_10005.min(arg_1_0.contextData.battleTimes, 10)

		var_2_1(var_2_0, var_2_2, var_2_3)

		return
	end)

	local var_1_2 = arg_1_0
	local var_1_3 = arg_1_0.bind

	LevelMediator2 = var_3

	var_1_3(var_1_2, var_3.ON_SPITEM_CHANGED, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.sendNotification

		LevelMediator2 = var_2_10004

		var_3_1(var_3_0, var_2_10004.ON_SPITEM_CHANGED, arg_3_1)

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_4_0)
	local var_4_0 = {}

	ActivityProxy = var_1_10002
	var_4_0[1] = var_1_10002.ACTIVITY_UPDATED
	PlayerProxy = var_2
	var_4_0[2] = var_2.UPDATED

	return var_4_0
end

function var_0_1.handleNotification(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1:getName()
	local var_5_1 = arg_5_1
	local var_5_2 = arg_5_1.getBody(var_5_1)

	ActivityProxy = var_5_1

	local var_5_4

	if var_5_0 == var_5_1.ACTIVITY_UPDATED then
		local var_5_3 = var_5_2

		var_5_4 = var_5_2.getConfig(var_5_3, "type")
		ActivityConst = var_5_3

		if var_5_4 == var_5_3.ACTIVITY_TYPE_BOSS_BATTLE_MARK_2 then
			local var_5_5 = arg_5_0.viewComponent

			var_5_4.SetActivity(var_5_5, var_5_2)
		end
	else
		PlayerProxy = var_5_4

		if var_5_0 == var_5_4.UPDATED then
			local var_5_6 = arg_5_0.viewComponent

			var_4.UpdateContent(var_5_6)
		end
	end

	return
end

function var_0_1.remove(arg_6_0)
	return
end

return var_0_1
