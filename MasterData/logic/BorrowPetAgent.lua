-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/borrowpet/agent/BorrowPetAgent.lua

module("logic.extensions.borrowpet.agent.BorrowPetAgent", package.seeall)

local BorrowPetAgent = class("BorrowPetAgent", BaseAgent)

function BorrowPetAgent:sendPM_BorrowPetGetActivityInfosReq(activityId)
	local req = BorrowPetExtension_pb.PM_BorrowPetGetActivityInfosReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function BorrowPetAgent:handlePM_BorrowPetGetActivityInfosRes(status, msg)
	if status == 0 then
		BorrowPetController.instance:handlePM_BorrowPetGetActivityInfosRes(msg)
	end
end

function BorrowPetAgent:sendPM_BorrowPetBorrowReq(activityId, itemId)
	local req = BorrowPetExtension_pb.PM_BorrowPetBorrowReq()

	req.activityId = activityId
	req.itemId = itemId

	self:sendMsg(req)
end

function BorrowPetAgent:handlePM_BorrowPetBorrowRes(status, msg)
	if status == 0 then
		BorrowPetController.instance:handlePM_BorrowPetBorrowRes(msg)
	end
end

BorrowPetAgent.instance = BorrowPetAgent.New()

return BorrowPetAgent
