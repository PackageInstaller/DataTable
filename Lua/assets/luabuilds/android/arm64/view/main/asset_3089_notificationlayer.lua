local NotificationLayer = class("NotificationLayer", import("..base.BaseUI"))

NotificationLayer.InitCount = 10
NotificationLayer.MaxCount = 100
NotificationLayer.FORM_COMMON = 0
NotificationLayer.FORM_BATTLE = 1
NotificationLayer.FORM_MAIN = 2
NotificationLayer.ChannelBits = {
	send = ChatConst.ChannelWorld,
	recv = IndexConst.Flags2Bits({
		ChatConst.ChannelAll
	})
}

function NotificationLayer:getUIName()
	if getProxy(SettingsProxy):IsMellowStyle() then
		return "NotificationUI4Mellow"
	else
		return "NotificationUI"
	end

	return
end

function NotificationLayer:setPlayer(arg_2_1)
	self.player = arg_2_1

	return
end

function NotificationLayer:setInGuild(arg_3_1)
	self.inGuild = arg_3_1

	return
end

function NotificationLayer:setMessages(arg_4_1)
	self.messages = arg_4_1

	return
end

function NotificationLayer:init()
	self.close = self._tf:Find("close")
	self.frame = self._tf:Find("adapt/frame")
	self.contain = self.frame:Find("contain")

	local var_5_0 = self.contain:Find("ListContainer/list")

	self.content = var_5_0:Find("content")
	self.emptySign = var_5_0:Find("EmptySign")

	setActive(self.emptySign, false)

	self.prefabSelf = var_5_0:Find("popo_self").gameObject
	self.prefabOthers = var_5_0:Find("popo_other").gameObject
	self.prefabPublic = var_5_0:Find("popo_public").gameObject
	self.prefabWorldBoss = var_5_0:Find("popo_worldboss").gameObject
	self.prefabWorldBossArchives = var_5_0:Find("popo_worldboss_archives").gameObject
	self.input = self.frame:Find("contain/ListContainer/inputbg/input"):GetComponent("InputField")

	setText(self.frame:Find("contain/ListContainer/inputbg/input/Placeholder"), i18n("notice_input_desc"))

	self.send = self.frame:Find("send")
	self.channelSend = self.frame:Find("channel_send")
	self.channelSendPop = self.frame:Find("channel_pop")
	self.scroll = var_5_0:GetComponent("ScrollRect")
	self.topMsg = self.contain:Find("topmsg")

	SetActive(self.topMsg, false)

	self.topPublic = self.topMsg:Find("popo_public")
	self.emoji = self.frame:Find("contain/ListContainer/inputbg/emoji")
	self.changeRoomPanel = self._tf:Find("change_room_Panel")
	self.roomSendBtns = self.changeRoomPanel:Find("frame/bg/type_send")
	self.roomRecvBtns = self.changeRoomPanel:Find("frame/bg/type_recv")
	self.enterRoomTip = self.frame:Find("enter_room_tip")
	self.enterRoomCG = self.enterRoomTip:GetComponent(typeof(CanvasGroup))
	self.roomBtn = self.contain:Find("top/room")
	self.typeBtns = self.contain:Find("top/type")
	self.inputTF = self.changeRoomPanel:Find("frame/bg/InputField"):GetComponent(typeof(InputField))
	self.switchTpl = self.changeRoomPanel:Find("switch_tpl")
	self.switchNormalSprite = self.changeRoomPanel:Find("switch_normal"):GetComponent(typeof(Image)).sprite
	self.switchSelectedSprite = self.changeRoomPanel:Find("switch_selected"):GetComponent(typeof(Image)).sprite

	setText(findTF(self.changeRoomPanel, "frame/bg/label_send"), i18n("notice_label_send"))
	setText(findTF(self.changeRoomPanel, "frame/bg/label_recv"), i18n("notice_label_recv"))
	setText(findTF(self.changeRoomPanel, "frame/bg/label_room"), i18n("notice_label_room"))
	setText(findTF(self.changeRoomPanel, "frame/bg/label_tip"), i18n("notice_label_tip"))
	setText(findTF(self.changeRoomPanel, "frame/bg/InputField/Placeholder"), i18n("please_input_1_99"))
	setText(findTF(self.changeRoomPanel, "frame/cancel/Image"), i18n("word_cancel"))
	setText(findTF(self.changeRoomPanel, "frame/confirm/Image"), i18n("word_ok"))

	self.resource = self._tf:Find("resource")
	self.typeTpl = self.resource:Find("type_tpl")
	self.normalSprite = self.resource:Find("normal"):GetComponent(typeof(Image)).sprite
	self.selectedSprite = self.resource:Find("selected"):GetComponent(typeof(Image)).sprite
	self.bottomChannelTpl = self.resource:Find("channel_tpl")
	self.bottomChannelNormalSprite = self.resource:Find("channel_normal"):GetComponent(typeof(Image)).sprite
	self.bottomChannelSelectedSprite = self.resource:Find("channel_selected"):GetComponent(typeof(Image)).sprite
	self.textSprites = {}
	self.textSelectedSprites = {}
	self.bottomChannelTextSprites = {}
	self.switchTextSprites = {}

	for iter_5_0, iter_5_1 in pairs({
		ChatConst.ChannelAll,
		ChatConst.ChannelWorld,
		ChatConst.ChannelPublic,
		ChatConst.ChannelFriend,
		ChatConst.ChannelGuild,
		ChatConst.ChannelWorldBoss
	}) do
		local var_5_1 = ChatConst.GetChannelSprite(iter_5_0)

		self.textSprites[iter_5_0] = self.resource:Find("text_" .. var_5_1):GetComponent(typeof(Image)).sprite
		self.textSelectedSprites[iter_5_0] = self.resource:Find("text_" .. var_5_1 .. "_selected"):GetComponent(typeof(Image)).sprite
		self.switchTextSprites[iter_5_0] = self.changeRoomPanel:Find("text_" .. var_5_1 .. "_switch"):GetComponent(typeof(Image)).sprite

		if table.contains(ChatConst.SendChannels, iter_5_0) then
			self.bottomChannelTextSprites[iter_5_0] = self.resource:Find("channel_" .. var_5_1):GetComponent(typeof(Image)).sprite
		end
	end

	self.prefabSelf:SetActive(false)
	self.prefabOthers:SetActive(false)
	self.prefabPublic:SetActive(false)

	self.bubbleCards = {}
	self.worldBossCards = {}
	self.poolBubble = {
		self = {},
		public = {},
		others = {}
	}
	NotificationLayer.ChannelBits.recv = getProxy(SettingsProxy):GetChatFlag()

	self:BlurPanel(self._tf)

	return
end

function NotificationLayer:adjustMsgListPanel()
	self.listContainerTF = self.contain:Find("ListContainer")
	self.listTF = self.contain:Find("ListContainer/list")
	GetComponent(self.listTF, "LayoutElement").preferredHeight = self.listContainerTF.rect.size.y - 69.01791

	return
end

function NotificationLayer:didEnter()
	self:adjustMsgListPanel()

	self.currentForm = self.contextData.form
	self.escFlag = false

	onButton(self, self.close, function()
		if self.isExitPlay then
			return
		end

		self.isExitPlay = true

		self:PlayUIAnimation(self._tf, "exit", function()
			if self.currentForm == NotificationLayer.FORM_BATTLE then
				self:emit(NotificationMediator.BATTLE_CHAT_CLOSE)
			end

			self:closeView()

			return
		end)

		return
	end, SFX_CANCEL)
	onButton(self, self.emoji, function()
		self:displayEmojiPanel()

		return
	end, SFX_PANEL)
	onButton(self, self.send, function()
		if self.input.text == "" then
			pg.TipsMgr.GetInstance():ShowTips(i18n("main_notificationLayer_sendButton"))

			return
		end

		self.input.text = ""

		self:emit(NotificationMediator.ON_SEND_PUBLIC, NotificationLayer.ChannelBits.send, self.input.text)

		return
	end, SFX_PANEL)
	onButton(self, self.roomBtn, function()
		self:showChangeRoomPanel()

		return
	end, SFX_PANEL)
	onButton(self, findTF(self.changeRoomPanel, "frame/cancel"), function()
		self:closeChangeRoomPanel()

		return
	end, SFX_CANCEL)
	onButton(self, findTF(self.changeRoomPanel, "frame/confirm"), function()
		self:emit(NotificationMediator.CHANGE_ROOM, tonumber(self.inputTF.text))

		return
	end, SFX_CANCEL)
	onButton(self, self.channelSend, function()
		setActive(self.channelSendPop, not isActive(self.channelSendPop))

		if isActive(self.channelSendPop) then
			self:updateChannelSendPop()
		end

		return
	end, SFX_PANEL)
	onButton(self, self._tf, function()
		if isActive(self.channelSendPop) then
			setActive(self.channelSendPop, false)
		end

		return
	end)
	pg.DelegateInfo.Add(self, self.scroll.onValueChanged)
	self.scroll.onValueChanged:AddListener(function(arg_17_0)
		if self.index > 1 and arg_17_0.y >= 1 then
			local var_17_0 = math.max(1, self.index - NotificationLayer.InitCount)

			for iter_17_0 = self.index - 1, var_17_0, -1 do
				self:append(self.filteredMessages[iter_17_0], 0)
			end

			Canvas.ForceUpdateCanvases()

			self.scroll.normalizedPosition = Vector2(0, self.content.sizeDelta.y * arg_17_0.y / self.content.sizeDelta.y)

			self.scroll.onValueChanged:Invoke(self.scroll.normalizedPosition)

			self.scroll.velocity = self.scroll.velocity
			self.index = var_17_0
		end

		return
	end)
	self:updateRoom()
	self:updateChatChannel()
	self:initFilter()
	self:updateFilter()
	self:updateAll()
	LeanTween.delayedCall(go(self._tf), 0.2, System.Action(function()
		scrollToBottom(self.content.parent)

		return
	end))

	rtf(self._tf).offsetMax = Vector2(0, 0)
	rtf(self._tf).offsetMin = Vector2(0, 0)

	return
end

function NotificationLayer:onBackPressed()
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_CANCEL)

	if isActive(self.changeRoomPanel) then
		self:closeChangeRoomPanel()
	else
		triggerButton(self.close)
	end

	return
end

function NotificationLayer:initFilter()
	local var_20_0 = ChatConst.RecvChannels

	self.recvTypes = UIItemList.New(self.typeBtns, self.typeTpl)

	self.recvTypes:make(function(arg_21_0, arg_21_1, arg_21_2)
		if arg_21_0 == UIItemList.EventUpdate then
			local var_21_0 = var_20_0[arg_21_1 + 1]

			setImageSprite(arg_21_2:Find("text"), self.textSprites[var_20_0[arg_21_1 + 1]], true)
			setImageSprite(arg_21_2:Find("text_selected"), self.textSelectedSprites[var_20_0[arg_21_1 + 1]], true)
			onButton(self, arg_21_2, function()
				local var_22_0 = IndexConst.ToggleBits(NotificationLayer.ChannelBits.recv, _.filter(var_20_0, function(arg_23_0)
					return arg_23_0 ~= ChatConst.ChannelGuild or self.inGuild
				end), ChatConst.ChannelAll, var_21_0)

				if NotificationLayer.ChannelBits.recv == var_22_0 then
					return
				end

				NotificationLayer.ChannelBits.recv = var_22_0

				self:updateFilter()
				self:updateAll()
				getProxy(SettingsProxy):SetChatFlag(NotificationLayer.ChannelBits.recv)

				return
			end, SFX_UI_TAG)
		end

		return
	end)
	self.recvTypes:align(#ChatConst.RecvChannels)

	return
end

function NotificationLayer:updateFilter()
	local var_24_0 = ChatConst.RecvChannels

	self.recvTypes:each(function(arg_25_0, arg_25_1)
		if var_24_0[arg_25_0 + 1] == ChatConst.ChannelGuild and not self.inGuild then
			setButtonEnabled(arg_25_1, false)
		end

		if bit.band(NotificationLayer.ChannelBits.recv, bit.lshift(1, var_24_0[arg_25_0 + 1])) > 0 then
			setImageSprite(arg_25_1, self.selectedSprite)
			setActive(arg_25_1:Find("text_selected"), true)
		else
			setImageSprite(arg_25_1, self.normalSprite)
			setActive(arg_25_1:Find("text_selected"), false)
		end

		return
	end)

	local var_24_1 = NotificationLayer.ChannelBits.recv
	local var_24_2 = bit.lshift(1, ChatConst.ChannelAll)

	self.filteredMessages = _.filter(self.messages, function(arg_26_0)
		return var_24_1 == var_24_2 or bit.band(var_24_1, bit.lshift(1, arg_26_0.type)) > 0
	end)
	self.filteredMessages = _.slice(self.filteredMessages, #self.filteredMessages - NotificationLayer.MaxCount + 1, NotificationLayer.MaxCount)

	return
end

function NotificationLayer:updateChatChannel()
	setImageSprite(self.channelSend:Find("Text"), self.bottomChannelTextSprites[NotificationLayer.ChannelBits.send], true)

	return
end

function NotificationLayer:updateChannelSendPop()
	local var_28_0 = ChatConst.SendChannels
	local var_28_1 = UIItemList.New(self.channelSendPop:Find("type_send"), self.bottomChannelTpl)

	local function var_28_2()
		var_28_1:each(function(arg_30_0, arg_30_1)
			local var_30_0 = var_28_0[arg_30_0 + 1]

			if var_28_0[arg_30_0 + 1] == ChatConst.ChannelGuild and not self.inGuild then
				setButtonEnabled(arg_30_1, false)
			end

			local var_30_1 = NotificationLayer.ChannelBits.send == var_30_0

			if NotificationLayer.ChannelBits.send == var_30_0 then
				setImageSprite(arg_30_1:Find("bottom"), self.bottomChannelSelectedSprite, true)
			else
				setImageSprite(arg_30_1:Find("bottom"), self.bottomChannelNormalSprite, true)
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

			setImageSprite(arg_31_2:Find("text"), self.bottomChannelTextSprites[var_28_0[arg_31_1 + 1]], true)
			setImageSprite(arg_31_2:Find("selected"), self.bottomChannelTextSprites[var_28_0[arg_31_1 + 1]], true)
			onButton(self, arg_31_2, function()
				setActive(self.channelSendPop, false)

				NotificationLayer.ChannelBits.send = var_31_0

				var_28_2()
				self:updateChatChannel()

				return
			end, SFX_UI_TAG)
		end

		return
	end)
	var_28_1:align(#ChatConst.SendChannels)
	var_28_2()

	return
end

function NotificationLayer:updateRoom()
	setText(self.enterRoomTip:Find("text"), i18n("main_notificationLayer_enter_room", self.player.chatRoomId == 0 and "" or self.player.chatRoomId))
	setText(self.roomBtn:Find("Text"), self.player.chatRoomId == 0 and i18n("common_not_enter_room") or self.player.chatRoomId)
	self:showEnterRommTip()

	return
end

function NotificationLayer:showChangeRoomPanel()
	pg.UIMgr.GetInstance():BlurPanel(self.changeRoomPanel)

	self.inputTF.text = tostring(self.player.chatRoomId)
	self.tempRoomSendBits = NotificationLayer.ChannelBits.send

	local var_34_0 = ChatConst.SendChannels
	local var_34_1 = UIItemList.New(self.roomSendBtns, self.switchTpl)

	local function var_34_2()
		var_34_1:each(function(arg_36_0, arg_36_1)
			if var_34_0[arg_36_0 + 1] == ChatConst.ChannelGuild and not self.inGuild then
				setButtonEnabled(arg_36_1, false)
			end

			if self.tempRoomSendBits == var_34_0[arg_36_0 + 1] then
				setImageSprite(arg_36_1, self.switchSelectedSprite)
			else
				setImageSprite(arg_36_1, self.switchNormalSprite)
			end

			return
		end)

		return
	end

	var_34_1:make(function(arg_37_0, arg_37_1, arg_37_2)
		if arg_37_0 == UIItemList.EventUpdate then
			local var_37_0 = var_34_0[arg_37_1 + 1]

			setImageSprite(arg_37_2:Find("text"), self.switchTextSprites[var_34_0[arg_37_1 + 1]], true)
			onButton(self, arg_37_2, function()
				self.tempRoomSendBits = var_37_0

				var_34_2()

				return
			end, SFX_UI_TAG)
		end

		return
	end)
	var_34_1:align(#ChatConst.SendChannels)
	var_34_2()

	self.tempRoomRecvBits = NotificationLayer.ChannelBits.recv

	local var_34_3 = ChatConst.RecvChannels
	local var_34_4 = UIItemList.New(self.roomRecvBtns, self.switchTpl)

	local function var_34_5()
		var_34_4:each(function(arg_40_0, arg_40_1)
			if var_34_3[arg_40_0 + 1] == ChatConst.ChannelGuild and not self.inGuild then
				setButtonEnabled(arg_40_1, false)
			end

			if bit.band(self.tempRoomRecvBits, bit.lshift(1, var_34_3[arg_40_0 + 1])) > 0 then
				setImageSprite(arg_40_1, self.switchSelectedSprite)
			else
				setImageSprite(arg_40_1, self.switchNormalSprite)
			end

			return
		end)

		return
	end

	var_34_4:make(function(arg_41_0, arg_41_1, arg_41_2)
		if arg_41_0 == UIItemList.EventUpdate then
			local var_41_0 = var_34_3[arg_41_1 + 1]

			setImageSprite(arg_41_2:Find("text"), self.switchTextSprites[var_34_3[arg_41_1 + 1]], true)
			onButton(self, arg_41_2, function()
				self.tempRoomRecvBits = IndexConst.ToggleBits(self.tempRoomRecvBits, _.filter(var_34_3, function(arg_43_0)
					return arg_43_0 ~= ChatConst.ChannelGuild or self.inGuild
				end), ChatConst.ChannelAll, var_41_0)

				var_34_5()

				return
			end, SFX_UI_TAG)
		end

		return
	end)
	var_34_4:align(#ChatConst.RecvChannels)
	var_34_5()
	setActive(self.changeRoomPanel, true)

	return
end

function NotificationLayer:closeChangeRoomPanel()
	pg.UIMgr.GetInstance():UnOverlayPanel(self.changeRoomPanel, self._tf)
	setActive(self.changeRoomPanel, false)

	return
end

function NotificationLayer:removeAllBubble()
	for iter_45_0, iter_45_1 in ipairs(self.bubbleCards or {}) do
		setActive(iter_45_1.tf, false)

		local var_45_1 = self.poolBubble.others

		if iter_45_1.__cname == "ChatBubblePublic" then
			var_45_1 = self.poolBubble.public
		elseif iter_45_1.__cname == "ChatBubble" and iter_45_1.data.player and iter_45_1.data.player.id == self.player.id then
			var_45_1 = self.poolBubble.self
		end

		iter_45_1:dispose()
		table.insert(var_45_1, iter_45_1)
	end

	self.bubbleCards = {}

	for iter_45_2, iter_45_3 in pairs(self.worldBossCards) do
		if not IsNil(iter_45_3.tf) then
			Destroy(iter_45_3.tf)
		end
	end

	self.worldBossCards = {}

	return
end

function NotificationLayer:updateAll()
	self:removeAllBubble()

	self.index = math.max(1, #self.filteredMessages - NotificationLayer.InitCount)

	for iter_46_0 = self.index, #self.filteredMessages do
		self:append(self.filteredMessages[iter_46_0], -1)
	end

	scrollToBottom(self.content.parent)
	setActive(self.emptySign, PLATFORM_CODE == PLATFORM_JP and #self.filteredMessages <= 0)

	return
end

function NotificationLayer:append(arg_47_1, arg_47_2, arg_47_3)
	if #self.filteredMessages >= NotificationLayer.MaxCount * 2 then
		self:updateFilter()
		self:updateAll()
	else
		arg_47_3 = arg_47_3 and self.scroll.normalizedPosition.y < 0.1

		if arg_47_1.type == ChatConst.ChannelPublic then
			if arg_47_1.id == 0 then
				self:appendTopPublic(arg_47_1)
			else
				self:appendPublic(arg_47_1, arg_47_2)
			end
		elseif arg_47_1:IsWorldBossNotify() then
			self:appendPublic(arg_47_1, arg_47_2)
		else
			self:appendOthers(arg_47_1, arg_47_2)
		end

		if arg_47_3 then
			scrollToBottom(self.content.parent)
		end
	end

	setActive(self.emptySign, PLATFORM_CODE == PLATFORM_JP and #self.filteredMessages <= 0)

	return
end

function NotificationLayer:appendOthers(arg_48_1, arg_48_2)
	local var_48_0 = arg_48_1.player
	local var_48_1 = self.poolBubble.others
	local var_48_2 = self.prefabOthers

	if arg_48_1.player.id == self.player.id then
		var_48_1 = self.poolBubble.self
		var_48_2 = self.prefabSelf
		arg_48_1.isSelf = true
		arg_48_1.player = setmetatable(Clone(self.player), {
			__index = arg_48_1.player.__index
		})
	end

	local var_48_3

	if #var_48_1 > 0 then
		var_48_3 = var_48_1[1]

		setActive(var_48_1[1].tf, true)
		table.remove(var_48_1, 1)
	else
		var_48_3 = ChatBubble.New((cloneTplTo(var_48_2, self.content)))
	end

	var_48_3.tf:SetSiblingIndex(arg_48_2)
	table.insert(self.bubbleCards, var_48_3)
	var_48_3:update(arg_48_1)
	removeOnButton(var_48_3.headTF)
	onButton(self, var_48_3.headTF, function()
		self:emit(NotificationMediator.OPEN_INFO, var_48_0, var_48_3.tf:Find("shipicon/icon").position, arg_48_1.content)

		return
	end, SFX_PANEL)

	return
end

function NotificationLayer:appendPublic(arg_50_1, arg_50_2)
	local var_50_0

	if arg_50_1.id == 4 then
		var_50_0 = ChatBubbleWorldBoss.New(cloneTplTo((WorldBossConst.__IsCurrBoss(arg_50_1.args.wordBossConfigId) or nil) and (self.prefabWorldBoss or self.prefabWorldBossArchives), self.content), self.currentForm ~= NotificationLayer.FORM_BATTLE)

		table.insert(self.worldBossCards, var_50_0)
	else
		local var_50_1 = self.poolBubble.public

		if #self.poolBubble.public > 0 then
			var_50_0 = var_50_1[1]

			setActive(var_50_1[1].tf, true)
			table.remove(var_50_1, 1)
		else
			var_50_0 = ChatBubblePublic.New((cloneTplTo(self.prefabPublic, self.content)))
		end

		table.insert(self.bubbleCards, var_50_0)
	end

	var_50_0.tf:SetSiblingIndex(arg_50_2)
	var_50_0:update(arg_50_1)

	return
end

function NotificationLayer:appendTopPublic(arg_51_1)
	local var_51_0 = 120 - (pg.TimeMgr.GetInstance():GetServerTime() - arg_51_1.timestamp)

	if var_51_0 <= 0 then
		return
	end

	SetActive(self.topMsg, true)
	ChatProxy.InjectPublic(findTF(self.topPublic, "text"):GetComponent("RichText"), arg_51_1)

	findTF(self.topPublic, "channel"):GetComponent(typeof(Image)).sprite = GetSpriteFromAtlas("channel", ChatConst.GetChannelSprite(arg_51_1.type) .. "_1920")

	if self._topTimer then
		self._topTimer:Stop()

		self._topTimer = nil
	end

	self._topTimer = Timer.New(function()
		SetActive(self.topMsg, false)

		self._topTimer = nil

		return
	end, var_51_0, 1)

	self._topTimer:Start()

	return
end

function NotificationLayer:showEnterRommTip()
	if self.player.chatRoomId == 0 then
		return
	end

	if not LeanTween.isTweening(go(self.enterRoomTip)) then
		LeanTween.value(go(self.enterRoomTip), 1, 0, 2):setOnUpdate(System.Action_float(function(arg_54_0)
			self.enterRoomCG.alpha = arg_54_0

			return
		end)):setEase(LeanTweenType.easeInSine):setOnComplete(System.Action(function()
			self.enterRoomCG.alpha = 0

			LeanTween.cancel(go(self.enterRoomTip))

			return
		end)):setDelay(0.5)
	end

	return
end

function NotificationLayer:getPos(arg_56_1)
	return
end

function NotificationLayer:displayEmojiPanel()
	self:emit(NotificationMediator.OPEN_EMOJI, function(arg_58_0)
		self:emit(NotificationMediator.ON_SEND_PUBLIC, NotificationLayer.ChannelBits.send, string.gsub(ChatConst.EmojiCode, "code", arg_58_0))

		return
	end, Vector3(self.emoji.position.x, self.emoji.position.y, 0))

	return
end

function NotificationLayer:willExit()
	if isActive(self.changeRoomPanel) then
		self:closeChangeRoomPanel()
	end

	self:UnOverlayPanel(self._tf)
	LeanTween.cancel(self._go)
	LeanTween.cancel(go(self.enterRoomTip))

	if self._topTimer then
		self._topTimer:Stop()

		self._topTimer = nil
	end

	for iter_59_0, iter_59_1 in ipairs(self.bubbleCards or {}) do
		iter_59_1:dispose()
	end

	for iter_59_2, iter_59_3 in ipairs(self.worldBossCards or {}) do
		iter_59_3:dispose()
	end

	self.worldBossCards = nil

	for iter_59_4, iter_59_5 in pairs(self.poolBubble) do
		for iter_59_6, iter_59_7 in ipairs(iter_59_5) do
			iter_59_7:dispose()
		end
	end

	self:removeLateUpdateListener()
	getProxy(GuildProxy):ClearNewChatMsgCnt()

	return
end

function NotificationLayer:insertEmojiToInputText(arg_60_1)
	self.input.text = self.input.text .. string.gsub(ChatConst.EmojiIconCode, "code", arg_60_1)

	return
end

function NotificationLayer:addLateUpdateListener()
	return
end

function NotificationLayer:removeLateUpdateListener()
	return
end

return NotificationLayer
