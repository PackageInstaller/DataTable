local PlayRoomChatSettingsMsgboxLayer = class("PlayRoomChatSettingsMsgboxLayer", import("view.base.BaseUI"))

function PlayRoomChatSettingsMsgboxLayer:getUIName()
	return "IslandPlayRoomChatSettingsMsgBox"
end

function PlayRoomChatSettingsMsgboxLayer:init()
	self.titleTxt = self.rtPage:Find("title"):GetComponent(typeof(Text))
	self.contentTxt = self.rtPage:Find("content/Text"):GetComponent("RichText")
	self.closeBtn = self.rtPage:Find("close")
	self.cancelBtn = self.rtPage:Find("cancel")
	self.confirmBtn = self.rtPage:Find("confirm")
	self.cancelTxt = self.rtPage:Find("cancel/Text"):GetComponent(typeof(Text))
	self.confirmTxt = self.rtPage:Find("confirm/Text"):GetComponent(typeof(Text))
	self.uiSendChanncelList = UIItemList.New(self.rtPage:Find("send_channel/list"), self.rtPage:Find("send_channel/list/tpl"))
	self.uiChanncelList = UIItemList.New(self.rtPage:Find("channels/list"), self.rtPage:Find("send_channel/list/tpl"))
	self.roomInput = self.rtPage:Find("room/room")

	setText(self.rtPage:Find("send_channel/Text"), i18n("notice_label_send"))
	setText(self.rtPage:Find("channels/Text"), i18n("notice_label_recv"))
	setText(self.rtPage:Find("room/Text"), i18n("notice_label_room"))
	setText(self.rtPage:Find("room/tip"), i18n("notice_label_tip"))
	self:InitSendChannel()
	self:InitChannels()
	self:OverlayPanel(self._tf)

	return
end

function PlayRoomChatSettingsMsgboxLayer:didEnter()
	onButton(self, self.rtBg, function()
		self:closeView()
		existCall(self.onNo)

		return
	end, SFX_PANEL)
	onButton(self, self.cancelBtn, function()
		self:closeView()
		existCall(self.onNo)

		return
	end, SFX_PANEL)
	onButton(self, self.closeBtn, function()
		self:closeView()

		return
	end, SFX_PANEL)
	onButton(self, self.confirmBtn, function()
		self:closeView()
		existCall(self.onYes)

		return
	end, SFX_PANEL)
	onButton(self, self.confirmBtn, function()
		existCall(self.onYes, self.sendChannelValue, self.channelValue, tonumber(getInputText(self.roomInput)))
		self:closeView()

		return
	end, SFX_PANEL)

	if self.contextData.settings.rawIconDic then
		for iter_3_0, iter_3_1 in pairs(self.contextData.settings.rawIconDic) do
			self.contentTxt:AddSprite(iter_3_0, iter_3_1)
		end
	end

	self.titleTxt.text = self.contextData.settings.title or i18n("island_msg_info")
	self.contentTxt.text = self.contextData.settings.content or ""
	self.onYes = self.contextData.settings.onYes
	self.onNo = self.contextData.settings.onNo
	self.onHide = self.contextData.settings.onHide

	self:FlushBtn(self.contextData.settings)

	self.sendChannelValue = self.contextData.settings.sendChannelValue
	self.channelValue = self.contextData.settings.channelValue

	self:FlushSendChannel()
	self:FlushChannels()
	self:FlushRoom()

	return
end

function PlayRoomChatSettingsMsgboxLayer:InitSendChannel()
	local var_9_0 = PlayRoomChatConst.SEND_CHANNELS

	self.uiSendChanncelList:make(function(arg_10_0, arg_10_1, arg_10_2)
		if arg_10_0 == UIItemList.EventUpdate then
			local var_10_0 = var_9_0[arg_10_1 + 1]

			onButton(self, arg_10_2, function()
				if var_10_0 == PlayRoomChatConst.CHANNEL_GUILD then
					if getProxy(GuildProxy):getRawData() == nil then
						return
					end
				end

				self.sendChannelValue = var_10_0

				self:FlushSendChannel()

				return
			end, SFX_PANEL)
			setActive(arg_10_2:Find("line"), #var_9_0 ~= arg_10_1 + 1)
		end

		return
	end)
	self.uiSendChanncelList:align(#PlayRoomChatConst.SEND_CHANNELS)

	return
end

function PlayRoomChatSettingsMsgboxLayer:InitChannels()
	local var_12_0 = PlayRoomChatConst.CHANNELS

	self.uiChanncelList:make(function(arg_13_0, arg_13_1, arg_13_2)
		if arg_13_0 == UIItemList.EventUpdate then
			local var_13_0 = var_12_0[arg_13_1 + 1]

			onButton(self, arg_13_2, function()
				self:UpdatteChannelValue(var_13_0)
				self:FlushChannels()

				return
			end, SFX_PANEL)
			setActive(arg_13_2:Find("line"), not (#var_12_0 == arg_13_1 + 1) and not ((arg_13_1 + 1) % 3 == 0))
		end

		return
	end)
	self.uiChanncelList:align(#PlayRoomChatConst.CHANNELS)

	return
end

function PlayRoomChatSettingsMsgboxLayer:FlushSendChannel()
	local var_15_0 = PlayRoomChatConst.SEND_CHANNELS

	self.uiSendChanncelList:eachActive(function(arg_16_0, arg_16_1)
		local var_16_0 = var_15_0[arg_16_0 + 1]
		local var_16_1 = var_15_0[arg_16_0 + 1] == self.sendChannelValue

		setActive(arg_16_1:Find("mark"), var_15_0[arg_16_0 + 1] == self.sendChannelValue)
		setText(arg_16_1:Find("Text"), setColorStr(PlayRoomChatConst.CHANNEL2CN(var_16_0), var_16_1 and "#FFFFFF" or "#393a3c"))

		return
	end)

	return
end

function PlayRoomChatSettingsMsgboxLayer:FlushChannels()
	local var_17_0 = PlayRoomChatConst.CHANNELS

	self.uiChanncelList:eachActive(function(arg_18_0, arg_18_1)
		local var_18_0 = var_17_0[arg_18_0 + 1]
		local var_18_1 = self.channelValue == PlayRoomChatConst.CHANNEL_ALL
		local var_18_2 = var_17_0[arg_18_0 + 1] == PlayRoomChatConst.CHANNEL_ALL and var_18_1 or var_17_0[arg_18_0 + 1] ~= PlayRoomChatConst.CHANNEL_ALL and not var_18_1 and bit.band(self.channelValue, var_18_0) > 0

		setActive(arg_18_1:Find("mark"), var_18_2)
		setText(arg_18_1:Find("Text"), setColorStr(PlayRoomChatConst.CHANNEL2CN(var_18_0), var_18_2 and "#FFFFFF" or "#393a3c"))

		return
	end)

	return
end

function PlayRoomChatSettingsMsgboxLayer:FlushRoom()
	setInputText(self.roomInput, getProxy(PlayerProxy):getRawData().chatRoomId)

	return
end

function PlayRoomChatSettingsMsgboxLayer:FlushBtn(arg_20_1)
	setActive(self.cancelBtn, not arg_20_1.hideNo)

	self.confirmBtn.sizeDelta = Vector2(arg_20_1.hideNo and 880 or 420, self.confirmBtn.sizeDelta.y)

	if arg_20_1.noText then
		self.cancelTxt.text = arg_20_1.noText or i18n("word_cancel")
	end

	if arg_20_1.yesText then
		self.confirmTxt.text = arg_20_1.yesText or i18n("word_ok")
	end

	return
end

function PlayRoomChatSettingsMsgboxLayer:UpdatteChannelValue(arg_21_1)
	if arg_21_1 == PlayRoomChatConst.CHANNEL_ALL then
		self.channelValue = PlayRoomChatConst.CHANNEL_ALL
	else
		self.channelValue = bit.band(self.channelValue, arg_21_1) > 0 and (self.channelValue == PlayRoomChatConst.CHANNEL_ALL and arg_21_1 or bit.bxor(self.channelValue, arg_21_1)) or bit.bor(self.channelValue, arg_21_1)

		if self.channelValue <= 0 then
			self.channelValue = PlayRoomChatConst.CHANNEL_ALL
		end
	end

	return
end

function PlayRoomChatSettingsMsgboxLayer:willExit()
	self:UnOverlayPanel(self._tf)

	if self.onHide then
		self.onHide()

		self.onHide = nil
	end

	return
end

return PlayRoomChatSettingsMsgboxLayer
