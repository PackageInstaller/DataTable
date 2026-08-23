local ChatFriendCell = class("ChatFriendCell", require("app.fairyGUI.chat.UI_ChatFriendCell"))
local var_0_1 = g.core.model.User.chatData
local var_0_2 = g.core.network.GameNetProxy
local var_0_3 = g.core.common.ServerTime

function ChatFriendCell:ctor()
	self._isAnim = false
	self._data = nil
	self._uid = nil

	self.getSharedTrans(self, "listCrossbandAUiRightIn", "LongCellFromLeft", self)
	self:_addListener()
end

function ChatFriendCell:_addListener()
	self.m_showMoreBtn:addClickListener(handler(self, self._showMore))
	self.m_cancelBtn:addClickListener(handler(self, self._cancel))
	self.m_topBtn:addClickListener(handler(self, self._setTop))
	self.m_deleteBtn:addClickListener(handler(self, self._delete))
	self:addClickListener(handler(self, self._chat))
end

function ChatFriendCell:updateCell(arg_3_1)
	if self._isAnim then
		self._isAnim = false

		self:setScale(1, 1)
		self:setPosition(0, 0)
		self:setAlpha(1)
	end

	self._data = arg_3_1.data

	if self._data and self._data.receiver then
		self._uid = self._data.receiver
	elseif self._data and self._data.id then
		self._uid = self._data.id
	end

	local var_3_0 = clone(self._data)

	var_3_0.id = self._uid

	self.m_friendIcon:updateIcon(var_3_0)
	self.m_nameText:setText(self._data.name)
	self.m_isCrossServerController:setSelectedIndex(1)

	if self.m_serverName then
		self.m_serverName:initRaceTextParams({
			scrollDirection = 1,
			moveType = 1,
			playMode = 2,
			pauseTime = 0.5,
			duration = 3,
			title = self._data.server_name or ""
		})

		local var_3_1 = self.m_serverName:getContainerSize()
		local var_3_2 = self.m_serverName:getTextSize()

		self.m_serverName:setTitleAlign("left")

		if var_3_2.width > var_3_1.width then
			self.m_serverName:setMoveDistance(var_3_2.width - var_3_1.width)
			self.m_serverName:setStartPos(cc.p(0, self.m_serverName:getTextPosition().y))
		end

		self.m_serverName:play()
	end

	if self._data.content and self._data.content ~= "" then
		self.m_chatText:setText((g.core.utils.String.splitString((g.core.utils.Black:filterBlack(self._data.content)))))
	elseif self._data.look then
		local var_3_3 = tonumber(self._data.look)

		if var_3_3 > 0 then
			self.m_chatText:setText(g.core.lang:get(109049, {
				imgName = g.core.config.talk_show_info.get(var_3_3).name
			}))
		end
	end

	self.m_timeText:setText(var_0_3:getTimerBeforeDHM(self._data.time))
	self.m_isTopController:setSelectedIndex(var_0_1:getTopPrivateChat(self._uid) and 1 or 0)
end

function ChatFriendCell:_hideMore()
	self.m_backTransition:play(handler(self, function()
		self.m_showMoreController:setSelectedIndex(0)
	end))
end

function ChatFriendCell:_showMore()
	self.m_enterTransition:play(handler(self, function()
		self.m_showMoreController:setSelectedIndex(1)
	end))
end

function ChatFriendCell:_cancel()
	self.m_backTransition:play(handler(self, function()
		self.m_showMoreController:setSelectedIndex(0)
		var_0_1:deleteTopPrivateChat(self._uid)
		self:dispatchCompEvent("ChatFriendCell_cancelTop")
	end))
end

function ChatFriendCell:_setTop()
	self.m_backTransition:play(handler(self, function()
		self.m_showMoreController:setSelectedIndex(0)
		var_0_1:setTopPrivateChat(self._uid)
		self:dispatchCompEvent("ChatFriendCell_setTop")
	end))
end

function ChatFriendCell:_delete()
	self.m_showMoreController:setSelectedIndex(0)
	self.getSharedTrans(self, "t6", "LongCellFromLeft", self):play(handler(self, function()
		self._isAnim = true

		local var_13_0, var_13_1 = var_0_1:getPrivatePlayerInfoById(self._uid)

		var_0_2:send_C2S_Mail_Del({
			mail_type = var_13_0,
			id = var_13_1
		})
		var_0_1:deletePrivateChatPInfo(self._uid)
		var_0_1:deletePrivateFromCache(self._uid)
		var_0_1:setPrivateRedPointPlayerList(self._uid)
		self:dispatchCompEvent("ChatPrivateComp_DelChat")
	end))
end

function ChatFriendCell:_chat()
	if self.m_showMoreController:getSelectedIndex() == 1 then
		self:_hideMore()
	else
		var_0_1:setPrivatePlayer(self._data)
		var_0_1:changePrivateChatPInfo(self._data)
		var_0_1:savePrivate(self._uid, (var_0_1:getPrivateContent(self._uid)))
		var_0_1:setPrivateRedPointPlayerList(self._uid)
		self:dispatchCompEvent("ChatFriendCell_chat", self._data)
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.CHAT_CLICK_REFRESH_RED_POINT)
end

return ChatFriendCell
