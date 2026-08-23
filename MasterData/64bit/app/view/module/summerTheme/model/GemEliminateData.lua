local var_0_0 = g.core.config.activity_theme_info
local var_0_1 = "gem_eliminate.json"
local var_0_2 = g.core.const.ConstMgr.ThemeConst
local var_0_3 = g.core.common.ServerTime
local var_0_4 = g.core.config.game_eliminate_info
local var_0_5 = g.core.config.game_eliminate_point_info
local var_0_6 = g.core.config.game_eliminate_point_info.getLength()
local GemData = class("GemData")

function GemData:ctor()
	self:initData()
end

function GemData:initData()
	self._jsonDict = nil
	self._maxCombo = 0
	self._totalEliScore = 0
	self._totalComboScore = 0
	self._curPhase = 0
	self._gemEliminateStartTime = 0
	self._gemEliminateEndTime = 0
	self._isGetAward = false
	self._phaseRankIds = {}
	self._miniGameId = 0
	self._phaseRankData = {}
	self._comboScoreArr = {}
	self._historyMyRank = {}

	self:_initComboScoreArr()
end

function GemData:startByActivityData(arg_3_1)
	self._activeThemeType = arg_3_1:getActivityType()
	self._activeThemeValue = arg_3_1:getConfigActivityValue()
	self._sourceType = arg_3_1:getActivitySourceType()
	self._activeStartTime = arg_3_1:getStartTime()
	self._activityInfo = arg_3_1:getInfo()
	self._miniGameId = g.core.config.activity_theme_info.get(self._activeThemeValue).minigame_id
	self._eliminateData = {}

	if not next(self._eliminateData) then
		self:_initPhaseEliminateInfo()
	end
end

function GemData:_initComboScoreArr()
	local var_4_0 = {}

	for iter_4_0, iter_4_1 in var_0_5.ipairs() do
		var_4_0[iter_4_1.id] = iter_4_1.point
	end

	self._comboScoreArr = var_4_0
end

function GemData:_initPhaseEliminateInfo()
	for iter_5_0 = 1, var_0_4.getLength() do
		local var_5_0 = var_0_4.indexOf(iter_5_0)

		self._eliminateData[var_5_0.minigame_id] = self._eliminateData[var_5_0.minigame_id] or {}
		self._eliminateData[var_5_0.minigame_id][var_5_0.phase] = var_5_0
	end
end

function GemData:getCurPhaseCfg()
	if not self._eliminateData[self._miniGameId] then
		return {}
	end

	return self._eliminateData[self._miniGameId][self._curPhase] or {}
end

function GemData:getGameId()
	return self._miniGameId
end

function GemData:getPhaseId()
	return self._curPhase
end

function GemData:getGemEliminateStartTime()
	return self._gemEliminateStartTime
end

function GemData:getPhaseInfoByPhase(arg_10_1)
	if not self._eliminateData[self._miniGameId] then
		return nil
	end

	return self._eliminateData[self._miniGameId][arg_10_1]
end

function GemData:getCurPhaseNeedDays()
	local var_11_0 = 0

	for iter_11_0 = 1, self._curPhase do
		local var_11_1 = self:getPhaseInfoByPhase(iter_11_0)

		if var_11_1 then
			var_11_0 = var_11_0 + (self._activityInfo["mini_game_phase" .. iter_11_0] or var_11_1.time)
		end
	end

	return var_11_0
end

function GemData:sendGemEliminateCommonRankInfo()
	for iter_12_0, iter_12_1 in pairs(self._phaseRankIds) do
		g.core.network.GameNetProxy:send_C2S_GetCommonRankList({
			size = 50,
			id = iter_12_1.num
		})
	end
end

function GemData:onS2CGemEliminateCommonRank(arg_13_1)
	local var_13_0 = self:getPhaseIdByRankId(arg_13_1.id)

	if var_13_0 then
		self._phaseRankData[var_13_0] = self._phaseRankData[var_13_0] or {}
		self._phaseRankData[var_13_0] = {
			rank = arg_13_1.rank_units,
			myRank = arg_13_1.self_rank
		}
		self._historyMyRank[var_13_0] = self._historyMyRank[var_13_0] or {}
		self._historyMyRank[var_13_0] = arg_13_1.self_rank
	end
end

function GemData:getHistoryMyRank(arg_14_1)
	return self._historyMyRank[arg_14_1]
end

function GemData:getPhaseIdByRankId(arg_15_1)
	for iter_15_0, iter_15_1 in pairs(self._phaseRankIds) do
		if arg_15_1 == iter_15_1.num then
			return iter_15_1.id
		end
	end
end

function GemData:getPhaseRankData(arg_16_1)
	return self._phaseRankData[arg_16_1]
end

function GemData:getGemEliminateEndTime()
	return self._gemEliminateEndTime
end

function GemData:onS2CGemEliminateGetInfo(arg_18_1)
	self._curPhase = arg_18_1.phase or 1
	self._gemEliminateStartTime = arg_18_1.start_time or 0
	self._gemEliminateEndTime = arg_18_1.end_time or 0
	self._isGetAward = arg_18_1.is_award or 0

	if arg_18_1.rank_id then
		self._phaseRankIds = arg_18_1.rank_id
	end
end

function GemData:onS2CEliminateResult(arg_19_1)
	self._isGetAward = arg_19_1.is_award or 0

	if arg_19_1.rank_id then
		self._phaseRankIds = arg_19_1.rank_id
	end
end

function GemData:resetGetRewardState()
	self._isGetAward = 0
end

function GemData:isGetTodayReward()
	if var_0_0.get(self._activeThemeValue).minigame_type == var_0_2.THEME_MINIGAME_TYPE.GEM_ELIMINATE then
		return self._isGetAward ~= 0
	else
		return true
	end
end

function GemData:isShowRewardRedPoint()
	return not self:isGetTodayReward()
end

function GemData:isHaveGemEliminateNewPhase()
	local var_23_0 = g.core.common.Storage:load("phaseGemCache.json", true)

	if not var_23_0 then
		return true
	else
		if var_23_0[self._activeThemeType .. "_" .. self._activeThemeValue .. "_" .. self._miniGameId .. "_" .. self._curPhase] then
			return false
		end

		return true
	end
end

function GemData:saveGemEliminateNewPhase()
	local var_24_0 = g.core.common.Storage:load("phaseGemCache.json", true)

	if not var_24_0 then
		g.core.common.Storage:save("phaseGemCache.json", {
			[self._activeThemeType .. "_" .. self._activeThemeValue .. "_" .. self._miniGameId .. "_" .. self._curPhase] = true
		}, true)
	elseif not var_24_0[self._activeThemeType .. "_" .. self._activeThemeValue .. "_" .. self._miniGameId .. "_" .. self._curPhase] then
		var_24_0[self._activeThemeType .. "_" .. self._activeThemeValue .. "_" .. self._miniGameId .. "_" .. self._curPhase] = true

		g.core.common.Storage:save("phaseGemCache.json", var_24_0, true)
	end
end

function GemData:refreshRedPointData(arg_25_1)
	self:onS2CGemEliminateGetInfo(arg_25_1)
end

function GemData:getComboScore(arg_26_1)
	arg_26_1 = math.min(var_0_6, arg_26_1)

	return self._comboScoreArr[arg_26_1]
end

function GemData:isNeedConfirm_2()
	return self:_getJsonDict().gemConfirm_2 == var_0_3:getDate()
end

function GemData:saveAfterConfirm_2()
	local var_28_0 = self:_getJsonDict()
	local var_28_1 = var_0_3:getDate()

	if var_28_0.gemConfirm_2 ~= var_28_1 then
		var_28_0.gemConfirm_2 = var_28_1

		g.core.common.Storage:save(var_0_1, var_28_0)
	end
end

function GemData:_getJsonDict()
	self._jsonDict = self._jsonDict or g.core.common.Storage:load(var_0_1) or {}

	return self._jsonDict
end

function GemData:refreshCombo(arg_30_1)
	local var_30_0 = self:getComboScore(arg_30_1)

	if arg_30_1 == 1 then
		self._totalEliScore = self._totalEliScore + var_30_0
	else
		self._totalComboScore = self._totalComboScore + var_30_0
	end

	self._maxCombo = math.max(self._maxCombo, arg_30_1)
end

function GemData:clearDataOnStartGame()
	self._totalEliScore = 0
	self._totalComboScore = 0
	self._maxCombo = 0
end

function GemData:getTotalScore()
	return self._totalEliScore + self._totalComboScore
end

function GemData:getTotalEliScore()
	return self._totalEliScore
end

function GemData:getTotalComboScore()
	return self._totalComboScore
end

function GemData:getMaxComboNum()
	return self._maxCombo
end

return GemData
