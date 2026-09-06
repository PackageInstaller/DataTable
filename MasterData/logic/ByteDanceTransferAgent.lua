-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zijiedatatransfer/agent/ByteDanceTransferAgent.lua

module("logic.extensions.bytedancetransfer.agent.ByteDanceTransferAgent", package.seeall)

local ByteDanceTransferAgent = class("ByteDanceTransferAgent", BaseAgent)

function ByteDanceTransferAgent:ctor()
	return
end

function ByteDanceTransferAgent:setExtId(extId)
	ByteDanceTransferAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function ByteDanceTransferAgent:sendPM_ByteDanceTransferInfoReq()
	local req = ByteDanceTransferExtension_pb.PM_ByteDanceTransferInfoReq()

	self:sendMsg(req)
end

function ByteDanceTransferAgent:handlePM_ByteDanceTransferInfoRes(status, msg)
	return
end

function ByteDanceTransferAgent:sendPM_ByteDanceTransferCreateTokenReq()
	local req = ByteDanceTransferExtension_pb.PM_ByteDanceTransferCreateTokenReq()

	self:sendMsg(req)
end

function ByteDanceTransferAgent:handlePM_ByteDanceTransferCreateTokenRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(ByteDanceTransferController.ON_WEB_VIEW_RES, msg)
	end
end

function ByteDanceTransferAgent:handlePM_ByteDanceTransferNotifyInfoRes(status, msg)
	ByteDanceTransferController.instance:onSetMainMsg(msg)
	GlobalDispatcher:dispatch(ByteDanceTransferController.ON_MAIN_VIEW_RES, msg)
end

ByteDanceTransferAgent.instance = ByteDanceTransferAgent.New()

return ByteDanceTransferAgent
