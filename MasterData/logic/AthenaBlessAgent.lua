-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/athenabless/agent/AthenaBlessAgent.lua

module("logic.extensions.athenabless.agent.AthenaBlessAgent", package.seeall)

local AthenaBlessAgent = class("AthenaBlessAgent", BaseAgent)

function AthenaBlessAgent:sendPM_AnthenaBlessGetInfoReq(activityId)
	local req = AthenaBlessExtension_pb.PM_AnthenaBlessGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function AthenaBlessAgent:handlePM_AnthenaBlessGetInfoRes(status, msg)
	if status == 0 then
		AthenaBlessModel.instance:onGetInfo(msg)
		GlobalDispatcher:dispatch(GlobalNotify.AthenaBlessGetInfo)
	end
end

function AthenaBlessAgent:sendPM_AnthenaBlessGainPrizeReq(activityId, prizeId)
	local req = AthenaBlessExtension_pb.PM_AnthenaBlessGainPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)

	self._prizeId = prizeId
end

function AthenaBlessAgent:handlePM_AnthenaBlessGainPrizeRes(status, msg)
	if status == 0 then
		if self._prizeId then
			AthenaBlessModel.instance:updatePrizeState(self._prizeId, true)
		end

		GlobalDispatcher:dispatch(GlobalNotify.AthenaBlessGainPrize, true)
	else
		GlobalDispatcher:dispatch(GlobalNotify.AthenaBlessGainPrize, false)
	end

	self._prizeId = nil
end

AthenaBlessAgent.instance = AthenaBlessAgent.New()

return AthenaBlessAgent
