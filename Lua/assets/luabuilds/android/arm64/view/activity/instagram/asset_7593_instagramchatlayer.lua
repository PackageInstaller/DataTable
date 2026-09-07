local InstagramChatLayer = class("InstagramChatLayer", import("...base.BaseUI"))
local var_0_1 = pg.activity_ins_ship_group_template
local var_0_2 = pg.activity_ins_redpackage
local var_0_3 = pg.emoji_template

function InstagramChatLayer:getUIName()
	return "InstagramChatUI"
end

function InstagramChatLayer:getGroupName()
	return "InstagramMainUI"
end

InstagramChatLayer.ReadType = {
	"all",
	"hasReaded",
	"waitingForRead"
}
InstagramChatLayer.TypeType = {
	"all",
	"single",
	"multiple"
}
InstagramChatLayer.CampIds = {
	0,
	1,
	2,
	3,
	4,
	5,
	6,
	7,
	8,
	9,
	10,
	11,
	12,
	13
}
InstagramChatLayer.CampNames = {
	"word_shipNation_all",
	"word_shipNation_baiYing",
	"word_shipNation_huangJia",
	"word_shipNation_chongYing",
	"word_shipNation_tieXue",
	"word_shipNation_dongHuang",
	"word_shipNation_saDing",
	"word_shipNation_beiLian",
	"word_shipNation_ziyou",
	"word_shipNation_weixi",
	"word_shipNation_mot",
	"word_shipNation_yujinwangguo",
	"word_shipNation_jinghuanlianmeng",
	"word_shipNation_other"
}

function InstagramChatLayer:init()
	self.leftPanel = self._tf:Find("main/leftPanel")
	self.filterBtn = self.leftPanel:Find("leftTop/filter")
	self.isFiltered = self.filterBtn:Find("isFiltered")
	self.charaScrollrect = self.leftPanel:Find("charaScroll"):GetComponent("LScrollRect")
	self.charaScrollContent = self.leftPanel:Find("charaScroll/Viewport/Content")
	self.rightPanel = self._tf:Find("main/rightPanel")
	self.rightChatPanel = self.rightPanel:Find("chat")
	self.rightOfficialAccountsPanel = self.rightPanel:Find("officialAccounts")
	self.characterName = self.rightPanel:Find("chat/rightTop/name")
	self.careBtn = self.rightPanel:Find("chat/rightTop/careBtn")
	self.topicBtn = self.rightPanel:Find("chat/rightTop/topicBtn")
	self.backgroundBtn = self.rightPanel:Find("chat/rightTop/backgroundBtn")
	self.messageList = UIItemList.New(self.rightPanel:Find("chat/messageScroll/Viewport/Content"), self.rightPanel:Find("chat/messageScroll/Viewport/Content/messageCard"))
	self.optionPanel = self.rightPanel:Find("chat/optionPanel")
	self.optionList = UIItemList.New(self.optionPanel, self.optionPanel:Find("option"))
	self.filterUI = self._tf:Find("subPages/InstagramFilterUI")
	self.topicUI = self._tf:Find("subPages/InstagramTopicUI")
	self.backgroundUI = self._tf:Find("subPages/InstagramBackgroundUI")
	self.redPacketUI = self._tf:Find("subPages/InstagramRedPacketUI")

	setText(self.filterBtn:Find("Text"), i18n("juuschat_filter_title"))
	setText(self.filterUI:Find("panel/filterScroll/Viewport/Content/read/subTitleFrame/subTitle"), i18n("juuschat_filter_subtitle1"))
	setText(self.filterUI:Find("panel/filterScroll/Viewport/Content/type/subTitleFrame/subTitle"), i18n("juuschat_filter_subtitle2"))
	setText(self.filterUI:Find("panel/filterScroll/Viewport/Content/subTitleFrame/subTitle"), i18n("juuschat_filter_subtitle3"))
	setText(self.filterUI:Find("panel/filterScroll/Viewport/Content/read/option/Text"), i18n("juuschat_filter_tip1"))
	setText(self.filterUI:Find("panel/filterScroll/Viewport/Content/read/option_1/Text"), i18n("juuschat_filter_tip2"))
	setText(self.filterUI:Find("panel/filterScroll/Viewport/Content/read/option_2/Text"), i18n("juuschat_filter_tip3"))
	setText(self.filterUI:Find("panel/filterScroll/Viewport/Content/type/option/Text"), i18n("juuschat_filter_tip1"))
	setText(self.filterUI:Find("panel/filterScroll/Viewport/Content/type/option_1/Text"), i18n("juuschat_filter_tip4"))
	setText(self.filterUI:Find("panel/filterScroll/Viewport/Content/type/option_2/Text"), i18n("juuschat_filter_tip5"))
	setText(self.topicUI:Find("panel/topicScroll/Viewport/Content/self/topic/waiting"), i18n("juuschat_chattip3"))
	setText(self.topicUI:Find("panel/topicScroll/Viewport/Content/self/topic/selected/Text"), i18n("juuschat_label2"))
	setText(self.topicUI:Find("panel/topicScroll/Viewport/Content/other/topic/waiting"), i18n("juuschat_chattip3"))
	setText(self.topicUI:Find("panel/topicScroll/Viewport/Content/other/topic/selected/Text"), i18n("juuschat_label2"))
	setText(self.backgroundUI:Find("panel/backgroundScroll/Viewport/Content/background/selected/Text"), i18n("juuschat_label1"))
	setText(self.redPacketUI:Find("panel/got/detailBtn/Text"), i18n("juuschat_redpacket_show_detail"))
	setText(self.redPacketUI:Find("panel/detail/title"), i18n("juuschat_redpacket_detail"))
	setText(self._tf:Find("main/noFilteredMessageBg/Text"), i18n("juuschat_filter_empty"))
	setText(self.backgroundUI:Find("panel/backgroundScroll/Viewport/Content/background/lockFrame/Text"), i18n("juuschat_background_tip1"))

	self.redPacketGot = self.redPacketUI:Find("panel/got")

	self:OverlayPanel(self._tf)
	SetActive(self.filterUI, false)
	SetActive(self.isFiltered, false)
	SetActive(self.topicUI, false)
	SetActive(self.backgroundUI, false)
	SetActive(self.redPacketUI, false)
	SetActive(self.rightPanel, false)

	self.timerList = {}
	self.canFresh = false

	local var_3_0 = self.rightPanel:Find("chat/messageScroll/Scrollbar Vertical"):GetComponent(typeof(RectTransform))

	self.messageScrollWidth = var_3_0.rect.width
	self.messageScrollHeight = var_3_0.rect.height

	self.filterUI:Find("panel/title"):GetComponent(typeof(Image)):SetNativeSize()
	self.topicUI:Find("panel/title"):GetComponent(typeof(Image)):SetNativeSize()
	self.backgroundUI:Find("panel/title"):GetComponent(typeof(Image)):SetNativeSize()
	self:InitOfficialAccounts()

	return
end

function InstagramChatLayer:didEnter()
	self:SetData()

	function self.charaScrollrect.onInitItem(arg_5_0)
		self:OnInitItem(arg_5_0)

		return
	end

	function self.charaScrollrect.onUpdateItem(arg_6_0, arg_6_1)
		self:OnUpdateItem(arg_6_0, arg_6_1)

		return
	end

	self:UpdateCharaList(false, false)
	self:SetFilterPanel()

	self.officialAccountsTimerList = {}
	self.officialAccountsItemList = {}

	self:AddOfficialAccountsTimer()

	return
end

function InstagramChatLayer:InsertOfficialAccounts()
	if InstagramTools.ExistOfficialAccounts() then
		table.insert(self.chatList, 1, {
			chatType = InstagramConst.INSTAGRAM_CHAT_TYPE.OFFICIAL_ACCOUNT
		})
	end

	return
end

function InstagramChatLayer:OnInitItem(arg_8_1)
	return
end

function InstagramChatLayer:OnUpdateItem(arg_9_1, arg_9_2)
	local var_9_0 = self.chatList[arg_9_1 + 1]
	local var_9_1 = tf(arg_9_2)

	setActive(var_9_1, true)

	local var_9_2 = var_9_0.chatType == InstagramConst.INSTAGRAM_CHAT_TYPE.OFFICIAL_ACCOUNT

	setActive(var_9_1:Find("chat"), not (var_9_0.chatType == InstagramConst.INSTAGRAM_CHAT_TYPE.OFFICIAL_ACCOUNT))
	setActive(var_9_1:Find("officialAccounts"), var_9_2)

	if not var_9_2 then
		setImageSprite(var_9_1:Find("chat/charaBg/chara"), LoadSprite("qicon/" .. ((var_9_0.currentTopic.isII and var_9_0.sculptureII ~= "" or nil) and var_9_0.sculptureII)), false)
		setText(var_9_1:Find("chat/name"), var_9_0.name)

		local var_9_4 = var_9_0:GetDisplayWord()

		if not self.currentChat or self.currentChat.characterId ~= var_9_0.characterId or not self.isSlowMsg then
			setText(var_9_1:Find("chat/msg"), var_9_4)
		end

		setText(var_9_1:Find("chat/displayWord"), var_9_4)
		SetActive(var_9_1:Find("chat/care"), var_9_0.care == 1)

		if var_9_0.care == 1 and self.careAniTriggerId and self.careAniTriggerId == var_9_0.characterId then
			self.careAniTriggerId = nil

			var_9_1:Find("chat/care"):GetComponent(typeof(Animation)):Play("anim_newinstagram_care")
		end

		SetActive(var_9_1:Find("chat/tip"), var_9_0:GetCharacterEndFlag() == 0)
		setText(var_9_1:Find("chat/id"), var_9_0.characterId)
		onButton(self, var_9_1, function()
			if self.currentChat and self.currentChat.characterId ~= var_9_0.characterId then
				self:ResetCharaTextFunc(self.currentChat.characterId)
			end

			self.currentChat = var_9_0

			SetActive(self.rightPanel, true)
			SetActive(self._tf:Find("main/rightNoMessageBg"), false)
			self:UpdateChatContent(var_9_0, false, false)
			self:SetTopicPanel(var_9_0)
			self:SetBackgroundPanel(var_9_0)

			for iter_10_0 = 0, self.charaScrollContent.childCount - 1 do
				SetActive(self.charaScrollContent:GetChild(iter_10_0):Find("frame"), false)
			end

			SetActive(var_9_1:Find("frame"), true)

			function self.cancelFrame()
				if not IsNil(var_9_1) then
					SetActive(var_9_1:Find("frame"), false)
				end

				return
			end

			local var_10_0 = self.rightPanel:GetComponent(typeof(Animation))

			var_10_0:Stop()
			var_10_0:Play("anim_newinstagram_chat_right_in")

			return
		end, SFX_PANEL)
	else
		SetActive(var_9_1:Find("officialAccounts/tip"), getProxy(InstagramProxy):ShouldShowOfficialAccountsTip())
		onButton(self, var_9_1, function()
			SetActive(self.rightPanel, true)
			SetActive(self._tf:Find("main/rightNoMessageBg"), false)

			for iter_12_0 = 0, self.charaScrollContent.childCount - 1 do
				SetActive(self.charaScrollContent:GetChild(iter_12_0):Find("frame"), false)
			end

			SetActive(var_9_1:Find("frame"), true)

			function self.cancelFrame()
				if not IsNil(var_9_1) then
					SetActive(var_9_1:Find("frame"), false)
				end

				return
			end

			self.currentChat = var_9_0

			self:UpdateOfficialAccounts(var_9_0)

			local var_12_0 = self.rightPanel:GetComponent(typeof(Animation))

			var_12_0:Stop()
			var_12_0:Play("anim_newinstagram_chat_right_in")

			return
		end, SFX_PANEL)
	end

	if self.currentChat then
		SetActive(var_9_1:Find("frame"), self.currentChat == var_9_0)
	end

	return
end

function InstagramChatLayer:UpdateCharaList(arg_14_1, arg_14_2)
	if not self.chatList or #self.chatList == 0 then
		SetActive(self.leftPanel, false)
		SetActive(self.rightPanel, false)
		SetActive(self._tf:Find("main/noMessageBg"), true)
		SetActive(self._tf:Find("main/noFilteredMessageBg"), false)
		SetActive(self._tf:Find("main/rightNoMessageBg"), false)

		return
	end

	if not self.currentChat then
		SetActive(self.rightPanel, false)
		SetActive(self._tf:Find("main/rightNoMessageBg"), true)
	else
		SetActive(self.rightPanel, true)
		SetActive(self._tf:Find("main/rightNoMessageBg"), false)
	end

	self.isSlowMsg = arg_14_1

	self:SetFilterResult()

	if self.currentChat then
		if self.currentChat.chatType == InstagramConst.INSTAGRAM_CHAT_TYPE.OFFICIAL_ACCOUNT then
			self:UpdateOfficialAccounts(self.currentChat)
		else
			self:UpdateChatContent(self.currentChat, arg_14_1, arg_14_2)
			self:SetTopicPanel(self.currentChat)
		end
	end

	return
end

function InstagramChatLayer:UpdateChatContent(arg_15_1, arg_15_2, arg_15_3)
	setActive(self.rightChatPanel, true)
	setActive(self.rightOfficialAccountsPanel, false)
	SetActive(self.rightPanel, true)
	setText(self.characterName, arg_15_1.name)
	SetActive(self.careBtn:Find("care"), arg_15_1.care == 1)
	onButton(self, self.careBtn, function()
		self:emit(InstagramChatMediator.CHANGE_CARE, arg_15_1.characterId, arg_15_1.care == 0 and 1 or 0)

		self.careAniTriggerId = arg_15_1.characterId

		return
	end, SFX_PANEL)

	local var_15_0 = self.rightPanel:Find("chat/paintingMask")
	local var_15_1 = var_15_0:Find("painting")
	local var_15_2 = self.rightPanel:Find("chat/groupBackground")

	if arg_15_1.type == 1 then
		SetActive(var_15_0, true)
		SetActive(var_15_2, false)

		local var_15_3 = "unknown"

		if arg_15_1.skinId == 0 then
			var_15_3 = arg_15_1:GetPainting()
		else
			for iter_15_0, iter_15_1 in ipairs(arg_15_1.skins) do
				if iter_15_1.id == arg_15_1.skinId then
					var_15_3 = iter_15_1.painting
				end
			end
		end

		if not self.paintingName then
			setPaintingPrefabAsync(var_15_1, var_15_3, "pifu")

			self.paintingName = var_15_3
		elseif self.paintingName and self.paintingName ~= var_15_3 then
			retPaintingPrefab(var_15_1, self.paintingName)
			setPaintingPrefabAsync(var_15_1, var_15_3, "pifu")

			self.paintingName = var_15_3
		end
	else
		SetActive(var_15_0, false)
		SetActive(var_15_2, true)

		if self.paintingName then
			retPaintingPrefab(var_15_1, self.paintingName)

			self.paintingName = nil
		end

		setImageSprite(var_15_2, LoadSprite("ui/InstagramChatBackgrounds_atlas", arg_15_1.groupBackground), true)
	end

	local var_15_4 = arg_15_1.currentTopic:GetDisplayWordList()

	if not arg_15_3 then
		self:UpdateOptionPanel(arg_15_1.currentTopic, var_15_4)
		self:UpdateMessageList(arg_15_1.currentTopic, var_15_4, arg_15_2, arg_15_1.characterId, arg_15_1.type)
	end

	if not arg_15_2 and arg_15_1.currentTopic.readFlag == 0 then
		self:emit(InstagramChatMediator.SET_READED, {
			arg_15_1.currentTopic.topicId
		})
	end

	return
end

function InstagramChatLayer:UpdateMessageList(arg_17_1, arg_17_2, arg_17_3, arg_17_4, arg_17_5)
	self:RemoveAllTimer()

	local var_17_0

	for iter_17_0 = #arg_17_2, 1, -1 do
		if arg_17_2[iter_17_0].ship_group == 0 or arg_17_2[iter_17_0].type == 3 and arg_17_1:RedPacketGotFlag(tonumber(arg_17_2[iter_17_0].param)) then
			var_17_0 = iter_17_0

			break
		end
	end

	local var_17_1 = {}

	if var_17_0 then
		for iter_17_1 = var_17_0, 1, -1 do
			if arg_17_2[iter_17_1].ship_group == 0 then
				table.insert(var_17_1, iter_17_1)
			else
				break
			end
		end
	end

	if self.shouldShowOption and arg_17_3 then
		self:SetOptionPanelActive(false)
	end

	if arg_17_3 then
		onButton(self, self.rightPanel:Find("chat/messageScroll"), function()
			self:SpeedUpMessage()

			return
		end, SFX_PANEL)
	end

	local var_17_2 = GetComponent(self.rightPanel:Find("chat/messageScroll"), typeof(ScrollRect))

	local function var_17_3(arg_19_0)
		var_17_2.normalizedPosition = Vector2(0, arg_19_0)

		return
	end

	local var_17_4 = pg.gameset.juuschat_dialogue_trigger_time.key_value / 1000
	local var_17_5 = pg.gameset.juuschat_entering_time.key_value / 1000
	local var_17_6 = pg.gameset.juuschat_dialogue_trigger_time.key_value / 1000 - pg.gameset.juuschat_entering_time.key_value / 1000

	self.messageList:make(function(arg_20_0, arg_20_1, arg_20_2)
		if arg_20_0 == UIItemList.EventUpdate then
			local var_20_0 = arg_17_2[arg_20_1 + 1]

			if arg_17_2[arg_20_1 + 1].ship_group == 0 and var_20_0.type == 0 then
				SetActive(arg_20_2, false)

				return
			end

			local var_20_1 = arg_20_2:Find("charaMessageCard")
			local var_20_2 = arg_20_2:Find("playerReplyCard")

			SetActive(var_20_1, var_20_0.ship_group ~= 0)
			SetActive(var_20_2, var_20_0.ship_group == 0)

			if var_20_0.ship_group ~= 0 and arg_17_5 == 2 and var_20_0.type ~= 5 then
				SetActive(arg_20_2:Find("nameBar"), true)
				setText(arg_20_2:Find("nameBar/Text"), var_0_1[var_20_0.ship_group].name)
			else
				SetActive(arg_20_2:Find("nameBar"), false)
			end

			local var_20_3

			if arg_17_3 and var_17_0 and arg_20_1 + 1 > var_17_0 then
				var_20_3 = (arg_20_1 + 1 - var_17_0) * var_17_4 - var_17_5

				if #var_17_1 > 1 then
					var_20_3 = var_20_3 + (#var_17_1 - 1) * var_17_6
				end
			end

			if var_20_0.ship_group ~= 0 then
				local var_20_4 = "unknown"

				if var_0_1[var_20_0.ship_group] then
					var_20_4 = var_20_0.ship_group == arg_17_4 and arg_17_1.isII and var_0_1[var_20_0.ship_group].sculpture_ii ~= "" and var_0_1[var_20_0.ship_group].sculpture_ii or var_0_1[var_20_0.ship_group].sculpture
				end

				if var_20_0.type ~= 5 then
					setImageSprite(arg_20_2:Find("charaMessageCard/charaBg/chara"), LoadSprite("qicon/" .. var_20_4), false)
				end

				if var_20_0.type == 1 then
					self:SetCharaMessageCardActive(var_20_1, {
						3
					})
					setText(arg_20_2:Find("charaMessageCard/msgBox/msg"), var_20_0.param)

					if arg_17_3 and var_17_0 and arg_20_1 + 1 > var_17_0 then
						SetActive(arg_20_2, false)
						self:StartTimer(function()
							SetActive(arg_20_2, true)
							arg_20_2:Find("charaMessageCard/charaBg"):GetComponent(typeof(Animation)):Play("anim_newinstagram_charabg")
							SetActive(arg_20_2:Find("charaMessageCard/waiting"), true)
							SetActive(arg_20_2:Find("charaMessageCard/msgBox"), false)
							Canvas.ForceUpdateCanvases()
							LeanTween.value(go(self.rightPanel:Find("chat/messageScroll")), var_17_2.normalizedPosition.y, 0, 0.5):setOnUpdate(System.Action_float(var_17_3)):setEase(LeanTweenType.easeInOutCubic)
							self:StartTimer(function()
								SetActive(arg_20_2:Find("charaMessageCard/waiting"), false)
								SetActive(arg_20_2:Find("charaMessageCard/msgBox"), true)
								arg_20_2:Find("charaMessageCard/msgBox"):GetComponent(typeof(Animation)):Play("anim_newinstagram_chat_common_in")

								if arg_20_1 + 1 ~= #arg_17_2 then
									self:ChangeCharaTextFunc(arg_17_4, var_20_0.param)
								else
									self:emit(InstagramChatMediator.SET_READED, {
										arg_17_1.topicId
									})
								end

								Canvas.ForceUpdateCanvases()
								LeanTween.value(go(self.rightPanel:Find("chat/messageScroll")), var_17_2.normalizedPosition.y, 0, 0.5):setOnUpdate(System.Action_float(var_17_3)):setEase(LeanTweenType.easeInOutCubic)
								self:SetEndAniEvent(arg_20_2:Find("charaMessageCard/msgBox"), function()
									if self.shouldShowOption and arg_20_1 + 1 == #arg_17_2 then
										self:SetOptionPanelActive(true)
									end

									return
								end)

								return
							end, var_17_5)

							return
						end, var_20_3)
					end
				elseif var_20_0.type == 2 then
					self:SetCharaMessageCardActive(var_20_1, {
						2,
						7
					})
					pg.CriMgr.GetInstance():GetCueInfo("cv-" .. var_20_0.ship_group, var_20_0.param[1], function(arg_24_0)
						setText(arg_20_2:Find("charaMessageCard/voiceBox/time"), tostring(math.ceil(tonumber(tostring(arg_24_0.length)) / 1000)) .. "\"")

						return
					end)
					onButton(self, arg_20_2:Find("charaMessageCard/voiceBox"), function()
						pg.CriMgr.GetInstance():PlaySoundEffect_V3("event:/cv/" .. var_20_0.ship_group .. "/" .. var_20_0.param[1])

						return
					end, SFX_PANEL)
					setText(arg_20_2:Find("charaMessageCard/voiceMsgBox/voiceMsg/msg"), var_20_0.param[2])

					if arg_17_3 and var_17_0 and arg_20_1 + 1 > var_17_0 then
						SetActive(arg_20_2, false)
						self:StartTimer(function()
							SetActive(arg_20_2, true)
							arg_20_2:Find("charaMessageCard/charaBg"):GetComponent(typeof(Animation)):Play("anim_newinstagram_charabg")
							SetActive(arg_20_2:Find("charaMessageCard/waiting"), true)
							SetActive(arg_20_2:Find("charaMessageCard/voiceBox"), false)
							SetActive(arg_20_2:Find("charaMessageCard/voiceMsgBox"), false)
							Canvas.ForceUpdateCanvases()
							LeanTween.value(go(self.rightPanel:Find("chat/messageScroll")), var_17_2.normalizedPosition.y, 0, 0.5):setOnUpdate(System.Action_float(var_17_3)):setEase(LeanTweenType.easeInOutCubic)
							self:StartTimer(function()
								SetActive(arg_20_2:Find("charaMessageCard/waiting"), false)
								SetActive(arg_20_2:Find("charaMessageCard/voiceBox"), true)
								SetActive(arg_20_2:Find("charaMessageCard/voiceMsgBox"), true)
								arg_20_2:Find("charaMessageCard/voiceBox"):GetComponent(typeof(Animation)):Play("anim_newinstagram_chat_common_in")
								arg_20_2:Find("charaMessageCard/voiceMsgBox"):GetComponent(typeof(Animation)):Play("anim_newinstagram_voicetip_in")

								if arg_20_1 + 1 ~= #arg_17_2 then
									self:ChangeCharaTextFunc(arg_17_4, "<color=#ff6666>" .. i18n("juuschat_chattip1") .. "</color>")
								else
									self:emit(InstagramChatMediator.SET_READED, {
										arg_17_1.topicId
									})
								end

								Canvas.ForceUpdateCanvases()
								LeanTween.value(go(self.rightPanel:Find("chat/messageScroll")), var_17_2.normalizedPosition.y, 0, 0.5):setOnUpdate(System.Action_float(var_17_3)):setEase(LeanTweenType.easeInOutCubic)
								self:SetEndAniEvent(arg_20_2:Find("charaMessageCard/voiceBox"), function()
									if self.shouldShowOption and arg_20_1 + 1 == #arg_17_2 then
										self:SetOptionPanelActive(true)
									end

									return
								end)

								return
							end, var_17_5)

							return
						end, var_20_3)
					end
				elseif var_20_0.type == 3 then
					self:SetCharaMessageCardActive(var_20_1, {
						5
					})

					local var_20_5 = var_0_2[tonumber(var_20_0.param)]

					setText(arg_20_2:Find("charaMessageCard/redPacket/desc"), var_20_5.desc)

					local var_20_6 = arg_17_1:RedPacketGotFlag(var_20_5.id)

					SetActive(arg_20_2:Find("charaMessageCard/redPacket/got"), var_20_6)
					self:SetRedPacketPanel(arg_20_2:Find("charaMessageCard/redPacket"), var_20_5, var_20_6, var_20_4, arg_17_1.topicId, var_20_0.id)

					if arg_17_3 and var_17_0 and arg_20_1 + 1 == var_17_0 then
						self:ChangeCharaTextFunc(arg_17_4, "<color=#ff6666>" .. i18n("juuschat_chattip2") .. "</color>" .. pg.activity_ins_redpackage[tonumber(var_20_0.param)].desc)
					end

					if arg_17_3 and var_17_0 and arg_20_1 + 1 > var_17_0 then
						SetActive(arg_20_2, false)
						self:StartTimer(function()
							SetActive(arg_20_2, true)
							arg_20_2:Find("charaMessageCard/charaBg"):GetComponent(typeof(Animation)):Play("anim_newinstagram_charabg")
							SetActive(arg_20_2:Find("charaMessageCard/waiting"), true)
							SetActive(arg_20_2:Find("charaMessageCard/redPacket"), false)
							Canvas.ForceUpdateCanvases()
							LeanTween.value(go(self.rightPanel:Find("chat/messageScroll")), var_17_2.normalizedPosition.y, 0, 0.5):setOnUpdate(System.Action_float(var_17_3)):setEase(LeanTweenType.easeInOutCubic)
							self:StartTimer(function()
								SetActive(arg_20_2:Find("charaMessageCard/waiting"), false)
								SetActive(arg_20_2:Find("charaMessageCard/redPacket"), true)
								arg_20_2:Find("charaMessageCard/redPacket"):GetComponent(typeof(Animation)):Play("anim_newinstagram_redpacket_in")

								if arg_20_1 + 1 ~= #arg_17_2 then
									self:ChangeCharaTextFunc(arg_17_4, "<color=#ff6666>" .. i18n("juuschat_chattip2") .. "</color>" .. pg.activity_ins_redpackage[tonumber(var_20_0.param)].desc)
								else
									self:emit(InstagramChatMediator.SET_READED, {
										arg_17_1.topicId
									})
								end

								Canvas.ForceUpdateCanvases()
								LeanTween.value(go(self.rightPanel:Find("chat/messageScroll")), var_17_2.normalizedPosition.y, 0, 0.5):setOnUpdate(System.Action_float(var_17_3)):setEase(LeanTweenType.easeInOutCubic)
								self:SetEndAniEvent(arg_20_2:Find("charaMessageCard/redPacket"), function()
									if self.shouldShowOption and arg_20_1 + 1 == #arg_17_2 then
										self:SetOptionPanelActive(true)
									end

									return
								end)

								return
							end, var_17_5)

							return
						end, var_20_3)
					end
				elseif var_20_0.type == 4 then
					self:SetCharaMessageCardActive(var_20_1, {
						4
					})
					self:ClearEmoji(arg_20_2:Find("charaMessageCard/emoji/emoticon"))
					self:SetEmoji(arg_20_2:Find("charaMessageCard/emoji/emoticon"), var_0_3[tonumber(var_20_0.param)].pic)

					if arg_17_3 and var_17_0 and arg_20_1 + 1 > var_17_0 then
						SetActive(arg_20_2, false)
						self:StartTimer(function()
							SetActive(arg_20_2, true)
							arg_20_2:Find("charaMessageCard/charaBg"):GetComponent(typeof(Animation)):Play("anim_newinstagram_charabg")
							SetActive(arg_20_2:Find("charaMessageCard/waiting"), true)
							SetActive(arg_20_2:Find("charaMessageCard/emoji"), false)
							Canvas.ForceUpdateCanvases()
							LeanTween.value(go(self.rightPanel:Find("chat/messageScroll")), var_17_2.normalizedPosition.y, 0, 0.5):setOnUpdate(System.Action_float(var_17_3)):setEase(LeanTweenType.easeInOutCubic)
							self:StartTimer(function()
								SetActive(arg_20_2:Find("charaMessageCard/waiting"), false)
								SetActive(arg_20_2:Find("charaMessageCard/emoji"), true)
								arg_20_2:Find("charaMessageCard/emoji"):GetComponent(typeof(Animation)):Play("anim_newinstagram_emoji_in")

								if arg_20_1 + 1 ~= #arg_17_2 then
									self:ChangeCharaTextFunc(arg_17_4, (string.gsub(var_0_3[tonumber(var_20_0.param)].desc, "#%w+>", "#28af6e>")))
								else
									self:emit(InstagramChatMediator.SET_READED, {
										arg_17_1.topicId
									})
								end

								Canvas.ForceUpdateCanvases()
								LeanTween.value(go(self.rightPanel:Find("chat/messageScroll")), var_17_2.normalizedPosition.y, 0, 0.5):setOnUpdate(System.Action_float(var_17_3)):setEase(LeanTweenType.easeInOutCubic)
								self:SetEndAniEvent(arg_20_2:Find("charaMessageCard/emoji"), function()
									if self.shouldShowOption and arg_20_1 + 1 == #arg_17_2 then
										self:SetOptionPanelActive(true)
									end

									return
								end)

								return
							end, var_17_5)

							return
						end, var_20_3)
					end
				elseif var_20_0.type == 5 then
					self:SetCharaMessageCardActive(var_20_1, {
						6
					})

					local var_20_7 = var_20_0.param

					for iter_20_0 in string.gmatch(var_20_0.param, "'%d+'") do
						var_20_7 = string.gsub(var_20_7, iter_20_0, "<color=#93e9ff>" .. var_0_1[tonumber((string.sub(iter_20_0, 2, #iter_20_0 - 1)))].name .. "</color>")
					end

					setText(arg_20_2:Find("charaMessageCard/systemTip/panel/Text"), var_20_7)

					if arg_17_3 and var_17_0 and arg_20_1 + 1 > var_17_0 then
						SetActive(arg_20_2, false)
						self:StartTimer(function()
							SetActive(arg_20_2, true)
							arg_20_2:Find("charaMessageCard/systemTip"):GetComponent(typeof(Animation)):Play("anim_newinstagram_tip_in")

							if arg_20_1 + 1 ~= #arg_17_2 then
								self:ChangeCharaTextFunc(arg_17_4, var_20_7)
							else
								self:emit(InstagramChatMediator.SET_READED, {
									arg_17_1.topicId
								})
							end

							Canvas.ForceUpdateCanvases()
							LeanTween.value(go(self.rightPanel:Find("chat/messageScroll")), var_17_2.normalizedPosition.y, 0, 0.5):setOnUpdate(System.Action_float(var_17_3)):setEase(LeanTweenType.easeInOutCubic)
							self:SetEndAniEvent(arg_20_2:Find("charaMessageCard/systemTip"), function()
								if self.shouldShowOption and arg_20_1 + 1 == #arg_17_2 then
									self:SetOptionPanelActive(true)
								end

								return
							end)

							return
						end, var_20_3)
					end
				end
			else
				if var_20_0.type == 1 then
					self:SetPlayerMessageCardActive(var_20_2, {
						0
					})
					setText(arg_20_2:Find("playerReplyCard/msgBox/msg"), var_20_0.param)
				elseif var_20_0.type == 4 then
					self:SetPlayerMessageCardActive(var_20_2, {
						1
					})
					self:ClearEmoji(arg_20_2:Find("playerReplyCard/emoji/emoticon"))
					self:SetEmoji(arg_20_2:Find("playerReplyCard/emoji/emoticon"), var_0_3[tonumber(var_20_0.param)].pic)
				elseif var_20_0.type == 5 then
					self:SetPlayerMessageCardActive(var_20_2, {
						2
					})

					local var_20_8 = var_20_0.param

					for iter_20_1 in string.gmatch(var_20_0.param, "'%d+'") do
						var_20_8 = string.gsub(var_20_8, iter_20_1, "<color=#93e9ff>" .. var_0_1[tonumber((string.sub(iter_20_1, 2, #iter_20_1 - 1)))].name .. "</color>")
					end

					setText(arg_20_2:Find("playerReplyCard/systemTip/panel/Text"), var_20_8)
				end

				if arg_17_3 and var_17_0 and _.contains(var_17_1, arg_20_1 + 1) then
					if table.indexof(var_17_1, arg_20_1 + 1) < #var_17_1 then
						SetActive(arg_20_2, false)
						self:StartTimer(function()
							SetActive(arg_20_2, true)

							if var_20_0.type == 1 then
								arg_20_2:Find("playerReplyCard/msgBox"):GetComponent(typeof(Animation)):Play("anim_newinstagram_playerchat_common_in")
								self:ChangeCharaTextFunc(arg_17_4, var_20_0.param)
							elseif var_20_0.type == 4 then
								arg_20_2:Find("playerReplyCard/emoji"):GetComponent(typeof(Animation)):Play("anim_newinstagram_emoji_in")
								self:ChangeCharaTextFunc(arg_17_4, (string.gsub(var_0_3[tonumber(var_20_0.param)].desc, "#%w+>", "#28af6e>")))
							elseif var_20_0.type == 5 then
								arg_20_2:Find("playerReplyCard/systemTip"):GetComponent(typeof(Animation)):Play("anim_newinstagram_tip_in")

								local var_37_0 = var_20_0.param

								for iter_37_0 in string.gmatch(var_20_0.param, "'%d+'") do
									var_37_0 = string.gsub(var_37_0, iter_37_0, "<color=#93e9ff>" .. var_0_1[tonumber((string.sub(iter_37_0, 2, #iter_37_0 - 1)))].name .. "</color>")
								end

								self:ChangeCharaTextFunc(arg_17_4, var_37_0)
							end

							if arg_20_1 + 1 == #arg_17_2 then
								self:emit(InstagramChatMediator.SET_READED, {
									arg_17_1.topicId
								})
							end

							Canvas.ForceUpdateCanvases()
							LeanTween.value(go(self.rightPanel:Find("chat/messageScroll")), var_17_2.normalizedPosition.y, 0, 0.5):setOnUpdate(System.Action_float(var_17_3)):setEase(LeanTweenType.easeInOutCubic)

							return
						end, (#var_17_1 - table.indexof(var_17_1, arg_20_1 + 1)) * var_17_6)
					else
						if var_20_0.type == 1 then
							arg_20_2:Find("playerReplyCard/msgBox"):GetComponent(typeof(Animation)):Play("anim_newinstagram_playerchat_common_in")
							self:ChangeCharaTextFunc(arg_17_4, var_20_0.param)
						elseif var_20_0.type == 4 then
							arg_20_2:Find("playerReplyCard/emoji"):GetComponent(typeof(Animation)):Play("anim_newinstagram_emoji_in")
							self:ChangeCharaTextFunc(arg_17_4, (string.gsub(var_0_3[tonumber(var_20_0.param)].desc, "#%w+>", "#28af6e>")))
						elseif var_20_0.type == 5 then
							arg_20_2:Find("playerReplyCard/systemTip"):GetComponent(typeof(Animation)):Play("anim_newinstagram_tip_in")

							local var_20_9 = var_20_0.param

							for iter_20_2 in string.gmatch(var_20_0.param, "'%d+'") do
								var_20_9 = string.gsub(var_20_9, iter_20_2, "<color=#93e9ff>" .. var_0_1[tonumber((string.sub(iter_20_2, 2, #iter_20_2 - 1)))].name .. "</color>")
							end

							self:ChangeCharaTextFunc(arg_17_4, var_20_9)
						end

						if arg_20_1 + 1 == #arg_17_2 then
							self:emit(InstagramChatMediator.SET_READED, {
								arg_17_1.topicId
							})
						end
					end
				end
			end

			if not arg_17_1:isWaiting() and arg_20_1 + 1 == #arg_17_2 then
				if arg_17_3 then
					if var_20_0.ship_group ~= 0 then
						self:StartTimer(function()
							setActive(arg_20_2:Find("end"), true)

							return
						end, var_20_3 + var_17_4)
					else
						self:StartTimer(function()
							setActive(arg_20_2:Find("end"), true)

							return
						end, (#var_17_1 - table.indexof(var_17_1, arg_20_1 + 1)) * var_17_6 + var_17_6)
					end
				else
					setActive(arg_20_2:Find("end"), true)
				end
			else
				setActive(arg_20_2:Find("end"), false)
			end
		end

		return
	end)
	self.messageList:align(#arg_17_2)

	if arg_17_3 then
		Canvas.ForceUpdateCanvases()
		LeanTween.value(go(self.rightPanel:Find("chat/messageScroll")), var_17_2.normalizedPosition.y, 0, 0.5):setOnUpdate(System.Action_float(var_17_3)):setEase(LeanTweenType.easeInOutCubic)
	else
		scrollToBottom(self.rightPanel:Find("chat/messageScroll"))
	end

	return
end

function InstagramChatLayer:SetCharaMessageCardActive(arg_40_1, arg_40_2)
	if _.contains(arg_40_2, 6) then
		SetActive(arg_40_1:GetChild(0), false)
	else
		SetActive(arg_40_1:GetChild(0), true)
	end

	for iter_40_0 = 1, arg_40_1.childCount - 1 do
		if _.contains(arg_40_2, iter_40_0) then
			SetActive(arg_40_1:GetChild(iter_40_0), true)
		else
			SetActive(arg_40_1:GetChild(iter_40_0), false)
		end
	end

	return
end

function InstagramChatLayer:SetPlayerMessageCardActive(arg_41_1, arg_41_2)
	for iter_41_0 = 0, arg_41_1.childCount - 1 do
		if _.contains(arg_41_2, iter_41_0) then
			SetActive(arg_41_1:GetChild(iter_41_0), true)
		else
			SetActive(arg_41_1:GetChild(iter_41_0), false)
		end
	end

	return
end

function InstagramChatLayer:SetEmoji(arg_42_1, arg_42_2)
	PoolMgr.GetInstance():GetPrefab("emoji/" .. arg_42_2, arg_42_2, true, function(arg_43_0)
		if not IsNil(arg_42_1) then
			arg_43_0.name = arg_42_2
			tf(arg_43_0).sizeDelta = arg_42_1.sizeDelta
			tf(arg_43_0).anchoredPosition = Vector2.zero

			local var_43_0 = arg_43_0:GetComponent("Animator")

			if var_43_0 then
				var_43_0.enabled = true
			end

			setParent(arg_43_0, arg_42_1, false)
		else
			PoolMgr.GetInstance():ReturnPrefab("emoji/" .. arg_42_2, arg_42_2, arg_43_0)
		end

		return
	end)

	return
end

function InstagramChatLayer:ClearEmoji(arg_44_1)
	eachChild(arg_44_1, function(arg_45_0)
		local var_45_0 = go(arg_45_0)

		PoolMgr.GetInstance():ReturnPrefab("emoji/" .. var_45_0.name, var_45_0.name, var_45_0)

		return
	end)

	return
end

function InstagramChatLayer:UpdateOptionPanel(arg_46_1, arg_46_2)
	local var_46_0 = arg_46_2[#arg_46_2].option

	if arg_46_2[#arg_46_2].option and type(arg_46_2[#arg_46_2].option) == "table" then
		self.shouldShowOption = true
		self.optionCount = #arg_46_2[#arg_46_2].option

		self:SetOptionPanelActive(true)
		self.optionList:make(function(arg_47_0, arg_47_1, arg_47_2)
			if arg_47_0 == UIItemList.EventUpdate then
				local var_47_0 = var_46_0[arg_47_1 + 1]

				setText(arg_47_2:Find("Text"), HXSet.hxLan(var_46_0[arg_47_1 + 1][2]))
				onButton(self, arg_47_2, function()
					self:emit(InstagramChatMediator.REPLY, arg_46_1.topicId, arg_46_2[#arg_46_2].id, var_47_0[1])

					return
				end, SFX_PANEL)
			end

			return
		end)
		self.optionList:align(#arg_46_2[#arg_46_2].option)
	else
		self:SetOptionPanelActive(false)

		self.shouldShowOption = false
	end

	return
end

function InstagramChatLayer:SetOptionPanelActive(arg_49_1)
	SetActive(self.optionPanel, arg_49_1)

	local var_49_0 = self.rightPanel:Find("chat/messageScroll/Viewport/Content"):GetComponent(typeof(VerticalLayoutGroup))
	local var_49_1 = UnityEngine.RectOffset.New()

	var_49_1.left = 0
	var_49_1.right = 0
	var_49_1.top = 0

	local var_49_2 = self.rightPanel:Find("chat/messageScroll/Scrollbar Vertical"):GetComponent(typeof(RectTransform))

	if arg_49_1 then
		var_49_1.bottom = 42 + 88 * self.optionCount
		var_49_2.sizeDelta = Vector2(self.messageScrollWidth, -var_49_1.bottom)
	else
		var_49_1.bottom = 50
		var_49_2.sizeDelta = Vector2(self.messageScrollWidth, 0)
	end

	var_49_0.padding = var_49_1

	scrollToBottom(self.rightPanel:Find("chat/messageScroll"))

	return
end

function InstagramChatLayer:SetFilterPanel()
	self.readFilter = self.readFilter or InstagramChatLayer.ReadType[1]
	self.typeFilter = self.typeFilter or InstagramChatLayer.TypeType[1]
	self.campFilter = self.campFilter or {
		InstagramChatLayer.CampIds[1]
	}

	local var_50_0 = self.filterUI:Find("panel/filterScroll/Viewport/Content/read")
	local var_50_1 = self.filterUI:Find("panel/filterScroll/Viewport/Content/type")
	local var_50_2 = self.filterUI:Find("panel/filterScroll/Viewport/Content/camp")
	local var_50_3 = UIItemList.New(var_50_2, var_50_2:Find("option"))

	onButton(self, self.filterBtn, function()
		SetActive(self.filterUI, true)
		pg.UIMgr.GetInstance():BlurPanel(self.filterUI)

		for iter_51_0, iter_51_1 in ipairs(InstagramChatLayer.ReadType) do
			local var_51_0 = var_50_0:GetChild(iter_51_0)
			local var_51_1 = var_51_0:Find("selectedFrame")

			SetActive(var_51_1, self.readFilter == iter_51_1)
			onButton(self, var_51_0, function()
				for iter_52_0, iter_52_1 in ipairs(InstagramChatLayer.ReadType) do
					SetActive(var_50_0:GetChild(iter_52_0):Find("selectedFrame"), false)
				end

				SetActive(var_51_1, true)

				return
			end, SFX_PANEL)
		end

		for iter_51_2, iter_51_3 in ipairs(InstagramChatLayer.TypeType) do
			local var_51_2 = var_50_1:GetChild(iter_51_2)
			local var_51_3 = var_51_2:Find("selectedFrame")

			SetActive(var_51_3, self.typeFilter == iter_51_3)
			onButton(self, var_51_2, function()
				for iter_53_0, iter_53_1 in ipairs(InstagramChatLayer.TypeType) do
					SetActive(var_50_1:GetChild(iter_53_0):Find("selectedFrame"), false)
				end

				SetActive(var_51_3, true)

				return
			end, SFX_PANEL)
		end

		var_50_3:make(function(arg_54_0, arg_54_1, arg_54_2)
			if arg_54_0 == UIItemList.EventUpdate then
				setText(arg_54_2:Find("Text"), i18n(InstagramChatLayer.CampNames[arg_54_1 + 1]))

				local var_54_0 = arg_54_2:Find("selectedFrame")

				SetActive(var_54_0, _.contains(self.campFilter, InstagramChatLayer.CampIds[arg_54_1 + 1]))
				onButton(self, arg_54_2, function()
					if arg_54_1 == 0 then
						SetActive(var_54_0, true)

						for iter_55_0 = 2, #InstagramChatLayer.CampIds do
							SetActive(var_50_2:GetChild(iter_55_0 - 1):Find("selectedFrame"), false)
						end
					else
						SetActive(var_54_0, not isActive(var_54_0))

						local var_55_0 = true
						local var_55_1 = true

						for iter_55_1 = 2, #InstagramChatLayer.CampIds do
							local var_55_2

							if not isActive(var_50_2:GetChild(iter_55_1 - 1):Find("selectedFrame")) then
								var_55_0 = false
								var_55_2 = var_50_2:GetChild(iter_55_1 - 1)
							end

							if isActive(var_55_2:Find("selectedFrame")) then
								var_55_1 = false
							end
						end

						if var_55_0 then
							SetActive(var_50_2:GetChild(0):Find("selectedFrame"), true)

							for iter_55_2 = 2, #InstagramChatLayer.CampIds do
								SetActive(var_50_2:GetChild(iter_55_2 - 1):Find("selectedFrame"), false)
							end
						elseif var_55_1 then
							SetActive(var_50_2:GetChild(0):Find("selectedFrame"), true)
						else
							SetActive(var_50_2:GetChild(0):Find("selectedFrame"), false)
						end
					end

					return
				end, SFX_PANEL)
			end

			return
		end)
		var_50_3:align(#InstagramChatLayer.CampIds)

		return
	end, SFX_PANEL)
	onButton(self, self.filterUI:Find("bg"), function()
		self:CloseFilterPanel()

		return
	end, SFX_PANEL)
	onButton(self, self.filterUI:Find("panel/bottom/close"), function()
		self:CloseFilterPanel()

		return
	end, SFX_PANEL)
	onButton(self, self.filterUI:Find("panel/bottom/ok"), function()
		for iter_58_0, iter_58_1 in ipairs(InstagramChatLayer.ReadType) do
			if isActive((var_50_0:GetChild(iter_58_0):Find("selectedFrame"))) then
				self.readFilter = iter_58_1
			end
		end

		for iter_58_2, iter_58_3 in ipairs(InstagramChatLayer.TypeType) do
			if isActive((var_50_1:GetChild(iter_58_2):Find("selectedFrame"))) then
				self.typeFilter = iter_58_3
			end
		end

		self.campFilter = {}

		for iter_58_4, iter_58_5 in ipairs(InstagramChatLayer.CampIds) do
			if isActive((var_50_2:GetChild(iter_58_4 - 1):Find("selectedFrame"))) then
				table.insert(self.campFilter, iter_58_5)
			end
		end

		self:CloseFilterPanel()
		self:SetFilterResult()

		return
	end, SFX_PANEL)

	return
end

function InstagramChatLayer:SetFilterResult()
	local var_59_0 = true
	local var_59_1 = false

	if not self.readFilter then
		self.readFilter = InstagramChatLayer.ReadType[1]
		self.typeFilter = InstagramChatLayer.TypeType[1]
		self.campFilter = {
			InstagramChatLayer.CampIds[1]
		}
	end

	self.chatList = table.insertto({}, self.allChatList)

	for iter_59_0 = #self.chatList, 1, -1 do
		local var_59_2 = self.chatList[iter_59_0]
		local var_59_3 = not (self.readFilter ~= "all" and var_59_2:GetCharacterEndFlag() ~= (self.readFilter == "hasReaded" and 1 or 0))

		if self.typeFilter ~= "all" and var_59_2.type ~= (self.typeFilter == "single" and 1 or 2) then
			var_59_3 = false
		end

		if not _.contains(self.campFilter, 0) and not _.contains(self.campFilter, var_59_2.nationality) then
			var_59_3 = false
		end

		if not var_59_3 then
			table.remove(self.chatList, iter_59_0)
		end

		if var_59_3 then
			var_59_0 = false
		end

		if self.currentChat and self.currentChat.characterId == var_59_2.characterId and var_59_3 then
			var_59_1 = true
		end
	end

	local var_59_4 = self.readFilter == "all" and self.typeFilter == "all" and _.contains(self.campFilter, 0)

	SetActive(self.isFiltered, not var_59_4)

	if var_59_4 then
		self:InsertOfficialAccounts()
	end

	if var_59_0 then
		SetActive(self.leftPanel:Find("charaScroll"), false)
		SetActive(self._tf:Find("main/noFilteredMessageBg"), true)
		SetActive(self.rightPanel, false)
		SetActive(self._tf:Find("main/rightNoMessageBg"), false)
	else
		SetActive(self.leftPanel:Find("charaScroll"), true)
		self.charaScrollrect:SetTotalCount(#self.chatList)
		SetActive(self._tf:Find("main/noFilteredMessageBg"), false)

		if var_59_1 then
			SetActive(self.rightPanel, true)
			SetActive(self._tf:Find("main/rightNoMessageBg"), false)
		else
			SetActive(self.rightPanel, false)
			SetActive(self._tf:Find("main/rightNoMessageBg"), true)

			self.currentChat = nil

			if self.cancelFrame then
				self.cancelFrame()

				self.cancelFrame = nil
			end
		end
	end

	return
end

function InstagramChatLayer:CloseFilterPanel()
	pg.UIMgr.GetInstance():UnOverlayPanel(self.filterUI, self._tf:Find("subPages"))
	SetActive(self.filterUI, false)

	return
end

function InstagramChatLayer:SetTopicPanel(arg_61_1)
	SetActive(self.topicBtn:Find("tip"), arg_61_1:GetCharacterEndFlagExceptCurrent() == 0)
	onButton(self, self.topicBtn, function()
		SetActive(self.topicUI, true)
		pg.UIMgr.GetInstance():BlurPanel(self.topicUI)

		self.currentTopic = nil

		arg_61_1:SortTopicList()

		local var_62_0 = {}
		local var_62_1 = {}

		for iter_62_0, iter_62_1 in ipairs(arg_61_1.topics) do
			if iter_62_1.active then
				if iter_62_1.isII then
					table.insert(var_62_1, iter_62_1)
				else
					table.insert(var_62_0, iter_62_1)
				end
			end
		end

		setActive(self.topicUI:Find("panel/topicScroll/Viewport/Content/self"), #var_62_0 > 0)
		setActive(self.topicUI:Find("panel/topicScroll/Viewport/Content/other"), #var_62_1 > 0)
		setActive(self.topicUI:Find("panel/topicScroll/Viewport/Content/line"), #var_62_0 > 0 and #var_62_1 > 0)

		if #var_62_0 > 0 then
			local var_62_2 = UIItemList.New(self.topicUI:Find("panel/topicScroll/Viewport/Content/self"), self.topicUI:Find("panel/topicScroll/Viewport/Content/self/topic"))

			var_62_2:make(function(arg_63_0, arg_63_1, arg_63_2)
				if arg_63_0 == UIItemList.EventUpdate then
					self:SetTopic(arg_63_2, arg_61_1, var_62_0[arg_63_1 + 1], var_62_0, var_62_1)
				end

				return
			end)
			var_62_2:align(#var_62_0)
		end

		if #var_62_1 > 0 then
			local var_62_3 = UIItemList.New(self.topicUI:Find("panel/topicScroll/Viewport/Content/other"), self.topicUI:Find("panel/topicScroll/Viewport/Content/other/topic"))

			var_62_3:make(function(arg_64_0, arg_64_1, arg_64_2)
				if arg_64_0 == UIItemList.EventUpdate then
					self:SetTopic(arg_64_2, arg_61_1, var_62_1[arg_64_1 + 1], var_62_0, var_62_1)
				end

				return
			end)
			var_62_3:align(#var_62_1)
		end

		return
	end, SFX_PANEL)
	onButton(self, self.topicUI:Find("bg"), function()
		self:CloseTopicPanel()

		return
	end, SFX_PANEL)
	onButton(self, self.topicUI:Find("panel/bottom/close"), function()
		self:CloseTopicPanel()

		return
	end, SFX_PANEL)
	onButton(self, self.topicUI:Find("panel/bottom/ok"), function()
		self:emit(InstagramChatMediator.SET_CURRENT_TOPIC, self.currentTopic.topicId)
		self:CloseTopicPanel()

		local var_67_0 = self.rightPanel:GetComponent(typeof(Animation))

		var_67_0:Stop()
		var_67_0:Play("anim_newinstagram_chat_right_in")

		return
	end, SFX_PANEL)

	return
end

function InstagramChatLayer:SetTopic(arg_68_1, arg_68_2, arg_68_3, arg_68_4, arg_68_5)
	setScrollText(arg_68_1:Find("mask/name"), HXSet.hxLan(arg_68_3.name))
	SetActive(arg_68_1:Find("lock"), not arg_68_3.active)
	SetActive(arg_68_1:Find("waiting"), arg_68_3.active and arg_68_3:isWaiting())
	SetActive(arg_68_1:Find("complete"), arg_68_3.active and arg_68_3:IsCompleted())
	SetActive(arg_68_1:Find("selectedFrame"), arg_68_2.currentTopicId == arg_68_3.topicId)
	SetActive(arg_68_1:Find("selected"), arg_68_2.currentTopicId == arg_68_3.topicId)
	SetActive(arg_68_1:Find("tip"), arg_68_3.active and not arg_68_3:IsCompleted())

	if arg_68_2.currentTopicId == arg_68_3.topicId then
		self.currentTopic = arg_68_3
	end

	SetActive(arg_68_1, arg_68_3.active)

	if arg_68_3.active then
		onButton(self, arg_68_1, function()
			for iter_69_0 = 1, #arg_68_4 do
				SetActive(self.topicUI:Find("panel/topicScroll/Viewport/Content/self"):GetChild(iter_69_0 - 1):Find("selectedFrame"), false)
			end

			for iter_69_1 = 1, #arg_68_5 do
				SetActive(self.topicUI:Find("panel/topicScroll/Viewport/Content/other"):GetChild(iter_69_1 - 1):Find("selectedFrame"), false)
			end

			SetActive(arg_68_1:Find("selectedFrame"), true)

			self.currentTopic = arg_68_3

			return
		end, SFX_PANEL)
	else
		onButton(self, arg_68_1, function()
			pg.TipsMgr.GetInstance():ShowTips(arg_68_3.unlockDesc)

			return
		end, SFX_PANEL)
	end

	return
end

function InstagramChatLayer:CloseTopicPanel()
	pg.UIMgr.GetInstance():UnOverlayPanel(self.topicUI, self._tf:Find("subPages"))
	SetActive(self.topicUI, false)

	return
end

function InstagramChatLayer:SetBackgroundPanel(arg_72_1)
	if arg_72_1.type == 2 then
		SetActive(self.backgroundBtn, false)

		return
	end

	SetActive(self.backgroundBtn, true)
	onButton(self, self.backgroundBtn, function()
		SetActive(self.backgroundUI, true)
		pg.UIMgr.GetInstance():BlurPanel(self.backgroundUI)

		self.currentBgId = nil

		local var_73_0 = arg_72_1:GetSkins()
		local var_73_1 = UIItemList.New(self.backgroundUI:Find("panel/backgroundScroll/Viewport/Content"), self.backgroundUI:Find("panel/backgroundScroll/Viewport/Content/background"))

		var_73_1:make(function(arg_74_0, arg_74_1, arg_74_2)
			if arg_74_0 == UIItemList.EventUpdate then
				local var_74_0 = var_73_0[arg_74_1 + 1].id

				LoadImageSpriteAsync("herohrzicon/" .. var_73_0[arg_74_1 + 1].painting, arg_74_2:Find("skinMask/skin"), false)
				setScrollText(arg_74_2:Find("skinMask/Panel/mask/Text"), var_73_0[arg_74_1 + 1].name)

				local var_74_1 = getProxy(ShipSkinProxy):hasSkin(var_73_0[arg_74_1 + 1].id)

				var_74_1 = var_74_1 or var_73_0[arg_74_1 + 1].skin_type == ShipSkin.SKIN_TYPE_DEFAULT or var_73_0[arg_74_1 + 1].skin_type == ShipSkin.SKIN_TYPE_PROPOSE or var_73_0[arg_74_1 + 1].skin_type == ShipSkin.SKIN_TYPE_REMAKE

				SetActive(arg_74_2:Find("lockFrame"), not var_74_1)

				if arg_72_1.skinId ~= 0 then
					SetActive(arg_74_2:Find("selectedFrame"), arg_72_1.skinId == var_74_0)
					SetActive(arg_74_2:Find("selected"), arg_72_1.skinId == var_74_0)

					if arg_72_1.skinId == var_74_0 then
						self.currentBgId = var_74_0
					end
				else
					local var_74_2 = arg_72_1:GetPaintingId()

					SetActive(arg_74_2:Find("selectedFrame"), var_74_2 == var_74_0)
					SetActive(arg_74_2:Find("selected"), var_74_2 == var_74_0)

					if var_74_2 == var_74_0 then
						self.currentBgId = var_74_0
					end
				end

				onButton(self, arg_74_2, function()
					if var_74_1 then
						SetActive(arg_74_2:Find("selectedFrame"), true)

						for iter_75_0 = 1, #var_73_0 do
							if iter_75_0 ~= arg_74_1 + 1 then
								SetActive(self.backgroundUI:Find("panel/backgroundScroll/Viewport/Content"):GetChild(iter_75_0 - 1):Find("selectedFrame"), false)
							end
						end

						self.currentBgId = var_74_0
					else
						pg.TipsMgr.GetInstance():ShowTips(i18n("juuschat_background_tip2"))
					end

					return
				end, SFX_PANEL)
			end

			return
		end)
		var_73_1:align(#var_73_0)

		return
	end, SFX_PANEL)
	onButton(self, self.backgroundUI:Find("bg"), function()
		self:CloseBackgroundPanel()

		return
	end, SFX_PANEL)
	onButton(self, self.backgroundUI:Find("panel/bottom/close"), function()
		self:CloseBackgroundPanel()

		return
	end, SFX_PANEL)
	onButton(self, self.backgroundUI:Find("panel/bottom/ok"), function()
		self:emit(InstagramChatMediator.SET_CURRENT_BACKGROUND, arg_72_1.characterId, self.currentBgId)
		self:CloseBackgroundPanel()

		return
	end, SFX_PANEL)

	return
end

function InstagramChatLayer:CloseBackgroundPanel()
	pg.UIMgr.GetInstance():UnOverlayPanel(self.backgroundUI, self._tf:Find("subPages"))
	SetActive(self.backgroundUI, false)

	return
end

function InstagramChatLayer:SetRedPacketPanel(arg_80_1, arg_80_2, arg_80_3, arg_80_4, arg_80_5, arg_80_6)
	onButton(self, arg_80_1, function()
		SetActive(self.redPacketUI, true)
		pg.UIMgr.GetInstance():BlurPanel(self.redPacketUI)
		setImageSprite(self.redPacketUI:Find("panel/charaBg/chara"), LoadSprite("qicon/" .. arg_80_4), false)

		if not arg_80_3 then
			SetActive(self.redPacketUI:Find("panel/panelBg"), true)
			SetActive(self.redPacketUI:Find("panel/openImg"), false)
			SetActive(self.redPacketUI:Find("panel/get"), true)
			SetActive(self.redPacketUI:Find("panel/got"), false)
			SetActive(self.redPacketUI:Find("panel/detail"), false)
			setText(self.redPacketUI:Find("panel/get/titleBg/title"), arg_80_2.desc)
			onButton(self, self.redPacketUI:Find("panel/get/getBtn"), function()
				self:emit(InstagramChatMediator.GET_REDPACKET, arg_80_5, arg_80_6, arg_80_2.id)

				return
			end, SFX_PANEL)
		else
			self:UpdateRedPacketUI(arg_80_2.id)
		end

		return
	end, SFX_PANEL)
	onButton(self, self.redPacketUI:Find("bg"), function()
		self:CloseRedPacketPanel()

		if self.canFresh then
			self.canFresh = false

			local var_83_0 = self.currentChat.currentTopic:GetDisplayWordList()

			if var_83_0[#var_83_0].type == 0 then
				self:UpdateCharaList(false, false)
			else
				self:UpdateCharaList(true, false)
			end
		end

		return
	end, SFX_PANEL)

	return
end

function InstagramChatLayer:UpdateRedPacketUI(arg_84_1)
	local var_84_0 = var_0_2[arg_84_1]

	SetActive(self.redPacketUI:Find("panel/panelBg"), true)
	SetActive(self.redPacketUI:Find("panel/openImg"), false)
	SetActive(self.redPacketUI:Find("panel/get"), false)
	SetActive(self.redPacketUI:Find("panel/got"), true)
	SetActive(self.redPacketUI:Find("panel/detail"), false)

	local var_84_1 = Drop.Create(var_0_2[arg_84_1].content)

	var_84_1.count = 0

	updateDrop(self.redPacketUI:Find("panel/got/item"), var_84_1)
	onButton(self, self.redPacketUI:Find("panel/got/item"), function()
		self:emit(BaseUI.ON_DROP, var_84_1)

		return
	end, SFX_PANEL)

	self.redPacketUI:Find("panel/got/item/icon_bg"):GetComponent(typeof(Image)).enabled = false
	self.redPacketUI:Find("panel/got/item/icon_bg/frame"):GetComponent(typeof(Image)).enabled = false

	setText(self.redPacketUI:Find("panel/got/awardCount"), var_0_2[arg_84_1].content[3])

	if var_0_2[arg_84_1].type == 1 then
		SetActive(self.redPacketUI:Find("panel/got/detailBtn"), false)
	else
		SetActive(self.redPacketUI:Find("panel/got/detailBtn"), true)
		onButton(self, self.redPacketUI:Find("panel/got/detailBtn"), function()
			SetActive(self.redPacketUI:Find("panel/panelBg"), false)
			SetActive(self.redPacketUI:Find("panel/openImg"), true)
			SetActive(self.redPacketUI:Find("panel/got"), false)
			SetActive(self.redPacketUI:Find("panel/detail"), true)

			local var_86_0 = 0
			local var_86_1 = 0
			local var_86_2 = UIItemList.New(self.redPacketUI:Find("panel/detail/detailScroll/Viewport/Content"), self.redPacketUI:Find("panel/detail/detailScroll/Viewport/Content/charaGetCard"))

			var_86_2:make(function(arg_87_0, arg_87_1, arg_87_2)
				if arg_87_0 == UIItemList.EventUpdate then
					local var_87_0 = var_84_0.group_receive[arg_87_1 + 1]
					local var_87_1 = {
						var_84_0.group_receive[arg_87_1 + 1][2],
						var_84_0.group_receive[arg_87_1 + 1][3],
						var_84_0.group_receive[arg_87_1 + 1][4]
					}

					if var_84_0.group_receive[arg_87_1 + 1][1] ~= 0 then
						setImageSprite(arg_87_2:Find("charaBg/chara"), LoadSprite("qicon/" .. ((var_0_1[var_84_0.group_receive[arg_87_1 + 1][1]] or nil) and var_0_1[var_84_0.group_receive[arg_87_1 + 1][1]].sculpture)), false)
					else
						setImageSprite(arg_87_2:Find("charaBg/chara"), GetSpriteFromAtlas("ui/InstagramUI_atlas", "txdi_3"), false)
					end

					local var_87_3 = Drop.Create(var_87_1)

					var_87_3.count = 0

					updateDrop(arg_87_2:Find("item"), var_87_3)
					onButton(self, arg_87_2:Find("item"), function()
						self:emit(BaseUI.ON_DROP, var_87_3)

						return
					end, SFX_PANEL)

					arg_87_2:Find("item/icon_bg"):GetComponent(typeof(Image)).enabled = false
					arg_87_2:Find("item/icon_bg/frame"):GetComponent(typeof(Image)).enabled = false

					setText(arg_87_2:Find("awardCount"), var_87_0[4])

					if var_87_0[4] > var_86_1 then
						var_86_0 = arg_87_1
						var_86_1 = var_87_0[4]
					end
				end

				return
			end)
			var_86_2:align(#var_84_0.group_receive)

			for iter_86_0 = 1, #var_84_0.group_receive do
				SetActive(self.redPacketUI:Find("panel/detail/detailScroll/Viewport/Content"):GetChild(iter_86_0 - 1):Find("charaBg/king"), var_86_0 == iter_86_0 - 1)
			end

			return
		end, SFX_PANEL)
	end

	return
end

function InstagramChatLayer:CloseRedPacketPanel()
	pg.UIMgr.GetInstance():UnOverlayPanel(self.redPacketUI, self._tf:Find("subPages"))
	SetActive(self.redPacketUI, false)

	return
end

function InstagramChatLayer:SetData()
	local var_90_0 = getProxy(InstagramChatProxy)

	self.allChatList = var_90_0:GetChatList()
	self.chatList = table.insertto({}, self.allChatList)

	var_90_0:SortChatList()

	return
end

function InstagramChatLayer:willExit()
	if self.paintingName then
		retPaintingPrefab(self.rightPanel:Find("chat/paintingMask/painting"), self.paintingName)

		self.paintingName = nil
	end

	self:RemoveAllTimer()
	self:EixtOfficialAccounts()

	return
end

function InstagramChatLayer:StartTimer(arg_92_1, arg_92_2)
	local var_92_0 = Timer.New(arg_92_1, arg_92_2, 1)

	var_92_0:Start()
	table.insert(self.timerList, var_92_0)

	return
end

function InstagramChatLayer:RemoveAllTimer()
	for iter_93_0, iter_93_1 in ipairs(self.timerList) do
		iter_93_1:Stop()
	end

	self.timerList = {}

	return
end

function InstagramChatLayer:StartTimer2(arg_94_1, arg_94_2)
	self.timer = Timer.New(arg_94_1, arg_94_2, 1)

	self.timer:Start()

	return
end

function InstagramChatLayer:SpeedUpMessage()
	for iter_95_0, iter_95_1 in ipairs(self.timerList) do
		if iter_95_1.running then
			if iter_95_1.duration == pg.gameset.juuschat_entering_time.key_value / 1000 then
				iter_95_1.time = 0.05
			elseif iter_95_1.time - pg.gameset.juuschat_dialogue_trigger_time.key_value / 1000 < 0.05 then
				iter_95_1.time = 0.05

				self:StartTimer2(function()
					self:SpeedUpWaiting()

					return
				end, 0.05)
			else
				iter_95_1.time = iter_95_1.time - pg.gameset.juuschat_dialogue_trigger_time.key_value / 1000
			end
		end
	end

	return
end

function InstagramChatLayer:SpeedUpWaiting()
	for iter_97_0, iter_97_1 in ipairs(self.timerList) do
		if iter_97_1.running and iter_97_1.duration == pg.gameset.juuschat_entering_time.key_value / 1000 then
			iter_97_1.time = 0.05

			break
		end
	end

	return
end

function InstagramChatLayer:ChangeFresh()
	self.canFresh = true

	return
end

function InstagramChatLayer:ChangeCharaTextFunc(arg_99_1, arg_99_2)
	local function var_99_0(arg_100_0)
		if arg_100_0:Find("chat/id"):GetComponent(typeof(Text)).text == tostring(arg_99_1) then
			setText(arg_100_0:Find("chat/msg"), arg_99_2)
		end

		return
	end

	for iter_99_0 = 0, self.charaScrollContent.childCount - 1 do
		var_99_0((self.charaScrollContent:GetChild(iter_99_0)))
	end

	return
end

function InstagramChatLayer:ResetCharaTextFunc(arg_101_1)
	local function var_101_0(arg_102_0)
		if arg_102_0:Find("chat/id"):GetComponent(typeof(Text)).text == tostring(arg_101_1) then
			setText(arg_102_0:Find("chat/msg"), arg_102_0:Find("chat/displayWord"):GetComponent(typeof(Text)).text)
		end

		return
	end

	for iter_101_0 = 0, self.charaScrollContent.childCount - 1 do
		var_101_0((self.charaScrollContent:GetChild(iter_101_0)))
	end

	return
end

function InstagramChatLayer:SetEndAniEvent(arg_103_1, arg_103_2)
	local var_103_0 = arg_103_1:GetComponent(typeof(DftAniEvent))

	if var_103_0 then
		var_103_0:SetEndEvent(function()
			arg_103_2()
			var_103_0:SetEndEvent(nil)

			return
		end)
	end

	return
end

function InstagramChatLayer:onBackPressed()
	if isActive(self.filterUI) then
		self:CloseFilterPanel()

		return
	end

	if isActive(self.topicUI) then
		self:CloseTopicPanel()

		return
	end

	if isActive(self.backgroundUI) then
		self:CloseBackgroundPanel()

		return
	end

	if isActive(self.redPacketUI) then
		self:CloseRedPacketPanel()

		return
	end

	if isActive(self.rightOfficialAccountsPanel) and isActive(self.rightOfficialAccountsInfoPanel) then
		self:ExitOfficialAccountsInfo()

		return
	end

	self:emit(InstagramChatMediator.CLOSE_ALL)

	return
end

function InstagramChatLayer:InitOfficialAccounts()
	self.rightOfficialAccountsListPanel = self.rightOfficialAccountsPanel:Find("officialAccountsPanel")
	self.rightOfficialAccountsInfoPanel = self.rightOfficialAccountsPanel:Find("officialAccountsInfoPanel")

	setText(self.rightOfficialAccountsListPanel:Find("topBg/Text"), i18n("juusoa_title"))
	setText(self.rightOfficialAccountsInfoPanel:Find("topBg/Text"), i18n("juusoa_title"))

	self.officialAccountsScroll = self.rightOfficialAccountsListPanel:Find("charaScroll"):GetComponent("LScrollRect")
	self.officialAccountsScroll.onInitItem = handler(self, self.OfficialAccountsInitItem)
	self.officialAccountsScroll.onUpdateItem = handler(self, self.OfficialAccountsUpdateItem)
	self.downloadmgr = BulletinBoardMgr.Inst
	self.sprites = {}
	self.toDownloadList = {}
	self.officialAccountsInfoScroll = self.rightOfficialAccountsInfoPanel:Find("scroll"):GetComponent(typeof(ScrollRect))
	self.officialAccountsInfoItem = self.rightOfficialAccountsInfoPanel:Find("scroll/content/infoItem")
	self.commentList = UIItemList.New(self.rightOfficialAccountsInfoPanel:Find("scroll/content/commentPanel"), self.rightOfficialAccountsInfoPanel:Find("scroll/content/commentPanel/tpl"))
	self.commentPanel = self.rightOfficialAccountsInfoPanel:Find("last/bg2")
	self.optionalPanel = self.rightOfficialAccountsInfoPanel:Find("last/bg2/option")

	setActive(self.rightOfficialAccountsPanel, false)
	setActive(self.rightOfficialAccountsInfoPanel, false)

	return
end

function InstagramChatLayer:UpdateOfficialAccounts(arg_107_1)
	setActive(self.rightChatPanel, false)
	setActive(self.rightOfficialAccountsPanel, true)
	setActive(self.rightOfficialAccountsListPanel, true)
	setActive(self.rightOfficialAccountsInfoPanel, false)

	self.currentChat = arg_107_1
	self.instagramOfficialAccounts = {}

	for iter_107_0, iter_107_1 in pairs(getProxy(InstagramProxy):GetOfficialAccounts()) do
		table.insert(self.instagramOfficialAccounts, iter_107_1)
	end

	table.sort(self.instagramOfficialAccounts, function(arg_108_0, arg_108_1)
		return arg_108_0.id > arg_108_1.id
	end)
	self.officialAccountsScroll:SetTotalCount(#self.instagramOfficialAccounts)

	return
end

function InstagramChatLayer:OfficialAccountsInitItem(arg_109_1)
	self.officialAccountsItemList[arg_109_1] = InstagramOfficialAccountsItem.New(tf(arg_109_1), self)

	return
end

function InstagramChatLayer:OfficialAccountsUpdateItem(arg_110_1, arg_110_2)
	local var_110_0 = self.officialAccountsItemList[arg_110_2]

	if self.officialAccountsItemList[arg_110_2] == nil then
		self:OfficialAccountsInitItem(arg_110_2)

		var_110_0 = self.officialAccountsItemList[arg_110_2]
	end

	local var_110_1 = self.instagramOfficialAccounts[arg_110_1 + 1]
	local var_110_2 = tf(arg_110_2)

	var_110_0:SetData(self.instagramOfficialAccounts[arg_110_1 + 1].id)
	self:SetImageByUrl(var_110_1.oaListPic, var_110_2:Find("Image"):GetComponent(typeof(RawImage)))
	onButton(self, var_110_2, function()
		self.currentOfficalID = var_110_1.id

		pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildJuusOfficialAccountsClick(var_110_1.id))
		self:ShowOfficialAccountsInfo(var_110_1)
		self:ReadOfficialAccountComment()

		self.officialAccountsInfoScroll.verticalNormalizedPosition = 1

		return
	end, SFX_PANEL)

	return
end

function InstagramChatLayer:ShowOfficialAccountsInfo(arg_112_1)
	setActive(self.rightOfficialAccountsListPanel, false)
	setActive(self.rightOfficialAccountsInfoPanel, true)
	self:CloseCommentPanel()
	onButton(self, self.rightOfficialAccountsInfoPanel:Find("topBg"), function()
		self:ExitOfficialAccountsInfo()

		return
	end, SFX_PANEL)
	setScrollText(self.officialAccountsInfoItem:Find("title/Text"), arg_112_1:getConfig("title"))
	setText(self.officialAccountsInfoItem:Find("content"), arg_112_1.text)
	self:SetImageByUrl(arg_112_1:GetImage(), self.officialAccountsInfoItem:Find("Image/Image"):GetComponent(typeof(RawImage)))
	setText(self.officialAccountsInfoItem:Find("bottom/time"), arg_112_1:GetPushTime())
	self:UpdateLinkBtn(arg_112_1.id)
	onButton(self, self.officialAccountsInfoItem:Find("bottom/time/share"), function()
		self:emit(InstagramChatMediator.ON_OFFICIAL_ACCOUNTS_OPERATE, ActivityConst.INSTAGRAM_OP_SHARE, arg_112_1.id)

		return
	end, SFX_PANEL)
	self:UpdateCommentList(arg_112_1.id)
	Canvas.ForceUpdateCanvases()
	onToggle(self, self.commentPanel, function(arg_115_0)
		if arg_115_0 then
			self:OpenCommentPanel(arg_112_1.id)
		else
			self:CloseCommentPanel()
		end

		return
	end, SFX_PANEL)

	return
end

function InstagramChatLayer:ExitOfficialAccountsInfo()
	setActive(self.rightOfficialAccountsListPanel, true)
	setActive(self.rightOfficialAccountsInfoPanel, false)

	self.currentOfficalID = nil

	return
end

function InstagramChatLayer:UpdateLinkBtn(arg_117_1)
	local var_117_0 = getProxy(InstagramProxy):GetOfficialAccounts()[arg_117_1]
	local var_117_1 = var_117_0:IsLiking()
	local var_117_2 = self.officialAccountsInfoItem:Find("bottom/notCare")

	if not var_117_1 then
		onButton(self, var_117_2, function()
			self:emit(InstagramChatMediator.ON_OFFICIAL_ACCOUNTS_OPERATE, ActivityConst.INSTAGRAM_OP_LIKE, var_117_0.id)

			return
		end, SFX_PANEL)
	else
		removeOnButton(var_117_2)
	end

	setActive(var_117_2, not var_117_1)
	setActive(self.officialAccountsInfoItem:Find("bottom/care"), var_117_1)
	setText(self.officialAccountsInfoItem:Find("bottom/careText"), i18n("ins_word_like", var_117_0:GetLikeCnt()))

	return
end

function InstagramChatLayer:UpdateCommentList(arg_119_1)
	if self.currentOfficalID ~= arg_119_1 then
		return
	end

	local var_119_0 = getProxy(InstagramProxy):GetOfficialAccounts()[arg_119_1]

	if not var_119_0 then
		return
	end

	local var_119_1, var_119_2 = var_119_0:GetCanDisplayComments()

	table.sort(var_119_1, function(arg_120_0, arg_120_1)
		return arg_120_0.time < arg_120_1.time
	end)
	self.commentList:make(function(arg_121_0, arg_121_1, arg_121_2)
		if arg_121_0 == UIItemList.EventUpdate then
			local var_121_0 = var_119_1[arg_121_1 + 1]
			local var_121_1 = var_119_1[arg_121_1 + 1]:HasReply()

			setText(arg_121_2:Find("main/reply"), var_119_1[arg_121_1 + 1]:GetReplyBtnTxt())
			setText(arg_121_2:Find("main/content"), HXSet.hxLan((SwitchSpecialChar((var_121_0:GetContent())))))
			setText(arg_121_2:Find("main/bubble/Text"), var_121_0:GetReplyCnt())
			setText(arg_121_2:Find("main/time"), var_121_0:GetTime())

			if var_121_0:GetType() == Instagram.TYPE_PLAYER_COMMENT then
				local var_121_2, var_121_3 = var_121_0:GetIcon()

				setImageSprite(arg_121_2:Find("main/head/icon"), GetSpriteFromAtlas(var_121_2, var_121_3))
			else
				setImageSprite(arg_121_2:Find("main/head/icon"), LoadSprite("qicon/" .. var_121_0:GetIcon()), false)
			end

			if var_121_1 then
				onToggle(self, arg_121_2:Find("main/bubble"), function(arg_122_0)
					setActive(arg_121_2:Find("replys"), arg_122_0)

					return
				end, SFX_PANEL)
				self:UpdateReplys(arg_121_2, var_121_0)
				triggerToggle(arg_121_2:Find("main/bubble"), true)
			else
				setActive(arg_121_2:Find("replys"), false)
				triggerToggle(arg_121_2:Find("main/bubble"), false)
			end

			arg_121_2:Find("main/bubble"):GetComponent(typeof(Toggle)).enabled = var_121_1
		end

		return
	end)
	Canvas.ForceUpdateCanvases()
	self.commentList:align(#var_119_1)

	return
end

function InstagramChatLayer:UpdateReplys(arg_123_1, arg_123_2)
	local var_123_0, var_123_1 = arg_123_2:GetCanDisplayReply()
	local var_123_2 = UIItemList.New(arg_123_1:Find("replys"), arg_123_1:Find("replys/sub"))

	table.sort(var_123_0, function(arg_124_0, arg_124_1)
		if arg_124_0.level == arg_124_1.level then
			if arg_124_0.time == arg_124_1.time then
				return arg_124_0.id < arg_124_1.id
			else
				return arg_124_0.time < arg_124_1.time
			end
		else
			return arg_124_0.level < arg_124_1.level
		end

		return
	end)
	var_123_2:make(function(arg_125_0, arg_125_1, arg_125_2)
		if arg_125_0 == UIItemList.EventUpdate then
			setImageSprite(arg_125_2:Find("head/icon"), LoadSprite("qicon/" .. var_123_0[arg_125_1 + 1]:GetIcon()), false)
			setText(arg_125_2:Find("content"), HXSet.hxLan((SwitchSpecialChar((var_123_0[arg_125_1 + 1]:GetContent())))))
		end

		return
	end)
	var_123_2:align(#var_123_0)

	return
end

function InstagramChatLayer:OpenCommentPanel(arg_126_1)
	local var_126_0 = getProxy(InstagramProxy):GetOfficialAccounts()[arg_126_1]

	if not var_126_0:CanOpenComment() then
		return
	end

	setActive(self.optionalPanel, true)

	local var_126_1 = var_126_0:GetOptionComment()

	self.commentPanel.sizeDelta = Vector2(0, #var_126_1 * 120 + 40)

	local var_126_2 = UIItemList.New(self.optionalPanel, self.optionalPanel:Find("option1"))

	var_126_2:make(function(arg_127_0, arg_127_1, arg_127_2)
		if arg_127_0 == UIItemList.EventUpdate then
			local var_127_0 = var_126_1[arg_127_1 + 1].id
			local var_127_1 = var_126_1[arg_127_1 + 1].index

			setText(arg_127_2:Find("Text"), HXSet.hxLan(var_126_1[arg_127_1 + 1].text))
			onButton(self, arg_127_2, function()
				self:emit(InstagramChatMediator.ON_OFFICIAL_ACCOUNTS_OPERATE, ActivityConst.INSTAGRAM_OP_COMMENT, arg_126_1, var_127_0, var_127_1)
				self:CloseCommentPanel()

				return
			end, SFX_PANEL)
		end

		return
	end)
	var_126_2:align(#var_126_1)

	return
end

function InstagramChatLayer:CloseCommentPanel()
	self.commentPanel.sizeDelta = Vector2(0, 0)

	setActive(self.optionalPanel, false)

	return
end

function InstagramChatLayer:ReadOfficialAccountComment()
	if self.currentChat and self.currentChat.chatType == InstagramConst.INSTAGRAM_CHAT_TYPE.OFFICIAL_ACCOUNT and self.currentOfficalID then
		local var_130_0 = getProxy(InstagramProxy):GetOfficialAccounts()[self.currentOfficalID]

		if var_130_0 and not var_130_0:IsReaded() then
			self:emit(InstagramChatMediator.ON_OFFICIAL_ACCOUNTS_OPERATE, ActivityConst.INSTAGRAM_OP_MARK_READ, self.currentOfficalID)
		end
	end

	return
end

function InstagramChatLayer:RefreshOfficialAccountTips()
	for iter_131_0, iter_131_1 in pairs(self.officialAccountsItemList) do
		iter_131_1:RefreshTip()
	end

	self.charaScrollrect:SetTotalCount(#self.chatList)

	return
end

function InstagramChatLayer:SetImageByUrl(arg_132_1, arg_132_2, arg_132_3)
	if not arg_132_1 or arg_132_1 == "" then
		setActive(arg_132_2.gameObject, false)

		if arg_132_3 then
			arg_132_3()
		end
	else
		setActive(arg_132_2.gameObject, true)

		if self.sprites[arg_132_1] then
			arg_132_2.texture = self.sprites[arg_132_1]

			if arg_132_3 then
				arg_132_3()
			end
		else
			arg_132_2.enabled = false

			self.downloadmgr:GetTexture("ins", "1", arg_132_1, UnityEngine.Events.UnityAction_UnityEngine_Texture(function(arg_133_0)
				if self.exited then
					return
				end

				if not self.sprites then
					return
				end

				self.sprites[arg_132_1] = arg_133_0
				arg_132_2.texture = arg_133_0
				arg_132_2.enabled = true

				if arg_132_3 then
					arg_132_3()
				end

				return
			end))
			table.insert(self.toDownloadList, arg_132_1)
		end
	end

	return
end

function InstagramChatLayer:AddOfficialAccountsTimer()
	self:StopOfficialAccountsTimer()

	local var_134_0 = pg.TimeMgr.GetInstance():GetServerTime()

	for iter_134_0, iter_134_1 in pairs((getProxy(InstagramProxy):GetOfficialAccounts())) do
		local var_134_1 = iter_134_1:GetFastestRefreshTime()

		if var_134_1 then
			if var_134_1 - var_134_0 <= 0 then
				self:emit(InstagramChatMediator.ON_OFFICIAL_ACCOUNTS_OPERATE, ActivityConst.INSTAGRAM_OP_UPDATE, iter_134_1.id)
			else
				self.officialAccountsTimerList[iter_134_1.id] = Timer.New(function()
					self:emit(InstagramChatMediator.ON_OFFICIAL_ACCOUNTS_OPERATE, ActivityConst.INSTAGRAM_OP_UPDATE, iter_134_1.id)

					return
				end, var_134_1 - var_134_0, 1)

				self.officialAccountsTimerList[iter_134_1.id]:Start()
			end
		end
	end

	return
end

function InstagramChatLayer:StopOfficialAccountsTimer()
	for iter_136_0, iter_136_1 in pairs(self.officialAccountsTimerList) do
		self.officialAccountsTimerList[iter_136_0]:Stop()
	end

	self.officialAccountsTimerList = {}

	return
end

function InstagramChatLayer:EixtOfficialAccounts()
	self:StopOfficialAccountsTimer()

	self.officialAccountsItemList = nil
	self.exited = true
	self.sprites = nil

	for iter_137_0, iter_137_1 in ipairs(self.toDownloadList or {}) do
		self.downloadmgr:StopLoader(iter_137_1)
	end

	self.toDownloadList = {}

	return
end

return InstagramChatLayer
