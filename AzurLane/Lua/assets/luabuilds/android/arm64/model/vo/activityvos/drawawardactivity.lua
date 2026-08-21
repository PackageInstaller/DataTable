local var_0_0 = class("DrawAwardActivity", import("model.vo.Activity"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.countDic = arg_1_0.data1KeyValueList[1]
	arg_1_0.storeDic = {}
	arg_1_0.rarityDic = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_0:GetDrawConfig("reward_list")) do
		local var_1_0, var_1_1 = unpack(iter_1_1)

		arg_1_0.storeDic[var_1_0] = var_1_1
		arg_1_0.rarityDic[pg.island_draw_reward[var_1_0].rarity] = arg_1_0.rarityDic[pg.island_draw_reward[var_1_0].rarity] or {}

		table.insert(arg_1_0.rarityDic[pg.island_draw_reward[var_1_0].rarity], var_1_0)
	end

	return
end

function var_0_0.GetDrawConfig(arg_2_0, arg_2_1)
	assert(pg.island_draw[arg_2_0.configId], "without config in pg.island_draw:" .. arg_2_0.configId)

	return pg.island_draw[arg_2_0.configId][arg_2_1]
end

function var_0_0.GetDrawTimes(arg_3_0)
	return arg_3_0.data1
end

function var_0_0.GetDrawCount(arg_4_0)
	return arg_4_0.data2
end

function var_0_0.SetList(arg_5_0, arg_5_1)
	arg_5_0.data1_list = underscore.to_array(arg_5_1)

	return
end

function var_0_0.GetList(arg_6_0)
	local var_6_0 = {}

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.data1_list) do
		var_6_0[iter_6_1] = defaultValue(var_6_0[iter_6_1], 0) + 1

		table.insert({}, {
			iter_6_1,
			true
		})
	end

	local var_6_1 = arg_6_0.rarityDic[4] or {}

	for iter_6_2, iter_6_3 in ipairs(var_6_1) do
		for iter_6_4 = defaultValue(arg_6_0.storeDic[iter_6_3], 0), defaultValue(var_6_0[iter_6_3], 0) + 1, -1 do
			table.insert({}, {
				iter_6_3,
				iter_6_4 > defaultValue(var_6_0[iter_6_3], 0) + defaultValue(arg_6_0.countDic[iter_6_3], 0)
			})
		end
	end

	return {}
end

function var_0_0.CheckList(arg_7_0, arg_7_1)
	local var_7_0 = 0

	for iter_7_0, iter_7_1 in ipairs(arg_7_0.rarityDic[4]) do
		({})[iter_7_1] = defaultValue(arg_7_0.storeDic[iter_7_1], 0) - defaultValue(arg_7_0.countDic[iter_7_1], 0)
		var_7_0 = var_7_0 + ({})[iter_7_1]
	end

	if #arg_7_1 ~= var_7_0 then
		return false
	end

	for iter_7_2, iter_7_3 in ipairs(arg_7_1) do
		({})[iter_7_3] = defaultValue(({})[iter_7_3], 0) - 1

		if ({})[iter_7_3] < 0 then
			return false
		end
	end

	return true
end

function var_0_0.GetCountAwardsRecord(arg_8_0)
	return arg_8_0.data2_list
end

function var_0_0.GetRarityIds(arg_9_0, arg_9_1)
	return arg_9_0.rarityDic[switch(arg_9_1, {
		S = function()
			return 4
		end,
		A = function()
			return 3
		end,
		B = function()
			return 2
		end,
		C = function()
			return 1
		end
	})]
end

function var_0_0.GetRankList(arg_14_0, arg_14_1)
	for iter_14_0, iter_14_1 in ipairs(arg_14_0:GetRarityIds(arg_14_1)) do
		for iter_14_2 = defaultValue(arg_14_0.storeDic[iter_14_1], 0), 1, -1 do
			table.insert({}, {
				iter_14_1,
				iter_14_2 > defaultValue(arg_14_0.countDic[iter_14_1], 0)
			})
		end
	end

	return {}
end

function var_0_0.GetTimesLeft(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_1 and arg_15_0:GetRarityIds(arg_15_1) or underscore.map(arg_15_0:GetDrawConfig("reward_list"), function(arg_16_0)
		return arg_16_0[1]
	end)
	local var_15_1 = 0

	for iter_15_0, iter_15_1 in ipairs(var_15_0) do
		var_15_1 = var_15_1 + defaultValue(arg_15_0.storeDic[iter_15_1], 0) - defaultValue(arg_15_0.countDic[iter_15_1], 0)
	end

	return var_15_1
end

function var_0_0.ResultDraw(arg_17_0, arg_17_1)
	arg_17_0.data1 = arg_17_0.data1 - #arg_17_1
	arg_17_0.data2 = arg_17_0.data2 + #arg_17_1

	for iter_17_0, iter_17_1 in ipairs(arg_17_1) do
		arg_17_0.countDic[iter_17_1] = defaultValue(arg_17_0.countDic[iter_17_1], 0) + 1

		if pg.island_draw_reward[iter_17_1].rarity == 4 then
			if #arg_17_0.data1_list == 0 or arg_17_0.data1_list[1] == iter_17_1 then
				table.remove(arg_17_0.data1_list, 1)
			else
				assert(false, string.format("error SList drop %d in %s", iter_17_1, PrintTable(arg_17_0.data1_list)))
			end
		end
	end

	return
end

function var_0_0.CountAward(arg_18_0, arg_18_1)
	table.insert(arg_18_0.data2_list, arg_18_1)

	return
end

function var_0_0.GetCountAwards(arg_19_0)
	for iter_19_0, iter_19_1 in ipairs(arg_19_0.data2_list) do
		({})[iter_19_1] = defaultValue(({})[iter_19_1], 0) + 1
	end

	local var_19_0 = {}

	for iter_19_2, iter_19_3 in ipairs(arg_19_0:GetDrawConfig("reward_acc")) do
		local var_19_1, var_19_2 = unpack(iter_19_3)

		for iter_19_4 = 1, var_19_2 do
			table.insert(var_19_0, {
				var_19_1,
				iter_19_4 > defaultValue(({})[var_19_1], 0)
			})
		end
	end

	return var_19_0
end

function var_0_0.GetNextCountAwardTimes(arg_20_0)
	return arg_20_0:GetDrawConfig("acc_count_list")[#arg_20_0.data2_list + 1]
end

function var_0_0.CanCountAward(arg_21_0, arg_21_1)
	if not arg_21_1 then
		return true
	end

	local var_21_0 = arg_21_0:GetNextCountAwardTimes()

	if not var_21_0 or var_21_0 > arg_21_0.data2 then
		return false
	end

	local var_21_1 = 0

	for iter_21_0, iter_21_1 in ipairs(arg_21_0.data2_list) do
		if iter_21_1 == arg_21_1 then
			var_21_1 = var_21_1 - 1
		end
	end

	for iter_21_2, iter_21_3 in ipairs(arg_21_0:GetDrawConfig("reward_acc")) do
		local var_21_2, var_21_3 = unpack(iter_21_3)

		if arg_21_1 == var_21_2 then
			var_21_1 = var_21_1 + var_21_3

			if var_21_1 > 0 then
				return true
			end
		end
	end

	return false
end

function var_0_0.GetShowRankList(arg_22_0, arg_22_1)
	for iter_22_0, iter_22_1 in ipairs(arg_22_0:GetRankList(arg_22_1)) do
		local var_22_0, var_22_1 = unpack(iter_22_1)

		if noEmptyStr(pg.island_draw_reward[var_22_0].show) then
			table.insert({}, var_22_0)
		end
	end

	return {}
end

function var_0_0.GetLastItemCount(arg_23_0, arg_23_1)
	return defaultValue(arg_23_0.storeDic[arg_23_1], 0) - defaultValue(arg_23_0.countDic[arg_23_1], 0)
end

return var_0_0
