-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/birthdaysportswish/agent/BirthdaySportsWishesAgent.lua

module("logic.extensions.birthdaysportswish.agent.BirthdaySportsWishesAgent", package.seeall)

local BirthdaySportsWishesAgent = class("BirthdaySportsWishesAgent", BaseAgent)

function BirthdaySportsWishesAgent:sendPM_BirthdaySportsWishesGetInfoReq(activityId)
	local req = BirthdaySportsWishesExtension_pb.PM_BirthdaySportsWishesGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function BirthdaySportsWishesAgent:handlePM_BirthdaySportsWishesGetInfoRes(status, msg)
	if status == 0 then
		BirthdaySportsWishController.instance:handleGetInfo(msg)
	end
end

function BirthdaySportsWishesAgent:sendPM_BirthdaySportsWishesHirePetReq(activityId)
	local req = BirthdaySportsWishesExtension_pb.PM_BirthdaySportsWishesHirePetReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function BirthdaySportsWishesAgent:handlePM_BirthdaySportsWishesHirePetRes(status, msg)
	if status == 0 then
		BirthdaySportsWishController.instance:handleHidePet(msg)
	end
end

BirthdaySportsWishesAgent.instance = BirthdaySportsWishesAgent.New()

return BirthdaySportsWishesAgent
