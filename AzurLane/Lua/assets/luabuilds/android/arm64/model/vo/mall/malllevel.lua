local var_0_0 = class("MallLevel", import("model.vo.BaseVO"))

var_0_0.CONDITION_TYPE = {
	ROUND = 1,
	ROUND_INCOME = 2,
	FLOOR_INCOME = 4,
	ORDER = 3
}

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.level = arg_1_1

	arg_1_0:InitLevelConfig()

	arg_1_0.level = math.min(arg_1_0.level, arg_1_0.maxLevel)
	arg_1_0.id = arg_1_0.level2Id[arg_1_0.level]
	arg_1_0.configId = arg_1_0.id

	return
end

function var_0_0.bindConfigTable(arg_2_0)
	return pg.activity_mall_level
end

function var_0_0.InitLevelConfig(arg_3_0)
	arg_3_0.level2Id = {}
	arg_3_0.maxLevel = 0

	for iter_3_0, iter_3_1 in ipairs(pg.activity_mall_level.all) do
		arg_3_0.level2Id[pg.activity_mall_level[iter_3_1].lv] = iter_3_1
		arg_3_0.maxLevel = math.max(arg_3_0.maxLevel, pg.activity_mall_level[iter_3_1].lv)
	end

	return
end

function var_0_0.IsMaxLevel(arg_4_0)
	return arg_4_0.level == arg_4_0.maxLevel
end

function var_0_0.OnUpgradeDone(arg_5_0, arg_5_1)
	arg_5_0.level = math.min(arg_5_1, arg_5_0.maxLevel)
	arg_5_0.id = arg_5_0.level2Id[arg_5_0.level]
	arg_5_0.configId = arg_5_0.id

	return
end

function var_0_0.GetReachLevelIds(arg_6_0, arg_6_1)
	for iter_6_0 = 1, arg_6_0.level do
		table.insert({}, arg_6_0.level2Id[iter_6_0])
	end

	return {}
end

function var_0_0.GetUnlockStoryIds(arg_7_0)
	local var_7_0 = {}
	local var_7_1 = arg_7_0:bindConfigTable()

	for iter_7_0, iter_7_1 in ipairs(arg_7_0:GetReachLevelIds()) do
		var_7_0 = table.mergeArray(var_7_0, var_7_1[iter_7_1].unlock_param.story_id, true)
	end

	return var_7_0
end

function var_0_0.GetUnlockStoryIdsByType(arg_8_0)
	for iter_8_0, iter_8_1 in ipairs(arg_8_0:GetUnlockStoryIds()) do
		if pg.activity_mall_story[iter_8_1] then
			local var_8_0 = ({})[pg.activity_mall_story[iter_8_1].type]

			if not ({})[pg.activity_mall_story[iter_8_1].type] then
				var_8_0 = {}
			end

			;({})[pg.activity_mall_story[iter_8_1].type] = var_8_0

			table.insert(({})[pg.activity_mall_story[iter_8_1].type], iter_8_1)
		end
	end

	for iter_8_2, iter_8_3 in pairs({}) do
		table.sort(iter_8_3, function(arg_9_0, arg_9_1)
			return arg_9_0 < arg_9_1
		end)
	end

	return {}
end

function var_0_0.GetIdByLevel(arg_10_0)
	return underscore.detect(pg.activity_mall_level.all, function(arg_11_0)
		return pg.activity_mall_level[arg_11_0].lv == arg_10_0
	end)
end

function var_0_0.GetShowInfos(arg_12_0)
	for iter_12_0, iter_12_1 in ipairs(pg.activity_mall_level[arg_12_0].round_show) do
		table.insert({}, iter_12_1[2])
	end

	local var_12_0 = pg.activity_mall_level[arg_12_0].round_show[getRandomIdxByWeights({})]

	return {
		skinId = var_12_0[1],
		wordList = var_12_0[3]
	}
end

return var_0_0
