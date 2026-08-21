local var_0_0 = class("NotificationLayer", import("..base.BaseUI"))

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
	if getProxy(SettingsProxy):IsMellowStyle() then
		return "NotificationUI4Mellow"
	else
		return "NotificationUI"
	end

	return
end

function var_0_0.setPlayer(arg_2_0, arg_2_1)
	arg_2_0.player = arg_2_1

	return
end

function var_0_0.setInGuild(arg_3_0, arg_3_1)
	arg_3_0.inGuild = arg_3_1

	return
end

function var_0_0.setMessages(arg_4_0, arg_4_1)
	arg_4_0.messages = arg_4_1

	return
end

function var_0_0.init(arg_5_0)
	arg_5_0.close = arg_5_0._tf:Find("close")
	arg_5_0.frame = arg_5_0._tf:Find("adapt/frame")
	arg_5_0.contain = arg_5_0.frame:Find("contain")

	local var_5_0 = arg_5_0.contain:Find("ListContainer/list")

	arg_5_0.content = var_5_0:Find("content")
	arg_5_0.emptySign = var_5_0:Find("EmptySign")

	setActive(arg_5_0.emptySign, false)

	arg_5_0.prefabSelf = var_5_0:Find("popo_self").gameObject
	arg_5_0.prefabOthers = var_5_0:Find("popo_other").gameObject
	arg_5_0.prefabPublic = var_5_0:Find("popo_public").gameObject
	arg_5_0.prefabWorldBoss = var_5_0:Find("popo_worldboss").gameObject
	arg_5_0.prefabWorldBossArchives = var_5_0:Find("popo_worldboss_archives").gameObject
	arg_5_0.input = arg_5_0.frame:Find("contain/ListContainer/inputbg/input"):GetComponent("InputField")

	setText(arg_5_0.frame:Find("contain/ListContainer/inputbg/input/Placeholder"), i18n("notice_input_desc"))

	arg_5_0.send = arg_5_0.frame:Find("send")
	arg_5_0.channelSend = arg_5_0.frame:Find("channel_send")
	arg_5_0.channelSendPop = arg_5_0.frame:Find("channel_pop")
	arg_5_0.scroll = var_5_0:GetComponent("ScrollRect")
	arg_5_0.topMsg = arg_5_0.contain:Find("topmsg")

	SetActive(arg_5_0.topMsg, false)

	arg_5_0.topPublic = arg_5_0.topMsg:Find("popo_public")
	arg_5_0.emoji = arg_5_0.frame:Find("contain/ListContainer/inputbg/emoji")
	arg_5_0.changeRoomPanel = arg_5_0._tf:Find("change_room_Panel")
	arg_5_0.roomSendBtns = arg_5_0.changeRoomPanel:Find("frame/bg/type_send")
	arg_5_0.roomRecvBtns = arg_5_0.changeRoomPanel:Find("frame/bg/type_recv")
	arg_5_0.enterRoomTip = arg_5_0.frame:Find("enter_room_tip")
	arg_5_0.enterRoomCG = arg_5_0.enterRoomTip:GetComponent(typeof(CanvasGroup))
	arg_5_0.roomBtn = arg_5_0.contain:Find("top/room")
	arg_5_0.typeBtns = arg_5_0.contain:Find("top/type")
	arg_5_0.inputTF = arg_5_0.changeRoomPanel:Find("frame/bg/InputField"):GetComponent(typeof(InputField))
	arg_5_0.switchTpl = arg_5_0.changeRoomPanel:Find("switch_tpl")
	arg_5_0.switchNormalSprite = arg_5_0.changeRoomPanel:Find("switch_normal"):GetComponent(typeof(Image)).sprite
	arg_5_0.switchSelectedSprite = arg_5_0.changeRoomPanel:Find("switch_selected"):GetComponent(typeof(Image)).sprite

	setText(findTF(arg_5_0.changeRoomPanel, "frame/bg/label_send"), i18n("notice_label_send"))
	setText(findTF(arg_5_0.changeRoomPanel, "frame/bg/label_recv"), i18n("notice_label_recv"))
	setText(findTF(arg_5_0.changeRoomPanel, "frame/bg/label_room"), i18n("notice_label_room"))
	setText(findTF(arg_5_0.changeRoomPanel, "frame/bg/label_tip"), i18n("notice_label_tip"))
	setText(findTF(arg_5_0.changeRoomPanel, "frame/bg/InputField/Placeholder"), i18n("please_input_1_99"))
	setText(findTF(arg_5_0.changeRoomPanel, "frame/cancel/Image"), i18n("word_cancel"))
	setText(findTF(arg_5_0.changeRoomPanel, "frame/confirm/Image"), i18n("word_ok"))

	arg_5_0.resource = arg_5_0._tf:Find("resource")
	arg_5_0.typeTpl = arg_5_0.resource:Find("type_tpl")
	arg_5_0.normalSprite = arg_5_0.resource:Find("normal"):GetComponent(typeof(Image)).sprite
	arg_5_0.selectedSprite = arg_5_0.resource:Find("selected"):GetComponent(typeof(Image)).sprite
	arg_5_0.bottomChannelTpl = arg_5_0.resource:Find("channel_tpl")
	arg_5_0.bottomChannelNormalSprite = arg_5_0.resource:Find("channel_normal"):GetComponent(typeof(Image)).sprite
	arg_5_0.bottomChannelSelectedSprite = arg_5_0.resource:Find("channel_selected"):GetComponent(typeof(Image)).sprite
	arg_5_0.textSprites = {}
	arg_5_0.textSelectedSprites = {}
	arg_5_0.bottomChannelTextSprites = {}
	arg_5_0.switchTextSprites = {}

	for iter_5_0, iter_5_1 in pairs({
		ChatConst.ChannelAll,
		ChatConst.ChannelWorld,
		ChatConst.ChannelPublic,
		ChatConst.ChannelFriend,
		ChatConst.ChannelGuild,
		ChatConst.ChannelWorldBoss
	}) do
		local var_5_1 = ChatConst.GetChannelSprite(iter_5_0)
		local var_5_2 = arg_5_0.resource:Find("text_" .. var_5_1)

		arg_5_0.textSprites[iter_5_0] = var_5_2:GetComponent(typeof(Image)).sprite

		local var_5_3 = arg_5_0.resource:Find("text_" .. var_5_1 .. "_selected")

		arg_5_0.textSelectedSprites[iter_5_0] = var_5_3:GetComponent(typeof(Image)).sprite

		local var_5_4 = arg_5_0.changeRoomPanel:Find("text_" .. var_5_1 .. "_switch")

		arg_5_0.switchTextSprites[iter_5_0] = var_5_4:GetComponent(typeof(Image)).sprite

		if table.contains(ChatConst.SendChannels, iter_5_0) then
			local var_5_5 = arg_5_0.resource:Find("channel_" .. var_5_1)

			arg_5_0.bottomChannelTextSprites[iter_5_0] = var_5_5:GetComponent(typeof(Image)).sprite
		end
	end

	arg_5_0.prefabSelf:SetActive(false)
	arg_5_0.prefabOthers:SetActive(false)
	arg_5_0.prefabPublic:SetActive(false)

	arg_5_0.bubbleCards = {}
	arg_5_0.worldBossCards = {}
	arg_5_0.poolBubble = {
		self = {},
		public = {},
		others = {}
	}
	var_0_0.ChannelBits.recv = getProxy(SettingsProxy):GetChatFlag()

	arg_5_0:BlurPanel(arg_5_0._tf)

	return
end

function var_0_0.adjustMsgListPanel(arg_6_0)
	arg_6_0.listContainerTF = arg_6_0.contain:Find("ListContainer")
	arg_6_0.listTF = arg_6_0.contain:Find("ListContainer/list")
	GetComponent(arg_6_0.listTF, "LayoutElement").preferredHeight = arg_6_0.listContainerTF.rect.size.y - 69.01791

	return
end

function var_0_0.didEnter(arg_7_0)
	arg_7_0:adjustMsgListPanel()

	arg_7_0.currentForm = arg_7_0.contextData.form
	arg_7_0.escFlag = false

	onButton(arg_7_0, arg_7_0.close, function()
		if arg_7_0.isExitPlay then
			return
		end

		arg_7_0.isExitPlay = true

		arg_7_0:PlayUIAnimation(arg_7_0._tf, "exit", function()
			if arg_7_0.currentForm == var_0_0.FORM_BATTLE then
				arg_7_0:emit(NotificationMediator.BATTLE_CHAT_CLOSE)
			end

			arg_7_0:closeView()

			return
		end)

		return
	end, SFX_CANCEL)
	onButton(arg_7_0, arg_7_0.emoji, function()
		arg_7_0:displayEmojiPanel()

		return
	end, SFX_PANEL)
	onButton(arg_7_0, arg_7_0.send, function()
		if arg_7_0.input.text == "" then
			pg.TipsMgr.GetInstance():ShowTips(i18n("main_notificationLayer_sendButton"))

			return
		end

		arg_7_0.input.text = ""

		arg_7_0:emit(NotificationMediator.ON_SEND_PUBLIC, var_0_0.ChannelBits.send, arg_7_0.input.text)

		return
	end, SFX_PANEL)
	onButton(arg_7_0, arg_7_0.roomBtn, function()
		arg_7_0:showChangeRoomPanel()

		return
	end, SFX_PANEL)
	onButton(arg_7_0, findTF(arg_7_0.changeRoomPanel, "frame/cancel"), function()
		arg_7_0:closeChangeRoomPanel()

		return
	end, SFX_CANCEL)
	onButton(arg_7_0, findTF(arg_7_0.changeRoomPanel, "frame/confirm"), function()
		arg_7_0:emit(NotificationMediator.CHANGE_ROOM, tonumber(arg_7_0.inputTF.text))

		return
	end, SFX_CANCEL)
	onButton(arg_7_0, arg_7_0.channelSend, function()
		setActive(arg_7_0.channelSendPop, not isActive(arg_7_0.channelSendPop))

		if isActive(arg_7_0.channelSendPop) then
			arg_7_0:updateChannelSendPop()
		end

		return
	end, SFX_PANEL)
	onButton(arg_7_0, arg_7_0._tf, function()
		if isActive(arg_7_0.channelSendPop) then
			setActive(arg_7_0.channelSendPop, false)
		end

		return
	end)
	pg.DelegateInfo.Add(arg_7_0, arg_7_0.scroll.onValueChanged)
	arg_7_0.scroll.onValueChanged:AddListener(function(arg_17_0)
		if arg_7_0.index > 1 and arg_17_0.y >= 1 then
			local var_17_0 = math.max(1, arg_7_0.index - var_0_0.InitCount)

			for iter_17_0 = arg_7_0.index - 1, var_17_0, -1 do
				arg_7_0:append(arg_7_0.filteredMessages[iter_17_0], 0)
			end

			Canvas.ForceUpdateCanvases()

			arg_7_0.scroll.normalizedPosition = Vector2(0, arg_7_0.content.sizeDelta.y * arg_17_0.y / arg_7_0.content.sizeDelta.y)

			arg_7_0.scroll.onValueChanged:Invoke(arg_7_0.scroll.normalizedPosition)

			arg_7_0.scroll.velocity = arg_7_0.scroll.velocity
			arg_7_0.index = var_17_0
		end

		return
	end)
	arg_7_0:updateRoom()
	arg_7_0:updateChatChannel()
	arg_7_0:initFilter()
	arg_7_0:updateFilter()
	arg_7_0:updateAll()
	LeanTween.delayedCall(go(arg_7_0._tf), 0.2, System.Action(function()
		scrollToBottom(arg_7_0.content.parent)

		return
	end))

	rtf(arg_7_0._tf).offsetMax = Vector2(0, 0)
	rtf(arg_7_0._tf).offsetMin = Vector2(0, 0)

	return
end

function var_0_0.onBackPressed(arg_19_0)
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_CANCEL)

	if isActive(arg_19_0.changeRoomPanel) then
		arg_19_0:closeChangeRoomPanel()
	else
		triggerButton(arg_19_0.close)
	end

	return
end

function var_0_0.initFilter(arg_20_0)
	local var_20_0 = ChatConst.RecvChannels

	arg_20_0.recvTypes = UIItemList.New(arg_20_0.typeBtns, arg_20_0.typeTpl)

	arg_20_0.recvTypes:make(function(arg_21_0, arg_21_1, arg_21_2)
		if arg_21_0 == UIItemList.EventUpdate then
			local var_21_0 = var_20_0[arg_21_1 + 1]

			setImageSprite(arg_21_2:Find("text"), arg_20_0.textSprites[var_20_0[arg_21_1 + 1]], true)
			setImageSprite(arg_21_2:Find("text_selected"), arg_20_0.textSelectedSprites[var_20_0[arg_21_1 + 1]], true)
			onButton(arg_20_0, arg_21_2, function()
				local var_22_0 = IndexConst.ToggleBits(var_0_0.ChannelBits.recv, _.filter(var_20_0, function(arg_23_0)
					return arg_23_0 ~= ChatConst.ChannelGuild or arg_20_0.inGuild
				end), ChatConst.ChannelAll, var_21_0)

				if var_0_0.ChannelBits.recv == var_22_0 then
					return
				end

				var_0_0.ChannelBits.recv = var_22_0

				arg_20_0:updateFilter()
				arg_20_0:updateAll()
				getProxy(SettingsProxy):SetChatFlag(var_0_0.ChannelBits.recv)

				return
			end, SFX_UI_TAG)
		end

		return
	end)
	arg_20_0.recvTypes:align(#ChatConst.RecvChannels)

	return
end

function var_0_0.updateFilter(arg_24_0)
	local var_24_0 = ChatConst.RecvChannels

	arg_24_0.recvTypes:each(function(arg_25_0, arg_25_1)
		if var_24_0[arg_25_0 + 1] == ChatConst.ChannelGuild and not arg_24_0.inGuild then
			setButtonEnabled(arg_25_1, false)
		end

		if bit.band(var_0_0.ChannelBits.recv, bit.lshift(1, var_24_0[arg_25_0 + 1])) > 0 then
			setImageSprite(arg_25_1, arg_24_0.selectedSprite)
			setActive(arg_25_1:Find("text_selected"), true)
		else
			setImageSprite(arg_25_1, arg_24_0.normalSprite)
			setActive(arg_25_1:Find("text_selected"), false)
		end

		return
	end)

	local var_24_1 = var_0_0.ChannelBits.recv
	local var_24_2 = bit.lshift(1, ChatConst.ChannelAll)

	arg_24_0.filteredMessages = _.filter(arg_24_0.messages, function(arg_26_0)
		return var_24_1 == var_24_2 or bit.band(var_24_1, bit.lshift(1, arg_26_0.type)) > 0
	end)
	arg_24_0.filteredMessages = _.slice(arg_24_0.filteredMessages, #arg_24_0.filteredMessages - var_0_0.MaxCount + 1, var_0_0.MaxCount)

	return
end

function var_0_0.updateChatChannel(arg_27_0)
	setImageSprite(arg_27_0.channelSend:Find("Text"), arg_27_0.bottomChannelTextSprites[var_0_0.ChannelBits.send], true)

	return
end

function var_0_0.updateChannelSendPop(arg_28_0)
	local var_28_0 = ChatConst.SendChannels
	local var_28_1 = UIItemList.New(arg_28_0.channelSendPop:Find("type_send"), arg_28_0.bottomChannelTpl)

	local function var_28_2()
		var_28_1:each(function(arg_30_0, arg_30_1)
			local var_30_0 = var_28_0[arg_30_0 + 1]

			if var_28_0[arg_30_0 + 1] == ChatConst.ChannelGuild and not arg_28_0.inGuild then
				setButtonEnabled(arg_30_1, false)
			end

			local var_30_1 = var_0_0.ChannelBits.send == var_30_0

			if var_0_0.ChannelBits.send == var_30_0 then
				setImageSprite(arg_30_1:Find("bottom"), arg_28_0.bottomChannelSelectedSprite, true)
			else
				setImageSprite(arg_30_1:Find("bottom"), arg_28_0.bottomChannelNormalSprite, true)
			end

			setActive(arg_30_1:Find("selected"), var_30_1)
			setActive(arg_30_1:Find("text"), not var_30_1)

			return
		end)

		return
	end

	var_28_1:make(function(arg_31_0, arg_31_1, arg_31_2)
		if arg_31_0 == UIItemList.EventUpdate then
			local var_31_0 = var_28_0[arg_31_1 + 1]

			setImageSprite(arg_31_2:Find("text"), arg_28_0.bottomChannelTextSprites[var_28_0[arg_31_1 + 1]], true)
			setImageSprite(arg_31_2:Find("selected"), arg_28_0.bottomChannelTextSprites[var_28_0[arg_31_1 + 1]], true)
			onButton(arg_28_0, arg_31_2, function()
				setActive(arg_28_0.channelSendPop, false)

				var_0_0.ChannelBits.send = var_31_0

				var_28_2()
				arg_28_0:updateChatChannel()

				return
			end, SFX_UI_TAG)
		end

		return
	end)
	var_28_1:align(#ChatConst.SendChannels)
	;(function()
		var_28_1:each(function(arg_30_0, arg_30_1)
			local var_30_0 = var_28_0[arg_30_0 + 1]

			if var_28_0[arg_30_0 + 1] == ChatConst.ChannelGuild and not arg_28_0.inGuild then
				setButtonEnabled(arg_30_1, false)
			end

			local var_30_1 = var_0_0.ChannelBits.send == var_30_0

			if var_0_0.ChannelBits.send == var_30_0 then
				setImageSprite(arg_30_1:Find("bottom"), arg_28_0.bottomChannelSelectedSprite, true)
			else
				setImageSprite(arg_30_1:Find("bottom"), arg_28_0.bottomChannelNormalSprite, true)
			end

			setActive(arg_30_1:Find("selected"), var_30_1)
			setActive(arg_30_1:Find("text"), not var_30_1)

			return
		end)

		return
	end)()

	return
end

function var_0_0.updateRoom(arg_33_0)
	setText(arg_33_0.enterRoomTip:Find("text"), i18n("main_notificationLayer_enter_room", arg_33_0.player.chatRoomId == 0 and "" or arg_33_0.player.chatRoomId))

	local var_33_0 = arg_33_0.player.chatRoomId == 0 and i18n("common_not_enter_room") or arg_33_0.player.chatRoomId

	setText(arg_33_0.roomBtn:Find("Text"), var_33_0)
	arg_33_0:showEnterRommTip()

	return
end

function var_0_0.showChangeRoomPanel(arg_34_0)
	pg.UIMgr.GetInstance():BlurPanel(arg_34_0.changeRoomPanel)

	arg_34_0.inputTF.text = tostring(arg_34_0.player.chatRoomId)
	arg_34_0.tempRoomSendBits = var_0_0.ChannelBits.send

	local var_34_0 = ChatConst.SendChannels
	local var_34_1 = UIItemList.New(arg_34_0.roomSendBtns, arg_34_0.switchTpl)

	local function var_34_2()
		var_34_1:each(function(arg_36_0, arg_36_1)
			if var_34_0[arg_36_0 + 1] == ChatConst.ChannelGuild and not arg_34_0.inGuild then
				setButtonEnabled(arg_36_1, false)
			end

			if arg_34_0.tempRoomSendBits == var_34_0[arg_36_0 + 1] then
				setImageSprite(arg_36_1, arg_34_0.switchSelectedSprite)
			else
				setImageSprite(arg_36_1, arg_34_0.switchNormalSprite)
			end

			return
		end)

		return
	end

	var_34_1:make(function(arg_37_0, arg_37_1, arg_37_2)
		if arg_37_0 == UIItemList.EventUpdate then
			setImageSprite(arg_37_2:Find("text"), arg_34_0.switchTextSprites[var_34_0[arg_37_1 + 1]], true)
			onButton(arg_34_0, arg_37_2, function()
				arg_34_0.tempRoomSendBits = var_0

				var_34_2()

				return
			end, SFX_UI_TAG)
		end

		return
	end)
	var_34_1:align(#ChatConst.SendChannels)
	;(function()
		var_34_1:each(function(arg_36_0, arg_36_1)
			if var_34_0[arg_36_0 + 1] == ChatConst.ChannelGuild and not arg_34_0.inGuild then
				setButtonEnabled(arg_36_1, false)
			end

			if arg_34_0.tempRoomSendBits == var_34_0[arg_36_0 + 1] then
				setImageSprite(arg_36_1, arg_34_0.switchSelectedSprite)
			else
				setImageSprite(arg_36_1, arg_34_0.switchNormalSprite)
			end

			return
		end)

		return
	end)()

	arg_34_0.tempRoomRecvBits = var_0_0.ChannelBits.recv

	local var_34_3 = ChatConst.RecvChannels
	local var_34_4 = UIItemList.New(arg_34_0.roomRecvBtns, arg_34_0.switchTpl)

	local function var_34_5()
		var_34_4:each(function(arg_40_0, arg_40_1)
			if var_34_3[arg_40_0 + 1] == ChatConst.ChannelGuild and not arg_34_0.inGuild then
				setButtonEnabled(arg_40_1, false)
			end

			if bit.band(arg_34_0.tempRoomRecvBits, bit.lshift(1, var_34_3[arg_40_0 + 1])) > 0 then
				setImageSprite(arg_40_1, arg_34_0.switchSelectedSprite)
			else
				setImageSprite(arg_40_1, arg_34_0.switchNormalSprite)
			end

			return
		end)

		return
	end

	var_34_4:make(function(arg_41_0, arg_41_1, arg_41_2)
		if arg_41_0 == UIItemList.EventUpdate then
			setImageSprite(arg_41_2:Find("text"), arg_34_0.switchTextSprites[var_34_3[arg_41_1 + 1]], true)
			onButton(arg_34_0, arg_41_2, function()
				arg_34_0.tempRoomRecvBits = IndexConst.ToggleBits(arg_34_0.tempRoomRecvBits, _.filter(var_34_3, function(arg_43_0)
					return arg_43_0 ~= ChatConst.ChannelGuild or arg_34_0.inGuild
				end), ChatConst.ChannelAll, var_0)

				var_34_5()

				return
			end, SFX_UI_TAG)
		end

		return
	end)
	var_34_4:align(#ChatConst.RecvChannels)
	;(function()
		var_34_4:each(function(arg_40_0, arg_40_1)
			if var_34_3[arg_40_0 + 1] == ChatConst.ChannelGuild and not arg_34_0.inGuild then
				setButtonEnabled(arg_40_1, false)
			end

			if bit.band(arg_34_0.tempRoomRecvBits, bit.lshift(1, var_34_3[arg_40_0 + 1])) > 0 then
				setImageSprite(arg_40_1, arg_34_0.switchSelectedSprite)
			else
				setImageSprite(arg_40_1, arg_34_0.switchNormalSprite)
			end

			return
		end)

		return
	end)()
	setActive(arg_34_0.changeRoomPanel, true)

	return
end

function var_0_0.closeChangeRoomPanel(arg_44_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_44_0.changeRoomPanel, arg_44_0._tf)
	setActive(arg_44_0.changeRoomPanel, false)

	return
end

function var_0_0.removeAllBubble(arg_45_0)
	local var_45_0 = arg_45_0.bubbleCards or {}

	for iter_45_0, iter_45_1 in ipairs(var_45_0) do
		setActive(iter_45_1.tf, false)

		local var_45_1 = arg_45_0.poolBubble.others

		if iter_45_1.__cname == "ChatBubblePublic" then
			var_45_1 = arg_45_0.poolBubble.public
		elseif iter_45_1.__cname == "ChatBubble" and iter_45_1.data.player and iter_45_1.data.player.id == arg_45_0.player.id then
			var_45_1 = arg_45_0.poolBubble.self
		end

		iter_45_1:dispose()
		table.insert(var_45_1, iter_45_1)
	end

	arg_45_0.bubbleCards = {}

	for iter_45_2, iter_45_3 in pairs(arg_45_0.worldBossCards) do
		if not IsNil(iter_45_3.tf) then
			Destroy(iter_45_3.tf)
		end
	end

	arg_45_0.worldBossCards = {}

	return
end

function var_0_0.updateAll(arg_46_0)
	arg_46_0:removeAllBubble()

	arg_46_0.index = math.max(1, #arg_46_0.filteredMessages - var_0_0.InitCount)

	for iter_46_0 = arg_46_0.index, #arg_46_0.filteredMessages do
		arg_46_0:append(arg_46_0.filteredMessages[iter_46_0], -1)
	end

	scrollToBottom(arg_46_0.content.parent)
	setActive(arg_46_0.emptySign, PLATFORM_CODE == PLATFORM_JP and #arg_46_0.filteredMessages <= 0)

	return
end

function var_0_0.append(arg_47_0, arg_47_1, arg_47_2, arg_47_3)
	if #arg_47_0.filteredMessages >= var_0_0.MaxCount * 2 then
		arg_47_0:updateFilter()
		arg_47_0:updateAll()
	else
		arg_47_3 = arg_47_3 and arg_47_0.scroll.normalizedPosition.y < 0.1

		if arg_47_1.type == ChatConst.ChannelPublic then
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
			scrollToBottom(arg_47_0.content.parent)
		end
	end

	setActive(arg_47_0.emptySign, PLATFORM_CODE == PLATFORM_JP and #arg_47_0.filteredMessages <= 0)

	return
end

function var_0_0.appendOthers(arg_48_0, arg_48_1, arg_48_2)
	local var_48_0 = arg_48_0.poolBubble.others
	local var_48_1 = arg_48_0.prefabOthers

	if arg_48_1.player.id == arg_48_0.player.id then
		var_48_0 = arg_48_0.poolBubble.self
		var_48_1 = arg_48_0.prefabSelf
		arg_48_1.isSelf = true
		arg_48_1.player = setmetatable(Clone(arg_48_0.player), {
			__index = arg_48_1.player.__index
		})
	end

	local var_48_2

	if #var_48_0 > 0 then
		var_48_2 = var_48_0[1]

		setActive(var_48_0[1].tf, true)
		table.remove(var_48_0, 1)
	else
		var_48_2 = ChatBubble.New((cloneTplTo(var_48_1, arg_48_0.content)))
	end

	var_48_2.tf:SetSiblingIndex(arg_48_2)
	table.insert(arg_48_0.bubbleCards, var_48_2)
	var_48_2:update(arg_48_1)
	removeOnButton(var_48_2.headTF)
	onButton(arg_48_0, var_48_2.headTF, function()
		arg_48_0:emit(NotificationMediator.OPEN_INFO, var_0, var_48_2.tf:Find("shipicon/icon").position, arg_48_1.content)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.appendPublic(arg_50_0, arg_50_1, arg_50_2)
	local var_50_0

	if arg_50_1.id == 4 then
		if WorldBossConst.__IsCurrBoss(arg_50_1.args.wordBossConfigId) then
			local var_50_1 = arg_50_0.prefabWorldBoss
			local var_50_2

			if not arg_50_0.prefabWorldBoss then
				var_50_1 = arg_50_0.prefabWorldBossArchives
				var_50_2 = ChatBubbleWorldBoss.New
			end

			var_50_0 = var_50_2(cloneTplTo(var_50_1, arg_50_0.content), arg_50_0.currentForm ~= var_0_0.FORM_BATTLE)

			table.insert(arg_50_0.worldBossCards, var_50_0)

			if false then
				local var_50_3 = arg_50_0.poolBubble.public

				if #arg_50_0.poolBubble.public > 0 then
					var_50_0 = var_50_3[1]

					setActive(var_50_3[1].tf, true)
					table.remove(var_50_3, 1)
				else
					var_50_0 = ChatBubblePublic.New((cloneTplTo(arg_50_0.prefabPublic, arg_50_0.content)))
				end

				table.insert(arg_50_0.bubbleCards, var_50_0)
			end

			var_50_0.tf:SetSiblingIndex(arg_50_2)
			var_50_0:update(arg_50_1)

			return
		end
	end
end

function var_0_0.appendTopPublic(arg_51_0, arg_51_1)
	local var_51_0 = 120 - (pg.TimeMgr.GetInstance():GetServerTime() - arg_51_1.timestamp)

	if var_51_0 <= 0 then
		return
	end

	SetActive(arg_51_0.topMsg, true)
	ChatProxy.InjectPublic(findTF(arg_51_0.topPublic, "text"):GetComponent("RichText"), arg_51_1)

	findTF(arg_51_0.topPublic, "channel"):GetComponent(typeof(Image)).sprite = GetSpriteFromAtlas("channel", ChatConst.GetChannelSprite(arg_51_1.type) .. "_1920")

	if arg_51_0._topTimer then
		arg_51_0._topTimer:Stop()

		arg_51_0._topTimer = nil
	end

	arg_51_0._topTimer = Timer.New(function()
		SetActive(arg_51_0.topMsg, false)

		arg_51_0._topTimer = nil

		return
	end, var_51_0, 1)

	arg_51_0._topTimer:Start()

	return
end

function var_0_0.showEnterRommTip(arg_53_0)
	if arg_53_0.player.chatRoomId == 0 then
		return
	end

	if not LeanTween.isTweening(go(arg_53_0.enterRoomTip)) then
		LeanTween.value(go(arg_53_0.enterRoomTip), 1, 0, 2):setOnUpdate(System.Action_float(function(arg_54_0)
			arg_53_0.enterRoomCG.alpha = arg_54_0

			return
		end)):setEase(LeanTweenType.easeInSine):setOnComplete(System.Action(function()
			arg_53_0.enterRoomCG.alpha = 0

			LeanTween.cancel(go(arg_53_0.enterRoomTip))

			return
		end)):setDelay(0.5)
	end

	return
end

function var_0_0.getPos(arg_56_0, arg_56_1)
	return
end

function var_0_0.displayEmojiPanel(arg_57_0)
	arg_57_0:emit(NotificationMediator.OPEN_EMOJI, function(arg_58_0)
		arg_57_0:emit(NotificationMediator.ON_SEND_PUBLIC, var_0_0.ChannelBits.send, string.gsub(ChatConst.EmojiCode, "code", arg_58_0))

		return
	end, Vector3(arg_57_0.emoji.position.x, arg_57_0.emoji.position.y, 0))

	return
end

function var_0_0.willExit(arg_59_0)
	if isActive(arg_59_0.changeRoomPanel) then
		arg_59_0:closeChangeRoomPanel()
	end

	arg_59_0:UnOverlayPanel(arg_59_0._tf)
	LeanTween.cancel(arg_59_0._go)
	LeanTween.cancel(go(arg_59_0.enterRoomTip))

	if arg_59_0._topTimer then
		arg_59_0._topTimer:Stop()

		arg_59_0._topTimer = nil
	end

	local var_59_1 = arg_59_0.bubbleCards or {}

	for iter_59_0, iter_59_1 in var_59_0(var_59_1) do
		iter_59_1:dispose()
	end

	local var_59_2 = arg_59_0.worldBossCards or {}

	for iter_59_2, iter_59_3 in ipairs(var_59_2) do
		iter_59_3:dispose()
	end

	arg_59_0.worldBossCards = nil

	for iter_59_4, iter_59_5 in pairs(arg_59_0.poolBubble) do
		for iter_59_6, iter_59_7 in ipairs(iter_59_5) do
			iter_59_7:dispose()
		end
	end

	arg_59_0:removeLateUpdateListener()
	getProxy(GuildProxy):ClearNewChatMsgCnt()

	return
end

function var_0_0.insertEmojiToInputText(arg_60_0, arg_60_1)
	arg_60_0.input.text = arg_60_0.input.text .. string.gsub(ChatConst.EmojiIconCode, "code", arg_60_1)

	return
end

function var_0_0.addLateUpdateListener(arg_61_0)
	return
end

function var_0_0.removeLateUpdateListener(arg_62_0)
	return
end

return var_0_0
