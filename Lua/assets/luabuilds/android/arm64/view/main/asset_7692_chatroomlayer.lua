local ChatRoomLayer = class("ChatRoomLayer", import("..base.BaseUI"))

function ChatRoomLayer:getUIName()
	return "ChatRoomUI"
end

function ChatRoomLayer:setFriendVO(arg_2_1)
	self.friendVO = arg_2_1

	return
end

function ChatRoomLayer:setFriends(arg_3_1)
	self.friendVOs = arg_3_1

	return
end

function ChatRoomLayer:setPlayer(arg_4_1)
	self.playerVO = arg_4_1

	return
end

function ChatRoomLayer:setCacheMsgs(arg_5_1)
	self.cacheMsgsVOs = arg_5_1

	return
end

function ChatRoomLayer:init()
	self.frame = self._tf:Find("frame")
	self.friendView = self.frame:Find("left_length/scrollView")
	self.chatPanel = self.frame:Find("notification_panel")
	self.chatPanelTitle = self.frame:Find("notification_panel/frame/top/name")
	self.sendBtn = self.chatPanel:Find("frame/bottom/send")
	self.inputTF = self.chatPanel:Find("frame/bottom/input")
	self.chatsRect = self.chatPanel:Find("frame/list")
	self.chatsContainer = self.chatPanel:Find("frame/list/content")
	self.closeBtn = self._tf:Find("frame/notification_panel/frame/top/close_btn")
	self.otherPopTpl = self:getTpl("frame/list/popo_other", self.chatPanel)
	self.selfPopTpl = self:getTpl("frame/list/popo_self", self.chatPanel)

	self:BlurPanel(self.frame)

	return
end

function ChatRoomLayer:didEnter()
	local var_7_0 = self.chatPanel:Find("frame/bottom/emoji")

	onButton(self, var_7_0, function()
		self:emit(ChatRoomMediator.OPEN_EMOJI, Vector3(var_7_0.position.x, var_7_0.position.y, 0), function(arg_9_0)
			self:sendMessage(string.gsub(ChatConst.EmojiCode, "code", arg_9_0))

			return
		end)

		return
	end, SFX_PANEL)
	onButton(self, self._tf, function()
		self:emit(ChatRoomLayer.ON_CLOSE)

		return
	end, SOUND_BACK)
	onButton(self, self.closeBtn, function()
		self:emit(ChatRoomLayer.ON_CLOSE)

		return
	end, SOUND_BACK)
	self:initFriends()

	return
end

function ChatRoomLayer:initFriends()
	self.friendItems = {}
	self.friendRect = self.friendView:GetComponent("LScrollRect")

	function self.friendRect.onInitItem(arg_13_0)
		self:initFriend(arg_13_0)

		return
	end

	function self.friendRect.onUpdateItem(arg_14_0, arg_14_1)
		self:updateFriend(arg_14_0, arg_14_1)

		return
	end

	self:sortFriend()

	return
end

function ChatRoomLayer:createFriendItem(arg_15_1)
	local var_15_0 = {
		tf = tf(arg_15_1)
	}

	var_15_0.nameTF = var_15_0.tf:Find("name"):GetComponent(typeof(Text))
	var_15_0.iconTF = var_15_0.tf:Find("shipicon/icon"):GetComponent(typeof(Image))
	var_15_0.circle = var_15_0.tf:Find("shipicon/frame")
	var_15_0.toggle = var_15_0.tf:GetComponent(typeof(Toggle))
	var_15_0.tipTF = var_15_0.tf:Find("tip")
	var_15_0.dateTF = var_15_0.tf:Find("lv_bg/date"):GetComponent(typeof(Text))
	var_15_0.onlineTF = var_15_0.tf:Find("lv_bg/online")
	var_15_0.levelTF = var_15_0.tf:Find("lv_bg/Text"):GetComponent(typeof(Text))

	local var_15_1 = self.friendVO

	function var_15_0:update(arg_16_1, arg_16_2)
		self:clear()
		setActive(var_15_0.tipTF, false)

		self.friendVO = arg_16_1
		var_15_0.nameTF.text = arg_16_1.name
		var_15_0.levelTF.text = "LV." .. arg_16_1.level

		assert(pg.ship_data_statistics[arg_16_1.icon], "shipCfg is nil >> id ==" .. arg_16_1.icon)
		LoadSpriteAsync("qicon/" .. Ship.New({
			configId = arg_16_1.icon,
			skin_id = arg_16_1.skinId
		}):getPainting(), function(arg_17_0)
			var_15_0.iconTF.sprite = not arg_17_0 and GetSpriteFromAtlas("heroicon/unknown", "") or arg_17_0

			return
		end)

		local var_16_0 = AttireFrame.attireFrameRes(arg_16_1, arg_16_1.id == getProxy(PlayerProxy):getRawData().id, AttireConst.TYPE_ICON_FRAME, arg_16_1.propose)

		PoolMgr.GetInstance():GetPrefab("IconFrame/" .. var_16_0, var_16_0, true, function(arg_18_0)
			if self.circle then
				arg_18_0.name = var_16_0
				findTF(arg_18_0.transform, "icon"):GetComponent(typeof(Image)).raycastTarget = false

				setParent(arg_18_0, self.circle, false)
			else
				PoolMgr.GetInstance():ReturnPrefab("IconFrame/" .. var_16_0, var_16_0, arg_18_0)
			end

			return
		end)

		if var_15_1.id == arg_16_1.id and var_15_0.toggle.isOn == false then
			triggerToggle(var_15_0.tf, true)
		end

		setActive(self.onlineTF, arg_16_1.online == Friend.ONLINE)
		setActive(var_15_0.dateTF, arg_16_1.online == Friend.OFFLINE)

		var_15_0.dateTF.text = pg.TimeMgr.GetInstance():STimeDescC(arg_16_1.preOnLineTime, "%Y/%m/%d")

		return
	end

	function var_15_0:clear()
		if self.circle.childCount > 0 then
			local var_19_0 = self.circle:GetChild(0).gameObject

			PoolMgr.GetInstance():ReturnPrefab("IconFrame/" .. var_19_0.name, var_19_0.name, var_19_0)
		end

		return
	end

	function var_15_0:dispose()
		self:clear()

		return
	end

	return var_15_0
end

function ChatRoomLayer:updateFriend(arg_21_1, arg_21_2)
	if not self.friendItems[arg_21_2] then
		self:initFriend(arg_21_2)
	end

	self.friendItems[arg_21_2]:update(self.friendVOs[arg_21_1 + 1])

	return
end

function ChatRoomLayer:initFriend(arg_22_1)
	local var_22_0 = self:createFriendItem(arg_22_1)

	onToggle(self, var_22_0.tf, function(arg_23_0)
		if arg_23_0 and var_22_0.friendVO then
			self:openChatPanel(var_22_0.friendVO)

			self.contextData.friendVO = var_22_0.friendVO

			self:setFriendVO(var_22_0.friendVO)
			self:emit(ChatRoomMediator.CLEAR_UNREADCOUNT, var_22_0.friendVO.id)
		end

		return
	end)

	self.friendItems[arg_22_1] = var_22_0

	return
end

function ChatRoomLayer:updateFriendVO(arg_24_1)
	for iter_24_0, iter_24_1 in ipairs(self.friendVOs) do
		if iter_24_1.id == arg_24_1.id then
			self.friendVOs[iter_24_0] = arg_24_1

			break
		end
	end

	if arg_24_1.id == self.friendVO.id then
		self.friendVO = arg_24_1
	end

	self:sortFriend()

	return
end

function ChatRoomLayer:sortFriend()
	table.sort(self.friendVOs, function(arg_26_0, arg_26_1)
		local var_26_0 = arg_26_0.id == self.friendVO.id and 1 or 0
		local var_26_1 = arg_26_1.id == self.friendVO.id and 1 or 0

		if (arg_26_0.id == self.friendVO.id and 1 or 0) == (arg_26_1.id == self.friendVO.id and 1 or 0) then
			if arg_26_0.online == arg_26_1.online then
				if arg_26_0.level == arg_26_1.level then
					return arg_26_0.id < arg_26_1.id
				else
					return arg_26_0.level > arg_26_1.level
				end
			else
				return arg_26_0.online > arg_26_1.online
			end
		else
			return var_26_1 < var_26_0
		end

		return
	end)
	self.friendRect:SetTotalCount(#self.friendVOs, -1)

	return
end

function ChatRoomLayer:openChatPanel(arg_27_1)
	self.friendVO = arg_27_1

	removeAllChildren(self.chatsContainer)

	for iter_27_0, iter_27_1 in pairs(self.cacheMsgsVOs[arg_27_1.id] or {}) do
		self:appendMsg(iter_27_1)
	end

	setText(self.chatPanelTitle, self.friendVO.name)
	setActive(self.chatPanel, true)
	onButton(self, self.sendBtn, function()
		setInputText(self.inputTF, "")
		self:sendMessage((getInputText(self.inputTF)))

		return
	end)

	return
end

function ChatRoomLayer:sendMessage(arg_29_1)
	if arg_29_1 == "" then
		pg.TipsMgr.GetInstance():ShowTips(i18n("friend_send_msg_null_tip"))

		return
	end

	self:emit(ChatRoomMediator.SEND_FRIEND_MSG, self.friendVO.id, arg_29_1)

	return
end

function ChatRoomLayer:getPlayer(arg_30_1)
	if arg_30_1 == self.playerVO.id then
		return self.playerVO
	end

	for iter_30_0, iter_30_1 in ipairs(self.friendVOs) do
		if iter_30_1.id == arg_30_1 then
			return iter_30_1
		end
	end

	return
end

function ChatRoomLayer:appendMsg(arg_31_1)
	if arg_31_1.playerId ~= self.playerVO.id and arg_31_1.playerId ~= self.friendVO.id then
		return
	end

	self:emit(ChatRoomMediator.CLEAR_UNREADCOUNT, self.friendVO.id)

	local var_31_0 = self.otherPopTpl

	if arg_31_1.playerId == self.playerVO.id then
		var_31_0 = self.selfPopTpl
		arg_31_1.player = setmetatable(Clone(self.playerVO), {
			__index = self:getPlayer(arg_31_1.playerId)
		})
		arg_31_1.isSelf = true
	end

	ChatRoomBubble.New((cloneTplTo(var_31_0, self.chatsContainer))):update(arg_31_1)
	scrollToBottom(self.chatsRect)

	return
end

function ChatRoomLayer:closeChatPanel()
	setActive(self.chatPanel, false)

	return
end

function ChatRoomLayer:willExit()
	self:UnOverlayPanel(self.frame, self._tf)
	eachChild(self.chatsContainer, function(arg_34_0)
		local var_34_0 = arg_34_0:Find("face")

		if var_34_0.childCount > 0 then
			local var_34_1 = var_34_0:GetChild(0).gameObject

			PoolMgr.GetInstance():ReturnPrefab("emoji/" .. var_34_1.name, var_34_1.name, var_34_1)
		end

		return
	end)

	for iter_33_0, iter_33_1 in pairs(self.friendItems) do
		iter_33_1:dispose()
	end

	return
end

function ChatRoomLayer:insertEmojiToInputText(arg_35_1)
	setInputText(self.inputTF, getInputText(self.inputTF) .. string.gsub(ChatConst.EmojiIconCode, "code", arg_35_1))

	return
end

return ChatRoomLayer
