-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/buddyluckybag/view/BuddyLuckyBagSharePrizeView.lua

module("logic.extensions.buddyluckybag.view.BuddyLuckyBagSharePrizeView", package.seeall)

local BuddyLuckyBagSharePrizeView = class("BuddyLuckyBagSharePrizeView", ViewComponent)

function BuddyLuckyBagSharePrizeView:buildUI()
	BuddyLuckyBagSharePrizeView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnChat = self:getGo("btnChat")
	self._btnShare = self:getGo("btnShare")
	self._txtBagInfo = self:getTxt("bagInfo/txt")
	self._iconPrize = self:getGo("prize/mask/icon")
end

function BuddyLuckyBagSharePrizeView:bindEvents()
	BuddyLuckyBagSharePrizeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnChat, self._onClickBtnChat, self)
	GameUtil.addClickHandler(self._btnShare, self._onClickBtnShare, self)
end

function BuddyLuckyBagSharePrizeView:unbindEvents()
	BuddyLuckyBagSharePrizeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnChat)
	GameUtil.rmClickHandler(self._btnShare)
end

function BuddyLuckyBagSharePrizeView:onEnter()
	BuddyLuckyBagSharePrizeView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._bagInfo = params[2]

	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._subMo = BuddyLuckyBagController.instance:getSubMo(self._activityId)
	self._actData = BuddyLuckyBagConfig.instance:getActivityData(self._activityId)
	self._isHasShare = false

	local bagId = self._bagInfo.bagId
	local prizeId = self._bagInfo.prizeId
	local bagData = BuddyLuckyBagConfig.instance:getBagData(self._activityId, bagId)
	local poolId = bagData.poolId
	local data = BuddyLuckyBagConfig.instance:getPoolPrizeData(poolId, prizeId)
	local matType, matId, matNum = MaterialMgr.getMatParams(data.prize)
	local matName = MaterialMgr.getMaterialsName(matType, matId)
	local templateId = self._actData.sharePrizeTemplateId

	self._dataT = {
		tpId = templateId,
		params = {
			activityId = self._activityId,
			buddyId = self._bagInfo.buddyId,
			bagId = self._bagInfo.bagId,
			prizeId = self._bagInfo.prizeId,
			prizeName = matName,
			prizeCount = matNum
		}
	}
	self._txtBagInfo.text = string.format("%s x %s", matName, matNum)

	GameUtil.SetGray(self._btnChat, self._isHasShare)
	MaterialMgr.setIcon(self._iconPrize, matType, matId, nil, nil)
	GameUtil.addClickHandler(self._iconPrize, function()
		CommonTipsMgr.instance:openMaterialTips(self._iconPrize, matType, matId, matNum)
	end, self)
end

function BuddyLuckyBagSharePrizeView:onExit()
	BuddyLuckyBagSharePrizeView.super.onExit(self)
	MaterialMgr.clearIcon(self._iconPrize)
	GameUtil.rmClickHandler(self._iconPrize)
end

function BuddyLuckyBagSharePrizeView:_onClickBtnChat()
	if self._isHasShare then
		FloatWordMgr.instance:show("已分享")

		return
	end

	local content = GameUtil.jsonToString(self._dataT)

	ChatAgent.instance:sendSendMsgReq(GameEnum.ChatChannel.Share, GameEnum.ChatType.System, content)

	self._isHasShare = true

	GameUtil.SetGray(self._btnChat, self._isHasShare)
end

function BuddyLuckyBagSharePrizeView:_onClickBtnCopy()
	local content = self._subMo:getMyCode()

	if Framework.OSDef.isEditor then
		Game.TextUtil.CopyToClipBoard(content)
	else
		Clipboard.copy(content)
	end

	FloatWordMgr.instance:show("邀请码已复制")
end

function BuddyLuckyBagSharePrizeView:_onClickBtnShare()
	ShareController.instance:tryOpenFriendView(self._dataT)
end

return BuddyLuckyBagSharePrizeView
