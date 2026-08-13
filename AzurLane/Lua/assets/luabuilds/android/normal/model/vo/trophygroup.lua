class = var_0_10000

local var_0_0 = var_0_10000("TrophyGroup")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._trophyGroupID = arg_1_1
	arg_1_0._trophyList = {}

	return
end

function var_0_0.getGroupID(arg_2_0)
	return arg_2_0._trophyGroupID
end

function var_0_0.getTrophyList(arg_3_0)
	return arg_3_0._trophyList
end

function var_0_0.getDisplayTrophy(arg_4_0)
	local var_4_0 = #arg_4_0._trophyList
	local var_4_1

	while var_4_0 > 0 do
		local var_4_2 = arg_4_0._trophyList[var_4_0]

		if var_4_1.isClaimed(var_4_2) then
			break
		end

		var_4_0 = var_4_0 - 1
	end

	return var_4_1
end

function var_0_0.getProgressTrophy(arg_5_0)
	local var_5_0 = 1
	local var_5_1 = #arg_5_0._trophyList
	local var_5_2

	while var_5_0 <= var_5_1 do
		local var_5_3 = arg_5_0._trophyList[var_5_0]

		if not var_5_2.isClaimed(var_5_3) then
			break
		end

		var_5_0 = var_5_0 + 1
	end

	return var_5_2
end

function var_0_0.getTrophyIndex(arg_6_0, arg_6_1)
	local var_6_0

	ipairs = var_1_10003

	for iter_6_0, iter_6_1 in var_1_10003(arg_6_0._trophyList) do
		if iter_6_1.id == arg_6_1.id then
			var_6_0 = iter_6_0

			break
		end
	end

	return var_6_0
end

function var_0_0.getMaxClaimedTrophy(arg_7_0)
	local var_7_0 = #arg_7_0._trophyList

	while var_7_0 > 0 do
		local var_7_1 = arg_7_0._trophyList[var_7_0]

		if var_2.isClaimed(var_7_1) then
			return var_2
		end

		var_7_0 = var_7_0 - 1
	end

	return
end

function var_0_0.getTrophyCount(arg_8_0)
	return #arg_8_0._trophyList
end

function var_0_0.getPostTrophy(arg_9_0, arg_9_1)
	if not arg_9_0:getTrophyIndex(arg_9_1) then
		return nil
	end

	if var_2 + 1 > #arg_9_0._trophyList then
		return nil
	end

	return arg_9_0._trophyList[var_2]
end

function var_0_0.getPreTrophy(arg_10_0, arg_10_1)
	if not arg_10_0:getTrophyIndex(arg_10_1) then
		return nil
	end

	if var_2 - 1 < 1 then
		return nil
	end

	return arg_10_0._trophyList[var_2]
end

function var_0_0.addTrophy(arg_11_0, arg_11_1)
	ipairs = var_1_10002

	for iter_11_0, iter_11_1 in var_1_10002(arg_11_0._trophyList) do
		if iter_11_1.id == arg_11_1.id then
			arg_11_0._trophyList[iter_11_0] = arg_11_1

			return
		end
	end

	arg_11_0._trophyList[#arg_11_0._trophyList + 1] = arg_11_1

	return
end

function var_0_0.addDummyTrophy(arg_12_0, arg_12_1)
	Trophy = var_1_10002

	local var_12_0 = var_1_10002.generateDummyTrophy(arg_12_1)

	arg_12_0:addTrophy(var_12_0)

	return
end

function var_0_0.sortGroup(arg_13_0)
	table = var_1_10001

	var_1_10001.sort(arg_13_0._trophyList, function(arg_14_0, arg_14_1)
		return arg_14_0.id < arg_14_1.id
	end)

	return
end

function var_0_0.GetTrophyPage(arg_15_0)
	local var_15_0 = arg_15_0._trophyList[1]

	return var_1.getConfig(var_15_0, "page")
end

function var_0_0.IsExpire(arg_16_0)
	local var_16_0 = arg_16_0._trophyList[1]

	return var_1.getConfig(var_16_0, "is_out_of_print")
end

return var_0_0
