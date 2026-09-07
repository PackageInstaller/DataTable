local IslandChatSettingsMsgboxWindow = class("IslandChatSettingsMsgboxWindow", import(".IslandCommonMsgboxWindow"))

function IslandChatSettingsMsgboxWindow:getUIName()
	return "IslandChatSettingsMsgBox"
end

function IslandChatSettingsMsgboxWindow:OnLoaded()
	IslandChatSettingsMsgboxWindow.super.OnLoaded(self)

	self.uiSendChanncelList = UIItemList.New(self._tf:Find("send_channel/list"), self._tf:Find("send_channel/list/tpl"))
	self.uiChanncelList = UIItemList.New(self._tf:Find("channels/list"), self._tf:Find("send_channel/list/tpl"))
	self.roomInput = self._tf:Find("room/room")

	setText(self._tf:Find("send_channel/Text"), i18n("notice_label_send"))
	setText(self._tf:Find("channels/Text"), i18n("notice_label_recv"))
	setText(self._tf:Find("room/Text"), i18n("notice_label_room"))
	setText(self._tf:Find("room/tip"), i18n("notice_label_tip"))
	self:InitSendChannel()
	self:InitChannels()

	return
end

function IslandChatSettingsMsgboxWindow:OnInit()
	IslandChatSettingsMsgboxWindow.super.OnInit(self)
	onButton(self, self.confirmBtn, function()
		if self.onYes then
			self.onYes(self.sendChannelValue, self.channelValue, tonumber((getInputText(self.roomInput))))
		end

		self:Hide()

		return
	end, SFX_PANEL)

	return
end

function IslandChatSettingsMsgboxWindow:OnShow()
	IslandChatSettingsMsgboxWindow.super.OnShow(self)

	self.sendChannelValue = self.settings.sendChannelValue
	self.channelValue = self.settings.channelValue

	self:FlushSendChannel()
	self:FlushChannels()
	self:FlushRoom()

	return
end

function IslandChatSettingsMsgboxWindow:InitSendChannel()
	local var_6_0 = IslandChatConst.SEND_CHANNELS

	self.uiSendChanncelList:make(function(arg_7_0, arg_7_1, arg_7_2)
		if arg_7_0 == UIItemList.EventUpdate then
			local var_7_0 = var_6_0[arg_7_1 + 1]

			onButton(self, arg_7_2, function()
				if var_7_0 == IslandChatConst.CHANNEL_GUILD then
					if getProxy(GuildProxy):getRawData() == nil then
						return
					end
				end

				self.sendChannelValue = var_7_0

				self:FlushSendChannel()

				return
			end, SFX_PANEL)
			setActive(arg_7_2:Find("line"), #var_6_0 ~= arg_7_1 + 1)
		end

		return
	end)
	self.uiSendChanncelList:align(#IslandChatConst.SEND_CHANNELS)

	return
end

function IslandChatSettingsMsgboxWindow:InitChannels()
	local var_9_0 = IslandChatConst.CHANNELS

	self.uiChanncelList:make(function(arg_10_0, arg_10_1, arg_10_2)
		if arg_10_0 == UIItemList.EventUpdate then
			local var_10_0 = var_9_0[arg_10_1 + 1]

			onButton(self, arg_10_2, function()
				self:UpdatteChannelValue(var_10_0)
				self:FlushChannels()

				return
			end, SFX_PANEL)
			setActive(arg_10_2:Find("line"), not (#var_9_0 == arg_10_1 + 1) and not ((arg_10_1 + 1) % 3 == 0))
		end

		return
	end)
	self.uiChanncelList:align(#IslandChatConst.CHANNELS)

	return
end

function IslandChatSettingsMsgboxWindow:FlushSendChannel()
	local var_12_0 = IslandChatConst.SEND_CHANNELS

	self.uiSendChanncelList:eachActive(function(arg_13_0, arg_13_1)
		local var_13_0 = var_12_0[arg_13_0 + 1]
		local var_13_1 = var_12_0[arg_13_0 + 1] == self.sendChannelValue

		setActive(arg_13_1:Find("mark"), var_12_0[arg_13_0 + 1] == self.sendChannelValue)
		setText(arg_13_1:Find("Text"), setColorStr(IslandChatConst.CHANNEL2CN(var_13_0), var_13_1 and "#FFFFFF" or "#393a3c"))

		return
	end)

	return
end

function IslandChatSettingsMsgboxWindow:FlushChannels()
	local var_14_0 = IslandChatConst.CHANNELS

	self.uiChanncelList:eachActive(function(arg_15_0, arg_15_1)
		local var_15_0 = var_14_0[arg_15_0 + 1]
		local var_15_1 = self.channelValue == IslandChatConst.CHANNEL_ALL
		local var_15_2 = var_14_0[arg_15_0 + 1] == IslandChatConst.CHANNEL_ALL and var_15_1 or var_14_0[arg_15_0 + 1] ~= IslandChatConst.CHANNEL_ALL and not var_15_1 and bit.band(self.channelValue, var_15_0) > 0

		setActive(arg_15_1:Find("mark"), var_15_2)
		setText(arg_15_1:Find("Text"), setColorStr(IslandChatConst.CHANNEL2CN(var_15_0), var_15_2 and "#FFFFFF" or "#393a3c"))

		return
	end)

	return
end

function IslandChatSettingsMsgboxWindow:FlushRoom()
	setInputText(self.roomInput, getProxy(PlayerProxy):getRawData().chatRoomId)

	return
end

function IslandChatSettingsMsgboxWindow:UpdatteChannelValue(arg_17_1)
	if arg_17_1 == IslandChatConst.CHANNEL_ALL then
		self.channelValue = IslandChatConst.CHANNEL_ALL
	else
		self.channelValue = bit.band(self.channelValue, arg_17_1) > 0 and (self.channelValue == IslandChatConst.CHANNEL_ALL and arg_17_1 or bit.bxor(self.channelValue, arg_17_1)) or bit.bor(self.channelValue, arg_17_1)

		if self.channelValue <= 0 then
			self.channelValue = IslandChatConst.CHANNEL_ALL
		end
	end

	return
end

return IslandChatSettingsMsgboxWindow
