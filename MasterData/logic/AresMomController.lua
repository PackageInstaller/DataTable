-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aresmom/controller/AresMomController.lua

module("logic.extensions.aresmom.controller.AresMomController", package.seeall)

local AresMomController = class("AresMomController", BaseController)

function AresMomController:onReset()
	return
end

function AresMomController:getInfo(challengeId)
	AresMomAgent.instance:sendPM_AresMom_GetInfoReq(challengeId)
end

function AresMomController:handleGetInfo(msg)
	AresMomModel.instance:onGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.AresMomUpdateInfo)
end

function AresMomController:startFight(challengeId, type, stageId, mo)
	local simpleForm = mo:createFormPb()

	AresMomAgent.instance:sendPM_AresMom_FightReq(challengeId, type, stageId, simpleForm)
end

function AresMomController:handleNotifyFight(msg)
	AresMomModel.instance:onNotifyFight(msg)
	GlobalDispatcher:dispatch(GlobalNotify.AresMomUpdateInfo)
end

function AresMomController:gainPrize(challengeId, type, prizeId)
	AresMomAgent.instance:sendPM_AresMom_GainPrizeReq(challengeId, type, prizeId)
end

function AresMomController:handleGainPrize(msg)
	AresMomModel.instance:onGainPrize(msg)
	GlobalDispatcher:dispatch(GlobalNotify.AresMomGainPrize)
end

function AresMomController:unlock(challengeId, type, blockId)
	AresMomAgent.instance:sendPM_AresMom_UnlockReq(challengeId, type, blockId)
end

function AresMomController:handleUnlock(msg)
	AresMomModel.instance:onUnlock(msg)
	GlobalDispatcher:dispatch(GlobalNotify.AresMomUnlock)
end

function AresMomController:buyTimes(challengeId, type)
	AresMomAgent.instance:sendPM_AresMom_BuyTimesReq(challengeId, type)
end

function AresMomController:handleBuyTimes(msg)
	AresMomModel.instance:onBuyTimes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.AresMomBuyTimes)
end

function AresMomController:isInTime(challengeId)
	return TLChallengeController.instance:isInOpenTime(challengeId)
end

AresMomController.instance = AresMomController.New()

return AresMomController
