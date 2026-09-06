-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/teachingdungeon/agent/BattleCollegeAgent.lua

module("logic.extensions.battlecollege.agent.BattleCollegeAgent", package.seeall)

local BattleCollegeAgent = class("BattleCollegeAgent", BaseAgent)

BattleCollegeAgent.BC_ProcessInfoRes = "BattleCollegeAgent_BC_ProcessInfoRes"
BattleCollegeAgent.BC_ChallengeRes = "BattleCollegeAgent_BC_ChallengeRes"
BattleCollegeAgent.BC_NotifyAfterChallengeRes = "BattleCollegeAgent_BC_NotifyAfterChallengeRes"

function BattleCollegeAgent:ctor()
	return
end

function BattleCollegeAgent:setExtId(extId)
	BattleCollegeAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function BattleCollegeAgent:sendBC_ProcessInfoReq(handler, handlerObj, errHandler)
	local req = BattleCollegeExtension_pb.BC_ProcessInfoReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(BattleCollegeAgent.BC_ProcessInfoRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function BattleCollegeAgent:handleBC_ProcessInfoRes(status, msg)
	self:dispatch(BattleCollegeAgent.BC_ProcessInfoRes, status, msg)
end

function BattleCollegeAgent:sendBC_ChallengeReq(stageId, form_pb, handler, handlerObj, errHandler)
	local req = BattleCollegeExtension_pb.BC_ChallengeReq()

	req.stageId = stageId

	if form_pb ~= nil then
		req.form:ParseFromString(form_pb:SerializeToString())
	end

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(BattleCollegeAgent.BC_ChallengeRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function BattleCollegeAgent:handleBC_ChallengeRes(status, msg)
	self:dispatch(BattleCollegeAgent.BC_ChallengeRes, status, msg)
end

function BattleCollegeAgent:handleBC_NotifyAfterChallengeRes(status, msg)
	self:dispatch(BattleCollegeAgent.BC_NotifyAfterChallengeRes, status, msg)
end

BattleCollegeAgent.instance = BattleCollegeAgent.New()

return BattleCollegeAgent
