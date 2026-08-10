RankConst = {
	RANK_ID = {
		ABYSS = 3,
		MULTHEARTDEMON = 7,
		MATRIX = 2,
		COREVERIFICATION = 6,
		POLYHERON = 4,
		SOLOHEARTDEMON = 5,
		MYTHIC = 1
	}
}
RankTemplate = class("CommonRankTemplate")

function RankTemplate.Ctor(arg_1_0)
	arg_1_0.rankList = {}
	arg_1_0.curRank = nil
	arg_1_0.total_people = 1
	arg_1_0.rank_version = 0
end

function RankTemplate.InitData(arg_2_0, arg_2_1)
	arg_2_0.rankList = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.rank_list or {}) do
		local var_2_0 = RankInfoTemplate.New(iter_2_1)

		table.insert(arg_2_0.rankList, var_2_0)
	end

	table.sort(arg_2_0.rankList, function(arg_3_0, arg_3_1)
		return arg_3_0.rank < arg_3_1.rank
	end)

	if arg_2_1.my_rank then
		arg_2_0.curRank = RankInfoTemplate.New(arg_2_1.my_rank, true)
	end

	arg_2_0.total_people = arg_2_1.total or 1
	arg_2_0.rank_version = arg_2_1.version or 0
end

function RankTemplate.UpdateOwnData(arg_4_0, arg_4_1)
	arg_4_0.curRank = RankInfoTemplate.New(arg_4_1.my_rank, true)
	arg_4_0.total_people = arg_4_1.total or 1
end

function RankTemplate.GetRankVersion(arg_5_0)
	return arg_5_0.rank_version
end

function RankTemplate.GetCurRankDes(arg_6_0, arg_6_1)
	if not arg_6_0.curRank then
		return GetTips("MATRIX_RANK_NO_RANK"), GetTips("MATRIX_RANK_NO_INFO")
	end

	local var_6_0 = ""
	local var_6_1 = ""
	local var_6_2 = arg_6_0.curRank.rank
	local var_6_3 = arg_6_1 or 100

	if var_6_2 == 0 then
		var_6_0 = GetTips("MATRIX_RANK_NO_RANK")
		var_6_1 = GetTips("MATRIX_RANK_NO_INFO")
	elseif var_6_2 >= 1 and var_6_2 <= var_6_3 then
		var_6_0 = tostring(arg_6_0.curRank.rank)
		var_6_1 = tostring(arg_6_0.curRank.score)
	else
		local var_6_4 = arg_6_0.total_people
		local var_6_5 = arg_6_0.curRank.rank / var_6_4 * 100

		var_6_0 = string.format("%.2f", var_6_5) .. "%"
		var_6_1 = tostring(arg_6_0.curRank.score)
	end

	return var_6_0, var_6_1
end

GuildRankTemplate = class("ActivityRankTemplate")

function GuildRankTemplate.Ctor(arg_7_0, arg_7_1)
	local var_7_0 = PlayerData:GetPlayerInfo()

	arg_7_0.rankList = {}

	for iter_7_0, iter_7_1 in ipairs(arg_7_1.rank_list or {}) do
		local var_7_1 = RankInfoTemplate.New(iter_7_1)

		table.insert(arg_7_0.rankList, var_7_1)

		if var_7_0 and var_7_1.user_id == var_7_0.userID then
			arg_7_0.curRank = var_7_1
		end
	end
end

function GuildRankTemplate.GetCurRankDes(arg_8_0)
	if not arg_8_0.curRank then
		return GetTips("MATRIX_RANK_NO_RANK"), GetTips("MATRIX_RANK_NO_INFO")
	end

	local var_8_0 = ""
	local var_8_1 = ""
	local var_8_2 = arg_8_0.curRank.rank

	if var_8_2 == 0 then
		var_8_0 = GetTips("MATRIX_RANK_NO_RANK")
		var_8_1 = GetTips("MATRIX_RANK_NO_INFO")
	elseif var_8_2 >= 1 and var_8_2 <= 100 then
		var_8_0 = tostring(arg_8_0.curRank.rank)
		var_8_1 = tostring(arg_8_0.curRank.score)
	else
		local var_8_3 = GuildData:GetGuildInfo()

		if not var_8_3 then
			var_8_0 = "0%"
		else
			local var_8_4 = var_8_3.memberCnt
			local var_8_5 = arg_8_0.curRank.rank / var_8_4 * 100

			var_8_0 = string.format("%.2f", var_8_5) .. "%"
		end

		var_8_1 = tostring(arg_8_0.curRank.score)
	end

	return var_8_0, var_8_1
end

RankInfoTemplate = class("RankInfoTemplate")

function RankInfoTemplate.Ctor(arg_9_0, arg_9_1)
	arg_9_0.user_id = arg_9_1.user_id
	arg_9_0.score = arg_9_1.score
	arg_9_0.difficulty = arg_9_1.difficulty
	arg_9_0.rank = arg_9_1.rank
	arg_9_0.timestamp = arg_9_1.timestamp

	local var_9_0 = PlayerData:GetPlayerInfo()

	if var_9_0 and arg_9_0.user_id == var_9_0.userID then
		arg_9_0.nick = var_9_0.nick
		arg_9_0.portrait = var_9_0.portrait
		arg_9_0.frame = var_9_0.icon_frame
	else
		arg_9_0.nick = arg_9_1.nick
		arg_9_0.portrait = arg_9_1.portrait
		arg_9_0.frame = arg_9_1.frame
	end

	arg_9_0.stage_team_list = {}

	for iter_9_0, iter_9_1 in ipairs(arg_9_1.stage_team_list) do
		local var_9_1 = iter_9_1.stage_id or 0
		local var_9_2 = {}

		for iter_9_2, iter_9_3 in ipairs(iter_9_1.team_info_list) do
			local var_9_3 = iter_9_3.index
			local var_9_4 = {}

			for iter_9_4, iter_9_5 in ipairs(iter_9_3.hero_info_list) do
				table.insert(var_9_4, {
					hero_id = iter_9_5.hero_id,
					skin_id = iter_9_5.skin_id
				})
			end

			var_9_2[var_9_3] = var_9_4
		end

		arg_9_0.stage_team_list[var_9_1] = var_9_2
	end

	arg_9_0.staticInfo = {}
	arg_9_0.staticInfo.clearTime = arg_9_1.static_info.clear_time
	arg_9_0.staticInfo.hitNumber = arg_9_1.static_info.hit_num
	arg_9_0.extraInfo = {}

	for iter_9_6, iter_9_7 in ipairs(cleanProtoTable(arg_9_1.extra_info)) do
		arg_9_0.extraInfo[iter_9_7.key] = iter_9_7.value
	end
end

function RankInfoTemplate.GetSingleSelectHeroList(arg_10_0)
	local var_10_0 = arg_10_0.stage_team_list[0]

	if not var_10_0 then
		return {}
	end

	return var_10_0[1] or {}
end
