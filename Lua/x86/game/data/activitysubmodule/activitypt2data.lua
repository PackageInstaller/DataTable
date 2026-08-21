local var_0_0 = singletonClass("ActivityPt2Data")
local var_0_1 = {}
local var_0_2 = {}
local var_0_3 = {}
local var_0_4 = {}
local var_0_5 = 0

function var_0_0.Init(arg_1_0)
	var_0_1 = {}
	var_0_2 = {}
	var_0_3 = {}
	var_0_4 = {}
end

function var_0_0.SetNormalData(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1.activity_id

	if not var_0_1[var_2_0] then
		var_0_1[var_2_0] = {}
	end

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.pt_challenge_info) do
		var_0_1[var_2_0][iter_2_1.id] = {
			id = iter_2_1.id,
			clear_time = iter_2_1.clear_time
		}
	end
end

function var_0_0.SetChallengeData(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1.activity_id

	if not var_0_2[var_3_0] then
		var_0_2[var_3_0] = {}
	end

	for iter_3_0, iter_3_1 in ipairs(arg_3_1.pt_challenge_info) do
		var_0_2[var_3_0][iter_3_1.id] = {
			id = iter_3_1.id,
			clear_time = iter_3_1.clear_time,
			use_time = iter_3_1.use_time
		}
	end
end

function var_0_0.SetHardData(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1.activity_id

	if not var_0_3[var_4_0] then
		var_0_3[var_4_0] = {}
	end

	for iter_4_0, iter_4_1 in ipairs(arg_4_1.pt_challenge_info) do
		var_0_3[var_4_0] = {
			id = iter_4_1.id,
			clear_time = iter_4_1.clear_time,
			score = iter_4_1.score
		}
	end
end

function var_0_0.SetHardScore(arg_5_0, arg_5_1)
	var_0_5 = arg_5_1.score
end

function var_0_0.GetHardScore(arg_6_0)
	return var_0_5
end

function var_0_0.SetLastStage(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	var_0_4[arg_7_1] = {
		type = arg_7_2,
		index = arg_7_3
	}
end

function var_0_0.GetLastStage(arg_8_0, arg_8_1)
	return var_0_4[arg_8_1]
end

function var_0_0.GetExScore(arg_9_0, arg_9_1)
	return var_0_3[arg_9_1] and var_0_3[arg_9_1].score or 0
end

function var_0_0.GetNormalData(arg_10_0, arg_10_1, arg_10_2)
	return var_0_1[arg_10_1] and var_0_1[arg_10_1][arg_10_2]
end

function var_0_0.GetChallengeData(arg_11_0, arg_11_1, arg_11_2)
	return var_0_2[arg_11_1] and var_0_2[arg_11_1][arg_11_2]
end

function var_0_0.GetNormalDataList(arg_12_0, arg_12_1)
	return var_0_1[arg_12_1]
end

function var_0_0.GetChallengeDataList(arg_13_0, arg_13_1)
	return var_0_2[arg_13_1]
end

function var_0_0.GetHardData(arg_14_0, arg_14_1)
	return var_0_3[arg_14_1]
end

return var_0_0
