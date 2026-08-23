local var_0_0 = g.core.common.ServerTime
local var_0_1 = g.core.const.ConstMgr.BountyConst
local var_0_2 = g.core.const.ConstMgr.KNIGHT_CONST
local BountyMonsterStruct = require("app.view.module.bounty.model.BountyMonsterStruct")
local BountyTaskStruct = require("app.view.module.bounty.model.BountyTaskStruct")
local var_0_5 = g.core.config.bounty_info
local var_0_6 = g.core.config.bounty_monster_info
local var_0_7 = g.core.config.bounty_recruit_info
local BountyData = class("BountyData")

function BountyData:ctor()
	self:initData()
end

function BountyData:initData()
	self._activityId = 0
	self._activityStartTime = 0
	self._activityEndTime = 0
	self._activityExpireTime = 0
	self._activityOpenDay = 0
	self._findInfo = nil
	self._monsterInfoDict = {}
	self._myMonsterList = {}
	self._shareMonsterList = {}

	for iter_2_0 = var_0_1.SHARE_SEL_TYPE.MINE, var_0_1.SHARE_SEL_TYPE.CROSS_SERVER do
		self:resetShareMonster(iter_2_0)
	end

	self._myScore = 0
	self._myHelpScore = 0
	self._battleCount = 0
	self._taskList = {}
	self._myGuildRank = 0
	self._rankList = {}
	self._rankRwdData = {
		actId = 0,
		list = {}
	}
	self._dailyCfgList = {}
	self._dailyRankList = {}
	self._dailyUserIdMap = {}
	self._isJoinGuildToday = false

	self:_initDailyRankList()
	self:_initSummonCost()

	self._shareCD = {}
	self._lastChallengeResult = true
	self._shareRequestStarMap = {
		[0] = 7
	}
end

function BountyData:resetShareMonster(arg_3_1)
	local var_3_0 = {}

	for iter_3_0 = 1, var_0_2.STAR_MAX do
		var_3_0[iter_3_0] = {}
	end

	self._shareMonsterList[arg_3_1 + 1] = var_3_0

	return var_3_0
end

function BountyData:_initSummonCost()
	self._summonCostInfo = {}

	local var_4_0 = var_0_7.get(var_0_1.MONSTER_SUMMON_TYPE.LOW)

	self._summonCostInfo[var_0_1.MONSTER_SUMMON_TYPE.LOW] = {
		type = var_4_0.cost_type,
		value = var_4_0.cost_value,
		size = var_4_0.cost_size
	}

	local var_4_1 = var_0_7.get(var_0_1.MONSTER_SUMMON_TYPE.HIGH)

	self._summonCostInfo[var_0_1.MONSTER_SUMMON_TYPE.HIGH] = {
		type = var_4_1.cost_type,
		value = var_4_1.cost_value,
		size = var_4_1.cost_size
	}
end

function BountyData:_initDailyRankList()
	for iter_5_0 = 1, g.core.config.bounty_daily_score_info.getLength() do
		self._dailyCfgList[iter_5_0] = {
			score = 0,
			uid = 0,
			cfg = g.core.config.bounty_daily_score_info.indexOf(iter_5_0)
		}
	end
end

function BountyData:_initMonsterReward()
	for iter_6_0, iter_6_1 in ipairs((var_0_6.match(function(arg_7_0)
		return arg_7_0.activity_id == self._activityId
	end))) do
		self._monsterInfoDict[iter_6_1.monster_star] = iter_6_1
	end
end

function BountyData:_initRankReward()
	if self._activityId == self._rankRwdData.actId then
		return
	end

	local var_8_0 = g.core.config.rank_award_info.match(function(arg_9_0)
		return arg_9_0.rank_type == 97 and arg_9_0.activity_id == self._activityId
	end)

	table.sort(var_8_0, function(arg_10_0, arg_10_1)
		return arg_10_0.min_rank < arg_10_1.min_rank
	end)

	self._rankRwdData = {
		list = {},
		actId = self._rankRwdData.actId
	}

	for iter_8_0, iter_8_1 in ipairs(var_8_0) do
		local var_8_1 = 1
		local var_8_2 = {}
		local var_8_3 = {
			awards = var_8_2,
			cfg = iter_8_1
		}

		while g.core.config.rank_award_info.hasKey("reward_type" .. 1) do
			if iter_8_1["reward_size" .. var_8_1] > 0 then
				var_8_2[#var_8_2 + 1] = {
					type = iter_8_1["reward_type" .. var_8_1],
					value = iter_8_1["reward_value" .. var_8_1],
					size = iter_8_1["reward_size" .. var_8_1]
				}
			end

			var_8_1 = var_8_1 + 1
		end

		self._rankRwdData.list[#self._rankRwdData.list + 1] = var_8_3
	end
end

function BountyData:getBountyStr()
	local var_11_0 = self:getCurStage()

	if var_11_0 == var_0_1.ACTIVITY_STATE.OPEN then
		return g.core.lang:get(422567)
	elseif var_11_0 == var_0_1.ACTIVITY_STATE.RESULT then
		return g.core.lang:get(420602)
	elseif var_11_0 == var_0_1.ACTIVITY_STATE.NOT_OPEN then
		return g.core.lang:get(420603)
	end
end

function BountyData:getCurStage()
	local var_12_0 = g.core.common.ServerTime:getTime()

	if var_12_0 >= self._activityStartTime and var_12_0 <= self._activityEndTime then
		return var_0_1.ACTIVITY_STATE.OPEN
	elseif var_12_0 >= self._activityEndTime and var_12_0 <= self._activityExpireTime then
		return var_0_1.ACTIVITY_STATE.RESULT
	else
		return var_0_1.ACTIVITY_STATE.NOT_OPEN
	end
end

function BountyData:getFinishTime()
	local var_13_0 = self:getCurStage()

	if var_13_0 == var_0_1.ACTIVITY_STATE.OPEN then
		return self._activityEndTime
	elseif var_13_0 == var_0_1.ACTIVITY_STATE.RESULT then
		return self._activityExpireTime
	end

	return 0
end

function BountyData:getActivityExpireTime()
	return self._activityExpireTime
end

function BountyData:isActivityOpen(arg_15_1)
	if not self._activityStartTime == 0 or g.core.common.ServerTime:getOpenDays() < self._activityOpenDay then
		return false
	end

	if not g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.BOUNTY) then
		return false
	end

	if arg_15_1 and arg_15_1 ~= self._activityId then
		return false
	end

	return self:isInActiveTime()
end

function BountyData:isInActiveTime()
	local var_16_0 = g.core.common.ServerTime:getTime()

	return var_16_0 >= self._activityStartTime and var_16_0 <= self._activityExpireTime
end

function BountyData:isActivityInOpenTime(arg_17_1)
	if not self._activityStartTime == 0 or g.core.common.ServerTime:getOpenDays() < self._activityOpenDay then
		return false
	end

	if not g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.BOUNTY) then
		return false
	end

	if arg_17_1 and arg_17_1 ~= self._activityId then
		return false
	end

	local var_17_0 = g.core.common.ServerTime:getTime()

	return var_17_0 >= self._activityStartTime and var_17_0 <= self._activityEndTime
end

function BountyData:isActivityInTime(arg_18_1)
	if not self._activityStartTime == 0 or g.core.common.ServerTime:getOpenDays() < self._activityOpenDay then
		return false
	end

	if not g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.BOUNTY) then
		return false
	end

	if arg_18_1 and arg_18_1 ~= self._activityId then
		return false
	end

	local var_18_0 = g.core.common.ServerTime:getTime()

	return var_18_0 >= self._activityStartTime and var_18_0 <= self._activityExpireTime
end

function BountyData:getActivityState()
	local var_19_0 = var_0_0:getTime()

	if var_19_0 <= self._activityStartTime and var_19_0 < self._activityEndTime then
		return var_0_1.ACTIVITY_STATE.OPEN
	elseif var_19_0 <= self._activityEndTime and var_19_0 < self._activityExpireTime then
		return var_0_1.ACTIVITY_STATE.RESULT
	end

	return var_0_1.ACTIVITY_STATE.NOT_OPEN
end

function BountyData:getActivityTimeInfo()
	return {
		startTime = self._activityStartTime,
		endTime = self._activityEndTime,
		expireTime = self._activityExpireTime
	}
end

function BountyData:getHelpScoreLimit()
	return self._findInfo.help_score
end

function BountyData:getActivityId()
	return self._activityId
end

function BountyData:getHelpRate()
	return (self._findInfo or nil) and (self._findInfo.help_rate or 0)
end

function BountyData:getMonsterInfoByStarNum(arg_24_1)
	return self._monsterInfoDict[arg_24_1]
end

function BountyData:getMyMonsterList()
	return self._myMonsterList
end

function BountyData:updateMonsterAlive(arg_26_1)
	local var_26_0, var_26_1, var_26_2 = self:getMonsterById(arg_26_1.id)

	self._defeatedMonster = nil

	if arg_26_1.is_win then
		table.remove(var_26_1, var_26_2)

		self._defeatedMonster = var_26_0
	end

	if arg_26_1.daily_help_score then
		self._myHelpScore = arg_26_1.daily_help_score
	end
end

function BountyData:getMonsterById(arg_27_1)
	local var_27_0
	local var_27_1 = -1
	local var_27_2

	for iter_27_0, iter_27_1 in ipairs(self._myMonsterList) do
		if iter_27_1:getId() == arg_27_1 then
			var_27_1 = iter_27_0
			var_27_0 = self._myMonsterList
			var_27_2 = iter_27_1

			return iter_27_1, self._myMonsterList, iter_27_0
		end
	end

	for iter_27_2, iter_27_3 in ipairs(self._shareMonsterList) do
		for iter_27_4, iter_27_5 in ipairs(iter_27_3) do
			for iter_27_6, iter_27_7 in ipairs(iter_27_5) do
				if iter_27_7:getId() == arg_27_1 then
					var_27_1 = iter_27_6
					var_27_0 = iter_27_5
					var_27_2 = iter_27_7

					return iter_27_7, iter_27_5, iter_27_6
				end
			end
		end
	end

	return var_27_2, var_27_0, var_27_1
end

function BountyData:onGetShareMonsterAward(arg_28_1)
	self:_removeMonsterById(arg_28_1, self._myMonsterList)

	for iter_28_0, iter_28_1 in ipairs(self._shareMonsterList) do
		for iter_28_2, iter_28_3 in ipairs(iter_28_1) do
			if self:_removeMonsterById(arg_28_1, iter_28_3) then
				break
			end
		end
	end
end

function BountyData:_removeMonsterById(arg_29_1, arg_29_2)
	if not arg_29_2 then
		local var_29_0, var_29_1, var_29_2 = self:getMonsterById(arg_29_1)

		if var_29_1 then
			table.remove(var_29_1, var_29_2)
		end
	else
		for iter_29_0, iter_29_1 in ipairs(arg_29_2) do
			if iter_29_1:getId() == arg_29_1 then
				table.remove(arg_29_2, iter_29_0)

				return true
			end
		end
	end
end

function BountyData:getDefeatedMonster()
	return self._defeatedMonster
end

function BountyData:isSummonEnableByType(arg_31_1)
	if #self._myMonsterList > var_0_1.MONSTER_SUMMON_MAX_NUM then
		return false
	end

	if arg_31_1 == var_0_1.MONSTER_SUMMON_TYPE.LOW then
		-- block empty
	elseif arg_31_1 == var_0_1.MONSTER_SUMMON_TYPE.HIGH then
		-- block empty
	end

	return false
end

function BountyData:getSummonCostByType(arg_32_1)
	return self._summonCostInfo[arg_32_1]
end

function BountyData:getDailyRankList()
	return self._dailyRankList
end

function BountyData:getRankListAndMyRank(arg_34_1)
	local var_34_0 = self._rankList

	if arg_34_1 then
		var_34_0 = {}

		for iter_34_0, iter_34_1 in ipairs(self._rankList) do
			if arg_34_1 < iter_34_0 then
				break
			end

			var_34_0[iter_34_0] = iter_34_1
		end
	end

	return var_34_0, self._myGuildRank
end

function BountyData:getScore()
	return self._myScore
end

function BountyData:getHelpScore()
	return self._myHelpScore
end

function BountyData:getShareMonsterListByShareType(arg_37_1)
	return self._shareMonsterList[arg_37_1 + 1]
end

function BountyData:getRankRwdList()
	return self._rankRwdData.list
end

function BountyData:getShareRequestStarMap()
	return self._shareRequestStarMap
end

function BountyData:updateLastChallengeResult(arg_40_1, arg_40_2)
	local var_40_0 = false

	for iter_40_0, iter_40_1 in ipairs(self._myMonsterList) do
		if iter_40_1:getId() == arg_40_2 then
			var_40_0 = true
		end
	end

	if var_40_0 then
		self._lastChallengeResult = arg_40_1
	end
end

function BountyData:resetLastChallengeResult()
	self._lastChallengeResult = true
end

function BountyData:getLastChallengeResult()
	return self._lastChallengeResult
end

function BountyData:onS2CFlushRedPoint(arg_43_1)
	self:updateActivityData(arg_43_1.act_info)

	self._shareRed = arg_43_1.monster_share_award
	self._taskRed = arg_43_1.task_award
	self._dailyRed = arg_43_1.daily_score_award
	self._challengeRed = arg_43_1.can_challenge
end

function BountyData:onS2CBountyGetInfo(arg_44_1)
	self._myScore = arg_44_1.score
	self._myHelpScore = arg_44_1.daily_help_score
	self._battleCount = arg_44_1.times

	self:updateActivityData(arg_44_1.act_info)
	self:onUpdateTaskList(arg_44_1.tasks)
	self:updateMyMonsterList(arg_44_1.monsters or {}, true)

	for iter_44_0, iter_44_1 in ipairs(arg_44_1.share_type_star) do
		self._shareRequestStarMap[iter_44_1.id] = iter_44_1.num
	end
end

function BountyData:updateActivityData(arg_45_1)
	self._activityId = arg_45_1.sub_id or 0
	self._activityStartTime = arg_45_1.start_time or 0
	self._activityEndTime = arg_45_1.end_time or 0
	self._activityExpireTime = arg_45_1.expire_time or 0
	self._activityOpenDay = arg_45_1.open_day or 0

	self:_initMonsterReward()

	self._findInfo = var_0_5.fetch(self._activityId)

	self:_initRankReward()

	if self:isActivityInOpenTime() then
		g.core.model.User.giftData:refreshInTime()
	end
end

function BountyData:updateMyMonsterList(arg_46_1, arg_46_2)
	self._myMonsterList = {}

	for iter_46_0, iter_46_1 in ipairs(arg_46_1) do
		self:addMyMonster(iter_46_1)
	end

	self:sortMyMonsterData()

	self._challengeRed = false
end

function BountyData:addMyMonster(arg_47_1, arg_47_2)
	local var_47_0 = BountyMonsterStruct.new(arg_47_1)

	if arg_47_2 then
		table.insert(self._myMonsterList, 1, var_47_0)
		var_47_0:setIsNew(true)
	else
		table.insert(self._myMonsterList, var_47_0)
	end
end

function BountyData:sortMyMonsterData()
	table.sort(self._myMonsterList, function(arg_49_0, arg_49_1)
		local var_49_0 = arg_49_0:getExpireTime()
		local var_49_1 = arg_49_1:getExpireTime()

		if var_49_0 ~= var_49_1 then
			return var_49_0 < var_49_1
		end

		local var_49_2 = arg_49_0:getStarNum()
		local var_49_3 = arg_49_1:getStarNum()

		if var_49_2 ~= var_49_3 then
			return var_49_3 < var_49_2
		end

		return arg_49_0:getAdvanceId() > arg_49_1:getAdvanceId()
	end)
end

function BountyData:updateShareMonsterList(arg_50_1)
	local var_50_0 = arg_50_1.monsters or {}
	local var_50_1 = self:resetShareMonster(arg_50_1.share_type)

	self._shareRequestStarMap = {}

	for iter_50_0, iter_50_1 in ipairs(arg_50_1.share_type_star) do
		self._shareRequestStarMap[iter_50_1.id] = iter_50_1.num
	end

	local var_50_2 = {}

	for iter_50_2, iter_50_3 in ipairs(var_50_0) do
		local var_50_3 = BountyMonsterStruct.new(iter_50_3)
		local var_50_4 = var_50_3:getStarNum()

		var_50_2[var_50_4] = var_50_1[var_50_4]
		var_50_1[var_50_4][#var_50_1[var_50_4] + 1] = var_50_3
	end

	for iter_50_4, iter_50_5 in pairs(var_50_2) do
		self:sortShareMonsterList(iter_50_5, arg_50_1.share_type)
	end

	if arg_50_1.share_type == var_0_1.SHARE_SEL_TYPE.MINE then
		self._shareRed = false
	end
end

function BountyData:sortShareMonsterList(arg_51_1, arg_51_2)
	table.sort(arg_51_1, function(arg_52_0, arg_52_1)
		local var_52_0 = arg_52_0:getStarNum()
		local var_52_1 = arg_52_1:getStarNum()

		if var_52_0 ~= var_52_1 then
			return var_52_1 < var_52_0
		end

		local var_52_2 = arg_52_0:getExpireTime()
		local var_52_3 = arg_52_1:getExpireTime()

		if var_52_2 ~= var_52_3 then
			return var_52_2 < var_52_3
		end

		return arg_52_0:getAdvanceId() > arg_52_1:getAdvanceId()
	end)
end

function BountyData:onUpdateTaskList(arg_53_1)
	self._taskList = {}

	for iter_53_0, iter_53_1 in ipairs(arg_53_1) do
		local var_53_0 = BountyTaskStruct.new(iter_53_1.id, self._activityId)

		var_53_0:updateTask(iter_53_1)

		self._taskList[#self._taskList + 1] = var_53_0
	end

	self._taskRed = false
end

function BountyData:getTaskList()
	return self._taskList
end

function BountyData:onGetTaskAward(arg_55_1)
	for iter_55_0, iter_55_1 in ipairs(self._taskList) do
		if iter_55_1:getCfg().id == arg_55_1 then
			iter_55_1:receiveAward()

			break
		end
	end
end

function BountyData:onS2CCommonRankList(arg_56_1)
	self._myGuildRank = arg_56_1.self_guild_rank or 0
	self._rankList = arg_56_1.units or {}
end

function BountyData:isInShareCD(arg_57_1)
	return g.core.common.ServerTime:getTime() - (self._shareCD[arg_57_1] or 0) < var_0_1.SHARE_CD
end

function BountyData:updateMyMonsterShareType(arg_58_1)
	self._shareCD[arg_58_1.id] = g.core.common.ServerTime:getTime()

	for iter_58_0, iter_58_1 in ipairs(self._myMonsterList) do
		if iter_58_1:getId() == arg_58_1.id then
			iter_58_1:setShareType(arg_58_1.share_type)

			break
		end
	end
end

function BountyData:addGetDailyAwardUserIdByList(arg_59_1)
	for iter_59_0, iter_59_1 in ipairs(arg_59_1) do
		self:addGetDailyAwardUserId(iter_59_1)
	end
end

function BountyData:addGetDailyAwardUserId(arg_60_1)
	self._dailyUserIdMap[arg_60_1] = true
end

function BountyData:updateScoreData(arg_61_1)
	self._dailyUserIdMap = {}
	self._dailyRankList = {}

	for iter_61_0, iter_61_1 in ipairs(arg_61_1.award_daily_score_user_ids or {}) do
		self._dailyUserIdMap[iter_61_1] = true
	end

	self._isJoinGuildToday = arg_61_1.today_join_guild

	for iter_61_2, iter_61_3 in ipairs(arg_61_1.user_daily_score or {}) do
		local var_61_0

		for iter_61_4, iter_61_5 in ipairs(self._dailyCfgList) do
			var_61_0 = iter_61_5

			if iter_61_3.daily_score > iter_61_5.cfg.score_min then
				var_61_0 = {
					score = 0,
					uid = 0,
					cfg = iter_61_5.cfg
				}

				local var_61_1 = math.floor(iter_61_5.cfg.value / 1000 * iter_61_3.daily_score)

				table.insert(self._dailyRankList, var_61_0)

				break
			end
		end

		var_61_0.score = iter_61_3.daily_score
		var_61_0.uid = iter_61_3.user_id
	end

	self._dailyRed = false
end

function BountyData:getDailyRankInfoList()
	return self._dailyRankList
end

function BountyData:isGetDailyReward(arg_63_1)
	if self._isJoinGuildToday then
		return true
	else
		return self._dailyUserIdMap[arg_63_1]
	end
end

function BountyData:isJoinGuildToday()
	return self._isJoinGuildToday
end

function BountyData:_updateTaskValue(arg_65_1)
	for iter_65_0, iter_65_1 in ipairs(arg_65_1) do
		local var_65_0 = false

		for iter_65_2, iter_65_3 in ipairs(self._taskList) do
			if iter_65_3:getCfg().id == iter_65_1.id then
				iter_65_3:updateCurValue(iter_65_1.status)

				var_65_0 = true

				break
			end
		end

		if not var_65_0 then
			local var_65_1 = BountyTaskStruct.new(iter_65_1.id, self._activityId)

			var_65_1:updateCurValue(iter_65_1.status)

			self._taskList[#self._taskList + 1] = var_65_1
		end
	end
end

function BountyData:onS2CActionStatusFlush(arg_66_1)
	if not self:isActivityOpen() then
		return
	end

	self:_updateTaskValue({
		arg_66_1.status
	})
end

function BountyData:onS2CBountyGetMonsterDetailInfo(arg_67_1)
	if arg_67_1.error_ret then
		return
	end

	self:getMonsterById(arg_67_1.id):updateMonsterDetail(arg_67_1)
end

function BountyData:canSummon(arg_68_1)
	if not self:isActivityInOpenTime() then
		return false
	end

	local var_68_0 = self:getSummonCostByType(var_0_1.MONSTER_SUMMON_TYPE.LOW)

	if g.core.model.User.bagData:getOwnNum(var_68_0.type, var_68_0.value) >= var_68_0.size then
		return true
	end

	local var_68_1 = self:getSummonCostByType(var_0_1.MONSTER_SUMMON_TYPE.HIGH)

	if g.core.model.User.bagData:getOwnNum(var_68_1.type, var_68_1.value) >= var_68_1.size then
		return true
	end

	return false
end

function BountyData:canBattleMonster(arg_69_1)
	if not self:isActivityInOpenTime() then
		return false
	end

	if self._challengeRed then
		return true
	end

	if #self._myMonsterList > 0 then
		return true
	end

	for iter_69_0, iter_69_1 in ipairs(self._shareMonsterList) do
		for iter_69_2, iter_69_3 in ipairs(iter_69_1) do
			return #iter_69_3 > 0
		end
	end

	return false
end

function BountyData:canGetTaskReward(arg_70_1)
	if not self:isActivityInOpenTime() then
		return false
	end

	if self._taskRed then
		return true
	else
		local var_70_0 = arg_70_1.type

		for iter_70_0, iter_70_1 in ipairs(self._taskList) do
			if (not var_70_0 or var_70_0 == iter_70_1:getRefreshType()) and iter_70_1:canReceive() then
				return true
			end
		end
	end
end

function BountyData:canGetDailyReward(arg_71_1)
	if self._dailyRed then
		return true
	else
		for iter_71_0, iter_71_1 in ipairs(self._dailyRankList) do
			if iter_71_1.uid > 0 and not self:isGetDailyReward(iter_71_1.uid) and math.floor(iter_71_1.cfg.value / 1000 * iter_71_1.score) > 0 and iter_71_0 <= 5 then
				return true
			end
		end
	end
end

function BountyData:canGetShareReward(arg_72_1)
	if self._shareRed then
		return true
	end

	for iter_72_0, iter_72_1 in ipairs((self:getShareMonsterListByShareType(var_0_1.SHARE_SEL_TYPE.MINE))) do
		for iter_72_2, iter_72_3 in ipairs(iter_72_1) do
			if iter_72_3:getKillUserId() ~= 0 then
				return true
			end
		end
	end

	return false
end

function BountyData:isHaveFreeGift()
	if not self:isActivityOpen() then
		return false
	end

	if self:getCurStage() ~= var_0_1.ACTIVITY_STATE.OPEN then
		return false
	end

	for iter_73_0, iter_73_1 in ipairs(g.core.model.User.giftData:getGiftListByShopTypeValue(g.core.const.ConstMgr.ShopConst.SHOP_TYPE.GIFT, g.core.const.ConstMgr.ShopConst.SHOP_GIFT_VALUE.BOUNTY_GIFT) or {}) do
		if iter_73_1.diamond_price == 0 and iter_73_1.recharge_type == 0 then
			return iter_73_1.buyTimes == 0
		end
	end

	return false
end

function BountyData:isNewActivityBounty()
	self._cacheMap = self._cacheMap or g.core.common.Storage:load("bounty_act_cache.json") or {}

	if self._activityId == 0 or self._cacheMap[self._activityId] then
		return false
	end

	return self:isInActiveTime()
end

function BountyData:saveNewActivityBounty()
	self._cacheMap = self._cacheMap or {}
	self._cacheMap[self._activityId] = true

	g.core.common.Storage:save("bounty_act_cache.json", self._cacheMap)
end

return BountyData
