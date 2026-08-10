local var_0_0 = singletonClass("CombineGameData")
local var_0_1 = {}

function var_0_0.Init(arg_1_0)
	var_0_1:Init()
end

function var_0_0.GetDataByPara(arg_2_0, arg_2_1)
	return var_0_1[arg_2_1]
end

function var_0_0.InitServerData(arg_3_0, arg_3_1)
	var_0_1:InitServerData(arg_3_1)
end

function var_0_0.UpdateStageData(arg_4_0, arg_4_1)
	var_0_1:UpdateStageData(arg_4_1)
end

function var_0_0.CheckHeroLock(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = ActivityCombineHeroCfg[arg_5_2]

	return var_0_1.nowDay - 3 >= var_5_0.unlock_condition[1][2] and arg_5_1 == var_5_0.unlock_condition[1][1]
end

function var_0_1.Init(arg_6_0)
	arg_6_0.stageDataTable = {}
end

function var_0_1.InitServerData(arg_7_0, arg_7_1)
	arg_7_0.activityId = arg_7_1.activity_id
	arg_7_0.nowDay = arg_7_1.daily_stage

	if arg_7_1.score_of_endless then
		arg_7_0.score = arg_7_1.score_of_endless
	end

	for iter_7_0, iter_7_1 in ipairs(arg_7_1.reward_list) do
		arg_7_0.stageDataTable[iter_7_1] = true
	end
end

function var_0_1.UpdateStageData(arg_8_0, arg_8_1)
	if arg_8_1.score then
		arg_8_0.score = math.max(arg_8_1.score, arg_8_0.score or 0)
	end

	arg_8_0.stageDataTable[arg_8_1.reward_id] = true
end

return var_0_0
