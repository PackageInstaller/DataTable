local var_0_0 = class("ClueBuffSelectMediator", import("view.base.ContextMediator"))

var_0_0.ON_FLEET_SELECT = "ClueBuffSelectMediator.ON_FLEET_SELECT"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.ON_FLEET_SELECT, function(arg_2_0, arg_2_1)
		arg_1_0.viewComponent:ShowNormalFleet(arg_2_1)

		return
	end)
	arg_1_0.viewComponent:SetStageID(arg_1_0.contextData.clueSingleEnemyID)

	local var_1_0 = PlayerPrefs.GetString(arg_1_0.viewComponent.PLYAER_PREF_KEY .. arg_1_0.contextData.clueSingleEnemyID)
	local var_1_1 = {}

	if not var_1_0 or var_1_0 == "" then
		var_1_1 = nil
	else
		for iter_1_0 in string.gmatch(var_1_0, "[^|]+") do
			table.insert(var_1_1, tonumber(iter_1_0))
		end
	end

	local var_1_3 = arg_1_0.contextData.preSelectedBuffList or arg_1_0.contextData.selectedBuffList or var_1_1 or {}

	var_1_2(arg_1_0.viewComponent, var_1_3)
	BossSingleBattleFleetSelectMediatorComponent.AttachFleetSelect(arg_1_0, ActivityConst.ACTIVITY_TYPE_BOSSSINGLE_VARIABLE, SYSTEM_BOSS_SINGLE_VARIABLE, Fleet.MEGA_SUBMARINE_FLEET_OFFSET)

	return
end

function var_0_0.listNotificationInterests(arg_3_0)
	return {
		GAME.COMMANDER_ACTIVITY_FORMATION_OP_DONE
	}
end

function var_0_0.handleNotification(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1:getBody()

	if arg_4_1:getName() == GAME.COMMANDER_ACTIVITY_FORMATION_OP_DONE then
		local var_4_1 = arg_4_1:getBody()
		local var_4_2 = getProxy(FleetProxy):getActivityFleets()[var_4_1.actId]

		arg_4_0.contextData.actFleets = var_4_2

		arg_4_0.viewComponent:updateEditPanel()
		arg_4_0.viewComponent:updateCommanderFleet(var_4_2[var_4_1.fleetId])
	end

	return
end

return var_0_0
