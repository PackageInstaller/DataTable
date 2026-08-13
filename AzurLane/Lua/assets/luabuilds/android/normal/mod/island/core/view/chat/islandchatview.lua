class = var_0_10000

local var_0_0 = "IslandChatView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..IslandASynLoadSubView"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.parent = arg_1_2

	return
end

function var_0_1.GetUIName(arg_2_0)
	return "IslandChatUI"
end

function var_0_1.GetUIParent(arg_3_0, arg_3_1)
	return arg_3_0.parent
end

function var_0_1.FirstFlush(arg_4_0)
	local var_4_0 = arg_4_0._tf

	arg_4_0.settingsBtn = var_1.Find(var_4_0, "top/settings")
	UIItemList = var_1

	local var_4_1 = var_1.New
	local var_4_2 = arg_4_0._tf
	local var_4_3 = var_2.Find(var_4_2, "top/channels")
	local var_4_4 = arg_4_0._tf

	arg_4_0.uiChannelList = var_4_1(var_4_3, var_3.Find(var_4_4, "top/channels/tpl"))

	local var_4_5 = arg_4_0._tf

	arg_4_0.sendChanncelBtn = var_1.Find(var_4_5, "send_panel/channel_btn")

	local var_4_6 = arg_4_0._tf
	local var_4_7 = var_1.Find(var_4_6, "send_panel/channel_btn/Text")
	local var_4_8 = var_1.GetComponent

	typeof = var_3
	Text = var_4_4
	arg_4_0.sendChanncelTxt = var_4_8(var_4_7, var_3(var_4_4))

	local var_4_9 = arg_4_0._tf
	local var_4_10 = var_1.Find(var_4_9, "top/settings/Text")
	local var_4_11 = var_1.GetComponent

	typeof = var_3
	Text = var_4_4
	arg_4_0.roomNumTxt = var_4_11(var_4_10, var_3(var_4_4))

	local var_4_12 = arg_4_0._tf
	local var_4_13 = var_1.Find(var_4_12, "list")

	arg_4_0.scrollrect = var_1.GetComponent(var_4_13, "LScrollRect")

	local var_4_14 = arg_4_0._tf

	arg_4_0.emojiBtn = var_1.Find(var_4_14, "send_panel/input_panel/emoji")

	local var_4_15 = arg_4_0._tf

	arg_4_0.sendBtn = var_1.Find(var_4_15, "send_panel/send_btn")

	local var_4_16 = arg_4_0._tf
	local var_4_17 = var_1.Find(var_4_16, "send_panel/input_panel/input")
	local var_4_18 = var_1.GetComponent

	typeof = var_3
	InputField = var_4_4
	arg_4_0.inputField = var_4_18(var_4_17, var_3(var_4_4))
	UIItemList = var_1

	local var_4_19 = var_1.New
	local var_4_20 = arg_4_0._tf
	local var_4_21 = var_2.Find(var_4_20, "send_panel/channel_sel_panel")
	local var_4_22 = arg_4_0._tf

	arg_4_0.uiSendChanncelList = var_4_19(var_4_21, var_3.Find(var_4_22, "send_panel/channel_sel_panel/tpl"))
	IslandChatConst = var_1
	arg_4_0.channelValue = var_1.CHANNEL_ALL
	IslandChatConst = var_1
	arg_4_0.sendChannelValue = var_1.CHANNEL_ISLAND
	arg_4_0.cards = {}
	IslandEmojiAdaptor = var_1
	arg_4_0.emojiAdaptor = var_1.New(arg_4_0)

	arg_4_0:InitChanncelToggles()
	arg_4_0:InitSendChannelName()
	arg_4_0:RegisterEvent()

	return
end

function var_0_1.RegisterEvent(arg_5_0)
	onButton = var_1_10001

	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.settingsBtn

	local function var_5_2()
		local var_6_0 = arg_5_0
		local var_6_1 = var_0.ShowMsgbox
		local var_6_2 = {}

		IslandMsgBox = var_2_10003
		var_6_2.type = var_2_10003.TYPE_CHAT_SETTINGS
		var_6_2.sendChannelValue = arg_5_0.sendChannelValue
		var_6_2.channelValue = arg_5_0.channelValue
		i18n = var_3
		var_6_2.title = var_3("island_chat_settings")

		function var_6_2.onYes(arg_7_0, arg_7_1, arg_7_2)
			local var_7_0 = arg_5_0

			var_3.OnSettingEnd(var_7_0, arg_7_0, arg_7_1, arg_7_2)

			return
		end

		var_6_1(var_6_0, var_6_2)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_5_0, var_5_1, var_5_2, var_1_10005)

	onButton = var_1_10001

	local var_5_3 = arg_5_0
	local var_5_4 = arg_5_0.emojiBtn

	local function var_5_5()
		local var_8_0 = {
			emojiIconCallback = function(arg_9_0)
				local var_9_0 = arg_5_0.inputField
				local var_9_1 = arg_5_0.inputField.text

				string = var_3_10003

				local var_9_2 = var_3_10003.gsub

				ChatConst = var_3_10004
				var_9_0.text = var_9_1 .. var_9_2(var_3_10004.EmojiIconCode, "code", arg_9_0)

				return
			end,
			callback = function(arg_10_0)
				setInputText = var_3_10001

				var_3_10001(arg_5_0.inputField, "")

				local var_10_0 = arg_5_0
				local var_10_1 = var_1.NotifiyMeditor

				IslandBaseMediator = var_3

				local var_10_2 = var_3.SEND_CHAT
				local var_10_3 = arg_5_0.sendChannelValue

				string = var_3_10005

				local var_10_4 = var_3_10005.gsub

				ChatConst = var_3_10006

				var_10_1(var_10_0, var_10_2, var_10_3, var_10_4(var_3_10006.EmojiCode, "code", arg_10_0))

				return
			end,
			pos = arg_5_0.emojiBtn.position
		}
		local var_8_1 = arg_5_0.emojiAdaptor

		var_1.Init(var_8_1, var_8_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_5_3, var_5_4, var_5_5, var_1_10005)

	onButton = var_1_10001

	local var_5_6 = arg_5_0
	local var_5_7 = arg_5_0.sendBtn

	local function var_5_8()
		local var_11_0 = arg_5_0.inputField.text

		setInputText = var_2_10001

		var_2_10001(arg_5_0.inputField, "")

		local var_11_1 = arg_5_0
		local var_11_2 = var_1.NotifiyMeditor

		IslandBaseMediator = var_3

		var_11_2(var_11_1, var_3.SEND_CHAT, arg_5_0.sendChannelValue, var_11_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_5_6, var_5_7, var_5_8, var_1_10005)

	onToggle = var_1_10001

	local var_5_9 = arg_5_0
	local var_5_10 = arg_5_0.sendChanncelBtn

	local function var_5_11(arg_12_0)
		if arg_12_0 then
			local var_12_0 = arg_5_0

			var_1.InitSendChannel(var_12_0)
		end

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_5_9, var_5_10, var_5_11, var_1_10005)

	function arg_5_0.scrollrect.onInitItem(arg_13_0)
		local var_13_0 = arg_5_0

		var_1.OnInitItem(var_13_0, arg_13_0)

		return
	end

	function arg_5_0.scrollrect.onUpdateItem(arg_14_0, arg_14_1)
		local var_14_0 = arg_5_0

		var_2.OnUpdateItem(var_14_0, arg_14_0, arg_14_1)

		return
	end

	return
end

function var_0_1.OnSettingEnd(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
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
		local var_15_0 = arg_15_0
		local var_15_1 = arg_15_0.NotifiyMeditor

		IslandBaseMediator = var_1_10006

		var_15_1(var_15_0, var_1_10006.CHANGE_CHAT_ROOM, arg_15_3)
	end

	return
end

function var_0_1.InitRoomNum(arg_16_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10002

	local var_16_0 = var_1_10001(var_1_10002)
	local var_16_1 = var_1.getRawData(var_16_0).chatRoomId
	local var_16_2 = arg_16_0.roomNumTxt

	if var_16_1 == 0 then
		i18n = var_1_10003

		local var_16_3

		if not var_1_10003("common_not_enter_room") then
			var_16_3 = var_16_1
		end

		var_16_2.text = var_16_3
		arg_16_0.chatRoomId = var_16_1

		return
	end
end

function var_0_1.InitSendChannel(arg_17_0)
	IslandChatConst = var_1_10001

	local var_17_0 = var_1_10001.SEND_CHANNELS
	local var_17_1 = arg_17_0.uiSendChanncelList

	var_2.make(var_17_1, function(arg_18_0, arg_18_1, arg_18_2)
		UIItemList = var_2_10003

		if arg_18_0 == var_2_10003.EventUpdate then
			local var_18_0 = var_17_0[arg_18_1 + 1]

			onButton = var_4

			local var_18_1 = arg_17_0
			local var_18_2 = arg_18_2

			local function var_18_3()
				local var_19_0 = var_18_0

				IslandChatConst = var_3_10001

				if var_19_0 == var_3_10001.CHANNEL_GUILD then
					getProxy = var_19_0
					GuildProxy = var_1

					local var_19_1 = var_19_0(var_1)

					if var_0.getRawData(var_19_1) == nil then
						return
					end
				end

				arg_17_0.sendChannelValue = var_18_0

				local var_19_2 = arg_17_0

				var_0.InitSendChannelName(var_19_2)

				triggerToggle = var_0

				var_0(arg_17_0.sendChanncelBtn, false)

				return
			end

			SFX_PANEL = var_2_10008

			var_4(var_18_1, var_18_2, var_18_3, var_2_10008)

			IslandChatConst = var_4

			local var_18_4 = var_4.CHANNEL2CN(var_18_0)

			setText = var_5

			local var_18_5 = arg_18_2
			local var_18_6 = arg_18_2.Find(var_18_5, "Text")

			setColorStr = var_18_5

			var_5(var_18_6, var_18_5(var_18_4, var_18_0 == arg_17_0.sendChannelValue and "#5ccaff" or "#ffffff"))
		end

		return
	end)

	local var_17_2 = arg_17_0.uiSendChanncelList

	var_2.align(var_17_2, #var_17_0)

	return
end

function var_0_1.InitSendChannelName(arg_20_0)
	IslandChatConst = var_1_10001

	local var_20_0 = var_1_10001.CHANNEL2CN(arg_20_0.sendChannelValue)

	arg_20_0.sendChanncelTxt.text = var_20_0

	return
end

function var_0_1.InitChanncelToggles(arg_21_0)
	IslandChatConst = var_1_10001

	local var_21_0 = var_1_10001.CHANNELS
	local var_21_1 = arg_21_0.uiChannelList

	var_2.make(var_21_1, function(arg_22_0, arg_22_1, arg_22_2)
		UIItemList = var_2_10003

		if arg_22_0 == var_2_10003.EventUpdate then
			local var_22_0 = var_21_0[arg_22_1 + 1]

			onButton = var_4

			local var_22_1 = arg_21_0
			local var_22_2 = arg_22_2

			local function var_22_3()
				local var_23_0 = arg_21_0

				var_0.UpdatteChannelValue(var_23_0, var_22_0)

				local var_23_1 = arg_21_0

				var_0.Flush(var_23_1, false)

				return
			end

			SFX_PANEL = var_2_10008

			var_4(var_22_1, var_22_2, var_22_3, var_2_10008)
		end

		return
	end)

	local var_21_2 = arg_21_0.uiChannelList

	var_2.align(var_21_2, #var_21_0)
	arg_21_0:UpdatteChannelValue(arg_21_0.channelValue)

	return
end

function var_0_1.UpdatteChannelValue(arg_24_0, arg_24_1)
	IslandChatConst = var_1_10002

	if arg_24_1 == var_1_10002.CHANNEL_ALL then
		IslandChatConst = var_2
		arg_24_0.channelValue = var_2.CHANNEL_ALL
	else
		bit = var_2

		local var_24_0 = var_2.band(arg_24_0.channelValue, arg_24_1)
		local var_24_1

		if 0 < var_24_0 then
			var_24_1 = arg_24_0.channelValue
			IslandChatConst = var_4

			if var_24_1 == var_4.CHANNEL_ALL then
				arg_24_0.channelValue = arg_24_1
			else
				bit = var_24_1
				arg_24_0.channelValue = var_24_1.bxor(arg_24_0.channelValue, arg_24_1)
			end
		else
			bit = var_24_1
			arg_24_0.channelValue = var_24_1.bor(arg_24_0.channelValue, arg_24_1)
		end

		if arg_24_0.channelValue <= 0 then
			IslandChatConst = var_3
			arg_24_0.channelValue = var_3.CHANNEL_ALL
		end
	end

	arg_24_0:UpdateChannelToggles()

	return
end

function var_0_1.UpdateChannelToggles(arg_25_0)
	IslandChatConst = var_1_10001

	local var_25_0 = var_1_10001.CHANNELS
	local var_25_1 = arg_25_0.uiChannelList

	var_2.eachActive(var_25_1, function(arg_26_0, arg_26_1)
		local var_26_0 = var_25_0[arg_26_0 + 1]
		local var_26_1 = arg_25_0.channelValue

		IslandChatConst = var_2_10004

		local var_26_2 = var_26_1 == var_2_10004.CHANNEL_ALL

		IslandChatConst = var_4

		if not (var_26_0 == var_4.CHANNEL_ALL) or not var_26_2 then
			::label_26_0::

			if not var_4 and not var_26_2 then
				bit = var_2_10005
				var_2_10005 = var_2_10005.band(arg_25_0.channelValue, var_26_0)

				if not (0 < var_2_10005) then
					var_2_10005 = false
				else
					var_2_10005 = true
				end

				setActive = var_2_10006

				var_2_10006(arg_26_1:Find("sel"), var_2_10005)

				IslandChatConst = var_2_10006

				local var_26_3 = var_2_10006.CHANNEL2CN(var_26_0)

				setText = var_7

				local var_26_4 = arg_26_1
				local var_26_5 = arg_26_1.Find(var_26_4, "Text")

				setColorStr = var_26_4

				var_7(var_26_5, var_26_4(var_26_3, var_2_10005 and "#393a3c" or "#FFFFFF"))

				return
			end
		end
	end)

	return
end

function var_0_1.Flush(arg_27_0, arg_27_1)
	arg_27_0:InitChatMsg(arg_27_1)
	arg_27_0:InitRoomNum()

	return
end

function var_0_1.InsertMsg(arg_28_0, arg_28_1, arg_28_2)
	getProxy = var_1_10003
	FriendProxy = var_1_10004

	local var_28_0 = var_1_10003(var_1_10004)

	if var_3.isInBlackList(var_28_0, arg_28_2.playerId) then
		return
	end

	if arg_28_2.player and arg_28_2.content then
		table = var_3

		var_3.insert(arg_28_1, arg_28_2)
	end

	return
end

function var_0_1.MatchChannel(arg_29_0, arg_29_1)
	bit = var_1_10002

	return var_1_10002.band(arg_29_0.channelValue, arg_29_1) > 0
end

function var_0_1.InitChatMsg(arg_30_0, arg_30_1)
	arg_30_0.displays = {}

	local var_30_0 = arg_30_0
	local var_30_1 = arg_30_0.MatchChannel

	IslandChatConst = var_1_10004

	if var_30_1(var_30_0, var_1_10004.CHANNEL_WORLD) then
		getProxy = var_2
		ChatProxy = var_30_0

		local var_30_2 = var_2(var_30_0)

		_ = var_30_0

		local var_30_3 = var_30_0.each

		var_1_10005 = var_30_2

		var_30_3(var_30_2.getRawData(var_1_10005), function(arg_31_0)
			local var_31_0 = arg_30_0

			var_1.InsertMsg(var_31_0, arg_30_0.displays, arg_31_0)

			return
		end)
	end

	local var_30_4 = arg_30_0
	local var_30_5 = arg_30_0.MatchChannel

	IslandChatConst = var_4

	local var_30_6

	if var_30_5(var_30_4, var_4.CHANNEL_GUILD) then
		getProxy = var_2
		GuildProxy = var_30_4
		var_30_6 = var_2(var_30_4)

		if var_2.getRawData(var_30_6) then
			_ = var_3

			local var_30_7 = var_3.each

			var_1_10005 = var_2

			var_30_7(var_2.getChatMsgs(var_1_10005), function(arg_32_0)
				local var_32_0 = arg_30_0

				var_1.InsertMsg(var_32_0, arg_30_0.displays, arg_32_0)

				return
			end)
		end
	end

	local var_30_8 = arg_30_0
	local var_30_9 = arg_30_0.MatchChannel

	IslandChatConst = var_30_6

	if var_30_9(var_30_8, var_30_6.CHANNEL_FRIEND) then
		getProxy = var_2
		FriendProxy = var_30_8

		local var_30_10 = var_2(var_30_8)

		_ = var_30_8

		local var_30_11 = var_30_8.each

		var_1_10005 = var_30_10

		var_30_11(var_30_10.getCacheMsgList(var_1_10005), function(arg_33_0)
			local var_33_0 = arg_30_0

			var_1.InsertMsg(var_33_0, arg_30_0.displays, arg_33_0)

			return
		end)
	end

	local var_30_12 = arg_30_0
	local var_30_13 = arg_30_0.MatchChannel

	IslandChatConst = var_4

	local var_30_15

	if var_30_13(var_30_12, var_4.CHANNEL_ISLAND) then
		local var_30_14 = arg_30_0:GetView()

		var_30_15 = var_30_15.GetIsland(var_30_14)
		_ = var_30_14

		local var_30_16 = var_30_14.each

		getProxy = var_4
		IslandProxy = var_1_10005

		local var_30_17 = var_4(var_1_10005)

		var_30_16(var_4.GetChatMsgList(var_30_17, var_30_15.id), function(arg_34_0)
			local var_34_0 = arg_30_0

			var_1.InsertMsg(var_34_0, arg_30_0.displays, arg_34_0)

			return
		end)
	end

	table = var_30_15

	var_30_15.sort(arg_30_0.displays, function(arg_35_0, arg_35_1)
		return arg_35_0.timestamp < arg_35_1.timestamp
	end)

	local var_30_18 = arg_30_0.scrollrect

	var_2.SetTotalCount(var_30_18, #arg_30_0.displays, arg_30_1 and 1 or -1)

	return
end

function var_0_1.OnInitItem(arg_36_0, arg_36_1)
	IslandChatCard = var_1_10002

	local var_36_0 = var_1_10002.New(arg_36_1)

	onButton = var_3

	var_3(arg_36_0, var_36_0.otherBubble.tf, function()
		local var_37_0 = var_36_0.sender.id
		local var_37_1 = var_36_0.otherBubble.circle.position
		local var_37_2 = var_36_0.data.content
		local var_37_3 = arg_36_0
		local var_37_4 = var_3.NotifiyMeditor

		IslandBaseMediator = var_2_10005

		var_37_4(var_37_3, var_2_10005.OPEN_FRIEND_INFO, var_37_0, var_37_1, var_37_2)

		return
	end)

	onButton = var_3

	local var_36_1 = arg_36_0
	local var_36_2 = var_36_0.otherBubble.tf

	var_3(var_36_1, var_5.Find(var_36_2, "chat_fram"), function()
		local var_38_0 = var_36_0.sender.id
		local var_38_1 = var_36_0
		local var_38_3

		if var_1.IsTradeLink(var_38_1) then
			local var_38_2 = arg_36_0

			var_38_3 = var_38_3.NotifiyMeditor
			IslandMediator = var_2_10003

			var_38_3(var_38_2, var_2_10003.ENTER_ISLAND, var_38_0)
		else
			triggerButton = var_38_3

			var_38_3(var_36_0.otherBubble.tf)
		end

		return
	end)

	arg_36_0.cards[arg_36_1] = var_36_0

	return
end

function var_0_1.OnUpdateItem(arg_39_0, arg_39_1, arg_39_2)
	local var_39_0

	if not arg_39_0.cards[arg_39_2] then
		arg_39_0:OnInitItem(arg_39_2)

		var_39_0 = arg_39_0.cards[arg_39_2]
	end

	local var_39_1 = arg_39_0.displays[arg_39_1 + 1]

	var_39_0:Update(var_39_1)

	return
end

function var_0_1.OnDispose(arg_40_0)
	var_0_1.super.OnDispose(arg_40_0)

	ClearLScrollrect = var_1

	var_1(arg_40_0.scrollrect)

	if arg_40_0.emojiAdaptor then
		local var_40_0 = arg_40_0.emojiAdaptor

		var_1.Dispose(var_40_0)

		arg_40_0.emojiAdaptor = nil
	end

	return
end

return var_0_1
