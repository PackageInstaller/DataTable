-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/anchorsimulator/controller/AnchorSimulatorController.lua

module("logic.extensions.anchorsimulator.controller.AnchorSimulatorController", package.seeall)

local AnchorSimulatorController = class("AnchorSimulatorController", BaseController)

function AnchorSimulatorController:onInit()
	return
end

function AnchorSimulatorController:onReset()
	return
end

function AnchorSimulatorController:sendPM_AnchorSimulatorGetInfoReq(activityId)
	AnchorSimulatorAgent.instance:sendPM_AnchorSimulatorGetInfoReq(activityId)
end

function AnchorSimulatorController:handlePM_AnchorSimulatorGetInfoRes(msg)
	local mo = self:getAnchorSimulatorMo(msg.activityId)

	mo:handlePM_AnchorSimulatorGetInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_AnchorSimulatorGetInfoRes)
end

function AnchorSimulatorController:sendPM_AnchorSimulatorTrainReq(activityId, selectClasses)
	AnchorSimulatorAgent.instance:sendPM_AnchorSimulatorTrainReq(activityId, selectClasses)
end

function AnchorSimulatorController:handlePM_AnchorSimulatorTrainRes(msg)
	local mo = self:getAnchorSimulatorMo(msg.activityId)

	mo:handlePM_AnchorSimulatorTrainRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_AnchorSimulatorTrainRes, msg)
end

function AnchorSimulatorController:sendPM_AnchorSimulatorRefreshBuffReq(activityId)
	AnchorSimulatorAgent.instance:sendPM_AnchorSimulatorRefreshBuffReq(activityId)
end

function AnchorSimulatorController:handlePM_AnchorSimulatorRefreshBuffRes(msg)
	local mo = self:getAnchorSimulatorMo(msg.activityId)

	mo:handlePM_AnchorSimulatorRefreshBuffRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_AnchorSimulatorRefreshBuffRes)
end

function AnchorSimulatorController:sendPM_AnchorSimulatorStartLiveReq(activityId, guestIds)
	AnchorSimulatorAgent.instance:sendPM_AnchorSimulatorStartLiveReq(activityId, guestIds)
end

function AnchorSimulatorController:handlePM_AnchorSimulatorStartLiveRes(msg)
	local mo = self:getAnchorSimulatorMo(msg.activityId)

	mo:handlePM_AnchorSimulatorStartLiveRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_AnchorSimulatorStartLiveRes, msg)
end

function AnchorSimulatorController:sendPM_AnchorSimulatorRankViewReq(activityId)
	AnchorSimulatorAgent.instance:sendPM_AnchorSimulatorRankViewReq(activityId)
end

function AnchorSimulatorController:handlePM_AnchorSimulatorRankViewRes(msg)
	local mo = self:getAnchorSimulatorMo(msg.activityId)

	mo:handlePM_AnchorSimulatorRankViewRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_AnchorSimulatorRankViewRes, msg)
end

function AnchorSimulatorController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(self:getActivityType())
end

function AnchorSimulatorController:getActivityType()
	return GameEnum.ActivityType.AnchorSimulator
end

function AnchorSimulatorController:isInActivityTime(activityId)
	local activityType = self:getActivityType()

	return ActivityDefineController.instance:isInActivityTimeById(activityType, activityId)
end

function AnchorSimulatorController:getAnchorSimulatorMo(activityId)
	return AnchorSimulatorModel.instance:getAnchorSimulatorMo(activityId)
end

function AnchorSimulatorController:getProgressByExp(activityId, propertyType, exp)
	local curLevel = AnchorSimulatorConfig.instance:getPropertyLevelByExp(activityId, propertyType, exp)
	local maxLevel = AnchorSimulatorConfig.instance:getPropertyMaxLevel(activityId, propertyType)
	local nextLevel = Mathf.Min(curLevel + 1, maxLevel)
	local baseExp = AnchorSimulatorConfig.instance:getPropertyExpByLv(activityId, propertyType, curLevel)
	local nextExp = AnchorSimulatorConfig.instance:getPropertyExpByLv(activityId, propertyType, nextLevel)

	if nextExp == baseExp then
		return 1
	else
		return (exp - baseExp) / (nextExp - baseExp)
	end
end

function AnchorSimulatorController:opEventTask()
	local activityId = self:getActivityId()

	if not self:isInActivityTime(activityId) then
		FloatWordMgr.instance:show("不在活动日期内")

		return
	end

	UIStateManager.instance:push(ViewName.CommonGroupTaskMainView, activityId, 1)
end

function AnchorSimulatorController:getEventTaskRedId()
	local activityId = self:getActivityId()

	if self:isInActivityTime(activityId) then
		return EventTaskSummaryController.instance:getCurRedIdByActivityId(activityId)
	end
end

AnchorSimulatorController.instance = AnchorSimulatorController.New()

return AnchorSimulatorController
