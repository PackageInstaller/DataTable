class = var_0_10000

local var_0_0 = "PlayRoomChatSettingsMsgboxLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "IslandPlayRoomChatSettingsMsgBox"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0.rtPage
	local var_2_1 = var_1.Find(var_2_0, "title")
	local var_2_2 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.titleTxt = var_2_2(var_2_1, var_3(var_1_10004))

	local var_2_3 = arg_2_0.rtPage
	local var_2_4 = var_1.Find(var_2_3, "content/Text")

	arg_2_0.contentTxt = var_1.GetComponent(var_2_4, "RichText")

	local var_2_5 = arg_2_0.rtPage

	arg_2_0.closeBtn = var_1.Find(var_2_5, "close")

	local var_2_6 = arg_2_0.rtPage

	arg_2_0.cancelBtn = var_1.Find(var_2_6, "cancel")

	local var_2_7 = arg_2_0.rtPage

	arg_2_0.confirmBtn = var_1.Find(var_2_7, "confirm")

	local var_2_8 = arg_2_0.rtPage
	local var_2_9 = var_1.Find(var_2_8, "cancel/Text")
	local var_2_10 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.cancelTxt = var_2_10(var_2_9, var_3(var_1_10004))

	local var_2_11 = arg_2_0.rtPage
	local var_2_12 = var_1.Find(var_2_11, "confirm/Text")
	local var_2_13 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.confirmTxt = var_2_13(var_2_12, var_3(var_1_10004))
	UIItemList = var_1

	local var_2_14 = var_1.New
	local var_2_15 = arg_2_0.rtPage
	local var_2_16 = var_2.Find(var_2_15, "send_channel/list")
	local var_2_17 = arg_2_0.rtPage

	arg_2_0.uiSendChanncelList = var_2_14(var_2_16, var_3.Find(var_2_17, "send_channel/list/tpl"))
	UIItemList = var_1

	local var_2_18 = var_1.New
	local var_2_19 = arg_2_0.rtPage
	local var_2_20 = var_2.Find(var_2_19, "channels/list")
	local var_2_21 = arg_2_0.rtPage

	arg_2_0.uiChanncelList = var_2_18(var_2_20, var_3.Find(var_2_21, "send_channel/list/tpl"))

	local var_2_22 = arg_2_0.rtPage

	arg_2_0.roomInput = var_1.Find(var_2_22, "room/room")
	setText = var_1

	local var_2_23 = arg_2_0.rtPage
	local var_2_24 = var_2.Find(var_2_23, "send_channel/Text")

	i18n = var_2_23

	var_1(var_2_24, var_2_23("notice_label_send"))

	setText = var_1

	local var_2_25 = arg_2_0.rtPage
	local var_2_26 = var_2.Find(var_2_25, "channels/Text")

	i18n = var_2_25

	var_1(var_2_26, var_2_25("notice_label_recv"))

	setText = var_1

	local var_2_27 = arg_2_0.rtPage
	local var_2_28 = var_2.Find(var_2_27, "room/Text")

	i18n = var_2_27

	var_1(var_2_28, var_2_27("notice_label_room"))

	setText = var_1

	local var_2_29 = arg_2_0.rtPage
	local var_2_30 = var_2.Find(var_2_29, "room/tip")

	i18n = var_2_29

	var_1(var_2_30, var_2_29("notice_label_tip"))
	arg_2_0:InitSendChannel()
	arg_2_0:InitChannels()
	arg_2_0:OverlayPanel(arg_2_0._tf)

	return
end

function var_0_1.didEnter(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.rtBg

	local function var_3_2()
		local var_4_0 = arg_3_0.onNo
		local var_4_1 = arg_3_0

		var_1.closeView(var_4_1)

		existCall = var_1

		var_1(var_4_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10005)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.cancelBtn

	local function var_3_5()
		local var_5_0 = arg_3_0.onNo
		local var_5_1 = arg_3_0

		var_1.closeView(var_5_1)

		existCall = var_1

		var_1(var_5_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10005)

	onButton = var_1_10001

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.closeBtn

	local function var_3_8()
		local var_6_0 = arg_3_0

		var_0.closeView(var_6_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_6, var_3_7, var_3_8, var_1_10005)

	onButton = var_1_10001

	local var_3_9 = arg_3_0
	local var_3_10 = arg_3_0.confirmBtn

	local function var_3_11()
		local var_7_0 = arg_3_0.onYes
		local var_7_1 = arg_3_0

		var_1.closeView(var_7_1)

		existCall = var_1

		var_1(var_7_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_9, var_3_10, var_3_11, var_1_10005)

	onButton = var_1_10001

	local var_3_12 = arg_3_0
	local var_3_13 = arg_3_0.confirmBtn

	local function var_3_14()
		local var_8_0

		var_8_0, existCall = arg_3_0.onYes, var_2_10001

		local var_8_1 = arg_3_0.sendChannelValue
		local var_8_2 = arg_3_0.channelValue

		tonumber = var_2_10005
		getInputText = var_2_10006

		var_2_10001(var_8_0, var_8_1, var_8_2, var_2_10005(var_2_10006(arg_3_0.roomInput)))

		local var_8_3 = arg_3_0

		var_1.closeView(var_8_3)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_12, var_3_13, var_3_14, var_1_10005)

	if arg_3_0.contextData.settings.rawIconDic then
		pairs = var_2

		for iter_3_0, iter_3_1 in var_2(var_1.rawIconDic) do
			local var_3_15 = arg_3_0.contentTxt

			var_7.AddSprite(var_3_15, iter_3_0, iter_3_1)
		end
	end

	local var_3_16 = arg_3_0.titleTxt
	local var_3_17

	if not var_1.title then
		i18n = var_3_17
		var_3_17 = var_3_17("island_msg_info")
	end

	var_3_16.text = var_3_17

	local var_3_18 = arg_3_0.contentTxt
	local var_3_19

	if not var_1.content then
		var_3_19 = ""
	end

	var_3_18.text = var_3_19
	arg_3_0.onYes = var_1.onYes
	arg_3_0.onNo = var_1.onNo
	arg_3_0.onHide = var_1.onHide

	arg_3_0:FlushBtn(var_1)

	arg_3_0.sendChannelValue = var_1.sendChannelValue
	arg_3_0.channelValue = var_1.channelValue

	arg_3_0:FlushSendChannel()
	arg_3_0:FlushChannels()
	arg_3_0:FlushRoom()

	return
end

function var_0_1.InitSendChannel(arg_9_0)
	PlayRoomChatConst = var_1_10001

	local var_9_0 = var_1_10001.SEND_CHANNELS
	local var_9_1 = arg_9_0.uiSendChanncelList

	var_2.make(var_9_1, function(arg_10_0, arg_10_1, arg_10_2)
		UIItemList = var_2_10003

		if arg_10_0 == var_2_10003.EventUpdate then
			local var_10_0 = var_9_0[arg_10_1 + 1]

			onButton = var_4

			local var_10_1 = arg_9_0
			local var_10_2 = arg_10_2

			local function var_10_3()
				local var_11_0 = var_10_0

				PlayRoomChatConst = var_3_10001

				if var_11_0 == var_3_10001.CHANNEL_GUILD then
					getProxy = var_11_0
					GuildProxy = var_1

					local var_11_1 = var_11_0(var_1)

					if var_0.getRawData(var_11_1) == nil then
						return
					end
				end

				arg_9_0.sendChannelValue = var_10_0

				local var_11_2 = arg_9_0

				var_0.FlushSendChannel(var_11_2)

				return
			end

			SFX_PANEL = var_2_10008

			var_4(var_10_1, var_10_2, var_10_3, var_2_10008)

			setActive = var_4

			var_4(arg_10_2:Find("line"), #var_9_0 ~= arg_10_1 + 1)
		end

		return
	end)

	local var_9_2 = arg_9_0.uiSendChanncelList

	var_2.align(var_9_2, #var_9_0)

	return
end

function var_0_1.InitChannels(arg_12_0)
	PlayRoomChatConst = var_1_10001

	local var_12_0 = var_1_10001.CHANNELS
	local var_12_1 = arg_12_0.uiChanncelList

	var_2.make(var_12_1, function(arg_13_0, arg_13_1, arg_13_2)
		UIItemList = var_2_10003

		if arg_13_0 == var_2_10003.EventUpdate then
			local var_13_0 = var_12_0[arg_13_1 + 1]

			onButton = var_4

			local var_13_1 = arg_12_0
			local var_13_2 = arg_13_2

			local function var_13_3()
				local var_14_0 = arg_12_0

				var_0.UpdatteChannelValue(var_14_0, var_13_0)

				local var_14_1 = arg_12_0

				var_0.FlushChannels(var_14_1)

				return
			end

			SFX_PANEL = var_2_10008

			var_4(var_13_1, var_13_2, var_13_3, var_2_10008)

			local var_13_4 = (arg_13_1 + 1) % 3 == 0
			local var_13_5 = #var_12_0 == var_4

			setActive = var_13_3

			var_13_3(arg_13_2:Find("line"), not var_13_5 and not var_13_4)
		end

		return
	end)

	local var_12_2 = arg_12_0.uiChanncelList

	var_2.align(var_12_2, #var_12_0)

	return
end

function var_0_1.FlushSendChannel(arg_15_0)
	PlayRoomChatConst = var_1_10001

	local var_15_0 = var_1_10001.SEND_CHANNELS
	local var_15_1 = arg_15_0.uiSendChanncelList

	var_2.eachActive(var_15_1, function(arg_16_0, arg_16_1)
		local var_16_0 = var_15_0[arg_16_0 + 1] == arg_15_0.sendChannelValue

		setActive = var_2_10004

		var_2_10004(arg_16_1:Find("mark"), var_16_0)

		PlayRoomChatConst = var_2_10004

		local var_16_1 = var_2_10004.CHANNEL2CN(var_2)

		setText = var_5

		local var_16_2 = arg_16_1
		local var_16_3 = arg_16_1.Find(var_16_2, "Text")

		setColorStr = var_16_2

		var_5(var_16_3, var_16_2(var_16_1, var_16_0 and "#FFFFFF" or "#393a3c"))

		return
	end)

	return
end

function var_0_1.FlushChannels(arg_17_0)
	PlayRoomChatConst = var_1_10001

	local var_17_0 = var_1_10001.CHANNELS
	local var_17_1 = arg_17_0.uiChanncelList

	var_2.eachActive(var_17_1, function(arg_18_0, arg_18_1)
		local var_18_0 = var_17_0[arg_18_0 + 1]
		local var_18_1 = arg_17_0.channelValue

		PlayRoomChatConst = var_2_10004

		local var_18_2 = var_18_1 == var_2_10004.CHANNEL_ALL

		PlayRoomChatConst = var_4

		if not (var_18_0 == var_4.CHANNEL_ALL) or not var_18_2 then
			::label_18_0::

			if not var_4 and not var_18_2 then
				bit = var_2_10005
				var_2_10005 = var_2_10005.band(arg_17_0.channelValue, var_18_0)

				if not (0 < var_2_10005) then
					var_2_10005 = false
				else
					var_2_10005 = true
				end

				setActive = var_2_10006

				var_2_10006(arg_18_1:Find("mark"), var_2_10005)

				PlayRoomChatConst = var_2_10006

				local var_18_3 = var_2_10006.CHANNEL2CN(var_18_0)

				setText = var_7

				local var_18_4 = arg_18_1
				local var_18_5 = arg_18_1.Find(var_18_4, "Text")

				setColorStr = var_18_4

				var_7(var_18_5, var_18_4(var_18_3, var_2_10005 and "#FFFFFF" or "#393a3c"))

				return
			end
		end
	end)

	return
end

function var_0_1.FlushRoom(arg_19_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10002

	local var_19_0 = var_1_10001(var_1_10002)
	local var_19_1 = var_1.getRawData(var_19_0).chatRoomId

	setInputText = var_19_0

	var_19_0(arg_19_0.roomInput, var_19_1)

	return
end

function var_0_1.FlushBtn(arg_20_0, arg_20_1)
	setActive = var_1_10002

	var_1_10002(arg_20_0.cancelBtn, not arg_20_1.hideNo)

	local var_20_0 = arg_20_1.hideNo and 880 or 420
	local var_20_1 = arg_20_0.confirmBtn

	Vector2 = var_4
	var_20_1.sizeDelta = var_4(var_20_0, arg_20_0.confirmBtn.sizeDelta.y)

	local var_20_2 = arg_20_0.cancelTxt
	local var_20_3

	if not arg_20_1.noText or not arg_20_1.noText then
		i18n = var_20_3
		var_20_3 = var_20_3("word_cancel")
	end

	var_20_2.text = var_20_3

	local var_20_4 = arg_20_0.confirmTxt
	local var_20_5

	if not arg_20_1.yesText or not arg_20_1.yesText then
		i18n = var_20_5
		var_20_5 = var_20_5("word_ok")
	end

	var_20_4.text = var_20_5

	return
end

function var_0_1.UpdatteChannelValue(arg_21_0, arg_21_1)
	PlayRoomChatConst = var_1_10002

	if arg_21_1 == var_1_10002.CHANNEL_ALL then
		PlayRoomChatConst = var_2
		arg_21_0.channelValue = var_2.CHANNEL_ALL
	else
		bit = var_2

		local var_21_0 = var_2.band(arg_21_0.channelValue, arg_21_1)
		local var_21_1

		if 0 < var_21_0 then
			var_21_1 = arg_21_0.channelValue
			PlayRoomChatConst = var_4

			if var_21_1 == var_4.CHANNEL_ALL then
				arg_21_0.channelValue = arg_21_1
			else
				bit = var_21_1
				arg_21_0.channelValue = var_21_1.bxor(arg_21_0.channelValue, arg_21_1)
			end
		else
			bit = var_21_1
			arg_21_0.channelValue = var_21_1.bor(arg_21_0.channelValue, arg_21_1)
		end

		if arg_21_0.channelValue <= 0 then
			PlayRoomChatConst = var_3
			arg_21_0.channelValue = var_3.CHANNEL_ALL
		end
	end

	return
end

function var_0_1.willExit(arg_22_0)
	arg_22_0:UnOverlayPanel(arg_22_0._tf)

	if arg_22_0.onHide then
		arg_22_0.onHide()

		arg_22_0.onHide = nil
	end

	return
end

return var_0_1
