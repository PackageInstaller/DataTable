class = var_0_10000

local var_0_0 = "ContinuousOperationWindowMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.ContextMediator"))

function var_0_1.register(arg_1_0)
	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.bind

	PreCombatMediator = var_1_10004

	var_1_1(var_1_0, var_1_10004.CONTINUOUS_OPERATION, function(arg_2_0)
		getProxy = var_2_10001
		SettingsProxy = var_2_10003

		local var_2_0 = var_2_10001(var_2_10003)

		var_1.setActBossExchangeTicketTip(var_2_0, arg_1_0.contextData.useTicket and 1 or 0)

		local var_2_1 = arg_1_0
		local var_2_2 = var_1.sendNotification

		GAME = var_4

		local var_2_3 = var_4.AUTO_BOT
		local var_2_4 = {
			isActiveBot = false
		}

		SYSTEM_ACT_BOSS = var_2_10006
		var_2_4.system = var_2_10006

		var_2_2(var_2_1, var_2_3, var_2_4)

		ys = var_2_2

		local var_2_5 = var_2_2.Battle.BattleState.IsAutoSubActive

		SYSTEM_ACT_BOSS = var_2_1

		local var_2_6 = var_2_5(var_2_1)

		getProxy = var_2_10002
		SettingsProxy = var_2_3

		local var_2_7 = var_2_10002(var_2_3)

		var_2.RecordContinuousOperationAutoSubStatus(var_2_7, var_2_6)

		local var_2_8 = arg_1_0
		local var_2_9 = var_2.sendNotification

		GAME = var_5

		local var_2_10 = var_5.AUTO_SUB
		local var_2_11 = {
			isActiveSub = false
		}

		SYSTEM_ACT_BOSS = var_2_10007
		var_2_11.system = var_2_10007

		var_2_9(var_2_8, var_2_10, var_2_11)

		local var_2_12 = arg_1_0
		local var_2_13 = var_2.sendNotification

		PreCombatMediator = var_2_10

		local var_2_14 = var_2_10.CONTINUOUS_OPERATION
		local var_2_15 = {
			mainFleetId = arg_1_0.contextData.mainFleetId
		}

		math = var_7
		var_2_15.battleTimes = var_7.min(arg_1_0.contextData.battleTimes, 15)

		var_2_13(var_2_12, var_2_14, var_2_15)

		return
	end)

	getProxy = var_1_1
	ActivityProxy = var_1_0

	local var_1_2 = var_1_1(var_1_0)
	local var_1_3 = var_1.getActivityByType

	ActivityConst = var_4

	local var_1_4 = var_1_3(var_1_2, var_4.ACTIVITY_TYPE_BOSS_BATTLE_MARK_2)
	local var_1_5 = arg_1_0.viewComponent

	var_2.SetActivity(var_1_5, var_1_4)

	return
end

function var_0_1.listNotificationInterests(arg_3_0)
	local var_3_0 = {}

	ActivityProxy = var_1_10002
	var_3_0[1] = var_1_10002.ACTIVITY_UPDATED
	PlayerProxy = var_2
	var_3_0[2] = var_2.UPDATED

	return var_3_0
end

function var_0_1.handleNotification(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1
	local var_4_1 = arg_4_1.getName(var_4_0)
	local var_4_2 = arg_4_1
	local var_4_3 = arg_4_1.getBody(var_4_2)

	ActivityProxy = var_4_0

	local var_4_4

	if var_4_1 == var_4_0.ACTIVITY_UPDATED then
		var_4_4 = var_4_3:getConfig("type")
		ActivityConst = var_4_2

		if var_4_4 == var_4_2.ACTIVITY_TYPE_BOSS_BATTLE_MARK_2 then
			local var_4_5 = arg_4_0.viewComponent

			var_4_4.SetActivity(var_4_5, var_4_3)
		end
	else
		PlayerProxy = var_4_4

		if var_4_1 == var_4_4.UPDATED then
			local var_4_6 = arg_4_0.viewComponent

			var_4.UpdateContent(var_4_6)
		end
	end

	return
end

function var_0_1.remove(arg_5_0)
	return
end

return var_0_1
