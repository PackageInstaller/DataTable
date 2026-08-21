local var_0_0 = class("BattleGatePerform")

ys.Battle.BattleGatePerform = var_0_0
var_0_0.__name = "BattleGatePerform"

function var_0_0.Entrance(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_0.stageId
	local var_1_1 = ys.Battle.BattleDataFunction.GetDungeonTmpDataByID(pg.expedition_data_template[arg_1_0.stageId].dungeon_id).fleet_prefab or {}
	local var_1_2 = {}

	if arg_1_0.mainFleetId then
		if not arg_1_1.LegalFleet(arg_1_0.mainFleetId) then
			return
		end

		for iter_1_0, iter_1_1 in ipairs((getProxy(BayProxy):getSortShipsByFleet((getProxy(FleetProxy):getFleetById(arg_1_0.mainFleetId))))) do
			var_1_2[#var_1_2 + 1] = iter_1_1.id
		end
	end

	local var_1_3 = {
		stageId = arg_1_0.stageId,
		system = SYSTEM_PERFORM,
		memory = arg_1_0.memory,
		exitCallback = arg_1_0.exitCallback,
		prefabFleet = var_1_1,
		mainFleetId = arg_1_0.mainFleetId
	}

	if arg_1_0.memory then
		arg_1_1:sendNotification(GAME.BEGIN_STAGE_DONE, var_1_3)
	else
		BeginStageCommand.SendRequest(SYSTEM_PERFORM, var_1_2, {
			arg_1_0.stageId
		}, function(arg_2_0)
			arg_1_1:sendNotification(GAME.STORY_UPDATE, {
				storyId = tostring(var_1_0)
			})

			var_1_3.token = arg_2_0.key

			arg_1_1:sendNotification(GAME.BEGIN_STAGE_DONE, var_1_3)

			return
		end, function(arg_3_0)
			arg_1_1:RequestFailStandardProcess(arg_3_0)

			return
		end)
	end

	return
end

function var_0_0.Exit(arg_4_0, arg_4_1)
	if arg_4_0.memory then
		arg_4_1:sendNotification(GAME.FINISH_STAGE_DONE, {
			system = SYSTEM_PERFORM
		})
	else
		arg_4_1:SendRequest(arg_4_1.GeneralPackage(arg_4_0, {}), function(arg_5_0)
			print(arg_4_0.exitCallback)
			arg_4_1:sendNotification(GAME.FINISH_STAGE_DONE, {
				system = SYSTEM_PERFORM,
				exitCallback = arg_4_0.exitCallback
			})

			return
		end, function(arg_6_0)
			arg_4_1:RequestFailStandardProcess(arg_6_0)

			return
		end)
	end

	return
end

return var_0_0
