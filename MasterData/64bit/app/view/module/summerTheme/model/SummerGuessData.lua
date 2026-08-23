local var_0_0 = g.core.config.activity_theme_info
local var_0_1 = g.core.config.game_guess_info
local var_0_2 = g.core.config.game_guess_question_info
local var_0_3 = g.core.const.ConstMgr.ThemeConst
local SummerGuessData = class("SummerGuessData")

function SummerGuessData:ctor()
	self:initData()
end

function SummerGuessData:initData()
	self._activeStartTime = 0
	self._themeInfoId = 0
	self._miniGameId = 0
	self._miniGameStartTime = 0
	self._miniGameEndTime = 0
	self._phaseRankIds = {}
	self._isAwarded = false
	self._phase = 1
	self._miniGamePhaseDay = {}
	self._indexMap = {}
	self._allGroupQuestions = {}
	self._miniGameId = 1

	self:_initPhaseGuessInfo()
end

function SummerGuessData:startByActivityData(arg_3_1)
	self._activeThemeType = arg_3_1:getActivityType()
	self._activeThemeValue = arg_3_1:getConfigActivityValue()
	self._sourceType = arg_3_1:getActivitySourceType()
	self._activeStartTime = arg_3_1:getStartTime()
	self._activityInfo = arg_3_1:getInfo()
	self._miniGamePhaseDay = {}

	for iter_3_0 = 1, 3 do
		self._miniGamePhaseDay[iter_3_0] = self._activityInfo["mini_game_phase" .. iter_3_0] or 0
	end

	self._miniGameId = var_0_0.get(self._activeThemeValue).minigame_id

	self:_initPhaseGuessInfo()
end

function SummerGuessData:_initPhaseGuessInfo()
	self._phaseGuess = {}

	for iter_4_0 = 1, var_0_1.getLength() do
		local var_4_0 = var_0_1.indexOf(iter_4_0).toObject()

		if var_4_0.minigame_id == self._miniGameId then
			self._phaseGuess[var_4_0.phase] = self._phaseGuess[var_4_0.phase] or {}
			self._phaseGuess[var_4_0.phase] = var_4_0
			self._indexMap[var_4_0.index] = var_4_0.phase
		end
	end

	self._allGroupQuestions = {}

	for iter_4_1 = 1, var_0_2.getLength() do
		local var_4_1 = var_0_2.indexOf(iter_4_1)

		self._allGroupQuestions[var_4_1.group] = self._allGroupQuestions[var_4_1.group] or {}

		table.insert(self._allGroupQuestions[var_4_1.group], var_4_1)
	end
end

function SummerGuessData:getIndexPhase(arg_5_1)
	return self._indexMap[arg_5_1] or 1
end

function SummerGuessData:getPhaseIndex(arg_6_1)
	return self._phaseGuess[arg_6_1].index
end

function SummerGuessData:getPhaseGuessInfo(arg_7_1)
	return self._phaseGuess[self:getIndexPhase(arg_7_1)]
end

function SummerGuessData:onS2CGuessResult(arg_8_1)
	self._isAwarded = true
	self._phaseRankIds = arg_8_1.rank_id or {}
end

function SummerGuessData:on_S2C_Guess_GetInfo(arg_9_1)
	self._themeInfoId = arg_9_1.id or 0
	self._miniGameId = arg_9_1.game_id or 0

	if self._miniGameId == 0 then
		return
	end

	self._miniGameStartTime = arg_9_1.start_time or 0
	self._miniGameEndTime = arg_9_1.end_time or 0
	self._phaseRankIds = arg_9_1.rank_id or {}
	self._isAwarded = arg_9_1.day_award == 1 or false
	self._phase = arg_9_1.phase or 1
end

function SummerGuessData:refreshRedPointData(arg_10_1)
	self._themeInfoId = arg_10_1.id or 0
	self._miniGameId = arg_10_1.game_id or 0
	self._isAwarded = arg_10_1.day_award == 1 or false
	self._phase = arg_10_1.phase or 1
	self._miniGameStartTime = arg_10_1.start_time or 0
	self._miniGameEndTime = arg_10_1.end_time or 0
end

function SummerGuessData:getGuessStartTime()
	return self._miniGameStartTime
end

function SummerGuessData:getGuessEndTime()
	return self._miniGameEndTime
end

function SummerGuessData:isProcess()
	local var_13_0 = g.core.common.ServerTime:getTime()

	return var_13_0 > self._miniGameStartTime and var_13_0 < self._miniGameEndTime
end

function SummerGuessData:getMiniGameId()
	return self._miniGameId
end

function SummerGuessData:getCurPhase()
	return self:getPhaseIndex(self._phase)
end

function SummerGuessData:getCurRealPhase()
	return self._phase
end

function SummerGuessData:getPhaseRankIds()
	return self._phaseRankIds
end

function SummerGuessData:getPhaseIdByRankId(arg_18_1)
	for iter_18_0, iter_18_1 in pairs(self._phaseRankIds) do
		if arg_18_1 == iter_18_1.num then
			return iter_18_1.id
		end
	end
end

function SummerGuessData:hasGotAwards()
	if not self:isProcess() then
		return false
	end

	if var_0_0.get(self._activeThemeValue).minigame_type == var_0_3.THEME_MINIGAME_TYPE.GUESS then
		return self._isAwarded
	else
		return true
	end
end

function SummerGuessData:getCurPhaseEndTime()
	local var_20_0 = self._miniGameStartTime

	for iter_20_0 = 1, self._phase do
		if self._miniGamePhaseDay[iter_20_0] then
			var_20_0 = var_20_0 + self._miniGamePhaseDay[iter_20_0] * 86400
		end
	end

	return var_20_0
end

function SummerGuessData:hasNewPhase()
	local var_21_0

	if not self:isProcess() then
		do return false end

		var_21_0 = g.core.common.Storage:load("themeGuessCache.json", true) or {}
	end

	return not var_21_0[self._activeThemeType .. "_" .. self._activeThemeValue .. "_" .. self._miniGameId .. "_" .. self._phase]
end

function SummerGuessData:saveGuessNewPhase()
	local var_22_0 = g.core.common.Storage:load("themeGuessCache.json", true) or {}

	var_22_0[self._activeThemeType .. "_" .. self._activeThemeValue .. "_" .. self._miniGameId .. "_" .. self._phase] = true

	g.core.common.Storage:save("themeGuessCache.json", var_22_0, true)
end

function SummerGuessData:getNextQuestionGroup()
	local var_23_0 = self._allGroupQuestions[self:getPhaseGuessInfo(self:getCurPhase()).question_group]
	local var_23_1 = table.keys(var_23_0)
	local var_23_2 = {}

	for iter_23_0 = 1, #var_23_1 do
		table.insert(var_23_2, (table.remove(var_23_1, (math.random(1, #var_23_1)))))
	end

	local var_23_3 = {}

	for iter_23_1, iter_23_2 in ipairs(var_23_2) do
		table.insert(var_23_3, var_23_0[iter_23_2].id)
	end

	return var_23_3
end

function SummerGuessData:getQuestionById(arg_24_1)
	return var_0_2.get(arg_24_1)
end

return SummerGuessData
