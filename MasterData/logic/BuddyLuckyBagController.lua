-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/buddyluckybag/controller/BuddyLuckyBagController.lua

module("logic.extensions.buddyluckybag.controller.BuddyLuckyBagController", package.seeall)

local BuddyLuckyBagController = class("BuddyLuckyBagController", BaseController)

function BuddyLuckyBagController:onInit()
	GlobalDispatcher:addListener(GlobalNotify.ON_CLICK_ITEM_CHAT, self._onChatItemClick, self)
end

function BuddyLuckyBagController:onReset()
	return
end

function BuddyLuckyBagController:_onChatItemClick(tpId, chatMsgMo)
	if tpId == 93 then
		local activityId = chatMsgMo:getParam("activityId", true)
		local inviteCode = chatMsgMo:getParam("inviteCode", false)

		self:openInviteView(activityId, inviteCode, tpId)
	elseif tpId == 94 then
		local activityId = chatMsgMo:getParam("activityId", true)
		local buddyId = chatMsgMo:getParam("buddyId", false)
		local bagId = chatMsgMo:getParam("bagId", true)
		local prizeId = chatMsgMo:getParam("prizeId", true)

		self:openCardSureUseView(tpId, activityId, buddyId, bagId, prizeId)
	end
end

function BuddyLuckyBagController:sendPM_BuddyLuckyBagGetInfoReq(activityId)
	BuddyLuckyBagAgent.instance:sendPM_BuddyLuckyBagGetInfoReq(activityId)
end

function BuddyLuckyBagController:handlePM_BuddyLuckyBagGetInfoRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_BuddyLuckyBagGetInfoRes(msg)
	self:_updateCardRedPoint(msg.activityId)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_BuddyLuckyBagGetInfoRes)
end

function BuddyLuckyBagController:sendPM_BuddyLuckyBagHelpOpenBagReq(activityId, buddyCode)
	BuddyLuckyBagAgent.instance:sendPM_BuddyLuckyBagHelpOpenBagReq(activityId, buddyCode)
end

function BuddyLuckyBagController:handlePM_BuddyLuckyBagHelpOpenBagRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_BuddyLuckyBagHelpOpenBagRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_BuddyLuckyBagHelpOpenBagRes, msg)
end

function BuddyLuckyBagController:sendPM_BuddyLuckyBagGainCollectPrizeBagReq(activityId, prizeId)
	BuddyLuckyBagAgent.instance:sendPM_BuddyLuckyBagGainCollectPrizeBagReq(activityId, prizeId)
end

function BuddyLuckyBagController:handlePM_BuddyLuckyBagGainCollectPrizeBagRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_BuddyLuckyBagGainCollectPrizeBagRes(msg)
	self:_updateCardRedPoint(msg.activityId)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_BuddyLuckyBagGainCollectPrizeBagRes)
end

function BuddyLuckyBagController:sendPM_BuddyLuckyBagBuddyBagsReq(activityId, buddyIds)
	BuddyLuckyBagAgent.instance:sendPM_BuddyLuckyBagBuddyBagsReq(activityId, buddyIds)
end

function BuddyLuckyBagController:handlePM_BuddyLuckyBagBuddyBagsRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_BuddyLuckyBagBuddyBagsRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_BuddyLuckyBagBuddyBagsRes)
end

function BuddyLuckyBagController:sendPM_BuddyLuckyBagGainLuckReq(activityId, buddyId, bagId, prizeId)
	BuddyLuckyBagAgent.instance:sendPM_BuddyLuckyBagGainLuckReq(activityId, buddyId, bagId, prizeId)
end

function BuddyLuckyBagController:handlePM_BuddyLuckyBagGainLuckRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_BuddyLuckyBagGainLuckRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_BuddyLuckyBagGainLuckRes)
end

function BuddyLuckyBagController:sendPM_BuddyLuckyBagGainBagPrizeReq(activityId, bagId)
	BuddyLuckyBagAgent.instance:sendPM_BuddyLuckyBagGainBagPrizeReq(activityId, bagId)
end

function BuddyLuckyBagController:handlePM_BuddyLuckyBagGainBagPrizeRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_BuddyLuckyBagGainBagPrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_BuddyLuckyBagGainBagPrizeRes)
end

function BuddyLuckyBagController:handlePM_BuddyLuckyBagNotifyChangeRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_BuddyLuckyBagNotifyChangeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_BuddyLuckyBagNotifyChangeRes)
end

function BuddyLuckyBagController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.BuddyLuckyBag)
end

function BuddyLuckyBagController:getSubMo(activityId)
	return BuddyLuckyBagModel.instance:getSubMo(activityId)
end

function BuddyLuckyBagController:openInviteView(activityId, inviteCode, templateId)
	local isInActivityTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(activityId)

	if not isInActivityTime then
		FloatWordMgr.instance:show("活动已过期")

		return
	end

	BonusController.instance:openBonusView(ViewName.BuddyLuckyBagMainView)

	local cfg = ChatConfig.instance:getSystemMsgT(templateId)
	local content = ""

	if cfg then
		local t = {
			inviteCode = inviteCode
		}

		content = StringUtil.parseJsonParams(cfg.template, t)
	end

	UIStateManager.instance:push(ViewName.BuddyLuckyBagHelpShareView, activityId, content)
end

function BuddyLuckyBagController:openCardSureUseView(templateId, activityId, buddyId, bagId, prizeId)
	local isInActivityTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(activityId)

	if not isInActivityTime then
		FloatWordMgr.instance:show("活动已过期")

		return
	end

	if tostring(buddyId) == tostring(RoleModel.instance:getUserId()) then
		FloatWordMgr.instance:show("无法粘自己的福袋噢")

		return
	end

	self._openCardSureUseViewParams = {
		activityId = activityId,
		buddyId = buddyId,
		bagId = bagId,
		prizeId = prizeId
	}

	GlobalDispatcher:addListener(GlobalNotify.HandlePM_BuddyLuckyBagGetInfoRes, self._handleOpenCardSureUseView, self)
	BuddyLuckyBagController.instance:sendPM_BuddyLuckyBagGetInfoReq(activityId)
end

function BuddyLuckyBagController:_handleOpenCardSureUseView()
	GlobalDispatcher:removeListener(GlobalNotify.HandlePM_BuddyLuckyBagGetInfoRes, self._handleOpenCardSureUseView, self)

	local params = self._openCardSureUseViewParams

	if params == nil then
		return
	end

	local activityId = params.activityId
	local buddyId = params.buddyId
	local bagId = params.bagId
	local prizeId = params.prizeId

	self._openCardSureUseViewParams = nil

	local subMo = self:getSubMo(activityId)
	local cardCount = subMo:getCardCount()

	if cardCount <= 0 then
		FloatWordMgr.instance:show("粘福卡不足")

		return
	end

	local isGain = subMo:isPrizeGainInBag(bagId)

	if isGain then
		FloatWordMgr.instance:show(string.format("%s号福袋奖励已领取，无法再粘福", bagId))

		return
	end

	local oldBagPrizeId = subMo:getPrizeIdInBag(bagId)

	if oldBagPrizeId <= 0 then
		FloatWordMgr.instance:show(string.format("%s号福袋未拆开，无法粘福", bagId))

		return
	end

	if oldBagPrizeId == prizeId then
		FloatWordMgr.instance:show("奖励相同，无法粘福")

		return
	end

	local oldBagInfo = {}

	oldBagInfo.buddyId = "0"
	oldBagInfo.bagId = bagId
	oldBagInfo.prizeId = oldBagPrizeId

	local newBagInfo = {}

	newBagInfo.buddyId = buddyId
	newBagInfo.bagId = bagId
	newBagInfo.prizeId = prizeId

	BonusController.instance:openBonusView(ViewName.BuddyLuckyBagMainView)
	UIStateManager.instance:push(ViewName.BuddyLuckyBagHelpCardSureView, activityId, oldBagInfo, newBagInfo)
end

function BuddyLuckyBagController:_updateCardRedPoint(activityId)
	local isActivated = false
	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(activityId)

	if isInTime then
		local dataList = BuddyLuckyBagConfig.instance:getCardDatas(activityId) or {}
		local subMo = self:getSubMo(activityId)

		for _, data in ipairs(dataList) do
			if subMo:isCanGainPrizeInCard(data.cardId) then
				isActivated = true

				break
			end
		end
	end

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_BUDDYLUCKYBAG_CARD_GAIN, isActivated)
end

BuddyLuckyBagController.instance = BuddyLuckyBagController.New()

return BuddyLuckyBagController
