local var_0_0 = 50
local var_0_1 = g.core.network.proto.GUILD_WAR_PRACTICE_SCORE_CROSS
local var_0_2 = {
	[g.core.const.ConstMgr.GuildWarConst.GROUP_INDEX.KING] = g.core.network.proto.GUILD_WAR_GUILD_CROSS_KING,
	[g.core.const.ConstMgr.GuildWarConst.GROUP_INDEX.MASTER] = g.core.network.proto.GUILD_WAR_GUILD_CROSS_MASTER,
	[g.core.const.ConstMgr.GuildWarConst.GROUP_INDEX.ELITE] = g.core.network.proto.GUILD_WAR_GUILD_CROSS_ELITE
}
local GuildWarRankStructData = class("GuildWarRankStructData")

function GuildWarRankStructData:ctor()
	self._rankList = {}
	self._selfRank = {}
end

function GuildWarRankStructData:updateDrillRankListByNotify(arg_2_1)
	if not self._rankList[var_0_1] then
		return
	end

	local var_2_0 = false

	for iter_2_0, iter_2_1 in ipairs(self._rankList[var_0_1]) do
		if iter_2_1.guildId == arg_2_1.guild_id then
			var_2_0 = true
			iter_2_1.score = arg_2_1.score
			iter_2_1.rank = arg_2_1.rank

			break
		end
	end

	if not var_2_0 and #self._rankList[var_0_1] < var_0_0 then
		table.insert(self._rankList[var_0_1], {
			guildId = arg_2_1.guild_id,
			guildName = arg_2_1.guild_name,
			serverName = arg_2_1.server_name,
			score = arg_2_1.score,
			rank = arg_2_1.rank
		})
	end

	table.sort(self._rankList[var_0_1], function(arg_3_0, arg_3_1)
		if arg_3_0.score ~= arg_3_1.score then
			return arg_3_0.score > arg_3_1.score
		else
			return arg_3_0.rank < arg_3_1.rank
		end
	end)

	self._rankList[var_0_1] = self._rankList[var_0_1]
end

function GuildWarRankStructData:getDrillRankList()
	return self._rankList[var_0_1]
end

function GuildWarRankStructData:insetRankList(arg_5_1)
	local var_5_1 = {}

	for iter_5_0, iter_5_1 in pairs(arg_5_1.rank_units or {}) do
		if iter_5_1.id and iter_5_1.id > 0 then
			table.insert(var_5_1, {
				guildId = iter_5_1.id,
				rank = iter_5_1.rank,
				score = iter_5_1.score
			})
		end
	end

	self._rankList[arg_5_1.id] = var_5_1
	self._selfRank[arg_5_1.id] = arg_5_1.self_rank
end

function GuildWarRankStructData:getFightRankList(arg_6_1)
	return self._rankList[var_0_2[arg_6_1]], var_0_2[arg_6_1]
end

function GuildWarRankStructData:getRankBuGroup(arg_7_1)
	return self._selfRank[var_0_2[arg_7_1]] or 0
end

function GuildWarRankStructData:clearRankData()
	self._rankList = {}
	self._selfRank = {}
end

return GuildWarRankStructData
