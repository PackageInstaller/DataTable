local var_0_0 = g.core.config.pubg_parameter_info
local var_0_1 = g.core.config.pubg_stage_info
local var_0_2 = g.core.config.pubg_hot_time_info
local PubgData = class("PubgData")
local PubgTaskData = require("app.view.module.pubg.model.PubgTaskData")
local PubgMapData = require("app.view.module.pubg.model.PubgMapData")
local var_0_6 = g.core.const.ConstMgr.PubgConst

function PubgData:ctor()
	self:initData()
end

function PubgData:initData()
	self._taskData = PubgTaskData.new()
	self._openServerDays = 0
	self._startTime = 0
	self._regularEndTime = 0
	self._finalEndTime = 0
	self._showEndTime = 0
	self._subId = 1
	self._totalRank = 0
	self._totalScore = 0
	self._dailyMaxScore = 0
	self._dailyMaxRank = 0
	self._curMatchState = 0
	self._curMatchNum = 0
	self._rankPlayerList = {}
	self._rankRewardList = {}
	self._gameRank = 0
	self._gameScore = 0
	self._gameRecordList = {}
	self._gameServerList = {}
	self._mapData = nil
end

function PubgData:onS2CRedPoint(arg_3_1)
	if arg_3_1.activity then
		self._openServerDays = arg_3_1.activity.open_day or 0

		self:initStageTime(arg_3_1.activity.start_time, arg_3_1.activity.end_time, arg_3_1.activity.expire_time)

		self._subId = arg_3_1.activity.sub_id or 1
	end
end

function PubgData:onS2CGetInfo(arg_4_1)
	self._totalRank = arg_4_1.rank or 0
	self._totalScore = arg_4_1.score or 0
	self._dailyMaxScore = arg_4_1.daily_max_score or 0
	self._dailyMaxRank = arg_4_1.daily_max_rank or 0
	self._curMatchState = arg_4_1.play and 1 or 0
	self._curMatchNum = arg_4_1.match_num or 0
end

function PubgData:onS2CCommonRankList(arg_5_1)
	self._rankPlayerList[arg_5_1.id] = arg_5_1.rank_units
end

function PubgData:onS2CEnterMap(arg_6_1)
	self:getMapData():onMapEnter(arg_6_1.room or {})
end

function PubgData:onS2CServerInfos(arg_7_1)
	self._gameServerList = arg_7_1.server_infos or {}
end

function PubgData:initStageTime(arg_8_1, arg_8_2, arg_8_3)
	self._startTime = arg_8_1 or 0
	self._regularEndTime = g.core.common.ServerTime:getEndTimeStamp(self._startTime, var_0_1.get(1).end_time)
	self._finalEndTime = arg_8_2 or 0
	self._showEndTime = arg_8_3 or 0
end

function PubgData:getCurStage()
	if not self:isOpenDaysAvailable() then
		return var_0_6.GAME_STATE.NOT_OPEN
	end

	local var_9_0 = g.core.common.ServerTime:getTime()

	if var_9_0 >= self._startTime and var_9_0 < self._regularEndTime then
		return var_0_6.GAME_STATE.REGULAR
	elseif var_9_0 >= self._regularEndTime and var_9_0 < self._finalEndTime then
		return var_0_6.GAME_STATE.FINAL
	elseif var_9_0 >= self._finalEndTime and var_9_0 < self._showEndTime then
		return var_0_6.GAME_STATE.SHOW
	else
		return var_0_6.GAME_STATE.NOT_OPEN
	end
end

function PubgData:getHotTimeDesc()
	local var_10_0 = ""

	for iter_10_0, iter_10_1 in var_0_2.ipairs() do
		local var_10_1 = math.floor(iter_10_1.start_time / 10000)
		local var_10_2 = math.floor(iter_10_1.start_time % 10000 / 100)
		local var_10_3 = math.floor(iter_10_1.end_time / 10000)
		local var_10_4 = math.floor(iter_10_1.end_time % 10000 / 100)

		if var_10_2 < 10 then
			var_10_2 = "0" .. var_10_2
		end

		if var_10_4 < 10 then
			var_10_4 = "0" .. var_10_4
		end

		var_10_0 = var_10_0 .. g.core.lang:get(430915, {
			startHour = var_10_1,
			startMin = var_10_2,
			endHour = var_10_3,
			endMin = var_10_4
		}) .. "    "
	end

	return var_10_0
end

function PubgData:getCampaignStr()
	local var_11_0 = self:getCurStage()

	if var_11_0 == var_0_6.GAME_STATE.REGULAR then
		return g.core.lang:get(430911)
	elseif var_11_0 == var_0_6.GAME_STATE.FINAL then
		return g.core.lang:get(430912)
	elseif var_11_0 == var_0_6.GAME_STATE.SHOW then
		return g.core.lang:get(430913)
	elseif var_11_0 == var_0_6.GAME_STATE.NOT_OPEN then
		return g.core.lang:get(430914)
	end
end

function PubgData:getCurStageFinishTime()
	local var_12_0 = self:getCurStage()

	if var_12_0 == var_0_6.GAME_STATE.REGULAR then
		return self._regularEndTime
	elseif var_12_0 == var_0_6.GAME_STATE.FINAL then
		return self._finalEndTime
	elseif var_12_0 == var_0_6.GAME_STATE.SHOW then
		return self._showEndTime
	elseif var_12_0 == var_0_6.GAME_STATE.NOT_OPEN then
		return 0
	end
end

function PubgData:isOpenDaysAvailable()
	return g.core.common.ServerTime:getOpenDays() >= self._openServerDays
end

function PubgData:isActivityOpen()
	if not self:isOpenDaysAvailable() then
		return false
	end

	return self:getCurStage() ~= var_0_6.GAME_STATE.NOT_OPEN
end

function PubgData:getTimeData()
	return self._startTime, self._finalEndTime, self._showEndTime
end

function PubgData:getActivityExpireTime()
	return self._showEndTime
end

function PubgData:getStageStartEndTime(arg_17_1)
	local var_17_0 = 0
	local var_17_1 = 0

	if arg_17_1 == var_0_6.GAME_STATE.REGULAR then
		var_17_0 = self._startTime
		var_17_1 = self._regularEndTime
	elseif arg_17_1 == var_0_6.GAME_STATE.FINAL then
		var_17_0 = self._regularEndTime
		var_17_1 = self._finalEndTime
	elseif arg_17_1 == var_0_6.GAME_STATE.SHOW then
		var_17_0 = self._finalEndTime
		var_17_1 = self._showEndTime
	end

	return var_17_0, var_17_1
end

function PubgData:getCurMatchState()
	return self._curMatchState
end

function PubgData:getCurMatchNum()
	return self._curMatchNum
end

function PubgData:getAttackTimes()
	return (g.core.model.User.shopData:getLeftCount(var_0_6.LEFT_TIME_TYPE))
end

function PubgData:_initRankRewardInfo()
	self._rankRewardList = require("app.core.common.RankAward"):getRankAwardArray(var_0_6.RANK_REWARD_TYPE, self._subId)
end

function PubgData:getRankRewardList()
	if #self._rankRewardList == 0 then
		self:_initRankRewardInfo()
	end

	return self._rankRewardList
end

function PubgData:getRankPlayerListByRankType(arg_23_1)
	return self._rankPlayerList[arg_23_1] or {}
end

function PubgData:getGamePlayerList()
	local var_24_0 = {}

	for iter_24_0, iter_24_1 in pairs((self:getMapData():getAllUser())) do
		table.insert(var_24_0, iter_24_1)
	end

	table.sort(var_24_0, function(arg_25_0, arg_25_1)
		if arg_25_0:getScore() ~= arg_25_1:getScore() then
			return arg_25_0:getScore() > arg_25_1:getScore()
		end

		if arg_25_0:getFightValue() ~= arg_25_1:getFightValue() then
			return arg_25_0:getFightValue() > arg_25_1:getFightValue()
		end

		if arg_25_0:getUid() ~= arg_25_1:getUid() then
			return arg_25_0:getUid() < arg_25_1:getUid()
		end

		return false
	end)

	for iter_24_2, iter_24_3 in pairs(var_24_0) do
		if iter_24_3:isMe() then
			self._gameRank = iter_24_2
			self._gameScore = iter_24_3:getScore()

			break
		end
	end

	return var_24_0
end

function PubgData:getGameRecordList()
	return self:getMapData():getTextNoticeList()
end

function PubgData:getGameServerList()
	return self._gameServerList
end

function PubgData:getRandomServerName()
	local var_28_0 = g.core.platform.ServerListProxy:getSelectedServer()
	local var_28_1

	if var_28_0 then
		var_28_1 = var_28_0.name or ""

		if #self._gameServerList <= 0 then
			return var_28_1
		end
	end

	local var_28_2 = g.core.platform.ServerListProxy:getServerById(self._gameServerList[math.floor(math.random(1, #self._gameServerList))].sid)

	var_28_2 = var_28_2 or {
		name = var_28_1
	}

	return var_28_2.name
end

function PubgData:getMyGameRankAndScore()
	if self._gameRank <= 0 then
		self:getGamePlayerList()
	end

	return self._gameRank, self._gameScore
end

function PubgData:getMyTotalRankAndScore()
	return self._totalRank, self._totalScore
end

function PubgData:getDailyMaxScore()
	return self._dailyMaxScore
end

function PubgData:getDailyMaxRank()
	return self._dailyMaxRank
end

function PubgData:onS2CPubgTaskInfo(arg_33_1)
	if arg_33_1.tasks then
		self._taskData:updateTaskData(arg_33_1.tasks)
	end
end

function PubgData:getTaskData()
	return self._taskData
end

function PubgData:onS2CTaskAward(arg_35_1)
	self._taskData:onTaskAward(arg_35_1.task_id)
end

function PubgData:getMapData()
	self._mapData = self._mapData or PubgMapData.new()

	return self._mapData
end

function PubgData:getParams(arg_37_1)
	return var_0_0.get(arg_37_1).parameter
end

function PubgData:isHaveTime()
	local var_38_0 = self:getCurStage()

	if var_38_0 == var_0_6.GAME_STATE.REGULAR or var_38_0 == var_0_6.GAME_STATE.FINAL then
		return self:getAttackTimes() > 0
	end

	return false
end

function PubgData:isHaveTaskReward()
	local var_39_0 = self:getCurStage()

	if var_39_0 == var_0_6.GAME_STATE.REGULAR or var_39_0 == var_0_6.GAME_STATE.FINAL then
		return self._taskData:isCanRewardTask()
	end

	return false
end

return PubgData
