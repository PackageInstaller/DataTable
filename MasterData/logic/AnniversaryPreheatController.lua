-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/anniversarypreheat/controller/AnniversaryPreheatController.lua

module("logic.extensions.anniversarypreheat.controller.AnniversaryPreheatController", package.seeall)

local AnniversaryPreheatController = class("AnniversaryPreheatController", BaseController)

function AnniversaryPreheatController:getInfo()
	AnniversaryPreheatAgent.instance:sendPM_AnniversaryPreheatInfoReq()
end

function AnniversaryPreheatController:handleGetInfo(msg)
	AnniversaryPreheatModel.instance:onGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.AnniversaryPreheatGetInfo)
end

function AnniversaryPreheatController:gainProgressPrize(id)
	AnniversaryPreheatAgent.instance:sendPM_AnniversaryPreheatGainProgressPrizeReq(id)
	AnniversaryPreheatModel.instance:onGainProgressPrize(id)
end

function AnniversaryPreheatController:handleGainProgressPrize(msg)
	GlobalDispatcher:dispatch(GlobalNotify.AnniversaryPreheatGetInfo)
end

function AnniversaryPreheatController:gainSharePrize()
	AnniversaryPreheatAgent.instance:sendPM_AnniversaryPreheatGainSharePrizeReq()
end

function AnniversaryPreheatController:handleGainSharePrize(msg)
	AnniversaryPreheatModel.instance:onGainSharePrize(msg)
	GlobalDispatcher:dispatch(GlobalNotify.AnniversaryPreheatGetInfo)
end

function AnniversaryPreheatController:sendSucShare()
	AnniversaryPreheatAgent.instance:sendPM_AnniversaryPreheatSuccessShareReq()
end

function AnniversaryPreheatController:handldSucShare()
	AnniversaryPreheatModel.instance:onSucShare(msg)
	GlobalDispatcher:dispatch(GlobalNotify.AnniversaryPreheatGetInfo)
end

function AnniversaryPreheatController:getDanMuInfos()
	AnniversaryPreheatAgent.instance:sendPM_AnniversaryPreheatDanMuReq()
end

function AnniversaryPreheatController:handleGetDanMuInfos(msg)
	AnniversaryPreheatModel.instance:onGetDanMuInfos(msg)
	GlobalDispatcher:dispatch(GlobalNotify.AnniversaryPreheatDanMuInfoUpdate)
end

function AnniversaryPreheatController:switchDanMuState(isClose)
	AnniversaryPreheatAgent.instance:sendPM_AnniversaryPreheatDanmuSwitchReq(isClose)
	AnniversaryPreheatModel.instance:switchDanMuState(isClose)
end

function AnniversaryPreheatController:handleSwitchDanMuState()
	return
end

function AnniversaryPreheatController:sendDanMu(danMuId)
	AnniversaryPreheatAgent.instance:sendPM_AnniversaryPreheatSendDanmuReq(danMuId)
	AnniversaryPreheatModel.instance:addSendDanMu(danMuId)
end

function AnniversaryPreheatController:handleSendDanMu(msg)
	AnniversaryPreheatModel.instance:onSendDanMu(msg)
	GlobalDispatcher:dispatch(GlobalNotify.AnniversaryPreheatGetInfo)
	GlobalDispatcher:dispatch(GlobalNotify.AnniversaryPreheatDanMuInfoUpdate)
end

AnniversaryPreheatController.instance = AnniversaryPreheatController.New()

return AnniversaryPreheatController
