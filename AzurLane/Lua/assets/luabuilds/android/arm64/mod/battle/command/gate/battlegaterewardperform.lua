class = var_0_10000

local var_0_0 = var_0_10000("BattleGateRewardPerform")

ys = var_0_10001
var_0_10001.Battle.BattleGateRewardPerform = var_0_0
var_0_0.__name = "BattleGateRewardPerform"

function var_0_0.Entrance(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_0.stageId

	pg = var_1_10003

	local var_1_1 = var_1_10003.expedition_data_template[var_1_0].dungeon_id

	ys = var_1_10004

	local var_1_2 = var_1_10004.Battle.BattleDataFunction.GetDungeonTmpDataByID(var_1_1).fleet_prefab
	local var_1_3

	if not var_1_2 or #var_1_2 == 0 then
		var_1_3 = arg_1_0.mainFleetId
	end

	local var_1_4 = {
		mainFleetId = var_1_3,
		prefabFleet = var_1_2,
		stageId = var_1_0
	}

	SYSTEM_REWARD_PERFORM = var_1_10007
	var_1_4.system = var_1_10007
	var_1_4.actId = arg_1_0.actId

	local var_1_5 = arg_1_1
	local var_1_6 = arg_1_1.sendNotification

	GAME = var_1_10010

	var_1_6(var_1_5, var_1_10010.BEGIN_STAGE_DONE, var_1_4)

	return
end

function var_0_0.Exit(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0
	local var_2_1

	if arg_2_0.actId then
		var_2_1 = var_2_0.statistics._battleScore
		ys = var_1_10004
		var_2_1 = var_2_1 > var_1_10004.Battle.BattleConst.BattleScore.C

		if var_2_1 then
			var_1_10006 = arg_2_1

			local var_2_2 = arg_2_1.sendNotification

			GAME = var_1_10007

			var_2_2(var_1_10006, var_1_10007.ACTIVITY_OPERATION, {
				cmd = 2,
				activity_id = arg_2_0.actId,
				statistics = var_2_0.statistics,
				arg1 = var_2_0.stageId
			})
		else
			var_1_10006 = arg_2_1

			local var_2_3 = arg_2_1.sendNotification

			GAME = var_1_10007

			local var_2_4 = var_1_10007.FINISH_STAGE_DONE
			local var_2_5 = {
				statistics = arg_2_0.statistics,
				score = arg_2_0.statistics._battleScore
			}

			SYSTEM_REWARD_PERFORM = var_9
			var_2_5.system = var_9

			var_2_3(var_1_10006, var_2_4, var_2_5)
		end
	else
		getProxy = var_2_1
		ActivityProxy = var_1_10005

		local var_2_6 = var_2_1(var_1_10005)
		local var_2_7 = var_3.getActivityByType

		ActivityConst = var_1_10006

		local var_2_8 = var_2_7(var_2_6, var_1_10006.ACTIVITY_TYPE_EXPEDITION).data1_list
		local var_2_9

		for iter_2_0 = 1, #var_2_8 do
			bit = var_1_10010

			if var_1_10010.rshift(var_2_8[iter_2_0], 4) == var_2_0.stageId then
				var_2_9 = iter_2_0

				break
			end
		end

		local var_2_10 = arg_2_1
		local var_2_11 = arg_2_1.sendNotification

		GAME = iter_2_0

		var_2_11(var_2_10, iter_2_0.ACTIVITY_OPERATION, {
			cmd = 3,
			activity_id = var_3 and var_3.id,
			statistics = var_2_0.statistics,
			arg1 = var_2_0.statistics._battleScore,
			arg2 = var_2_9
		})
	end

	return
end

return var_0_0
