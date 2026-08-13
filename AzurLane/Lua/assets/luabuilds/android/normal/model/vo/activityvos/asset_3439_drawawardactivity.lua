class = var_0_10000

local var_0_0 = "DrawAwardActivity"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("model.vo.Activity"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.countDic = arg_1_0.data1KeyValueList[1]
	arg_1_0.storeDic = {}
	arg_1_0.rarityDic = {}
	ipairs = var_2

	for iter_1_0, iter_1_1 in var_2(arg_1_0:GetDrawConfig("reward_list")) do
		unpack = var_1_10007

		local var_1_0

		var_1_10007, var_1_0 = var_1_10007(iter_1_1)

		local var_1_1 = arg_1_0.storeDic

		var_1_1[var_1_10007] = var_1_0
		pg = var_1_1

		local var_1_2 = var_1_1.island_draw_reward[var_1_10007].rarity
		local var_1_3 = arg_1_0.rarityDic
		local var_1_4

		if not arg_1_0.rarityDic[var_1_2] then
			var_1_4 = {}
		end

		var_1_3[var_1_2] = var_1_4
		table = var_1_3

		var_1_3.insert(arg_1_0.rarityDic[var_1_2], var_1_10007)
	end

	return
end

function var_0_1.GetDrawConfig(arg_2_0, arg_2_1)
	pg = var_1_10002

	local var_2_0 = var_1_10002.island_draw[arg_2_0.configId]

	assert = var_3

	var_3(var_2_0, "without config in pg.island_draw:" .. arg_2_0.configId)

	return var_2_0[arg_2_1]
end

function var_0_1.GetDrawTimes(arg_3_0)
	return arg_3_0.data1
end

function var_0_1.GetDrawCount(arg_4_0)
	return arg_4_0.data2
end

function var_0_1.SetList(arg_5_0, arg_5_1)
	underscore = var_1_10002
	arg_5_0.data1_list = var_1_10002.to_array(arg_5_1)

	return
end

function var_0_1.GetList(arg_6_0)
	local var_6_0 = {}
	local var_6_1 = {}

	ipairs = var_1_10003

	for iter_6_0, iter_6_1 in var_1_10003(arg_6_0.data1_list) do
		defaultValue = var_1_10008
		var_6_1[iter_6_1] = var_1_10008(var_6_1[iter_6_1], 0) + 1
		table = var_1_10008

		var_1_10008.insert(var_6_0, {
			iter_6_1,
			true
		})
	end

	ipairs = var_3

	local var_6_2

	if not arg_6_0.rarityDic[4] then
		var_6_2 = {}
	end

	for iter_6_2, iter_6_3 in var_3(var_6_2) do
		defaultValue = var_1_10008
		var_1_10008 = var_1_10008(arg_6_0.storeDic[iter_6_3], 0)
		defaultValue = var_9

		for iter_6_4 = var_1_10008, var_9(var_6_1[iter_6_3], 0) + 1, -1 do
			table = var_1_10012
			var_1_10012 = var_1_10012.insert

			local var_6_3 = var_6_0
			local var_6_4 = {
				iter_6_3
			}

			defaultValue = var_1_10015
			var_1_10015 = var_1_10015(var_6_1[iter_6_3], 0)
			defaultValue = var_16
			var_1_10015 = var_1_10015 + var_16(arg_6_0.countDic[iter_6_3], 0) < iter_6_4
			var_6_4[2] = var_1_10015

			var_1_10012(var_6_3, var_6_4)
		end
	end

	return var_6_0
end

function var_0_1.CheckList(arg_7_0, arg_7_1)
	local var_7_0 = {}
	local var_7_1 = 0

	ipairs = var_1_10004

	for iter_7_0, iter_7_1 in var_1_10004(arg_7_0.rarityDic[4]) do
		defaultValue = var_1_10009
		var_1_10009 = var_1_10009(arg_7_0.storeDic[iter_7_1], 0)
		defaultValue = var_10
		var_7_0[iter_7_1] = var_1_10009 - var_10(arg_7_0.countDic[iter_7_1], 0)
		var_7_1 = var_7_1 + var_7_0[iter_7_1]
	end

	if #arg_7_1 ~= var_7_1 then
		return false
	end

	ipairs = var_4

	for iter_7_2, iter_7_3 in var_4(arg_7_1) do
		defaultValue = var_1_10009
		var_7_0[iter_7_3] = var_1_10009(var_7_0[iter_7_3], 0) - 1

		if var_7_0[iter_7_3] < 0 then
			return false
		end
	end

	return true
end

function var_0_1.GetCountAwardsRecord(arg_8_0)
	return arg_8_0.data2_list
end

function var_0_1.GetRarityIds(arg_9_0, arg_9_1)
	switch = var_1_10002

	local var_9_0 = var_1_10002(arg_9_1, {
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
	})

	return arg_9_0.rarityDic[var_9_0]
end

function var_0_1.GetRankList(arg_14_0, arg_14_1)
	local var_14_0 = {}

	ipairs = var_1_10003

	for iter_14_0, iter_14_1 in var_1_10003(arg_14_0:GetRarityIds(arg_14_1)) do
		defaultValue = var_1_10008

		for iter_14_2 = var_1_10008(arg_14_0.storeDic[iter_14_1], 0), 1, -1 do
			table = var_1_10012
			var_1_10012 = var_1_10012.insert

			local var_14_1 = var_14_0
			local var_14_2 = {
				iter_14_1
			}

			defaultValue = var_1_10015
			var_1_10015 = var_1_10015(arg_14_0.countDic[iter_14_1], 0) < iter_14_2
			var_14_2[2] = var_1_10015

			var_1_10012(var_14_1, var_14_2)
		end
	end

	return var_14_0
end

function var_0_1.GetTimesLeft(arg_15_0, arg_15_1)
	if not arg_15_1 or not arg_15_0:GetRarityIds(arg_15_1) then
		underscore = var_1_10002
		var_1_10002 = var_1_10002.map
		var_1_10004 = arg_15_0
		var_1_10002 = var_1_10002(arg_15_0.GetDrawConfig(var_1_10004, "reward_list"), function(arg_16_0)
			return arg_16_0[1]
		end)
	end

	local var_15_0 = 0

	ipairs = var_1_10004

	for iter_15_0, iter_15_1 in var_1_10004(var_1_10002) do
		defaultValue = var_1_10009
		var_1_10009 = var_15_0 + var_1_10009(arg_15_0.storeDic[iter_15_1], 0)
		defaultValue = var_10
		var_15_0 = var_1_10009 - var_10(arg_15_0.countDic[iter_15_1], 0)
	end

	return var_15_0
end

function var_0_1.ResultDraw(arg_17_0, arg_17_1)
	arg_17_0.data1 = arg_17_0.data1 - #arg_17_1
	arg_17_0.data2 = arg_17_0.data2 + #arg_17_1
	ipairs = var_2

	for iter_17_0, iter_17_1 in var_2(arg_17_1) do
		local var_17_0 = arg_17_0.countDic

		defaultValue = var_1_10008
		var_17_0[iter_17_1] = var_1_10008(arg_17_0.countDic[iter_17_1], 0) + 1
		pg = var_17_0

		if var_17_0.island_draw_reward[iter_17_1].rarity == 4 then
			if #arg_17_0.data1_list == 0 or arg_17_0.data1_list[1] == iter_17_1 then
				table = var_7

				var_7.remove(arg_17_0.data1_list, 1)
			else
				assert = var_7
				var_1_10008 = false
				string = var_9

				local var_17_1 = var_9.format
				local var_17_2 = "error SList drop %d in %s"
				local var_17_3 = iter_17_1

				PrintTable = var_1_10012

				var_7(var_1_10008, var_17_1(var_17_2, var_17_3, var_1_10012(arg_17_0.data1_list)))
			end
		end
	end

	return
end

function var_0_1.CountAward(arg_18_0, arg_18_1)
	table = var_1_10002

	var_1_10002.insert(arg_18_0.data2_list, arg_18_1)

	return
end

function var_0_1.GetCountAwards(arg_19_0)
	local var_19_0 = {}

	ipairs = var_1_10002

	for iter_19_0, iter_19_1 in var_1_10002(arg_19_0.data2_list) do
		defaultValue = var_1_10007
		var_19_0[iter_19_1] = var_1_10007(var_19_0[iter_19_1], 0) + 1
	end

	local var_19_1 = {}

	ipairs = var_3

	for iter_19_2, iter_19_3 in var_3(arg_19_0:GetDrawConfig("reward_acc")) do
		unpack = var_1_10008

		local var_19_2

		var_1_10008, var_19_2 = var_1_10008(iter_19_3)

		for iter_19_4 = 1, var_19_2 do
			table = var_1_10014
			var_1_10014 = var_1_10014.insert

			local var_19_3 = var_19_1
			local var_19_4 = {
				var_1_10008
			}

			defaultValue = var_1_10017
			var_1_10017 = var_1_10017(var_19_0[var_1_10008], 0) < iter_19_4
			var_19_4[2] = var_1_10017

			var_1_10014(var_19_3, var_19_4)
		end
	end

	return var_19_1
end

function var_0_1.GetNextCountAwardTimes(arg_20_0)
	return arg_20_0:GetDrawConfig("acc_count_list")[#arg_20_0.data2_list + 1]
end

function var_0_1.CanCountAward(arg_21_0, arg_21_1)
	if not arg_21_1 then
		return true
	end

	if not arg_21_0:GetNextCountAwardTimes() or var_2 > arg_21_0.data2 then
		return false
	end

	local var_21_0 = 0

	ipairs = var_1_10004

	for iter_21_0, iter_21_1 in var_1_10004(arg_21_0.data2_list) do
		if iter_21_1 == arg_21_1 then
			var_21_0 = var_21_0 - 1
		end
	end

	ipairs = var_4

	for iter_21_2, iter_21_3 in var_4(arg_21_0:GetDrawConfig("reward_acc")) do
		unpack = var_1_10009

		local var_21_1

		var_1_10009, var_21_1 = var_1_10009(iter_21_3)

		if arg_21_1 == var_1_10009 and var_21_0 + var_21_1 > 0 then
			return true
		end
	end

	return false
end

function var_0_1.GetShowRankList(arg_22_0, arg_22_1)
	local var_22_0 = {}

	ipairs = var_1_10003

	for iter_22_0, iter_22_1 in var_1_10003(arg_22_0:GetRankList(arg_22_1)) do
		unpack = var_1_10008

		local var_22_1

		var_1_10008, var_22_1 = var_1_10008(iter_22_1)
		pg = var_1_10010
		var_1_10010 = var_1_10010.island_draw_reward[var_1_10008]
		noEmptyStr = var_1_10011

		if var_1_10011(var_1_10010.show) then
			table = var_1_10011

			var_1_10011.insert(var_22_0, var_1_10008)
		end
	end

	return var_22_0
end

function var_0_1.GetLastItemCount(arg_23_0, arg_23_1)
	defaultValue = var_1_10002

	local var_23_0 = var_1_10002(arg_23_0.storeDic[arg_23_1], 0)

	defaultValue = var_3

	return var_23_0 - var_3(arg_23_0.countDic[arg_23_1], 0)
end

return var_0_1
