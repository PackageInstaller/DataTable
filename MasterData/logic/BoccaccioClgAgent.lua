-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/boccaccioclg/agent/BoccaccioClgAgent.lua

module("logic.extensions.boccaccioclg.agent.BoccaccioClgAgent", package.seeall)

local BoccaccioClgAgent = class("BoccaccioClgAgent", BaseAgent)

function BoccaccioClgAgent:sendPM_BoccaccioClgGetInfoReq(activityId)
	local req = BoccaccioClgExtension_pb.PM_BoccaccioClgGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function BoccaccioClgAgent:handlePM_BoccaccioClgGetInfoRes(status, msg)
	if status == 0 then
		BoccaccioclgModel.instance:setInfo(msg)
		GlobalDispatcher:dispatch(GlobalNotify.BoccaccioClgGetInfoRes)
	end
end

function BoccaccioClgAgent:sendPM_BoccaccioClgFightReq(activityId, stageId, form)
	local req = BoccaccioClgExtension_pb.PM_BoccaccioClgFightReq()

	req.activityId = activityId
	req.stageId = stageId

	req.form:ParseFromString(form:SerializeToString())
	self:sendMsg(req)
end

function BoccaccioClgAgent:handlePM_BoccaccioClgFightRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.BoccaccioClgFightRes)
	end
end

function BoccaccioClgAgent:handlePM_BoccaccioClgNotifyFightRes(status, msg)
	if status == 0 then
		BoccaccioclgController.instance:onNotifyFightRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.BoccaccioClgNotifyFightRes)
	end
end

BoccaccioClgAgent.instance = BoccaccioClgAgent.New()

return BoccaccioClgAgent
