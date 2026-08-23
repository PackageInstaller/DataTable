local var_0_0 = g.core.config.activity_theme_boss_integral_info
local var_0_1 = g.core.config.talent_skill_info
local var_0_2 = g.core.const.ConstMgr.LineUpConst
local var_0_3 = g.core.const.ConstMgr.ThemeThirdBossConst
local ThemeThirdBossTalentStruct = require("app.view.module.summerThemeThirdBoss.model.ThemeThirdBossTalentStruct")
local KsMath = require("app.core.utils.KsMath")
local var_0_6 = g.core.config.activity_theme_talent_info
local var_0_7 = g.core.const.ConstMgr.ThemeConst
local var_0_8 = g.core.const.ConstMgr.ActivityConst.ACTIVITY_SOURCE_TYPE
local var_0_9 = g.core.common.Goods
local ThemeThirdBossData = class("ThemeThirdBossData", require("app.core.model.BaseData"))

function ThemeThirdBossData:ctor()
	ThemeThirdBossData.super.ctor(self)

	self._themeType = 0
	self._themeValue = 0
	self._actId = 0
	self._curBossId = 0
	self._bossStartTime = 0
	self._curBossPhase = 0
	self._curPhaseLeaveTS = -1
	self._baseInfoArr = nil
	self._sourceType = var_0_8.CONFIG_TABLE
	self._activeStartTime = 0
	self._activeFinishTime = 0
	self._dayRank = 0
	self._totalRank = 0
	self._totalScore = 0
	self._totalRewardArr = nil
	self._mergeAwardArr = nil
	self._activityRankID = 0
	self._fightNum = 0
	self._awardNum = 0
	self._scoreInfoList = {}
	self._getAwardIdDict = {}
	self._talentDict = {}
	self._talentXList = {}
	self._firstPassDict = nil
end

function ThemeThirdBossData:getThemeType()
	return self._themeType
end

function ThemeThirdBossData:getThemeVal()
	return self._themeValue
end

function ThemeThirdBossData:isThemeStart()
	return self._themeValue > 0
end

function ThemeThirdBossData:startByActivityData(arg_5_1)
	self._themeType = arg_5_1:getActivityType()
	self._themeValue = arg_5_1:getConfigActivityValue()
	self._actId = arg_5_1:getActivityId()
	self._sourceType = arg_5_1:getActivitySourceType()
	self._activeStartTime = arg_5_1:getStartTime()
	self._activeFinishTime = arg_5_1:getFinishTime()
	self._activityInfo = arg_5_1:getInfo()

	local var_5_0 = g.core.config.activity_theme_info.get(self._themeValue)

	self._bossStartTime = self._activityInfo.boss_time or self._activeStartTime + var_5_0.boss_time

	self:_initCfgData(var_5_0)
	self:_calcBossPhase()

	self._activityRankID = (self:getBaseInfo() or self:getDefaultBaseInfo()).activity_rank

	self:_initBossRankData()
end

function ThemeThirdBossData:refreshRedPointData(arg_6_1)
	self:refreshBossCrossDay()

	if self:isThemeStart() then
		self:onNetHandleBossGetInfo(arg_6_1)
	end
end

function ThemeThirdBossData:requestBossInfo()
	g.core.network.GameNetProxy:send_C2S_NewDemonBoss_GetInfo({
		act_id = self._themeValue
	})
end

function ThemeThirdBossData:getActId()
	return self._actId
end

function ThemeThirdBossData:onNetHandleBossGetInfo(arg_9_1)
	local var_9_0 = self:getBaseInfo()

	if var_9_0 then
		self._fightNum = var_9_0.daily_times - arg_9_1.num
		self._awardNum = math.max(0, var_9_0.daily_award_times - arg_9_1.num)
	else
		self._fightNum = 0
	end

	self._totalScore = arg_9_1.total_point
	self._totalRank = arg_9_1.self_rank or self._totalRank

	for iter_9_0, iter_9_1 in ipairs(arg_9_1.talent_ids or {}) do
		self:getTalentById(iter_9_1):setActive(true)
	end

	for iter_9_2, iter_9_3 in ipairs(arg_9_1.award_ids or {}) do
		self._getAwardIdDict[iter_9_3] = true
	end
end

function ThemeThirdBossData:onNetHandleChallengeFinishInfo(arg_10_1)
	self._fightNum = self._fightNum - 1
	self._awardNum = math.max(0, self._awardNum - 1)
	self._totalScore = arg_10_1.total_point

	self:_markFirstPassDone()
end

function ThemeThirdBossData:onNetHandleActiveTalentInfo(arg_11_1)
	for iter_11_0, iter_11_1 in ipairs(arg_11_1.talent_ids or {}) do
		self:getTalentById(iter_11_1):setActive(true)
	end
end

function ThemeThirdBossData:onNetHandleResetTalentInfo(arg_12_1)
	for iter_12_0, iter_12_1 in ipairs(arg_12_1.talent_ids or {}) do
		self:getTalentById(iter_12_1):setActive(false)
	end
end

function ThemeThirdBossData:onNetHandleAutoBossGetAward(arg_13_1)
	for iter_13_0, iter_13_1 in ipairs(arg_13_1.ids or {}) do
		self._getAwardIdDict[iter_13_1] = true
	end
end

function ThemeThirdBossData:onNetHandleBossRankInfo(arg_14_1)
	if arg_14_1.id == self._themeValue then
		if arg_14_1.rank_type == 0 then
			self._dayRank = arg_14_1.self_rank
		else
			self._totalRank = arg_14_1.self_rank
		end
	end
end

function ThemeThirdBossData:getBaseInfo()
	if self._baseInfoArr[self._curBossPhase] then
		return self._baseInfoArr[self._curBossPhase]
	end

	return self:getDefaultBaseInfo()
end

function ThemeThirdBossData:getDefaultBaseInfo()
	return self._baseInfoArr[1]
end

function ThemeThirdBossData:getBossStartTime()
	return self._bossStartTime
end

function ThemeThirdBossData:getBossOpenState()
	if self._curBossPhase > 0 then
		return var_0_7.THEME_STATE_TYPE.OPENING
	elseif self._curPhaseLeaveTS < 0 then
		return var_0_7.THEME_STATE_TYPE.UNOPEN
	else
		return var_0_7.THEME_STATE_TYPE.FINISH
	end
end

function ThemeThirdBossData:getCurPhase()
	return self._curBossPhase
end

function ThemeThirdBossData:getCurLeaveTime()
	if self._curPhaseLeaveTS < 0 then
		return 0
	end

	return math.ceil(self._curPhaseLeaveTS / 86400)
end

function ThemeThirdBossData:refreshBossCrossDay()
	if self:isExpired() then
		self:resetExpired()
		self:_calcBossPhase()
	end
end

function ThemeThirdBossData:_initCfgData(arg_22_1)
	if self._curBossId == arg_22_1.boss_id then
		return
	end

	self._curBossId = arg_22_1.boss_id
	self._baseInfoArr = {}

	for iter_22_0 = 1, g.core.config.activity_theme_boss_new_info.getLength() do
		local var_22_0 = g.core.config.activity_theme_boss_new_info.indexOf(iter_22_0)

		if self._curBossId == var_22_0.boss_id then
			self._baseInfoArr[var_22_0.phase] = var_22_0
		end
	end

	self._scoreInfoList = {}

	for iter_22_1 = 1, var_0_0.getLength() do
		local var_22_1 = var_0_0.indexOf(iter_22_1)

		if arg_22_1.integral_award == var_22_1.group then
			table.insert(self._scoreInfoList, var_22_1)
		end
	end

	table.sort(self._scoreInfoList, function(arg_23_0, arg_23_1)
		return arg_23_0.integral_demand < arg_23_1.integral_demand
	end)

	self._talentDict = {}
	self._talentXList = {}

	for iter_22_2, iter_22_3 in var_0_6.ipairs() do
		if iter_22_3.group == arg_22_1.talent_group then
			local var_22_2 = self:getTalentById(iter_22_3.id, true)

			if iter_22_3.front_pot_1 > 0 then
				local var_22_3 = self:getTalentById(iter_22_3.front_pot_1, true)

				var_22_3:addChild(var_22_2)
				var_22_2:addParent(var_22_3)
			end

			if iter_22_3.front_pot_2 > 0 then
				local var_22_4 = self:getTalentById(iter_22_3.front_pot_2, true)

				var_22_4:addChild(var_22_2)
				var_22_2:addParent(var_22_4)
			end

			self._talentXList[iter_22_3.module_id] = self._talentXList[iter_22_3.module_id] or {}

			table.insert(self._talentXList[iter_22_3.module_id], var_22_2)
		end
	end
end

function ThemeThirdBossData:getTalentXList()
	return self._talentXList
end

function ThemeThirdBossData:getTalentModuleList(arg_25_1)
	return self._talentXList[arg_25_1] or {}
end

function ThemeThirdBossData:getTalentById(arg_26_1, arg_26_2)
	if not self._talentDict[arg_26_1] and arg_26_2 then
		self._talentDict[arg_26_1] = ThemeThirdBossTalentStruct.new(arg_26_1)
	end

	return self._talentDict[arg_26_1]
end

function ThemeThirdBossData:_calcBossPhase()
	local var_27_0 = g.core.common.ServerTime:getTime()

	if var_27_0 < self._bossStartTime then
		self._curBossPhase = 0
		self._curPhaseLeaveTS = -1

		return
	end

	local var_27_1 = 1

	while var_27_1 > 0 do
		if var_27_0 < self._bossStartTime + self._activityInfo["boss_last_time" .. var_27_1] then
			self._curBossPhase = var_27_1
			self._curPhaseLeaveTS = self._bossStartTime + self._activityInfo["boss_last_time" .. var_27_1] - var_27_0

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

function ThemeThirdBossData:_initBossRankData()
	if self._totalRewardArr then
		return
	end

	self._totalRewardArr = g.core.config.rank_award_info.match(function(arg_29_0)
		return arg_29_0.rank_type == self._activityRankID and arg_29_0.activity_id == self._themeValue
	end)

	self:_calcBossAwardList()
end

function ThemeThirdBossData:_calcBossAwardList()
	local var_30_0 = {}

	for iter_30_0, iter_30_1 in pairs(self._totalRewardArr) do
		self:_addOneBossAward(iter_30_1, var_30_0)
	end

	self._mergeAwardArr = {}

	for iter_30_2, iter_30_3 in pairs(var_30_0) do
		table.insert(self._mergeAwardArr, iter_30_3)
	end

	table.sort(self._mergeAwardArr, function(arg_31_0, arg_31_1)
		if arg_31_0.quality == arg_31_1.quality then
			return arg_31_0.info.id > arg_31_1.info.id
		end

		return arg_31_0.quality > arg_31_1.quality
	end)
end

function ThemeThirdBossData:_addOneBossAward(arg_32_1, arg_32_2)
	for iter_32_0 = 1, 4 do
		if arg_32_1["reward_type" .. iter_32_0] ~= 0 then
			arg_32_2[arg_32_1["reward_type" .. iter_32_0] .. "_" .. arg_32_1["reward_value" .. iter_32_0]] = arg_32_2[arg_32_1["reward_type" .. iter_32_0] .. "_" .. arg_32_1["reward_value" .. iter_32_0]] or var_0_9:convert({
				size = 1,
				type = arg_32_1["reward_type" .. iter_32_0],
				value = arg_32_1["reward_value" .. iter_32_0]
			})
		end
	end
end

function ThemeThirdBossData:redCheckBossNewPhase()
	if self._curBossPhase <= 0 then
		return false
	end

	if KsMath.transitionNeedPlayOnce("theme_boss_phase_" .. self._themeType .. "_" .. self._themeValue .. "_" .. self._curBossPhase) then
		return true
	end

	return false
end

function ThemeThirdBossData:redCheckBossChallengeCount()
	local var_34_0

	if self._curBossPhase <= 0 then
		do return false end

		var_34_0 = self._fightNum
	end

	return var_34_0 >= self:getBaseInfo().daily_times
end

function ThemeThirdBossData:redCheckBossHasAwardCanGet(arg_35_1)
	if self._curBossPhase <= 0 then
		return false
	end

	if arg_35_1 and arg_35_1.id then
		return var_0_0.get(arg_35_1.id).integral_demand <= self:getTotalScore() and not self:isGetAwardById(arg_35_1.id)
	end

	for iter_35_0 = 1, #self:getScoreInfoList() do
		local var_35_0 = self:getScoreInfoByIndex(iter_35_0)

		if var_35_0.integral_demand <= self:getTotalScore() and not self:isGetAwardById(var_35_0.id) then
			return true
		end
	end

	return false
end

function ThemeThirdBossData:redDoBossNewPhase()
	if self._curBossPhase <= 0 then
		return
	end

	if KsMath.transitionNeedPlayOnce("theme_boss_phase_" .. self._themeType .. "_" .. self._themeValue .. "_" .. self._curBossPhase) then
		KsMath.transitionPlayOnceSet("theme_boss_phase_" .. self._themeType .. "_" .. self._themeValue .. "_" .. self._curBossPhase)
	end
end

function ThemeThirdBossData:getCurBoss()
	return self._curBossId
end

function ThemeThirdBossData:getScoreInfoList()
	return self._scoreInfoList
end

function ThemeThirdBossData:getScoreListCurIndex()
	if self._scoreInfoList[#self._scoreInfoList].integral_demand <= self:getTotalScore() then
		return #self._scoreInfoList
	end

	local var_39_0 = 0

	for iter_39_0, iter_39_1 in ipairs(self._scoreInfoList) do
		if self:getTotalScore() < iter_39_1.integral_demand then
			break
		else
			var_39_0 = iter_39_0
		end
	end

	return var_39_0
end

function ThemeThirdBossData:isGetAwardById(arg_40_1)
	return self._getAwardIdDict[arg_40_1] == true
end

function ThemeThirdBossData:getScoreInfoByIndex(arg_41_1)
	return self._scoreInfoList[arg_41_1]
end

function ThemeThirdBossData:getCurProgressValue()
	local var_42_0 = 0
	local var_42_1 = {}
	local var_42_2 = self:getTotalScore()

	for iter_42_0, iter_42_1 in ipairs(self._scoreInfoList) do
		if var_42_2 < iter_42_1.integral_demand then
			break
		else
			var_42_0 = iter_42_0
			var_42_1 = iter_42_1
		end
	end

	local var_42_3 = var_42_1.integral_demand or 0

	if var_42_0 == #self._scoreInfoList then
		return 1, var_42_3, var_42_3
	else
		local var_42_4 = self:getScoreInfoByIndex(var_42_0 + 1)
		local var_42_5

		if var_42_4 then
			var_42_5 = var_42_4.integral_demand or var_42_2
		end

		return (var_42_2 - var_42_3) / math.min(1, var_42_5 - var_42_3), var_42_3, var_42_5
	end
end

function ThemeThirdBossData:getShowAwardIndex()
	local var_43_0 = self:getTotalScore()
	local var_43_1 = 1
	local var_43_2

	for iter_43_0 = 1, #self:getScoreInfoList() do
		local var_43_3 = self:getScoreInfoByIndex(iter_43_0)

		if var_43_0 >= var_43_3.integral_demand then
			if var_43_1 < iter_43_0 then
				var_43_1 = iter_43_0
			end

			if not self:isGetAwardById(var_43_3.id) and not var_43_2 then
				var_43_2 = iter_43_0
			end
		else
			break
		end
	end

	return var_43_1 or 1, var_43_2 or var_43_1
end

function ThemeThirdBossData:getTotalRank()
	return self._totalRank
end

function ThemeThirdBossData:getTotalScore()
	return self._totalScore
end

function ThemeThirdBossData:getSourceType()
	return self._sourceType
end

function ThemeThirdBossData:getFightNum()
	return self._fightNum
end

function ThemeThirdBossData:getRewardNum()
	return self._awardNum
end

function ThemeThirdBossData:getRecruitType()
	return self._sourceType == var_0_8.CONFIG_TABLE and 1 or 0
end

function ThemeThirdBossData:getBtnState(arg_50_1)
	if arg_50_1:isActive() then
		return var_0_3.btnState.UNLOCK
	elseif arg_50_1:parentIsActive() then
		return var_0_3.btnState.LOCK
	else
		local var_50_0 = arg_50_1:getInfo().module_id

		if #(self._talentXList[var_50_0] or {}) > 1 then
			return var_0_3.btnState.LOCK_TO
		else
			local var_50_1
			local var_50_2 = false

			for iter_50_0 = var_50_0 - 1, 1, -1 do
				local var_50_3 = self._talentXList[iter_50_0] or {}

				if #var_50_3 >= 2 then
					var_50_2 = true
				end

				for iter_50_1, iter_50_2 in ipairs(var_50_3) do
					if iter_50_2:isActive() then
						var_50_1 = var_50_3

						break
					end
				end

				if var_50_1 then
					break
				end
			end

			if var_50_1 and #var_50_1 >= 2 then
				local var_50_4

				for iter_50_3, iter_50_4 in ipairs(var_50_1) do
					if not iter_50_4:isActive() then
						var_50_4 = iter_50_4:getInfo().pot_location

						break
					end
				end

				return var_0_3.btnState.DOUBLE, var_50_4
			elseif var_50_2 then
				return var_0_3.btnState.DOUBLE
			else
				return var_0_3.btnState.LOCK_TO
			end
		end
	end
end

function ThemeThirdBossData:getUpActiveIds(arg_51_1)
	local var_51_0 = {
		arg_51_1:getId()
	}
	local var_51_1 = false

	for iter_51_0 = arg_51_1:getInfo().module_id - 1, 1, -1 do
		for iter_51_1, iter_51_2 in ipairs(self._talentXList[iter_51_0] or {}) do
			if iter_51_2:getInfo().pot_location <= 1 then
				if iter_51_2:isActive() then
					var_51_1 = true

					break
				else
					table.insert(var_51_0, iter_51_2:getId())
				end
			end
		end

		if var_51_1 then
			break
		end
	end

	return var_51_0
end

function ThemeThirdBossData:getDownActiveIds(arg_52_1)
	local var_52_0 = {
		arg_52_1:getId()
	}
	local var_52_1 = false

	for iter_52_0 = arg_52_1:getInfo().module_id - 1, 1, -1 do
		for iter_52_1, iter_52_2 in ipairs(self._talentXList[iter_52_0] or {}) do
			if iter_52_2:getInfo().pot_location >= 1 then
				if iter_52_2:isActive() then
					var_52_1 = true

					break
				else
					table.insert(var_52_0, iter_52_2:getId())
				end
			end
		end

		if var_52_1 then
			break
		end
	end

	return var_52_0
end

function ThemeThirdBossData:getToActiveIds(arg_53_1)
	local var_53_0 = {
		arg_53_1:getId()
	}
	local var_53_1 = arg_53_1:getInfo().module_id
	local var_53_2 = arg_53_1:getInfo().pot_location
	local var_53_3

	for iter_53_0 = var_53_1 - 1, 1, -1 do
		local var_53_5 = self._talentXList[iter_53_0] or {}

		for iter_53_1, iter_53_2 in ipairs(var_53_5) do
			if iter_53_2:isActive() and (math.abs(iter_53_2:getInfo().pot_location - var_53_2) <= 1 or (#var_53_5 == 1 or nil) and true) then
				var_53_3 = iter_53_2

				break
			end
		end

		if var_53_3 then
			break
		end
	end

	if var_53_3 then
		local var_53_6 = var_53_3:getChildList()
		local var_53_7 = var_53_3:getInfo().pot_location

		while #var_53_6 > 0 do
			local var_53_8 = {}

			for iter_53_3, iter_53_4 in ipairs(var_53_6) do
				if iter_53_4:getId() == arg_53_1:getId() then
					var_53_8 = {}

					break
				end

				if math.abs(iter_53_4:getInfo().pot_location - var_53_7) == 0 then
					if not iter_53_4:isActive() then
						table.insert(var_53_0, iter_53_4:getId())
					end

					var_53_8 = iter_53_4:getChildList()

					break
				else
					var_53_7 = var_53_2

					if math.abs(iter_53_4:getInfo().pot_location - var_53_2) <= 1 then
						table.insert(var_53_0, iter_53_4:getId())

						var_53_8 = iter_53_4:getChildList()

						break
					end
				end
			end

			var_53_6 = var_53_8
		end
	else
		for iter_53_5 = var_53_1 - 1, 1, -1 do
			for iter_53_6, iter_53_7 in ipairs(self._talentXList[iter_53_5] or {}) do
				if math.abs(iter_53_7:getInfo().pot_location - var_53_2) <= 1 then
					table.insert(var_53_0, iter_53_7:getId())
				end
			end
		end
	end

	return var_53_0
end

function ThemeThirdBossData:getAllActiveTalent()
	local var_54_0 = {}

	for iter_54_0, iter_54_1 in pairs(self._talentDict) do
		if iter_54_1:isActive() then
			var_54_0[iter_54_1:getId()] = iter_54_1
		end
	end

	return var_54_0
end

function ThemeThirdBossData:getActiveAttrData()
	local var_55_0 = {}
	local var_55_1 = {}

	for iter_55_0, iter_55_1 in pairs(self._talentDict) do
		if iter_55_1:isActive() then
			if iter_55_1:getInfo().pot_type == 3 then
				table.insert(var_55_0, iter_55_1:getInfo())
			else
				local var_55_2 = var_0_1.get(iter_55_1:getInfo().talent_skill)

				for iter_55_2 = 1, 3 do
					if var_55_2["affect_type_" .. iter_55_2] > 0 then
						var_55_1[var_55_2["affect_type_" .. iter_55_2]] = var_55_1[var_55_2["affect_type_" .. iter_55_2]] or 0
						var_55_1[var_55_2["affect_type_" .. iter_55_2]] = var_55_1[var_55_2["affect_type_" .. iter_55_2]] + var_55_2["affect_value_" .. iter_55_2]
					end
				end
			end
		end
	end

	local var_55_3 = {}

	for iter_55_3, iter_55_4 in pairs(var_55_1) do
		local var_55_4, var_55_5 = g.core.lang:getAttr(iter_55_3, iter_55_4)

		table.insert(var_55_3, {
			attrName = var_55_4,
			attrValue = var_55_5
		})
	end

	return var_55_3, var_55_0
end

function ThemeThirdBossData:getTotalRanRewardList()
	return self._totalRewardArr
end

function ThemeThirdBossData:getOutBaseFormationArr()
	local var_57_0 = {}

	table.insert(var_57_0, self:_toOutBaseFormation())

	return var_57_0
end

function ThemeThirdBossData:_toOutBaseFormation()
	return g.core.model.User.formationData:getMulTeamDataByCurFormation(var_0_2.MulTeamType.THEME_THIRD_BOSS)
end

function ThemeThirdBossData:isTalentRedTodayRecord()
	local var_59_0 = g.core.common.ServerTime:getDateObject()

	return (g.core.common.Storage:load("theme_third_talent_red.json") or {})[tostring(self._themeValue)] == string.format("%4d_%2d_%2d", var_59_0.year, var_59_0.month, var_59_0.day)
end

function ThemeThirdBossData:saveTalentRedTodayRecord()
	local var_60_0 = g.core.common.ServerTime:getDateObject()
	local var_60_1 = string.format("%4d_%2d_%2d", var_60_0.year, var_60_0.month, var_60_0.day)
	local var_60_2 = g.core.common.Storage:load("theme_third_talent_red.json") or {}
	local var_60_3 = tostring(self._themeValue)

	if var_60_2[var_60_3] ~= var_60_1 then
		var_60_2[var_60_3] = var_60_1

		g.core.common.Storage:save("theme_third_talent_red.json", var_60_2)
	end
end

function ThemeThirdBossData:isThirdBoss()
	return true
end

local var_0_11 = "theme_third_boss_first_pass.json"

function ThemeThirdBossData:_loadFirstPassData()
	if self._firstPassDict then
		return
	end

	self._firstPassDict = g.core.common.Storage:load(var_0_11) or {}
end

function ThemeThirdBossData:isFirstPassDone()
	self:_loadFirstPassData()

	return self._firstPassDict[tostring(self._themeValue)] == true
end

function ThemeThirdBossData:_markFirstPassDone()
	self:_loadFirstPassData()

	local var_64_0 = tostring(self._themeValue)

	if not self._firstPassDict[var_64_0] then
		self._firstPassDict[var_64_0] = true

		g.core.common.Storage:save(var_0_11, self._firstPassDict)
	end
end

function ThemeThirdBossData:_getBossTalentCost(arg_65_1)
	local var_65_0, var_65_1 = self:getBtnState(arg_65_1)
	local var_65_3 = 0

	for iter_65_0, iter_65_1 in pairs(var_65_0 == var_0_3.btnState.DOUBLE and (var_65_1 == 0 and self:getDownActiveIds(arg_65_1) or self:getUpActiveIds(arg_65_1)) or var_65_0 == var_0_3.btnState.LOCK_TO and self:getToActiveIds(arg_65_1) or {
		arg_65_1:getId()
	}) do
		var_65_3 = var_65_3 + self:getTalentById(iter_65_1):getInfo().activate_size
	end

	return var_65_3
end

function ThemeThirdBossData:hasTalentRed()
	local var_66_0 = -1

	for iter_66_0, iter_66_1 in pairs(self._talentDict) do
		if not iter_66_1:isActive() then
			local var_66_1 = iter_66_1:getInfo()

			if var_66_0 == -1 then
				var_66_0 = g.core.common.Goods:convert({
					type = var_66_1.activate_type,
					value = var_66_1.activate_value
				}).size
			end

			if var_66_0 >= self:_getBossTalentCost(iter_66_1) then
				return true
			end
		end
	end

	return false
end

return ThemeThirdBossData
