-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/anniversarymarket/model/AnniversaryMarketModel.lua

module("logic.extensions.anniversarymarket.model.AnniversaryMarketModel", package.seeall)

local AnniversaryMarketModel = class("AnniversaryMarketModel", BaseModel)

AnniversaryMarketModel.BIG_CELL_NUM = 2
AnniversaryMarketModel.MID_CELL_NUM = 2

function AnniversaryMarketModel:ctor()
	return
end

function AnniversaryMarketModel:onInit()
	self:onReset()
end

function AnniversaryMarketModel:onReset()
	self._info = {}
end

function AnniversaryMarketModel:getInfo(activityId)
	return self._info[activityId]
end

function AnniversaryMarketModel:handlePM_AnniversaryMarketGetInfoRes(msg)
	self._info[msg.activityId] = self._info[msg.activityId] or {}
	self._info[msg.activityId].otherSellCount = msg.otherSellCount
	self._info[msg.activityId].todayPrice = msg.todayPrice
	self._info[msg.activityId].totalRefreshTimes = msg.totalRefreshTimes
	self._info[msg.activityId].prizePools = msg.prizePools
end

function AnniversaryMarketModel:handlePM_AnniversaryMarketGetMyShareCodeRes(msg)
	local info = self:getInfo(msg.activityId)

	if info then
		info.shareCode = msg.shareCode
		info.otherSellCount = msg.otherSellCount
	end
end

function AnniversaryMarketModel:handlePM_AnniversaryMarketRefreshPrizePoolRes(msg)
	local info = self:getInfo(msg.activityId)

	info.prizePoolId = msg.prizePoolId
	info.newPrizeId = msg.newPrizeId
	info.totalRefreshTimes = msg.totalRefreshTimes
end

function AnniversaryMarketModel:handlePM_AnniversaryMarketConfirmRefreshRes(msg)
	local info = self:getInfo(msg.activityId)

	info.prizePools[msg.poolInfo.prizePoolId] = msg.poolInfo
end

function AnniversaryMarketModel:handlePM_AnniversaryMarketGainPrizePoolRes(msg)
	local info = self:getInfo(msg.activityId)
	local prizePool = info.prizePools[msg.prizePoolId]

	if prizePool then
		prizePool.hasGainPrize = true
	end
end

AnniversaryMarketModel.instance = AnniversaryMarketModel.New()

return AnniversaryMarketModel
