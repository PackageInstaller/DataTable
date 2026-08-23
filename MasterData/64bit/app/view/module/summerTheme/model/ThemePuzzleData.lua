local ThemePuzzleData = class("ThemePuzzleData")
local var_0_2 = g.core.config.game_puzzle_info
local var_0_3 = g.core.config.activity_theme_info
local var_0_4 = g.core.const.ConstMgr.ThemeConst

function ThemePuzzleData:ctor()
	self:initData()
end

function ThemePuzzleData:initData()
	self._activeStartTime = 0
	self._themeInfoId = 0
	self._miniGameId = 0
	self._miniGameStartTime = 0
	self._miniGameEndTime = 0
	self._phaseRankIds = {}
	self._isAwarded = false
	self._randPicId = 1
	self._phase = 1
	self._miniGamePhaseDay = {}
	self._historyMyRank = {}
	self._phaseHistoryRank = nil
	self._phaseCurRank = nil
end

function ThemePuzzleData:startByActivityData(arg_3_1)
	self._activeThemeType = arg_3_1:getActivityType()
	self._activeThemeValue = arg_3_1:getConfigActivityValue()
	self._sourceType = arg_3_1:getActivitySourceType()
	self._activeStartTime = arg_3_1:getStartTime()
	self._activityInfo = arg_3_1:getInfo()
	self._miniGamePhaseDay = {}

	for iter_3_0 = 1, 3 do
		self._miniGamePhaseDay[iter_3_0] = self._activityInfo["mini_game_phase" .. iter_3_0] or 0
	end

	self._miniGameId = var_0_3.get(self._activeThemeValue).minigame_id

	self:_initPhasePuzzleInfo()
end

function ThemePuzzleData:_initPhasePuzzleInfo()
	self._phasePuzzle = {}

	for iter_4_0 = 1, var_0_2.getLength() do
		local var_4_0 = var_0_2.indexOf(iter_4_0)

		if var_4_0.minigame_id == self._miniGameId then
			self._phasePuzzle[var_4_0.phase] = self._phasePuzzle[var_4_0.phase] or {}
			self._phasePuzzle[var_4_0.phase] = var_4_0
		end
	end
end

function ThemePuzzleData:getPhasePuzzleInfo(arg_5_1)
	return self._phasePuzzle[arg_5_1]
end

function ThemePuzzleData:refreshRedPointData(arg_6_1)
	self:onS2CPuzzleGetInfo(arg_6_1)
end

function ThemePuzzleData:onS2CPuzzleGetInfo(arg_7_1)
	self._themeInfoId = arg_7_1.id or 0
	self._miniGameId = arg_7_1.game_id or 0

	if self._miniGameId == 0 then
		return
	end

	self._miniGameStartTime = arg_7_1.start_time or 0
	self._miniGameEndTime = arg_7_1.end_time or 0
	self._phaseRankIds = arg_7_1.rank_id or {}
	self._isAwarded = arg_7_1.is_award == 1 or false
	self._randPicId = arg_7_1.rand_config_id or 1
	self._phase = arg_7_1.phase or 1
end

function ThemePuzzleData:onS2CPuzzleResult(arg_8_1)
	self._isAwarded = arg_8_1.is_award == 1 or false
	self._phaseRankIds = arg_8_1.rank_id or {}
end

function ThemePuzzleData:getRandPicId()
	return self._randPicId
end

function ThemePuzzleData:getMiniGameId()
	return self._miniGameId
end

function ThemePuzzleData:getCurPhase()
	return self._phase
end

function ThemePuzzleData:getPhaseRankIds()
	return self._phaseRankIds
end

function ThemePuzzleData:getPhaseIdByRankId(arg_13_1)
	for iter_13_0, iter_13_1 in pairs(self._phaseRankIds) do
		if arg_13_1 == iter_13_1.num then
			return iter_13_1.id
		end
	end
end

function ThemePuzzleData:hasGotAwards()
	if not self:isProcess() then
		return false
	end

	if var_0_3.get(self._activeThemeValue).minigame_type == var_0_4.THEME_MINIGAME_TYPE.PUZZLE then
		return self._isAwarded
	else
		return true
	end
end

function ThemePuzzleData:getPuzzleStartTime()
	return self._miniGameStartTime
end

function ThemePuzzleData:getPuzzleEndTime()
	return self._miniGameEndTime
end

function ThemePuzzleData:isProcess()
	local var_17_0 = g.core.common.ServerTime:getTime()

	return var_17_0 > self._miniGameStartTime and var_17_0 < self._miniGameEndTime
end

function ThemePuzzleData:getCurPhaseEndTime()
	local var_18_0 = self._miniGameStartTime

	for iter_18_0 = 1, self._phase do
		if self._miniGamePhaseDay[iter_18_0] then
			var_18_0 = var_18_0 + self._miniGamePhaseDay[iter_18_0] * 86400
		end
	end

	return var_18_0
end

function ThemePuzzleData:hasNewPhase()
	local var_19_0

	if not self:isProcess() then
		do return false end

		var_19_0 = g.core.common.Storage:load("puzzleCache.json", true) or {}
	end

	return not var_19_0[self._activeThemeType .. "_" .. self._activeThemeValue .. "_" .. self._miniGameId .. "_" .. self._phase]
end

function ThemePuzzleData:savePuzzleNewPhase()
	local var_20_0 = g.core.common.Storage:load("puzzleCache.json", true) or {}

	var_20_0[self._activeThemeType .. "_" .. self._activeThemeValue .. "_" .. self._miniGameId .. "_" .. self._phase] = true

	g.core.common.Storage:save("puzzleCache.json", var_20_0, true)
end

return ThemePuzzleData
