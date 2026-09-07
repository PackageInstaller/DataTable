local BattleGateRewardPerform = class("BattleGateRewardPerform")

ys.Battle.BattleGateRewardPerform = BattleGateRewardPerform
BattleGateRewardPerform.__name = "BattleGateRewardPerform"

function BattleGateRewardPerform:Entrance(arg_1_1)
	local var_1_0 = ys.Battle.BattleDataFunction.GetDungeonTmpDataByID(pg.expedition_data_template[self.stageId].dungeon_id).fleet_prefab

	arg_1_1:sendNotification(GAME.BEGIN_STAGE_DONE, {
		mainFleetId = (not var_1_0 or #var_1_0 == 0 or nil) and self.mainFleetId,
		prefabFleet = var_1_0,
		stageId = self.stageId,
		system = SYSTEM_REWARD_PERFORM,
		actId = self.actId
	})

	return
end

function BattleGateRewardPerform:Exit(arg_2_1)
	if self.actId then
		if self.statistics._battleScore > ys.Battle.BattleConst.BattleScore.C then
			arg_2_1:sendNotification(GAME.ACTIVITY_OPERATION, {
				cmd = 2,
				activity_id = self.actId,
				statistics = self.statistics,
				arg1 = self.stageId
			})
		else
			arg_2_1:sendNotification(GAME.FINISH_STAGE_DONE, {
				statistics = self.statistics,
				score = self.statistics._battleScore,
				system = SYSTEM_REWARD_PERFORM
			})
		end
	else
		local var_2_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_EXPEDITION)
		local var_2_1

		for iter_2_0 = 1, #var_2_0.data1_list do
			if bit.rshift(var_2_0.data1_list[iter_2_0], 4) == self.stageId then
				var_2_1 = iter_2_0

				break
			end
		end

		arg_2_1:sendNotification(GAME.ACTIVITY_OPERATION, {
			cmd = 3,
			activity_id = var_2_0 and var_2_0.id,
			statistics = self.statistics,
			arg1 = self.statistics._battleScore,
			arg2 = var_2_1
		})
	end

	return
end

return BattleGateRewardPerform
