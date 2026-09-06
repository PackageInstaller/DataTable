-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/buddyluckybag/view/BuddyLuckyBagShareView.lua

module("logic.extensions.buddyluckybag.view.BuddyLuckyBagShareView", package.seeall)

local BuddyLuckyBagShareView = class("BuddyLuckyBagShareView", ViewComponent)

function BuddyLuckyBagShareView:buildUI()
	BuddyLuckyBagShareView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnChat = self:getGo("btnChat")
	self._btnCopy = self:getGo("btnCopy")
	self._btnShare = self:getGo("btnShare")
	self._txtCode = self:getTxt("code/txt")
end

function BuddyLuckyBagShareView:bindEvents()
	BuddyLuckyBagShareView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnChat, self._onClickBtnChat, self)
	GameUtil.addClickHandler(self._btnCopy, self._onClickBtnCopy, self)
	GameUtil.addClickHandler(self._btnShare, self._onClickBtnShare, self)
end

function BuddyLuckyBagShareView:unbindEvents()
	BuddyLuckyBagShareView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnChat)
	GameUtil.rmClickHandler(self._btnCopy)
	GameUtil.rmClickHandler(self._btnShare)
end

function BuddyLuckyBagShareView:onEnter()
	BuddyLuckyBagShareView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = BuddyLuckyBagController.instance:getActivityId()
	end

	self._subMo = BuddyLuckyBagController.instance:getSubMo(self._activityId)
	self._actData = BuddyLuckyBagConfig.instance:getActivityData(self._activityId)
	self._isHasShare = false

	self:_onUpdate()
	self.addGEvent(self, GlobalNotify.HandlePM_BuddyLuckyBagGetInfoRes, self._onUpdate, self)
end

function BuddyLuckyBagShareView:onExit()
	BuddyLuckyBagShareView.super.onExit(self)
end

function BuddyLuckyBagShareView:_onUpdate()
	self._txtCode.text = self._subMo:getMyCode()

	GameUtil.SetGray(self._btnChat, self._isHasShare)
end

function BuddyLuckyBagShareView:_onClickBtnChat()
	if self._isHasShare then
		FloatWordMgr.instance:show("已分享")

		return
	end

	local activityId = self._activityId
	local inviteCode = self._subMo:getMyCode()
	local templateId = self._actData.templateId
	local dataT = {
		tpId = templateId,
		params = {
			activityId = activityId,
			inviteCode = inviteCode
		}
	}
	local content = GameUtil.jsonToString(dataT)

	ChatAgent.instance:sendSendMsgReq(GameEnum.ChatChannel.Share, GameEnum.ChatType.System, content)

	self._isHasShare = true

	GameUtil.SetGray(self._btnChat, self._isHasShare)
end

function BuddyLuckyBagShareView:_onClickBtnCopy()
	local content = self._subMo:getMyCode()

	if Framework.OSDef.isEditor then
		Game.TextUtil.CopyToClipBoard(content)
	else
		Clipboard.copy(content)
	end

	FloatWordMgr.instance:show("邀请码已复制")
end

function BuddyLuckyBagShareView:_onClickBtnShare()
	local activityId = self._activityId
	local code = self._subMo:getMyCode()
	local templateId = self._actData.templateId
	local dataT = {
		tpId = templateId,
		params = {
			activityId = activityId,
			inviteCode = code
		}
	}

	ShareController.instance:tryOpenFriendView(dataT)
end

return BuddyLuckyBagShareView
