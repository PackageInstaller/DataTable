-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/accumulatelottery/model/AccumulateLotteryModel.lua

module("logic.extensions.accumulatelottery.controller.AccumulateLotteryModel", package.seeall)

local AccumulateLotteryModel = class("AccumulateLotteryModel", BaseModel)

function AccumulateLotteryModel:onReset()
	self._activityId = 0
	self._activityInfo = nil

	self:resetLotteryResult()
end

function AccumulateLotteryModel:onInit()
	self:onReset()
end

function AccumulateLotteryModel:setActivityId(activityId)
	self._activityId = activityId
end

function AccumulateLotteryModel:getActivityId()
	return self._activityId
end

function AccumulateLotteryModel:setActivityInfo(info)
	self._activityInfo = {}
	self._activityInfo.curStorey = info.curStorey
	self._activityInfo.curTimes = info.curTimes
	self._activityInfo.preMoney = info.preMoney
	self._activityInfo.money = info.money
	self._activityInfo.gainPrizeIds = {}

	for i = 1, #info.gainPrizeIds do
		self._activityInfo.gainPrizeIds[info.gainPrizeIds[i]] = true
	end
end

function AccumulateLotteryModel:getPreMoney()
	if self._activityInfo then
		return self._activityInfo.preMoney
	end

	return 0
end

function AccumulateLotteryModel:getMoney()
	if self._activityInfo then
		return self._activityInfo.money
	end

	return 0
end

function AccumulateLotteryModel:addPayMoney(money)
	if self._activityInfo and self._activityInfo.money then
		self._activityInfo.money = self._activityInfo.money + money
	end
end

function AccumulateLotteryModel:getActivityInfo()
	return self._activityInfo
end

function AccumulateLotteryModel:getCurStorey()
	if self._activityInfo then
		return self._activityInfo.curStorey
	end

	return 0
end

function AccumulateLotteryModel:getCurLotteryTimes()
	if self._activityInfo then
		return self._activityInfo.curTimes
	end

	return 0
end

function AccumulateLotteryModel:hasGainPrize(id)
	if self._activityInfo and self._activityInfo.gainPrizeIds then
		return self._activityInfo.gainPrizeIds[id] == true
	end

	return false
end

function AccumulateLotteryModel:hasLottery()
	if self._activityInfo and self._activityInfo.gainPrizeIds then
		for k, v in pairs(self._activityInfo.gainPrizeIds) do
			if v == true then
				return true
			end
		end
	end

	return false
end

function AccumulateLotteryModel:setLotteryResult(msg)
	self._drawPrizeId = msg.prizeId
	self._drawChangesetid = msg.changeSetId
	self._activityInfo.curTimes = self._activityInfo.curTimes + 1
	self._activityInfo.gainPrizeIds = self._activityInfo.gainPrizeIds or {}
	self._activityInfo.gainPrizeIds[self._drawPrizeId] = true

	local activitiesStoreyData = AccumulateLotteryConfig.instance:getActivitiesStorey(self:getActivityId())

	if not activitiesStoreyData then
		return
	end

	local hasGainedAll = true
	local curStorey = self:getCurStorey()
	local datas = activitiesStoreyData[curStorey]

	for i = 1, #datas do
		if not self:hasGainPrize(datas[i].rewardId) then
			hasGainedAll = false

			break
		end
	end

	if hasGainedAll then
		self._activityInfo.curStorey = self._activityInfo.curStorey + 1
	end
end

function AccumulateLotteryModel:getLotteryResult()
	return self._drawPrizeId, self._drawChangesetid
end

function AccumulateLotteryModel:resetLotteryResult()
	self._drawPrizeId = nil
	self._drawChangesetid = nil
end

AccumulateLotteryModel.instance = AccumulateLotteryModel.New()

return AccumulateLotteryModel
