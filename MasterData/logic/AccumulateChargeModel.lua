-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/accumulatecharge/model/AccumulateChargeModel.lua

module("logic.extensions.accumulatecharge.model.AccumulateChargeModel", package.seeall)

local AccumulateChargeModel = class("AccumulateChargeModel", BaseModel)

function AccumulateChargeModel:ctor()
	return
end

function AccumulateChargeModel:onInit()
	self:onReset()
end

function AccumulateChargeModel:onReset()
	self._activityId = 0
	self._money = 0
	self._gainPrizeIds = {}
	self._exchangeCodeList = {}
	self._rankInfoList = {}
	self._myRank = -1
end

function AccumulateChargeModel:onCampaignConsumeGetInfoRes(msg)
	printInfo("test AccumulateChargeModel成功获取信息")

	self._money = msg.money / 100
	self._gainPrizeIds = GameUtil.pbToTable(msg.gainPrizeIds) or {}
	self._exchangeCodeList = GameUtil.pbToTable(msg.exchangeCodes) or {}
end

function AccumulateChargeModel:onCampaignConsumeGainPrizeRes(msg)
	if msg:HasField("exchangeCode") then
		local element = GameUtil.pbToTable(msg.exchangeCode) or {}

		printInfo("test onCampaignConsumeGainPrizeRes", element.id, element.exchangeCode)
		table.insert(self._exchangeCodeList, element)
	end
end

function AccumulateChargeModel:onCampaignConsumeOneKeyGainPrizeRes(msg)
	local actCfg = AccumulategiftConfig.instance:getCampaignConsumeCfg(self._activityId)
	local planId = AccumulategiftConfig.instance:GetActivityPlanID(self._activityId)
	local prizeCfgs = AccumulategiftConfig.instance:GetConsumeGiftCfg(planId)

	self._gainPrizeIds = {}

	for _, v in ipairs(prizeCfgs) do
		if v.consumeMoney > self._money then
			-- block empty
		else
			self:addPrizeId(v.id)
		end
	end
end

function AccumulateChargeModel:addPrizeId(prizeId)
	if prizeId and prizeId > 0 and not TableUtil.isHad(self._gainPrizeIds, prizeId) then
		printInfo("test AccumulateChargeModel添加已领取奖励 id = ", prizeId)
		table.insert(self._gainPrizeIds, prizeId)
	else
		printInfo("test AccumulateChargeModel添加已领取奖励失败 id = ", prizeId)
	end
end

function AccumulateChargeModel:getMoney()
	return self._money
end

function AccumulateChargeModel:isGetedReward(prizeId)
	return TableUtil.isHad(self._gainPrizeIds, prizeId)
end

function AccumulateChargeModel:getExchangeCode(prizeId)
	for i, v in ipairs(self._exchangeCodeList) do
		if v.id == prizeId then
			return v.exchangeCode
		end
	end

	return nil
end

function AccumulateChargeModel:resetRankInfoList()
	self._rankInfoList = {}
	self._myRank = -1
end

function AccumulateChargeModel:onGetRankInfo(msg)
	self._rankInfos = msg.infos
	self._myRank = msg.myRank
end

function AccumulateChargeModel:getRankInfo()
	return self._rankInfos, self._myRank
end

function AccumulateChargeModel:setActId(actId)
	self._activityId = actId
end

AccumulateChargeModel.instance = AccumulateChargeModel.New()

return AccumulateChargeModel
