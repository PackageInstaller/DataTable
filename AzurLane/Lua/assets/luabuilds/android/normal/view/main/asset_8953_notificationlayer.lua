class = var_0_10000

local var_0_0 = "NotificationLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BaseUI"))

var_0_1.InitCount = 10
var_0_1.MaxCount = 100
var_0_1.FORM_COMMON = 0
var_0_1.FORM_BATTLE = 1
var_0_1.FORM_MAIN = 2

local var_0_2 = {}

ChatConst = var_2
var_0_2.send = var_2.ChannelWorld
IndexConst = var_2

local var_0_3 = var_2.Flags2Bits
local var_0_4 = {}

ChatConst = var_0_10004
var_0_4[1] = var_0_10004.ChannelAll
var_0_2.recv = var_0_3(var_0_4)
var_0_1.ChannelBits = var_0_2

function var_0_1.getUIName(arg_1_0)
	getProxy = var_1_10001
	SettingsProxy = var_1_10002

	local var_1_0 = var_1_10001(var_1_10002)

	if var_1.IsMellowStyle(var_1_0) then
		return "NotificationUI4Mellow"
	else
		return "NotificationUI"
	end

	return
end

function var_0_1.setPlayer(arg_2_0, arg_2_1)
	arg_2_0.player = arg_2_1

	return
end

function var_0_1.setInGuild(arg_3_0, arg_3_1)
	arg_3_0.inGuild = arg_3_1

	return
end

function var_0_1.setMessages(arg_4_0, arg_4_1)
	arg_4_0.messages = arg_4_1

	return
end

function var_0_1.init(arg_5_0)
	local var_5_0 = arg_5_0._tf

	arg_5_0.close = var_1.Find(var_5_0, "close")

	local var_5_1 = arg_5_0._tf

	arg_5_0.frame = var_1.Find(var_5_1, "adapt/frame")

	local var_5_2 = arg_5_0.frame

	arg_5_0.contain = var_1.Find(var_5_2, "contain")

	local var_5_3 = arg_5_0.contain
	local var_5_4 = var_1.Find(var_5_3, "ListContainer/list")

	arg_5_0.content = var_1.Find(var_5_4, "content")
	arg_5_0.emptySign = var_1:Find("EmptySign")
	setActive = var_2

	var_2(arg_5_0.emptySign, false)

	arg_5_0.prefabSelf = var_1:Find("popo_self").gameObject
	arg_5_0.prefabOthers = var_1:Find("popo_other").gameObject
	arg_5_0.prefabPublic = var_1:Find("popo_public").gameObject
	arg_5_0.prefabWorldBoss = var_1:Find("popo_worldboss").gameObject
	arg_5_0.prefabWorldBossArchives = var_1:Find("popo_worldboss_archives").gameObject

	local var_5_5 = arg_5_0.frame
	local var_5_6 = var_2.Find(var_5_5, "contain/ListContainer/inputbg/input")

	arg_5_0.input = var_2.GetComponent(var_5_6, "InputField")
	setText = var_2

	local var_5_7 = arg_5_0.frame
	local var_5_8 = var_3.Find(var_5_7, "contain/ListContainer/inputbg/input/Placeholder")

	i18n = var_5_7

	var_2(var_5_8, var_5_7("notice_input_desc"))

	local var_5_9 = arg_5_0.frame

	arg_5_0.send = var_2.Find(var_5_9, "send")

	local var_5_10 = arg_5_0.frame

	arg_5_0.channelSend = var_2.Find(var_5_10, "channel_send")

	local var_5_11 = arg_5_0.frame

	arg_5_0.channelSendPop = var_2.Find(var_5_11, "channel_pop")
	arg_5_0.scroll = var_1:GetComponent("ScrollRect")

	local var_5_12 = arg_5_0.contain

	arg_5_0.topMsg = var_2.Find(var_5_12, "topmsg")
	SetActive = var_2

	var_2(arg_5_0.topMsg, false)

	local var_5_13 = arg_5_0.topMsg

	arg_5_0.topPublic = var_2.Find(var_5_13, "popo_public")

	local var_5_14 = arg_5_0.frame

	arg_5_0.emoji = var_2.Find(var_5_14, "contain/ListContainer/inputbg/emoji")

	local var_5_15 = arg_5_0._tf

	arg_5_0.changeRoomPanel = var_2.Find(var_5_15, "change_room_Panel")

	local var_5_16 = arg_5_0.changeRoomPanel

	arg_5_0.roomSendBtns = var_2.Find(var_5_16, "frame/bg/type_send")

	local var_5_17 = arg_5_0.changeRoomPanel

	arg_5_0.roomRecvBtns = var_2.Find(var_5_17, "frame/bg/type_recv")

	local var_5_18 = arg_5_0.frame

	arg_5_0.enterRoomTip = var_2.Find(var_5_18, "enter_room_tip")

	local var_5_19 = arg_5_0.enterRoomTip
	local var_5_20 = var_2.GetComponent

	typeof = var_4
	CanvasGroup = var_5
	arg_5_0.enterRoomCG = var_5_20(var_5_19, var_4(var_5))

	local var_5_21 = arg_5_0.contain

	arg_5_0.roomBtn = var_2.Find(var_5_21, "top/room")

	local var_5_22 = arg_5_0.contain

	arg_5_0.typeBtns = var_2.Find(var_5_22, "top/type")

	local var_5_23 = arg_5_0.changeRoomPanel
	local var_5_24 = var_2.Find(var_5_23, "frame/bg/InputField")
	local var_5_25 = var_2.GetComponent

	typeof = var_4
	InputField = var_5
	arg_5_0.inputTF = var_5_25(var_5_24, var_4(var_5))

	local var_5_26 = arg_5_0.changeRoomPanel

	arg_5_0.switchTpl = var_2.Find(var_5_26, "switch_tpl")

	local var_5_27 = arg_5_0.changeRoomPanel
	local var_5_28 = var_2.Find(var_5_27, "switch_normal")
	local var_5_29 = var_2.GetComponent

	typeof = var_4
	Image = var_5
	arg_5_0.switchNormalSprite = var_5_29(var_5_28, var_4(var_5)).sprite

	local var_5_30 = arg_5_0.changeRoomPanel
	local var_5_31 = var_2.Find(var_5_30, "switch_selected")
	local var_5_32 = var_2.GetComponent

	typeof = var_4
	Image = var_5
	arg_5_0.switchSelectedSprite = var_5_32(var_5_31, var_4(var_5)).sprite
	setText = var_2
	findTF = var_5_31

	local var_5_33 = var_5_31(arg_5_0.changeRoomPanel, "frame/bg/label_send")

	i18n = var_4

	var_2(var_5_33, var_4("notice_label_send"))

	setText = var_2
	findTF = var_5_33

	local var_5_34 = var_5_33(arg_5_0.changeRoomPanel, "frame/bg/label_recv")

	i18n = var_4

	var_2(var_5_34, var_4("notice_label_recv"))

	setText = var_2
	findTF = var_5_34

	local var_5_35 = var_5_34(arg_5_0.changeRoomPanel, "frame/bg/label_room")

	i18n = var_4

	var_2(var_5_35, var_4("notice_label_room"))

	setText = var_2
	findTF = var_5_35

	local var_5_36 = var_5_35(arg_5_0.changeRoomPanel, "frame/bg/label_tip")

	i18n = var_4

	var_2(var_5_36, var_4("notice_label_tip"))

	setText = var_2
	findTF = var_5_36

	local var_5_37 = var_5_36(arg_5_0.changeRoomPanel, "frame/bg/InputField/Placeholder")

	i18n = var_4

	var_2(var_5_37, var_4("please_input_1_99"))

	setText = var_2
	findTF = var_5_37

	local var_5_38 = var_5_37(arg_5_0.changeRoomPanel, "frame/cancel/Image")

	i18n = var_4

	var_2(var_5_38, var_4("word_cancel"))

	setText = var_2
	findTF = var_5_38

	local var_5_39 = var_5_38(arg_5_0.changeRoomPanel, "frame/confirm/Image")

	i18n = var_4

	var_2(var_5_39, var_4("word_ok"))

	local var_5_40 = arg_5_0._tf

	arg_5_0.resource = var_2.Find(var_5_40, "resource")

	local var_5_41 = arg_5_0.resource

	arg_5_0.typeTpl = var_2.Find(var_5_41, "type_tpl")

	local var_5_42 = arg_5_0.resource
	local var_5_43 = var_2.Find(var_5_42, "normal")
	local var_5_44 = var_2.GetComponent

	typeof = var_4
	Image = var_5
	arg_5_0.normalSprite = var_5_44(var_5_43, var_4(var_5)).sprite

	local var_5_45 = arg_5_0.resource
	local var_5_46 = var_2.Find(var_5_45, "selected")
	local var_5_47 = var_2.GetComponent

	typeof = var_4
	Image = var_5
	arg_5_0.selectedSprite = var_5_47(var_5_46, var_4(var_5)).sprite

	local var_5_48 = arg_5_0.resource

	arg_5_0.bottomChannelTpl = var_2.Find(var_5_48, "channel_tpl")

	local var_5_49 = arg_5_0.resource
	local var_5_50 = var_2.Find(var_5_49, "channel_normal")
	local var_5_51 = var_2.GetComponent

	typeof = var_4
	Image = var_5
	arg_5_0.bottomChannelNormalSprite = var_5_51(var_5_50, var_4(var_5)).sprite

	local var_5_52 = arg_5_0.resource
	local var_5_53 = var_2.Find(var_5_52, "channel_selected")
	local var_5_54 = var_2.GetComponent

	typeof = var_4
	Image = var_5
	arg_5_0.bottomChannelSelectedSprite = var_5_54(var_5_53, var_4(var_5)).sprite

	local var_5_55 = {}

	ChatConst = var_5_53
	var_5_55[1] = var_5_53.ChannelAll
	ChatConst = var_3
	var_5_55[2] = var_3.ChannelWorld
	ChatConst = var_3
	var_5_55[3] = var_3.ChannelPublic
	ChatConst = var_3
	var_5_55[4] = var_3.ChannelFriend
	ChatConst = var_3
	var_5_55[5] = var_3.ChannelGuild
	ChatConst = var_3
	var_5_55[6] = var_3.ChannelWorldBoss
	arg_5_0.textSprites = {}
	arg_5_0.textSelectedSprites = {}
	arg_5_0.bottomChannelTextSprites = {}
	arg_5_0.switchTextSprites = {}
	pairs = var_3

	for iter_5_0, iter_5_1 in var_3(var_5_55) do
		ChatConst = var_1_10008
		var_1_10008 = var_1_10008.GetChannelSprite(iter_5_0)

		local var_5_56 = arg_5_0.textSprites
		local var_5_57 = arg_5_0.resource
		local var_5_58 = var_10.Find(var_5_57, "text_" .. var_1_10008)
		local var_5_59 = var_10.GetComponent

		typeof = var_12
		Image = var_13
		var_5_56[iter_5_0] = var_5_59(var_5_58, var_12(var_13)).sprite

		local var_5_60 = arg_5_0.textSelectedSprites
		local var_5_61 = arg_5_0.resource
		local var_5_62 = var_10.Find(var_5_61, "text_" .. var_1_10008 .. "_selected")
		local var_5_63 = var_10.GetComponent

		typeof = var_12
		Image = var_13
		var_5_60[iter_5_0] = var_5_63(var_5_62, var_12(var_13)).sprite

		local var_5_64 = arg_5_0.switchTextSprites
		local var_5_65 = arg_5_0.changeRoomPanel
		local var_5_66 = var_10.Find(var_5_65, "text_" .. var_1_10008 .. "_switch")
		local var_5_67 = var_10.GetComponent

		typeof = var_12
		Image = var_13
		var_5_64[iter_5_0] = var_5_67(var_5_66, var_12(var_13)).sprite
		table = var_5_64

		local var_5_68 = var_5_64.contains

		ChatConst = var_10

		if var_5_68(var_10.SendChannels, iter_5_0) then
			local var_5_69 = arg_5_0.bottomChannelTextSprites
			local var_5_70 = arg_5_0.resource
			local var_5_71 = var_10.Find(var_5_70, "channel_" .. var_1_10008)
			local var_5_72 = var_10.GetComponent

			typeof = var_12
			Image = var_13
			var_5_69[iter_5_0] = var_5_72(var_5_71, var_12(var_13)).sprite
		end
	end

	local var_5_73 = arg_5_0.prefabSelf

	var_3.SetActive(var_5_73, false)

	local var_5_74 = arg_5_0.prefabOthers

	var_3.SetActive(var_5_74, false)

	local var_5_75 = arg_5_0.prefabPublic

	var_3.SetActive(var_5_75, false)

	arg_5_0.bubbleCards = {}
	arg_5_0.worldBossCards = {}
	arg_5_0.poolBubble = {
		self = {},
		public = {},
		others = {}
	}

	local var_5_76 = var_0_1.ChannelBits

	getProxy = var_4
	SettingsProxy = var_5

	local var_5_77 = var_4(var_5)

	var_5_76.recv = var_4.GetChatFlag(var_5_77)

	arg_5_0:BlurPanel(arg_5_0._tf)

	return
end

function var_0_1.adjustMsgListPanel(arg_6_0)
	local var_6_0 = arg_6_0.contain

	arg_6_0.listContainerTF = var_1.Find(var_6_0, "ListContainer")

	local var_6_1 = arg_6_0.contain

	arg_6_0.listTF = var_1.Find(var_6_1, "ListContainer/list")

	local var_6_2 = arg_6_0.listContainerTF.rect.size.y
	local var_6_3 = 69.01791

	GetComponent = var_3
	var_3(arg_6_0.listTF, "LayoutElement").preferredHeight = var_6_2 - var_6_3

	return
end

function var_0_1.didEnter(arg_7_0)
	arg_7_0:adjustMsgListPanel()

	arg_7_0.currentForm = arg_7_0.contextData.form
	arg_7_0.escFlag = false
	onButton = var_1

	local var_7_0 = arg_7_0
	local var_7_1 = arg_7_0.close

	local function var_7_2()
		if arg_7_0.isExitPlay then
			return
		end

		arg_7_0.isExitPlay = true

		local var_8_0 = arg_7_0

		var_0.PlayUIAnimation(var_8_0, arg_7_0._tf, "exit", function()
			if arg_7_0.currentForm == var_0_1.FORM_BATTLE then
				local var_9_0 = arg_7_0
				local var_9_1 = var_0.emit

				NotificationMediator = var_3_10002

				var_9_1(var_9_0, var_3_10002.BATTLE_CHAT_CLOSE)
			end

			local var_9_2 = arg_7_0

			var_0.closeView(var_9_2)

			return
		end)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1(var_7_0, var_7_1, var_7_2, var_1_10005)

	onButton = var_1

	local var_7_3 = arg_7_0
	local var_7_4 = arg_7_0.emoji

	local function var_7_5()
		local var_10_0 = arg_7_0

		var_0.displayEmojiPanel(var_10_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_7_3, var_7_4, var_7_5, var_1_10005)

	onButton = var_1

	local var_7_6 = arg_7_0
	local var_7_7 = arg_7_0.send

	local function var_7_8()
		if arg_7_0.input.text == "" then
			pg = var_2_10001

			local var_11_0 = var_2_10001.TipsMgr.GetInstance()
			local var_11_1 = var_1.ShowTips

			i18n = var_2_10003

			var_11_1(var_11_0, var_2_10003("main_notificationLayer_sendButton"))

			return
		end

		arg_7_0.input.text = ""

		local var_11_2 = arg_7_0
		local var_11_3 = var_1.emit

		NotificationMediator = var_2_10003

		var_11_3(var_11_2, var_2_10003.ON_SEND_PUBLIC, var_0_1.ChannelBits.send, var_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_7_6, var_7_7, var_7_8, var_1_10005)

	onButton = var_1

	local var_7_9 = arg_7_0
	local var_7_10 = arg_7_0.roomBtn

	local function var_7_11()
		local var_12_0 = arg_7_0

		var_0.showChangeRoomPanel(var_12_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_7_9, var_7_10, var_7_11, var_1_10005)

	onButton = var_1

	local var_7_12 = arg_7_0

	findTF = var_7_10

	local var_7_13 = var_7_10(arg_7_0.changeRoomPanel, "frame/cancel")

	local function var_7_14()
		local var_13_0 = arg_7_0

		var_0.closeChangeRoomPanel(var_13_0)

		return
	end

	SFX_CANCEL = var_5

	var_1(var_7_12, var_7_13, var_7_14, var_5)

	onButton = var_1

	local var_7_15 = arg_7_0

	findTF = var_7_13

	local var_7_16 = var_7_13(arg_7_0.changeRoomPanel, "frame/confirm")

	local function var_7_17()
		local var_14_0 = arg_7_0
		local var_14_1 = var_0.emit

		NotificationMediator = var_2_10002

		local var_14_2 = var_2_10002.CHANGE_ROOM

		tonumber = var_2_10003

		var_14_1(var_14_0, var_14_2, var_2_10003(arg_7_0.inputTF.text))

		return
	end

	SFX_CANCEL = var_5

	var_1(var_7_15, var_7_16, var_7_17, var_5)

	onButton = var_1

	local var_7_18 = arg_7_0
	local var_7_19 = arg_7_0.channelSend

	local function var_7_20()
		setActive = var_2_10000

		local var_15_0 = arg_7_0.channelSendPop

		isActive = var_2_10002

		var_2_10000(var_15_0, not var_2_10002(arg_7_0.channelSendPop))

		isActive = var_2_10000

		if var_2_10000(arg_7_0.channelSendPop) then
			local var_15_1 = arg_7_0

			var_0.updateChannelSendPop(var_15_1)
		end

		return
	end

	SFX_PANEL = var_5

	var_1(var_7_18, var_7_19, var_7_20, var_5)

	onButton = var_1

	var_1(arg_7_0, arg_7_0._tf, function()
		isActive = var_2_10000

		if var_2_10000(arg_7_0.channelSendPop) then
			setActive = var_0

			var_0(arg_7_0.channelSendPop, false)
		end

		return
	end)

	pg = var_1

	var_1.DelegateInfo.Add(arg_7_0, arg_7_0.scroll.onValueChanged)

	local var_7_21 = arg_7_0.scroll.onValueChanged

	var_1.AddListener(var_7_21, function(arg_17_0)
		if arg_7_0.index > 1 and arg_17_0.y >= 1 then
			local var_17_0 = arg_7_0.content.sizeDelta.y * arg_17_0.y
			local var_17_1 = arg_7_0.scroll.velocity

			math = var_2_10003

			local var_17_2 = var_2_10003.max(1, arg_7_0.index - var_0_1.InitCount)

			for iter_17_0 = arg_7_0.index - 1, var_17_2, -1 do
				local var_17_3 = arg_7_0

				var_9.append(var_17_3, arg_7_0.filteredMessages[iter_17_0], 0)
			end

			Canvas = var_5

			var_5.ForceUpdateCanvases()

			local var_17_4 = arg_7_0.scroll

			Vector2 = var_6
			var_17_4.normalizedPosition = var_6(0, var_17_0 / arg_7_0.content.sizeDelta.y)

			local var_17_5 = arg_7_0.scroll.onValueChanged

			var_5.Invoke(var_17_5, arg_7_0.scroll.normalizedPosition)

			arg_7_0.scroll.velocity = var_17_1
			arg_7_0.index = var_17_2
		end

		return
	end)
	arg_7_0:updateRoom()
	arg_7_0:updateChatChannel()
	arg_7_0:initFilter()
	arg_7_0:updateFilter()

	local var_7_22 = arg_7_0

	arg_7_0.updateAll(var_7_22)

	LeanTween = var_1

	local var_7_23 = var_1.delayedCall

	go = var_7_22

	local var_7_24 = var_7_22(arg_7_0._tf)
	local var_7_25 = 0.2

	System = var_4

	var_7_23(var_7_24, var_7_25, var_4.Action(function()
		scrollToBottom = var_2_10000

		var_2_10000(arg_7_0.content.parent)

		return
	end))

	rtf = var_7_23

	local var_7_26 = var_7_23(arg_7_0._tf)

	Vector2 = var_2
	var_7_26.offsetMax = var_2(0, 0)
	rtf = var_7_26

	local var_7_27 = var_7_26(arg_7_0._tf)

	Vector2 = var_2
	var_7_27.offsetMin = var_2(0, 0)

	return
end

function var_0_1.onBackPressed(arg_19_0)
	pg = var_1_10001

	local var_19_0 = var_1_10001.CriMgr.GetInstance()
	local var_19_1 = var_1.PlaySoundEffect_V3

	SFX_CANCEL = var_1_10003

	var_19_1(var_19_0, var_1_10003)

	isActive = var_19_1

	if var_19_1(arg_19_0.changeRoomPanel) then
		arg_19_0:closeChangeRoomPanel()
	else
		triggerButton = var_1

		var_1(arg_19_0.close)
	end

	return
end

function var_0_1.initFilter(arg_20_0)
	ChatConst = var_1_10001

	local var_20_0 = var_1_10001.RecvChannels

	UIItemList = var_1_10002
	arg_20_0.recvTypes = var_1_10002.New(arg_20_0.typeBtns, arg_20_0.typeTpl)

	local var_20_1 = arg_20_0.recvTypes

	var_2.make(var_20_1, function(arg_21_0, arg_21_1, arg_21_2)
		UIItemList = var_2_10003

		if arg_21_0 == var_2_10003.EventUpdate then
			local var_21_0 = var_20_0[arg_21_1 + 1]

			setImageSprite = var_4

			var_4(arg_21_2:Find("text"), arg_20_0.textSprites[var_21_0], true)

			setImageSprite = var_4

			var_4(arg_21_2:Find("text_selected"), arg_20_0.textSelectedSprites[var_21_0], true)

			onButton = var_4

			local var_21_1 = arg_20_0
			local var_21_2 = arg_21_2

			local function var_21_3()
				_ = var_3_10000

				local var_22_0 = var_3_10000.filter(var_20_0, function(arg_23_0)
					ChatConst = var_4_10001

					return arg_23_0 ~= var_4_10001.ChannelGuild or arg_20_0.inGuild
				end)

				IndexConst = var_1

				local var_22_1 = var_1.ToggleBits
				local var_22_2 = var_0_1.ChannelBits.recv
				local var_22_3 = var_22_0

				ChatConst = var_3_10004

				local var_22_4 = var_22_1(var_22_2, var_22_3, var_3_10004.ChannelAll, var_21_0)

				if var_0_1.ChannelBits.recv == var_22_4 then
					return
				end

				var_0_1.ChannelBits.recv = var_22_4

				local var_22_5 = arg_20_0

				var_2.updateFilter(var_22_5)

				local var_22_6 = arg_20_0

				var_2.updateAll(var_22_6)

				getProxy = var_2
				SettingsProxy = var_22_6

				local var_22_7 = var_2(var_22_6)

				var_2.SetChatFlag(var_22_7, var_0_1.ChannelBits.recv)

				return
			end

			SFX_UI_TAG = var_2_10008

			var_4(var_21_1, var_21_2, var_21_3, var_2_10008)
		end

		return
	end)

	local var_20_2 = arg_20_0.recvTypes

	var_2.align(var_20_2, #var_20_0)

	return
end

function var_0_1.updateFilter(arg_24_0)
	ChatConst = var_1_10001

	local var_24_0 = var_1_10001.RecvChannels
	local var_24_1 = arg_24_0.recvTypes

	var_2.each(var_24_1, function(arg_25_0, arg_25_1)
		local var_25_0 = var_24_0[arg_25_0 + 1]

		ChatConst = var_3

		if var_25_0 == var_3.ChannelGuild and not arg_24_0.inGuild then
			setButtonEnabled = var_3

			var_3(arg_25_1, false)
		end

		bit = var_3

		local var_25_1 = var_3.band
		local var_25_2 = var_0_1.ChannelBits.recv

		bit = var_2_10005

		if var_25_1(var_25_2, var_2_10005.lshift(1, var_25_0)) > 0 then
			setImageSprite = var_3

			var_3(arg_25_1, arg_24_0.selectedSprite)

			setActive = var_3

			var_3(arg_25_1:Find("text_selected"), true)
		else
			setImageSprite = var_3

			var_3(arg_25_1, arg_24_0.normalSprite)

			setActive = var_3

			var_3(arg_25_1:Find("text_selected"), false)
		end

		return
	end)

	local var_24_2 = var_0_1.ChannelBits.recv

	bit = var_24_1

	local var_24_3 = var_24_1.lshift
	local var_24_4 = 1

	ChatConst = var_1_10005

	local var_24_5 = var_24_3(var_24_4, var_1_10005.ChannelAll)

	_ = var_24_4
	arg_24_0.filteredMessages = var_24_4.filter(arg_24_0.messages, function(arg_26_0)
		local var_26_2

		if var_24_2 ~= var_24_5 then
			bit = var_1

			local var_26_0 = var_1.band
			local var_26_1 = var_24_2

			bit = var_2_10003

			if not (var_26_0(var_26_1, var_2_10003.lshift(1, arg_26_0.type)) > 0) then
				var_26_2 = false

				goto label_26_0
			end
		end

		var_26_2 = true

		::label_26_0::

		return var_26_2
	end)
	_ = var_4
	arg_24_0.filteredMessages = var_4.slice(arg_24_0.filteredMessages, #arg_24_0.filteredMessages - var_0_1.MaxCount + 1, var_0_1.MaxCount)

	return
end

function var_0_1.updateChatChannel(arg_27_0)
	setImageSprite = var_1_10001

	local var_27_0 = arg_27_0.channelSend

	var_1_10001(var_2.Find(var_27_0, "Text"), arg_27_0.bottomChannelTextSprites[var_0_1.ChannelBits.send], true)

	return
end

function var_0_1.updateChannelSendPop(arg_28_0)
	ChatConst = var_1_10001

	local var_28_0 = var_1_10001.SendChannels

	UIItemList = var_1_10002

	local var_28_1 = var_1_10002.New
	local var_28_2 = arg_28_0.channelSendPop
	local var_28_3 = var_28_1(var_3.Find(var_28_2, "type_send"), arg_28_0.bottomChannelTpl)

	local function var_28_4()
		local var_29_0 = var_28_3

		var_0.each(var_29_0, function(arg_30_0, arg_30_1)
			local var_30_0 = var_28_0[arg_30_0 + 1]

			ChatConst = var_3

			if var_30_0 == var_3.ChannelGuild and not arg_28_0.inGuild then
				setButtonEnabled = var_3

				var_3(arg_30_1, false)
			end

			if var_0_1.ChannelBits.send == var_30_0 then
				setImageSprite = var_3_10004

				var_3_10004(arg_30_1:Find("bottom"), arg_28_0.bottomChannelSelectedSprite, true)
			else
				setImageSprite = var_3_10004

				var_3_10004(arg_30_1:Find("bottom"), arg_28_0.bottomChannelNormalSprite, true)
			end

			setActive = var_3_10004

			var_3_10004(arg_30_1:Find("selected"), var_3)

			setActive = var_3_10004

			var_3_10004(arg_30_1:Find("text"), not var_3)

			return
		end)

		return
	end

	var_28_3:make(function(arg_31_0, arg_31_1, arg_31_2)
		UIItemList = var_2_10003

		if arg_31_0 == var_2_10003.EventUpdate then
			local var_31_0 = var_28_0[arg_31_1 + 1]

			setImageSprite = var_4

			var_4(arg_31_2:Find("text"), arg_28_0.bottomChannelTextSprites[var_31_0], true)

			setImageSprite = var_4

			var_4(arg_31_2:Find("selected"), arg_28_0.bottomChannelTextSprites[var_31_0], true)

			onButton = var_4

			local var_31_1 = arg_28_0
			local var_31_2 = arg_31_2

			local function var_31_3()
				setActive = var_3_10000

				var_3_10000(arg_28_0.channelSendPop, false)

				var_0_1.ChannelBits.send = var_31_0

				var_28_4()

				local var_32_0 = arg_28_0

				var_0.updateChatChannel(var_32_0)

				return
			end

			SFX_UI_TAG = var_2_10008

			var_4(var_31_1, var_31_2, var_31_3, var_2_10008)
		end

		return
	end)
	var_28_3:align(#var_28_0)
	var_28_4()

	return
end

function var_0_1.updateRoom(arg_33_0)
	setText = var_1_10001

	local var_33_0 = arg_33_0.enterRoomTip
	local var_33_1 = var_2.Find(var_33_0, "text")

	i18n = var_33_0

	var_1_10001(var_33_1, var_33_0("main_notificationLayer_enter_room", arg_33_0.player.chatRoomId == 0 and "" or arg_33_0.player.chatRoomId))

	setText = var_1_10001

	local var_33_2 = arg_33_0.roomBtn
	local var_33_3 = var_2.Find(var_33_2, "Text")

	if arg_33_0.player.chatRoomId == 0 then
		i18n = var_3

		local var_33_4

		if not var_3("common_not_enter_room") then
			var_33_4 = arg_33_0.player.chatRoomId
		end

		var_1_10001(var_33_3, var_33_4)
		arg_33_0:showEnterRommTip()

		return
	end
end

function var_0_1.showChangeRoomPanel(arg_34_0)
	pg = var_1_10001

	local var_34_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_34_0, arg_34_0.changeRoomPanel)

	local var_34_1 = arg_34_0.inputTF

	tostring = var_34_0
	var_34_1.text = var_34_0(arg_34_0.player.chatRoomId)
	arg_34_0.tempRoomSendBits = var_0_1.ChannelBits.send
	ChatConst = var_1

	local var_34_2 = var_1.SendChannels

	UIItemList = var_2

	local var_34_3 = var_2.New(arg_34_0.roomSendBtns, arg_34_0.switchTpl)

	local function var_34_4()
		local var_35_0 = var_34_3

		var_0.each(var_35_0, function(arg_36_0, arg_36_1)
			local var_36_0 = var_34_2[arg_36_0 + 1]

			ChatConst = var_3

			if var_36_0 == var_3.ChannelGuild and not arg_34_0.inGuild then
				setButtonEnabled = var_3

				var_3(arg_36_1, false)
			end

			if arg_34_0.tempRoomSendBits == var_36_0 then
				setImageSprite = var_3

				var_3(arg_36_1, arg_34_0.switchSelectedSprite)
			else
				setImageSprite = var_3

				var_3(arg_36_1, arg_34_0.switchNormalSprite)
			end

			return
		end)

		return
	end

	var_34_3:make(function(arg_37_0, arg_37_1, arg_37_2)
		UIItemList = var_2_10003

		if arg_37_0 == var_2_10003.EventUpdate then
			local var_37_0 = var_34_2[arg_37_1 + 1]

			setImageSprite = var_4

			var_4(arg_37_2:Find("text"), arg_34_0.switchTextSprites[var_37_0], true)

			onButton = var_4

			local var_37_1 = arg_34_0
			local var_37_2 = arg_37_2

			local function var_37_3()
				arg_34_0.tempRoomSendBits = var_37_0

				var_34_4()

				return
			end

			SFX_UI_TAG = var_2_10008

			var_4(var_37_1, var_37_2, var_37_3, var_2_10008)
		end

		return
	end)

	local var_34_5 = var_34_3

	var_34_3.align(var_34_5, #var_34_2)
	var_34_4()

	arg_34_0.tempRoomRecvBits = var_0_1.ChannelBits.recv
	ChatConst = var_4

	local var_34_6 = var_4.RecvChannels

	UIItemList = var_34_5

	local var_34_7 = var_34_5.New(arg_34_0.roomRecvBtns, arg_34_0.switchTpl)

	local function var_34_8()
		local var_39_0 = var_34_7

		var_0.each(var_39_0, function(arg_40_0, arg_40_1)
			local var_40_0 = var_34_6[arg_40_0 + 1]

			ChatConst = var_3

			if var_40_0 == var_3.ChannelGuild and not arg_34_0.inGuild then
				setButtonEnabled = var_3

				var_3(arg_40_1, false)
			end

			bit = var_3

			local var_40_1 = var_3.band
			local var_40_2 = arg_34_0.tempRoomRecvBits

			bit = var_3_10005

			if var_40_1(var_40_2, var_3_10005.lshift(1, var_40_0)) > 0 then
				setImageSprite = var_3

				var_3(arg_40_1, arg_34_0.switchSelectedSprite)
			else
				setImageSprite = var_3

				var_3(arg_40_1, arg_34_0.switchNormalSprite)
			end

			return
		end)

		return
	end

	var_34_7:make(function(arg_41_0, arg_41_1, arg_41_2)
		UIItemList = var_2_10003

		if arg_41_0 == var_2_10003.EventUpdate then
			local var_41_0 = var_34_6[arg_41_1 + 1]

			setImageSprite = var_4

			var_4(arg_41_2:Find("text"), arg_34_0.switchTextSprites[var_41_0], true)

			onButton = var_4

			local var_41_1 = arg_34_0
			local var_41_2 = arg_41_2

			local function var_41_3()
				_ = var_3_10000

				local var_42_0 = var_3_10000.filter(var_34_6, function(arg_43_0)
					ChatConst = var_4_10001

					return arg_43_0 ~= var_4_10001.ChannelGuild or arg_34_0.inGuild
				end)
				local var_42_1 = arg_34_0

				IndexConst = var_2

				local var_42_2 = var_2.ToggleBits
				local var_42_3 = arg_34_0.tempRoomRecvBits
				local var_42_4 = var_42_0

				ChatConst = var_3_10005
				var_42_1.tempRoomRecvBits = var_42_2(var_42_3, var_42_4, var_3_10005.ChannelAll, var_41_0)

				var_34_8()

				return
			end

			SFX_UI_TAG = var_2_10008

			var_4(var_41_1, var_41_2, var_41_3, var_2_10008)
		end

		return
	end)
	var_34_7:align(#var_34_6)
	var_34_8()

	setActive = var_7

	var_7(arg_34_0.changeRoomPanel, true)

	return
end

function var_0_1.closeChangeRoomPanel(arg_44_0)
	pg = var_1_10001

	local var_44_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_44_0, arg_44_0.changeRoomPanel, arg_44_0._tf)

	setActive = var_1

	var_1(arg_44_0.changeRoomPanel, false)

	return
end

function var_0_1.removeAllBubble(arg_45_0)
	ipairs = var_1_10001

	local var_45_0

	if not arg_45_0.bubbleCards then
		var_45_0 = {}
	end

	for iter_45_0, iter_45_1 in var_1_10001(var_45_0) do
		setActive = var_1_10006

		var_1_10006(iter_45_1.tf, false)

		var_1_10006 = arg_45_0.poolBubble.others

		if iter_45_1.__cname == "ChatBubblePublic" then
			var_1_10006 = arg_45_0.poolBubble.public
		elseif iter_45_1.__cname == "ChatBubble" and iter_45_1.data.player and iter_45_1.data.player.id == arg_45_0.player.id then
			var_1_10006 = arg_45_0.poolBubble.self
		end

		iter_45_1:dispose()

		table = var_7

		var_7.insert(var_1_10006, iter_45_1)
	end

	arg_45_0.bubbleCards = {}
	pairs = var_1

	for iter_45_2, iter_45_3 in var_1(arg_45_0.worldBossCards) do
		IsNil = var_1_10006

		if not var_1_10006(iter_45_3.tf) then
			Destroy = var_1_10006

			var_1_10006(iter_45_3.tf)
		end
	end

	arg_45_0.worldBossCards = {}

	return
end

function var_0_1.updateAll(arg_46_0)
	arg_46_0:removeAllBubble()

	math = var_1
	arg_46_0.index = var_1.max(1, #arg_46_0.filteredMessages - var_0_1.InitCount)

	for iter_46_0 = arg_46_0.index, #arg_46_0.filteredMessages do
		arg_46_0:append(arg_46_0.filteredMessages[iter_46_0], -1)
	end

	scrollToBottom = var_1

	var_1(arg_46_0.content.parent)

	setActive = var_1

	local var_46_0 = arg_46_0.emptySign

	PLATFORM_CODE = var_3
	PLATFORM_JP = iter_46_0

	var_1(var_46_0, var_3 == iter_46_0 and #arg_46_0.filteredMessages <= 0)

	return
end

function var_0_1.append(arg_47_0, arg_47_1, arg_47_2, arg_47_3)
	local var_47_0 = #arg_47_0.filteredMessages
	local var_47_1

	if var_0_1.MaxCount * 2 <= var_47_0 then
		var_47_1 = arg_47_0

		arg_47_0.updateFilter(var_47_1)

		var_47_1 = arg_47_0

		arg_47_0.updateAll(var_47_1)
	else
		arg_47_3 = arg_47_3 and arg_47_0.scroll.normalizedPosition.y < 0.1
		var_47_0 = arg_47_1.type
		ChatConst = var_47_1

		if var_47_0 == var_47_1.ChannelPublic then
			if arg_47_1.id == 0 then
				arg_47_0:appendTopPublic(arg_47_1)
			else
				arg_47_0:appendPublic(arg_47_1, arg_47_2)
			end
		elseif arg_47_1:IsWorldBossNotify() then
			arg_47_0:appendPublic(arg_47_1, arg_47_2)
		else
			arg_47_0:appendOthers(arg_47_1, arg_47_2)
		end

		if arg_47_3 then
			scrollToBottom = var_47_0

			var_47_0(arg_47_0.content.parent)
		end
	end

	setActive = var_47_0

	local var_47_2 = arg_47_0.emptySign

	PLATFORM_CODE = var_1_10006
	PLATFORM_JP = var_1_10007

	var_47_0(var_47_2, var_1_10006 == var_1_10007 and #arg_47_0.filteredMessages <= 0)

	return
end

function var_0_1.appendOthers(arg_48_0, arg_48_1, arg_48_2)
	local var_48_0 = arg_48_1.player
	local var_48_1 = arg_48_0.poolBubble.others
	local var_48_2 = arg_48_0.prefabOthers

	if var_48_0.id == arg_48_0.player.id then
		var_48_1 = arg_48_0.poolBubble.self
		var_48_2 = arg_48_0.prefabSelf
		arg_48_1.isSelf = true
		setmetatable = var_6
		Clone = var_7
		arg_48_1.player = var_6(var_7(arg_48_0.player), {
			__index = arg_48_1.player.__index
		})
	end

	local var_48_3

	if #var_48_1 > 0 then
		var_48_3 = var_48_1[1]
		setActive = var_7

		var_7(var_48_3.tf, true)

		table = var_7

		var_7.remove(var_48_1, 1)
	else
		cloneTplTo = var_7

		local var_48_4 = var_7(var_48_2, arg_48_0.content)

		ChatBubble = var_8
		var_48_3 = var_8.New(var_48_4)
	end

	local var_48_5 = var_48_3.tf

	var_7.SetSiblingIndex(var_48_5, arg_48_2)

	table = var_7

	var_7.insert(arg_48_0.bubbleCards, var_48_3)
	var_48_3:update(arg_48_1)

	removeOnButton = var_7

	var_7(var_48_3.headTF)

	onButton = var_7

	local var_48_6 = arg_48_0
	local var_48_7 = var_48_3.headTF

	local function var_48_8()
		local var_49_0 = var_48_3.tf
		local var_49_1 = var_0.Find(var_49_0, "shipicon/icon").position
		local var_49_2 = arg_48_0
		local var_49_3 = var_2.emit

		NotificationMediator = var_2_10004

		var_49_3(var_49_2, var_2_10004.OPEN_INFO, var_48_0, var_49_1, arg_48_1.content)

		return
	end

	SFX_PANEL = var_1_10011

	var_7(var_48_6, var_48_7, var_48_8, var_1_10011)

	return
end

function var_0_1.appendPublic(arg_50_0, arg_50_1, arg_50_2)
	local var_50_0

	if arg_50_1.id == 4 then
		WorldBossConst = var_4

		local var_50_1

		if not var_4.__IsCurrBoss(arg_50_1.args.wordBossConfigId) or not arg_50_0.prefabWorldBoss then
			var_50_1 = arg_50_0.prefabWorldBossArchives
		end

		cloneTplTo = var_5

		local var_50_2 = var_5(var_50_1, arg_50_0.content)

		ChatBubbleWorldBoss = var_6
		var_50_0 = var_6.New(var_50_2, arg_50_0.currentForm ~= var_0_1.FORM_BATTLE)
		table = var_6

		var_6.insert(arg_50_0.worldBossCards, var_50_0)
	else
		local var_50_3

		if #arg_50_0.poolBubble.public > 0 then
			var_50_0 = var_4[1]
			setActive = var_50_3

			var_50_3(var_50_0.tf, true)

			table = var_50_3

			var_50_3.remove(var_4, 1)
		else
			cloneTplTo = var_50_3
			var_50_3 = var_50_3(arg_50_0.prefabPublic, arg_50_0.content)
			ChatBubblePublic = var_6
			var_50_0 = var_6.New(var_50_3)
		end

		table = var_50_3

		var_50_3.insert(arg_50_0.bubbleCards, var_50_0)
	end

	local var_50_4 = var_50_0.tf

	var_4.SetSiblingIndex(var_50_4, arg_50_2)
	var_50_0:update(arg_50_1)

	return
end

function var_0_1.appendTopPublic(arg_51_0, arg_51_1)
	pg = var_1_10002

	local var_51_0 = var_1_10002.TimeMgr.GetInstance()

	if 120 - (var_2.GetServerTime(var_51_0) - arg_51_1.timestamp) <= 0 then
		return
	end

	SetActive = var_3

	var_3(arg_51_0.topMsg, true)

	ChatProxy = var_3

	local var_51_1 = var_3.InjectPublic

	findTF = var_4

	local var_51_2 = var_4(arg_51_0.topPublic, "text")

	var_51_1(var_4.GetComponent(var_51_2, "RichText"), arg_51_1)

	findTF = var_51_1

	local var_51_3 = var_51_1(arg_51_0.topPublic, "channel")
	local var_51_4 = var_3.GetComponent

	typeof = var_5
	Image = var_6

	local var_51_5 = var_51_4(var_51_3, var_5(var_6))

	GetSpriteFromAtlas = var_51_3

	local var_51_6 = "channel"

	ChatConst = var_6
	var_51_5.sprite = var_51_3(var_51_6, var_6.GetChannelSprite(arg_51_1.type) .. "_1920")

	if arg_51_0._topTimer then
		local var_51_7 = arg_51_0._topTimer

		var_4.Stop(var_51_7)

		arg_51_0._topTimer = nil
	end

	Timer = var_4
	arg_51_0._topTimer = var_4.New(function()
		SetActive = var_2_10000

		var_2_10000(arg_51_0.topMsg, false)

		arg_51_0._topTimer = nil

		return
	end, var_2, 1)

	local var_51_8 = arg_51_0._topTimer

	var_4.Start(var_51_8)

	return
end

function var_0_1.showEnterRommTip(arg_53_0)
	if arg_53_0.player.chatRoomId == 0 then
		return
	end

	LeanTween = var_1

	local var_53_0 = var_1.isTweening

	go = var_1_10002

	if not var_53_0(var_1_10002(arg_53_0.enterRoomTip)) then
		LeanTween = var_1

		local var_53_1 = var_1.value

		go = var_2

		local var_53_2 = var_53_1(var_2(arg_53_0.enterRoomTip), 1, 0, 2)
		local var_53_3 = var_1.setOnUpdate

		System = var_3

		local var_53_4 = var_53_3(var_53_2, var_3.Action_float(function(arg_54_0)
			arg_53_0.enterRoomCG.alpha = arg_54_0

			return
		end))
		local var_53_5 = var_1.setEase

		LeanTweenType = var_3

		local var_53_6 = var_53_5(var_53_4, var_3.easeInSine)
		local var_53_7 = var_1.setOnComplete

		System = var_3

		local var_53_8 = var_53_7(var_53_6, var_3.Action(function()
			local var_55_0 = arg_53_0.enterRoomCG

			var_55_0.alpha = 0
			LeanTween = var_55_0

			local var_55_1 = var_55_0.cancel

			go = var_1

			var_55_1(var_1(arg_53_0.enterRoomTip))

			return
		end))

		var_1.setDelay(var_53_8, 0.5)
	end

	return
end

function var_0_1.getPos(arg_56_0, arg_56_1)
	return
end

function var_0_1.displayEmojiPanel(arg_57_0)
	local var_57_0 = arg_57_0.emoji.position
	local var_57_1 = arg_57_0
	local var_57_2 = arg_57_0.emit

	NotificationMediator = var_1_10004

	local var_57_3 = var_1_10004.OPEN_EMOJI

	local function var_57_4(arg_58_0)
		local var_58_0 = arg_57_0
		local var_58_1 = var_1.emit

		NotificationMediator = var_2_10003

		local var_58_2 = var_2_10003.ON_SEND_PUBLIC
		local var_58_3 = var_0_1.ChannelBits.send

		string = var_2_10005

		local var_58_4 = var_2_10005.gsub

		ChatConst = var_2_10006

		var_58_1(var_58_0, var_58_2, var_58_3, var_58_4(var_2_10006.EmojiCode, "code", arg_58_0))

		return
	end

	Vector3 = var_1_10006

	var_57_2(var_57_1, var_57_3, var_57_4, var_1_10006(var_57_0.x, var_57_0.y, 0))

	return
end

function var_0_1.willExit(arg_59_0)
	isActive = var_1_10001

	if var_1_10001(arg_59_0.changeRoomPanel) then
		arg_59_0:closeChangeRoomPanel()
	end

	arg_59_0:UnOverlayPanel(arg_59_0._tf)

	LeanTween = var_1

	var_1.cancel(arg_59_0._go)

	LeanTween = var_1

	local var_59_0 = var_1.cancel

	go = var_2

	var_59_0(var_2(arg_59_0.enterRoomTip))

	if arg_59_0._topTimer then
		local var_59_1 = arg_59_0._topTimer

		var_1.Stop(var_59_1)

		arg_59_0._topTimer = nil
	end

	ipairs = var_1

	local var_59_2

	if not arg_59_0.bubbleCards then
		var_59_2 = {}
	end

	for iter_59_0, iter_59_1 in var_1(var_59_2) do
		iter_59_1:dispose()
	end

	ipairs = var_1

	local var_59_3

	if not arg_59_0.worldBossCards then
		var_59_3 = {}
	end

	for iter_59_2, iter_59_3 in var_1(var_59_3) do
		iter_59_3:dispose()
	end

	arg_59_0.worldBossCards = nil
	pairs = var_1

	for iter_59_4, iter_59_5 in var_1(arg_59_0.poolBubble) do
		ipairs = var_1_10006

		for iter_59_6, iter_59_7 in var_1_10006(iter_59_5) do
			iter_59_7:dispose()
		end
	end

	local var_59_4 = arg_59_0

	arg_59_0.removeLateUpdateListener(var_59_4)

	getProxy = var_1
	GuildProxy = var_59_4

	local var_59_5 = var_1(var_59_4)

	var_1.ClearNewChatMsgCnt(var_59_5)

	return
end

function var_0_1.insertEmojiToInputText(arg_60_0, arg_60_1)
	local var_60_0 = arg_60_0.input
	local var_60_1 = arg_60_0.input.text

	string = var_1_10004

	local var_60_2 = var_1_10004.gsub

	ChatConst = var_1_10005
	var_60_0.text = var_60_1 .. var_60_2(var_1_10005.EmojiIconCode, "code", arg_60_1)

	return
end

function var_0_1.addLateUpdateListener(arg_61_0)
	return
end

function var_0_1.removeLateUpdateListener(arg_62_0)
	return
end

return var_0_1
