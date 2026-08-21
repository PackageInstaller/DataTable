local var_0_0 = class("BattleGateRewardPerform")

ys.Battle.BattleGateRewardPerform = var_0_0
var_0_0.__name = "BattleGateRewardPerform"

function var_0_0.Entrance(arg_1_0, arg_1_1)
	local var_1_0 = ys.Battle.BattleDataFunction.GetDungeonTmpDataByID(pg.expedition_data_template[arg_1_0.stageId].dungeon_id).fleet_prefab
	local var_1_1

	if not var_1_0 or #var_1_0 == 0 then
		var_1_1 = arg_1_0.mainFleetId
	end

	arg_1_1:sendNotification(GAME.BEGIN_STAGE_DONE, {
		mainFleetId = var_1_1,
		prefabFleet = var_1_0,
		stageId = arg_1_0.stageId,
		system = SYSTEM_REWARD_PERFORM,
		actId = arg_1_0.actId
	})

	return
end

function var_0_0.Exit(arg_2_0, arg_2_1)
	if arg_2_0.actId then
		if arg_2_0.statistics._battleScore > ys.Battle.BattleConst.BattleScore.C then
			arg_2_1:sendNotification(GAME.ACTIVITY_OPERATION, {
				cmd = 2,
				activity_id = arg_2_0.actId,
				statistics = arg_2_0.statistics,
				arg1 = arg_2_0.stageId
			})
		else
			arg_2_1:sendNotification(GAME.FINISH_STAGE_DONE, {
				statistics = arg_2_0.statistics,
				score = arg_2_0.statistics._battleScore,
				system = SYSTEM_REWARD_PERFORM
			})
		end
	else
		local var_2_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_EXPEDITION)
		local var_2_1

		for iter_2_0 = 1, #var_2_0.data1_list do
			if bit.rshift(var_2_0.data1_list[iter_2_0], 4) == arg_2_0.stageId then
				var_2_1 = iter_2_0

				break
			end
		end

		arg_2_1:sendNotification(GAME.ACTIVITY_OPERATION, {
			cmd = 3,
			activity_id = var_2_0 and var_2_0.id,
			statistics = arg_2_0.statistics,
			arg1 = arg_2_0.statistics._battleScore,
			arg2 = var_2_1
		})
	end

	return
end

return var_0_0
