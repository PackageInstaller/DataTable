class = var_0_10000

local var_0_0 = "MallLevel"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("model.vo.BaseVO"))

var_0_1.CONDITION_TYPE = {
	ROUND = 1,
	ROUND_INCOME = 2,
	FLOOR_INCOME = 4,
	ORDER = 3
}

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.level = arg_1_1

	arg_1_0:InitLevelConfig()

	math = var_2
	arg_1_0.level = var_2.min(arg_1_0.level, arg_1_0.maxLevel)
	arg_1_0.id = arg_1_0.level2Id[arg_1_0.level]
	arg_1_0.configId = arg_1_0.id

	return
end

function var_0_1.bindConfigTable(arg_2_0)
	pg = var_1_10001

	return var_1_10001.activity_mall_level
end

function var_0_1.InitLevelConfig(arg_3_0)
	arg_3_0.level2Id = {}
	arg_3_0.maxLevel = 0
	ipairs = var_1
	pg = var_1_10002

	for iter_3_0, iter_3_1 in var_1(var_1_10002.activity_mall_level.all) do
		pg = var_1_10006
		var_1_10006 = var_1_10006.activity_mall_level[iter_3_1]

		local var_3_0 = arg_3_0.level2Id

		var_3_0[var_1_10006.lv] = iter_3_1
		math = var_3_0
		arg_3_0.maxLevel = var_3_0.max(arg_3_0.maxLevel, var_1_10006.lv)
	end

	return
end

function var_0_1.IsMaxLevel(arg_4_0)
	return arg_4_0.level == arg_4_0.maxLevel
end

function var_0_1.OnUpgradeDone(arg_5_0, arg_5_1)
	math = var_1_10002
	arg_5_0.level = var_1_10002.min(arg_5_1, arg_5_0.maxLevel)
	arg_5_0.id = arg_5_0.level2Id[arg_5_0.level]
	arg_5_0.configId = arg_5_0.id

	return
end

function var_0_1.GetReachLevelIds(arg_6_0, arg_6_1)
	local var_6_0 = {}

	for iter_6_0 = 1, arg_6_0.level do
		table = var_1_10007

		var_1_10007.insert(var_6_0, arg_6_0.level2Id[iter_6_0])
	end

	return var_6_0
end

function var_0_1.GetUnlockStoryIds(arg_7_0)
	local var_7_0 = {}
	local var_7_1 = arg_7_0
	local var_7_2 = arg_7_0.bindConfigTable(var_7_1)

	ipairs = var_7_1

	for iter_7_0, iter_7_1 in var_7_1(arg_7_0:GetReachLevelIds()) do
		local var_7_3 = var_7_2[iter_7_1].unlock_param

		table = var_1_10009
		var_7_0 = var_1_10009.mergeArray(var_7_0, var_7_3.story_id, true)
	end

	return var_7_0
end

function var_0_1.GetUnlockStoryIdsByType(arg_8_0)
	local var_8_0 = {}

	ipairs = var_1_10002

	for iter_8_0, iter_8_1 in var_1_10002(arg_8_0:GetUnlockStoryIds()) do
		pg = var_1_10007

		if var_1_10007.activity_mall_story[iter_8_1] then
			local var_8_1

			if not var_8_0[var_1_10007.type] then
				var_8_1 = {}
			end

			var_8_0[var_8] = var_8_1
			table = var_8_1

			var_8_1.insert(var_8_0[var_8], iter_8_1)
		end
	end

	pairs = var_2

	for iter_8_2, iter_8_3 in var_2(var_8_0) do
		table = var_1_10007

		var_1_10007.sort(iter_8_3, function(arg_9_0, arg_9_1)
			return arg_9_0 < arg_9_1
		end)
	end

	return var_8_0
end

function var_0_1.GetIdByLevel(arg_10_0)
	underscore = var_1_10001

	local var_10_0 = var_1_10001.detect

	pg = var_1_10002

	return var_10_0(var_1_10002.activity_mall_level.all, function(arg_11_0)
		pg = var_2_10001

		return var_2_10001.activity_mall_level[arg_11_0].lv == arg_10_0
	end)
end

function var_0_1.GetShowInfos(arg_12_0)
	pg = var_1_10001

	local var_12_0 = var_1_10001.activity_mall_level[arg_12_0].round_show
	local var_12_1 = {}

	ipairs = var_1_10003

	for iter_12_0, iter_12_1 in var_1_10003(var_12_0) do
		table = var_1_10008

		var_1_10008.insert(var_12_1, iter_12_1[2])
	end

	getRandomIdxByWeights = var_3

	local var_12_2 = var_12_0[var_3(var_12_1)]

	return {
		skinId = var_12_2[1],
		wordList = var_12_2[3]
	}
end

return var_0_1
