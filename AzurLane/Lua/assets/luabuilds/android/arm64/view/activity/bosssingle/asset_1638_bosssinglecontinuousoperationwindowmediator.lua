class = var_0_10000

local var_0_0 = "BossSingleContinuousOperationWindowMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.ContextMediator"))

function var_0_1.register(arg_1_0)
	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.bind

	PreCombatMediator = var_1_10004

	var_1_1(var_1_0, var_1_10004.CONTINUOUS_OPERATION, function(arg_2_0)
		local var_2_0 = arg_1_0
		local var_2_1 = var_1.sendNotification

		GAME = var_2_10004

		local var_2_2 = var_2_10004.AUTO_BOT
		local var_2_3 = {
			isActiveBot = false
		}

		SYSTEM_BOSS_SINGLE = var_2_10006
		var_2_3.system = var_2_10006

		var_2_1(var_2_0, var_2_2, var_2_3)

		ys = var_2_1

		local var_2_4 = var_2_1.Battle.BattleState.IsAutoSubActive

		SYSTEM_BOSS_SINGLE = var_2_0

		local var_2_5 = var_2_4(var_2_0)

		getProxy = var_2_10002
		SettingsProxy = var_2_2

		local var_2_6 = var_2_10002(var_2_2)

		var_2.RecordContinuousOperationAutoSubStatus(var_2_6, var_2_5)

		local var_2_7 = arg_1_0
		local var_2_8 = var_2.sendNotification

		GAME = var_5

		local var_2_9 = var_5.AUTO_SUB
		local var_2_10 = {
			isActiveSub = false
		}

		SYSTEM_BOSS_SINGLE = var_2_10007
		var_2_10.system = var_2_10007

		var_2_8(var_2_7, var_2_9, var_2_10)

		local var_2_11 = arg_1_0
		local var_2_12 = var_2.sendNotification

		BossSinglePreCombatMediator = var_2_9

		local var_2_13 = var_2_9.CONTINUOUS_OPERATION
		local var_2_14 = {
			mainFleetId = arg_1_0.contextData.mainFleetId
		}

		math = var_7
		var_2_14.battleTimes = var_7.min(arg_1_0.contextData.battleTimes, 15)

		var_2_12(var_2_11, var_2_13, var_2_14)

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_3_0)
	local var_3_0 = {}

	PlayerProxy = var_1_10002
	var_3_0[1] = var_1_10002.UPDATED

	return var_3_0
end

function var_0_1.handleNotification(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1
	local var_4_1 = arg_4_1.getName(var_4_0)
	local var_4_2 = arg_4_1:getBody()

	PlayerProxy = var_4_0

	if var_4_1 == var_4_0.UPDATED then
		local var_4_3 = arg_4_0.viewComponent

		var_4.UpdateContent(var_4_3)
	end

	return
end

function var_0_1.remove(arg_5_0)
	return
end

return var_0_1
