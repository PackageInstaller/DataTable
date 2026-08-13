class = var_0_10000

local var_0_0 = "ClueBuffSelectMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.ContextMediator"))

var_0_1.ON_FLEET_SELECT = "ClueBuffSelectMediator.ON_FLEET_SELECT"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.ON_FLEET_SELECT, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0.viewComponent

		var_2.ShowNormalFleet(var_2_0, arg_2_1)

		return
	end)

	local var_1_0 = arg_1_0.viewComponent

	var_1.SetStageID(var_1_0, arg_1_0.contextData.clueSingleEnemyID)

	PlayerPrefs = var_1

	local var_1_1 = var_1.GetString(arg_1_0.viewComponent.PLYAER_PREF_KEY .. arg_1_0.contextData.clueSingleEnemyID)
	local var_1_2 = {}

	if not var_1_1 or var_1_1 == "" then
		var_1_2 = nil
	else
		string = var_3

		for iter_1_0 in var_3.gmatch(var_1_1, "[^|]+") do
			table = var_1_10007
			var_1_10007 = var_1_10007.insert

			local var_1_3 = var_1_2

			tonumber = var_1_10009

			var_1_10007(var_1_3, var_1_10009(iter_1_0))
		end
	end

	local var_1_4 = arg_1_0.viewComponent
	local var_1_5 = var_3.SetPreSelectedBuff
	local var_1_6

	if not arg_1_0.contextData.preSelectedBuffList and not arg_1_0.contextData.selectedBuffList then
		var_1_6 = var_1_2 or {}
	end

	var_1_5(var_1_4, var_1_6)

	BossSingleBattleFleetSelectMediatorComponent = var_1_5

	local var_1_7 = var_1_5.AttachFleetSelect
	local var_1_8 = arg_1_0

	ActivityConst = var_1_6

	local var_1_9 = var_1_6.ACTIVITY_TYPE_BOSSSINGLE_VARIABLE

	SYSTEM_BOSS_SINGLE_VARIABLE = iter_1_0
	Fleet = var_1_10007

	var_1_7(var_1_8, var_1_9, iter_1_0, var_1_10007.MEGA_SUBMARINE_FLEET_OFFSET)

	return
end

function var_0_1.listNotificationInterests(arg_3_0)
	local var_3_0 = {}

	GAME = var_1_10002
	var_3_0[1] = var_1_10002.COMMANDER_ACTIVITY_FORMATION_OP_DONE

	return var_3_0
end

function var_0_1.handleNotification(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1:getName()
	local var_4_1 = arg_4_1
	local var_4_2 = arg_4_1.getBody(var_4_1)

	GAME = var_4_1

	if var_4_0 == var_4_1.COMMANDER_ACTIVITY_FORMATION_OP_DONE then
		local var_4_3 = arg_4_1
		local var_4_4 = arg_4_1.getBody(var_4_3)

		getProxy = var_4_3
		FleetProxy = var_1_10006

		local var_4_5 = var_4_3(var_1_10006)
		local var_4_6 = var_5.getActivityFleets(var_4_5)[var_4_4.actId]

		arg_4_0.contextData.actFleets = var_4_6

		local var_4_7 = arg_4_0.viewComponent

		var_6.updateEditPanel(var_4_7)

		local var_4_8 = arg_4_0.viewComponent

		var_6.updateCommanderFleet(var_4_8, var_4_6[var_4_4.fleetId])
	end

	return
end

return var_0_1
