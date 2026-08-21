local var_0_0 = class("IslandChatView", import("..IslandASynLoadSubView"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.parent = arg_1_2

	return
end

function var_0_0.GetUIName(arg_2_0)
	return "IslandChatUI"
end

function var_0_0.GetUIParent(arg_3_0, arg_3_1)
	return arg_3_0.parent
end

function var_0_0.FirstFlush(arg_4_0)
	arg_4_0.settingsBtn = arg_4_0._tf:Find("top/settings")
	arg_4_0.uiChannelList = UIItemList.New(arg_4_0._tf:Find("top/channels"), arg_4_0._tf:Find("top/channels/tpl"))
	arg_4_0.sendChanncelBtn = arg_4_0._tf:Find("send_panel/channel_btn")
	arg_4_0.sendChanncelTxt = arg_4_0._tf:Find("send_panel/channel_btn/Text"):GetComponent(typeof(Text))
	arg_4_0.roomNumTxt = arg_4_0._tf:Find("top/settings/Text"):GetComponent(typeof(Text))
	arg_4_0.scrollrect = arg_4_0._tf:Find("list"):GetComponent("LScrollRect")
	arg_4_0.emojiBtn = arg_4_0._tf:Find("send_panel/input_panel/emoji")
	arg_4_0.sendBtn = arg_4_0._tf:Find("send_panel/send_btn")
	arg_4_0.inputField = arg_4_0._tf:Find("send_panel/input_panel/input"):GetComponent(typeof(InputField))
	arg_4_0.uiSendChanncelList = UIItemList.New(arg_4_0._tf:Find("send_panel/channel_sel_panel"), arg_4_0._tf:Find("send_panel/channel_sel_panel/tpl"))
	arg_4_0.channelValue = IslandChatConst.CHANNEL_ALL
	arg_4_0.sendChannelValue = IslandChatConst.CHANNEL_ISLAND
	arg_4_0.cards = {}
	arg_4_0.emojiAdaptor = IslandEmojiAdaptor.New(arg_4_0)

	arg_4_0:InitChanncelToggles()
	arg_4_0:InitSendChannelName()
	arg_4_0:RegisterEvent()

	return
end

function var_0_0.RegisterEvent(arg_5_0)
	onButton(arg_5_0, arg_5_0.settingsBtn, function()
		arg_5_0:ShowMsgbox({
			type = IslandMsgBox.TYPE_CHAT_SETTINGS,
			sendChannelValue = arg_5_0.sendChannelValue,
			channelValue = arg_5_0.channelValue,
			title = i18n("island_chat_settings"),
			onYes = function(arg_7_0, arg_7_1, arg_7_2)
				arg_5_0:OnSettingEnd(arg_7_0, arg_7_1, arg_7_2)

				return
			end
		})

		return
	end, SFX_PANEL)
	onButton(arg_5_0, arg_5_0.emojiBtn, function()
		arg_5_0.emojiAdaptor:Init({
			emojiIconCallback = function(arg_9_0)
				arg_5_0.inputField.text = arg_5_0.inputField.text .. string.gsub(ChatConst.EmojiIconCode, "code", arg_9_0)

				return
			end,
			callback = function(arg_10_0)
				setInputText(arg_5_0.inputField, "")
				arg_5_0:NotifiyMeditor(IslandBaseMediator.SEND_CHAT, arg_5_0.sendChannelValue, string.gsub(ChatConst.EmojiCode, "code", arg_10_0))

				return
			end,
			pos = arg_5_0.emojiBtn.position
		})

		return
	end, SFX_PANEL)
	onButton(arg_5_0, arg_5_0.sendBtn, function()
		setInputText(arg_5_0.inputField, "")
		arg_5_0:NotifiyMeditor(IslandBaseMediator.SEND_CHAT, arg_5_0.sendChannelValue, arg_5_0.inputField.text)

		return
	end, SFX_PANEL)
	onToggle(arg_5_0, arg_5_0.sendChanncelBtn, function(arg_12_0)
		if arg_12_0 then
			arg_5_0:InitSendChannel()
		end

		return
	end, SFX_PANEL)

	function arg_5_0.scrollrect.onInitItem(arg_13_0)
		arg_5_0:OnInitItem(arg_13_0)

		return
	end

	function arg_5_0.scrollrect.onUpdateItem(arg_14_0, arg_14_1)
		arg_5_0:OnUpdateItem(arg_14_0, arg_14_1)

		return
	end

	return
end

function var_0_0.OnSettingEnd(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	if arg_15_0.sendChannelValue ~= arg_15_1 then
		arg_15_0.sendChannelValue = arg_15_1

		arg_15_0:InitSendChannelName()
	end

	if arg_15_0.channelValue ~= arg_15_2 then
		arg_15_0.channelValue = arg_15_2

		arg_15_0:UpdateChannelToggles()
		arg_15_0:Flush(false)
	end

	if arg_15_0.chatRoomId ~= arg_15_3 then
		arg_15_0:NotifiyMeditor(IslandBaseMediator.CHANGE_CHAT_ROOM, arg_15_3)
	end

	return
end

function var_0_0.InitRoomNum(arg_16_0)
	local var_16_9000
	local var_16_0 = getProxy(PlayerProxy)
	local var_16_1 = var_16_0.getRawData(var_16_9000).chatRoomId
	local var_16_2 = arg_16_0.roomNumTxt
	local var_16_3 = var_16_1 == 0 and i18n("common_not_enter_room") or var_16_1

	var_16_2.text = var_16_0
	arg_16_0.chatRoomId = var_16_1

	return
end

function var_0_0.InitSendChannel(arg_17_0)
	local var_17_0 = IslandChatConst.SEND_CHANNELS

	arg_17_0.uiSendChanncelList:make(function(arg_18_0, arg_18_1, arg_18_2)
		if arg_18_0 == UIItemList.EventUpdate then
			local var_18_0 = var_17_0[arg_18_1 + 1]

			onButton(arg_17_0, arg_18_2, function()
				if var_18_0 == IslandChatConst.CHANNEL_GUILD then
					if getProxy(GuildProxy):getRawData() == nil then
						return
					end
				end

				arg_17_0.sendChannelValue = var_18_0

				arg_17_0:InitSendChannelName()
				triggerToggle(arg_17_0.sendChanncelBtn, false)

				return
			end, SFX_PANEL)
			setText(arg_18_2:Find("Text"), setColorStr(IslandChatConst.CHANNEL2CN(var_18_0), var_18_0 == arg_17_0.sendChannelValue and "#5ccaff" or "#ffffff"))
		end

		return
	end)
	arg_17_0.uiSendChanncelList:align(#IslandChatConst.SEND_CHANNELS)

	return
end

function var_0_0.InitSendChannelName(arg_20_0)
	arg_20_0.sendChanncelTxt.text = IslandChatConst.CHANNEL2CN(arg_20_0.sendChannelValue)

	return
end

function var_0_0.InitChanncelToggles(arg_21_0)
	local var_21_0 = IslandChatConst.CHANNELS

	arg_21_0.uiChannelList:make(function(arg_22_0, arg_22_1, arg_22_2)
		if arg_22_0 == UIItemList.EventUpdate then
			local var_22_0 = var_21_0[arg_22_1 + 1]

			onButton(arg_21_0, arg_22_2, function()
				arg_21_0:UpdatteChannelValue(var_22_0)
				arg_21_0:Flush(false)

				return
			end, SFX_PANEL)
		end

		return
	end)
	arg_21_0.uiChannelList:align(#IslandChatConst.CHANNELS)
	arg_21_0:UpdatteChannelValue(arg_21_0.channelValue)

	return
end

function var_0_0.UpdatteChannelValue(arg_24_0, arg_24_1)
	if arg_24_1 == IslandChatConst.CHANNEL_ALL then
		arg_24_0.channelValue = IslandChatConst.CHANNEL_ALL
	else
		arg_24_0.channelValue = bit.band(arg_24_0.channelValue, arg_24_1) > 0 and (arg_24_0.channelValue == IslandChatConst.CHANNEL_ALL and arg_24_1 or bit.bxor(arg_24_0.channelValue, arg_24_1)) or bit.bor(arg_24_0.channelValue, arg_24_1)

		if arg_24_0.channelValue <= 0 then
			arg_24_0.channelValue = IslandChatConst.CHANNEL_ALL
		end
	end

	arg_24_0:UpdateChannelToggles()

	return
end

function var_0_0.UpdateChannelToggles(arg_25_0)
	local var_25_0 = IslandChatConst.CHANNELS

	arg_25_0.uiChannelList:eachActive(function(arg_26_0, arg_26_1)
		local var_26_0 = var_25_0[arg_26_0 + 1]
		local var_26_1 = arg_25_0.channelValue == IslandChatConst.CHANNEL_ALL
		local var_26_2 = var_25_0[arg_26_0 + 1] == IslandChatConst.CHANNEL_ALL
		local var_26_3 = var_25_0[arg_26_0 + 1] == IslandChatConst.CHANNEL_ALL and var_26_1 or not var_26_2 and not var_26_1 and bit.band(arg_25_0.channelValue, var_26_0) > 0

		setActive(arg_26_1:Find("sel"), var_26_3)
		setText(arg_26_1:Find("Text"), setColorStr(IslandChatConst.CHANNEL2CN(var_26_0), var_26_3 and "#393a3c" or "#FFFFFF"))

		return
	end)

	return
end

function var_0_0.Flush(arg_27_0, arg_27_1)
	arg_27_0:InitChatMsg(arg_27_1)
	arg_27_0:InitRoomNum()

	return
end

function var_0_0.InsertMsg(arg_28_0, arg_28_1, arg_28_2)
	if getProxy(FriendProxy):isInBlackList(arg_28_2.playerId) then
		return
	end

	if arg_28_2.player and arg_28_2.content then
		table.insert(arg_28_1, arg_28_2)
	end

	return
end

function var_0_0.MatchChannel(arg_29_0, arg_29_1)
	return bit.band(arg_29_0.channelValue, arg_29_1) > 0
end

function var_0_0.InitChatMsg(arg_30_0, arg_30_1)
	arg_30_0.displays = {}

	if arg_30_0:MatchChannel(IslandChatConst.CHANNEL_WORLD) then
		_.each(getProxy(ChatProxy):getRawData(), function(arg_31_0)
			arg_30_0:InsertMsg(arg_30_0.displays, arg_31_0)

			return
		end)
	end

	if arg_30_0:MatchChannel(IslandChatConst.CHANNEL_GUILD) then
		local var_30_0 = getProxy(GuildProxy)

		if var_30_0:getRawData() then
			_.each(var_30_0:getChatMsgs(), function(arg_32_0)
				arg_30_0:InsertMsg(arg_30_0.displays, arg_32_0)

				return
			end)
		end
	end

	if arg_30_0:MatchChannel(IslandChatConst.CHANNEL_FRIEND) then
		_.each(getProxy(FriendProxy):getCacheMsgList(), function(arg_33_0)
			arg_30_0:InsertMsg(arg_30_0.displays, arg_33_0)

			return
		end)
	end

	if arg_30_0:MatchChannel(IslandChatConst.CHANNEL_ISLAND) then
		_.each(getProxy(IslandProxy):GetChatMsgList(arg_30_0:GetView():GetIsland().id), function(arg_34_0)
			arg_30_0:InsertMsg(arg_30_0.displays, arg_34_0)

			return
		end)
	end

	table.sort(arg_30_0.displays, function(arg_35_0, arg_35_1)
		return arg_35_0.timestamp < arg_35_1.timestamp
	end)
	arg_30_0.scrollrect:SetTotalCount(#arg_30_0.displays, arg_30_1 and 1 or -1)

	return
end

function var_0_0.OnInitItem(arg_36_0, arg_36_1)
	local var_36_0 = IslandChatCard.New(arg_36_1)

	onButton(arg_36_0, var_36_0.otherBubble.tf, function()
		arg_36_0:NotifiyMeditor(IslandBaseMediator.OPEN_FRIEND_INFO, var_36_0.sender.id, var_36_0.otherBubble.circle.position, var_36_0.data.content)

		return
	end)
	onButton(arg_36_0, var_36_0.otherBubble.tf:Find("chat_fram"), function()
		if var_36_0:IsTradeLink() then
			arg_36_0:NotifiyMeditor(IslandMediator.ENTER_ISLAND, var_36_0.sender.id)
		else
			triggerButton(var_36_0.otherBubble.tf)
		end

		return
	end)

	arg_36_0.cards[arg_36_1] = var_36_0

	return
end

function var_0_0.OnUpdateItem(arg_39_0, arg_39_1, arg_39_2)
	if not arg_39_0.cards[arg_39_2] then
		arg_39_0:OnInitItem(arg_39_2)
	end

	arg_39_0.cards[arg_39_2]:Update(arg_39_0.displays[arg_39_1 + 1])

	return
end

function var_0_0.OnDispose(arg_40_0)
	var_0_0.super.OnDispose(arg_40_0)
	ClearLScrollrect(arg_40_0.scrollrect)

	if arg_40_0.emojiAdaptor then
		arg_40_0.emojiAdaptor:Dispose()

		arg_40_0.emojiAdaptor = nil
	end

	return
end

return var_0_0
