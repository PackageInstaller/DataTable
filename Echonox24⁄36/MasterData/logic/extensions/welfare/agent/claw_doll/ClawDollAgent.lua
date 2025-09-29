-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/welfare/agent/claw_doll/ClawDollAgent.lua

module("logic.extensions.welfare.agent.claw_doll.ClawDollAgent", package.seeall)

local M = class("ClawDollAgent", BaseAgent)

function M:sendGetClipDollInfoRequest(cfgId)
	local msg = ClipDollExtension_pb.GetClipDollInfoRequest()

	msg.aConfigId = cfgId

	self:sendMsg(msg)
end

function M:handleGetClipDollInfoReply(status, msg)
	if status == 0 then
		ClawDollController.instance:setClipDollInfoReply(msg)
	end
end

function M:sendClipDollRequest(table)
	local msg = ClipDollExtension_pb.ClipDollRequest()

	msg.aConfigId = table.cfgId
	msg.doll = table.dollId

	self:sendMsg(msg)
end

function M:handleClipDollReply(status, msg)
	if status == 0 then
		ClawDollController.instance:setClipDollBollReply(msg)
	end
end

function M:sendRedeemPrizeRequest(info)
	local msg = ClipDollExtension_pb.RedeemPrizeRequest()

	msg.aConfigId = info.cfgId
	msg.id = info.id

	self:sendMsg(msg)
end

function M:handleRedeemPrizeReply(status, msg)
	if status == 0 then
		ClawDollController.instance:setRedeemPrizeReply(msg)
	end
end

function M:handleDollsChangePush(status, msg)
	if status == 0 then
		self:sendGetClipDollInfoRequest(msg.aConfigId)
	end
end

M.instance = M:New()

return M
