local KsMath = require("app.core.utils.KsMath")
local var_0_1 = g.core.const.ConstMgr.ThemeConst
local var_0_2 = g.core.const.ConstMgr.ActivityConst.ACTIVITY_SOURCE_TYPE
local var_0_3 = g.core.common.Goods
local SummerThemeBossData = class("SummerThemeBossData", require("app.core.model.BaseData"))

function SummerThemeBossData:ctor()
	SummerThemeBossData.super.ctor(self)

	self._activeThemeType = nil
	self._activeThemeValue = nil
	self._curBossId = nil
	self._bossStartTime = 0
	self._curBossPhase = 0
	self._curPhaseLeaveTS = -1
	self._baseInfoArr = nil
	self._sourceType = var_0_2.CONFIG_TABLE
	self._activeStartTime = 0
	self._activeFinishTime = 0
	self.dailyRankID = 0
	self.activityRankID = 0
	self.dayScore = 0
	self._totalScore = 0
	self.dayRank = 0
	self.totalRank = 0
	self.fightNum = 0
	self.dayRewardArr = nil
	self.totalRewardArr = nil
	self.mergeAwardArr = nil
	self._scoreInfoList = {}
	self._getAwardIdDict = {}
end

function SummerThemeBossData:configThemeType()
	return self._activeThemeType
end

function SummerThemeBossData:configThemeVal()
	return self._activeThemeValue
end

function SummerThemeBossData:isThemeStart()
	return self._activeThemeValue ~= nil
end

function SummerThemeBossData:startByActivityData(arg_5_1)
	self._activeThemeType = arg_5_1:getActivityType()
	self._activeThemeValue = arg_5_1:getConfigActivityValue()
	self._sourceType = arg_5_1:getActivitySourceType()
	self._activeStartTime = arg_5_1:getStartTime()
	self._activeFinishTime = arg_5_1:getFinishTime()
	self._activityInfo = arg_5_1:getInfo()

	local var_5_0 = g.core.config.activity_theme_info.get(self._activeThemeValue)

	self._bossStartTime = self._activityInfo.boss_time or self._activeStartTime + var_5_0.boss_time

	self:_initCfgData(var_5_0.boss_id, var_5_0.integral_award)
	self:_calcBossPhase()

	if var_5_0.version == var_0_1.THEME_ACTIVITY_BOSS_VERSION.SECOND then
		local var_5_1 = self:getBaseInfo() or self:getDefaultBaseInfo()

		if var_5_1 then
			self.activityRankID = var_5_1.activity_rank
		end
	else
		self.dailyRankID = var_5_0.daily_rank
		self.activityRankID = var_5_0.activity_rank
	end

	self:_initBossRankData()
end

function SummerThemeBossData:refreshRedPointData(arg_6_1)
	self:refreshBossCrossDay()

	if self:isThemeStart() then
		if g.core.config.activity_theme_info.get(self._activeThemeValue).version == var_0_1.THEME_ACTIVITY_BOSS_VERSION.SECOND then
			local var_6_0 = {
				num = arg_6_1.num
			}

			var_6_0.total_point = arg_6_1.phase_point or 0
			var_6_0.award_ids = arg_6_1.award_ids or {}

			self:onNetHandleAutoBossGetInfo(var_6_0)
		else
			self:onNetHandleBossGetInfo(arg_6_1)
		end
	end
end

function SummerThemeBossData:requestBossRankInfo()
	local var_7_0 = self._sourceType == var_0_2.CONFIG_TABLE and 1 or 0
	local var_7_1 = g.core.network.GameNetProxy

	g.core.network.GameNetProxy:send_C2S_DemonBoss_GetRankList({
		size = 50,
		rank_type = 0,
		recruit_type = self._sourceType == var_0_2.CONFIG_TABLE and 1 or 0,
		id = self._activeThemeValue
	})
	var_7_1:send_C2S_DemonBoss_GetRankList({
		size = 50,
		rank_type = 1,
		recruit_type = var_7_0,
		id = self._activeThemeValue
	})
end

function SummerThemeBossData:requestBossInfo()
	g.core.network.GameNetProxy:send_C2S_DemonBoss_GetInfo({
		recruit_type = self._sourceType == var_0_2.CONFIG_TABLE and 1 or 0,
		id = self._activeThemeValue
	})
end

function SummerThemeBossData:requestBossFight()
	local var_9_0

	if self._curBossId == nil or self._curBossPhase <= 0 then
		do return end

		var_9_0 = {}
	end

	var_9_0.recruit_type = self._sourceType == var_0_2.CONFIG_TABLE and 1 or 0
	var_9_0.act_id = self._activeThemeValue
	var_9_0.boss_id = self._curBossId
	var_9_0.phase = self._curBossPhase

	g.core.network.GameNetProxy:send_C2S_DemonBoss_BeginChallenge(var_9_0)
end

function SummerThemeBossData:requestAutoBossRankInfo()
	if self:getBaseInfo() then
		g.core.network.GameNetProxy:send_C2S_DemonBoss_GetRankList({
			size = 50,
			rank_type = 1,
			recruit_type = self._sourceType == var_0_2.CONFIG_TABLE and 1 or 0,
			id = self._activeThemeValue
		})
	end
end

function SummerThemeBossData:requestAutoBossGetInfo()
	g.core.network.GameNetProxy:send_C2S_DemonAutoBoss_GetInfo({
		recruit_type = self._sourceType == var_0_2.CONFIG_TABLE and 1 or 0,
		id = self._activeThemeValue
	})
end

function SummerThemeBossData:requestAutoBossFight()
	local var_12_0

	if self._curBossId == nil or self._curBossPhase <= 0 then
		do return end

		var_12_0 = {}
	end

	var_12_0.recruit_type = self._sourceType == var_0_2.CONFIG_TABLE and 1 or 0
	var_12_0.act_id = self._activeThemeValue
	var_12_0.boss_id = self._curBossId
	var_12_0.phase = self._curBossPhase

	g.core.network.GameNetProxy:send_C2S_DemonAutoBoss_BeginChallenge(var_12_0)
end

function SummerThemeBossData:requestAutoBossGetAllAward()
	if self._curBossId == nil or self._curBossPhase <= 0 then
		return false
	end

	local var_13_0 = {}

	for iter_13_0 = #self:getScoreInfoList(), 1, -1 do
		local var_13_1 = self:getScoreInfoByIndex(iter_13_0)

		if var_13_1.integral_demand <= self:getTotalScore() and not self:isGetAwardById(var_13_1.id) then
			table.insert(var_13_0, var_13_1.id)
		end
	end

	local var_13_2

	if #var_13_0 <= 0 then
		do return false end

		var_13_2 = {}
	end

	var_13_2.recruit_type = self._sourceType == var_0_2.CONFIG_TABLE and 1 or 0
	var_13_2.id = self._activeThemeValue
	var_13_2.ids = var_13_0

	g.core.network.GameNetProxy:send_C2S_DemonAutoBoss_GetAward(var_13_2)

	return true
end

function SummerThemeBossData:onNetHandleBossGetInfo(arg_14_1)
	local var_14_0 = self:getBaseInfo()

	self.fightNum = var_14_0 and var_14_0.daily_times - arg_14_1.num or 0
	self.dayScore = arg_14_1.daily_point
	self._totalScore = arg_14_1.total_point
	self.dayRank = arg_14_1.daily_rank or self.dayRank
	self.totalRank = arg_14_1.total_rank or self.totalRank
end

function SummerThemeBossData:onNetHandleAutoBossGetInfo(arg_15_1)
	local var_15_0 = self:getBaseInfo()

	self.fightNum = var_15_0 and var_15_0.daily_times - arg_15_1.num or 0
	self.dayScore = arg_15_1.daily_point or 0
	self._totalScore = arg_15_1.total_point or 0
	self.totalRank = arg_15_1.self_rank or self.totalRank

	for iter_15_0, iter_15_1 in ipairs(arg_15_1.award_ids or {}) do
		self._getAwardIdDict[iter_15_1] = true
	end
end

function SummerThemeBossData:onNetHandleAutoBossGetAward(arg_16_1)
	for iter_16_0, iter_16_1 in ipairs(arg_16_1.ids or {}) do
		self._getAwardIdDict[iter_16_1] = true
	end
end

function SummerThemeBossData:onNetHandleBossRankInfo(arg_17_1)
	if arg_17_1.id == self._activeThemeValue then
		if arg_17_1.rank_type == 0 then
			self.dayRank = arg_17_1.self_rank
		else
			self.totalRank = arg_17_1.self_rank
		end
	end
end

function SummerThemeBossData:getBaseInfo()
	return self._baseInfoArr[self._curBossPhase]
end

function SummerThemeBossData:getDefaultBaseInfo()
	return self._baseInfoArr[1]
end

function SummerThemeBossData:getBossStartTime()
	return self._bossStartTime
end

function SummerThemeBossData:getBossOpenState()
	if self._curBossPhase > 0 then
		return var_0_1.THEME_STATE_TYPE.OPENING
	elseif self._curPhaseLeaveTS < 0 then
		return var_0_1.THEME_STATE_TYPE.UNOPEN
	else
		return var_0_1.THEME_STATE_TYPE.FINISH
	end
end

function SummerThemeBossData:getCurPhase()
	return self._curBossPhase
end

function SummerThemeBossData:getCurLeaveTime()
	if self._curPhaseLeaveTS < 0 then
		return 0
	end

	return (math.ceil(self._curPhaseLeaveTS / 86400))
end

function SummerThemeBossData:refreshBossCrossDay()
	if self:isExpired() then
		self:resetExpired()
		self:_calcBossPhase()
	end
end

function SummerThemeBossData:_initCfgData(arg_25_1, arg_25_2)
	if self._curBossId == arg_25_1 then
		return
	end

	self._curBossId = arg_25_1
	self._baseInfoArr = {}

	for iter_25_0 = 1, g.core.config.activity_theme_boss_info.getLength() do
		local var_25_0 = g.core.config.activity_theme_boss_info.indexOf(iter_25_0)

		if self._curBossId == var_25_0.boss_id then
			self._baseInfoArr[var_25_0.phase] = var_25_0
		end
	end

	self._scoreInfoList = {}

	for iter_25_1 = 1, g.core.config.activity_theme_boss_integral_info.getLength() do
		local var_25_1 = g.core.config.activity_theme_boss_integral_info.indexOf(iter_25_1)

		if arg_25_2 == var_25_1.group then
			table.insert(self._scoreInfoList, var_25_1)
		end
	end

	table.sort(self._scoreInfoList, function(arg_26_0, arg_26_1)
		return arg_26_0.integral_demand > arg_26_1.integral_demand
	end)
end

function SummerThemeBossData:_calcBossPhase()
	local var_27_0 = g.core.common.ServerTime:getTime()

	if var_27_0 < self._bossStartTime then
		self._curBossPhase = 0
		self._curPhaseLeaveTS = -1

		return
	end

	local var_27_1 = 1

	while var_27_1 > 0 do
		if var_27_0 < self._bossStartTime + (self._activityInfo["boss_last_time" .. var_27_1] or self._baseInfoArr[var_27_1].last_time) then
			self._curBossPhase = var_27_1
			self._curPhaseLeaveTS = self._bossStartTime + (self._activityInfo["boss_last_time" .. var_27_1] or self._baseInfoArr[var_27_1].last_time) - var_27_0

			if var_27_0 >= self._activeFinishTime then
				self._curBossPhase = 0
				self._curPhaseLeaveTS = 0
			elseif var_27_0 + self._curPhaseLeaveTS > self._activeFinishTime then
				self._curPhaseLeaveTS = self._activeFinishTime - var_27_0
			end

			return
		end

		var_27_1 = self._baseInfoArr[var_27_1].next_phase
	end

	self._curBossPhase = 0
	self._curPhaseLeaveTS = 0
end

function SummerThemeBossData:_initBossRankData()
	if self.dayRewardArr then
		return
	end

	self.dayRewardArr = g.core.config.rank_award_info.match(function(arg_29_0)
		return arg_29_0.rank_type == self.dailyRankID and arg_29_0.activity_id == self._activeThemeValue
	end)
	self.totalRewardArr = g.core.config.rank_award_info.match(function(arg_30_0)
		return arg_30_0.rank_type == self.activityRankID and arg_30_0.activity_id == self._activeThemeValue
	end)

	self:_calcBossAwardList()
end

function SummerThemeBossData:_calcBossAwardList()
	local var_31_0 = {}

	for iter_31_0, iter_31_1 in pairs(self.totalRewardArr) do
		self:_addOneBossAward(iter_31_1, var_31_0)
	end

	for iter_31_2, iter_31_3 in pairs(self.dayRewardArr) do
		self:_addOneBossAward(iter_31_3, var_31_0)
	end

	self.mergeAwardArr = {}

	for iter_31_4, iter_31_5 in pairs(var_31_0) do
		table.insert(self.mergeAwardArr, iter_31_5)
	end

	table.sort(self.mergeAwardArr, function(arg_32_0, arg_32_1)
		if arg_32_0.quality == arg_32_1.quality then
			return arg_32_0.info.id > arg_32_1.info.id
		end

		return arg_32_0.quality > arg_32_1.quality
	end)
end

function SummerThemeBossData:_addOneBossAward(arg_33_1, arg_33_2)
	for iter_33_0 = 1, 4 do
		if arg_33_1["reward_type" .. iter_33_0] ~= 0 then
			arg_33_2[arg_33_1["reward_type" .. iter_33_0] .. "_" .. arg_33_1["reward_value" .. iter_33_0]] = arg_33_2[arg_33_1["reward_type" .. iter_33_0] .. "_" .. arg_33_1["reward_value" .. iter_33_0]] or var_0_3:convert({
				size = 1,
				type = arg_33_1["reward_type" .. iter_33_0],
				value = arg_33_1["reward_value" .. iter_33_0]
			})
		end
	end
end

function SummerThemeBossData:redCheckBossNewPhase()
	if self._curBossPhase <= 0 then
		return false
	end

	if KsMath.transitionNeedPlayOnce("theme_boss_phase_" .. self._activeThemeType .. "_" .. self._activeThemeValue .. "_" .. self._curBossPhase) then
		return true
	end

	return false
end

function SummerThemeBossData:redCheckBossChallengeCount()
	local var_35_0

	if self._curBossPhase <= 0 then
		do return false end

		var_35_0 = self.fightNum
	end

	return var_35_0 >= self:getBaseInfo().daily_times
end

function SummerThemeBossData:redCheckBossHasAwardCanGet()
	if self._curBossPhase <= 0 then
		return false
	end

	for iter_36_0 = #self:getScoreInfoList(), 1, -1 do
		local var_36_0 = self:getScoreInfoByIndex(iter_36_0)

		if var_36_0.integral_demand <= self:getTotalScore() and not self:isGetAwardById(var_36_0.id) then
			return true
		end
	end

	return false
end

function SummerThemeBossData:redDoBossNewPhase()
	if self._curBossPhase <= 0 then
		return
	end

	if KsMath.transitionNeedPlayOnce("theme_boss_phase_" .. self._activeThemeType .. "_" .. self._activeThemeValue .. "_" .. self._curBossPhase) then
		KsMath.transitionPlayOnceSet("theme_boss_phase_" .. self._activeThemeType .. "_" .. self._activeThemeValue .. "_" .. self._curBossPhase)
	end
end

function SummerThemeBossData:getCurBoss()
	return self._curBossId
end

function SummerThemeBossData:getScoreInfoList()
	return self._scoreInfoList
end

function SummerThemeBossData:getScoreListCurIndex()
	local var_40_0 = #self._scoreInfoList

	for iter_40_0, iter_40_1 in ipairs(self._scoreInfoList) do
		if self:getTotalScore() >= iter_40_1.integral_demand then
			var_40_0 = iter_40_0

			break
		end
	end

	return var_40_0
end

function SummerThemeBossData:isGetAwardById(arg_41_1)
	return self._getAwardIdDict[arg_41_1] == true
end

function SummerThemeBossData:getScoreInfoByIndex(arg_42_1)
	return self._scoreInfoList[arg_42_1]
end

function SummerThemeBossData:getCurProgressValue()
	local var_43_0 = 0
	local var_43_1 = {}

	for iter_43_0, iter_43_1 in ipairs(self._scoreInfoList) do
		if self:getTotalScore() >= iter_43_1.integral_demand then
			var_43_0 = iter_43_0
			var_43_1 = iter_43_1

			break
		end
	end

	local var_43_3 = self:getScoreInfoByIndex(var_43_0 == 0 and #self._scoreInfoList or var_43_0 - 1)
	local var_43_4 = self:getTotalScore()
	local var_43_5 = var_43_1.integral_demand or 0
	local var_43_6

	if var_43_3 then
		var_43_6 = var_43_3.integral_demand or var_43_4
	end

	return (var_43_4 - var_43_5) / (var_43_6 - var_43_5), var_43_5, var_43_6
end

function SummerThemeBossData:getShowAwardInfo()
	local var_44_0 = 0

	for iter_44_0 = #self:getScoreInfoList(), 1, -1 do
		local var_44_1 = self:getScoreInfoByIndex(iter_44_0)

		if var_44_1.integral_demand <= self:getTotalScore() then
			if not self:isGetAwardById(var_44_1.id) then
				var_44_0 = iter_44_0
			end
		elseif var_44_0 == 0 then
			return var_44_1, iter_44_0
		else
			break
		end
	end

	if var_44_0 == 0 then
		return self:getScoreInfoByIndex(1), 1
	else
		return self:getScoreInfoByIndex(var_44_0), var_44_0
	end
end

function SummerThemeBossData:getTotalScore()
	return self._totalScore
end

function SummerThemeBossData:getSourceType()
	return self._sourceType
end

function SummerThemeBossData:isThirdBoss()
	return false
end

return SummerThemeBossData
