local BattleGatePerform = class("BattleGatePerform")

ys.Battle.BattleGatePerform = BattleGatePerform
BattleGatePerform.__name = "BattleGatePerform"

function BattleGatePerform:Entrance(arg_1_1)
	local var_1_0 = self.stageId
	local var_1_1 = ys.Battle.BattleDataFunction.GetDungeonTmpDataByID(pg.expedition_data_template[self.stageId].dungeon_id).fleet_prefab or {}
	local var_1_2 = {}

	if self.mainFleetId then
		if not arg_1_1.LegalFleet(self.mainFleetId) then
			return
		end

		for iter_1_0, iter_1_1 in ipairs((getProxy(BayProxy):getSortShipsByFleet((getProxy(FleetProxy):getFleetById(self.mainFleetId))))) do
			var_1_2[#var_1_2 + 1] = iter_1_1.id
		end
	end

	local var_1_3 = {
		stageId = self.stageId,
		system = SYSTEM_PERFORM,
		memory = self.memory,
		exitCallback = self.exitCallback,
		prefabFleet = var_1_1,
		mainFleetId = self.mainFleetId
	}

	if self.memory then
		arg_1_1:sendNotification(GAME.BEGIN_STAGE_DONE, var_1_3)
	else
		BeginStageCommand.SendRequest(SYSTEM_PERFORM, var_1_2, {
			self.stageId
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

function BattleGatePerform:Exit(arg_4_1)
	if self.memory then
		arg_4_1:sendNotification(GAME.FINISH_STAGE_DONE, {
			system = SYSTEM_PERFORM
		})
	else
		arg_4_1:SendRequest(arg_4_1.GeneralPackage(self, {}), function(arg_5_0)
			print(self.exitCallback)
			arg_4_1:sendNotification(GAME.FINISH_STAGE_DONE, {
				system = SYSTEM_PERFORM,
				exitCallback = self.exitCallback
			})

			return
		end, function(arg_6_0)
			arg_4_1:RequestFailStandardProcess(arg_6_0)

			return
		end)
	end

	return
end

return BattleGatePerform
