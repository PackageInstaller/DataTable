class = var_0_10000

local var_0_0 = "NewEducateRound"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("model.vo.BaseVO"))

var_0_1.TYPE = {
	NORMAL = 1,
	ENDLESS = 2
}

function var_0_1.bindConfigTable(arg_1_0)
	pg = var_1_10001

	return var_1_10001.child2_round
end

function var_0_1.Ctor(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1.id

	arg_2_0.difficulty = arg_2_1.difficulty

	arg_2_0:InitConfig(var_2_0)
	arg_2_0:InitEndlessConfig(var_2_0)

	arg_2_0.round = arg_2_1.round.round
	arg_2_0.isTemp = var_3.in_temp == 1
	arg_2_0.tempCnt = var_3.temp_round

	arg_2_0:InitRoundId()

	arg_2_0.isEndlessFail = arg_2_1.eval_fail == 1

	return
end

function var_0_1.InitConfig(arg_3_0, arg_3_1)
	arg_3_0.round2Id = {}
	arg_3_0.assessRoundIds = {}
	arg_3_0.talentRoundIds = {}
	ipairs = var_2
	pg = var_1_10004

	for iter_3_0, iter_3_1 in var_2(var_1_10004.child2_round.get_id_list_by_character[arg_3_1]) do
		pg = var_1_10007

		if var_1_10007.child2_round[iter_3_1].round_type == var_0_1.TYPE.NORMAL and arg_3_0.difficulty == var_1_10007.is_hard_mode then
			arg_3_0.round2Id[var_1_10007.round] = iter_3_1

			if var_1_10007.target_id ~= 0 then
				table = var_8

				var_8.insert(arg_3_0.assessRoundIds, var_1_10007.round)
			end

			if var_1_10007.benefit_select ~= "" and #var_1_10007.benefit_select ~= 0 then
				table = var_8

				var_8.insert(arg_3_0.talentRoundIds, var_1_10007.round)
			end
		end
	end

	table = var_2

	var_2.sort(arg_3_0.assessRoundIds)

	table = var_2

	var_2.sort(arg_3_0.talentRoundIds)

	underscore = var_2
	arg_3_0.gameRoundCnt = #var_2.keys(arg_3_0.round2Id)

	return
end

function var_0_1.InitRoundId(arg_4_0)
	if arg_4_0:IsEndless() then
		arg_4_0:InitEndlessRoundId()
	else
		arg_4_0.id = arg_4_0.round2Id[arg_4_0.round]
		arg_4_0.configId = arg_4_0.id
	end

	return
end

function var_0_1.GetTalentRoundIds(arg_5_0)
	return arg_5_0.talentRoundIds
end

function var_0_1.IsTalentRound(arg_6_0)
	local var_6_0

	if not arg_6_0:IsTemp() then
		table = var_1
		var_6_0 = var_1.contains(arg_6_0.talentRoundIds, arg_6_0.round)
	else
		var_6_0 = false
	end

	if false then
		var_6_0 = true
	end

	return var_6_0
end

function var_0_1.IsShowAssessTip(arg_7_0)
	if arg_7_0.round == 1 then
		return true
	end

	ipairs = var_1

	for iter_7_0, iter_7_1 in var_1(arg_7_0.assessRoundIds) do
		if arg_7_0.round == iter_7_1 + 1 then
			return true
		end
	end

	return false
end

function var_0_1.GetProgressInfo(arg_8_0)
	underscore = var_1_10001

	local var_8_0 = var_1_10001.detect(arg_8_0.assessRoundIds, function(arg_9_0)
		return arg_9_0 >= arg_8_0.round
	end)

	pg = var_1_10002

	local var_8_1 = var_1_10002.child2_round[arg_8_0.round2Id[var_8_0]].target_id
	local var_8_2 = arg_8_0.round
	local var_8_3 = var_8_0 - arg_8_0.round

	pg = var_1_10005

	return var_8_2, var_8_3, var_1_10005.child2_target[var_8_1].attr_sum
end

function var_0_1.GetGameRoundCnt(arg_10_0)
	return arg_10_0.gameRoundCnt
end

function var_0_1.IsEndRound(arg_11_0)
	return not arg_11_0.round2Id[arg_11_0.round + 1]
end

function var_0_1.OnNextRound(arg_12_0)
	if arg_12_0.tempCnt > 0 then
		arg_12_0.tempCnt = arg_12_0.tempCnt - 1
		arg_12_0.isTemp = true
	else
		arg_12_0.isTemp = false
		arg_12_0.round = arg_12_0.round + 1
	end

	arg_12_0:InitRoundId()

	return
end

function var_0_1.IsTemp(arg_13_0)
	return arg_13_0.isTemp
end

function var_0_1.NextIsTemp(arg_14_0)
	return arg_14_0.tempCnt > 0
end

function var_0_1.AddTempCnt(arg_15_0, arg_15_1)
	arg_15_0.tempCnt = arg_15_0.tempCnt + arg_15_1

	return
end

function var_0_1.ExistEndless(arg_16_0)
	return #arg_16_0.cycleIds > 0
end

function var_0_1.InitEndlessConfig(arg_17_0, arg_17_1)
	arg_17_0.cycleIds = {}
	ipairs = var_2
	pg = var_1_10004

	for iter_17_0, iter_17_1 in var_2(var_1_10004.child2_round.get_id_list_by_character[arg_17_1]) do
		pg = var_1_10007

		if var_1_10007.child2_round[iter_17_1].round_type == var_0_1.TYPE.ENDLESS and arg_17_0.difficulty == var_1_10007.is_hard_mode then
			table = var_8

			var_8.insert(arg_17_0.cycleIds, iter_17_1)
		end
	end

	table = var_2

	var_2.sort(arg_17_0.cycleIds)

	arg_17_0.endlessRoundCnt = #arg_17_0.cycleIds

	return
end

function var_0_1.InitEndlessRoundId(arg_18_0)
	local var_18_0 = arg_18_0.round - arg_18_0.gameRoundCnt

	math = var_2
	arg_18_0.cycleCnt = 1 + var_2.floor(var_18_0 / arg_18_0.endlessRoundCnt)
	arg_18_0.cycleIdx = var_18_0 % arg_18_0.endlessRoundCnt

	if arg_18_0.cycleIdx == 0 then
		arg_18_0.cycleIdx = #arg_18_0.cycleIds
	end

	arg_18_0.id = arg_18_0.cycleIds[arg_18_0.cycleIdx]
	arg_18_0.configId = arg_18_0.id

	return
end

function var_0_1.IsEndless(arg_19_0)
	return arg_19_0.round > arg_19_0.gameRoundCnt
end

function var_0_1.GetWave(arg_20_0)
	return arg_20_0.round - arg_20_0.gameRoundCnt
end

function var_0_1.IsEndlessFail(arg_21_0)
	local var_21_0

	if arg_21_0:IsEndless() then
		var_21_0 = arg_21_0.isEndlessFail
	end

	return var_21_0
end

function var_0_1.SetEndlessFail(arg_22_0)
	arg_22_0.isEndlessFail = true

	return
end

function var_0_1.GetHeighestWave(arg_23_0)
	getProxy = var_1_10001
	NewEducateProxy = var_1_10003

	local var_23_0 = var_1_10001(var_1_10003)
	local var_23_1 = var_1.GetCurChar(var_23_0)
	local var_23_2 = var_1.GetPermanentData(var_23_1)

	return var_1.GetMaxRound(var_23_2) - arg_23_0.gameRoundCnt
end

function var_0_1.GetExtraFactor(arg_24_0)
	if not arg_24_0:IsEndless() then
		return 1
	end

	local var_24_0 = arg_24_0
	local var_24_1 = arg_24_0.getConfig(var_24_0, "endless_factor")
	local var_24_2 = arg_24_0.difficulty

	NewEducateChar = var_24_0

	local var_24_3 = var_24_2 == var_24_0.DIFFICULTY.EASY and "child2_endless_loop_extra_factor" or "child2_endless_loop_extra_factor_hard"

	pg = var_3

	local var_24_4 = var_3.gameset[var_24_3].description

	ipairs = var_4

	for iter_24_0, iter_24_1 in var_4(var_24_4) do
		if arg_24_0.round >= iter_24_1[1] and arg_24_0.round <= iter_24_1[2] then
			local var_24_5 = iter_24_1[3]

			tonumber = var_10

			local var_24_6

			if not var_10(var_24_1) then
				var_24_6 = 1
			end

			return var_24_5 * var_24_6
		end
	end

	local var_24_7 = var_24_4[#var_24_4][3]

	tonumber = var_5

	local var_24_8

	if not var_5(var_24_1) then
		var_24_8 = 1
	end

	return var_24_7 * var_24_8
end

function var_0_1.GetEndlessProgressInfos(arg_25_0)
	pg = var_1_10001

	local var_25_0 = var_1_10001.child2_target[arg_25_0:getConfig("target_id")].attr_sum * arg_25_0:GetExtraFactor()

	return arg_25_0:GetWave(), var_2 > arg_25_0:GetHeighestWave(), var_25_0
end

return var_0_1
