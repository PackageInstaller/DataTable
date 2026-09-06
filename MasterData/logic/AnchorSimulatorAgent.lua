-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/anchorsimulator/agent/AnchorSimulatorAgent.lua

module("logic.extensions.anchorsimulator.agent.AnchorSimulatorAgent", package.seeall)

local AnchorSimulatorAgent = class("AnchorSimulatorAgent", BaseAgent)

function AnchorSimulatorAgent:sendPM_AnchorSimulatorGetInfoReq(activityId)
	local req = AnchorSimulatorExtension_pb.PM_AnchorSimulatorGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function AnchorSimulatorAgent:handlePM_AnchorSimulatorGetInfoRes(status, msg)
	if status == 0 then
		AnchorSimulatorController.instance:handlePM_AnchorSimulatorGetInfoRes(msg)
	end
end

function AnchorSimulatorAgent:sendPM_AnchorSimulatorTrainReq(activityId, selectClasses)
	local req = AnchorSimulatorExtension_pb.PM_AnchorSimulatorTrainReq()

	req.activityId = activityId

	if selectClasses then
		for _, v in ipairs(selectClasses) do
			req.selectClasses:append(v)
		end
	end

	self:sendMsg(req)
end

function AnchorSimulatorAgent:handlePM_AnchorSimulatorTrainRes(status, msg)
	if status == 0 then
		AnchorSimulatorController.instance:handlePM_AnchorSimulatorTrainRes(msg)
	end
end

function AnchorSimulatorAgent:sendPM_AnchorSimulatorRefreshBuffReq(activityId)
	local req = AnchorSimulatorExtension_pb.PM_AnchorSimulatorRefreshBuffReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function AnchorSimulatorAgent:handlePM_AnchorSimulatorRefreshBuffRes(status, msg)
	if status == 0 then
		AnchorSimulatorController.instance:handlePM_AnchorSimulatorRefreshBuffRes(msg)
	end
end

function AnchorSimulatorAgent:sendPM_AnchorSimulatorStartLiveReq(activityId, guestIds)
	local req = AnchorSimulatorExtension_pb.PM_AnchorSimulatorStartLiveReq()

	req.activityId = activityId

	if guestIds then
		for _, v in ipairs(guestIds) do
			req.guestIds:append(v)
		end
	end

	self:sendMsg(req)
end

function AnchorSimulatorAgent:handlePM_AnchorSimulatorStartLiveRes(status, msg)
	if status == 0 then
		AnchorSimulatorController.instance:handlePM_AnchorSimulatorStartLiveRes(msg)
	end
end

function AnchorSimulatorAgent:sendPM_AnchorSimulatorRankViewReq(activityId)
	local req = AnchorSimulatorExtension_pb.PM_AnchorSimulatorRankViewReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function AnchorSimulatorAgent:handlePM_AnchorSimulatorRankViewRes(status, msg)
	if status == 0 then
		AnchorSimulatorController.instance:handlePM_AnchorSimulatorRankViewRes(msg)
	end
end

AnchorSimulatorAgent.instance = AnchorSimulatorAgent.New()

return AnchorSimulatorAgent
