-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/buddyhire/agent/BuddyPetLeaseAgent.lua

module("logic.extensions.buddypetlease.agent.BuddyPetLeaseAgent", package.seeall)

local BuddyPetLeaseAgent = class("BuddyPetLeaseAgent", BaseAgent)

function BuddyPetLeaseAgent:ctor()
	return
end

function BuddyPetLeaseAgent:setExtId(extId)
	BuddyPetLeaseAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function BuddyPetLeaseAgent:sendPM_BuddyPetLeaseGetHirePetInfoReq()
	local req = BuddyPetLeaseExtension_pb.PM_BuddyPetLeaseGetHirePetInfoReq()

	self:sendMsg(req)
end

function BuddyPetLeaseAgent:handlePM_BuddyPetLeaseGetHirePetInfoRes(status, msg)
	if status == 0 then
		BuddyHireController.instance:onGetOtherListInfo(msg)
	end
end

function BuddyPetLeaseAgent:sendPM_BuddyPetLeaseGetBuddyPetInfoReq(petId, userId)
	local req = BuddyPetLeaseExtension_pb.PM_BuddyPetLeaseGetBuddyPetInfoReq()

	req.petId = petId
	req.userId = userId

	self:sendMsg(req)
end

function BuddyPetLeaseAgent:handlePM_BuddyPetLeaseGetBuddyPetInfoRes(status, msg)
	if status == 0 then
		BuddyHireController.instance:onGetPetDetail(msg)
	end
end

function BuddyPetLeaseAgent:sendPM_BuddyPetLeaseHireReq(petId, userId)
	local req = BuddyPetLeaseExtension_pb.PM_BuddyPetLeaseHireReq()

	req.petId = petId
	req.userId = userId

	self:sendMsg(req)
end

function BuddyPetLeaseAgent:handlePM_BuddyPetLeaseHireRes(status, msg)
	if status == 0 then
		BuddyHireController.instance:onPetHireIn(msg)
	end
end

function BuddyPetLeaseAgent:sendPM_BuddyPetLeaseGetRentOutInfoReq()
	local req = BuddyPetLeaseExtension_pb.PM_BuddyPetLeaseGetRentOutInfoReq()

	self:sendMsg(req)
end

function BuddyPetLeaseAgent:handlePM_BuddyPetLeaseGetRentOutInfoRes(status, msg)
	if status == 0 then
		BuddyHireController.instance:onGetMyListInfo(msg)
	end
end

function BuddyPetLeaseAgent:sendPM_BuddyPetLeaseRentOutReq(petId, slotId)
	local req = BuddyPetLeaseExtension_pb.PM_BuddyPetLeaseRentOutReq()

	req.petId = petId
	req.slotId = slotId

	self:sendMsg(req)
end

function BuddyPetLeaseAgent:handlePM_BuddyPetLeaseRentOutRes(status, msg)
	if status == 0 then
		BuddyHireController.instance:onPetHireOut(msg)
	end
end

function BuddyPetLeaseAgent:sendPM_BuddyPetLeaseGainPrizeReq()
	local req = BuddyPetLeaseExtension_pb.PM_BuddyPetLeaseGainPrizeReq()

	self:sendMsg(req)
end

function BuddyPetLeaseAgent:handlePM_BuddyPetLeaseGainPrizeRes(status, msg)
	if status == 0 then
		BuddyHireController.instance:onGetPrize(msg)
	end
end

BuddyPetLeaseAgent.instance = BuddyPetLeaseAgent.New()

return BuddyPetLeaseAgent
