class = var_0_10000

local var_0_0 = "WorldBossInformationMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.ContextMediator"))

var_0_1.RETREAT_FLEET = "WorldBossInformationMediator:RETREAT_FLEET"
var_0_1.OnOpenSublayer = "WorldBossInformationMediator:OpenSublayer"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.RETREAT_FLEET, function()
		local var_2_0 = arg_1_0
		local var_2_1 = var_0.sendNotification

		GAME = var_2_10002

		var_2_1(var_2_0, var_2_10002.WORLD_RETREAT_FLEET)

		return
	end)
	arg_1_0:bind(var_0_1.OnOpenSublayer, function(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
		local var_3_0 = arg_1_0

		var_4.addSubLayers(var_3_0, arg_3_1, arg_3_2, arg_3_3)

		return
	end)

	local var_1_0 = arg_1_0.viewComponent
	local var_1_1 = var_1.setPlayerInfo

	getProxy = var_3
	PlayerProxy = var_4

	local var_1_2 = var_3(var_4)

	var_1_1(var_1_0, var_3.getRawData(var_1_2))

	return
end

function var_0_1.listNotificationInterests(arg_4_0)
	local var_4_0 = {}

	PlayerProxy = var_1_10002
	var_4_0[1] = var_1_10002.UPDATED
	GAME = var_2
	var_4_0[2] = var_2.WORLD_MAP_OP_DONE
	GAME = var_2
	var_4_0[3] = var_2.BEGIN_STAGE_DONE

	return var_4_0
end

function var_0_1.handleNotification(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1:getName()
	local var_5_1 = arg_5_1
	local var_5_2 = arg_5_1.getBody(var_5_1)

	PlayerProxy = var_5_1

	local var_5_4

	if var_5_0 == var_5_1.UPDATED then
		local var_5_3 = arg_5_0.viewComponent

		var_5_4 = var_5_4.setPlayerInfo
		getProxy = var_1_10006
		PlayerProxy = var_1_10007
		var_1_10007 = var_1_10006(var_1_10007)

		var_5_4(var_5_3, var_1_10006.getRawData(var_1_10007))
	else
		GAME = var_5_4

		if var_5_0 == var_5_4.WORLD_MAP_OP_DONE then
			-- block empty
		else
			GAME = var_4

			if var_5_0 == var_4.BEGIN_STAGE_DONE then
				local var_5_5 = arg_5_0
				local var_5_6 = arg_5_0.sendNotification

				GAME = var_1_10006

				local var_5_7 = var_1_10006.GO_SCENE

				SCENE = var_1_10007

				var_5_6(var_5_5, var_5_7, var_1_10007.COMBATLOAD, var_5_2)
			end
		end
	end

	return
end

return var_0_1
