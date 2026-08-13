class = var_0_10000

local var_0_0 = "IslandChatSettingsMsgboxWindow"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".IslandCommonMsgboxWindow"))

function var_0_1.getUIName(arg_1_0)
	return "IslandChatSettingsMsgBox"
end

function var_0_1.OnLoaded(arg_2_0)
	var_0_1.super.OnLoaded(arg_2_0)

	UIItemList = var_1

	local var_2_0 = var_1.New
	local var_2_1 = arg_2_0._tf
	local var_2_2 = var_2.Find(var_2_1, "send_channel/list")
	local var_2_3 = arg_2_0._tf

	arg_2_0.uiSendChanncelList = var_2_0(var_2_2, var_3.Find(var_2_3, "send_channel/list/tpl"))
	UIItemList = var_1

	local var_2_4 = var_1.New
	local var_2_5 = arg_2_0._tf
	local var_2_6 = var_2.Find(var_2_5, "channels/list")
	local var_2_7 = arg_2_0._tf

	arg_2_0.uiChanncelList = var_2_4(var_2_6, var_3.Find(var_2_7, "send_channel/list/tpl"))

	local var_2_8 = arg_2_0._tf

	arg_2_0.roomInput = var_1.Find(var_2_8, "room/room")
	setText = var_1

	local var_2_9 = arg_2_0._tf
	local var_2_10 = var_2.Find(var_2_9, "send_channel/Text")

	i18n = var_2_9

	var_1(var_2_10, var_2_9("notice_label_send"))

	setText = var_1

	local var_2_11 = arg_2_0._tf
	local var_2_12 = var_2.Find(var_2_11, "channels/Text")

	i18n = var_2_11

	var_1(var_2_12, var_2_11("notice_label_recv"))

	setText = var_1

	local var_2_13 = arg_2_0._tf
	local var_2_14 = var_2.Find(var_2_13, "room/Text")

	i18n = var_2_13

	var_1(var_2_14, var_2_13("notice_label_room"))

	setText = var_1

	local var_2_15 = arg_2_0._tf
	local var_2_16 = var_2.Find(var_2_15, "room/tip")

	i18n = var_2_15

	var_1(var_2_16, var_2_15("notice_label_tip"))
	arg_2_0:InitSendChannel()
	arg_2_0:InitChannels()

	return
end

function var_0_1.OnInit(arg_3_0)
	var_0_1.super.OnInit(arg_3_0)

	onButton = var_1

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.confirmBtn

	local function var_3_2()
		if arg_3_0.onYes then
			getInputText = var_0

			local var_4_0 = var_0(arg_3_0.roomInput)
			local var_4_1 = arg_3_0.onYes
			local var_4_2 = arg_3_0.sendChannelValue
			local var_4_3 = arg_3_0.channelValue

			tonumber = var_2_10004

			var_4_1(var_4_2, var_4_3, var_2_10004(var_4_0))
		end

		local var_4_4 = arg_3_0

		var_0.Hide(var_4_4)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_3_0, var_3_1, var_3_2, var_1_10005)

	return
end

function var_0_1.OnShow(arg_5_0)
	var_0_1.super.OnShow(arg_5_0)

	arg_5_0.sendChannelValue = arg_5_0.settings.sendChannelValue
	arg_5_0.channelValue = var_1.channelValue

	arg_5_0:FlushSendChannel()
	arg_5_0:FlushChannels()
	arg_5_0:FlushRoom()

	return
end

function var_0_1.InitSendChannel(arg_6_0)
	IslandChatConst = var_1_10001

	local var_6_0 = var_1_10001.SEND_CHANNELS
	local var_6_1 = arg_6_0.uiSendChanncelList

	var_2.make(var_6_1, function(arg_7_0, arg_7_1, arg_7_2)
		UIItemList = var_2_10003

		if arg_7_0 == var_2_10003.EventUpdate then
			local var_7_0 = var_6_0[arg_7_1 + 1]

			onButton = var_4

			local var_7_1 = arg_6_0
			local var_7_2 = arg_7_2

			local function var_7_3()
				local var_8_0 = var_7_0

				IslandChatConst = var_3_10001

				if var_8_0 == var_3_10001.CHANNEL_GUILD then
					getProxy = var_8_0
					GuildProxy = var_1

					local var_8_1 = var_8_0(var_1)

					if var_0.getRawData(var_8_1) == nil then
						return
					end
				end

				arg_6_0.sendChannelValue = var_7_0

				local var_8_2 = arg_6_0

				var_0.FlushSendChannel(var_8_2)

				return
			end

			SFX_PANEL = var_2_10008

			var_4(var_7_1, var_7_2, var_7_3, var_2_10008)

			setActive = var_4

			var_4(arg_7_2:Find("line"), #var_6_0 ~= arg_7_1 + 1)
		end

		return
	end)

	local var_6_2 = arg_6_0.uiSendChanncelList

	var_2.align(var_6_2, #var_6_0)

	return
end

function var_0_1.InitChannels(arg_9_0)
	IslandChatConst = var_1_10001

	local var_9_0 = var_1_10001.CHANNELS
	local var_9_1 = arg_9_0.uiChanncelList

	var_2.make(var_9_1, function(arg_10_0, arg_10_1, arg_10_2)
		UIItemList = var_2_10003

		if arg_10_0 == var_2_10003.EventUpdate then
			local var_10_0 = var_9_0[arg_10_1 + 1]

			onButton = var_4

			local var_10_1 = arg_9_0
			local var_10_2 = arg_10_2

			local function var_10_3()
				local var_11_0 = arg_9_0

				var_0.UpdatteChannelValue(var_11_0, var_10_0)

				local var_11_1 = arg_9_0

				var_0.FlushChannels(var_11_1)

				return
			end

			SFX_PANEL = var_2_10008

			var_4(var_10_1, var_10_2, var_10_3, var_2_10008)

			local var_10_4 = (arg_10_1 + 1) % 3 == 0
			local var_10_5 = #var_9_0 == var_4

			setActive = var_10_3

			var_10_3(arg_10_2:Find("line"), not var_10_5 and not var_10_4)
		end

		return
	end)

	local var_9_2 = arg_9_0.uiChanncelList

	var_2.align(var_9_2, #var_9_0)

	return
end

function var_0_1.FlushSendChannel(arg_12_0)
	IslandChatConst = var_1_10001

	local var_12_0 = var_1_10001.SEND_CHANNELS
	local var_12_1 = arg_12_0.uiSendChanncelList

	var_2.eachActive(var_12_1, function(arg_13_0, arg_13_1)
		local var_13_0 = var_12_0[arg_13_0 + 1] == arg_12_0.sendChannelValue

		setActive = var_2_10004

		var_2_10004(arg_13_1:Find("mark"), var_13_0)

		IslandChatConst = var_2_10004

		local var_13_1 = var_2_10004.CHANNEL2CN(var_2)

		setText = var_5

		local var_13_2 = arg_13_1
		local var_13_3 = arg_13_1.Find(var_13_2, "Text")

		setColorStr = var_13_2

		var_5(var_13_3, var_13_2(var_13_1, var_13_0 and "#FFFFFF" or "#393a3c"))

		return
	end)

	return
end

function var_0_1.FlushChannels(arg_14_0)
	IslandChatConst = var_1_10001

	local var_14_0 = var_1_10001.CHANNELS
	local var_14_1 = arg_14_0.uiChanncelList

	var_2.eachActive(var_14_1, function(arg_15_0, arg_15_1)
		local var_15_0 = var_14_0[arg_15_0 + 1]
		local var_15_1 = arg_14_0.channelValue

		IslandChatConst = var_2_10004

		local var_15_2 = var_15_1 == var_2_10004.CHANNEL_ALL

		IslandChatConst = var_4

		if not (var_15_0 == var_4.CHANNEL_ALL) or not var_15_2 then
			::label_15_0::

			if not var_4 and not var_15_2 then
				bit = var_2_10005
				var_2_10005 = var_2_10005.band(arg_14_0.channelValue, var_15_0)

				if not (0 < var_2_10005) then
					var_2_10005 = false
				else
					var_2_10005 = true
				end

				setActive = var_2_10006

				var_2_10006(arg_15_1:Find("mark"), var_2_10005)

				IslandChatConst = var_2_10006

				local var_15_3 = var_2_10006.CHANNEL2CN(var_15_0)

				setText = var_7

				local var_15_4 = arg_15_1
				local var_15_5 = arg_15_1.Find(var_15_4, "Text")

				setColorStr = var_15_4

				var_7(var_15_5, var_15_4(var_15_3, var_2_10005 and "#FFFFFF" or "#393a3c"))

				return
			end
		end
	end)

	return
end

function var_0_1.FlushRoom(arg_16_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10002

	local var_16_0 = var_1_10001(var_1_10002)
	local var_16_1 = var_1.getRawData(var_16_0).chatRoomId

	setInputText = var_16_0

	var_16_0(arg_16_0.roomInput, var_16_1)

	return
end

function var_0_1.UpdatteChannelValue(arg_17_0, arg_17_1)
	IslandChatConst = var_1_10002

	if arg_17_1 == var_1_10002.CHANNEL_ALL then
		IslandChatConst = var_2
		arg_17_0.channelValue = var_2.CHANNEL_ALL
	else
		bit = var_2

		local var_17_0 = var_2.band(arg_17_0.channelValue, arg_17_1)
		local var_17_1

		if 0 < var_17_0 then
			var_17_1 = arg_17_0.channelValue
			IslandChatConst = var_4

			if var_17_1 == var_4.CHANNEL_ALL then
				arg_17_0.channelValue = arg_17_1
			else
				bit = var_17_1
				arg_17_0.channelValue = var_17_1.bxor(arg_17_0.channelValue, arg_17_1)
			end
		else
			bit = var_17_1
			arg_17_0.channelValue = var_17_1.bor(arg_17_0.channelValue, arg_17_1)
		end

		if arg_17_0.channelValue <= 0 then
			IslandChatConst = var_3
			arg_17_0.channelValue = var_3.CHANNEL_ALL
		end
	end

	return
end

return var_0_1
