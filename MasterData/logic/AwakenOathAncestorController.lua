-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/awakenoathancestor/controller/AwakenOathAncestorController.lua

module("logic.extensions.awakenoathancestor.controller.AwakenOathAncestorController", package.seeall)

local AwakenOathAncestorController = class("AwakenOathAncestorController", BaseController)

function AwakenOathAncestorController:onInit()
	return
end

function AwakenOathAncestorController:onReset()
	return
end

function AwakenOathAncestorController:sendPM_AwakenOathAncestorInfoReq(activityId)
	AwakenOathAncestorAgent.instance:sendPM_AwakenOathAncestorInfoReq(activityId)
end

function AwakenOathAncestorController:handlePM_AwakenOathAncestorInfoRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_AwakenOathAncestorInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_AwakenOathAncestorInfoRes)
end

function AwakenOathAncestorController:sendPM_AwakenOathAncestorUnlockPointReq(activityId, pointId)
	AwakenOathAncestorAgent.instance:sendPM_AwakenOathAncestorUnlockPointReq(activityId, pointId)
end

function AwakenOathAncestorController:handlePM_AwakenOathAncestorUnlockPointRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_AwakenOathAncestorUnlockPointRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_AwakenOathAncestorUnlockPointRes, msg)
end

function AwakenOathAncestorController:sendPM_GainProgressPrizeReq(activityId, progressId)
	AwakenOathAncestorAgent.instance:sendPM_GainProgressPrizeReq(activityId, progressId)
end

function AwakenOathAncestorController:handlePM_GainProgressPrizeRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_GainProgressPrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_GainProgressPrizeRes)
end

function AwakenOathAncestorController:sendPM_AwakenOathAncestorChallengeReq(activityId, form, stageId)
	AwakenOathAncestorAgent.instance:sendPM_AwakenOathAncestorChallengeReq(activityId, form, stageId)
end

function AwakenOathAncestorController:handlePM_AwakenOathAncestorChallengeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_AwakenOathAncestorChallengeRes)
end

function AwakenOathAncestorController:handlePM_AwakenOathAncestorNotifyChallengeRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_AwakenOathAncestorNotifyChallengeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_AwakenOathAncestorNotifyChallengeRes)
end

function AwakenOathAncestorController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.AwakenOathAncestor)
end

function AwakenOathAncestorController:getSubMo(activityId)
	return AwakenOathAncestorModel.instance:getSubMo(activityId)
end

function AwakenOathAncestorController:enterBattle(activityId, stageId)
	local fmtMo = AwakenOathAncestorModel.instance:getClgFmtMo()

	fmtMo:updateCfg(activityId, stageId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

AwakenOathAncestorController.instance = AwakenOathAncestorController.New()

return AwakenOathAncestorController
