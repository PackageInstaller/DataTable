-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/controller/AthenaController.lua

module("logic.extensions.timelimitedchallenge.controller.AthenaController", package.seeall)

local AthenaController = class("AthenaController", BaseController)

AthenaController.PM_WaterLightHeroTowerInfo = "sendPM_WaterLightHeroTowerInfoReq"
AthenaController.PM_WaterLightHeroTowerGainPrize = "sendPM_WaterLightHeroTowerGainPrizeReq"
AthenaController.PM_WaterLightHeroTowerBuyTimes = "sendPM_WaterLightHeroTowerBuyTimesReq"
AthenaController.PM_WaterLightHeroTowerGainBuff = "sendPM_WaterLightHeroTowerGainBuffReq"
AthenaController.PM_WaterLightHeroTowerOnKeyPassWisdom = "sendPM_WaterLightHeroTowerOnKeyPassWisdomReq"
AthenaController.PM_WaterLightHeroTowerOnKeyPassWisdomStage = "sendPM_WaterLightHeroTowerOnKeyPassWisdomStageReq"

function AthenaController:onInit()
	AthenaController.super.onInit(self)

	self._sendParam = {}
	self._prizeDic = {}
end

function AthenaController:onReset()
	AthenaController.super.onReset(self)

	self._sendParam = {}
	self._prizeDic = {}
end

function AthenaController:sendMsg(method, ...)
	self._sendParam[method] = {
		...
	}

	WaterLightHeroTowerAgent[method](WaterLightHeroTowerAgent.instance, ...)
end

function AthenaController:handlePM_WaterLightHeroTowerInfoRes(msg)
	AthenaModel.instance:setChallenge(msg.challengeId)
	AthenaModel.instance:setPowerTowerStageId(msg.challengeId, msg.powerTowerStageId)
	AthenaModel.instance:setWisdomTowerStageId(msg.challengeId, msg.wisdomTowerStageId)
	AthenaModel.instance:setPowerTowerDailyTimes(msg.challengeId, msg.powerTowerDailyTimes)
	AthenaModel.instance:setPowerTowerBuyTimes(msg.challengeId, msg.powerTowerBuyTimes)
	AthenaModel.instance:setScore(msg.challengeId, msg.score)
	AthenaModel.instance:setGainedPrize(msg.challengeId, msg.gainedPrize)
	AthenaModel.instance:setCurBuffLevel(msg.challengeId, msg.curBuffLevel)
	AthenaModel.instance:setHadGotBuff(msg.challengeId, msg.hadGotBuff)
	GlobalDispatcher:dispatch(AthenaController.PM_WaterLightHeroTowerInfo, msg)
end

function AthenaController:handlePM_WaterLightHeroTowerBuyTimesRes(msg)
	AthenaModel.instance:setPowerTowerBuyTimes(msg.challengeId, AthenaModel.instance:getPowerTowerBuyTimes(msg.challengeId) + 1)
	GlobalDispatcher:dispatch(AthenaController.PM_WaterLightHeroTowerBuyTimes, msg)
end

function AthenaController:sendPM_WaterLightHeroTowerGainPrizeReq(challengeId, prizeId)
	self._prizeDic[challengeId] = prizeId

	WaterLightHeroTowerAgent.instance:sendPM_WaterLightHeroTowerGainPrizeReq(challengeId, prizeId)
end

function AthenaController:handlePM_WaterLightHeroTowerGainPrizeRes(msg)
	if self._prizeDic[msg.challengeId] then
		local prizeId = self._prizeDic[msg.challengeId]

		GlobalDispatcher:dispatch(AthenaController.PM_WaterLightHeroTowerGainPrize, prizeId)

		self._prizeDic[msg.challengeId] = nil
	end
end

function AthenaController:handlePM_WaterLightHeroTowerGainBuffRes(msg)
	AthenaModel.instance:setCurBuffLevel(msg.challengeId, msg.curBuffLevel)
	AthenaModel.instance:setHadGotBuff(msg.challengeId, true)
	GlobalDispatcher:dispatch(AthenaController.PM_WaterLightHeroTowerGainBuff, msg)
end

function AthenaController:handlePM_WaterLightHeroTowerOnKeyPassWisdomRes(msg)
	AthenaModel.instance:setScore(msg.challengeId, msg.curScore)

	local cfg = WaterLightHeroTowerConfig.instance:getWisdomById(msg.challengeId)

	AthenaModel.instance:setWisdomTowerStageId(msg.challengeId, #cfg)
	GlobalDispatcher:dispatch(AthenaController.PM_WaterLightHeroTowerOnKeyPassWisdom, msg)
end

function AthenaController:handlePM_WaterLightHeroTowerOnKeyPassWisdomStageRes(msg)
	AthenaModel.instance:setScore(msg.challengeId, msg.curScore)
	AthenaModel.instance:setWisdomTowerStageId(msg.challengeId, AthenaModel.instance:getWisdomTowerStageId(msg.challengeId) + 1)
	GlobalDispatcher:dispatch(AthenaController.PM_WaterLightHeroTowerOnKeyPassWisdomStage, msg)
end

AthenaController.instance = AthenaController.New()

return AthenaController
