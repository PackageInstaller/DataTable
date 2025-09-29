-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/agent/MonumentAgent.lua

module("logic.extensions.playerinfo.agent.MonumentAgent", package.seeall)

local M = class("MonumentAgent", BaseAgent)

function M:ctor()
	M.super.ctor(self)
end

function M:sendGetAllCupRequest()
	local msg = AchievementExtension_pb.GetAllCupRequest()

	self:sendMsg(msg)
end

function M:handleGetAllCupReply(status, msg)
	if status == 0 then
		MonumentModel.instance:refreshMonumentMoByAgent(msg.cups or {})
		GlobalDispatcher:dispatchEvent(EventType.UPDATA_MONUMENT)
	end
end

function M:handleFinishPush(status, msg)
	if status == 0 then
		MonumentModel.instance:refreshMonumentMoByAgent({
			msg.cup
		})
		GlobalDispatcher:dispatchEvent(EventType.UPDATA_MONUMENT)
		MonumentController.instance:handleGetNewMonument({
			msg.cup
		})
	end
end

M.instance = M.New()

return M
