-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/birthdaywishes/agent/BirthdayWishesAgent.lua

module("logic.extensions.birthdaywishes.agent.BirthdayWishesAgent", package.seeall)

local BirthdayWishesAgent = class("BirthdayWishesAgent", BaseAgent)

function BirthdayWishesAgent:sendPM_BirthdayWishesUserInfoReq(activityId)
	local req = BirthdayWishesExtension_pb.PM_BirthdayWishesUserInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function BirthdayWishesAgent:handlePM_BirthdayWishesUserInfoRes(status, msg)
	if status == 0 then
		BirthdayWishesController.instance:csSendBirthdayWishesUserInfo(msg)
	end
end

function BirthdayWishesAgent:sendPM_BirthdayWishesSendWishReq(activityId, textId)
	local req = BirthdayWishesExtension_pb.PM_BirthdayWishesSendWishReq()

	req.activityId = activityId
	req.textId = textId

	self:sendMsg(req)
end

function BirthdayWishesAgent:handlePM_BirthdayWishesSendWishRes(status, msg)
	if status == 0 then
		BirthdayWishesController.instance:csSendBirthdayWishesSendWish(msg)
	end
end

function BirthdayWishesAgent:sendPM_BirthdayWishesGiftOpenReq(activityId, giftType)
	local req = BirthdayWishesExtension_pb.PM_BirthdayWishesGiftOpenReq()

	req.activityId = activityId
	req.giftType = giftType

	self:sendMsg(req)
end

function BirthdayWishesAgent:handlePM_BirthdayWishesGiftOpenRes(status, msg)
	if status == 0 then
		BirthdayWishesController.instance:csSendBirthdayWishesGiftOpen(msg)
	end
end

function BirthdayWishesAgent:sendPM_BirthdayWishesGiveFriendReq(activityId, friendUserId, tokenId)
	local req = BirthdayWishesExtension_pb.PM_BirthdayWishesGiveFriendReq()

	req.activityId = activityId
	req.friendUserId = friendUserId
	req.tokenId = tokenId

	self:sendMsg(req)
end

function BirthdayWishesAgent:handlePM_BirthdayWishesGiveFriendRes(status, msg)
	if status == 0 then
		BirthdayWishesController.instance:csSendBirthdayWishesGiveFriend(msg)
	end
end

function BirthdayWishesAgent:sendPM_BirthdayWishesGiveAndGetRecordReq(activityId)
	local req = BirthdayWishesExtension_pb.PM_BirthdayWishesGiveAndGetRecordReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function BirthdayWishesAgent:handlePM_BirthdayWishesGiveAndGetRecordRes(status, msg)
	if status == 0 then
		BirthdayWishesController.instance:csSendBirthdayWishesGiveAndGetRecord(msg)
	end
end

function BirthdayWishesAgent:sendPM_BirthdayWishesUserRedPointSetReq(activityId, giftType, redOpen)
	local req = BirthdayWishesExtension_pb.PM_BirthdayWishesUserRedPointSetReq()

	req.activityId = activityId
	req.giftType = giftType
	req.redOpen = redOpen

	self:sendMsg(req)
end

function BirthdayWishesAgent:handlePM_BirthdayWishesUserRedPointSetRes(status, msg)
	if status == 0 then
		BirthdayWishesController.instance:csSendBirthdayWishesUserRedPointSet(msg)
	end
end

function BirthdayWishesAgent:sendPM_BirthdayWishesPutOutWishListReq(activityId, wishListId)
	local req = BirthdayWishesExtension_pb.PM_BirthdayWishesPutOutWishListReq()

	req.activityId = activityId
	req.wishListId = wishListId

	self:sendMsg(req)
end

function BirthdayWishesAgent:handlePM_BirthdayWishesPutOutWishListRes(status, msg)
	if status == 0 then
		BirthdayWishesController.instance:handleBirthdayWishesPutOutWishListRes(msg)
	end
end

function BirthdayWishesAgent:sendPM_BirthdayWishesRepealWishListReq(activityId)
	local req = BirthdayWishesExtension_pb.PM_BirthdayWishesRepealWishListReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function BirthdayWishesAgent:handlePM_BirthdayWishesRepealWishListRes(status, msg)
	if status == 0 then
		BirthdayWishesController.instance:handleBirthdayWishesRepealWishListRes(msg)
	end
end

function BirthdayWishesAgent:sendPM_BirthdayWishesGetAllWishListReq(activityId)
	local req = BirthdayWishesExtension_pb.PM_BirthdayWishesGetAllWishListReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function BirthdayWishesAgent:handlePM_BirthdayWishesGetAllWishListRes(status, msg)
	if status == 0 then
		BirthdayWishesController.instance:handleBirthdayWishesGetAllWishListRes(msg)
	end
end

function BirthdayWishesAgent:sendPM_BirthdayWishesGetWishListRecordReq(activityId)
	local req = BirthdayWishesExtension_pb.PM_BirthdayWishesGetWishListRecordReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function BirthdayWishesAgent:handlePM_BirthdayWishesGetWishListRecordRes(status, msg)
	if status == 0 then
		BirthdayWishesController.instance:handleBirthdayWishesGetWishListRecordRes(msg)
	end
end

function BirthdayWishesAgent:sendPM_BirthdayWishesFinishBuddyWishListReq(activityId, targetUserId)
	local req = BirthdayWishesExtension_pb.PM_BirthdayWishesFinishBuddyWishListReq()

	req.activityId = activityId
	req.targetUserId = targetUserId

	self:sendMsg(req)
end

function BirthdayWishesAgent:handlePM_BirthdayWishesFinishBuddyWishListRes(status, msg)
	if status == 0 then
		BirthdayWishesController.instance:handleBirthdayWishesFinishBuddyWishListRes(msg)
	end
end

function BirthdayWishesAgent:sendPM_BirthadyWishesGainCollectPrizeReq(activityId, prizeId)
	local req = BirthdayWishesExtension_pb.PM_BirthadyWishesGainCollectPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function BirthdayWishesAgent:handlePM_BirthadyWishesGainCollectPrizeRes(status, msg)
	if status == 0 then
		BirthdayWishesController.instance:handlePM_BirthadyWishesGainCollectPrizeRes(msg)
	end
end

function BirthdayWishesAgent:sendPM_BirthadyWishesGainGivePrizeReq(activityId, prizeId)
	local req = BirthdayWishesExtension_pb.PM_BirthadyWishesGainGivePrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function BirthdayWishesAgent:handlePM_BirthadyWishesGainGivePrizeRes(status, msg)
	if status == 0 then
		BirthdayWishesController.instance:handlePM_BirthadyWishesGainGivePrizeRes(msg)
	end
end

BirthdayWishesAgent.instance = BirthdayWishesAgent.New()

return BirthdayWishesAgent
