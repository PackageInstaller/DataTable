local ChatPrivateComp = class("ChatPrivateComp", require("app.fairyGUI.chat.UI_ChatPrivateComp"))
local var_0_1 = g.core.const.ConstMgr.ChatConst
local var_0_2 = g.core.model.User.chatData
local var_0_3 = g.core.model.User.friendData
local var_0_4 = g.core.event.EventManager
local var_0_5 = g.core.module.ModuleManager

function ChatPrivateComp:ctor(arg_1_1)
	self._friendInfo = {}
	self._chatList = {}
	self._uid = nil
	self._useInfo = nil
	self._scrollPane = nil

	self:_initComp()
	self:_addListener()
end

function ChatPrivateComp:onLoad()
	self:_addNetWorkListener()
	self:updateComp()
end

function ChatPrivateComp:_initComp()
	self:_initData()
	self:_initUI()
end

function ChatPrivateComp:updateComp(arg_4_1, arg_4_2)
	if self.m_stateController:getSelectedIndex() == 1 then
		self:_updateChatList(arg_4_1, arg_4_2)
	else
		self:_updatePlayerList(true)
	end
end

function ChatPrivateComp:getChattingUid()
	return self._uid
end

function ChatPrivateComp:scrollToBottomWithOutAni()
	if #self._chatList > 0 then
		self._scrollPane:scrollBottom(false)
	end
end

function ChatPrivateComp:receiveCompEvent(arg_7_1)
	local var_7_0 = {
		...
	}

	if arg_7_1 == "ChatFriendCell_setTop" or arg_7_1 == "ChatFriendCell_cancelTop" then
		self:_updatePlayerList()
	elseif arg_7_1 == "ChatFriendCell_chat" and var_7_0[1] then
		self:changeToChat(var_7_0[1])

		return false
	end

	return false
end

function ChatPrivateComp:changeToChat(arg_8_1)
	self.m_stateController:setSelectedIndex(1)

	self._useInfo = arg_8_1

	self:_updateChatList()
end

function ChatPrivateComp:_initData()
	self._friendIndex = 0
	self._friendList = var_0_3:getRecommendList() or {}
	self._scrollPane = self.m_chatList:getScrollPane()
end

function ChatPrivateComp:_initUI()
	self:addListen(self.m_friendList)
	self:addListen(self.m_chatList)
	self.m_chatList:setVirtual()
	self.m_chatList:doFairyBatching(false)
	self.m_chatList:setItemProvider(handler(self, self._chatListProvider))
	self.m_chatList:setItemRenderer(handler(self, self._chatListRenderer))
	self.m_friendList:setVirtual()
	self.m_friendList:doFairyBatching(false)
	self.m_friendList:setItemRenderer(handler(self, self._onFriendListRenderer))
end

function ChatPrivateComp:_addListener()
	self.m_returnBtn:addClickListener(handler(self, self._onClickReturnBtn))
end

function ChatPrivateComp:_addNetWorkListener()
	var_0_4:addEventListener(g.core.event.enum.EVENT_NET_S2C_MAIL_DEL, handler(self, self._onrecvDeletMail), self)
	var_0_4:addEventListener(g.core.event.enum.EVENT_NET_S2C_FRIEND_ADDBLACKLIST, handler(self, self._onDelFriendSuc), self)
	var_0_4:addEventListener(g.core.event.enum.EVENT_NET_S2C_FRIEND_BLACKLIST, handler(self, self._onBlackFriendInfo), self)
	var_0_4:addEventListener(g.core.event.enum.EVENT_NET_S2C_MAIL_SEND, handler(self, self._recvChatPrivate), self)
	var_0_4:addEventListener(g.core.event.enum.EVENT_NET_S2C_MAIL_INFO, handler(self, self._recvChatInfoPrivate), self)
	var_0_4:addEventListener(g.core.event.enum.EVENT_TRANSLATE_FINISH_NOTIFY, handler(self, self._onTranslateFinish), self)
	var_0_4:addEventListener(g.core.event.enum.EVENT_NET_S2C_ANNIVERSARY_GETSHAREJIGSAW, handler(self, self._onTranslateFinish), self)
end

function ChatPrivateComp:_onTranslateFinish()
	if self._chatList then
		self.m_chatList:setNumItems(#self._chatList)
	end
end

function ChatPrivateComp:_chatListProvider(arg_14_1)
	if self._chatList[arg_14_1 + 1].showTime then
		return "ui://chat/ChatTimeCell"
	elseif string.format("%d", self._chatList[arg_14_1 + 1].user.id) == string.format("%d", g.core.model.User:getId()) then
		return "ui://chat/ChatRightCell"
	else
		return "ui://chat/ChatLeftCell"
	end
end

function ChatPrivateComp:_chatListRenderer(arg_15_1, arg_15_2)
	if arg_15_2 and arg_15_2.updateCell then
		arg_15_2:updateCell({
			data = self._chatList[arg_15_1 + 1]
		})
	end
end

function ChatPrivateComp:_onFriendListRenderer(arg_16_1, arg_16_2)
	arg_16_2:updateCell({
		data = self._friendInfo[arg_16_1 + 1]
	})
end

function ChatPrivateComp:_updateChatList(arg_17_1, arg_17_2)
	self._useInfo = self._useInfo or arg_17_2

	var_0_2:setPrivatePlayer(self._useInfo)

	self._uid = nil

	if self._useInfo and self._useInfo.receiver then
		self._uid = self._useInfo.receiver
	elseif self._useInfo and self._useInfo.id then
		self._uid = self._useInfo.id
	end

	self._chatList = arg_17_1 or var_0_2:getPrivateContent(self._uid)

	self.m_chatList:setNumItems(#self._chatList)
	self.m_nameText:setText(self._useInfo.name)
	self:scrollToBottomWithOutAni()
end

function ChatPrivateComp:_updatePlayerList(arg_18_1)
	local var_18_0 = var_0_2:getPrivateChatPInfo()

	self._friendInfo = var_18_0

	if #var_18_0 == 0 then
		self.m_isEmptyController:setSelectedIndex(1)
	else
		self.m_isEmptyController:setSelectedIndex(0)
		self.m_friendList:setNumItems(#var_18_0)

		if arg_18_1 then
			self.m_friendList:transitionShowCells("listCrossbandAUiRightIn")
		end
	end

	self._uid = nil
end

function ChatPrivateComp:_getSendPlayerId(arg_19_1)
	local var_19_0 = arg_19_1.mails[1].sender_id

	if arg_19_1.mails[1].keys and arg_19_1.mails[1].values then
		for iter_19_0, iter_19_1 in pairs(arg_19_1.mails[1].keys) do
			if iter_19_1 == "receiver" then
				var_19_0 = tonumber(arg_19_1.mails[1].values[iter_19_0])

				break
			end
		end
	end

	return var_19_0
end

function ChatPrivateComp:_onClickReturnBtn()
	self.m_stateController:setSelectedIndex(0)
	self:dispatchCompEvent("ChatPrivateComp_ChangeToFriend")
	self:_updatePlayerList(true)
end

function ChatPrivateComp:_onrecvDeletMail()
	self:_updatePlayerList()
end

function ChatPrivateComp:_onBlackFriendInfo(arg_22_1, arg_22_2, arg_22_3, arg_22_4)
	self:_updatePlayerList()
end

function ChatPrivateComp:_onDelFriendSuc(arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	var_0_2:setPrivateRedPointPlayerList(arg_23_4.id)
	self:dispatchCompEvent("ChatPrivateComp_DelChat")
end

function ChatPrivateComp:_recvChatPrivate(arg_24_1, arg_24_2, arg_24_3, arg_24_4)
	self:_updateChatList((var_0_2:getPrivateContent(arg_24_4.uid)))
	self._scrollPane:scrollBottom(true)
end

function ChatPrivateComp:_recvChatInfoPrivate(arg_25_1, arg_25_2, arg_25_3, arg_25_4)
	if not arg_25_4.mails or not self._uid then
		self:_updatePlayerList()

		return
	end

	local var_25_0 = self:_getSendPlayerId(arg_25_4)
	local var_25_1 = var_0_2:getPrivateContent(var_25_0)
	local var_25_2 = var_0_2:getSingleMailInfoContent(arg_25_4)

	if not math.uint64_equal(var_25_0, g.core.model.User:getId()) then
		if self._scrollPane:isBottomMost() then
			if math.uint64_equal(var_25_0, self._uid) then
				self:updateComp(var_25_1, var_25_2)
				self._scrollPane:scrollBottom(true)
				var_0_2:savePrivate(var_25_0, var_25_1)
			end
		elseif math.uint64_equal(var_25_0, self._uid) then
			self:updateComp(var_25_1, var_25_2)
			var_0_2:setUnreadInfo(var_0_1.SINGLE)
		end
	else
		self._scrollPane:scrollBottom(true)
	end
end

function ChatPrivateComp:_onPlayerInfoBack()
	local var_26_0 = var_0_3:getPlayerInfo()

	if var_0_2:isInBlackList(var_26_0.user.id) then
		var_0_5:tip(g.core.lang:get(109031))

		return
	end

	var_0_2:setPrivateChatPInfo(var_26_0.user)
	self:_updatePlayerList()
end

return ChatPrivateComp
