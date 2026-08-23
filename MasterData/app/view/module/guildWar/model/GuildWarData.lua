local var_0_0 = g.core.config.guild_war_parameter_info
local var_0_1 = g.core.config.guild_war_info
local var_0_2 = g.core.config.guild_war_achievement_info
local var_0_3 = g.core.config.guild_war_map_info
local var_0_4 = g.core.const.ConstMgr
local var_0_5 = g.core.const.ConstMgr.GuildWarConst
local var_0_6 = g.core.const.ConstMgr.GuildWarConst.StageType
local var_0_7 = g.core.const.ConstMgr.GuildWarConst.FightStageType
local var_0_8 = 3001
local var_0_9 = 3002
local var_0_10 = "guild_war_lamu_cache.json"
local var_0_11 = {
	AVAILABLE = 1,
	RECEIVED = 2,
	NO_REACH = 0
}
local var_0_12 = {
	TYPE_LEADER = 1,
	TYPE_VICE_LEADER = 2
}
local var_0_13 = g.core.common.ServerTime
local GuildWarCityStruct = import(".GuildWarCityStruct")
local GuildWarRankStructData = import(".GuildWarRankStructData")
local GuildWarGuildStruct = import(".GuildWarGuildStruct")
local var_0_17 = g.core.model.User.guildData
local GuildWarData = class("GuildWarData")

function GuildWarData:ctor()
	self:initData()
end

function GuildWarData:initData()
	self._startTime = 0
	self._drillEndTime = 0
	self._dayDeployEndTime = var_0_0.get(var_0_8).parameter
	self._dayFightingEndTime = var_0_0.get(var_0_9).parameter
	self._fightEndTime = 0
	self._seasonResultEndTime = 0
	self._curEnterGuildId = 0
	self._formationData = GuildWarCityStruct.new()
	self._warMapTypeKCfg = {}
	self._achieveIdMap = {}
	self._achieveList = {}
	self._actionInfoArr = {}
	self._guildStructDict = {}
	self._achieveServerData = {}
	self._serverList = {}
	self._drillLeftChallengeCount = 0
	self._drillRank = 0
	self._drillGuildScore = 0
	self._drillUserScore = 0
	self._fightResultBadgeList = {}
	self._seasonResultBadgeList = {}
	self._fightingRank = 0
	self._fightingGroupIndex = var_0_5.GROUP_INDEX.ELITE
	self._myGuildJoinNum = 0
	self._preDestroyIds = {}
	self._subId = 0
	self._baseScore = 0
	self._isWaitDrillBattle = false
	self._showSaveCache = g.core.common.Storage:load(var_0_10) or {}
	self._rankStructData = GuildWarRankStructData.new()

	self:initBuildCfg()
	self:initAchieve()
end

function GuildWarData:_logActivityInfo()
	g.core.log:info("---------      当前时间：", var_0_13:getTimeString())
	g.core.log:info("---------      演练开始时间：", var_0_13:getTimeString(self._startTime))
	g.core.log:info("---------      演练结束时间：", var_0_13:getTimeString(self._drillEndTime))
	g.core.log:info("---------      作战结束时间：", var_0_13:getTimeString(self._fightEndTime))
	g.core.log:info("---------      赛季结算结束时间：", var_0_13:getTimeString(self._seasonResultEndTime))
end

function GuildWarData:onS2CFlushRedPoint(arg_4_1)
	if not arg_4_1 then
		return
	end

	self:_initTimeData(arg_4_1.start_time, arg_4_1.activityId)

	self._drillLeftChallengeCount = arg_4_1.practice_num or 0
	self._achieveServerData = arg_4_1.achieve_num or self._achieveServerData
	self._drillGuildScore = arg_4_1.practice_score or 0

	self:updateAchieveInfo()
end

function GuildWarData:onS2CGetInfo(arg_5_1)
	self:_initTimeData(arg_5_1.start_time, arg_5_1.sub_id)
	self:_initGuildStructDict(arg_5_1)
	self:onS2CAchievesGetInfo(arg_5_1)

	self._drillLeftChallengeCount = arg_5_1.left_practice_times or 0
	self._drillRank = arg_5_1.practice_rank or 0
	self._drillGuildScore = arg_5_1.practice_score or 0
	self._drillUserScore = arg_5_1.user_practice_score or 0
	self._fightingGroupIndex = arg_5_1.war_group and arg_5_1.war_group or self:getDrillRankGroup(self._drillRank)
	self._subId = arg_5_1.sub_id or 0
	self._myGuildJoinNum = arg_5_1.join_people or 0
	self._fightResultBadgeList = arg_5_1.titles or {}
	self._seasonResultBadgeList = arg_5_1.honor_guilds or {}
end

function GuildWarData:onS2CPractice(arg_6_1)
	self._drillLeftChallengeCount = self._drillLeftChallengeCount - 1
	self._drillUserScore = (arg_6_1.score or 0) + self._drillUserScore
end

function GuildWarData:onS2CPracticeNotify(arg_7_1)
	self._drillRank = arg_7_1.self_rank or self._drillRank

	if arg_7_1.guild_id and arg_7_1.guild_id == g.core.model.User:getGuildId() then
		self._drillGuildScore = arg_7_1.score or self._drillGuildScore
	end

	self._rankStructData:updateDrillRankListByNotify(arg_7_1)
end

function GuildWarData:onS2CAchieveNotify(arg_8_1)
	return
end

function GuildWarData:onS2CFormat(arg_9_1)
	local var_9_0 = self:getCurWatchGuildId()

	if var_9_0 ~= 0 then
		g.core.network.GameNetProxy:send_C2S_GuildWar_GetFormation({
			guild_id = var_9_0
		})
	end
end

function GuildWarData:onS2CAttackDefenderBegin(arg_10_1)
	return
end

function GuildWarData:onS2CAttackDefenderFinish(arg_11_1)
	return
end

function GuildWarData:onS2CGetFormation(arg_12_1)
	self._curEnterGuildId = arg_12_1.guild_id or self._curEnterGuildId

	self._formationData:setGuildId(self._curEnterGuildId)
	self._formationData:updateData(arg_12_1)
end

function GuildWarData:onS2CFireOn(arg_13_1)
	return
end

function GuildWarData:onS2CAttackBuilding(arg_14_1)
	return
end

function GuildWarData:onS2CNotify(arg_15_1)
	local var_15_0 = self:getGuildWarGuildStruct(arg_15_1.guild_id)

	var_15_0:setTodayRobScore(arg_15_1.today_rob_score)
	var_15_0:setTodayDefendScore(arg_15_1.today_defend_score)

	local var_15_1 = self:getGuildWarGuildStruct(arg_15_1.self_guild_id)

	var_15_1:setTodayRobScore(arg_15_1.self_today_rob_score)
	var_15_1:setTodayDefendScore(arg_15_1.self_today_defend_score)

	if self._curEnterGuildId == arg_15_1.guild_id then
		local var_15_2 = self:getBuildDataById(arg_15_1.build_id)

		if var_15_2 then
			if arg_15_1.notify_type == 1 then
				var_15_2:setCostHp(arg_15_1.total_lost_hp or 0)
				var_15_2:setCostScore(arg_15_1.build_lost_score or 0)
			else
				local var_15_4 = var_15_2:getUserByPosition(arg_15_1.position)

				if var_15_4 then
					var_15_4:setCostHp(arg_15_1.total_lost_hp or 0)
				end
			end
		end
	end
end

function GuildWarData:onS2CGetServerInfo(arg_16_1)
	self._serverList = arg_16_1.servers or {}
end

function GuildWarData:onS2COpTab(arg_17_1)
	return
end

function GuildWarData:onS2CAchievesGetInfo(arg_18_1)
	self._achieveServerData = arg_18_1.achieves or {}

	for iter_18_0, iter_18_1 in ipairs(self._achieveServerData) do
		if self._achieveIdMap[iter_18_1.id] then
			self._achieveIdMap[iter_18_1.id].state = iter_18_1.state
			self._achieveIdMap[iter_18_1.id].curValue = iter_18_1.value
		end
	end
end

function GuildWarData:onS2CAchievesAward(arg_19_1)
	if not arg_19_1 then
		return
	end

	local var_19_0 = arg_19_1.id or 0

	if self._achieveIdMap[var_19_0] then
		self._achieveIdMap[var_19_0].state = var_0_11.RECEIVED
	end
end

function GuildWarData:onS2CReportGetInfo(arg_20_1)
	self._actionInfoArr = arg_20_1.report or {}

	table.sort(self._actionInfoArr, function(arg_21_0, arg_21_1)
		return arg_21_0.id > arg_21_1.id
	end)
end

function GuildWarData:onS2CCommonRankList(arg_22_1)
	if arg_22_1.id == g.core.network.proto.GUILD_WAR_PRACTICE_SCORE_CROSS then
		self._drillRank = arg_22_1.self_rank or 0
	end

	self._rankStructData:insetRankList(arg_22_1)
end

function GuildWarData:onSwapUserBuild(arg_23_1)
	local var_23_0 = self:getCurWatchGuildId()

	if var_23_0 ~= 0 then
		g.core.network.GameNetProxy:send_C2S_GuildWar_GetFormation({
			guild_id = var_23_0
		})
	end
end

function GuildWarData:onS2CSetStrategy(arg_24_1)
	local var_24_0 = self:getGuildWarGuildStruct(arg_24_1.guild_id)

	if var_24_0 then
		var_24_0:setStrategyType(arg_24_1.strategy)
	end
end

function GuildWarData:onS2CGuildFastJoin()
	if self:isShowEntrance() and self._drillGuildScore == 0 then
		g.core.network.GameNetProxy:send_C2S_GuildWar_GetInfo({})
	end
end

function GuildWarData:onS2CGuildNotifyJoin()
	self:onS2CGuildFastJoin()
end

function GuildWarData:_initTimeData(arg_27_1, arg_27_2)
	arg_27_1 = arg_27_1 or 0
	self._startTime = arg_27_1

	local var_27_0 = var_0_1.get(arg_27_2)

	self._drillEndTime = arg_27_1 + var_27_0.end_time_1
	self._fightEndTime = arg_27_1 + var_27_0.end_time_2
	self._seasonResultEndTime = arg_27_1 + var_27_0.end_time_3
end

function GuildWarData:_initGuildStructDict(arg_28_1)
	for iter_28_0, iter_28_1 in ipairs(arg_28_1.opposites or {}) do
		self:getGuildWarGuildStruct(iter_28_1.guild.id):updateWithSvrData(iter_28_1)
	end

	local var_28_1 = self:getMyGuildStruct()

	if var_28_1 then
		var_28_1:updateWithSvrData(arg_28_1)
	end

	for iter_28_2, iter_28_3 in ipairs(arg_28_1.strategy or {}) do
		self:getGuildWarGuildStruct(iter_28_3.guild_id):setStrategyType(iter_28_3.strategy)
	end

	local var_28_2 = table.values(self._guildStructDict)

	table.sort(var_28_2, self:getGuildStructSortFunc_2())

	for iter_28_4, iter_28_5 in ipairs(var_28_2) do
		iter_28_5:setCityName(g.core.lang:get(308638 + iter_28_4))
	end
end

function GuildWarData:getStageType()
	local var_29_0 = var_0_13:getTime()

	if var_29_0 <= self._startTime then
		return var_0_6.NONE
	elseif var_29_0 <= self._drillEndTime then
		return var_0_6.DRILL
	elseif var_29_0 <= self._fightEndTime then
		return var_0_6.FIGHT
	elseif var_29_0 <= self._seasonResultEndTime then
		return var_0_6.SEASON_RESULT
	else
		return var_0_6.NONE
	end
end

function GuildWarData:getFightStageType()
	local var_30_0 = var_0_13:getTimeFromZero((var_0_13:getTime()))

	if var_30_0 <= self._dayDeployEndTime then
		return var_0_7.DEPLOY
	elseif var_30_0 <= self._dayFightingEndTime then
		return var_0_7.FIGHTING
	else
		return var_0_7.WAR_RESULT
	end
end

function GuildWarData:getWarNumNow()
	return math.max(1, math.ceil((math.clamp(var_0_13:getTime(), self._drillEndTime, self._fightEndTime) - self._drillEndTime) / 86400))
end

function GuildWarData:getMaxWarNum()
	return math.max(1, (math.ceil((self._fightEndTime - self._drillEndTime) / 86400)))
end

function GuildWarData:getStartEndTime(arg_33_1, arg_33_2)
	if arg_33_1 == var_0_6.DRILL then
		return self._startTime, self._drillEndTime
	elseif arg_33_1 == var_0_6.FIGHT then
		local var_33_0 = var_0_13:getZeroClockSeconds()

		if arg_33_2 == var_0_7.DEPLOY then
			return var_33_0, var_33_0 + self._dayDeployEndTime
		elseif arg_33_2 == var_0_7.FIGHTING then
			return var_33_0 + self._dayDeployEndTime, var_33_0 + self._dayFightingEndTime
		elseif arg_33_2 == var_0_7.WAR_RESULT then
			return var_33_0 + self._dayFightingEndTime, var_33_0 + 86400
		else
			return self._drillEndTime, self._fightEndTime
		end
	elseif arg_33_1 == var_0_6.SEASON_RESULT then
		return self._fightEndTime, self._seasonResultEndTime
	else
		return 0, 0
	end
end

function GuildWarData:isOpen()
	if g.core.common.ModuleUnlock:isModuleUnlock(var_0_4.FUNCTION_TYPE.GUILD_WAR) then
		local var_34_0 = self:getStageType()

		if var_34_0 == var_0_6.NONE then
			return false, g.core.lang:get(308613)
		elseif var_34_0 == var_0_6.DRILL then
			return true, ""
		else
			return self._drillGuildScore > 0, g.core.lang:get(308657)
		end
	else
		return false, g.core.config.function_info.get(var_0_4.FUNCTION_TYPE.GUILD_WAR).lock_direction
	end
end

function GuildWarData:isShowEntrance()
	return self:getStageType() ~= var_0_6.NONE
end

function GuildWarData:isOpenChat()
	if self:isOpen() then
		return self:getStageType() == var_0_6.FIGHT
	end

	return false
end

function GuildWarData:initBuildCfg()
	self._baseScore = 0

	local var_37_0 = {}
	local var_37_1 = {}

	for iter_37_0, iter_37_1 in var_0_3.ipairs() do
		if iter_37_1.next_id ~= 0 then
			if var_37_0[iter_37_1.next_id] then
				table.insert(var_37_0[iter_37_1.next_id], iter_37_1.id)
			else
				var_37_0[iter_37_1.next_id] = {
					iter_37_1.id
				}
			end
		end

		local var_37_2 = iter_37_1.build_type

		if var_37_1[iter_37_1.build_type] then
			table.insert(var_37_1[var_37_2], iter_37_1)
		else
			var_37_1[var_37_2] = {
				iter_37_1
			}
		end

		self._baseScore = self._baseScore + iter_37_1.build_score
	end

	self._preDestroyIds = var_37_0
	self._warMapTypeKCfg = var_37_1
end

function GuildWarData:initAchieve()
	local var_38_0 = {}
	local var_38_1 = {}

	for iter_38_0, iter_38_1 in var_0_2.ipairs() do
		local var_38_2 = {
			curValue = 0,
			info = iter_38_1,
			state = var_0_11.NO_REACH
		}

		table.insert(var_38_0, var_38_2)

		var_38_1[iter_38_1.id] = var_38_2
	end

	self._achieveList = var_38_0
	self._achieveIdMap = var_38_1
end

function GuildWarData:getBuildDataById(arg_39_1)
	return self._formationData:getBuildById(arg_39_1)
end

function GuildWarData:getBuildDataByPlayerId(arg_40_1)
	return self._formationData:getBuildByPlayerId(arg_40_1)
end

function GuildWarData:getAchieveAward(arg_41_1)
	local var_41_0 = {}

	for iter_41_0, iter_41_1, iter_41_2 in var_0_2.get(arg_41_1).gmatch({
		"reward_type_%d+",
		"reward_value_%d+",
		"reward_size_%d+"
	}) do
		table.insert(var_41_0, {
			type = iter_41_2[1],
			value = iter_41_2[2],
			size = iter_41_2[3]
		})
	end

	return var_41_0
end

function GuildWarData:isLeader()
	local var_42_0 = var_0_17:getMyRightId()

	return var_42_0 == var_0_12.TYPE_LEADER or var_42_0 == var_0_12.TYPE_VICE_LEADER
end

function GuildWarData:getMyGuildId()
	if var_0_17:hasGuild() then
		return var_0_17:getGuildId()
	end

	return 0
end

function GuildWarData:getGuildWarGuildStruct(arg_44_1)
	assert(arg_44_1 > 0, "Error! GuildId is invalid: " .. tostring(arg_44_1))

	local var_44_0 = self._guildStructDict[arg_44_1]

	if not self._guildStructDict[arg_44_1] then
		var_44_0 = GuildWarGuildStruct.new(arg_44_1)
		self._guildStructDict[arg_44_1] = var_44_0
	end

	return var_44_0
end

function GuildWarData:getMyGuildStruct()
	if var_0_17:hasGuild() then
		return self:getGuildWarGuildStruct((var_0_17:getGuildId()))
	end
end

function GuildWarData:getSelfGuildFormation()
	return self._formationData
end

function GuildWarData:isAllLineUp()
	local var_47_0 = var_0_17:getMemberData()
	local var_47_1 = self._formationData:getAllUpLineUserNum()

	return var_47_1 >= var_0_5.ALL_POSITION_NUM or var_47_1 == #var_47_0
end

function GuildWarData:getBuildCfgByType(arg_48_1)
	return self._warMapTypeKCfg[arg_48_1]
end

function GuildWarData:getServerList()
	return self._serverList
end

function GuildWarData:getLastDrillCount()
	return self._drillLeftChallengeCount
end

function GuildWarData:getDrillRank()
	return self._drillRank
end

function GuildWarData:getDrillRankList()
	return self._rankStructData:getDrillRankList()
end

function GuildWarData:getFightRankList(arg_53_1)
	return self._rankStructData:getFightRankList(arg_53_1)
end

function GuildWarData:getDrillGuildScore()
	return self._drillGuildScore
end

function GuildWarData:getDrillUserScore()
	return self._drillUserScore
end

function GuildWarData:getMyGuildJoinNum()
	return self._myGuildJoinNum
end

function GuildWarData:getCurFightingGroup()
	return self._fightingGroupIndex
end

function GuildWarData:getFightResultBadgeList()
	return self._fightResultBadgeList
end

function GuildWarData:getSeasonResultBadgeList()
	return self._seasonResultBadgeList
end

function GuildWarData:getDrillRankGroup(arg_60_1)
	local var_60_0 = arg_60_1 or self:getDrillRank()

	if var_60_0 > var_0_5.GROUP_NUM.MASTER then
		return var_0_5.GROUP_INDEX.ELITE
	elseif var_60_0 > var_0_5.GROUP_NUM.KING then
		return var_0_5.GROUP_INDEX.MASTER
	elseif var_60_0 > 0 then
		return var_0_5.GROUP_INDEX.KING
	end

	return var_0_5.GROUP_INDEX.ELITE
end

function GuildWarData:getAchieveList()
	return self._achieveList
end

function GuildWarData:getSortAchieveFunc()
	return function(arg_63_0, arg_63_1)
		if arg_63_0.state == var_0_11.AVAILABLE ~= (arg_63_1.state == var_0_11.AVAILABLE) then
			return arg_63_0.state == var_0_11.AVAILABLE
		end

		if arg_63_0.state ~= arg_63_1.state then
			return arg_63_0.state < arg_63_1.state
		end

		return arg_63_0.info.order < arg_63_1.info.order
	end
end

function GuildWarData:getActionInfoArr()
	return self._actionInfoArr
end

function GuildWarData:getGuildMemberGroup()
	local var_65_0 = {}
	local var_65_1 = {}
	local var_65_2 = var_0_17:getMemberData()

	table.sort(var_65_2, function(arg_66_0, arg_66_1)
		local var_66_0 = arg_66_1.user

		if arg_66_0.user.fight_value ~= arg_66_1.user.fight_value then
			return arg_66_0.user.fight_value > var_66_0.fight_value
		end

		return arg_66_0.user.id < var_66_0.id
	end)

	local var_65_3 = math.ceil(var_0_0.get(var_0_5.GROUP_ID).parameter / 1000 * #var_65_2)

	for iter_65_0, iter_65_1 in ipairs(var_65_2) do
		if iter_65_0 <= var_65_3 then
			table.insert(var_65_0, iter_65_1)
		else
			table.insert(var_65_1, iter_65_1)
		end
	end

	return {
		group1 = var_65_0,
		group2 = var_65_1
	}
end

function GuildWarData:getMyGroup()
	local var_67_0 = self:getGuildMemberGroup()
	local var_67_1 = g.core.model.User:getId()

	for iter_67_0, iter_67_1 in ipairs(var_67_0.group1) do
		if iter_67_1.user.id == var_67_1 then
			return var_0_5.GROUP_TYPE.FIRED
		end
	end

	for iter_67_2, iter_67_3 in ipairs(var_67_0.group2) do
		if iter_67_3.user.id == var_67_1 then
			return var_0_5.GROUP_TYPE.AFTER
		end
	end
end

function GuildWarData:getUserState(arg_68_1)
	if not arg_68_1 or not arg_68_1:getUsers() or #arg_68_1:getUsers() == 0 then
		return var_0_5.PLAYER_STATE.EMPTY
	end

	local var_68_0 = var_0_3.get(arg_68_1:getBuildId())

	for iter_68_0, iter_68_1 in pairs(arg_68_1:getUsers()) do
		if var_68_0.people_hp - iter_68_1:getCostHp() > 0 then
			return var_0_5.PLAYER_STATE.ALIVE
		end
	end

	return var_0_5.PLAYER_STATE.DEAD
end

function GuildWarData:hasMemberNotLineUp()
	return self._formationData:getAllUpLineUserNum() < #var_0_17:getMemberData()
end

function GuildWarData:isBuildPositionCanLineUp(arg_70_1, arg_70_2)
	if self._formationData:isMyGuild() then
		if self._formationData:getBuildById(arg_70_1):isPositionUserEmpty(arg_70_2) then
			return self:hasMemberNotLineUp()
		end
	end

	return false
end

function GuildWarData:isUserEmpty(arg_71_1)
	local var_71_0 = self:getUserState(arg_71_1)

	return var_71_0 == var_0_5.PLAYER_STATE.EMPTY or var_71_0 == var_0_5.PLAYER_STATE.DEAD
end

function GuildWarData:isCurMineStation()
	return self._curEnterGuildId == self:getMyGuildId()
end

function GuildWarData:isBuildDestroy(arg_73_1)
	if self:getUserState(arg_73_1) == var_0_5.PLAYER_STATE.ALIVE then
		return false
	end

	return arg_73_1:getCfg().build_hp - arg_73_1:getCostHp() <= 0
end

function GuildWarData:canFightTargetBuild(arg_74_1)
	if self._preDestroyIds[arg_74_1] then
		for iter_74_0, iter_74_1 in ipairs(self._preDestroyIds[arg_74_1]) do
			if self:isBuildDestroy((self:getBuildDataById(iter_74_1))) then
				return true
			end
		end

		return false
	end

	return true
end

function GuildWarData:getDayDeployEndTime()
	return self._dayDeployEndTime
end

function GuildWarData:getDayFightingEndTime()
	return self._dayFightingEndTime
end

function GuildWarData:getGuildStructSortFunc()
	return function(arg_78_0, arg_78_1)
		local var_78_0 = arg_78_0:getTodayTotalScore()
		local var_78_1 = arg_78_1:getTodayTotalScore()

		if var_78_0 ~= var_78_1 then
			return var_78_1 < var_78_0
		elseif arg_78_0.todayRank ~= arg_78_1.todayRank and arg_78_0.todayRank > 0 and arg_78_1.todayRank > 0 then
			return arg_78_0.todayRank < arg_78_1.todayRank
		else
			return arg_78_0.guildSnapshot.fight_value > arg_78_1.guildSnapshot.fight_value
		end
	end
end

function GuildWarData:getGuildStructSortFunc_2()
	return function(arg_80_0, arg_80_1)
		return arg_80_0.guildId < arg_80_1.guildId
	end
end

function GuildWarData:getEnemyGuildStructArr()
	local var_81_0 = {}

	for iter_81_0, iter_81_1 in pairs(self._guildStructDict) do
		if not iter_81_1:isMyGuild() then
			table.insert(var_81_0, iter_81_1)
		end
	end

	return var_81_0
end

function GuildWarData:getAllGuildStructArr()
	return table.values(self._guildStructDict)
end

function GuildWarData:getSubId()
	return self._subId
end

function GuildWarData:getCurWatchGuildId()
	return self._curEnterGuildId
end

function GuildWarData:getTestAward()
	return var_0_1.get(self._subId).test_award_req
end

function GuildWarData:getBattleAward()
	return var_0_1.get(self._subId).battle_award_req
end

function GuildWarData:getSeasonAward()
	return var_0_1.get(self._subId).season_award_req
end

function GuildWarData:updateAchieveInfo()
	for iter_88_0, iter_88_1 in ipairs(self._achieveServerData) do
		if self._achieveIdMap[iter_88_1.id] then
			self._achieveIdMap[iter_88_1.id].state = iter_88_1.state
			self._achieveIdMap[iter_88_1.id].curValue = iter_88_1.value
		end
	end
end

function GuildWarData:getCurStageTypeDesc()
	local var_89_0 = self:getStageType()
	local var_89_1 = 308613

	if var_89_0 == var_0_6.DRILL then
		var_89_1 = 308614
	elseif var_89_0 == var_0_6.FIGHT then
		local var_89_2 = self:getFightStageType()

		var_89_1 = var_89_2 == var_0_7.DEPLOY and 308615 or var_89_2 == var_0_7.FIGHTING and 308616 or 308617
	elseif var_89_0 == var_0_6.SEASON_RESULT then
		var_89_1 = 308618
	end

	return g.core.lang:get(var_89_1)
end

function GuildWarData:getAllBaseScore()
	return self._baseScore
end

function GuildWarData:getMyFightRank()
	return self._rankStructData:getRankBuGroup(self._fightingGroupIndex)
end

function GuildWarData:getRankStrByGroup(arg_92_1, arg_92_2)
	local var_92_0 = 308635

	if arg_92_1 == var_0_5.GROUP_INDEX.MASTER then
		var_92_0 = 308636
	elseif arg_92_1 == var_0_5.GROUP_INDEX.ELITE then
		var_92_0 = 308637
	end

	return (g.core.lang:get(var_92_0, {
		rank = arg_92_2
	}))
end

function GuildWarData:resetExitData()
	self._rankStructData:clearRankData()

	self._fightResultBadgeList = {}
	self._seasonResultBadgeList = {}
	self._guildStructDict = {}
end

function GuildWarData:isExistTaskAward(arg_94_1)
	for iter_94_0, iter_94_1 in ipairs(self._achieveList) do
		if iter_94_1.state == var_0_11.AVAILABLE then
			return true
		end
	end

	return false
end

function GuildWarData:isNeedDispatchGuildMember(arg_95_1)
	if not self:isLeader() then
		return false
	end

	if self:getStageType() ~= var_0_6.FIGHT then
		return false
	end

	if self:getFightStageType() == var_0_7.DEPLOY then
		if arg_95_1.buildId then
			return self:isBuildPositionCanLineUp(arg_95_1.buildId, arg_95_1.pos or 1)
		end
	end

	return false
end

function GuildWarData:setIsWaitDrillBattle(arg_96_1)
	self._isWaitDrillBattle = arg_96_1
end

function GuildWarData:getIsWaitDrillBattle()
	return self._isWaitDrillBattle
end

function GuildWarData:isNeedShowLamu(arg_98_1)
	local var_98_0 = os.date("*t", (g.core.common.ServerTime:getTime()))

	if self._showSaveCache[var_98_0.year .. "_" .. var_98_0.month .. "_" .. var_98_0.day .. arg_98_1] then
		return false
	else
		self._showSaveCache[var_98_0.year .. "_" .. var_98_0.month .. "_" .. var_98_0.day .. arg_98_1] = true

		g.core.common.Storage:save(var_0_10, self._showSaveCache)

		return true
	end
end

function GuildWarData:isNeedShowNewSeasonLamu()
	local var_99_0 = tostring(self._startTime) .. "s"

	if self._showSaveCache[var_99_0] then
		return false
	end

	self._showSaveCache[var_99_0] = true

	g.core.common.Storage:save(var_0_10, self._showSaveCache)

	return true
end

function GuildWarData:getTimeData()
	return self._startTime, self._seasonResultEndTime
end

function GuildWarData:enteredMineCityLayer()
	if self:isLeader() then
		if not self._showSaveCache["goInMineCityLayer_" .. self._startTime] then
			self._showSaveCache["goInMineCityLayer_" .. self._startTime] = 1

			g.core.common.Storage:save(var_0_10, self._showSaveCache)
		end
	end
end

function GuildWarData:isHaveDrillNumOnDrillStage()
	if self:isOpen() and self:getStageType() == var_0_6.DRILL then
		return self._drillLeftChallengeCount > 0
	end

	return false
end

function GuildWarData:isLeaderNotGoInMineCityLayerThisSeason()
	if self:isOpen() and self:isLeader() and self:getStageType() == var_0_6.FIGHT and self:getFightStageType() == var_0_7.DEPLOY then
		return not self._showSaveCache["goInMineCityLayer_" .. self._startTime]
	end

	return false
end

function GuildWarData:isHaveFightNumOnFighting()
	if not self:isOpen() then
		return false
	end

	if self:getStageType() == var_0_6.FIGHT and self:getFightStageType() == var_0_7.FIGHTING then
		return g.core.model.User.resourceData:getGuildWar() > 0
	end

	return false
end

function GuildWarData:getGuildScorePercentage(arg_105_1)
	local var_105_0 = self:getGuildWarGuildStruct(arg_105_1)

	if not var_105_0 then
		return 0
	end

	local var_105_1 = 100

	if self._baseScore > 0 then
		var_105_1 = var_105_0:getTodayTotalScore() / self._baseScore * 100
	end

	if var_105_1 > 90 then
		return math.floor(var_105_1)
	else
		return math.ceil(var_105_1)
	end
end

return GuildWarData
