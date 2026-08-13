class = var_0_10000

local var_0_0 = "PlayRoomNotificationLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.BaseUI"))

var_0_1.InitCount = 10
var_0_1.MaxCount = 100
var_0_1.FORM_COMMON = 0
var_0_1.FORM_BATTLE = 1
var_0_1.FORM_MAIN = 2

local var_0_2 = {}

ChatConst = var_0_0
var_0_2.send = var_0_0.ChannelWorld
IndexConst = var_2

local var_0_3 = var_2.Flags2Bits
local var_0_4 = {}

ChatConst = var_5
var_0_4[1] = var_5.ChannelAll
var_0_2.recv = var_0_3(var_0_4)
var_0_1.ChannelBits = var_0_2

function var_0_1.getUIName(arg_1_0)
	return "IslandPlayRoomChatUI"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0.rtWindow

	arg_2_0.settingsBtn = var_1.Find(var_2_0, "top/settings")
	UIItemList = var_1

	local var_2_1 = var_1.New
	local var_2_2 = arg_2_0.rtWindow
	local var_2_3 = var_3.Find(var_2_2, "top/channels")
	local var_2_4 = arg_2_0.rtWindow

	arg_2_0.uiChannelList = var_2_1(var_2_3, var_4.Find(var_2_4, "top/channels/tpl"))

	local var_2_5 = arg_2_0.rtWindow

	arg_2_0.sendChanncelBtn = var_1.Find(var_2_5, "send_panel/channel_btn")

	local var_2_6 = arg_2_0.rtWindow
	local var_2_7 = var_1.Find(var_2_6, "send_panel/channel_btn/Text")
	local var_2_8 = var_1.GetComponent

	typeof = var_4
	Text = var_2_4
	arg_2_0.sendChanncelTxt = var_2_8(var_2_7, var_4(var_2_4))

	local var_2_9 = arg_2_0.rtWindow
	local var_2_10 = var_1.Find(var_2_9, "top/settings/Text")
	local var_2_11 = var_1.GetComponent

	typeof = var_4
	Text = var_2_4
	arg_2_0.roomNumTxt = var_2_11(var_2_10, var_4(var_2_4))

	local var_2_12 = arg_2_0.rtWindow
	local var_2_13 = var_1.Find(var_2_12, "list/content")

	arg_2_0.scrollrect = var_1.GetComponent(var_2_13, "LScrollRect")

	local var_2_14 = arg_2_0.rtWindow

	arg_2_0.emojiBtn = var_1.Find(var_2_14, "send_panel/input_panel/emoji")

	local var_2_15 = arg_2_0.rtWindow

	arg_2_0.sendBtn = var_1.Find(var_2_15, "send_panel/send_btn")

	local var_2_16 = arg_2_0.rtWindow
	local var_2_17 = var_1.Find(var_2_16, "send_panel/input_panel/input")
	local var_2_18 = var_1.GetComponent

	typeof = var_4
	InputField = var_2_4
	arg_2_0.inputField = var_2_18(var_2_17, var_4(var_2_4))
	UIItemList = var_1

	local var_2_19 = var_1.New
	local var_2_20 = arg_2_0.rtWindow
	local var_2_21 = var_3.Find(var_2_20, "send_panel/channel_sel_panel")
	local var_2_22 = arg_2_0.rtWindow

	arg_2_0.uiSendChanncelList = var_2_19(var_2_21, var_4.Find(var_2_22, "send_panel/channel_sel_panel/tpl"))
	PlayRoomChatConst = var_1
	arg_2_0.channelValue = var_1.CHANNEL_ALL
	PlayRoomChatConst = var_1
	arg_2_0.sendChannelValue = var_1.CHANNEL_PLAYROOM
	arg_2_0.cards = {}

	arg_2_0:InitChanncelToggles()
	arg_2_0:InitSendChannelName()
	arg_2_0:RegisterEvent()
	arg_2_0:BlurPanel(arg_2_0._tf)

	return
end

function var_0_1.RegisterEvent(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.rtBg

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.closeView(var_4_0)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10006)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.settingsBtn

	local function var_3_5()
		local var_5_0 = arg_3_0
		local var_5_1 = var_0.emit

		BaseUI = var_2_10003

		local var_5_2 = var_2_10003.ON_ADD_SUBLAYER

		Context = var_2_10004

		local var_5_3 = var_2_10004.New
		local var_5_4 = {}

		PlayRoomChatSettingsMsgboxMediator = var_2_10007
		var_5_4.mediator = var_2_10007
		PlayRoomChatSettingsMsgboxLayer = var_2_10007
		var_5_4.viewComponent = var_2_10007

		local var_5_5 = {}
		local var_5_6 = arg_3_0

		var_5_5.groupName = var_8.getGroupName(var_5_6)

		local var_5_7 = {
			sendChannelValue = arg_3_0.sendChannelValue,
			channelValue = arg_3_0.channelValue
		}

		i18n = var_9
		var_5_7.title = var_9("island_chat_settings")

		function var_5_7.onYes(arg_6_0, arg_6_1, arg_6_2)
			local var_6_0 = arg_3_0

			var_3.OnSettingEnd(var_6_0, arg_6_0, arg_6_1, arg_6_2)

			return
		end

		var_5_5.settings = var_5_7
		var_5_4.data = var_5_5

		var_5_1(var_5_0, var_5_2, var_5_3(var_5_4))

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10006)

	onButton = var_1_10001

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.emojiBtn

	local function var_3_8()
		local var_7_0 = {
			emojiIconCallback = function(arg_8_0)
				local var_8_0 = arg_3_0.inputField
				local var_8_1 = arg_3_0.inputField.text

				string = var_3_10003

				local var_8_2 = var_3_10003.gsub

				ChatConst = var_3_10005
				var_8_0.text = var_8_1 .. var_8_2(var_3_10005.EmojiIconCode, "code", arg_8_0)

				return
			end,
			callback = function(arg_9_0)
				setInputText = var_3_10001

				var_3_10001(arg_3_0.inputField, "")

				local var_9_0 = arg_3_0
				local var_9_1 = var_1.emit

				PlayRoomNotificationMediator = var_4

				local var_9_2 = var_4.SEND_CHAT
				local var_9_3 = arg_3_0.sendChannelValue

				string = var_3_10006

				local var_9_4 = var_3_10006.gsub

				ChatConst = var_3_10008

				var_9_1(var_9_0, var_9_2, var_9_3, var_9_4(var_3_10008.EmojiCode, "code", arg_9_0))

				return
			end,
			pos = arg_3_0.emojiBtn.position
		}
		local var_7_1 = arg_3_0

		var_7_0.groupName = var_1.getGroupName(var_7_1)

		local var_7_2 = arg_3_0
		local var_7_3 = var_1.emit

		PlayRoomNotificationMediator = var_2_10004

		var_7_3(var_7_2, var_2_10004.OPEN_EMOJI, var_7_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_6, var_3_7, var_3_8, var_1_10006)

	onButton = var_1_10001

	local var_3_9 = arg_3_0
	local var_3_10 = arg_3_0.sendBtn

	local function var_3_11()
		local var_10_0 = arg_3_0.inputField.text

		setInputText = var_2_10001

		var_2_10001(arg_3_0.inputField, "")

		local var_10_1 = arg_3_0
		local var_10_2 = var_1.emit

		PlayRoomNotificationMediator = var_4

		var_10_2(var_10_1, var_4.SEND_CHAT, arg_3_0.sendChannelValue, var_10_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_9, var_3_10, var_3_11, var_1_10006)

	onToggle = var_1_10001

	local var_3_12 = arg_3_0
	local var_3_13 = arg_3_0.sendChanncelBtn

	local function var_3_14(arg_11_0)
		if arg_11_0 then
			local var_11_0 = arg_3_0

			var_1.InitSendChannel(var_11_0)
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_12, var_3_13, var_3_14, var_1_10006)

	function arg_3_0.scrollrect.onInitItem(arg_12_0)
		local var_12_0 = arg_3_0

		var_1.OnInitItem(var_12_0, arg_12_0)

		return
	end

	function arg_3_0.scrollrect.onUpdateItem(arg_13_0, arg_13_1)
		local var_13_0 = arg_3_0

		var_2.OnUpdateItem(var_13_0, arg_13_0, arg_13_1)

		return
	end

	return
end

function var_0_1.OnSettingEnd(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
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
		local var_14_0 = arg_14_0
		local var_14_1 = arg_14_0.emit

		PlayRoomNotificationMediator = var_1_10007

		var_14_1(var_14_0, var_1_10007.CHANGE_CHAT_ROOM, arg_14_3)
	end

	return
end

function var_0_1.InitRoomNum(arg_15_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10003

	local var_15_0 = var_1_10001(var_1_10003)
	local var_15_1 = var_1.getRawData(var_15_0).chatRoomId
	local var_15_2 = arg_15_0.roomNumTxt

	if var_15_1 == 0 then
		i18n = var_15_0

		local var_15_3

		if not var_15_0("common_not_enter_room") then
			var_15_3 = var_15_1
		end

		var_15_2.text = var_15_3
		arg_15_0.chatRoomId = var_15_1

		return
	end
end

function var_0_1.InitSendChannel(arg_16_0)
	PlayRoomChatConst = var_1_10001

	local var_16_0 = var_1_10001.SEND_CHANNELS
	local var_16_1 = arg_16_0.uiSendChanncelList

	var_2.make(var_16_1, function(arg_17_0, arg_17_1, arg_17_2)
		UIItemList = var_2_10003

		if arg_17_0 == var_2_10003.EventUpdate then
			local var_17_0 = var_16_0[arg_17_1 + 1]

			onButton = var_4

			local var_17_1 = arg_16_0
			local var_17_2 = arg_17_2

			local function var_17_3()
				local var_18_0 = var_17_0

				PlayRoomChatConst = var_3_10001

				if var_18_0 == var_3_10001.CHANNEL_GUILD then
					getProxy = var_18_0
					GuildProxy = var_3_10002

					local var_18_1 = var_18_0(var_3_10002)

					if var_0.getRawData(var_18_1) == nil then
						return
					end
				end

				arg_16_0.sendChannelValue = var_17_0

				local var_18_2 = arg_16_0

				var_0.InitSendChannelName(var_18_2)

				triggerToggle = var_0

				var_0(arg_16_0.sendChanncelBtn, false)

				return
			end

			SFX_PANEL = var_2_10009

			var_4(var_17_1, var_17_2, var_17_3, var_2_10009)

			PlayRoomChatConst = var_4

			local var_17_4 = var_4.CHANNEL2CN(var_17_0)

			setText = var_2_10005

			local var_17_5 = arg_17_2:Find("Text")

			setColorStr = var_17_3

			var_2_10005(var_17_5, var_17_3(var_17_4, var_17_0 == arg_16_0.sendChannelValue and "#5ccaff" or "#ffffff"))
		end

		return
	end)

	local var_16_2 = arg_16_0.uiSendChanncelList

	var_2.align(var_16_2, #var_16_0)

	return
end

function var_0_1.InitSendChannelName(arg_19_0)
	PlayRoomChatConst = var_1_10001

	local var_19_0 = var_1_10001.CHANNEL2CN(arg_19_0.sendChannelValue)

	arg_19_0.sendChanncelTxt.text = var_19_0

	return
end

function var_0_1.InitChanncelToggles(arg_20_0)
	PlayRoomChatConst = var_1_10001

	local var_20_0 = var_1_10001.CHANNELS
	local var_20_1 = arg_20_0.uiChannelList

	var_2.make(var_20_1, function(arg_21_0, arg_21_1, arg_21_2)
		UIItemList = var_2_10003

		if arg_21_0 == var_2_10003.EventUpdate then
			local var_21_0 = var_20_0[arg_21_1 + 1]

			onButton = var_4

			local var_21_1 = arg_20_0
			local var_21_2 = arg_21_2

			local function var_21_3()
				local var_22_0 = arg_20_0

				var_0.UpdatteChannelValue(var_22_0, var_21_0)

				local var_22_1 = arg_20_0

				var_0.Flush(var_22_1, false)

				return
			end

			SFX_PANEL = var_2_10009

			var_4(var_21_1, var_21_2, var_21_3, var_2_10009)
		end

		return
	end)

	local var_20_2 = arg_20_0.uiChannelList

	var_2.align(var_20_2, #var_20_0)

	local var_20_3 = arg_20_0
	local var_20_4 = arg_20_0.UpdatteChannelValue

	PlayRoomChatConst = var_5

	var_20_4(var_20_3, var_5.CHANNEL_PLAYROOM)

	return
end

function var_0_1.UpdatteChannelValue(arg_23_0, arg_23_1)
	PlayRoomChatConst = var_1_10002

	if arg_23_1 == var_1_10002.CHANNEL_ALL then
		PlayRoomChatConst = var_2
		arg_23_0.channelValue = var_2.CHANNEL_ALL
	else
		bit = var_2

		local var_23_0 = var_2.band(arg_23_0.channelValue, arg_23_1)
		local var_23_1

		if 0 < var_23_0 then
			var_23_1 = arg_23_0.channelValue
			PlayRoomChatConst = var_4

			if var_23_1 == var_4.CHANNEL_ALL then
				arg_23_0.channelValue = arg_23_1
			else
				bit = var_23_1
				arg_23_0.channelValue = var_23_1.bxor(arg_23_0.channelValue, arg_23_1)
			end
		else
			bit = var_23_1
			arg_23_0.channelValue = var_23_1.bor(arg_23_0.channelValue, arg_23_1)
		end

		if arg_23_0.channelValue <= 0 then
			PlayRoomChatConst = var_3
			arg_23_0.channelValue = var_3.CHANNEL_ALL
		end
	end

	arg_23_0:UpdateChannelToggles()

	return
end

function var_0_1.UpdateChannelToggles(arg_24_0)
	PlayRoomChatConst = var_1_10001

	local var_24_0 = var_1_10001.CHANNELS
	local var_24_1 = arg_24_0.uiChannelList

	var_2.eachActive(var_24_1, function(arg_25_0, arg_25_1)
		local var_25_0 = var_24_0[arg_25_0 + 1]
		local var_25_1 = arg_24_0.channelValue

		PlayRoomChatConst = var_2_10004

		local var_25_2 = var_25_1 == var_2_10004.CHANNEL_ALL

		PlayRoomChatConst = var_4

		if not (var_25_0 == var_4.CHANNEL_ALL) or not var_25_2 then
			::label_25_0::

			if not var_4 and not var_25_2 then
				bit = var_2_10005
				var_2_10005 = var_2_10005.band(arg_24_0.channelValue, var_25_0)

				if not (0 < var_2_10005) then
					var_2_10005 = false
				else
					var_2_10005 = true
				end

				setActive = var_2_10006

				local var_25_3 = arg_25_1

				var_2_10006(arg_25_1.Find(var_25_3, "sel"), var_2_10005)

				PlayRoomChatConst = var_2_10006

				local var_25_4 = var_2_10006.CHANNEL2CN(var_25_0)

				setText = var_2_10007

				local var_25_5 = arg_25_1:Find("Text")

				setColorStr = var_25_3

				var_2_10007(var_25_5, var_25_3(var_25_4, var_2_10005 and "#393a3c" or "#FFFFFF"))

				return
			end
		end
	end)

	return
end

function var_0_1.Flush(arg_26_0, arg_26_1)
	arg_26_0:InitChatMsg(arg_26_1)
	arg_26_0:InitRoomNum()

	return
end

function var_0_1.InsertMsg(arg_27_0, arg_27_1, arg_27_2)
	getProxy = var_1_10003
	FriendProxy = var_1_10005

	local var_27_0 = var_1_10003(var_1_10005)

	if var_3.isInBlackList(var_27_0, arg_27_2.playerId) then
		return
	end

	if arg_27_2.player and arg_27_2.content then
		table = var_3

		var_3.insert(arg_27_1, arg_27_2)
	end

	return
end

function var_0_1.MatchChannel(arg_28_0, arg_28_1)
	bit = var_1_10002

	return var_1_10002.band(arg_28_0.channelValue, arg_28_1) > 0
end

function var_0_1.InitChatMsg(arg_29_0, arg_29_1)
	arg_29_0.displays = {}

	local var_29_0 = arg_29_0
	local var_29_1 = arg_29_0.MatchChannel

	PlayRoomChatConst = var_1_10005

	if var_29_1(var_29_0, var_1_10005.CHANNEL_WORLD) then
		getProxy = var_2
		ChatProxy = var_29_0

		local var_29_2 = var_2(var_29_0)

		_ = var_1_10003

		var_1_10003.each(var_29_2:getRawData(), function(arg_30_0)
			local var_30_0 = arg_29_0

			var_1.InsertMsg(var_30_0, arg_29_0.displays, arg_30_0)

			return
		end)
	end

	local var_29_3 = arg_29_0
	local var_29_4 = arg_29_0.MatchChannel

	PlayRoomChatConst = var_5

	local var_29_5

	if var_29_4(var_29_3, var_5.CHANNEL_GUILD) then
		getProxy = var_2
		GuildProxy = var_29_3
		var_29_5 = var_2(var_29_3)

		if var_2.getRawData(var_29_5) then
			_ = var_1_10003

			var_1_10003.each(var_2:getChatMsgs(), function(arg_31_0)
				local var_31_0 = arg_29_0

				var_1.InsertMsg(var_31_0, arg_29_0.displays, arg_31_0)

				return
			end)
		end
	end

	local var_29_6 = arg_29_0
	local var_29_7 = arg_29_0.MatchChannel

	PlayRoomChatConst = var_29_5

	if var_29_7(var_29_6, var_29_5.CHANNEL_FRIEND) then
		getProxy = var_2
		FriendProxy = var_29_6

		local var_29_8 = var_2(var_29_6)

		_ = var_1_10003

		var_1_10003.each(var_29_8:getCacheMsgList(), function(arg_32_0)
			local var_32_0 = arg_29_0

			var_1.InsertMsg(var_32_0, arg_29_0.displays, arg_32_0)

			return
		end)
	end

	local var_29_9 = arg_29_0
	local var_29_10 = arg_29_0.MatchChannel

	PlayRoomChatConst = var_5

	local var_29_11

	if var_29_10(var_29_9, var_5.CHANNEL_PLAYROOM) then
		_ = var_29_11
		var_29_11 = var_29_11.each
		getProxy = var_29_9
		PlayRoomProxy = var_1_10006

		local var_29_12 = var_29_9(var_1_10006)

		var_29_11(var_4.GetChatMsgs(var_29_12), function(arg_33_0)
			local var_33_0 = arg_29_0

			var_1.InsertMsg(var_33_0, arg_29_0.displays, arg_33_0)

			return
		end)
	end

	table = var_29_11

	var_29_11.sort(arg_29_0.displays, function(arg_34_0, arg_34_1)
		return arg_34_0.timestamp < arg_34_1.timestamp
	end)

	onNextTick = var_2

	var_2(function()
		local var_35_0 = arg_29_0.scrollrect

		var_0.SetTotalCount(var_35_0, #arg_29_0.displays, arg_29_1 and 1 or -1)

		return
	end)

	return
end

function var_0_1.OnInitItem(arg_36_0, arg_36_1)
	IslandChatCard = var_1_10002

	local var_36_0 = var_1_10002.New(arg_36_1)

	onButton = var_1_10003

	var_1_10003(arg_36_0, var_36_0.otherBubble.tf, function()
		local var_37_0 = var_36_0.sender.id
		local var_37_1 = var_36_0.otherBubble.circle.position
		local var_37_2 = var_36_0.data.content
		local var_37_3 = arg_36_0
		local var_37_4 = var_3.emit

		PlayRoomNotificationMediator = var_2_10006

		var_37_4(var_37_3, var_2_10006.OPEN_FRIEND_INFO, var_37_0, var_37_1, var_37_2)

		return
	end)

	arg_36_0.cards[arg_36_1] = var_36_0

	return
end

function var_0_1.OnUpdateItem(arg_38_0, arg_38_1, arg_38_2)
	local var_38_0

	if not arg_38_0.cards[arg_38_2] then
		arg_38_0:OnInitItem(arg_38_2)

		var_38_0 = arg_38_0.cards[arg_38_2]
	end

	local var_38_1 = arg_38_0.displays[arg_38_1 + 1]

	var_38_0:Update(var_38_1)

	return
end

function var_0_1.didEnter(arg_39_0)
	arg_39_0:Flush()

	return
end

function var_0_1.willExit(arg_40_0)
	arg_40_0:UnOverlayPanel(arg_40_0._tf)

	ClearLScrollrect = var_1

	var_1(arg_40_0.scrollrect)

	return
end

return var_0_1
