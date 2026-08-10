require("game.data.SPHeroChallengeDataTemplate")

local var_0_0 = singletonClass("TugGameData")

function var_0_0.Init(arg_1_0)
	arg_1_0.activityID = 0
	arg_1_0.activityData = {}
	arg_1_0.isInitRed = false
end

function var_0_0.InitTugData(arg_2_0, arg_2_1)
	if not arg_2_0.activityData[arg_2_1.activity_id] then
		arg_2_0.activityData[arg_2_1.activity_id] = {}
	end

	local var_2_0 = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.mission_list) do
		var_2_0[iter_2_1.id] = iter_2_1
	end

	arg_2_0.activityData[arg_2_1.activity_id] = {
		mission_list = arg_2_1.mission_list,
		activity_id = arg_2_1.activity_id,
		pointData = var_2_0
	}

	arg_2_0:UpdateRedPoint(arg_2_1.activity_id)
end

function var_0_0.UpdateStage(arg_3_0, arg_3_1)
	if arg_3_0.activityData[arg_3_1.activity_id] then
		arg_3_0.activityData[arg_3_1.activity_id].pointData[arg_3_1.stage_id] = {
			times = 1,
			id = arg_3_1.stage_id
		}
	end

	arg_3_0:UpdateRedPoint(arg_3_1.activity_id)
end

function var_0_0.GetActivityData(arg_4_0, arg_4_1)
	return arg_4_0.activityData[arg_4_1]
end

function var_0_0.GetStageData(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0:GetActivityData(arg_5_1)

	if var_5_0 then
		for iter_5_0, iter_5_1 in pairs(var_5_0.pointData) do
			if iter_5_1.id == arg_5_2 then
				return iter_5_1
			end
		end
	end

	return nil
end

function var_0_0.UpdateRedPoint(arg_6_0, arg_6_1)
	local var_6_0 = ActivityKaliGameStageCfg.all
	local var_6_1 = ActivityCfg.get_id_list_by_sub_activity_list[arg_6_1] and ActivityCfg.get_id_list_by_sub_activity_list[arg_6_1][1] or 0

	if var_6_1 ~= 0 then
		local var_6_2 = {}

		for iter_6_0, iter_6_1 in ipairs(var_6_0) do
			local var_6_3 = string.format("%s_%s", RedPointConst.ACTIVITY_KALI_GAME_TUG, iter_6_1)
			local var_6_4 = TugGameData:GetStageData(arg_6_1, iter_6_1)
			local var_6_5 = var_6_4 and var_6_4.times > 0 or false
			local var_6_6 = ActivityKaliGameStageCfg[iter_6_1]
			local var_6_7 = ActivityData:GetActivityIsOpen(var_6_6.activity_id)
			local var_6_8 = var_6_6.pre_stage
			local var_6_9 = TugGameData:GetStageData(arg_6_1, var_6_8)
			local var_6_10 = var_6_8 == 0 and true or var_6_9 and var_6_9.times > 0 or false

			table.insert(var_6_2, var_6_3)
			manager.redPoint:setTip(var_6_3, not var_6_5 and var_6_7 and var_6_10 and 1 or 0)
		end

		local var_6_11 = ActivityTools.GetRedPointKey(arg_6_1) .. arg_6_1
		local var_6_12 = ActivityTools.GetRedPointKey(var_6_1) .. var_6_1

		if not arg_6_0.isInitRed then
			manager.redPoint:addGroup(var_6_11, var_6_2)
			manager.redPoint:addGroup(var_6_12, {
				var_6_11
			})
		end
	end

	arg_6_0.isInitRed = true
end

return var_0_0
