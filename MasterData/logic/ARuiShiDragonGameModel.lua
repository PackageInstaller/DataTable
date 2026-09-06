-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aruishidragongame/model/ARuiShiDragonGameModel.lua

module("logic.extensions.aruishidragongame.model.ARuiShiDragonGameModel", package.seeall)

local ARuiShiDragonGameModel = class("ARuiShiDragonGameModel", BaseModel)

function ARuiShiDragonGameModel:onInit()
	self:onReset()
end

function ARuiShiDragonGameModel:onReset()
	self._agentDic = {}
end

function ARuiShiDragonGameModel:getAgentInfo(activityId)
	if not self._agentDic[activityId] then
		self._agentDic[activityId] = {}

		self:_initAgent(self._agentDic[activityId])
	end

	return self._agentDic[activityId]
end

function ARuiShiDragonGameModel:_initAgent(info)
	info.activityId = 0
	info.todayTimes = 0
	info.gainedPrizeIds = {}
	info.score = 0
	info.serverKey = 0
	info.encryptedKey = 0
	info.isPass = false
	info.num = 0

	self:_resetGameInfo(info)
end

function ARuiShiDragonGameModel:_resetGameInfo(info)
	info.gameInfo = {
		itemCount = 0,
		gameTimes = 0,
		unlockBlockIds = {}
	}
end

function ARuiShiDragonGameModel:onInfoRes(msg)
	local info = self:getAgentInfo(msg.activityId)

	info.todayTimes = msg.todayTimes
	info.gainedPrizeIds = GameUtil.pbToTable(msg.gainedPrizeIds) or {}
	info.score = msg.score
end

function ARuiShiDragonGameModel:onStartRes(msg, activityId)
	local info = self:getAgentInfo(activityId)

	info.serverKey = msg.serverKey
end

function ARuiShiDragonGameModel:onEndRes(msg, isPass, num, encryptedKey)
	local info = self:getAgentInfo(msg.activityId)

	info.isPass = isPass
	info.num = num
	info.encryptedKey = encryptedKey
	info.score = info.score + info.num
end

function ARuiShiDragonGameModel:onGainPrizeRes(msg)
	local info = self:getAgentInfo(msg.activityId)

	if not TableUtil.isHad(info.gainedPrizeIds, msg.prizeId) then
		table.insert(info.gainedPrizeIds, msg.prizeId)
	end
end

function ARuiShiDragonGameModel:getActivityId()
	return 366001
end

function ARuiShiDragonGameModel:getTodayTimes(activityId)
	local info = self:getAgentInfo(activityId)

	return info.todayTimes
end

function ARuiShiDragonGameModel:getRewardProgress(activityId)
	local info = self:getAgentInfo(activityId)

	return info.score
end

function ARuiShiDragonGameModel:isPlayerRewardGeted(activityId, prizeId)
	local info = self:getAgentInfo(activityId)

	return TableUtil.isHad(info.gainedPrizeIds, prizeId)
end

function ARuiShiDragonGameModel:isPlayerRewardCanGet(activityId, prizeId, progress)
	local isScoreEnough = progress <= self:getRewardProgress(activityId)

	return isScoreEnough and not self:isPlayerRewardGeted(activityId, prizeId)
end

function ARuiShiDragonGameModel:initGameInfo(activityId)
	local info = self:getAgentInfo(activityId)

	self:_resetGameInfo(info)
end

function ARuiShiDragonGameModel:getGameInfo(activityId)
	local info = self:getAgentInfo(activityId)

	return info.gameInfo
end

function ARuiShiDragonGameModel:getServerKey(activityId)
	local info = self:getAgentInfo(activityId)

	return info.serverKey
end

ARuiShiDragonGameModel.instance = ARuiShiDragonGameModel.New()

return ARuiShiDragonGameModel
