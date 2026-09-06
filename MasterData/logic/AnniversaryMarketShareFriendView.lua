-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/anniversarymarket/view/AnniversaryMarketShareFriendView.lua

module("logic.extensions.anniversarymarket.view.AnniversaryMarketShareFriendView", package.seeall)

local AnniversaryMarketShareFriendView = class("AnniversaryMarketShareFriendView", ViewComponent)
local MAX_SEND_NUM = 5

function AnniversaryMarketShareFriendView:ctor()
	AnniversaryMarketShareFriendView.super.ctor(self)
end

function AnniversaryMarketShareFriendView:unbindEvents()
	AnniversaryMarketShareFriendView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnCopy)
	GameUtil.rmClickHandler(self._btnSend)
end

function AnniversaryMarketShareFriendView:bindEvents()
	AnniversaryMarketShareFriendView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnCopy, self._onClickBtnCopy, self)
	GameUtil.addClickHandler(self._btnSend, self._onClickBtnSend, self)
end

function AnniversaryMarketShareFriendView:buildUI()
	AnniversaryMarketShareFriendView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._txtLeftNum = self:getTxt("leftNum/txtLeftNum")
	self._txtCode = self:getTxt("marketCode/txtCode")
	self._txtTip = self:getTxt("tip/text")
	self._highPrizeTag = self:getGo("soldBar/highPrizeTag")
	self._lowPrizeTag = self:getGo("soldBar/lowPrizeTag")
	self._imgSold = self:getGo("soldBar/imgSold")
	self._txtPrice = self:getTxt("soldBar/txtPrice")
	self._btnCopy = self:getGo("btnCopy")
	self._btnSend = self:getGo("btnSend")
end

function AnniversaryMarketShareFriendView:onExit()
	AnniversaryMarketShareFriendView.super.onExit(self)
	MaterialMgr.clearIcon(self._imgSold)
end

function AnniversaryMarketShareFriendView:onEnter()
	AnniversaryMarketShareFriendView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_AnniversaryMarketGetMyShareCodeRes, self._onSetUI, self)
	self.addGEvent(self, GlobalNotify.FriendSelected, self._friendSelected, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._shareCode = params[2]
	self._otherSellCount = checknumber(params[3])
	self._actCfg = AnniversaryMarketConfig.instance:getActCfg(self._activityId)
	self._info = AnniversaryMarketModel.instance:getInfo(self._activityId)
	self._buddyIds = nil

	self:_onSetUI()
	AnniversaryMarketController.instance:sendPM_AnniversaryMarketGetMyShareCodeReq(self._activityId)
end

function AnniversaryMarketShareFriendView:_onSetUI()
	local sellForOtherDailyLimit = self._actCfg.sellForOtherDailyLimit
	local leftSellFriendNum = sellForOtherDailyLimit - self._otherSellCount
	local curPriceCfgs = AnniversaryMarketConfig.instance:getPriceRangesCfg(self._actCfg.commonPricePlanId)
	local curPriceCfg = curPriceCfgs[#curPriceCfgs]
	local maxRange = curPriceCfg.priceRange
	local isHighPrize = self._info.todayPrice >= maxRange[1]
	local matType, matId, matNum = MaterialMgr.getMatParams(self._actCfg.refreshCoinMpKey)

	self._txtCode.text = self._shareCode
	self._txtTip.text = string.format("好友在你的市集出售,你可以获得%d%%返利噢~", self._actCfg.rebatePercent)
	self._txtLeftNum.text = string.format("%d/%d", leftSellFriendNum, sellForOtherDailyLimit)
	self._txtPrice.text = self._info.todayPrice

	MaterialMgr.setIcon(self._imgSold, matType, matId)
	GameUtil.SetActive(self._highPrizeTag, isHighPrize)
	GameUtil.SetActive(self._lowPrizeTag, not isHighPrize)
end

function AnniversaryMarketShareFriendView:_onClickBtnCopy()
	local soldStr = string.format("我的市集是【%s】，今日每个可兑%d币，粘贴这段文字即可前往！", self._shareCode, self._info.todayPrice)

	if Framework.OSDef.isEditor then
		Game.TextUtil.CopyToClipBoard(soldStr)
	else
		Clipboard.copy(soldStr)
	end

	FloatWordMgr.instance:show("分享码已复制，快去分享给好友吧~")
	SDKManager.share(SDKManager.SHARE_TEXT, soldStr, "我的邀请", nil, nil, 1)
end

function AnniversaryMarketShareFriendView:_onClickBtnSend()
	local cdTime = AnniversaryMarketController.instance:getInviteCdTime()

	if cdTime and cdTime <= 0 then
		local maxCount = MAX_SEND_NUM
		local desc = "选择在线的好友发送集市邀请"

		UIStateManager.instance:open(ViewName.AnniversaryMarketInviteView, 0, maxCount, desc)
	else
		FloatWordMgr.instance:show("邀请得太快啦~每次邀请之间要间隔30秒，晚点再来吧~")
	end
end

function AnniversaryMarketShareFriendView:_friendSelected(buddyIds)
	self._buddyIds = buddyIds

	local tpId = 85

	self._msgType = GameEnum.ChatType.System

	local cfg = ChatConfig.instance:getSystemMsgT(tpId)
	local params = {}

	params.activityId = self._activityId
	params.price = self._info.todayPrice
	params.shareCode = self._info.shareCode
	params.sendChatTime = ServerTime.now()

	local dataT = {
		tpId = 85,
		params = params
	}

	self._content = GameUtil.jsonToString(dataT)

	self:_sendInviteMsg()
end

function AnniversaryMarketShareFriendView:_sendInviteMsg()
	ChatAgent.instance:sendBatchSendMsgToBuddyReq(GameEnum.ChatChannel.Private, self._msgType, self._content, self._buddyIds, nil, nil)
end

return AnniversaryMarketShareFriendView
