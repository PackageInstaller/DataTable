local BattleGateTest = class("BattleGateTest")

ys.Battle.BattleGateTest = BattleGateTest
BattleGateTest.__name = "BattleGateTest"

function BattleGateTest:Entrance(arg_1_1)
	if not arg_1_1.LegalFleet(self.mainFleetId) then
		return
	end

	local var_1_0 = {}

	for iter_1_0, iter_1_1 in ipairs((getProxy(BayProxy):getSortShipsByFleet((getProxy(FleetProxy):getFleetById(self.mainFleetId))))) do
		var_1_0[#var_1_0 + 1] = iter_1_1.id
	end

	local var_1_1 = self.mainFleetId
	local var_1_2 = self.stageId

	BeginStageCommand.SendRequest(SYSTEM_TEST, var_1_0, {
		self.stageId
	}, function(arg_2_0)
		arg_1_1:sendNotification(GAME.BEGIN_STAGE_DONE, {
			mainFleetId = var_1_1,
			prefabFleet = {},
			stageId = var_1_2,
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

function BattleGateTest:Exit(arg_4_1)
	local var_4_1 = self.statistics._battleScore

	arg_4_1:SendRequest(arg_4_1.GeneralPackage(self, (getProxy(BayProxy):getSortShipsByFleet((getProxy(FleetProxy):getFleetById(self.mainFleetId))))), function(arg_5_0)
		self.statistics.mvpShipID = -1

		arg_4_1:sendNotification(GAME.FINISH_STAGE_DONE, {
			system = SYSTEM_TEST,
			statistics = self.statistics,
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

return BattleGateTest
