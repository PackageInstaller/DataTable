local var_0_0 = g.core.const.ConstMgr.ActivityConst.ACTIVITY_SOURCE_TYPE
local var_0_1 = g.core.const.ConstMgr.ThemeConst
local var_0_2 = g.core.config.turn_card_info
local var_0_3 = g.core.config.turn_card_wave_info
local var_0_4 = g.core.config.turn_card_res_info
local var_0_5 = g.core.config.activity_theme_info
local ThemeTurnCardData = class("ThemeTurnCardData", require("app.core.model.BaseData"))

function ThemeTurnCardData:ctor()
	self:initData()
end

function ThemeTurnCardData:initData()
	self._activeStartTime = 0
	self._activeThemeType = nil
	self._activeThemeValue = nil
	self._sourceType = var_0_0.CONFIG_TABLE
	self._miniGameId = 0
	self._curPhase = 1
	self._curWave = 1
	self._endlessWin = false
	self._bonusTime = 0
	self._scoreNum = 0
	self._timeScoreNum = 0
	self._turnCardStartTime = 0
	self._turnCardEndTime = 0
	self._passWaveSurplusT = 0
	self._endlessWaveNum = 0
	self._phaseCard = {}
	self._waveInfo = {}
	self._phaseRankData = {}
	self._historyMyRank = {}
	self._phaseRankIds = {}
	self._startId = 99999
end

function ThemeTurnCardData:startByActivityData(arg_3_1)
	self._activeThemeType = arg_3_1:getActivityType()
	self._activeThemeValue = arg_3_1:getConfigActivityValue()
	self._sourceType = arg_3_1:getActivitySourceType()
	self._activeStartTime = arg_3_1:getStartTime()
	self._activityInfo = arg_3_1:getInfo()
	self._miniGameId = g.core.config.activity_theme_info.get(self._activeThemeValue).minigame_id

	self:_initPhaseTurnCardInfo()
	self:_initTurnCardWaveInfo()
end

function ThemeTurnCardData:_initPhaseTurnCardInfo()
	self._phaseCard = {}

	for iter_4_0 = 1, var_0_2.getLength() do
		local var_4_0 = var_0_2.indexOf(iter_4_0)

		if var_4_0.minigame_id == self._miniGameId then
			self._phaseCard[var_4_0.phase] = self._phaseCard[var_4_0.phase] or {}
			self._phaseCard[var_4_0.phase] = var_4_0
			self._startId = math.min(self._startId, var_4_0.id)
		end
	end
end

function ThemeTurnCardData:_initTurnCardWaveInfo()
	self._waveInfo = {}

	for iter_5_0 = 1, var_0_3.getLength() do
		local var_5_0 = var_0_3.indexOf(iter_5_0)

		self._waveInfo[var_5_0.phase_id] = self._waveInfo[var_5_0.phase_id] or {}
		self._waveInfo[var_5_0.phase_id][var_5_0.wave] = self._waveInfo[var_5_0.phase_id][var_5_0.wave] or {}
		self._waveInfo[var_5_0.phase_id][var_5_0.wave] = var_5_0
	end
end

function ThemeTurnCardData:getPhaseCardInfo(arg_6_1)
	return self._phaseCard[arg_6_1]
end

function ThemeTurnCardData:getPhaseCfgByIndex(arg_7_1)
	local var_7_0 = table.values(self._phaseCard)

	table.sort(var_7_0, function(arg_8_0, arg_8_1)
		return arg_8_0.phase < arg_8_1.phase
	end)

	return var_7_0[arg_7_1]
end

function ThemeTurnCardData:getWaveInfoByPhase(arg_9_1, arg_9_2)
	if self._waveInfo[arg_9_1] then
		return self._waveInfo[arg_9_1][arg_9_2]
	end

	return nil
end

function ThemeTurnCardData:getWaveCountByPhase(arg_10_1)
	return (self._waveInfo[arg_10_1] or nil) and #self._waveInfo[arg_10_1]
end

function ThemeTurnCardData:getRandWaveResGroupData(arg_11_1, arg_11_2)
	local var_11_0 = {}
	local var_11_1 = self:getWaveInfoByPhase(arg_11_1, arg_11_2)

	if var_11_1 then
		for iter_11_0 = 1, var_0_4.getLength() do
			local var_11_2 = var_0_4.indexOf(iter_11_0)

			if var_11_2.group == var_11_1.res_group then
				table.insert(var_11_0, var_11_2.res)
			end
		end
	end

	for iter_11_1 = 1, #var_11_0 do
		local var_11_3 = math.random(iter_11_1, #var_11_0)

		var_11_0[iter_11_1], var_11_0[var_11_3] = var_11_0[var_11_3], var_11_0[iter_11_1]
	end

	return var_11_0
end

function ThemeTurnCardData:getTurnCardGameId()
	return self._miniGameId
end

function ThemeTurnCardData:requestTurnCardResult(arg_13_1)
	g.core.network.GameNetProxy:send_C2S_TurnCard_Result({
		id = self._activeThemeValue,
		game_id = self._miniGameId,
		phase = self._curPhase,
		score = self._scoreNum + self._timeScoreNum,
		state = arg_13_1 and 1 or 0
	})
end

function ThemeTurnCardData:refreshRedPointData(arg_14_1)
	self:onS2CTurnCardGetInfo(arg_14_1)
end

function ThemeTurnCardData:onS2CTurnCardGetInfo(arg_15_1)
	self._curPhase = arg_15_1.phase or 1
	self._turnCardStartTime = arg_15_1.start_time or 0
	self._turnCardEndTime = arg_15_1.end_time or 0
	self._isGetAward = arg_15_1.is_award or 0

	if arg_15_1.rank_id then
		self._phaseRankIds = arg_15_1.rank_id
	end
end

function ThemeTurnCardData:onS2CTurnCardResult(arg_16_1)
	self._isGetAward = arg_16_1.is_award or 0

	if arg_16_1.rank_id then
		self._phaseRankIds = arg_16_1.rank_id
	end
end

function ThemeTurnCardData:getPhaseIdByRankId(arg_17_1)
	for iter_17_0, iter_17_1 in pairs(self._phaseRankIds) do
		if arg_17_1 == iter_17_1.num then
			return iter_17_1.id
		end
	end
end

function ThemeTurnCardData:sendTurnCardCommonRankInfo()
	for iter_18_0, iter_18_1 in pairs(self._phaseRankIds) do
		g.core.network.GameNetProxy:send_C2S_GetCommonRankList({
			size = 50,
			id = iter_18_1.num
		})
	end
end

function ThemeTurnCardData:onS2CTurnCardCommonRank(arg_19_1)
	local var_19_0 = self:getPhaseIdByRankId(arg_19_1.id)

	if var_19_0 then
		self._phaseRankData[var_19_0] = self._phaseRankData[var_19_0] or {}
		self._phaseRankData[var_19_0] = {
			rank = arg_19_1.rank_units,
			myRank = arg_19_1.self_rank
		}
		self._historyMyRank[var_19_0] = self._historyMyRank[var_19_0] or {}
		self._historyMyRank[var_19_0] = arg_19_1.self_rank
	end
end

function ThemeTurnCardData:getPhaseRankIds()
	return self._phaseRankIds
end

function ThemeTurnCardData:getCurTurnCardPhase()
	return self._curPhase
end

function ThemeTurnCardData:goToNextTurnCardWave()
	local var_22_0 = self:getWaveInfoByPhase(self._curPhase, self._curWave)

	if var_22_0 then
		self._endlessWin = true
		self._bonusTime = var_22_0.bonus_time
		self._curWave = var_22_0.next_wave
		self._endlessWaveNum = self._endlessWaveNum + 1
	end
end

function ThemeTurnCardData:resetTurnCardWave()
	self._curWave = 1
	self._endlessWaveNum = 1
	self._bonusTime = 0
	self._passWaveSurplusT = 0
end

function ThemeTurnCardData:resetScore()
	self._scoreNum = 0
	self._timeScoreNum = 0
	self._endlessWin = false
	self._limitPauseTime = 1
end

function ThemeTurnCardData:resetTimeScore()
	self._timeScoreNum = 0
end

function ThemeTurnCardData:addScoreNum(arg_26_1)
	self._scoreNum = self._scoreNum + arg_26_1
end

function ThemeTurnCardData:setTimeScoreNum(arg_27_1)
	self._timeScoreNum = arg_27_1
end

function ThemeTurnCardData:setPassWaveSurplusTime(arg_28_1)
	self._passWaveSurplusT = arg_28_1
end

function ThemeTurnCardData:getPassWaveSurplusTime()
	return self._passWaveSurplusT
end

function ThemeTurnCardData:getScoreNum()
	return self._scoreNum
end

function ThemeTurnCardData:addOncePauseTime()
	self._limitPauseTime = self._limitPauseTime + 1
end

function ThemeTurnCardData:getLimitPauseTime()
	return self._limitPauseTime
end

function ThemeTurnCardData:getTimeScoreNum()
	return self._timeScoreNum
end

function ThemeTurnCardData:isEndlessModelWin()
	return self._endlessWin
end

function ThemeTurnCardData:getCurTurnCardWave()
	return self._curWave
end

function ThemeTurnCardData:getEndlessWaveNum()
	return self._endlessWaveNum
end

function ThemeTurnCardData:getWaveCanUseTime()
	local var_37_0 = 0

	if self._scoreNum == 0 then
		local var_37_1 = self:getPhaseCardInfo(self._curPhase)

		if var_37_1 then
			var_37_0 = var_37_1.base_time + self._bonusTime
		end
	else
		var_37_0 = self._passWaveSurplusT + self._bonusTime
	end

	return var_37_0
end

function ThemeTurnCardData:getTurnCardStartTime()
	return self._turnCardStartTime
end

function ThemeTurnCardData:getTurnCardEndTime()
	return self._turnCardEndTime
end

function ThemeTurnCardData:isGetTurnCardAwards()
	if var_0_5.get(self._activeThemeValue).minigame_type == var_0_1.THEME_MINIGAME_TYPE.TURN_CARD then
		return self._isGetAward == 1
	else
		return true
	end
end

function ThemeTurnCardData:getRankListData(arg_41_1)
	return self._phaseRankData[arg_41_1]
end

function ThemeTurnCardData:getHistoryMyRank(arg_42_1)
	return self._historyMyRank[arg_42_1]
end

function ThemeTurnCardData:getCurPhaseNeedDays()
	local var_43_0 = 0

	if not self._phaseCard[self._curPhase] then
		return var_43_0
	end

	for iter_43_0 = 1, self._phaseCard[self._curPhase].rank_idx do
		local var_43_1 = self:getPhaseCardInfo(self:getPhaseCfgByIndex(iter_43_0).phase)

		if var_43_1 then
			var_43_0 = var_43_0 + (self._activityInfo["mini_game_phase" .. iter_43_0] or var_43_1.time)
		end
	end

	return var_43_0
end

function ThemeTurnCardData:isHaveTurnCardNewPhase()
	if var_0_5.get(self._activeThemeValue).minigame_type ~= var_0_1.THEME_MINIGAME_TYPE.TURN_CARD then
		return false
	end

	local var_44_0 = self._activeThemeType .. "_" .. self._activeThemeValue .. "_" .. self._miniGameId .. "_" .. self._curPhase
	local var_44_1 = g.core.common.Storage:load("phaseCache.json", true)

	if not var_44_1 then
		return true
	else
		for iter_44_0, iter_44_1 in ipairs(var_44_1) do
			if iter_44_1 == var_44_0 then
				return false
			end
		end

		return true
	end
end

function ThemeTurnCardData:saveTurnCardNewPhase()
	local var_45_0 = g.core.common.Storage:load("phaseCache.json", true)

	if not var_45_0 then
		local var_45_1 = {}

		table.insert(var_45_1, self._activeThemeType .. "_" .. self._activeThemeValue .. "_" .. self._miniGameId .. "_" .. self._curPhase)
		g.core.common.Storage:save("phaseCache.json", var_45_1, true)
	else
		local var_45_2 = false

		for iter_45_0, iter_45_1 in ipairs(var_45_0) do
			if iter_45_1 == self._activeThemeType .. "_" .. self._activeThemeValue .. "_" .. self._miniGameId .. "_" .. self._curPhase then
				var_45_2 = true

				break
			end
		end

		if not var_45_2 then
			table.insert(var_45_0, self._activeThemeType .. "_" .. self._activeThemeValue .. "_" .. self._miniGameId .. "_" .. self._curPhase)
			g.core.common.Storage:save("phaseCache.json", var_45_0, true)
		end
	end
end

function ThemeTurnCardData:getPhaseStartId()
	return self._startId
end

return ThemeTurnCardData
