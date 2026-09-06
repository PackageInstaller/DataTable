-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/agent/ActivitySummaryStatisticsAgent.lua

module("logic.extensions.activitysummarystatistics.agent.ActivitySummaryStatisticsAgent", package.seeall)

local ActivitySummaryStatisticsAgent = class("ActivitySummaryStatisticsAgent", BaseAgent)

function ActivitySummaryStatisticsAgent:sendPM_ActivitySummaryStatisticsGetInfoReq()
	local req = ActivitySummaryStatisticsExtension_pb.PM_ActivitySummaryStatisticsGetInfoReq()

	self:sendMsg(req)
end

function ActivitySummaryStatisticsAgent:handlePM_ActivitySummaryStatisticsGetInfoRes(status, msg)
	if status == 0 then
		OpSummaryModel.instance:handleSummaryStatisticsGetInfoRes(msg)
	end
end

ActivitySummaryStatisticsAgent.instance = ActivitySummaryStatisticsAgent.New()

return ActivitySummaryStatisticsAgent
