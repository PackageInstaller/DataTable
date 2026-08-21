local var_0_0 = class("BattleGateTest")

ys.Battle.BattleGateTest = var_0_0
var_0_0.__name = "BattleGateTest"

function var_0_0.Entrance(arg_1_0, arg_1_1)
	if not arg_1_1.LegalFleet(arg_1_0.mainFleetId) then
		return
	end

	local var_1_0 = getProxy(BayProxy)

	for iter_1_0, iter_1_1 in ipairs((var_1_0:getSortShipsByFleet((getProxy(FleetProxy):getFleetById(arg_1_0.mainFleetId))))) do
		({})[#{} + 1] = iter_1_1.id
	end

	local var_1_1 = arg_1_0.mainFleetId

	BeginStageCommand.SendRequest(SYSTEM_TEST, {}, {
		arg_1_0.stageId
	}, function(arg_2_0)
		arg_1_1:sendNotification(GAME.BEGIN_STAGE_DONE, {
			mainFleetId = var_1_1,
			prefabFleet = {},
			stageId = var_0,
			system = SYSTEM_TEST,
			token = arg_2_0.key
		})

		return
	end, function(arg_3_0)
		arg_1_1:RequestFailStandardProcess(arg_3_0)

		return
	end)

	return
end

function var_0_0.Exit(arg_4_0, arg_4_1)
	local var_4_1 = arg_4_0.statistics._battleScore

	arg_4_1:SendRequest(arg_4_1.GeneralPackage(arg_4_0, (getProxy(BayProxy):getSortShipsByFleet((getProxy(FleetProxy):getFleetById(arg_4_0.mainFleetId))))), function(arg_5_0)
		arg_4_0.statistics.mvpShipID = -1

		arg_4_1:sendNotification(GAME.FINISH_STAGE_DONE, {
			system = SYSTEM_TEST,
			statistics = arg_4_0.statistics,
			score = var_4_1,
			drops = {},
			commanderExps = {},
			result = arg_5_0.result,
			extraDrops = {}
		})

		return
	end)

	return
end

return var_0_0
