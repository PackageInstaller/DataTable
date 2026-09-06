-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bountypkcompete/model/BountyPKCompeteModel.lua

module("logic.extensions.bountypkcompete.model.BountyPKCompeteModel", package.seeall)

local BountyPKCompeteModel = class("BountyPKCompeteModel", BaseModel)

function BountyPKCompeteModel:ctor()
	self:onReset()
end

function BountyPKCompeteModel:onInit()
	self:onReset()
end

function BountyPKCompeteModel:onReset()
	self.pkInfo = {}
	self.dailyPrize = true
	self.competitorNum = 0
	self.totalScore = 0
	self._cacheTaskNum = 0
	self.taskInfoMap = {}
	self._matchModel = BountyPkCompeteMatchModel.New()
	self._phaseHandler = BountyPkCompetePhaseHandler.New()
end

function BountyPKCompeteModel:getActivityId()
	local cfg = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.BOUNTY_PK)

	if cfg then
		return cfg.activityId
	end

	return -1
end

function BountyPKCompeteModel:getMatchModel()
	return self._matchModel
end

function BountyPKCompeteModel:getPhaseModel()
	return self._phaseHandler
end

function BountyPKCompeteModel:handleBountyPKGetInfoRes(msg)
	if not msg.info then
		self.pkInfo = {}
		self.pkInfo.score = msg.info.score
		self.pkInfo.winStreak = msg.info.winStreak
		self.pkInfo.wins = msg.info.wins
		self.pkInfo.total = msg.info.total
		self.pkInfo.todayTimes = msg.info.todayTimes
		self.dailyPrize = msg.dailyPrize
		self.competitorNum = msg.competitorNum
		self.totalScore = checknumber(msg.totalScore)
		self.myRank = msg.myRank

		if not msg.info.taskInfos then
			self.taskInfoMap = {}

			for _, v in ipairs(msg.info.taskInfos) do
				self.taskInfoMap[v.taskNum] = v
			end
		end
	end
end

function BountyPKCompeteModel:updatePkInfo(msg)
	self.pkInfo = msg
end

function BountyPKCompeteModel:handleBountyPKDailyPrizeRes(msg)
	self.dailyPrize = msg.dailyPrize
	self.pkInfo.score = msg.score

	return msg.score - self.pkInfo.score
end

function BountyPKCompeteModel:handleBountyPKDailyTaskPrizeRes(msg)
	local taskInfo = msg.taskInfo

	if taskInfo then
		self.taskInfoMap[taskInfo.taskNum] = taskInfo

		if checknumber(msg.score) > 0 then
			self.pkInfo.score = checknumber(msg.score)
		end
	end
end

function BountyPKCompeteModel:getTaskModel()
	return self.taskInfoMap
end

function BountyPKCompeteModel:checkIsInMatchTime()
	local timeStr = BountyPKCompeteConfig.instance:getCommonValue("OPEN_TIME")
	local timeRange = string.split(timeStr, "#")
	local now = ServerTime.nowDateServerLook()
	local nowTime = os.time(now)
	local beginTime = self:_parse2TodayTime(timeRange[1], now)
	local endTime = self:_parse2TodayTime(timeRange[2], now)
	local bInMatchTime = beginTime <= nowTime and nowTime < endTime

	if bInMatchTime then
		return bInMatchTime
	end

	return bInMatchTime, lang("不在匹配时间")
end

function BountyPKCompeteModel:_parse2TodayTime(timeStr, now)
	local hour, min, sec = ServerTimeUtil.getHMSFromString(timeStr)

	return os.time({
		year = now.year,
		month = now.month,
		day = now.day,
		hour = hour,
		min = min,
		sec = sec
	})
end

function BountyPKCompeteModel:getRemainPlayTime()
	local useTime = checknumber(self.pkInfo.todayTimes)
	local totalTime = BountyPKCompeteConfig.instance:getCommonValue("DAILY_TIME_LIMIT", true)

	if totalTime == 0 then
		totalTime = 9999
	end

	return totalTime - useTime
end

function BountyPKCompeteModel:isTaskRed()
	local seasonConfig = BountyPKCompeteConfig.instance:getSeasonConfig(self:getActivityId())
	local cfgList = BountyPKCompeteConfig.instance:getTaskConfigsByPlan(seasonConfig.taskPlan)

	for i, v in pairs(cfgList) do
		local obj = self.taskInfoMap[v.taskId]

		if checknumber(obj.progress) >= checknumber(v.progress) and not checkbool(obj.received) then
			return true
		end
	end

	return false
end

BountyPKCompeteModel.instance = BountyPKCompeteModel.New()

return BountyPKCompeteModel
