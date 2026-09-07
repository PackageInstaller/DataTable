local PlayRoomNotificationLayer = class("PlayRoomNotificationLayer", import("..base.BaseUI"))

PlayRoomNotificationLayer.InitCount = 10
PlayRoomNotificationLayer.MaxCount = 100
PlayRoomNotificationLayer.FORM_COMMON = 0
PlayRoomNotificationLayer.FORM_BATTLE = 1
PlayRoomNotificationLayer.FORM_MAIN = 2
PlayRoomNotificationLayer.ChannelBits = {
	send = ChatConst.ChannelWorld,
	recv = IndexConst.Flags2Bits({
		ChatConst.ChannelAll
	})
}

function PlayRoomNotificationLayer:getUIName()
	return "IslandPlayRoomChatUI"
end

function PlayRoomNotificationLayer:init()
	self.settingsBtn = self.rtWindow:Find("top/settings")
	self.uiChannelList = UIItemList.New(self.rtWindow:Find("top/channels"), self.rtWindow:Find("top/channels/tpl"))
	self.sendChanncelBtn = self.rtWindow:Find("send_panel/channel_btn")
	self.sendChanncelTxt = self.rtWindow:Find("send_panel/channel_btn/Text"):GetComponent(typeof(Text))
	self.roomNumTxt = self.rtWindow:Find("top/settings/Text"):GetComponent(typeof(Text))
	self.scrollrect = self.rtWindow:Find("list/content"):GetComponent("LScrollRect")
	self.emojiBtn = self.rtWindow:Find("send_panel/input_panel/emoji")
	self.sendBtn = self.rtWindow:Find("send_panel/send_btn")
	self.inputField = self.rtWindow:Find("send_panel/input_panel/input"):GetComponent(typeof(InputField))
	self.uiSendChanncelList = UIItemList.New(self.rtWindow:Find("send_panel/channel_sel_panel"), self.rtWindow:Find("send_panel/channel_sel_panel/tpl"))
	self.channelValue = PlayRoomChatConst.CHANNEL_ALL
	self.sendChannelValue = PlayRoomChatConst.CHANNEL_PLAYROOM
	self.cards = {}

	self:InitChanncelToggles()
	self:InitSendChannelName()
	self:RegisterEvent()
	self:BlurPanel(self._tf)

	return
end

function PlayRoomNotificationLayer:RegisterEvent()
	onButton(self, self.rtBg, function()
		self:closeView()

		return
	end, SFX_CANCEL)
	onButton(self, self.settingsBtn, function()
		self:emit(BaseUI.ON_ADD_SUBLAYER, Context.New({
			mediator = PlayRoomChatSettingsMsgboxMediator,
			viewComponent = PlayRoomChatSettingsMsgboxLayer,
			data = {
				groupName = self:getGroupName(),
				settings = {
					sendChannelValue = self.sendChannelValue,
					channelValue = self.channelValue,
					title = i18n("island_chat_settings"),
					onYes = function(arg_6_0, arg_6_1, arg_6_2)
						self:OnSettingEnd(arg_6_0, arg_6_1, arg_6_2)

						return
					end
				}
			}
		}))

		return
	end, SFX_PANEL)
	onButton(self, self.emojiBtn, function()
		self:emit(PlayRoomNotificationMediator.OPEN_EMOJI, {
			emojiIconCallback = function(arg_8_0)
				self.inputField.text = self.inputField.text .. string.gsub(ChatConst.EmojiIconCode, "code", arg_8_0)

				return
			end,
			callback = function(arg_9_0)
				setInputText(self.inputField, "")
				self:emit(PlayRoomNotificationMediator.SEND_CHAT, self.sendChannelValue, string.gsub(ChatConst.EmojiCode, "code", arg_9_0))

				return
			end,
			pos = self.emojiBtn.position,
			groupName = self:getGroupName()
		})

		return
	end, SFX_PANEL)
	onButton(self, self.sendBtn, function()
		setInputText(self.inputField, "")
		self:emit(PlayRoomNotificationMediator.SEND_CHAT, self.sendChannelValue, self.inputField.text)

		return
	end, SFX_PANEL)
	onToggle(self, self.sendChanncelBtn, function(arg_11_0)
		if arg_11_0 then
			self:InitSendChannel()
		end

		return
	end, SFX_PANEL)

	function self.scrollrect.onInitItem(arg_12_0)
		self:OnInitItem(arg_12_0)

		return
	end

	function self.scrollrect.onUpdateItem(arg_13_0, arg_13_1)
		self:OnUpdateItem(arg_13_0, arg_13_1)

		return
	end

	return
end

function PlayRoomNotificationLayer:OnSettingEnd(arg_14_1, arg_14_2, arg_14_3)
	if self.sendChannelValue ~= arg_14_1 then
		self.sendChannelValue = arg_14_1

		self:InitSendChannelName()
	end

	if self.channelValue ~= arg_14_2 then
		self.channelValue = arg_14_2

		self:UpdateChannelToggles()
		self:Flush(false)
	end

	if self.chatRoomId ~= arg_14_3 then
		self:emit(PlayRoomNotificationMediator.CHANGE_CHAT_ROOM, arg_14_3)
	end

	return
end

function PlayRoomNotificationLayer:InitRoomNum()
	local var_15_0 = getProxy(PlayerProxy)
	local var_15_1 = var_15_0:getRawData().chatRoomId
	local var_15_2 = self.roomNumTxt
	local var_15_3 = var_15_1 == 0 and i18n("common_not_enter_room") or var_15_1

	var_15_2.text = var_15_0
	self.chatRoomId = var_15_1

	return
end

function PlayRoomNotificationLayer:InitSendChannel()
	local var_16_0 = PlayRoomChatConst.SEND_CHANNELS

	self.uiSendChanncelList:make(function(arg_17_0, arg_17_1, arg_17_2)
		if arg_17_0 == UIItemList.EventUpdate then
			local var_17_0 = var_16_0[arg_17_1 + 1]

			onButton(self, arg_17_2, function()
				if var_17_0 == PlayRoomChatConst.CHANNEL_GUILD then
					if getProxy(GuildProxy):getRawData() == nil then
						return
					end
				end

				self.sendChannelValue = var_17_0

				self:InitSendChannelName()
				triggerToggle(self.sendChanncelBtn, false)

				return
			end, SFX_PANEL)
			setText(arg_17_2:Find("Text"), setColorStr(PlayRoomChatConst.CHANNEL2CN(var_17_0), var_17_0 == self.sendChannelValue and "#5ccaff" or "#ffffff"))
		end

		return
	end)
	self.uiSendChanncelList:align(#PlayRoomChatConst.SEND_CHANNELS)

	return
end

function PlayRoomNotificationLayer:InitSendChannelName()
	self.sendChanncelTxt.text = PlayRoomChatConst.CHANNEL2CN(self.sendChannelValue)

	return
end

function PlayRoomNotificationLayer:InitChanncelToggles()
	local var_20_0 = PlayRoomChatConst.CHANNELS

	self.uiChannelList:make(function(arg_21_0, arg_21_1, arg_21_2)
		if arg_21_0 == UIItemList.EventUpdate then
			local var_21_0 = var_20_0[arg_21_1 + 1]

			onButton(self, arg_21_2, function()
				self:UpdatteChannelValue(var_21_0)
				self:Flush(false)

				return
			end, SFX_PANEL)
		end

		return
	end)
	self.uiChannelList:align(#PlayRoomChatConst.CHANNELS)
	self:UpdatteChannelValue(PlayRoomChatConst.CHANNEL_PLAYROOM)

	return
end

function PlayRoomNotificationLayer:UpdatteChannelValue(arg_23_1)
	if arg_23_1 == PlayRoomChatConst.CHANNEL_ALL then
		self.channelValue = PlayRoomChatConst.CHANNEL_ALL
	else
		self.channelValue = bit.band(self.channelValue, arg_23_1) > 0 and (self.channelValue == PlayRoomChatConst.CHANNEL_ALL and arg_23_1 or bit.bxor(self.channelValue, arg_23_1)) or bit.bor(self.channelValue, arg_23_1)

		if self.channelValue <= 0 then
			self.channelValue = PlayRoomChatConst.CHANNEL_ALL
		end
	end

	self:UpdateChannelToggles()

	return
end

function PlayRoomNotificationLayer:UpdateChannelToggles()
	local var_24_0 = PlayRoomChatConst.CHANNELS

	self.uiChannelList:eachActive(function(arg_25_0, arg_25_1)
		local var_25_0 = var_24_0[arg_25_0 + 1]
		local var_25_1 = self.channelValue == PlayRoomChatConst.CHANNEL_ALL
		local var_25_2 = var_24_0[arg_25_0 + 1] == PlayRoomChatConst.CHANNEL_ALL and var_25_1 or var_24_0[arg_25_0 + 1] ~= PlayRoomChatConst.CHANNEL_ALL and not var_25_1 and bit.band(self.channelValue, var_25_0) > 0

		setActive(arg_25_1:Find("sel"), var_25_2)
		setText(arg_25_1:Find("Text"), setColorStr(PlayRoomChatConst.CHANNEL2CN(var_25_0), var_25_2 and "#393a3c" or "#FFFFFF"))

		return
	end)

	return
end

function PlayRoomNotificationLayer:Flush(arg_26_1)
	self:InitChatMsg(arg_26_1)
	self:InitRoomNum()

	return
end

function PlayRoomNotificationLayer:InsertMsg(arg_27_1, arg_27_2)
	if getProxy(FriendProxy):isInBlackList(arg_27_2.playerId) then
		return
	end

	if arg_27_2.player and arg_27_2.content then
		table.insert(arg_27_1, arg_27_2)
	end

	return
end

function PlayRoomNotificationLayer:MatchChannel(arg_28_1)
	return bit.band(self.channelValue, arg_28_1) > 0
end

function PlayRoomNotificationLayer:InitChatMsg(arg_29_1)
	self.displays = {}

	if self:MatchChannel(PlayRoomChatConst.CHANNEL_WORLD) then
		_.each(getProxy(ChatProxy):getRawData(), function(arg_30_0)
			self:InsertMsg(self.displays, arg_30_0)

			return
		end)
	end

	if self:MatchChannel(PlayRoomChatConst.CHANNEL_GUILD) then
		local var_29_0 = getProxy(GuildProxy)

		if var_29_0:getRawData() then
			_.each(var_29_0:getChatMsgs(), function(arg_31_0)
				self:InsertMsg(self.displays, arg_31_0)

				return
			end)
		end
	end

	if self:MatchChannel(PlayRoomChatConst.CHANNEL_FRIEND) then
		_.each(getProxy(FriendProxy):getCacheMsgList(), function(arg_32_0)
			self:InsertMsg(self.displays, arg_32_0)

			return
		end)
	end

	if self:MatchChannel(PlayRoomChatConst.CHANNEL_PLAYROOM) then
		_.each(getProxy(PlayRoomProxy):GetChatMsgs(), function(arg_33_0)
			self:InsertMsg(self.displays, arg_33_0)

			return
		end)
	end

	table.sort(self.displays, function(arg_34_0, arg_34_1)
		return arg_34_0.timestamp < arg_34_1.timestamp
	end)
	onNextTick(function()
		self.scrollrect:SetTotalCount(#self.displays, arg_29_1 and 1 or -1)

		return
	end)

	return
end

function PlayRoomNotificationLayer:OnInitItem(arg_36_1)
	local var_36_0 = IslandChatCard.New(arg_36_1)

	onButton(self, var_36_0.otherBubble.tf, function()
		self:emit(PlayRoomNotificationMediator.OPEN_FRIEND_INFO, var_36_0.sender.id, var_36_0.otherBubble.circle.position, var_36_0.data.content)

		return
	end)

	self.cards[arg_36_1] = var_36_0

	return
end

function PlayRoomNotificationLayer:OnUpdateItem(arg_38_1, arg_38_2)
	if not self.cards[arg_38_2] then
		self:OnInitItem(arg_38_2)
	end

	self.cards[arg_38_2]:Update(self.displays[arg_38_1 + 1])

	return
end

function PlayRoomNotificationLayer:didEnter()
	self:Flush()

	return
end

function PlayRoomNotificationLayer:willExit()
	self:UnOverlayPanel(self._tf)
	ClearLScrollrect(self.scrollrect)

	return
end

return PlayRoomNotificationLayer
