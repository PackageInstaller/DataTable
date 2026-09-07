local Dorm3dChatLayer = class("Dorm3dChatLayer", import("view.base.BaseUI"))
local var_0_1 = pg.dorm3d_ins_ship_group_template
local var_0_2 = pg.dorm3d_ins_redpackage
local var_0_3 = pg.emoji_template

function Dorm3dChatLayer:getUIName()
	return "Dorm3dChatUI"
end

function Dorm3dChatLayer:init()
	self.rightPanel = self._tf:Find("main/rightPanel")
	self.characterName = self.rightPanel:Find("rightTop/name")
	self.careBtn = self.rightPanel:Find("rightTop/careBtn")
	self.topicBtn = self.rightPanel:Find("rightTop/topicBtn")
	self.backgroundBtn = self.rightPanel:Find("rightTop/backgroundBtn")
	self.messageList = UIItemList.New(self.rightPanel:Find("messageScroll/Viewport/Content"), self.rightPanel:Find("messageScroll/Viewport/Content/messageCard"))
	self.optionPanel = self.rightPanel:Find("optionPanel")
	self.optionList = UIItemList.New(self.optionPanel, self.optionPanel:Find("option"))
	self.topicUI = self._tf:Find("subPages/InstagramTopicUI")
	self.backgroundUI = self._tf:Find("subPages/InstagramBackgroundUI")
	self.redPacketUI = self._tf:Find("subPages/InstagramRedPacketUI")
	self.pictureUI = self._tf:Find("subPages/PictureUI")

	setText(self.topicUI:Find("panel/topicScroll/Viewport/Content/topic/waiting"), i18n("juuschat_chattip3"))
	setText(self.topicUI:Find("panel/topicScroll/Viewport/Content/topic/selected/Text"), i18n("juuschat_label2"))
	setText(self.backgroundUI:Find("panel/backgroundScroll/Viewport/Content/background/selected/Text"), i18n("juuschat_label1"))
	setText(self.backgroundUI:Find("panel/backgroundScroll/Viewport/Content/background/lockFrame/Text"), i18n("juuschat_background_tip1"))

	self.redPacketGot = self.redPacketUI:Find("panel/got")
	self.noMessage = self.rightPanel:Find("noMessage")

	setText(self.noMessage:Find("Text"), i18n("dorm3d_ins_no_topics"))
	SetActive(self.topicUI, false)
	SetActive(self.backgroundUI, false)
	SetActive(self.redPacketUI, false)
	SetActive(self.pictureUI, false)

	self.timerList = {}
	self.canFresh = false

	local var_2_0 = self.rightPanel:Find("messageScroll/Scrollbar Vertical"):GetComponent(typeof(RectTransform))

	self.messageScrollWidth = var_2_0.rect.width
	self.messageScrollHeight = var_2_0.rect.height

	self.topicUI:Find("panel/title"):GetComponent(typeof(Image)):SetNativeSize()
	self.backgroundUI:Find("panel/title"):GetComponent(typeof(Image)):SetNativeSize()
	onButton(self, self.rightPanel:Find("closeBtn"), function()
		self:closeView()

		return
	end, SFX_PANEL)
	self:OverlayPanel(self._tf)

	return
end

function Dorm3dChatLayer:didEnter()
	self:SetData()
	self:UpdateChat(false, false)

	return
end

function Dorm3dChatLayer:UpdateChat(arg_5_1, arg_5_2)
	SetActive(self.rightPanel, true)
	self:UpdateChatContent(arg_5_1, arg_5_2)
	self:SetTopicPanel(self.currentChat)
	self:SetBackgroundPanel(self.currentChat)

	if not arg_5_1 then
		local var_5_0 = self.rightPanel:GetComponent(typeof(Animation))

		var_5_0:Stop()
		var_5_0:Play("anim_newinstagram_chat_right_in")
	end

	return
end

function Dorm3dChatLayer:UpdateChatContent(arg_6_1, arg_6_2)
	SetActive(self.rightPanel, true)
	setText(self.characterName, self.currentChat.name)
	SetActive(self.careBtn:Find("care"), self.currentChat.care == 1)
	onButton(self, self.careBtn, function()
		self:emit(Dorm3dChatMediator.CHANGE_CARE, self.currentChat.characterId, self.currentChat.care == 0 and 1 or 0)

		return
	end, SFX_PANEL)

	local var_6_0 = self.rightPanel:Find("paintingMask")
	local var_6_1 = var_6_0:Find("painting")
	local var_6_2 = self.rightPanel:Find("groupBackground")

	if not self.currentChat.groupBackground or self.currentChat.groupBackground == "" then
		SetActive(var_6_0, true)
		SetActive(var_6_2, false)

		local var_6_3 = "unknown"

		if self.currentChat.skinId == 0 then
			var_6_3 = self.currentChat:GetPainting()
		else
			for iter_6_0, iter_6_1 in ipairs(self.currentChat.skins) do
				if iter_6_1.id == self.currentChat.skinId then
					var_6_3 = iter_6_1.painting
				end
			end
		end

		if not self.paintingName then
			setPaintingPrefabAsync(var_6_1, var_6_3, "pifu")

			self.paintingName = var_6_3
		elseif self.paintingName and self.paintingName ~= var_6_3 then
			retPaintingPrefab(var_6_1, self.paintingName)
			setPaintingPrefabAsync(var_6_1, var_6_3, "pifu")

			self.paintingName = var_6_3
		end
	else
		SetActive(var_6_0, false)
		SetActive(var_6_2, true)

		if self.paintingName then
			retPaintingPrefab(var_6_1, self.paintingName)

			self.paintingName = nil
		end

		setImageSprite(var_6_2, LoadSprite("ui/" .. self.currentChat.groupBackground), true)
	end

	setActive(self.rightPanel:Find("messageScroll"), self.currentChat.currentTopic)
	setActive(var_6_0, self.currentChat.currentTopic)
	setActive(self.noMessage, not self.currentChat.currentTopic)

	if not self.currentChat.currentTopic then
		return
	end

	local var_6_4 = self.currentChat.currentTopic:GetDisplayWordList()

	if not arg_6_2 then
		self:UpdateOptionPanel(self.currentChat.currentTopic, var_6_4)
		self:UpdateMessageList(self.currentChat.currentTopic, var_6_4, arg_6_1, self.currentChat.characterId)
	end

	if not arg_6_1 and self.currentChat.currentTopic.readFlag == 0 then
		self:emit(Dorm3dChatMediator.SET_READED, self.currentChat.characterId, {
			self.currentChat.currentTopic.topicId
		})
	end

	return
end

function Dorm3dChatLayer:UpdateMessageList(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	self:RemoveAllTimer()

	local var_8_0

	for iter_8_0 = #arg_8_2, 1, -1 do
		if arg_8_2[iter_8_0].ship_group == 0 or arg_8_2[iter_8_0].type == 3 and arg_8_1:RedPacketGotFlag(tonumber(arg_8_2[iter_8_0].param)) then
			var_8_0 = iter_8_0

			break
		end
	end

	local var_8_1 = {}

	if var_8_0 then
		for iter_8_1 = var_8_0, 1, -1 do
			if arg_8_2[iter_8_1].ship_group == 0 then
				table.insert(var_8_1, iter_8_1)
			else
				break
			end
		end
	end

	if self.shouldShowOption and arg_8_3 then
		self:SetOptionPanelActive(false)
	end

	if arg_8_3 then
		onButton(self, self.rightPanel:Find("messageScroll"), function()
			self:SpeedUpMessage()

			return
		end, SFX_PANEL)
	end

	local var_8_2 = GetComponent(self.rightPanel:Find("messageScroll"), typeof(ScrollRect))

	local function var_8_3(arg_10_0)
		var_8_2.normalizedPosition = Vector2(0, arg_10_0)

		return
	end

	local var_8_4 = pg.gameset.juuschat_dialogue_trigger_time.key_value / 1000
	local var_8_5 = pg.gameset.juuschat_entering_time.key_value / 1000
	local var_8_6 = pg.gameset.juuschat_dialogue_trigger_time.key_value / 1000 - pg.gameset.juuschat_entering_time.key_value / 1000

	self.playbackInfos = {}

	self.messageList:make(function(arg_11_0, arg_11_1, arg_11_2)
		if arg_11_0 == UIItemList.EventUpdate then
			local var_11_0 = arg_8_2[arg_11_1 + 1]

			if arg_8_2[arg_11_1 + 1].ship_group == 0 and var_11_0.type == 0 then
				SetActive(arg_11_2, false)

				return
			end

			local var_11_1 = arg_11_2:Find("charaMessageCard")
			local var_11_2 = arg_11_2:Find("playerReplyCard")

			SetActive(var_11_1, var_11_0.ship_group ~= 0)
			SetActive(var_11_2, var_11_0.ship_group == 0)
			SetActive(arg_11_2:Find("nameBar"), false)

			local var_11_3

			if arg_8_3 and var_8_0 and arg_11_1 + 1 > var_8_0 then
				var_11_3 = (arg_11_1 + 1 - var_8_0) * var_8_4 - var_8_5

				if #var_8_1 > 1 then
					var_11_3 = var_11_3 + (#var_8_1 - 1) * var_8_6
				end
			end

			if var_11_0.ship_group ~= 0 then
				local var_11_4 = "unknown"

				if var_0_1[var_11_0.ship_group] then
					var_11_4 = var_0_1[var_11_0.ship_group].sculpture
				end

				if var_11_0.type ~= 5 then
					setImageSprite(arg_11_2:Find("charaMessageCard/charaBg/chara"), LoadSprite("qicon/" .. var_11_4), false)
				end

				if var_11_0.type == 1 then
					self:SetCharaMessageCardActive(var_11_1, {
						3
					})
					setText(arg_11_2:Find("charaMessageCard/msgBox/msg"), var_11_0.param)

					if arg_8_3 and var_8_0 and arg_11_1 + 1 > var_8_0 then
						SetActive(arg_11_2, false)
						self:StartTimer(function()
							SetActive(arg_11_2, true)
							arg_11_2:Find("charaMessageCard/charaBg"):GetComponent(typeof(Animation)):Play("anim_newinstagram_charabg")
							SetActive(arg_11_2:Find("charaMessageCard/waiting"), true)
							SetActive(arg_11_2:Find("charaMessageCard/msgBox"), false)
							Canvas.ForceUpdateCanvases()
							LeanTween.value(go(self.rightPanel:Find("messageScroll")), var_8_2.normalizedPosition.y, 0, 0.5):setOnUpdate(System.Action_float(var_8_3)):setEase(LeanTweenType.easeInOutCubic)
							self:StartTimer(function()
								SetActive(arg_11_2:Find("charaMessageCard/waiting"), false)
								SetActive(arg_11_2:Find("charaMessageCard/msgBox"), true)
								arg_11_2:Find("charaMessageCard/msgBox"):GetComponent(typeof(Animation)):Play("anim_newinstagram_chat_common_in")

								if arg_11_1 + 1 == #arg_8_2 then
									self:emit(Dorm3dChatMediator.SET_READED, arg_8_4, {
										arg_8_1.topicId
									})
								end

								Canvas.ForceUpdateCanvases()
								LeanTween.value(go(self.rightPanel:Find("messageScroll")), var_8_2.normalizedPosition.y, 0, 0.5):setOnUpdate(System.Action_float(var_8_3)):setEase(LeanTweenType.easeInOutCubic)
								self:SetEndAniEvent(arg_11_2:Find("charaMessageCard/msgBox"), function()
									if self.shouldShowOption and arg_11_1 + 1 == #arg_8_2 then
										self:SetOptionPanelActive(true)
									end

									return
								end)

								return
							end, var_8_5)

							return
						end, var_11_3)
					end
				elseif var_11_0.type == 2 then
					self:SetCharaMessageCardActive(var_11_1, {
						2,
						7
					})
					pg.CriMgr.GetInstance():GetCueInfo("cv-" .. var_11_0.ship_group, var_11_0.param[1], function(arg_15_0)
						setText(arg_11_2:Find("charaMessageCard/voiceBox/time"), tostring(math.ceil(tonumber(tostring(arg_15_0.length)) / 1000)) .. "\"")

						return
					end)

					self.playbackInfos[var_11_0.id] = nil

					setActive(arg_11_2:Find("charaMessageCard/voiceBox/play/pause"), false)
					onButton(self, arg_11_2:Find("charaMessageCard/voiceBox/play"), function()
						if self.playbackInfos[var_11_0.id].playback:GetStatus() == CriAtomExPlayback.Status.Removed then
							self.playbackInfos[var_11_0.id] = nil
						end

						if not self.playbackInfos[var_11_0.id] then
							pg.CriMgr.GetInstance():PlaySoundEffect_V3("event:/cv/" .. var_11_0.ship_group .. "/" .. var_11_0.param[1], function(arg_17_0)
								if arg_17_0 then
									self.playbackInfos[var_11_0.id] = arg_17_0
								end

								return
							end)
							setActive(arg_11_2:Find("charaMessageCard/voiceBox/play/pause"), true)
						elseif self.playbackInfos[var_11_0.id].playback:IsPaused() then
							self.playbackInfos[var_11_0.id].playback:Resume(CriWare.CriAtomEx.ResumeMode.PausedPlayback)
							setActive(arg_11_2:Find("charaMessageCard/voiceBox/play/pause"), true)
						else
							self.playbackInfos[var_11_0.id].playback:Pause()
							setActive(arg_11_2:Find("charaMessageCard/voiceBox/play/pause"), false)
						end

						return
					end, SFX_PANEL)
					setText(arg_11_2:Find("charaMessageCard/voiceMsgBox/voiceMsg/msg"), var_11_0.param[2])

					if arg_8_3 and var_8_0 and arg_11_1 + 1 > var_8_0 then
						SetActive(arg_11_2, false)
						self:StartTimer(function()
							SetActive(arg_11_2, true)
							arg_11_2:Find("charaMessageCard/charaBg"):GetComponent(typeof(Animation)):Play("anim_newinstagram_charabg")
							SetActive(arg_11_2:Find("charaMessageCard/waiting"), true)
							SetActive(arg_11_2:Find("charaMessageCard/voiceBox"), false)
							SetActive(arg_11_2:Find("charaMessageCard/voiceMsgBox"), false)
							Canvas.ForceUpdateCanvases()
							LeanTween.value(go(self.rightPanel:Find("messageScroll")), var_8_2.normalizedPosition.y, 0, 0.5):setOnUpdate(System.Action_float(var_8_3)):setEase(LeanTweenType.easeInOutCubic)
							self:StartTimer(function()
								SetActive(arg_11_2:Find("charaMessageCard/waiting"), false)
								SetActive(arg_11_2:Find("charaMessageCard/voiceBox"), true)
								SetActive(arg_11_2:Find("charaMessageCard/voiceMsgBox"), true)
								arg_11_2:Find("charaMessageCard/voiceBox"):GetComponent(typeof(Animation)):Play("anim_newinstagram_chat_common_in")
								arg_11_2:Find("charaMessageCard/voiceMsgBox"):GetComponent(typeof(Animation)):Play("anim_newinstagram_voicetip_in")

								if arg_11_1 + 1 == #arg_8_2 then
									self:emit(Dorm3dChatMediator.SET_READED, arg_8_4, {
										arg_8_1.topicId
									})
								end

								Canvas.ForceUpdateCanvases()
								LeanTween.value(go(self.rightPanel:Find("messageScroll")), var_8_2.normalizedPosition.y, 0, 0.5):setOnUpdate(System.Action_float(var_8_3)):setEase(LeanTweenType.easeInOutCubic)
								self:SetEndAniEvent(arg_11_2:Find("charaMessageCard/voiceBox"), function()
									if self.shouldShowOption and arg_11_1 + 1 == #arg_8_2 then
										self:SetOptionPanelActive(true)
									end

									return
								end)

								return
							end, var_8_5)

							return
						end, var_11_3)
					end
				elseif var_11_0.type == 3 then
					self:SetCharaMessageCardActive(var_11_1, {
						5
					})

					local var_11_5 = var_0_2[tonumber(var_11_0.param)]

					setText(arg_11_2:Find("charaMessageCard/redPacket/desc"), var_11_5.desc)

					local var_11_6 = arg_8_1:RedPacketGotFlag(var_11_5.id)

					SetActive(arg_11_2:Find("charaMessageCard/redPacket/got"), var_11_6)
					self:SetRedPacketPanel(arg_11_2:Find("charaMessageCard/redPacket"), var_11_5, var_11_6, var_11_4, arg_8_4, arg_8_1.topicId, var_11_0.id)

					if arg_8_3 and var_8_0 and arg_11_1 + 1 > var_8_0 then
						SetActive(arg_11_2, false)
						self:StartTimer(function()
							SetActive(arg_11_2, true)
							arg_11_2:Find("charaMessageCard/charaBg"):GetComponent(typeof(Animation)):Play("anim_newinstagram_charabg")
							SetActive(arg_11_2:Find("charaMessageCard/waiting"), true)
							SetActive(arg_11_2:Find("charaMessageCard/redPacket"), false)
							Canvas.ForceUpdateCanvases()
							LeanTween.value(go(self.rightPanel:Find("messageScroll")), var_8_2.normalizedPosition.y, 0, 0.5):setOnUpdate(System.Action_float(var_8_3)):setEase(LeanTweenType.easeInOutCubic)
							self:StartTimer(function()
								SetActive(arg_11_2:Find("charaMessageCard/waiting"), false)
								SetActive(arg_11_2:Find("charaMessageCard/redPacket"), true)
								arg_11_2:Find("charaMessageCard/redPacket"):GetComponent(typeof(Animation)):Play("anim_newinstagram_redpacket_in")

								if arg_11_1 + 1 == #arg_8_2 then
									self:emit(Dorm3dChatMediator.SET_READED, arg_8_4, {
										arg_8_1.topicId
									})
								end

								Canvas.ForceUpdateCanvases()
								LeanTween.value(go(self.rightPanel:Find("messageScroll")), var_8_2.normalizedPosition.y, 0, 0.5):setOnUpdate(System.Action_float(var_8_3)):setEase(LeanTweenType.easeInOutCubic)
								self:SetEndAniEvent(arg_11_2:Find("charaMessageCard/redPacket"), function()
									if self.shouldShowOption and arg_11_1 + 1 == #arg_8_2 then
										self:SetOptionPanelActive(true)
									end

									return
								end)

								return
							end, var_8_5)

							return
						end, var_11_3)
					end
				elseif var_11_0.type == 4 then
					self:SetCharaMessageCardActive(var_11_1, {
						4
					})
					self:ClearEmoji(arg_11_2:Find("charaMessageCard/emoji/emoticon"))
					self:SetEmoji(arg_11_2:Find("charaMessageCard/emoji/emoticon"), var_0_3[tonumber(var_11_0.param)].pic)

					if arg_8_3 and var_8_0 and arg_11_1 + 1 > var_8_0 then
						SetActive(arg_11_2, false)
						self:StartTimer(function()
							SetActive(arg_11_2, true)
							arg_11_2:Find("charaMessageCard/charaBg"):GetComponent(typeof(Animation)):Play("anim_newinstagram_charabg")
							SetActive(arg_11_2:Find("charaMessageCard/waiting"), true)
							SetActive(arg_11_2:Find("charaMessageCard/emoji"), false)
							Canvas.ForceUpdateCanvases()
							LeanTween.value(go(self.rightPanel:Find("messageScroll")), var_8_2.normalizedPosition.y, 0, 0.5):setOnUpdate(System.Action_float(var_8_3)):setEase(LeanTweenType.easeInOutCubic)
							self:StartTimer(function()
								SetActive(arg_11_2:Find("charaMessageCard/waiting"), false)
								SetActive(arg_11_2:Find("charaMessageCard/emoji"), true)
								arg_11_2:Find("charaMessageCard/emoji"):GetComponent(typeof(Animation)):Play("anim_newinstagram_emoji_in")

								if arg_11_1 + 1 == #arg_8_2 then
									self:emit(Dorm3dChatMediator.SET_READED, arg_8_4, {
										arg_8_1.topicId
									})
								end

								Canvas.ForceUpdateCanvases()
								LeanTween.value(go(self.rightPanel:Find("messageScroll")), var_8_2.normalizedPosition.y, 0, 0.5):setOnUpdate(System.Action_float(var_8_3)):setEase(LeanTweenType.easeInOutCubic)
								self:SetEndAniEvent(arg_11_2:Find("charaMessageCard/emoji"), function()
									if self.shouldShowOption and arg_11_1 + 1 == #arg_8_2 then
										self:SetOptionPanelActive(true)
									end

									return
								end)

								return
							end, var_8_5)

							return
						end, var_11_3)
					end
				elseif var_11_0.type == 5 then
					self:SetCharaMessageCardActive(var_11_1, {
						6
					})

					local var_11_7 = var_11_0.param

					for iter_11_0 in string.gmatch(var_11_0.param, "'%d+'") do
						var_11_7 = string.gsub(var_11_7, iter_11_0, "<color=#93e9ff>" .. var_0_1[tonumber((string.sub(iter_11_0, 2, #iter_11_0 - 1)))].name .. "</color>")
					end

					setText(arg_11_2:Find("charaMessageCard/systemTip/panel/Text"), var_11_7)

					if arg_8_3 and var_8_0 and arg_11_1 + 1 > var_8_0 then
						SetActive(arg_11_2, false)
						self:StartTimer(function()
							SetActive(arg_11_2, true)
							arg_11_2:Find("charaMessageCard/systemTip"):GetComponent(typeof(Animation)):Play("anim_newinstagram_tip_in")

							if arg_11_1 + 1 == #arg_8_2 then
								self:emit(Dorm3dChatMediator.SET_READED, arg_8_4, {
									arg_8_1.topicId
								})
							end

							Canvas.ForceUpdateCanvases()
							LeanTween.value(go(self.rightPanel:Find("messageScroll")), var_8_2.normalizedPosition.y, 0, 0.5):setOnUpdate(System.Action_float(var_8_3)):setEase(LeanTweenType.easeInOutCubic)
							self:SetEndAniEvent(arg_11_2:Find("charaMessageCard/systemTip"), function()
								if self.shouldShowOption and arg_11_1 + 1 == #arg_8_2 then
									self:SetOptionPanelActive(true)
								end

								return
							end)

							return
						end, var_11_3)
					end
				elseif var_11_0.type == 6 then
					self:SetCharaMessageCardActive(var_11_1, {
						8
					})
					setImageSprite(arg_11_2:Find("charaMessageCard/picture/mask/img"), LoadSprite("dorm3dprivatechat/" .. var_11_0.param), false)
					self:SetPicturePanel(arg_11_2:Find("charaMessageCard/picture/mask/img"), var_11_0.param)

					if arg_8_3 and var_8_0 and arg_11_1 + 1 > var_8_0 then
						SetActive(arg_11_2, false)
						self:StartTimer(function()
							SetActive(arg_11_2, true)
							arg_11_2:Find("charaMessageCard/charaBg"):GetComponent(typeof(Animation)):Play("anim_newinstagram_charabg")
							SetActive(arg_11_2:Find("charaMessageCard/waiting"), true)
							SetActive(arg_11_2:Find("charaMessageCard/picture"), false)
							Canvas.ForceUpdateCanvases()
							LeanTween.value(go(self.rightPanel:Find("messageScroll")), var_8_2.normalizedPosition.y, 0, 0.5):setOnUpdate(System.Action_float(var_8_3)):setEase(LeanTweenType.easeInOutCubic)
							self:StartTimer(function()
								SetActive(arg_11_2:Find("charaMessageCard/waiting"), false)
								SetActive(arg_11_2:Find("charaMessageCard/picture"), true)
								arg_11_2:Find("charaMessageCard/picture"):GetComponent(typeof(Animation)):Play("anim_newinstagram_emoji_in")

								if arg_11_1 + 1 == #arg_8_2 then
									self:emit(Dorm3dChatMediator.SET_READED, arg_8_4, {
										arg_8_1.topicId
									})
								end

								Canvas.ForceUpdateCanvases()
								LeanTween.value(go(self.rightPanel:Find("messageScroll")), var_8_2.normalizedPosition.y, 0, 0.5):setOnUpdate(System.Action_float(var_8_3)):setEase(LeanTweenType.easeInOutCubic)
								self:SetEndAniEvent(arg_11_2:Find("charaMessageCard/picture"), function()
									if self.shouldShowOption and arg_11_1 + 1 == #arg_8_2 then
										self:SetOptionPanelActive(true)
									end

									return
								end)

								return
							end, var_8_5)

							return
						end, var_11_3)
					end
				end
			else
				if var_11_0.type == 1 then
					self:SetPlayerMessageCardActive(var_11_2, {
						0
					})
					setText(arg_11_2:Find("playerReplyCard/msgBox/msg"), var_11_0.param)
				elseif var_11_0.type == 4 then
					self:SetPlayerMessageCardActive(var_11_2, {
						1
					})
					self:ClearEmoji(arg_11_2:Find("playerReplyCard/emoji/emoticon"))
					self:SetEmoji(arg_11_2:Find("playerReplyCard/emoji/emoticon"), var_0_3[tonumber(var_11_0.param)].pic)
				elseif var_11_0.type == 5 then
					self:SetPlayerMessageCardActive(var_11_2, {
						2
					})

					local var_11_8 = var_11_0.param

					for iter_11_1 in string.gmatch(var_11_0.param, "'%d+'") do
						var_11_8 = string.gsub(var_11_8, iter_11_1, "<color=#93e9ff>" .. var_0_1[tonumber((string.sub(iter_11_1, 2, #iter_11_1 - 1)))].name .. "</color>")
					end

					setText(arg_11_2:Find("playerReplyCard/systemTip/panel/Text"), var_11_8)
				end

				if arg_8_3 and var_8_0 and _.contains(var_8_1, arg_11_1 + 1) then
					if table.indexof(var_8_1, arg_11_1 + 1) < #var_8_1 then
						SetActive(arg_11_2, false)
						self:StartTimer(function()
							SetActive(arg_11_2, true)

							if var_11_0.type == 1 then
								arg_11_2:Find("playerReplyCard/msgBox"):GetComponent(typeof(Animation)):Play("anim_newinstagram_playerchat_common_in")
							elseif var_11_0.type == 4 then
								arg_11_2:Find("playerReplyCard/emoji"):GetComponent(typeof(Animation)):Play("anim_newinstagram_emoji_in")
							elseif var_11_0.type == 5 then
								arg_11_2:Find("playerReplyCard/systemTip"):GetComponent(typeof(Animation)):Play("anim_newinstagram_tip_in")
							end

							if arg_11_1 + 1 == #arg_8_2 then
								self:emit(Dorm3dChatMediator.SET_READED, arg_8_4, {
									arg_8_1.topicId
								})
							end

							Canvas.ForceUpdateCanvases()
							LeanTween.value(go(self.rightPanel:Find("messageScroll")), var_8_2.normalizedPosition.y, 0, 0.5):setOnUpdate(System.Action_float(var_8_3)):setEase(LeanTweenType.easeInOutCubic)

							return
						end, (#var_8_1 - table.indexof(var_8_1, arg_11_1 + 1)) * var_8_6)
					else
						if var_11_0.type == 1 then
							arg_11_2:Find("playerReplyCard/msgBox"):GetComponent(typeof(Animation)):Play("anim_newinstagram_playerchat_common_in")
						elseif var_11_0.type == 4 then
							arg_11_2:Find("playerReplyCard/emoji"):GetComponent(typeof(Animation)):Play("anim_newinstagram_emoji_in")
						elseif var_11_0.type == 5 then
							arg_11_2:Find("playerReplyCard/systemTip"):GetComponent(typeof(Animation)):Play("anim_newinstagram_tip_in")
						end

						if arg_11_1 + 1 == #arg_8_2 then
							self:emit(Dorm3dChatMediator.SET_READED, arg_8_4, {
								arg_8_1.topicId
							})
						end
					end
				end
			end

			if not arg_8_1:isWaiting() and arg_11_1 + 1 == #arg_8_2 then
				if arg_8_3 then
					if var_11_0.ship_group ~= 0 then
						self:StartTimer(function()
							setActive(arg_11_2:Find("end"), true)

							return
						end, var_11_3 + var_8_4)
					else
						self:StartTimer(function()
							setActive(arg_11_2:Find("end"), true)

							return
						end, (#var_8_1 - table.indexof(var_8_1, arg_11_1 + 1)) * var_8_6 + var_8_6)
					end
				else
					setActive(arg_11_2:Find("end"), true)
				end
			else
				setActive(arg_11_2:Find("end"), false)
			end
		end

		return
	end)
	self.messageList:align(#arg_8_2)

	if arg_8_3 then
		Canvas.ForceUpdateCanvases()
		LeanTween.value(go(self.rightPanel:Find("messageScroll")), var_8_2.normalizedPosition.y, 0, 0.5):setOnUpdate(System.Action_float(var_8_3)):setEase(LeanTweenType.easeInOutCubic)
	else
		scrollToBottom(self.rightPanel:Find("messageScroll"))
	end

	return
end

function Dorm3dChatLayer:SetCharaMessageCardActive(arg_35_1, arg_35_2)
	if _.contains(arg_35_2, 6) then
		SetActive(arg_35_1:GetChild(0), false)
	else
		SetActive(arg_35_1:GetChild(0), true)
	end

	for iter_35_0 = 1, arg_35_1.childCount - 1 do
		if _.contains(arg_35_2, iter_35_0) then
			SetActive(arg_35_1:GetChild(iter_35_0), true)
		else
			SetActive(arg_35_1:GetChild(iter_35_0), false)
		end
	end

	return
end

function Dorm3dChatLayer:SetPlayerMessageCardActive(arg_36_1, arg_36_2)
	for iter_36_0 = 0, arg_36_1.childCount - 1 do
		if _.contains(arg_36_2, iter_36_0) then
			SetActive(arg_36_1:GetChild(iter_36_0), true)
		else
			SetActive(arg_36_1:GetChild(iter_36_0), false)
		end
	end

	return
end

function Dorm3dChatLayer:SetEmoji(arg_37_1, arg_37_2)
	PoolMgr.GetInstance():GetPrefab("emoji/" .. arg_37_2, arg_37_2, true, function(arg_38_0)
		if not IsNil(arg_37_1) then
			arg_38_0.name = arg_37_2
			tf(arg_38_0).sizeDelta = arg_37_1.sizeDelta
			tf(arg_38_0).anchoredPosition = Vector2.zero

			local var_38_0 = arg_38_0:GetComponent("Animator")

			if var_38_0 then
				var_38_0.enabled = true
			end

			setParent(arg_38_0, arg_37_1, false)
		else
			PoolMgr.GetInstance():ReturnPrefab("emoji/" .. arg_37_2, arg_37_2, arg_38_0)
		end

		return
	end)

	return
end

function Dorm3dChatLayer:ClearEmoji(arg_39_1)
	eachChild(arg_39_1, function(arg_40_0)
		local var_40_0 = go(arg_40_0)

		PoolMgr.GetInstance():ReturnPrefab("emoji/" .. var_40_0.name, var_40_0.name, var_40_0)

		return
	end)

	return
end

function Dorm3dChatLayer:UpdateOptionPanel(arg_41_1, arg_41_2)
	local var_41_0 = arg_41_2[#arg_41_2].option

	if arg_41_2[#arg_41_2].option and type(arg_41_2[#arg_41_2].option) == "table" then
		self.shouldShowOption = true
		self.optionCount = #arg_41_2[#arg_41_2].option

		self:SetOptionPanelActive(true)
		self.optionList:make(function(arg_42_0, arg_42_1, arg_42_2)
			if arg_42_0 == UIItemList.EventUpdate then
				local var_42_0 = var_41_0[arg_42_1 + 1]

				setText(arg_42_2:Find("Text"), HXSet.hxLan(var_41_0[arg_42_1 + 1][2]))
				onButton(self, arg_42_2, function()
					self:emit(Dorm3dChatMediator.REPLY, arg_41_1.characterId, arg_41_1.topicId, arg_41_2[#arg_41_2].id, var_42_0[1])

					return
				end, SFX_PANEL)
			end

			return
		end)
		self.optionList:align(#arg_41_2[#arg_41_2].option)
	else
		self:SetOptionPanelActive(false)

		self.shouldShowOption = false
	end

	return
end

function Dorm3dChatLayer:SetOptionPanelActive(arg_44_1)
	SetActive(self.optionPanel, arg_44_1)

	local var_44_0 = self.rightPanel:Find("messageScroll/Viewport/Content"):GetComponent(typeof(VerticalLayoutGroup))
	local var_44_1 = UnityEngine.RectOffset.New()

	var_44_1.left = 0
	var_44_1.right = 0
	var_44_1.top = 0

	local var_44_2 = self.rightPanel:Find("messageScroll/Scrollbar Vertical"):GetComponent(typeof(RectTransform))

	if arg_44_1 then
		var_44_1.bottom = 42 + 88 * self.optionCount
		var_44_2.sizeDelta = Vector2(self.messageScrollWidth, -var_44_1.bottom)
	else
		var_44_1.bottom = 50
		var_44_2.sizeDelta = Vector2(self.messageScrollWidth, 0)
	end

	var_44_0.padding = var_44_1

	scrollToBottom(self.rightPanel:Find("messageScroll"))

	return
end

function Dorm3dChatLayer:SetTopicPanel(arg_45_1)
	SetActive(self.topicBtn:Find("tip"), arg_45_1:GetCharacterEndFlagExceptCurrent() == 0)
	onButton(self, self.topicBtn, function()
		SetActive(self.topicUI, true)
		pg.UIMgr.GetInstance():BlurPanel(self.topicUI)

		self.currentTopic = nil

		local var_46_0 = UIItemList.New(self.topicUI:Find("panel/topicScroll/Viewport/Content"), self.topicUI:Find("panel/topicScroll/Viewport/Content/topic"))

		var_46_0:make(function(arg_47_0, arg_47_1, arg_47_2)
			if arg_47_0 == UIItemList.EventUpdate then
				arg_45_1:SortTopicList()

				local var_47_0 = arg_45_1.topics[arg_47_1 + 1]

				setScrollText(arg_47_2:Find("mask/name"), HXSet.hxLan(arg_45_1.topics[arg_47_1 + 1].name))
				SetActive(arg_47_2:Find("lock"), not var_47_0.active)
				SetActive(arg_47_2:Find("waiting"), var_47_0.active and var_47_0:isWaiting())
				SetActive(arg_47_2:Find("complete"), var_47_0.active and var_47_0:IsCompleted())
				SetActive(arg_47_2:Find("selectedFrame"), arg_45_1.currentTopicId == var_47_0.topicId)
				SetActive(arg_47_2:Find("selected"), arg_45_1.currentTopicId == var_47_0.topicId)
				SetActive(arg_47_2:Find("tip"), var_47_0.active and not var_47_0:IsCompleted())

				if arg_45_1.currentTopicId == var_47_0.topicId then
					self.currentTopic = var_47_0
				end

				if var_47_0.active then
					onButton(self, arg_47_2, function()
						SetActive(arg_47_2:Find("selectedFrame"), true)

						for iter_48_0 = 1, #arg_45_1.topics do
							if iter_48_0 ~= arg_47_1 + 1 then
								SetActive(self.topicUI:Find("panel/topicScroll/Viewport/Content"):GetChild(iter_48_0 - 1):Find("selectedFrame"), false)
							end
						end

						self.currentTopic = var_47_0

						return
					end, SFX_PANEL)
				else
					onButton(self, arg_47_2, function()
						pg.TipsMgr.GetInstance():ShowTips(var_47_0.unlockDesc)

						return
					end, SFX_PANEL)
				end
			end

			return
		end)
		var_46_0:align(#arg_45_1.topics)

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
		self:emit(Dorm3dChatMediator.SET_CURRENT_TOPIC, self.currentTopic.characterId, self.currentTopic.topicId)
		self:CloseTopicPanel()

		local var_52_0 = self.rightPanel:GetComponent(typeof(Animation))

		var_52_0:Stop()
		var_52_0:Play("anim_newinstagram_chat_right_in")

		return
	end, SFX_PANEL)

	return
end

function Dorm3dChatLayer:CloseTopicPanel()
	pg.UIMgr.GetInstance():UnOverlayPanel(self.topicUI, self._tf:Find("subPages"))
	SetActive(self.topicUI, false)

	return
end

function Dorm3dChatLayer:SetBackgroundPanel(arg_54_1)
	local var_54_0 = arg_54_1:GetPaintingId()

	onButton(self, self.backgroundBtn, function()
		SetActive(self.backgroundUI, true)
		pg.UIMgr.GetInstance():BlurPanel(self.backgroundUI)

		self.currentBgId = nil

		local var_55_0 = arg_54_1:GetSkins()
		local var_55_1 = UIItemList.New(self.backgroundUI:Find("panel/backgroundScroll/Viewport/Content"), self.backgroundUI:Find("panel/backgroundScroll/Viewport/Content/background"))

		var_55_1:make(function(arg_56_0, arg_56_1, arg_56_2)
			if arg_56_0 == UIItemList.EventUpdate then
				local var_56_0 = 0

				if var_55_0[arg_56_1 + 1].id ~= var_54_0 then
					var_56_0 = var_55_0[arg_56_1 + 1].id
				end

				LoadImageSpriteAsync("herohrzicon/" .. var_55_0[arg_56_1 + 1].painting, arg_56_2:Find("skinMask/skin"), false)
				setScrollText(arg_56_2:Find("skinMask/Panel/mask/Text"), var_55_0[arg_56_1 + 1].name)

				local var_56_1 = getProxy(ShipSkinProxy):hasSkin(var_55_0[arg_56_1 + 1].id)

				var_56_1 = var_56_1 or var_55_0[arg_56_1 + 1].skin_type == ShipSkin.SKIN_TYPE_DEFAULT or var_55_0[arg_56_1 + 1].skin_type == ShipSkin.SKIN_TYPE_PROPOSE or var_55_0[arg_56_1 + 1].skin_type == ShipSkin.SKIN_TYPE_REMAKE

				SetActive(arg_56_2:Find("lockFrame"), not var_56_1)
				SetActive(arg_56_2:Find("selectedFrame"), arg_54_1.skinId == var_56_0)
				SetActive(arg_56_2:Find("selected"), arg_54_1.skinId == var_56_0)

				if arg_54_1.skinId == var_56_0 then
					self.currentBgId = var_56_0
				end

				onButton(self, arg_56_2, function()
					if var_56_1 then
						SetActive(arg_56_2:Find("selectedFrame"), true)

						for iter_57_0 = 1, #var_55_0 do
							if iter_57_0 ~= arg_56_1 + 1 then
								SetActive(self.backgroundUI:Find("panel/backgroundScroll/Viewport/Content"):GetChild(iter_57_0 - 1):Find("selectedFrame"), false)
							end
						end

						self.currentBgId = var_56_0
					else
						pg.TipsMgr.GetInstance():ShowTips(i18n("juuschat_background_tip2"))
					end

					return
				end, SFX_PANEL)
			end

			return
		end)
		var_55_1:align(#var_55_0)

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
		self:emit(Dorm3dChatMediator.SET_CURRENT_BACKGROUND, arg_54_1.characterId, self.currentBgId)
		self:CloseBackgroundPanel()

		return
	end, SFX_PANEL)

	return
end

function Dorm3dChatLayer:CloseBackgroundPanel()
	pg.UIMgr.GetInstance():UnOverlayPanel(self.backgroundUI, self._tf:Find("subPages"))
	SetActive(self.backgroundUI, false)

	return
end

function Dorm3dChatLayer:SetRedPacketPanel(arg_62_1, arg_62_2, arg_62_3, arg_62_4, arg_62_5, arg_62_6, arg_62_7)
	onButton(self, arg_62_1, function()
		SetActive(self.redPacketUI, true)
		pg.UIMgr.GetInstance():BlurPanel(self.redPacketUI)
		setImageSprite(self.redPacketUI:Find("panel/charaBg/chara"), LoadSprite("qicon/" .. arg_62_4), false)

		if not arg_62_3 then
			SetActive(self.redPacketUI:Find("panel/get"), true)
			SetActive(self.redPacketUI:Find("panel/got"), false)
			SetActive(self.redPacketUI:Find("panel/detail"), false)
			setText(self.redPacketUI:Find("panel/get/titleBg/title"), arg_62_2.desc)
			onButton(self, self.redPacketUI:Find("panel/get/getBtn"), function()
				self:emit(Dorm3dChatMediator.GET_REDPACKET, arg_62_5, arg_62_6, arg_62_7, arg_62_2.id)

				return
			end, SFX_PANEL)
		else
			self:UpdateRedPacketUI(arg_62_2.id)
		end

		return
	end, SFX_PANEL)
	onButton(self, self.redPacketUI:Find("bg"), function()
		self:CloseRedPacketPanel()

		if self.canFresh then
			self.canFresh = false

			local var_65_0 = self.currentChat.currentTopic:GetDisplayWordList()

			if var_65_0[#var_65_0].type == 0 then
				self:UpdateChat(false, false)
			else
				self:UpdateChat(true, false)
			end
		end

		return
	end, SFX_PANEL)

	return
end

function Dorm3dChatLayer:UpdateRedPacketUI(arg_66_1)
	SetActive(self.redPacketUI:Find("panel/get"), false)
	SetActive(self.redPacketUI:Find("panel/got"), true)
	SetActive(self.redPacketUI:Find("panel/detail"), false)

	local var_66_0 = Drop.Create(var_0_2[arg_66_1].content)

	var_66_0.count = 0

	updateDrop(self.redPacketUI:Find("panel/got/item"), var_66_0)
	onButton(self, self.redPacketUI:Find("panel/got/item"), function()
		self:emit(BaseUI.ON_DROP, var_66_0)

		return
	end, SFX_PANEL)

	self.redPacketUI:Find("panel/got/item/icon_bg"):GetComponent(typeof(Image)).enabled = false
	self.redPacketUI:Find("panel/got/item/icon_bg/frame"):GetComponent(typeof(Image)).enabled = false

	setText(self.redPacketUI:Find("panel/got/awardCount"), var_0_2[arg_66_1].content[3])

	return
end

function Dorm3dChatLayer:CloseRedPacketPanel()
	pg.UIMgr.GetInstance():UnOverlayPanel(self.redPacketUI, self._tf:Find("subPages"))
	SetActive(self.redPacketUI, false)

	return
end

function Dorm3dChatLayer:SetPicturePanel(arg_69_1, arg_69_2)
	onButton(self, arg_69_1, function()
		setActive(self.pictureUI, true)
		pg.UIMgr.GetInstance():BlurPanel(self.pictureUI)
		setImageSprite(self.pictureUI:Find("picture"), LoadSprite("dorm3dprivatechat/" .. arg_69_2), true)

		return
	end, SFX_PANEL)
	onButton(self, self.pictureUI:Find("bg"), function()
		self:ClosePicturePanel()

		return
	end, SFX_PANEL)
	onButton(self, self.pictureUI:Find("closeBtn"), function()
		self:ClosePicturePanel()

		return
	end, SFX_PANEL)

	return
end

function Dorm3dChatLayer:ClosePicturePanel()
	pg.UIMgr.GetInstance():UnOverlayPanel(self.pictureUI, self._tf:Find("subPages"))
	SetActive(self.pictureUI, false)

	return
end

function Dorm3dChatLayer:SetData()
	self.currentChat = getProxy(Dorm3dChatProxy):GetCharacterChatById(self.contextData.chatId)

	getProxy(Dorm3dChatProxy):AutoChangeCurrentTopic(self.currentChat)

	return
end

function Dorm3dChatLayer:willExit()
	if self.paintingName then
		retPaintingPrefab(self.rightPanel:Find("paintingMask/painting"), self.paintingName)

		self.paintingName = nil
	end

	self:RemoveAllTimer()

	return
end

function Dorm3dChatLayer:StartTimer(arg_76_1, arg_76_2)
	local var_76_0 = Timer.New(arg_76_1, arg_76_2, 1)

	var_76_0:Start()
	table.insert(self.timerList, var_76_0)

	return
end

function Dorm3dChatLayer:RemoveAllTimer()
	for iter_77_0, iter_77_1 in ipairs(self.timerList) do
		iter_77_1:Stop()
	end

	self.timerList = {}

	return
end

function Dorm3dChatLayer:StartTimer2(arg_78_1, arg_78_2)
	self.timer = Timer.New(arg_78_1, arg_78_2, 1)

	self.timer:Start()

	return
end

function Dorm3dChatLayer:SpeedUpMessage()
	for iter_79_0, iter_79_1 in ipairs(self.timerList) do
		if iter_79_1.running then
			if iter_79_1.duration == pg.gameset.juuschat_entering_time.key_value / 1000 then
				iter_79_1.time = 0.05
			elseif iter_79_1.time - pg.gameset.juuschat_dialogue_trigger_time.key_value / 1000 < 0.05 then
				iter_79_1.time = 0.05

				self:StartTimer2(function()
					self:SpeedUpWaiting()

					return
				end, 0.05)
			else
				iter_79_1.time = iter_79_1.time - pg.gameset.juuschat_dialogue_trigger_time.key_value / 1000
			end
		end
	end

	return
end

function Dorm3dChatLayer:SpeedUpWaiting()
	for iter_81_0, iter_81_1 in ipairs(self.timerList) do
		if iter_81_1.running and iter_81_1.duration == pg.gameset.juuschat_entering_time.key_value / 1000 then
			iter_81_1.time = 0.05

			break
		end
	end

	return
end

function Dorm3dChatLayer:ChangeFresh()
	self.canFresh = true

	return
end

function Dorm3dChatLayer:SetEndAniEvent(arg_83_1, arg_83_2)
	local var_83_0 = arg_83_1:GetComponent(typeof(DftAniEvent))

	if var_83_0 then
		var_83_0:SetEndEvent(function()
			arg_83_2()
			var_83_0:SetEndEvent(nil)

			return
		end)
	end

	return
end

function Dorm3dChatLayer:onBackPressed()
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

	if isActive(self.pictureUI) then
		self:ClosePicturePanel()

		return
	end

	self:closeView()

	return
end

return Dorm3dChatLayer
