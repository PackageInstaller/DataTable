-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/burygame/controller/BuryGameController.lua

module("logic.extensions.burygame.controller.BuryGameController", package.seeall)

local BuryGameController = class("BuryGameController", BaseController)

function BuryGameController:onInit()
	return
end

function BuryGameController:onReset()
	return
end

function BuryGameController:sendGetInfoReq()
	local activityId = BuryGameModel.instance:getActivityId()

	BuryPitGameAgent.instance:sendPM_BuryPitGameGetInfoReq(activityId, self._onGetInfoRes, self)
end

function BuryGameController:_onGetInfoRes(msg)
	BuryGameModel.instance:setInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.BuryGetInfoRes)
end

function BuryGameController:sendStartGameReq()
	local activityId = BuryGameModel.instance:getActivityId()
	local clientKey = BuryGameModel.instance:randomClientKey()

	BuryPitGameAgent.instance:sendPM_BuryPitGameStartGameReq(activityId, clientKey, self._onStartGameRes, self)
end

function BuryGameController:_onStartGameRes(msg)
	BuryGameModel.instance:setGameStartInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.BuryStartGameRes)
end

function BuryGameController:sendEndGameReq(score, specialPrizeCount)
	local encryptedKey = BuryGameModel.instance:getEncryptedKey(score, specialPrizeCount)

	print("encryptedKey = " .. encryptedKey)
	BuryPitGameAgent.instance:sendPM_BuryPitGameEndGameReq(score, specialPrizeCount, encryptedKey, self._onEndGameRes, self)
end

function BuryGameController:_onEndGameRes(msg)
	BuryGameModel.instance:setTotalScore(msg.newTotalScore)
	GlobalDispatcher:dispatch(GlobalNotify.BuryEndGameRes)
end

function BuryGameController:sendBuyTimesReq()
	local activityId = BuryGameModel.instance:getActivityId()

	BuryPitGameAgent.instance:sendPM_BuryPitGameBuyGameTimesReq(activityId, self._onBuyTimesRes, self)
end

function BuryGameController:_onBuyTimesRes(msg)
	BuryGameModel.instance:subTodayGameBuyTimes()
	GlobalDispatcher:dispatch(GlobalNotify.BuryBuyTimesRes)
end

function BuryGameController:sendGainPrizeReq(prizeId)
	local activityId = BuryGameModel.instance:getActivityId()

	BuryPitGameAgent.instance:sendPM_BuryPitGameGainScorePrizeReq(activityId, prizeId, function(msg)
		BuryGameModel.instance:setGainedById(prizeId)
		self:_onGainPrizeRes(msg)
	end)
end

function BuryGameController:_onGainPrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.BuryGainPrizeRes)
end

function BuryGameController:sendGetRankInfoReq()
	local activityId = BuryGameModel.instance:getActivityId()

	BuryPitGameAgent.instance:sendPM_BuryPitGameGetRankInfoReq(activityId, 1, 100, self._onGetRankInfoRes, self)
end

function BuryGameController:_onGetRankInfoRes(msg)
	BuryGameModel.instance:setRankInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.BuryRankInfoRes)
end

BuryGameController.instance = BuryGameController.New()

return BuryGameController
