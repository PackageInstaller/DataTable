-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/anmoyangame/controller/AnMoYanController.lua

module("logic.extensions.anmoyangame.controller.AnMoYanController", package.seeall)

local AnMoYanController = class("AnMoYanController", BaseController)

function AnMoYanController:ctor()
	return
end

function AnMoYanController:onInit()
	self:onReset()
end

function AnMoYanController:onReset()
	return
end

function AnMoYanController:_endGameHandle(activityId, gameScore)
	self:sendPM_DarkMoYanGameEndGameReq(activityId, gameScore)
end

function AnMoYanController:getActivityType()
	return 458
end

function AnMoYanController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(self:getActivityType())
end

function AnMoYanController:sendPM_DarkMoYanGameInfoReq(activityId)
	AnMoYanAgent.instance:sendPM_DarkMoYanGameInfoReq(activityId)
end

function AnMoYanController:handlePM_DarkMoYanGameInfoRes(msg)
	AnMoYanModel.instance:handlePM_DarkMoYanGameInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_DarkMoYanGameInfoRes)
end

function AnMoYanController:sendPM_DarkMoYanGameStartGameReq(activityId)
	local clientKey = AnMoYanModel.instance:getClientKey(activityId)

	AnMoYanAgent.instance:sendPM_DarkMoYanGameStartGameReq(activityId, clientKey)
end

function AnMoYanController:handlePM_DarkMoYanGameStartGameRes(msg)
	AnMoYanModel.instance:handlePM_DarkMoYanGameStartGameRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_DarkMoYanGameStartGameRes)
end

function AnMoYanController:sendPM_DarkMoYanGameEndGameReq(activityId, score)
	local encryptedKey = AnMoYanModel.instance:getEncryptedKey(activityId, score)

	AnMoYanAgent.instance:sendPM_DarkMoYanGameEndGameReq(activityId, score, encryptedKey)
end

function AnMoYanController:handlePM_DarkMoYanGameEndGameRes(msg)
	AnMoYanModel.instance:handlePM_DarkMoYanGameEndGameRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_DarkMoYanGameEndGameRes)
end

function AnMoYanController:sendPM_DarkMoYanGameSweepReq(activityId, times)
	AnMoYanAgent.instance:sendPM_DarkMoYanGameSweepReq(activityId, times)
end

function AnMoYanController:handlePM_DarkMoYanGameSweepRes(msg)
	AnMoYanModel.instance:handlePM_DarkMoYanGameSweepRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_DarkMoYanGameSweepRes)
end

function AnMoYanController:sendPM_DarkMoYanGameGainProgressPrizeReq(activityId, prizeId)
	AnMoYanAgent.instance:sendPM_DarkMoYanGameGainProgressPrizeReq(activityId, prizeId)
end

function AnMoYanController:handlePM_DarkMoYanGameGainProgressPrizeRes(msg)
	AnMoYanModel.instance:handlePM_DarkMoYanGameGainProgressPrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_DarkMoYanGameGainProgressPrizeRes)
end

AnMoYanController.instance = AnMoYanController.New()

return AnMoYanController
