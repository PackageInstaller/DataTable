local GuildThemePage = class("GuildThemePage", import("...base.GuildBasePage"))

function GuildThemePage:getTargetUI()
	if getProxy(SettingsProxy):IsMellowStyle() then
		return "GuildThemeBlueUI4Mellow", "GuildThemeRedUI4Mellow"
	else
		return "GuildThemeBlueUI", "GuildThemeRedUI"
	end

	return
end

function GuildThemePage:OnLoaded()
	self.top = self._tf:Find("top")
	self.chatBtn = self._tf:Find("chat_bg")
	self.chatBtnTip = self.chatBtn:Find("tip")
	self.chatBtnTipCnt = self.chatBtn:Find("tip/Text"):GetComponent(typeof(Text))
	self.chatPanel = self._tf:Find("chat_frame")
	self.chatCloseBtn = self.chatPanel:Find("close")
	self.bottomPanel = self._tf:Find("bottom")
	self.battleEvent = self._tf:Find("bottom/battle_event")
	self.battleEventTip = self.battleEvent:Find("tip")
	self.battleEventTipCnt = self.battleEventTip:Find("Text"):GetComponent(typeof(Text))
	self.battleReport = self._tf:Find("bottom/battle_report")
	self.battleReportTip = self.battleReport:Find("tip")
	self.battleReportCnt = self.battleReportTip:Find("Text"):GetComponent(typeof(Text))
	self.shopBtn = self._tf:Find("bottom/battle_shop")
	self.nameTxt = self._tf:Find("top/name/Text"):GetComponent(typeof(Text))
	self.modifyBtn = self._tf:Find("top/name")
	self.levelImg = self._tf:Find("top/level/Text"):GetComponent(typeof(Text))
	self.factionTxt = self._tf:Find("top/policy/label"):GetComponent(typeof(Text))
	self.policyTxt = self._tf:Find("top/policy/Text"):GetComponent(typeof(Text))
	self.idTxt = self._tf:Find("top/id/Text"):GetComponent(typeof(Text))
	self.numberTxt = self._tf:Find("top/id/number"):GetComponent(typeof(Text))
	self.expImg = self._tf:Find("top/exp/bar")
	self.levelTxt = self._tf:Find("top/exp/lv/Text"):GetComponent(typeof(Text))
	self.topPanelWidth = self.top.rect.height
	self.bottomPanelWidth = -165
	self.chatPanelWidth = self.chatPanel.rect.width + 300
	self.chatBtnWidth = self.chatBtn.rect.width + 300

	setAnchoredPosition(self.chatPanel, {
		x = self.chatPanelWidth
	})
	setAnchoredPosition(self.chatBtn, {
		x = 0
	})

	self.modifyPage = GuildModifitonPage.New(self._tf, self.event)
	self.chatBubbles = {}

	return
end

function GuildThemePage:OnInit()
	onButton(self, self.battleEvent, function()
		triggerToggle(self.contextData.toggles[GuildMainScene.TOGGLE_TAG[6]], true)

		return
	end, SFX_PANEL)
	onButton(self, self.battleReport, function()
		self:emit(GuildMainMediator.OPEN_EVENT_REPORT)

		return
	end, SFX_PANEL)
	onButton(self, self.shopBtn, function()
		self:emit(GuildMainMediator.OPEN_SHOP)

		return
	end, SFX_PANEL)
	onButton(self, self.chatBtn, function()
		self:InitChatWindow()
		self:ShowOrHideChatWindow(true)

		return
	end, SFX_PANEL)
	onButton(self, self.chatCloseBtn, function()
		getProxy(GuildProxy):ClearNewChatMsgCnt()
		self:UpdateChatBtn()
		self:ShowOrHideChatWindow(false)

		return
	end, SFX_PANEL)
	onButton(self, self.modifyBtn, function()
		self.modifyPage:ExecuteAction("Show", self.guildVO, self.playerVO)

		return
	end, SFX_PANEL)

	return
end

function GuildThemePage:Update(arg_10_1, arg_10_2, arg_10_3)
	self:UpdateData(arg_10_1, arg_10_2, arg_10_3)
	self:UpdateMainInfo()
	self:UpdateChatBtn()
	self:UpdateBattleBtn()
	self:Show()

	return
end

function GuildThemePage:ResUISettings()
	return {
		showType = PlayerResUI.TYPE_ALL
	}
end

function GuildThemePage:UpdateData(arg_12_1, arg_12_2, arg_12_3)
	self:UpdateGuild(arg_12_1)

	self.playerVO = arg_12_2
	self.chatMsgs = arg_12_3
	self.isAdmin = arg_12_1:IsAdministrator()

	return
end

function GuildThemePage:UpdateGuild(arg_13_1)
	self.guildVO = arg_13_1

	return
end

function GuildThemePage:RefreshReportBtn()
	self:UpdateBattleBtn()

	return
end

function GuildThemePage:UpdateBattleBtn()
	local var_15_0 = getProxy(GuildProxy):GetReports()

	setActive(self.battleEvent, self.guildVO:GetActiveEvent() ~= nil)
	setActive(self.battleEventTip, false)

	local var_15_1 = self.guildVO:getMemberById(self.playerVO.id)
	local var_15_2 = _.select(_.values(var_15_0), function(arg_16_0)
		return arg_16_0:CanSubmit()
	end)
	local var_15_3 = #var_15_2 > 0 and not var_15_1:IsRecruit()

	setActive(self.battleReport, var_15_3)
	setActive(self.battleReportTip, var_15_3)

	if var_15_3 then
		self.battleReportCnt.text = #var_15_2
	end

	return
end

function GuildThemePage:UpdateChatBtn()
	local var_17_0 = getProxy(GuildProxy):GetNewChatMsgCnt()
	local var_17_1 = var_17_0 > 0

	setActive(self.chatBtnTip, var_17_0 > 0)

	if var_17_1 then
		self.chatBtnTipCnt.text = var_17_0
	end

	return
end

function GuildThemePage:InitChatWindow()
	if self.isInitChatWindow then
		return
	end

	self.isInitChatWindow = true
	self.noticeTxt = self.chatPanel:Find("log/notice/InputField"):GetComponent(typeof(InputField))
	self.noticeMask = self.chatPanel:Find("log/notice/mask")
	self.noticeScrollTxt = self.chatPanel:Find("log/notice/mask/label"):GetComponent(typeof(ScrollText))
	self.logContent = self.chatPanel:Find("log/content/viewport/list")
	self.prefabPublic = self:getTpl("tpl", self.logContent)
	self.chatRect = self.chatPanel:Find("bottom/list")
	self.chatContent = self.chatPanel:Find("bottom/list/content")
	self.prefabOthers = self.chatPanel:Find("bottom/list/popo_other")
	self.prefabSelf = self.chatPanel:Find("bottom/list/popo_self")
	self.prefabWorldboss = self.chatPanel:Find("bottom/list/popo_worldboss")
	self.sendBtn = self.chatPanel:Find("bottom/bottom/send")
	self.msgInput = self.chatPanel:Find("bottom/bottom/input"):GetComponent(typeof(InputField))
	self.emojiBtn = self.chatPanel:Find("bottom/bottom/emoji")
	self.newMsgTip = self.chatPanel:Find("bottom/bottom/tip")

	onButton(self, self.sendBtn, function()
		if wordVer(self.msgInput.text) > 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("playerinfo_mask_word"))

			return
		end

		if self.msgInput.text == "" then
			pg.TipsMgr.GetInstance():ShowTips(i18n("guild_msg_is_null"))

			return
		end

		if self.chatTimer then
			if pg.TimeMgr.GetInstance():GetServerTime() - self.chatTimer < 5 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("dont_send_message_frequently"))

				return
			end
		end

		self.chatTimer = pg.TimeMgr.GetInstance():GetServerTime()

		self:emit(GuildMainMediator.SEND_MSG, self.msgInput.text)

		self.msgInput.text = ""

		return
	end, SFX_PANEL)
	onButton(self, self.emojiBtn, function()
		self:emit(GuildMainMediator.OPEN_EMOJI, Vector3(self.emojiBtn.position.x, self.emojiBtn.position.y, 0), function(arg_21_0)
			self:emit(GuildMainMediator.SEND_MSG, string.gsub(ChatConst.EmojiCode, "code", arg_21_0))

			return
		end)

		return
	end, SFX_PANEL)
	GetOrAddComponent(self.chatRect, typeof(EventTriggerListener)):AddDragEndFunc(function(arg_22_0, arg_22_1)
		if GetComponent(self.chatRect, typeof(ScrollRect)).normalizedPosition.y <= 0.1 then
			self:ClearChatTip()
		end

		return
	end)
	self:UpdateChatWindow()

	if self.isAdmin then
		onInputEndEdit(self, self.noticeTxt.gameObject, function()
			local var_23_0 = self.guildVO:GetAnnounce() or ""
			local var_23_1 = getInputText(self.noticeTxt.gameObject)

			if var_23_1 == "" or var_23_1 == var_23_0 then
				return
			end

			if wordVer(var_23_1) > 0 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("playerinfo_mask_word"))
				setInputText(self.noticeTxt.gameObject, "")

				return
			end

			self.noticeScrollTxt:SetText(var_23_1)
			self:emit(GuildMainMediator.MODIFY, 5, 0, var_23_1)
			setInputText(self.noticeTxt.gameObject, "")

			return
		end)
	end

	setButtonEnabled(self.noticeMask, self.isAdmin)

	return
end

function GuildThemePage:UpdateChatWindow()
	self:UpdateNotice()
	self:UpdateAllLog(self.guildVO.logInfo)
	self:UpdateAllChat(self.chatMsgs)

	return
end

function GuildThemePage:UpdateNotice()
	local var_25_0 = self.guildVO:GetAnnounce()

	self.noticeScrollTxt:SetText((not var_25_0 or var_25_0 == "") and i18n("guild_not_exist_notifycation") or var_25_0)

	return
end

function GuildThemePage:UpdateAllLog(arg_26_1)
	removeAllChildren(self.logContent)

	for iter_26_0, iter_26_1 in ipairs(arg_26_1) do
		self:AppendLog(iter_26_1)
	end

	return
end

function GuildThemePage:AppendLog(arg_27_1, arg_27_2)
	if not self.isInitChatWindow then
		return
	end

	if self.logContent.childCount >= 200 then
		self:emit(GuildMainMediator.ON_REBUILD_LOG_ALL)
	else
		local var_27_0 = cloneTplTo(self.prefabPublic, self.logContent)

		if arg_27_2 then
			var_27_0:SetAsFirstSibling()
		end

		local var_27_1 = var_27_0:Find("text"):GetComponent("RichText")
		local var_27_2 = var_27_0:Find("time"):GetComponent(typeof(Text))
		local var_27_3, var_27_4 = arg_27_1:getConent()

		if arg_27_1.cmd == GuildLogInfo.CMD_TYPE_GET_SHIP then
			ChatProxy.InjectPublic(var_27_1, var_27_3, true)
		else
			var_27_1.text = var_27_3
		end

		var_27_2.text = var_27_4
	end

	return
end

function GuildThemePage:UpdateAllChat(arg_28_1)
	local var_28_0 = arg_28_1 or {}

	removeAllChildren(self.chatContent)

	local var_28_1 = {}

	self.index = math.max(1, #var_28_0 - GuildConst.CHAT_LOG_MAX_COUNT)

	for iter_28_0 = self.index, #var_28_0 do
		table.insert(var_28_1, function(arg_29_0)
			self:Append(var_28_0[iter_28_0], -1, true)
			arg_29_0()

			return
		end)
	end

	seriesAsync(var_28_1, function()
		Timer.New(function()
			if not IsNil(self.chatContent) then
				scrollToBottom(self.chatContent.parent)
			end

			return
		end, 0.5, 1):Start()

		return
	end)

	return
end

function GuildThemePage:Append(arg_32_1, arg_32_2, arg_32_3)
	self:UpdateChatBtn()

	if not self.isInitChatWindow then
		return
	end

	if self.chatContent.childCount >= GuildConst.CHAT_LOG_MAX_COUNT * 2 then
		self:emit(GuildMainMediator.REBUILD_ALL)
	elseif arg_32_1.id and arg_32_1.id == 4 then
		self:AddWorldBossMsg(arg_32_1, arg_32_2, arg_32_3)
	else
		self:AppendWorld(arg_32_1, arg_32_2, arg_32_3)
	end

	return
end

function GuildThemePage:ShowChatTip()
	setActive(self.newMsgTip, true)

	return
end

function GuildThemePage:ClearChatTip()
	setActive(self.newMsgTip, false)

	return
end

function GuildThemePage:AddWorldBossMsg(arg_35_1, arg_35_2, arg_35_3)
	local var_35_0 = Clone(arg_35_1)

	if not arg_35_3 then
		self:ShowChatTip()
	end

	local var_35_2 = ChatBubbleWorldBoss.New((cloneTplTo(self.prefabWorldboss, self.chatContent)))

	if arg_35_2 >= 0 then
		var_35_2.tf:SetSiblingIndex(arg_35_2)
	end

	var_35_2:update(var_35_0)
	table.insert(self.chatBubbles, var_35_2)

	return
end

function GuildThemePage:AppendWorld(arg_36_1, arg_36_2, arg_36_3)
	local var_36_0 = Clone(arg_36_1)
	local var_36_1 = var_36_0.player
	local var_36_2 = self.prefabOthers

	if var_36_0.player.id == self.playerVO.id then
		var_36_2 = self.prefabSelf
		var_36_0.player = setmetatable(Clone(self.playerVO), {
			__index = var_36_0.player
		})
	elseif not arg_36_3 then
		self:ShowChatTip()
	end

	local var_36_3 = GuildChatBubble.New((cloneTplTo(var_36_2, self.chatContent)))

	if arg_36_2 >= 0 then
		var_36_3.tf:SetSiblingIndex(arg_36_2)
	end

	var_36_0.isSelf = var_36_1.id == self.playerVO.id

	var_36_3:update(var_36_0)

	if not arg_36_3 and var_36_0.isSelf then
		onNextTick(function()
			scrollToBottom(self.chatContent.parent)

			return
		end)
	end

	table.insert(self.chatBubbles, var_36_3)

	return
end

function GuildThemePage:UpdateMainInfo()
	self.nameTxt.text = self.guildVO:getName()
	self.factionTxt.text = self.guildVO:getFactionName()
	self.policyTxt.text = self.guildVO:getPolicyName()
	self.idTxt.text = "ID:" .. self.guildVO.id
	self.numberTxt.text = self.guildVO.memberCount .. "/" .. self.guildVO:getMaxMember()

	setFillAmount(self.expImg, self.guildVO.exp / math.max(self.guildVO:getLevelMaxExp(), 1))

	if self.guildVO.level <= 9 then
		self.levelTxt.text = "0" .. self.guildVO.level or self.guildVO.level
	end

	local var_38_1 = ""

	for iter_38_0 = 1, math.floor(self.guildVO.level / 10) do
		var_38_1 = var_38_1 .. ":"
	end

	self.levelImg.text = var_38_1 .. (self.guildVO.level % 10 == 0 and "" or self.guildVO.level % 10)

	if self.isInitChatWindow then
		self:UpdateNotice()
	end

	return
end

function GuildThemePage:ShowOrHideChatWindow(arg_39_1)
	if LeanTween.isTweening(go(self.chatPanel)) then
		return
	end

	local var_39_0
	local var_39_1
	local var_39_2
	local var_39_3

	if not arg_39_1 then
		var_39_1 = self.chatPanelWidth
		var_39_0 = 0
		var_39_3 = 0
		var_39_2 = self.chatBtnWidth
	else
		var_39_1 = 0
		var_39_0 = self.chatPanelWidth
		var_39_3 = self.chatBtnWidth
		var_39_2 = 0
	end

	self.isShowChatWindow = arg_39_1

	LeanTween.value(go(self.chatPanel), var_39_0, var_39_1, 0.3):setOnUpdate(System.Action_float(function(arg_41_0)
		setAnchoredPosition(self.chatPanel, {
			x = arg_41_0
		})

		return
	end)):setOnComplete(System.Action(function()
		if arg_39_1 then
			setParent(self.chatPanel, pg.UIMgr.GetInstance().OverlayMain, true)

			self.chatPanel.localPosition = Vector3(self.chatPanel.localPosition.x, self.chatPanel.localPosition.y, 0)

			pg.UIMgr.GetInstance():OverlayPanel(self.chatPanel, {
				groupName = "group_GuildMainUI",
				pbList = {
					self.chatPanel
				}
			})

			self.chatPanelAnchoredPositionX = self.chatPanel.anchoredPosition.x
		else
			pg.UIMgr.GetInstance():UnOverlayPanel(self.chatPanel, self._tf)
		end

		return
	end))
	LeanTween.value(go(self.chatBtn), var_39_2, var_39_3, 0.3):setOnUpdate(System.Action_float(function(arg_42_0)
		setAnchoredPosition(self.chatBtn, {
			x = arg_42_0
		})

		return
	end))

	return
end

function GuildThemePage:EnterOrExitPreView(arg_43_1)
	if LeanTween.isTweening(go(self.top)) or LeanTween.isTweening(go(self.bottomPanel)) or LeanTween.isTweening(go(self.chatPanel)) or LeanTween.isTweening(go(self.chatBtn)) then
		return
	end

	local var_43_0 = arg_43_1 and {
		0,
		self.topPanelWidth
	} or {
		self.topPanelWidth,
		0
	}

	LeanTween.value(go(self.top), var_43_0[1], var_43_0[2], 0.3):setOnUpdate(System.Action_float(function(arg_44_0)
		setAnchoredPosition(self.top, {
			y = arg_44_0
		})

		return
	end))

	local var_43_1 = arg_43_1 and {
		94,
		94 + self.bottomPanelWidth
	} or {
		94 + self.bottomPanelWidth,
		94
	}

	LeanTween.value(go(self.bottomPanel), var_43_1[1], var_43_1[2], 0.3):setOnUpdate(System.Action_float(function(arg_45_0)
		setAnchoredPosition(self.bottomPanel, {
			y = arg_45_0
		})

		return
	end))

	if self.isShowChatWindow then
		local var_43_2

		if arg_43_1 then
			var_43_2 = {
				0,
				self.chatPanelWidth
			}

			if not var_43_2 then
				var_43_2 = {
					self.chatPanelWidth
				}
				var_43_2[2] = self.chatPanelAnchoredPositionX or 0
			end
		end

		LeanTween.value(go(self.chatPanel), var_43_2[1], var_43_2[2], 0.3):setOnUpdate(System.Action_float(function(arg_46_0)
			setAnchoredPosition(self.chatPanel, {
				x = arg_46_0
			})

			return
		end))
	else
		local var_43_3 = arg_43_1 and {
			0,
			self.chatBtnWidth
		} or {
			self.chatBtnWidth,
			0
		}

		LeanTween.value(go(self.chatBtn), var_43_3[1], var_43_3[2], 0.3):setOnUpdate(System.Action_float(function(arg_47_0)
			setAnchoredPosition(self.chatBtn, {
				x = arg_47_0
			})

			return
		end))
	end

	return
end

function GuildThemePage:InsertEmojiToInputText(arg_48_1)
	self.msgInput.text = self.msgInput.text .. string.gsub(ChatConst.EmojiIconCode, "code", arg_48_1)

	return
end

function GuildThemePage:OnDestroy()
	if self.isShowChatWindow then
		pg.UIMgr.GetInstance():UnOverlayPanel(self.chatPanel, self._tf)
	end

	if LeanTween.isTweening(go(self.chatPanel)) then
		LeanTween.cancel(go(self.chatPanel))
	end

	if LeanTween.isTweening(go(self.chatBtn)) then
		LeanTween.cancel(go(self.chatBtn))
	end

	self.modifyPage:Destroy()

	for iter_49_0, iter_49_1 in ipairs(self.chatBubbles) do
		if iter_49_1 then
			iter_49_1:dispose()
		end
	end

	self.chatBubbles = nil

	self:Hide()

	return
end

return GuildThemePage
