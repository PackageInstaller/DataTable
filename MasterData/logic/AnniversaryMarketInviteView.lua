-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/anniversarymarket/view/AnniversaryMarketInviteView.lua

module("logic.extensions.anniversarymarket.view.AnniversaryMarketInviteView", package.seeall)

local AnniversaryMarketInviteView = class("AnniversaryMarketInviteView", FriendSelectView)
local INVITE_CD_TIME = 30

function AnniversaryMarketInviteView:onEnter()
	AnniversaryMarketInviteView.super.onEnter(self)

	self._curViewDatas = {}
	self._openParam = self:getOpenParam() or {}

	local friendData = FriendModel.instance:getGroupDatas(GameEnum.FriendGroup.Friend)

	self._curViewDatas = self:_getCurOnlineDatas(friendData)

	table.sort(self._curViewDatas, AnniversaryMarketInviteView._sortFriends)

	self._friendIds = {}

	self:reloadData()
	goutil.setActive(self._emptyTips, #self._curViewDatas == 0)

	self._selectedCount = 0
	self._maxCount = checknumber(self._openParam[2])

	if self._maxCount <= 0 then
		self._maxCount = FriendConfig.instance:getCommonValue("MAX_BATCH_SEND_TO_BUDDY__CLIENT_COUNT", true)
	end

	self._titleStr = self._openParam[3] or lang("请选择好友进行展示")

	self:_updateTitle()
end

function AnniversaryMarketInviteView:_getCurOnlineDatas(friendData)
	local onlineDatas = {}

	for _, friend in pairs(friendData) do
		if friend:getIsOnline() then
			table.insert(onlineDatas, friend)
		end
	end

	return onlineDatas
end

function AnniversaryMarketInviteView:_onClickSend()
	local t = {}

	for k, v in pairs(self._friendIds) do
		if v == true then
			table.insert(t, k)
		end
	end

	if #t == 0 then
		FloatWordMgr.instance:show("选中至少一名好友进行发送")
	else
		GlobalDispatcher:dispatch(GlobalNotify.FriendSelected, t)
		AnniversaryMarketController.instance:setInviteCdTime(INVITE_CD_TIME)
		AnniversaryMarketController.instance:beginIniteCdTime()
		self:close()
	end
end

return AnniversaryMarketInviteView
