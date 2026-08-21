local var_0_0 = class("PlayRoomNotificationLayer", import("..base.BaseUI"))

var_0_0.InitCount = 10
var_0_0.MaxCount = 100
var_0_0.FORM_COMMON = 0
var_0_0.FORM_BATTLE = 1
var_0_0.FORM_MAIN = 2
var_0_0.ChannelBits = {
	send = ChatConst.ChannelWorld,
	recv = IndexConst.Flags2Bits({
		ChatConst.ChannelAll
	})
}

function var_0_0.getUIName(arg_1_0)
	return "IslandPlayRoomChatUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0.settingsBtn = arg_2_0.rtWindow:Find("top/settings")
	arg_2_0.uiChannelList = UIItemList.New(arg_2_0.rtWindow:Find("top/channels"), arg_2_0.rtWindow:Find("top/channels/tpl"))
	arg_2_0.sendChanncelBtn = arg_2_0.rtWindow:Find("send_panel/channel_btn")
	arg_2_0.sendChanncelTxt = arg_2_0.rtWindow:Find("send_panel/channel_btn/Text"):GetComponent(typeof(Text))
	arg_2_0.roomNumTxt = arg_2_0.rtWindow:Find("top/settings/Text"):GetComponent(typeof(Text))
	arg_2_0.scrollrect = arg_2_0.rtWindow:Find("list/content"):GetComponent("LScrollRect")
	arg_2_0.emojiBtn = arg_2_0.rtWindow:Find("send_panel/input_panel/emoji")
	arg_2_0.sendBtn = arg_2_0.rtWindow:Find("send_panel/send_btn")
	arg_2_0.inputField = arg_2_0.rtWindow:Find("send_panel/input_panel/input"):GetComponent(typeof(InputField))
	arg_2_0.uiSendChanncelList = UIItemList.New(arg_2_0.rtWindow:Find("send_panel/channel_sel_panel"), arg_2_0.rtWindow:Find("send_panel/channel_sel_panel/tpl"))
	arg_2_0.channelValue = PlayRoomChatConst.CHANNEL_ALL
	arg_2_0.sendChannelValue = PlayRoomChatConst.CHANNEL_PLAYROOM
	arg_2_0.cards = {}

	arg_2_0:InitChanncelToggles()
	arg_2_0:InitSendChannelName()
	arg_2_0:RegisterEvent()
	arg_2_0:BlurPanel(arg_2_0._tf)

	return
end

function var_0_0.RegisterEvent(arg_3_0)
	onButton(arg_3_0, arg_3_0.rtBg, function()
		arg_3_0:closeView()

		return
	end, SFX_CANCEL)
	onButton(arg_3_0, arg_3_0.settingsBtn, function()
		arg_3_0:emit(BaseUI.ON_ADD_SUBLAYER, Context.New({
			mediator = PlayRoomChatSettingsMsgboxMediator,
			viewComponent = PlayRoomChatSettingsMsgboxLayer,
			data = {
				groupName = arg_3_0:getGroupName(),
				settings = {
					sendChannelValue = arg_3_0.sendChannelValue,
					channelValue = arg_3_0.channelValue,
					title = i18n("island_chat_settings"),
					onYes = function(arg_6_0, arg_6_1, arg_6_2)
						arg_3_0:OnSettingEnd(arg_6_0, arg_6_1, arg_6_2)

						return
					end
				}
			}
		}))

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.emojiBtn, function()
		arg_3_0:emit(PlayRoomNotificationMediator.OPEN_EMOJI, {
			emojiIconCallback = function(arg_8_0)
				arg_3_0.inputField.text = arg_3_0.inputField.text .. string.gsub(ChatConst.EmojiIconCode, "code", arg_8_0)

				return
			end,
			callback = function(arg_9_0)
				setInputText(arg_3_0.inputField, "")
				arg_3_0:emit(PlayRoomNotificationMediator.SEND_CHAT, arg_3_0.sendChannelValue, string.gsub(ChatConst.EmojiCode, "code", arg_9_0))

				return
			end,
			pos = arg_3_0.emojiBtn.position,
			groupName = arg_3_0:getGroupName()
		})

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.sendBtn, function()
		setInputText(arg_3_0.inputField, "")
		arg_3_0:emit(PlayRoomNotificationMediator.SEND_CHAT, arg_3_0.sendChannelValue, arg_3_0.inputField.text)

		return
	end, SFX_PANEL)
	onToggle(arg_3_0, arg_3_0.sendChanncelBtn, function(arg_11_0)
		if arg_11_0 then
			arg_3_0:InitSendChannel()
		end

		return
	end, SFX_PANEL)

	function arg_3_0.scrollrect.onInitItem(arg_12_0)
		arg_3_0:OnInitItem(arg_12_0)

		return
	end

	function arg_3_0.scrollrect.onUpdateItem(arg_13_0, arg_13_1)
		arg_3_0:OnUpdateItem(arg_13_0, arg_13_1)

		return
	end

	return
end

function var_0_0.OnSettingEnd(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	if arg_14_0.sendChannelValue ~= arg_14_1 then
		arg_14_0.sendChannelValue = arg_14_1

		arg_14_0:InitSendChannelName()
	end

	if arg_14_0.channelValue ~= arg_14_2 then
		arg_14_0.channelValue = arg_14_2

		arg_14_0:UpdateChannelToggles()
		arg_14_0:Flush(false)
	end

	if arg_14_0.chatRoomId ~= arg_14_3 then
		arg_14_0:emit(PlayRoomNotificationMediator.CHANGE_CHAT_ROOM, arg_14_3)
	end

	return
end

function var_0_0.InitRoomNum(arg_15_0)
	local var_15_9000
	local var_15_0 = getProxy(PlayerProxy)
	local var_15_1 = var_15_0.getRawData(var_15_9000).chatRoomId
	local var_15_2 = arg_15_0.roomNumTxt
	local var_15_3 = var_15_1 == 0 and i18n("common_not_enter_room") or var_15_1

	var_15_2.text = var_15_0
	arg_15_0.chatRoomId = var_15_1

	return
end

function var_0_0.InitSendChannel(arg_16_0)
	local var_16_0 = PlayRoomChatConst.SEND_CHANNELS

	arg_16_0.uiSendChanncelList:make(function(arg_17_0, arg_17_1, arg_17_2)
		if arg_17_0 == UIItemList.EventUpdate then
			local var_17_0 = var_16_0[arg_17_1 + 1]

			onButton(arg_16_0, arg_17_2, function()
				if var_17_0 == PlayRoomChatConst.CHANNEL_GUILD then
					if getProxy(GuildProxy):getRawData() == nil then
						return
					end
				end

				arg_16_0.sendChannelValue = var_17_0

				arg_16_0:InitSendChannelName()
				triggerToggle(arg_16_0.sendChanncelBtn, false)

				return
			end, SFX_PANEL)
			setText(arg_17_2:Find("Text"), setColorStr(PlayRoomChatConst.CHANNEL2CN(var_17_0), var_17_0 == arg_16_0.sendChannelValue and "#5ccaff" or "#ffffff"))
		end

		return
	end)
	arg_16_0.uiSendChanncelList:align(#PlayRoomChatConst.SEND_CHANNELS)

	return
end

function var_0_0.InitSendChannelName(arg_19_0)
	arg_19_0.sendChanncelTxt.text = PlayRoomChatConst.CHANNEL2CN(arg_19_0.sendChannelValue)

	return
end

function var_0_0.InitChanncelToggles(arg_20_0)
	local var_20_0 = PlayRoomChatConst.CHANNELS

	arg_20_0.uiChannelList:make(function(arg_21_0, arg_21_1, arg_21_2)
		if arg_21_0 == UIItemList.EventUpdate then
			local var_21_0 = var_20_0[arg_21_1 + 1]

			onButton(arg_20_0, arg_21_2, function()
				arg_20_0:UpdatteChannelValue(var_21_0)
				arg_20_0:Flush(false)

				return
			end, SFX_PANEL)
		end

		return
	end)
	arg_20_0.uiChannelList:align(#PlayRoomChatConst.CHANNELS)
	arg_20_0:UpdatteChannelValue(PlayRoomChatConst.CHANNEL_PLAYROOM)

	return
end

function var_0_0.UpdatteChannelValue(arg_23_0, arg_23_1)
	if arg_23_1 == PlayRoomChatConst.CHANNEL_ALL then
		arg_23_0.channelValue = PlayRoomChatConst.CHANNEL_ALL
	else
		arg_23_0.channelValue = bit.band(arg_23_0.channelValue, arg_23_1) > 0 and (arg_23_0.channelValue == PlayRoomChatConst.CHANNEL_ALL and arg_23_1 or bit.bxor(arg_23_0.channelValue, arg_23_1)) or bit.bor(arg_23_0.channelValue, arg_23_1)

		if arg_23_0.channelValue <= 0 then
			arg_23_0.channelValue = PlayRoomChatConst.CHANNEL_ALL
		end
	end

	arg_23_0:UpdateChannelToggles()

	return
end

function var_0_0.UpdateChannelToggles(arg_24_0)
	local var_24_0 = PlayRoomChatConst.CHANNELS

	arg_24_0.uiChannelList:eachActive(function(arg_25_0, arg_25_1)
		local var_25_0 = var_24_0[arg_25_0 + 1]
		local var_25_1 = arg_24_0.channelValue == PlayRoomChatConst.CHANNEL_ALL
		local var_25_2 = var_24_0[arg_25_0 + 1] == PlayRoomChatConst.CHANNEL_ALL
		local var_25_3 = var_24_0[arg_25_0 + 1] == PlayRoomChatConst.CHANNEL_ALL and var_25_1 or not var_25_2 and not var_25_1 and bit.band(arg_24_0.channelValue, var_25_0) > 0

		setActive(arg_25_1:Find("sel"), var_25_3)
		setText(arg_25_1:Find("Text"), setColorStr(PlayRoomChatConst.CHANNEL2CN(var_25_0), var_25_3 and "#393a3c" or "#FFFFFF"))

		return
	end)

	return
end

function var_0_0.Flush(arg_26_0, arg_26_1)
	arg_26_0:InitChatMsg(arg_26_1)
	arg_26_0:InitRoomNum()

	return
end

function var_0_0.InsertMsg(arg_27_0, arg_27_1, arg_27_2)
	if getProxy(FriendProxy):isInBlackList(arg_27_2.playerId) then
		return
	end

	if arg_27_2.player and arg_27_2.content then
		table.insert(arg_27_1, arg_27_2)
	end

	return
end

function var_0_0.MatchChannel(arg_28_0, arg_28_1)
	return bit.band(arg_28_0.channelValue, arg_28_1) > 0
end

function var_0_0.InitChatMsg(arg_29_0, arg_29_1)
	arg_29_0.displays = {}

	if arg_29_0:MatchChannel(PlayRoomChatConst.CHANNEL_WORLD) then
		_.each(getProxy(ChatProxy):getRawData(), function(arg_30_0)
			arg_29_0:InsertMsg(arg_29_0.displays, arg_30_0)

			return
		end)
	end

	if arg_29_0:MatchChannel(PlayRoomChatConst.CHANNEL_GUILD) then
		local var_29_0 = getProxy(GuildProxy)

		if var_29_0:getRawData() then
			_.each(var_29_0:getChatMsgs(), function(arg_31_0)
				arg_29_0:InsertMsg(arg_29_0.displays, arg_31_0)

				return
			end)
		end
	end

	if arg_29_0:MatchChannel(PlayRoomChatConst.CHANNEL_FRIEND) then
		_.each(getProxy(FriendProxy):getCacheMsgList(), function(arg_32_0)
			arg_29_0:InsertMsg(arg_29_0.displays, arg_32_0)

			return
		end)
	end

	if arg_29_0:MatchChannel(PlayRoomChatConst.CHANNEL_PLAYROOM) then
		_.each(getProxy(PlayRoomProxy):GetChatMsgs(), function(arg_33_0)
			arg_29_0:InsertMsg(arg_29_0.displays, arg_33_0)

			return
		end)
	end

	table.sort(arg_29_0.displays, function(arg_34_0, arg_34_1)
		return arg_34_0.timestamp < arg_34_1.timestamp
	end)
	onNextTick(function()
		arg_29_0.scrollrect:SetTotalCount(#arg_29_0.displays, arg_29_1 and 1 or -1)

		return
	end)

	return
end

function var_0_0.OnInitItem(arg_36_0, arg_36_1)
	local var_36_0 = IslandChatCard.New(arg_36_1)

	onButton(arg_36_0, var_36_0.otherBubble.tf, function()
		arg_36_0:emit(PlayRoomNotificationMediator.OPEN_FRIEND_INFO, var_36_0.sender.id, var_36_0.otherBubble.circle.position, var_36_0.data.content)

		return
	end)

	arg_36_0.cards[arg_36_1] = var_36_0

	return
end

function var_0_0.OnUpdateItem(arg_38_0, arg_38_1, arg_38_2)
	if not arg_38_0.cards[arg_38_2] then
		arg_38_0:OnInitItem(arg_38_2)
	end

	arg_38_0.cards[arg_38_2]:Update(arg_38_0.displays[arg_38_1 + 1])

	return
end

function var_0_0.didEnter(arg_39_0)
	arg_39_0:Flush()

	return
end

function var_0_0.willExit(arg_40_0)
	arg_40_0:UnOverlayPanel(arg_40_0._tf)
	ClearLScrollrect(arg_40_0.scrollrect)

	return
end

return var_0_0
