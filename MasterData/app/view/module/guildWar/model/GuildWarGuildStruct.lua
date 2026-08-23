local var_0_0 = g.core.const.ConstMgr.GuildWarConst
local var_0_1 = g.core.model.User.guildData
local GuildWarGuildStruct = class("GuildWarGuildStruct")

function GuildWarGuildStruct:ctor(arg_1_1)
	self.guildId = arg_1_1
	self.cityName = ""
	self.todayRobScore = 0
	self.todayDefendScore = 0
	self.totalRobScore = 0
	self.totalDefendScore = 0
	self.cityState = var_0_0.CityState.ALIVE
	self.joinNum = 0
	self.strategyType = var_0_0.StrategyType.NONE
	self.todayRank = 0
	self.guildSnapshot = {}
end

function GuildWarGuildStruct:updateWithSvrData(arg_2_1)
	arg_2_1 = arg_2_1 or {}

	if self:isMyGuild() then
		self.guildSnapshot = var_0_1:getGuildData()
		self.todayRobScore = arg_2_1.today_rob_score or 0
		self.todayDefendScore = arg_2_1.today_defend_score or 0
		self.cityState = arg_2_1.stage or var_0_0.CityState.ALIVE
		self.joinNum = arg_2_1.join_people or 0
		self.totalRobScore = arg_2_1.rob_score or 0
		self.totalDefendScore = arg_2_1.defend_score or 0
		self.todayRank = arg_2_1.battle_rank or 0
	else
		self.guildSnapshot = arg_2_1.guild or {}
		self.todayRobScore = arg_2_1.rob_score or 0
		self.todayDefendScore = arg_2_1.defend_score or 0
		self.cityState = arg_2_1.stage or var_0_0.CityState.ALIVE
		self.joinNum = arg_2_1.join_num or 0
		self.todayRank = arg_2_1.battle_rank or 0
	end
end

function GuildWarGuildStruct:setCityName(arg_3_1)
	self.cityName = arg_3_1 or ""
end

function GuildWarGuildStruct:setStrategyType(arg_4_1)
	self.strategyType = arg_4_1 or var_0_0.StrategyType.NONE
end

function GuildWarGuildStruct:setTodayRobScore(arg_5_1)
	self.todayRobScore = arg_5_1 or 0
end

function GuildWarGuildStruct:setTodayDefendScore(arg_6_1)
	self.todayDefendScore = arg_6_1 or 0
end

function GuildWarGuildStruct:isMyGuild()
	if var_0_1:hasGuild() then
		return var_0_1:getGuildId() == self.guildId
	end

	return false
end

function GuildWarGuildStruct:getTotalScore()
	if self:isMyGuild() then
		return self.totalRobScore + self.totalDefendScore
	else
		return self:getTodayTotalScore()
	end
end

function GuildWarGuildStruct:getTodayTotalScore()
	return self.todayRobScore + self.todayDefendScore
end

return GuildWarGuildStruct
