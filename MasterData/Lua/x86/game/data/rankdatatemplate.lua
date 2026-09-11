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

function RankTemplate:InitData(arg_2_1)
	self.rankList = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.rank_list or {}) do
		table.insert(self.rankList, (RankInfoTemplate.New(iter_2_1)))
	end

	table.sort(self.rankList, function(arg_3_0, arg_3_1)
		return arg_3_0.rank < arg_3_1.rank
	end)

	if arg_2_1.my_rank then
		self.curRank = RankInfoTemplate.New(arg_2_1.my_rank, true)
	end

	self.total_people = arg_2_1.total or 1
	self.rank_version = arg_2_1.version or 0
end

function RankTemplate.UpdateOwnData(arg_4_0, arg_4_1)
	arg_4_0.curRank = RankInfoTemplate.New(arg_4_1.my_rank, true)
	arg_4_0.total_people = arg_4_1.total or 1
end

function RankTemplate:GetRankVersion()
	return self.rank_version
end

function RankTemplate:GetCurRankDes(arg_6_1)
	if not self.curRank then
		return GetTips("MATRIX_RANK_NO_RANK"), GetTips("MATRIX_RANK_NO_INFO")
	end

	local var_6_0 = ""
	local var_6_1 = ""
	local var_6_2 = arg_6_1 or 100

	if self.curRank.rank == 0 then
		var_6_0 = GetTips("MATRIX_RANK_NO_RANK")
		var_6_1 = GetTips("MATRIX_RANK_NO_INFO")
	elseif self.curRank.rank >= 1 and self.curRank.rank <= var_6_2 then
		var_6_0 = tostring(self.curRank.rank)
		var_6_1 = tostring(self.curRank.score)
	else
		var_6_0 = string.format("%.2f", self.curRank.rank / self.total_people * 100) .. "%"
		var_6_1 = tostring(self.curRank.score)
	end

	return var_6_0, var_6_1
end

GuildRankTemplate = class("ActivityRankTemplate")

function GuildRankTemplate:Ctor(arg_7_1)
	local var_7_0 = PlayerData:GetPlayerInfo()

	self.rankList = {}

	for iter_7_0, iter_7_1 in ipairs(arg_7_1.rank_list or {}) do
		local var_7_1 = RankInfoTemplate.New(iter_7_1)

		table.insert(self.rankList, var_7_1)

		if var_7_0 and var_7_1.user_id == var_7_0.userID then
			self.curRank = var_7_1
		end
	end
end

function GuildRankTemplate:GetCurRankDes()
	if not self.curRank then
		return GetTips("MATRIX_RANK_NO_RANK"), GetTips("MATRIX_RANK_NO_INFO")
	end

	local var_8_0 = ""
	local var_8_1 = ""

	if self.curRank.rank == 0 then
		var_8_0 = GetTips("MATRIX_RANK_NO_RANK")
		var_8_1 = GetTips("MATRIX_RANK_NO_INFO")
	elseif self.curRank.rank >= 1 and self.curRank.rank <= 100 then
		var_8_0 = tostring(self.curRank.rank)
		var_8_1 = tostring(self.curRank.score)
	else
		local var_8_2 = GuildData:GetGuildInfo()

		var_8_0 = not var_8_2 and "0%" or string.format("%.2f", self.curRank.rank / var_8_2.memberCnt * 100) .. "%"
		var_8_1 = tostring(self.curRank.score)
	end

	return var_8_0, var_8_1
end

RankInfoTemplate = class("RankInfoTemplate")

function RankInfoTemplate:Ctor(arg_9_1)
	self.user_id = arg_9_1.user_id
	self.score = arg_9_1.score
	self.difficulty = arg_9_1.difficulty
	self.rank = arg_9_1.rank
	self.timestamp = arg_9_1.timestamp

	local var_9_0 = PlayerData:GetPlayerInfo()

	if var_9_0 and self.user_id == var_9_0.userID then
		self.nick = var_9_0.nick
		self.portrait = var_9_0.portrait
		self.frame = var_9_0.icon_frame
	else
		self.nick = arg_9_1.nick
		self.portrait = arg_9_1.portrait
		self.frame = arg_9_1.frame
	end

	self.stage_team_list = {}

	for iter_9_0, iter_9_1 in ipairs(arg_9_1.stage_team_list) do
		local var_9_1 = iter_9_1.stage_id or 0
		local var_9_2 = {}

		for iter_9_2, iter_9_3 in ipairs(iter_9_1.team_info_list) do
			local var_9_3 = {}

			for iter_9_4, iter_9_5 in ipairs(iter_9_3.hero_info_list) do
				table.insert(var_9_3, {
					hero_id = iter_9_5.hero_id,
					skin_id = iter_9_5.skin_id
				})
			end

			var_9_2[iter_9_3.index] = var_9_3
		end

		self.stage_team_list[var_9_1] = var_9_2
	end

	self.staticInfo = {}
	self.staticInfo.clearTime = arg_9_1.static_info.clear_time
	self.staticInfo.hitNumber = arg_9_1.static_info.hit_num
	self.extraInfo = {}

	for iter_9_6, iter_9_7 in ipairs(cleanProtoTable(arg_9_1.extra_info)) do
		self.extraInfo[iter_9_7.key] = iter_9_7.value
	end
end

function RankInfoTemplate:GetSingleSelectHeroList()
	if not self.stage_team_list[0] then
		return {}
	end

	return self.stage_team_list[0][1] or {}
end
