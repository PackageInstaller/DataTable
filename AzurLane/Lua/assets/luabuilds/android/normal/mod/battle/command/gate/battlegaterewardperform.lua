class = var_0_10000

local var_0_0 = var_0_10000("BattleGateRewardPerform")

ys = var_1
var_1.Battle.BattleGateRewardPerform = var_0_0
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

	GAME = var_1_10009

	var_1_6(var_1_5, var_1_10009.BEGIN_STAGE_DONE, var_1_4)

	return
end

function var_0_0.Exit(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0
	local var_2_1

	if arg_2_0.actId then
		var_2_1 = var_2_0.statistics._battleScore
		ys = var_1_10004
		var_2_1 = var_1_10004.Battle.BattleConst.BattleScore.C < var_2_1

		if var_2_1 then
			var_1_10005 = arg_2_1
			var_1_10004 = arg_2_1.sendNotification
			GAME = var_1_10006

			var_1_10004(var_1_10005, var_1_10006.ACTIVITY_OPERATION, {
				cmd = 2,
				activity_id = arg_2_0.actId,
				statistics = var_2_0.statistics,
				arg1 = var_2_0.stageId
			})
		else
			var_1_10005 = arg_2_1
			var_1_10004 = arg_2_1.sendNotification
			GAME = var_1_10006

			local var_2_2 = var_1_10006.FINISH_STAGE_DONE
			local var_2_3 = {
				statistics = arg_2_0.statistics,
				score = arg_2_0.statistics._battleScore
			}

			SYSTEM_REWARD_PERFORM = var_8
			var_2_3.system = var_8

			var_1_10004(var_1_10005, var_2_2, var_2_3)
		end
	else
		getProxy = var_2_1
		ActivityProxy = var_1_10004

		local var_2_4 = var_2_1(var_1_10004)
		local var_2_5 = var_3.getActivityByType

		ActivityConst = var_1_10005

		local var_2_6 = var_2_5(var_2_4, var_1_10005.ACTIVITY_TYPE_EXPEDITION).data1_list
		local var_2_7

		for iter_2_0 = 1, #var_2_6 do
			bit = var_1_10010

			if var_1_10010.rshift(var_2_6[iter_2_0], 4) == var_2_0.stageId then
				var_2_7 = iter_2_0

				break
			end
		end

		local var_2_8 = arg_2_1
		local var_2_9 = arg_2_1.sendNotification

		GAME = var_8

		var_2_9(var_2_8, var_8.ACTIVITY_OPERATION, {
			cmd = 3,
			activity_id = var_3 and var_3.id,
			statistics = var_2_0.statistics,
			arg1 = var_2_0.statistics._battleScore,
			arg2 = var_2_7
		})
	end

	return
end

return var_0_0
