local var_0_0 = {}

function var_0_0.QueryCommonRank(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_1 = arg_1_1 or 0

	local var_1_0 = 1
	local var_1_1 = arg_1_3 or 100
	local var_1_2 = RankData:GetRankVersion(arg_1_0, arg_1_1)
	local var_1_3 = {
		rank_id = arg_1_0,
		children_id = arg_1_1,
		start = var_1_0,
		stop = var_1_1,
		version = var_1_2
	}

	manager.net:SendWithLoadingNew(69000, var_1_3, 69001, function(arg_2_0, arg_2_1)
		var_0_0.OnQueryCommonRankBack(arg_2_0, arg_2_1, arg_1_2)
	end)
end

function var_0_0.OnQueryCommonRankBack(arg_3_0, arg_3_1, arg_3_2)
	if isSuccess(arg_3_0.result) then
		if arg_3_0.version ~= arg_3_1.version or arg_3_1.version == 0 then
			RankData:SetCommonRankData(arg_3_1.rank_id, arg_3_1.children_id, arg_3_0)
		end

		if arg_3_2 then
			arg_3_2(arg_3_1.rank_id, arg_3_1.children_id)
		end

		manager.notify:CallUpdateFunc(RANK_UPDATE, arg_3_1.rank_id)
	elseif arg_3_0.result == 5 then
		if arg_3_2 then
			arg_3_2(arg_3_1.rank_id, arg_3_1.children_id)
		end

		manager.notify:CallUpdateFunc(RANK_UPDATE, arg_3_1.rank_id)
	else
		ShowTips(arg_3_0.result)
	end
end

function var_0_0.QueryGuildCommonRank(arg_4_0, arg_4_1, arg_4_2)
	arg_4_1 = arg_4_1 or 0

	local var_4_0 = {
		rank_id = arg_4_0,
		children_id = arg_4_1
	}

	manager.net:SendWithLoadingNew(33300, var_4_0, 33301, function(arg_5_0, arg_5_1)
		var_0_0.OnQueryGuildCommonRankBack(arg_5_0, arg_5_1, arg_4_2)
	end)
end

function var_0_0.OnQueryGuildCommonRankBack(arg_6_0, arg_6_1, arg_6_2)
	if isSuccess(arg_6_0.result) then
		RankData:SetGuildCommonRankData(arg_6_1.rank_id, arg_6_1.children_id, arg_6_0)

		if arg_6_2 then
			arg_6_2(arg_6_1.rank_id, arg_6_1.children_id)
		end

		manager.notify:CallUpdateFunc(RANK_UPDATE, arg_6_1.rank_id)
	elseif arg_6_0.result == 5 then
		if arg_6_2 then
			arg_6_2(arg_6_1.rank_id, arg_6_1.children_id)
		end

		manager.notify:CallUpdateFunc(RANK_UPDATE, arg_6_1.rank_id)
	else
		ShowTips(arg_6_0.result)
	end
end

function var_0_0.QueryActivityRank(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	arg_7_1 = arg_7_1 or 0

	local var_7_0 = 1

	if arg_7_3 == nil or arg_7_3 > 1 then
		arg_7_3 = 100
	end

	local var_7_1 = RankData:GetActivityRankVersion(arg_7_0, arg_7_1)
	local var_7_2 = {
		activity_id = arg_7_0,
		children_id = arg_7_1,
		start = var_7_0,
		stop = arg_7_3,
		version = var_7_1
	}

	manager.net:SendWithLoadingNew(69004, var_7_2, 69005, function(arg_8_0, arg_8_1)
		var_0_0.OnQueryActivityRankBack(arg_8_0, arg_8_1, arg_7_2)
	end)
end

function var_0_0.OnQueryActivityRankBack(arg_9_0, arg_9_1, arg_9_2)
	if isSuccess(arg_9_0.result) then
		if arg_9_0.version ~= arg_9_1.version or arg_9_1.version == 0 then
			RankData:SetActivityRankData(arg_9_1.activity_id, arg_9_1.children_id, arg_9_0)
		end

		if arg_9_2 then
			arg_9_2(arg_9_1.rank_id, arg_9_1.children_id)
		end

		manager.notify:CallUpdateFunc(RANK_UPDATE, arg_9_1.activity_id)
	elseif arg_9_0.result == 5 then
		if arg_9_2 then
			arg_9_2(arg_9_1.rank_id, arg_9_1.children_id)
		end

		manager.notify:CallUpdateFunc(RANK_UPDATE, arg_9_1.rank_id)
	else
		ShowTips(arg_9_0.result)
	end
end

function var_0_0.QueryActivityRankWitchCallBack(arg_10_0, arg_10_1, arg_10_2)
	arg_10_1 = arg_10_1 or 0

	local var_10_0 = 1
	local var_10_1 = 100
	local var_10_2 = RankData:GetActivityRankVersion(arg_10_0, arg_10_1)
	local var_10_3 = {
		activity_id = arg_10_0,
		children_id = arg_10_1,
		start = var_10_0,
		stop = var_10_1,
		version = var_10_2
	}

	manager.net:SendWithLoadingNew(69004, var_10_3, 69005, function(arg_11_0)
		if isSuccess(arg_11_0.result) then
			RankData:SetActivityRankData(arg_10_0, arg_10_1, arg_11_0)
			arg_10_2()
		elseif arg_11_0.result == 5 then
			arg_10_2()
		else
			ShowTips(arg_11_0.result)
		end
	end)
end

function var_0_0.QueryGuildActivityRank(arg_12_0, arg_12_1)
	arg_12_1 = arg_12_1 or 0

	local var_12_0 = {
		activity_id = arg_12_0,
		children_id = arg_12_1
	}

	manager.net:SendWithLoadingNew(33302, var_12_0, 33303, var_0_0.OnQueryGuildActivityRankBack)
end

function var_0_0.OnQueryGuildActivityRankBack(arg_13_0, arg_13_1)
	if isSuccess(arg_13_0.result) then
		RankData:SetGuildActivityRankData(arg_13_1.activity_id, arg_13_1.children_id, arg_13_0)
		manager.notify:CallUpdateFunc(RANK_UPDATE, arg_13_1.activity_id)
	elseif arg_13_0.result == 5 then
		manager.notify:CallUpdateFunc(RANK_UPDATE, arg_13_1.rank_id)
	else
		ShowTips(arg_13_0.result)
	end
end

function var_0_0.QueryGuildActivityRankWitchCallBack(arg_14_0, arg_14_1, arg_14_2)
	arg_14_1 = arg_14_1 or 0

	local var_14_0 = {
		activity_id = arg_14_0,
		children_id = arg_14_1
	}

	manager.net:SendWithLoadingNew(33302, var_14_0, 33303, function(arg_15_0)
		if isSuccess(arg_15_0.result) then
			RankData:SetGuildActivityRankData(arg_14_0, arg_14_1, arg_15_0)
			arg_14_2()
		elseif arg_15_0.result == 5 then
			-- block empty
		else
			ShowTips(arg_15_0.result)
		end
	end)
end

function var_0_0.QueryOwnCommonRank(arg_16_0, arg_16_1, arg_16_2)
	arg_16_1 = arg_16_1 or {
		0
	}

	manager.net:SendWithLoadingNew(69002, {
		rank_id = arg_16_0,
		children_id_list = arg_16_1
	}, 69003, function(arg_17_0, arg_17_1)
		var_0_0.OnQueryOwnCommonRankBack(arg_17_0, arg_17_1, arg_16_2)
	end)
end

function var_0_0.OnQueryOwnCommonRankBack(arg_18_0, arg_18_1, arg_18_2)
	if isSuccess(arg_18_0.result) then
		for iter_18_0, iter_18_1 in ipairs(arg_18_0.children_rank_list) do
			RankData:SetOwnCommonRankData(arg_18_1.rank_id, iter_18_1.children_id, iter_18_1)
		end

		if arg_18_2 then
			arg_18_2()
		end

		manager.notify:CallUpdateFunc(RANK_UPDATE, arg_18_1.rank_id)
	elseif arg_18_0.result == 5 then
		if arg_18_2 then
			arg_18_2()
		end

		manager.notify:CallUpdateFunc(RANK_UPDATE, arg_18_1.rank_id)
	else
		ShowTips(arg_18_0.result)
	end
end

function var_0_0.QueryActivityAllRank(arg_19_0, arg_19_1)
	manager.net:SendWithLoadingNew(69006, {
		activity_id = arg_19_0
	}, 69007, function(arg_20_0)
		if isSuccess(arg_20_0.result) then
			for iter_20_0, iter_20_1 in ipairs(arg_20_0.children_rank_list) do
				RankData:SetActivityRankData(arg_19_0, iter_20_1.children_id, iter_20_1)
			end

			if arg_19_1 then
				arg_19_1(arg_20_0)
			end
		elseif arg_20_0.result == 5 then
			if arg_19_1 then
				arg_19_1(arg_20_0)
			end
		else
			ShowTips(arg_20_0.result)
		end
	end)
end

return var_0_0
