local var_0_0 = g.core.config.chief_arena_robot_info
local var_0_1 = g.core.config.chief_arena_info
local var_0_2 = g.core.config.chief_arena_buff_info
local var_0_3 = g.core.config.chief_arena_score_info
local var_0_4 = g.core.config.talent_skill_info
local var_0_5 = g.core.config.attribute_info
local var_0_6 = g.core.config.chief_arena_skill_info
local var_0_7 = g.core.config.chief_arena_guild_info
local var_0_8 = g.core.model.User.mulFormationData
local var_0_10 = g.core.common.Storage
local var_0_11 = g.core.common.ServerTime
local var_0_12 = g.core.const.ConstMgr
local var_0_13 = g.core.const.ConstMgr.CrossServerArenaConst
local CrossServerArenaData = class("CrossServerArenaData")

function CrossServerArenaData:ctor()
	self:initData()
end

function CrossServerArenaData:initData()
	self._seasonInfo = nil
	self._curRank = 0
	self._oldRank = 0
	self._maxRank = 0
	self._needGuide = false
	self._needGetSnapshotCnt = 0
	self._challengeCount = 0
	self._enterBattle = false
	self._oldSeasonNum = 0
	self._cachedCurRank = nil
	self._cachedOldRank = nil
	self._cachedMaxRank = nil
	self._dayAwardList = {}
	self._seasonAwardList = {}
	self._rankList = {}
	self._guildRankList = {}
	self._matchServerList = nil
	self._dailyTaskList = {}
	self._cachedBattleInfo = nil
	self._battleId = 0
	self._otherFormation = nil
	self._otherKnightsDict = nil
	self._otherSkillList = {}
	self._buffId = 0
	self._buffGroup = 0
	self._buffInfoDict = {}
	self._guildRank = 0
	self._guildRate = 0
	self._isGloryCanReceive = false
	self._lastSeasonRank = 0
	self._isSkipFormation = false
	self._challengeList = {
		_list = {},
		add = function(self, arg_3_1)
			if not arg_3_1.isMyself then
				table.insert(self._list, arg_3_1)
			end
		end,
		clear = function(arg_4_0)
			arg_4_0._list = {}
		end,
		remove = function(self, arg_5_1)
			table.remove(self._list, arg_5_1)
		end,
		getLength = function(self)
			return #self._list
		end,
		sort = function(self, arg_7_1)
			table.sort(self._list, arg_7_1)
		end,
		at = function(self, arg_8_1)
			return self._list[arg_8_1]
		end,
		getIdx = function(self, arg_9_1)
			for iter_9_0, iter_9_1 in ipairs(self._list) do
				if arg_9_1(iter_9_1) then
					return iter_9_0
				end
			end
		end
	}
	self._dayAwardList = self:_initRankAwardList(var_0_13.RANK_TYPE_DAY, 0)
	self._challengeTimeDict = {}

	self:_initGuildSkillInfo()
	self:_initGuildRankAwardInfo()
end

function CrossServerArenaData:_initRankAwardList(arg_10_1, arg_10_2)
	local var_10_0 = {
		_list = {},
		add = function(self, arg_11_1)
			table.insert(self._list, arg_11_1)
		end,
		remove = function(self, arg_12_1)
			table.remove(self._list, arg_12_1)
		end,
		getLength = function(self)
			return #self._list
		end,
		at = function(self, arg_14_1)
			return self._list[arg_14_1]
		end
	}

	for iter_10_0, iter_10_1 in pairs((g.core.config.rank_award_info.match(function(arg_15_0)
		return arg_15_0.rank_type == arg_10_1 and (arg_10_2 == 0 or arg_15_0.activity_id == arg_10_2)
	end))) do
		var_10_0:add(iter_10_1)
	end

	return var_10_0
end

function CrossServerArenaData:initDailyTaskList(arg_16_1)
	local var_16_1 = {}
	local var_16_2 = 0

	for iter_16_0, iter_16_1 in ipairs(arg_16_1.daily_tasks or {}) do
		var_16_1[iter_16_1.type] = iter_16_1.value
		var_16_2 = var_16_2 + iter_16_1.value
	end

	local var_16_3 = {}

	for iter_16_2, iter_16_3 in ipairs(arg_16_1.daily_awards or {}) do
		var_16_3[iter_16_3] = true
	end

	local var_16_4 = {}

	for iter_16_4, iter_16_5 in ipairs((g.core.config.action_task_info.match(function(arg_17_0)
		return arg_17_0.module == var_0_12.TaskConst.MODULE_ID.CROSS_SERVER_ARENA
	end))) do
		if iter_16_5.reset_time == var_0_12.TaskConst.RESET_TYPE.EVERY_DAY then
			local var_16_5 = {
				info = iter_16_5
			}

			var_16_5.count = var_16_1[iter_16_5.require_type] or 0
			var_16_5.got = var_16_3[iter_16_5.id]

			table.insert(var_16_4, var_16_5)
		end
	end

	table.sort(var_16_4, function(arg_18_0, arg_18_1)
		if arg_18_0.got ~= arg_18_1.got then
			return arg_18_1.got
		else
			return arg_18_0.info.id < arg_18_1.info.id
		end
	end)

	self._dailyTaskList = var_16_4
	self._dailyChallengeCount = var_16_2
end

function CrossServerArenaData:_createChallengeUnit(arg_19_1, arg_19_2)
	local var_19_0 = {
		rank = arg_19_1.rank,
		isMyself = arg_19_1.id == g.core.model.User:getId()
	}

	var_19_0.canChallenge = arg_19_1.can_challenge or true
	var_19_0.isTop10 = arg_19_1.rank <= 10
	var_19_0.isTop3 = arg_19_1.rank <= 3
	var_19_0.uid = arg_19_1.id

	if (not arg_19_1.snapshot or arg_19_1.snapshot.id == 0) and arg_19_2 then
		self:_combineSnapShot(var_19_0, arg_19_2)
	elseif arg_19_1.snapshot and arg_19_1.snapshot.id ~= 0 then
		var_19_0.user = arg_19_1.snapshot
		var_19_0.uid = nil
	end

	return var_19_0
end

function CrossServerArenaData:_combineSnapShot(arg_20_1, arg_20_2)
	local var_20_0 = {}

	for iter_20_0, iter_20_1 in pairs(arg_20_2) do
		var_20_0[iter_20_0] = iter_20_1
	end

	if arg_20_1.last_fight_value then
		var_20_0.fight_value = arg_20_1.last_fight_value
	end

	arg_20_1.user = var_20_0
	arg_20_1.uid = nil
end

function CrossServerArenaData:checkUnitSnapShots(arg_21_1)
	if self._needGetSnapshotCnt < 1 or not arg_21_1 then
		return
	end

	for iter_21_0, iter_21_1 in ipairs(arg_21_1) do
		for iter_21_2 = 1, self._challengeList:getLength() do
			local var_21_0 = self._challengeList:at(iter_21_2)

			if var_21_0.robotId == nil and var_21_0.user == nil and var_21_0.uid == iter_21_1.id then
				self:_combineSnapShot(var_21_0, iter_21_1)

				self._needGetSnapshotCnt = self._needGetSnapshotCnt - 1

				break
			end
		end
	end
end

function CrossServerArenaData:_createRobotChallengeUnit(arg_22_1, arg_22_2, arg_22_3)
	local var_22_0 = arg_22_1.id

	if arg_22_2 then
		var_22_0 = arg_22_2.id
	end

	local var_22_1 = {
		isMyself = false,
		isTop10 = false,
		isTop3 = false,
		canChallenge = true
	}

	if arg_22_2 then
		var_22_1.rank = arg_22_2.rank or arg_22_1.rank
	end

	var_22_1.user = self:createRobotSnapshot(arg_22_1)
	var_22_1.level = arg_22_1.seen_level
	var_22_1.robotId = var_22_0

	if arg_22_2 then
		var_22_1.robotBaseId = arg_22_2.robot_base_id or arg_22_1.id
	end

	var_22_1.showRank = arg_22_3

	return var_22_1
end

function CrossServerArenaData:createRobotSnapshot(arg_23_1)
	local var_23_0 = 0

	for iter_23_0 = 1, 3 do
		var_23_0 = var_23_0 + arg_23_1["fight_power_" .. iter_23_0]
	end

	return {
		sid = 0,
		id = arg_23_1.id,
		name = arg_23_1.name,
		level = arg_23_1.seen_level,
		base_id = arg_23_1.seen_knight,
		fight_value = var_23_0,
		show_knight_id = arg_23_1.seen_knight,
		server_name = g.core.platform.ServerListProxy:getSelectedServer().name
	}
end

function CrossServerArenaData:_initGuildSkillInfo()
	self._allSkillMap = {}
	self._skillMap = {}
	self._skillList = {}

	for iter_24_0, iter_24_1 in var_0_6.ipairs() do
		if not self._allSkillMap[iter_24_1.group] then
			self._allSkillMap[iter_24_1.group] = {}
			self._skillMap[iter_24_1.group] = {
				curExp = 0,
				info = iter_24_1
			}

			table.insert(self._skillList, self._skillMap[iter_24_1.group])
		end

		self._allSkillMap[iter_24_1.group][iter_24_1.level] = iter_24_1
	end

	table.sort(self._skillList, function(arg_25_0, arg_25_1)
		return arg_25_0.info.id < arg_25_1.info.id
	end)
end

function CrossServerArenaData:_initGuildRankAwardInfo()
	self._guildGloryList = {}

	for iter_26_0 = 1, 3 do
		self._guildGloryList[iter_26_0] = {
			hasReceived = false,
			rank = iter_26_0
		}
	end
end

function CrossServerArenaData:updateRankList(arg_27_1)
	if not arg_27_1 then
		return
	end

	self._rankList = arg_27_1

	table.sort(self._rankList, function(arg_28_0, arg_28_1)
		return arg_28_0.rank < arg_28_1.rank
	end)
end

function CrossServerArenaData:updateCrossServerArenaData(arg_29_1)
	self._challengeList:clear()

	self._needGetSnapshotCnt = 0
	self._curRank = arg_29_1.rank or 0
	self._maxRank = arg_29_1.history_max_rank or 0
	self._needGuide = not arg_29_1.guide_finish

	if not arg_29_1.guide_finish then
		local var_29_0 = var_0_0.fetch(var_0_13.GUIDE_ROBOT_ID)

		if var_29_0 then
			for iter_29_0 = 1, var_0_13.GUIDE_ROBOT_NUM do
				self._challengeList:add(self:_createRobotChallengeUnit(var_29_0, nil, var_29_0.rank))
			end
		end
	end

	self._oldRank = self._curRank or 0

	for iter_29_1, iter_29_2 in ipairs(arg_29_1.match_units or {}) do
		if iter_29_2.robot_base_id and iter_29_2.robot_base_id > 0 then
			local var_29_1 = var_0_0.fetch(iter_29_2.robot_base_id)

			if var_29_1 then
				self._challengeList:add(self:_createRobotChallengeUnit(var_29_1, iter_29_2))
			end
		elseif not iter_29_2.snapshot or iter_29_2.snapshot.id == 0 then
			local var_29_2 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, iter_29_2.id)

			if not var_29_2 then
				self._needGetSnapshotCnt = self._needGetSnapshotCnt + 1

				self._challengeList:add(self:_createChallengeUnit(iter_29_2))
			else
				self._challengeList:add(self:_createChallengeUnit(iter_29_2, var_29_2))
			end
		else
			self._challengeList:add(self:_createChallengeUnit(iter_29_2))
		end
	end

	self._challengeList:sort(function(arg_30_0, arg_30_1)
		if arg_30_0.showRank and arg_30_1.showRank then
			return arg_30_0.showRank > arg_30_1.showRank
		end

		return arg_30_0.rank > arg_30_1.rank
	end)

	self._buffId = arg_29_1.buff or 0
	self._guildRank = arg_29_1.guild_rank or 0

	for iter_29_3, iter_29_4 in ipairs(arg_29_1.guild_rank_awards or {}) do
		self:updateGuildReceiveState(iter_29_4)
	end

	self._lastSeasonRank = arg_29_1.last_season_rank or 0
end

function CrossServerArenaData:updateGuildReceiveState(arg_31_1)
	self._guildGloryList[arg_31_1].hasReceived = true
end

function CrossServerArenaData:resetGuildReceiveState()
	for iter_32_0, iter_32_1 in ipairs(self._guildGloryList) do
		iter_32_1.hasReceived = false
	end
end

function CrossServerArenaData:onS2CGuildSkill(arg_33_1)
	for iter_33_0, iter_33_1 in ipairs(arg_33_1.guild_skills or {}) do
		self._skillMap[iter_33_1.group].info = var_0_6.get(iter_33_1.id)
		self._skillMap[iter_33_1.group].curExp = iter_33_1.exp
	end
end

function CrossServerArenaData:onS2CSkillLevelUp(arg_34_1)
	self._skillMap[arg_34_1.group].info = var_0_6.get(arg_34_1.id)
	self._skillMap[arg_34_1.group].curExp = arg_34_1.exp
end

function CrossServerArenaData:updateSeasonInfo(arg_35_1)
	if arg_35_1 and arg_35_1.activity then
		if self._seasonInfo and arg_35_1.activity.term and self._seasonInfo.term ~= arg_35_1.activity.term then
			self._oldSeasonNum = self._seasonInfo.term
		end

		self._seasonInfo = arg_35_1.activity

		local var_35_0 = var_0_1.fetch(arg_35_1.activity.activity_sub_id)

		if var_35_0 then
			self._seasonAwardList = self:_initRankAwardList(var_0_13.RANK_TYPE_SEASON, var_35_0.rank_reward)
			self._buffGroup = var_35_0.buff_group

			self:_updateBuffInfoDict()
		end
	end

	if arg_35_1 and arg_35_1.honor_award then
		self:_updateGloryReceiveStateBySvrInfo(arg_35_1.honor_award)
	end
end

function CrossServerArenaData:_updateBuffInfoDict()
	self._buffInfoDict = {}

	for iter_36_0, iter_36_1 in var_0_2.ipairs() do
		if iter_36_1.buff_group == self._buffGroup then
			self._buffInfoDict[iter_36_1.id] = iter_36_1
		end
	end
end

function CrossServerArenaData:updateServerInfo(arg_37_1)
	if arg_37_1 then
		self._matchServerList = arg_37_1.server_infos or {}
	end
end

function CrossServerArenaData:updateGuildRankList(arg_38_1)
	self._guildRankList = arg_38_1.list or {}
	self._guildRank = arg_38_1.rank or 0
end

function CrossServerArenaData:onS2COtherGuildSkill(arg_39_1)
	self._otherSkillList = {}

	for iter_39_0, iter_39_1 in ipairs(arg_39_1.skills or {}) do
		local var_39_1 = var_0_6.get(iter_39_1)

		if var_39_1.level > 0 then
			table.insert(self._otherSkillList, (var_0_4.get(var_39_1.talent_skill_id)))
		end
	end
end

function CrossServerArenaData:onS2CChiefArenaChallengeBegin(arg_40_1)
	if arg_40_1 and arg_40_1.battle_id then
		self:cacheRank()

		self._battleId = arg_40_1.battle_id
	end
end

function CrossServerArenaData:onS2CChiefArenaChallengeFinish(arg_41_1)
	if arg_41_1 then
		if arg_41_1.is_win then
			if self._curRank > 0 then
				self._oldRank = self._curRank or var_0_13.GUIDE_ROBOT_SHOW_RANK + 1
			end

			self._curRank = self._curRank > 0 and math.max(arg_41_1.rank, self._curRank) or arg_41_1.rank

			if self._maxRank == 0 or self._curRank < self._maxRank then
				self._maxRank = self._curRank
			end
		end

		self._guildRate = arg_41_1.guild_rate or 0
	end
end

function CrossServerArenaData:setOtherFormationData(arg_42_1)
	self._otherFormation = {}

	if arg_42_1 and arg_42_1.formations then
		local var_42_0 = {}

		for iter_42_0, iter_42_1 in ipairs(arg_42_1.knights) do
			var_42_0[iter_42_1.id] = iter_42_1.base_id
		end

		self._otherFormation.formations = {}

		for iter_42_2, iter_42_3 in ipairs(arg_42_1.formations) do
			local var_42_1 = iter_42_3.seq or 0

			if not iter_42_3.knight_id then
				break
			end

			self._otherFormation.formations[var_42_1] = {}
			self._otherFormation.formations[var_42_1].knight_id = {}

			for iter_42_4, iter_42_5 in ipairs(iter_42_3.position or {}) do
				self._otherFormation.formations[var_42_1].knight_id[iter_42_5] = var_42_0[iter_42_3.knight_id[iter_42_4]] or 0
			end

			self._otherFormation.formations[var_42_1].fight_value = iter_42_3.fight_value or 0
		end
	end
end

function CrossServerArenaData:onS2CGetModuleTaskAward(arg_43_1)
	for iter_43_0, iter_43_1 in ipairs(self._dailyTaskList) do
		if iter_43_1.info.id == arg_43_1 then
			iter_43_1.got = true

			break
		end
	end

	table.sort(self._dailyTaskList, self:_getTaskSortRule())
end

function CrossServerArenaData:onS2CGuildHonorRank(arg_44_1)
	self._isGloryCanReceive = false

	local var_44_0 = arg_44_1.guild_honor_ranks or {}

	for iter_44_0 = 1, 3 do
		if var_44_0[iter_44_0] then
			self._guildGloryList[iter_44_0].user = var_44_0[iter_44_0].snapshot
			self._guildGloryList[iter_44_0].rank = var_44_0[iter_44_0].rank
		else
			self._guildGloryList[iter_44_0].user = nil
		end
	end
end

function CrossServerArenaData:_updateGloryReceiveStateBySvrInfo(arg_45_1)
	self._isGloryCanReceive = checkbool(arg_45_1)
end

function CrossServerArenaData:onS2CChiefArenaOneKeyChallenge(arg_46_1)
	self._guildRate = arg_46_1 or 0
end

function CrossServerArenaData:cacheBattleInfo(arg_47_1)
	self._cachedBattleInfo = {}
	self._cachedBattleInfo.rivalTeam = arg_47_1.rivalTeam
	self._cachedBattleInfo.rank = arg_47_1.rank
	self._cachedBattleInfo.isRobot = arg_47_1.isRobot
end

function CrossServerArenaData:getCacheBattleInfo()
	return self._cachedBattleInfo
end

function CrossServerArenaData:setEnterBattleStatus(arg_49_1)
	self._enterBattle = arg_49_1
end

function CrossServerArenaData:getEnterBattleStatus()
	return self._enterBattle
end

function CrossServerArenaData:cacheRank()
	if self._maxRank > 0 then
		self._cachedMaxRank = self._maxRank or var_0_13.GUIDE_ROBOT_SHOW_RANK + 1
	end

	if self._oldRank > 0 then
		self._cachedOldRank = self._oldRank or self._cachedMaxRank
	end

	if self._curRank > 0 then
		self._cachedCurRank = self._curRank or self._cachedMaxRank
	end
end

function CrossServerArenaData:getCachedRank()
	return {
		oldRank = self._cachedOldRank,
		curRank = self._cachedCurRank,
		maxRank = self._cachedMaxRank
	}
end

function CrossServerArenaData:getOtherSkill()
	return self._otherSkillList or {}
end

function CrossServerArenaData:saveSeasonPopStatus(arg_54_1, arg_54_2)
	local var_54_0 = var_0_10:load(var_0_13.JSON_SEASON_POP, true) or {}

	var_54_0[string.format("s%d_%s", arg_54_1, arg_54_2)] = true

	var_0_10:save(var_0_13.JSON_SEASON_POP, var_54_0)
end

function CrossServerArenaData:checkSeasonPopStatus(arg_55_1, arg_55_2)
	return checkbool((var_0_10:load(var_0_13.JSON_SEASON_POP, true) or {})[string.format("s%d_%s", arg_55_1, arg_55_2)])
end

function CrossServerArenaData:saveAdditionPop()
	local var_56_0 = var_0_10:load(var_0_13.JSON_ADDITION, true) or {}
	local var_56_1 = var_0_11:getDateObject()
	local var_56_2, var_56_3 = self:getAddition()

	var_56_0[string.format("%d_%d_%d", var_56_1.year, var_56_1.month, var_56_1.day)] = var_56_3

	var_0_10:save(var_0_13.JSON_ADDITION, var_56_0)
end

function CrossServerArenaData:checkAdditionPop()
	local var_57_0 = var_0_10:load(var_0_13.JSON_ADDITION, true) or {}
	local var_57_1 = var_0_11:getDateObject()
	local var_57_2 = string.format("%d_%d_%d", var_57_1.year, var_57_1.month, var_57_1.day)

	if not var_57_0[var_57_2] then
		return false
	end

	local var_57_3 = var_57_0[var_57_2]
	local var_57_4, var_57_5 = self:getAddition()

	return var_57_3 == var_57_5
end

function CrossServerArenaData:getRankList()
	return self._rankList or {}
end

function CrossServerArenaData:getDayAwardList()
	return self._dayAwardList or {}
end

function CrossServerArenaData:getSeasonAwardList()
	return self._seasonAwardList or {}
end

function CrossServerArenaData:getChallengeList()
	return self._challengeList or {}
end

function CrossServerArenaData:getServerInfo()
	return self._matchServerList
end

function CrossServerArenaData:getDailyTaskList()
	return self._dailyTaskList or {}
end

function CrossServerArenaData:isNeedGuide()
	return self._needGuide
end

function CrossServerArenaData:getCurRank()
	return self._curRank
end

function CrossServerArenaData:getMaxRank()
	return self._maxRank
end

function CrossServerArenaData:getBattleId()
	return self._battleId
end

function CrossServerArenaData:getSeasonStatus()
	if not self._seasonInfo then
		return var_0_13.CTRL_NONE_SEASON
	end

	local var_68_0 = var_0_11:getTime()

	if self._seasonInfo.start_time <= var_68_0 and var_68_0 <= self._seasonInfo.end_time then
		return var_0_13.CTRL_ON_SEASON
	elseif self._seasonInfo.end_time < var_68_0 and var_68_0 <= self._seasonInfo.expire_time then
		return var_0_13.CTRL_OFF_SEASON
	elseif self._seasonInfo.prepare_time and self._seasonInfo.prepare_time ~= 0 and self._seasonInfo.prepare_time <= var_68_0 and var_68_0 < self._seasonInfo.start_time then
		return var_0_13.CTRL_PRE_SEASON
	end

	return var_0_13.CTRL_NONE_SEASON
end

function CrossServerArenaData:isInSeason()
	return self:getSeasonStatus() == var_0_13.CTRL_ON_SEASON
end

function CrossServerArenaData:getDurationString()
	if not self._seasonInfo then
		return ""
	end

	local var_70_0 = self:getSeasonStatus()
	local var_70_1
	local var_70_2
	local var_70_3

	if var_70_0 == var_0_13.CTRL_OFF_SEASON then
		var_70_2 = self._seasonInfo.expire_time
		var_70_1 = self._seasonInfo.end_time
	elseif var_70_0 == var_0_13.CTRL_ON_SEASON then
		var_70_2 = self._seasonInfo.end_time
		var_70_1 = self._seasonInfo.start_time
	elseif var_70_0 == var_0_13.CTRL_PRE_SEASON then
		var_70_2 = self._seasonInfo.start_time
		var_70_1 = self._seasonInfo.prepare_time
	else
		do return "" end

		var_70_3 = {}
	end

	var_70_3.start = self:_getYMDHM((var_0_11:getDateObject(var_70_1)))
	var_70_3.endT = self:_getYMDHM((var_0_11:getDateObject(var_70_2)))

	return g.core.lang:get(411001, var_70_3)
end

function CrossServerArenaData:_getYMDHM(arg_71_1)
	local var_71_0 = {
		arg_71_1.hour,
		arg_71_1.min
	}

	return table.concat({
		arg_71_1.year,
		arg_71_1.month,
		arg_71_1.day
	}, "/") .. " " .. string.format("%02d:%02d", var_71_0[1], var_71_0[2])
end

function CrossServerArenaData:getRanks()
	return self._curRank, self._oldRank
end

function CrossServerArenaData:getPaintedIdBySnapshot(arg_73_1)
	local var_73_0
	local var_73_1

	if arg_73_1.robot_type and arg_73_1.robot_type > 0 then
		var_73_0 = var_0_0.get(arg_73_1.base_id).seen_knight
	else
		var_73_0 = arg_73_1.show_knight_id

		if not arg_73_1.show_knight_id or var_73_0 == 0 then
			var_73_0 = arg_73_1.base_id
		end

		var_73_1 = arg_73_1.show_knight_dress
	end

	return g.core.model.User.knightsData:getKnightResInfo({
		knightId = var_73_0,
		skinId = var_73_1
	}).painted_id
end

function CrossServerArenaData:getSeasonInfo()
	return self._seasonInfo
end

function CrossServerArenaData:getTop10ChallengeList()
	self._needGetSnapshotCnt = 0

	local var_75_0 = {
		_list = {},
		add = function(self, arg_76_1)
			if not arg_76_1.isMyself then
				table.insert(self._list, arg_76_1)
			end
		end,
		clear = function(arg_77_0)
			arg_77_0._list = {}
		end,
		remove = function(self, arg_78_1)
			table.remove(self._list, arg_78_1)
		end,
		getLength = function(self)
			return #self._list
		end,
		sort = function(self, arg_80_1)
			table.sort(self._list, arg_80_1)
		end,
		at = function(self, arg_81_1)
			return self._list[arg_81_1]
		end,
		getIdx = function(self, arg_82_1)
			for iter_82_0, iter_82_1 in ipairs(self._list) do
				if arg_82_1(iter_82_1) then
					return iter_82_0
				end
			end
		end
	}
	local var_75_1 = self:getRankList()

	for iter_75_0 = 1, 10 do
		if not var_75_1[iter_75_0] then
			break
		end

		if var_75_1[iter_75_0].robot_base_id > 0 then
			local var_75_2 = var_0_0.fetch(var_75_1[iter_75_0].robot_base_id)

			if var_75_2 then
				var_75_0:add(self:_createRobotChallengeUnit(var_75_2, var_75_1[iter_75_0]))
			end
		elseif not var_75_1[iter_75_0].snapshot or var_75_1[iter_75_0].snapshot.id == 0 then
			local var_75_3 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, var_75_1[iter_75_0].id)

			if not var_75_3 then
				self._needGetSnapshotCnt = self._needGetSnapshotCnt + 1

				self.top10ChallengeList:add(self:_createChallengeUnit(var_75_1[iter_75_0]))
			else
				self.top10ChallengeList:add(self:_createChallengeUnit(var_75_1[iter_75_0], var_75_3))
			end
		else
			var_75_0:add(self:_createChallengeUnit(var_75_1[iter_75_0]))
		end
	end

	return var_75_0
end

function CrossServerArenaData:isCrossServerArenaUnlock()
	return g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.CROSS_SERVER_ARENA)
end

function CrossServerArenaData:isCrossServerArenaCanRoute()
	local var_84_0 = self:getSeasonStatus()

	if not self:isCrossServerArenaUnlock() then
		return false
	end

	if var_84_0 == var_0_13.CTRL_NONE_SEASON or var_84_0 == var_0_13.CTRL_PRE_SEASON then
		return false
	end

	return true
end

function CrossServerArenaData:isFormationValid()
	local var_85_0 = var_0_8:getOutBaseFormationArr(g.core.const.ConstMgr.LineUpConst.MulTeamType.CROSS_SERVER_ARENA)

	if var_85_0 and #var_85_0 == 3 then
		for iter_85_0, iter_85_1 in pairs(var_85_0) do
			if iter_85_0 == 4 then
				return true
			end

			local var_85_1 = false

			for iter_85_2 = 1, 6 do
				if iter_85_1.knight_id[iter_85_2] and iter_85_1.knight_id[iter_85_2] > 0 then
					var_85_1 = true

					break
				end
			end

			if not var_85_1 then
				return false
			end
		end
	else
		return false
	end

	return true
end

function CrossServerArenaData:getOtherFormationData()
	return self._otherFormation
end

function CrossServerArenaData:getKnightBaseIdBySid(arg_87_1)
	if self._otherKnightsDict then
		return self._otherKnightsDict[arg_87_1] or 0
	end

	return 0
end

function CrossServerArenaData:getEndTimeString()
	if self._seasonInfo then
		local var_88_0 = var_0_11:getDateObject(self._seasonInfo.end_time)

		return g.core.lang:get(411011, {
			month = var_88_0.month,
			day = var_88_0.day,
			hour = var_88_0.hour
		})
	end

	return ""
end

function CrossServerArenaData:getExpireTime()
	if self._seasonInfo then
		return self._seasonInfo.expire_time
	end

	return 0
end

function CrossServerArenaData:_getTaskSortRule()
	return function(arg_91_0, arg_91_1)
		if arg_91_0.got ~= arg_91_1.got then
			return arg_91_1.got
		else
			return arg_91_0.info.id < arg_91_1.info.id
		end
	end
end

function CrossServerArenaData:getChallengeCount()
	return self._challengeCount or 0
end

function CrossServerArenaData:getCampaignStr()
	return g.core.lang:get(411003, {
		num = self._seasonInfo.term
	})
end

function CrossServerArenaData:getCampaignEntranceCDTime()
	local var_94_0 = 0
	local var_94_1 = self:getSeasonStatus()

	if var_94_1 == var_0_13.CTRL_ON_SEASON then
		var_94_0 = self._seasonInfo and self._seasonInfo.end_time or 0
	elseif var_94_1 == var_0_13.CTRL_OFF_SEASON then
		var_94_0 = self._seasonInfo and self._seasonInfo.expire_time or 0
	end

	return var_94_0
end

function CrossServerArenaData:needUpdateShopInfo()
	return self._oldSeasonNum ~= 0
end

function CrossServerArenaData:getBuffInfo()
	return self._buffInfoDict[self._buffId]
end

function CrossServerArenaData:getBuffGroupAndTalentSkillInfo(arg_97_1)
	local var_97_0 = var_0_4.fetch(arg_97_1)
	local var_97_1 = 2

	if var_97_0 then
		if var_97_0.affect_target_1 == var_0_13.BUFF_TARGET.JIAO_GUO then
			var_97_1 = g.core.const.ConstMgr.KNIGHT_CONST.GROUP_TYPE.JIAO_GUO
		elseif var_97_0.affect_target_1 == var_0_13.BUFF_TARGET.LIN_DONG then
			var_97_1 = g.core.const.ConstMgr.KNIGHT_CONST.GROUP_TYPE.LIN_DONG
		elseif var_97_0.affect_target_1 == var_0_13.BUFF_TARGET.DONG_XI then
			var_97_1 = g.core.const.ConstMgr.KNIGHT_CONST.GROUP_TYPE.DONG_XI
		elseif var_97_0.affect_target_1 == var_0_13.BUFF_TARGET.LI_JIN then
			var_97_1 = g.core.const.ConstMgr.KNIGHT_CONST.GROUP_TYPE.LI_JIN
		end
	end

	return var_97_1, var_97_0
end

function CrossServerArenaData:getAttrValByTalentId(arg_98_1)
	local var_98_0 = var_0_4.get(arg_98_1)
	local var_98_1, var_98_2 = self:_getAttrNameAndValString(var_98_0)

	return var_98_1, var_98_0.affect_value_1
end

function CrossServerArenaData:_getAttrNameAndValString(arg_99_1)
	local var_99_0 = arg_99_1.affect_value_1
	local var_99_1 = var_0_5.get(arg_99_1.affect_type_1)

	if var_99_1.value_format == 2 then
		var_99_0 = tostring(var_99_0 / 10) .. "%"
	end

	return var_99_0, var_99_1.name
end

function CrossServerArenaData:getSkillList()
	return self._skillList or {}
end

function CrossServerArenaData:getMySkillList()
	local var_101_0 = {}

	for iter_101_0, iter_101_1 in ipairs((self:getSkillList())) do
		if iter_101_1.info.level > 0 then
			table.insert(var_101_0, (var_0_4.get(iter_101_1.info.talent_skill_id)))
		end
	end

	return var_101_0
end

function CrossServerArenaData:getSkillInfoByGroup(arg_102_1)
	return self._skillMap[arg_102_1]
end

function CrossServerArenaData:getGuildRank()
	return self._guildRank
end

function CrossServerArenaData:getAddition()
	for iter_104_0, iter_104_1 in var_0_7.ipairs() do
		if iter_104_1.min_rank <= self._guildRank and self._guildRank <= iter_104_1.max_rank then
			return true, iter_104_1.buff / 10
		end
	end

	return false, 0
end

function CrossServerArenaData:getGuildRate()
	return self._guildRate
end

function CrossServerArenaData:getAdditionByRank(arg_106_1)
	for iter_106_0, iter_106_1 in var_0_7.ipairs() do
		if arg_106_1 >= iter_106_1.min_rank and arg_106_1 <= iter_106_1.max_rank then
			return iter_106_1.buff / 10
		end
	end

	return 0
end

function CrossServerArenaData:getRankScoreByRank(arg_107_1)
	for iter_107_0, iter_107_1 in var_0_3.ipairs() do
		if arg_107_1 >= iter_107_1.min_rank and arg_107_1 <= iter_107_1.max_rank then
			return iter_107_1.score
		end
	end

	return 0
end

function CrossServerArenaData:getGuildRankList()
	return self._guildRankList or {}
end

function CrossServerArenaData:isGuildRewardCanReceive(arg_109_1)
	if not self._guildGloryList[arg_109_1] then
		return false
	end

	return self._guildGloryList[arg_109_1].user and not self._guildGloryList[arg_109_1].hasReceived
end

function CrossServerArenaData:getGuildSkillInfoByGroupAndLevel(arg_110_1, arg_110_2)
	return self._allSkillMap[arg_110_1][arg_110_2]
end

function CrossServerArenaData:isShowEntrance()
	local var_111_0 = self:getSeasonStatus()

	return var_111_0 == var_0_13.CTRL_ON_SEASON or var_111_0 == var_0_13.CTRL_OFF_SEASON
end

function CrossServerArenaData:isNeedWaitUserSnapshot()
	return self._needGetSnapshotCnt > 0
end

function CrossServerArenaData:checkChallengeTime(arg_113_1, arg_113_2)
	local var_113_0 = table.concat({
		arg_113_1,
		arg_113_2
	}, "_")
	local var_113_1 = self._challengeTimeDict[var_113_0] or 0
	local var_113_2 = g.core.common.ServerTime:getTime()

	if var_113_1 <= var_113_2 then
		self._challengeTimeDict[var_113_0] = var_113_2 + 1
	else
		return false
	end

	return true
end

function CrossServerArenaData:isChallengeNumFull()
	if not self:isCrossServerArenaUnlock() or self:getSeasonStatus() ~= var_0_13.CTRL_ON_SEASON then
		return false
	end

	return g.core.model.User.shopData:getLeftCount(var_0_13.BUY_TIMES_ID) > 0
end

function CrossServerArenaData:isExistTaskAward()
	if not self:isCrossServerArenaUnlock() then
		return false
	end

	local var_115_0 = self:getSeasonStatus()

	if var_115_0 ~= var_0_13.CTRL_ON_SEASON and var_115_0 ~= var_0_13.CTRL_OFF_SEASON then
		return false
	end

	for iter_115_0, iter_115_1 in ipairs(self._dailyTaskList) do
		if not iter_115_1.got and iter_115_1.count >= iter_115_1.info.require_value then
			return true
		end
	end
end

function CrossServerArenaData:isNewSeason()
	if not self:isCrossServerArenaUnlock() then
		return false
	end

	local var_116_0 = self:getSeasonStatus()

	if var_116_0 ~= var_0_13.CTRL_OFF_SEASON and var_116_0 ~= var_0_13.CTRL_ON_SEASON then
		return false
	end

	local var_116_1 = false

	if self._seasonInfo then
		var_116_1 = self:checkSeasonPopStatus(self._seasonInfo.term, var_0_13.JSON_SEASON_STATUS_START)
		var_116_1 = var_116_1 or self:checkSeasonPopStatus(self._seasonInfo.term, var_0_13.JSON_SEASON_STATUS_END)
	end

	return not var_116_1
end

function CrossServerArenaData:isGloryRewardCanReceive(arg_117_1)
	if g.core.model.User:getGuildId() > 0 and self:isCrossServerArenaUnlock() then
		if arg_117_1 and arg_117_1.rank then
			return self._isGloryCanReceive or self:isGuildRewardCanReceive(arg_117_1.rank)
		else
			if self._isGloryCanReceive then
				return true
			end

			for iter_117_0 = 1, 3 do
				if self:isGuildRewardCanReceive(iter_117_0) then
					return true
				end
			end
		end
	end

	return false
end

function CrossServerArenaData:isSkillCanLvUp()
	if g.core.model.User:getGuildId() > 0 and self:isCrossServerArenaUnlock() and g.core.model.User.resourceData:getChiefArenaScore() > 0 then
		for iter_118_0, iter_118_1 in ipairs(self._skillList) do
			if iter_118_1.info.next_id > 0 then
				return true
			end
		end
	end

	return false
end

function CrossServerArenaData:getGuildGloryList()
	return self._guildGloryList
end

function CrossServerArenaData:getLastSeasonRank()
	return self._lastSeasonRank
end

function CrossServerArenaData:setSkipFormationState()
	self._isSkipFormation = not self._isSkipFormation
end

function CrossServerArenaData:isSkipFormation()
	return self._isSkipFormation
end

function CrossServerArenaData:checkLeftCount()
	if g.core.model.User.shopData:getLeftCount(g.core.const.ConstMgr.ShopConst.PLAY_TYPE.CROSS_SERVER_ARENA_COUNT) <= 0 then
		return false
	end

	return true
end

function CrossServerArenaData:getOneKeyAwardList(arg_124_1)
	local var_124_0 = {}

	if not arg_124_1 then
		return var_124_0
	end

	if arg_124_1.turn_awards then
		for iter_124_0, iter_124_1 in ipairs(arg_124_1.turn_awards) do
			for iter_124_2, iter_124_3 in ipairs(iter_124_1.detail) do
				var_124_0[iter_124_0] = {}

				table.insert(var_124_0[iter_124_0], (g.core.common.Goods:convert(iter_124_3)))
			end
		end
	end

	if arg_124_1.challenge_awards then
		for iter_124_4, iter_124_5 in ipairs(arg_124_1.challenge_awards) do
			for iter_124_6, iter_124_7 in ipairs(iter_124_5.detail) do
				table.insert(var_124_0[iter_124_4], (g.core.common.Goods:convert(iter_124_7)))
			end
		end
	end

	for iter_124_8 = 1, #var_124_0 do
		var_124_0[iter_124_8] = g.core.utils.Tools.mergeAwardList(var_124_0[iter_124_8])

		table.sort(var_124_0[iter_124_8], function(arg_125_0, arg_125_1)
			local var_125_0 = arg_125_0.type == 1 and arg_125_0.value == 92
			local var_125_1 = arg_125_1.type == 1 and arg_125_1.value == 92

			if (arg_125_0.type == 1 and arg_125_0.value == 5000001) ~= (arg_125_1.type == 1 and arg_125_1.value == 5000001) then
				return arg_125_0.type == 1 and arg_125_0.value == 5000001
			end

			if var_125_0 ~= var_125_1 then
				return var_125_0
			end

			return arg_125_0.quality > arg_125_1.quality
		end)
	end

	return var_124_0
end

function CrossServerArenaData:_createFakeData()
	self:onS2CGuildSkill({
		guild_skills = (function(arg_127_0)
			local var_127_0 = {}

			for iter_127_0 = 1, arg_127_0 do
				table.insert(var_127_0, {
					group = iter_127_0,
					id = iter_127_0 * 2 % 8,
					exp = iter_127_0 * 30 % 100
				})
			end

			return var_127_0
		end)(3)
	})
	self:onS2CGuildHonorRank({
		guild_honor_ranks = (function(arg_128_0)
			local var_128_0 = {}

			for iter_128_0 = 1, arg_128_0 do
				table.insert(var_128_0, {
					snapshot = {
						id = 1,
						name = "TOP" .. iter_128_0
					},
					rank = iter_128_0
				})
			end

			return var_128_0
		end)(2)
	})
	self:onS2COtherGuildSkill({
		skills = {
			3,
			11,
			23
		}
	})
end

return CrossServerArenaData
