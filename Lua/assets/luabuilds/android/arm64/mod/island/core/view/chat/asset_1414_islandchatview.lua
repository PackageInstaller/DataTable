local IslandChatView = class("IslandChatView", import("..IslandASynLoadSubView"))

function IslandChatView:Ctor(arg_1_1, arg_1_2)
	IslandChatView.super.Ctor(self, arg_1_1)

	self.parent = arg_1_2

	return
end

function IslandChatView:GetUIName()
	return "IslandChatUI"
end

function IslandChatView:GetUIParent(arg_3_1)
	return self.parent
end

function IslandChatView:FirstFlush()
	self.settingsBtn = self._tf:Find("top/settings")
	self.uiChannelList = UIItemList.New(self._tf:Find("top/channels"), self._tf:Find("top/channels/tpl"))
	self.sendChanncelBtn = self._tf:Find("send_panel/channel_btn")
	self.sendChanncelTxt = self._tf:Find("send_panel/channel_btn/Text"):GetComponent(typeof(Text))
	self.roomNumTxt = self._tf:Find("top/settings/Text"):GetComponent(typeof(Text))
	self.scrollrect = self._tf:Find("list"):GetComponent("LScrollRect")
	self.emojiBtn = self._tf:Find("send_panel/input_panel/emoji")
	self.sendBtn = self._tf:Find("send_panel/send_btn")
	self.inputField = self._tf:Find("send_panel/input_panel/input"):GetComponent(typeof(InputField))
	self.uiSendChanncelList = UIItemList.New(self._tf:Find("send_panel/channel_sel_panel"), self._tf:Find("send_panel/channel_sel_panel/tpl"))
	self.channelValue = IslandChatConst.CHANNEL_ALL
	self.sendChannelValue = IslandChatConst.CHANNEL_ISLAND
	self.cards = {}
	self.emojiAdaptor = IslandEmojiAdaptor.New(self)

	self:InitChanncelToggles()
	self:InitSendChannelName()
	self:RegisterEvent()

	return
end

function IslandChatView:RegisterEvent()
	onButton(self, self.settingsBtn, function()
		self:ShowMsgbox({
			type = IslandMsgBox.TYPE_CHAT_SETTINGS,
			sendChannelValue = self.sendChannelValue,
			channelValue = self.channelValue,
			title = i18n("island_chat_settings"),
			onYes = function(arg_7_0, arg_7_1, arg_7_2)
				self:OnSettingEnd(arg_7_0, arg_7_1, arg_7_2)

				return
			end
		})

		return
	end, SFX_PANEL)
	onButton(self, self.emojiBtn, function()
		self.emojiAdaptor:Init({
			emojiIconCallback = function(arg_9_0)
				self.inputField.text = self.inputField.text .. string.gsub(ChatConst.EmojiIconCode, "code", arg_9_0)

				return
			end,
			callback = function(arg_10_0)
				setInputText(self.inputField, "")
				self:NotifiyMeditor(IslandBaseMediator.SEND_CHAT, self.sendChannelValue, string.gsub(ChatConst.EmojiCode, "code", arg_10_0))

				return
			end,
			pos = self.emojiBtn.position
		})

		return
	end, SFX_PANEL)
	onButton(self, self.sendBtn, function()
		setInputText(self.inputField, "")
		self:NotifiyMeditor(IslandBaseMediator.SEND_CHAT, self.sendChannelValue, self.inputField.text)

		return
	end, SFX_PANEL)
	onToggle(self, self.sendChanncelBtn, function(arg_12_0)
		if arg_12_0 then
			self:InitSendChannel()
		end

		return
	end, SFX_PANEL)

	function self.scrollrect.onInitItem(arg_13_0)
		self:OnInitItem(arg_13_0)

		return
	end

	function self.scrollrect.onUpdateItem(arg_14_0, arg_14_1)
		self:OnUpdateItem(arg_14_0, arg_14_1)

		return
	end

	return
end

function IslandChatView:OnSettingEnd(arg_15_1, arg_15_2, arg_15_3)
	if self.sendChannelValue ~= arg_15_1 then
		self.sendChannelValue = arg_15_1

		self:InitSendChannelName()
	end

	if self.channelValue ~= arg_15_2 then
		self.channelValue = arg_15_2

		self:UpdateChannelToggles()
		self:Flush(false)
	end

	if self.chatRoomId ~= arg_15_3 then
		self:NotifiyMeditor(IslandBaseMediator.CHANGE_CHAT_ROOM, arg_15_3)
	end

	return
end

function IslandChatView:InitRoomNum()
	local var_16_0 = getProxy(PlayerProxy)
	local var_16_1 = var_16_0:getRawData().chatRoomId
	local var_16_2 = self.roomNumTxt
	local var_16_3 = var_16_1 == 0 and i18n("common_not_enter_room") or var_16_1

	var_16_2.text = var_16_0
	self.chatRoomId = var_16_1

	return
end

function IslandChatView:InitSendChannel()
	local var_17_0 = IslandChatConst.SEND_CHANNELS

	self.uiSendChanncelList:make(function(arg_18_0, arg_18_1, arg_18_2)
		if arg_18_0 == UIItemList.EventUpdate then
			local var_18_0 = var_17_0[arg_18_1 + 1]

			onButton(self, arg_18_2, function()
				if var_18_0 == IslandChatConst.CHANNEL_GUILD then
					if getProxy(GuildProxy):getRawData() == nil then
						return
					end
				end

				self.sendChannelValue = var_18_0

				self:InitSendChannelName()
				triggerToggle(self.sendChanncelBtn, false)

				return
			end, SFX_PANEL)
			setText(arg_18_2:Find("Text"), setColorStr(IslandChatConst.CHANNEL2CN(var_18_0), var_18_0 == self.sendChannelValue and "#5ccaff" or "#ffffff"))
		end

		return
	end)
	self.uiSendChanncelList:align(#IslandChatConst.SEND_CHANNELS)

	return
end

function IslandChatView:InitSendChannelName()
	self.sendChanncelTxt.text = IslandChatConst.CHANNEL2CN(self.sendChannelValue)

	return
end

function IslandChatView:InitChanncelToggles()
	local var_21_0 = IslandChatConst.CHANNELS

	self.uiChannelList:make(function(arg_22_0, arg_22_1, arg_22_2)
		if arg_22_0 == UIItemList.EventUpdate then
			local var_22_0 = var_21_0[arg_22_1 + 1]

			onButton(self, arg_22_2, function()
				self:UpdatteChannelValue(var_22_0)
				self:Flush(false)

				return
			end, SFX_PANEL)
		end

		return
	end)
	self.uiChannelList:align(#IslandChatConst.CHANNELS)
	self:UpdatteChannelValue(self.channelValue)

	return
end

function IslandChatView:UpdatteChannelValue(arg_24_1)
	if arg_24_1 == IslandChatConst.CHANNEL_ALL then
		self.channelValue = IslandChatConst.CHANNEL_ALL
	else
		self.channelValue = bit.band(self.channelValue, arg_24_1) > 0 and (self.channelValue == IslandChatConst.CHANNEL_ALL and arg_24_1 or bit.bxor(self.channelValue, arg_24_1)) or bit.bor(self.channelValue, arg_24_1)

		if self.channelValue <= 0 then
			self.channelValue = IslandChatConst.CHANNEL_ALL
		end
	end

	self:UpdateChannelToggles()

	return
end

function IslandChatView:UpdateChannelToggles()
	local var_25_0 = IslandChatConst.CHANNELS

	self.uiChannelList:eachActive(function(arg_26_0, arg_26_1)
		local var_26_0 = var_25_0[arg_26_0 + 1]
		local var_26_1 = self.channelValue == IslandChatConst.CHANNEL_ALL
		local var_26_2 = var_25_0[arg_26_0 + 1] == IslandChatConst.CHANNEL_ALL and var_26_1 or var_25_0[arg_26_0 + 1] ~= IslandChatConst.CHANNEL_ALL and not var_26_1 and bit.band(self.channelValue, var_26_0) > 0

		setActive(arg_26_1:Find("sel"), var_26_2)
		setText(arg_26_1:Find("Text"), setColorStr(IslandChatConst.CHANNEL2CN(var_26_0), var_26_2 and "#393a3c" or "#FFFFFF"))

		return
	end)

	return
end

function IslandChatView:Flush(arg_27_1)
	self:InitChatMsg(arg_27_1)
	self:InitRoomNum()

	return
end

function IslandChatView:InsertMsg(arg_28_1, arg_28_2)
	if getProxy(FriendProxy):isInBlackList(arg_28_2.playerId) then
		return
	end

	if arg_28_2.player and arg_28_2.content then
		table.insert(arg_28_1, arg_28_2)
	end

	return
end

function IslandChatView:MatchChannel(arg_29_1)
	return bit.band(self.channelValue, arg_29_1) > 0
end

function IslandChatView:InitChatMsg(arg_30_1)
	self.displays = {}

	if self:MatchChannel(IslandChatConst.CHANNEL_WORLD) then
		_.each(getProxy(ChatProxy):getRawData(), function(arg_31_0)
			self:InsertMsg(self.displays, arg_31_0)

			return
		end)
	end

	if self:MatchChannel(IslandChatConst.CHANNEL_GUILD) then
		local var_30_0 = getProxy(GuildProxy)

		if var_30_0:getRawData() then
			_.each(var_30_0:getChatMsgs(), function(arg_32_0)
				self:InsertMsg(self.displays, arg_32_0)

				return
			end)
		end
	end

	if self:MatchChannel(IslandChatConst.CHANNEL_FRIEND) then
		_.each(getProxy(FriendProxy):getCacheMsgList(), function(arg_33_0)
			self:InsertMsg(self.displays, arg_33_0)

			return
		end)
	end

	if self:MatchChannel(IslandChatConst.CHANNEL_ISLAND) then
		_.each(getProxy(IslandProxy):GetChatMsgList(self:GetView():GetIsland().id), function(arg_34_0)
			self:InsertMsg(self.displays, arg_34_0)

			return
		end)
	end

	table.sort(self.displays, function(arg_35_0, arg_35_1)
		return arg_35_0.timestamp < arg_35_1.timestamp
	end)
	self.scrollrect:SetTotalCount(#self.displays, arg_30_1 and 1 or -1)

	return
end

function IslandChatView:OnInitItem(arg_36_1)
	local var_36_0 = IslandChatCard.New(arg_36_1)

	onButton(self, var_36_0.otherBubble.tf, function()
		self:NotifiyMeditor(IslandBaseMediator.OPEN_FRIEND_INFO, var_36_0.sender.id, var_36_0.otherBubble.circle.position, var_36_0.data.content)

		return
	end)
	onButton(self, var_36_0.otherBubble.tf:Find("chat_fram"), function()
		if var_36_0:IsTradeLink() then
			self:NotifiyMeditor(IslandMediator.ENTER_ISLAND, var_36_0.sender.id)
		else
			triggerButton(var_36_0.otherBubble.tf)
		end

		return
	end)

	self.cards[arg_36_1] = var_36_0

	return
end

function IslandChatView:OnUpdateItem(arg_39_1, arg_39_2)
	if not self.cards[arg_39_2] then
		self:OnInitItem(arg_39_2)
	end

	self.cards[arg_39_2]:Update(self.displays[arg_39_1 + 1])

	return
end

function IslandChatView:OnDispose()
	IslandChatView.super.OnDispose(self)
	ClearLScrollrect(self.scrollrect)

	if self.emojiAdaptor then
		self.emojiAdaptor:Dispose()

		self.emojiAdaptor = nil
	end

	return
end

return IslandChatView
