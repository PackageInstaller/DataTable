class = var_0_10000

local var_0_0 = "BossRushCMDFormationMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.ContextMediator"))

function var_0_1.register(arg_1_0)
	getProxy = var_1_10001
	CommanderProxy = var_1_10002

	local var_1_0 = var_1_10001(var_1_10002)
	local var_1_1 = var_1.getPrefabFleet(var_1_0)
	local var_1_2 = arg_1_0.viewComponent

	var_2.updateFleet(var_1_2, arg_1_0.contextData.fleet)

	local var_1_3 = arg_1_0.viewComponent

	var_2.setCommanderPrefabs(var_1_3, var_1_1)

	local var_1_4 = arg_1_0.viewComponent

	var_2.setCallback(var_1_4, arg_1_0.contextData.callback)

	return
end

function var_0_1.listNotificationInterests(arg_2_0)
	local var_2_0 = {}

	CommanderProxy = var_1_10002
	var_2_0[1] = var_1_10002.PREFAB_FLEET_UPDATE
	GAME = var_2
	var_2_0[2] = var_2.COMMANDER_ACTIVITY_FORMATION_OP_DONE

	return var_2_0
end

function var_0_1.handleNotification(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1:getName()
	local var_3_1 = arg_3_1
	local var_3_2 = arg_3_1.getBody(var_3_1)

	if var_3_0 == nil then
		-- block empty
	else
		CommanderProxy = var_3_1

		local var_3_4

		if var_3_0 == var_3_1.PREFAB_FLEET_UPDATE then
			getProxy = var_3_4
			CommanderProxy = var_1_10005

			local var_3_3 = var_3_4(var_1_10005)

			var_3_4 = var_3_4.getPrefabFleet(var_3_3)

			local var_3_5 = arg_3_0.viewComponent

			var_5.setCommanderPrefabs(var_3_5, var_3_4)
		else
			GAME = var_3_4

			if var_3_0 == var_3_4.COMMANDER_ACTIVITY_FORMATION_OP_DONE then
				local var_3_6 = arg_3_0.viewComponent

				var_4.updateRecordFleet(var_3_6)

				local var_3_7 = arg_3_0.viewComponent

				var_4.updateDesc(var_3_7)

				local var_3_8 = arg_3_0.viewComponent

				var_4.updateRecordPanel(var_3_8)
			end
		end
	end

	return
end

function var_0_1.remove(arg_4_0)
	return
end

return var_0_1
