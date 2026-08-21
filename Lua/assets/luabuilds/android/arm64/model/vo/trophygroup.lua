local var_0_0 = class("TrophyGroup")

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
	local var_4_0

	while #arg_4_0._trophyList > 0 do
		var_4_0 = arg_4_0._trophyList[#arg_4_0._trophyList]

		if arg_4_0._trophyList[#arg_4_0._trophyList]:isClaimed() then
			break
		end
	end

	return var_4_0
end

function var_0_0.getProgressTrophy(arg_5_0)
	local var_5_0

	while 1 <= #arg_5_0._trophyList do
		var_5_0 = arg_5_0._trophyList[1]

		if not arg_5_0._trophyList[1]:isClaimed() then
			break
		end
	end

	return var_5_0
end

function var_0_0.getTrophyIndex(arg_6_0, arg_6_1)
	local var_6_0

	for iter_6_0, iter_6_1 in ipairs(arg_6_0._trophyList) do
		if iter_6_1.id == arg_6_1.id then
			var_6_0 = iter_6_0

			break
		end
	end

	return var_6_0
end

function var_0_0.getMaxClaimedTrophy(arg_7_0)
	while #arg_7_0._trophyList > 0 do
		if arg_7_0._trophyList[#arg_7_0._trophyList]:isClaimed() then
			return arg_7_0._trophyList[#arg_7_0._trophyList]
		end
	end

	return
end

function var_0_0.getTrophyCount(arg_8_0)
	return #arg_8_0._trophyList
end

function var_0_0.getPostTrophy(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0:getTrophyIndex(arg_9_1)

	if not var_9_0 then
		return nil
	end

	local var_9_1 = var_9_0 + 1

	if var_9_0 + 1 > #arg_9_0._trophyList then
		return nil
	end

	return arg_9_0._trophyList[var_9_1]
end

function var_0_0.getPreTrophy(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0:getTrophyIndex(arg_10_1)

	if not var_10_0 then
		return nil
	end

	local var_10_1 = var_10_0 - 1

	if var_10_0 - 1 < 1 then
		return nil
	end

	return arg_10_0._trophyList[var_10_1]
end

function var_0_0.addTrophy(arg_11_0, arg_11_1)
	for iter_11_0, iter_11_1 in ipairs(arg_11_0._trophyList) do
		if iter_11_1.id == arg_11_1.id then
			arg_11_0._trophyList[iter_11_0] = arg_11_1

			return
		end
	end

	arg_11_0._trophyList[#arg_11_0._trophyList + 1] = arg_11_1

	return
end

function var_0_0.addDummyTrophy(arg_12_0, arg_12_1)
	arg_12_0:addTrophy((Trophy.generateDummyTrophy(arg_12_1)))

	return
end

function var_0_0.sortGroup(arg_13_0)
	table.sort(arg_13_0._trophyList, function(arg_14_0, arg_14_1)
		return arg_14_0.id < arg_14_1.id
	end)

	return
end

function var_0_0.GetTrophyPage(arg_15_0)
	return arg_15_0._trophyList[1]:getConfig("page")
end

function var_0_0.IsExpire(arg_16_0)
	return arg_16_0._trophyList[1]:getConfig("is_out_of_print")
end

return var_0_0
