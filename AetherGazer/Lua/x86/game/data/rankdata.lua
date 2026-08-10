require("game.data.RankDataTemplate")

local var_0_0 = singletonClass("RankData")
local var_0_1 = {}
local var_0_2 = {}
local var_0_3 = {}
local var_0_4 = {}

function var_0_0.Init(arg_1_0)
	var_0_1 = {}
	var_0_2 = {}
	var_0_3 = {}
	var_0_4 = {}
end

function var_0_0.SetCommonRankData(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	if not var_0_1[arg_2_1] then
		var_0_1[arg_2_1] = {}
	end

	local var_2_0 = RankTemplate.New()

	var_2_0:InitData(arg_2_3)

	var_0_1[arg_2_1][arg_2_2] = var_2_0
end

function var_0_0.SetGuildCommonRankData(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if not var_0_3[arg_3_1] then
		var_0_3[arg_3_1] = {}
	end

	var_0_3[arg_3_1][arg_3_2] = GuildRankTemplate.New(arg_3_3)
end

function var_0_0.SetActivityRankData(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if not var_0_2[arg_4_1] then
		var_0_2[arg_4_1] = {}
	end

	local var_4_0 = RankTemplate.New()

	var_4_0:InitData(arg_4_3)

	var_0_2[arg_4_1][arg_4_2] = var_4_0
end

function var_0_0.SetGuildActivityRankData(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	if not var_0_4[arg_5_1] then
		var_0_4[arg_5_1] = {}
	end

	var_0_4[arg_5_1][arg_5_2] = GuildRankTemplate.New(arg_5_3)
end

function var_0_0.SetOwnCommonRankData(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	if not var_0_1[arg_6_1] then
		var_0_1[arg_6_1] = {}
	end

	var_0_1[arg_6_1][arg_6_2] = var_0_1[arg_6_1][arg_6_2] or RankTemplate.New()

	var_0_1[arg_6_1][arg_6_2]:UpdateOwnData(arg_6_3)
end

function var_0_0.GetRankVersion(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0:GetCommonRank(arg_7_1, arg_7_2)

	if not var_7_0 then
		return 0
	end

	return var_7_0:GetRankVersion()
end

function var_0_0.GetActivityRankVersion(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0:GetActivityRank(arg_8_1, arg_8_2)

	if not var_8_0 then
		return 0
	end

	return var_8_0:GetRankVersion()
end

function var_0_0.GetCommonRank(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_2 == nil then
		arg_9_2 = 0
	end

	return var_0_1[arg_9_1] and var_0_1[arg_9_1][arg_9_2] or nil
end

function var_0_0.GetGuildCommonRank(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_2 == nil then
		arg_10_2 = 0
	end

	return var_0_3[arg_10_1] and var_0_3[arg_10_1][arg_10_2] or nil
end

function var_0_0.GetActivityRank(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_2 == nil then
		arg_11_2 = 0
	end

	return var_0_2[arg_11_1] and var_0_2[arg_11_1][arg_11_2] or nil
end

function var_0_0.GetGuildActivityRank(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_2 == nil then
		arg_12_2 = 0
	end

	return var_0_4[arg_12_1] and var_0_4[arg_12_1][arg_12_2] or nil
end

function var_0_0.GetCommonRankList(arg_13_0, arg_13_1)
	if var_0_1[arg_13_1] then
		return var_0_1[arg_13_1]
	end

	return {}
end

return var_0_0
