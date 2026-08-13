class = var_0_10000

local var_0_0 = "Dorm3dChatLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))

pg = var_0_0

local var_0_2 = var_0_0.dorm3d_ins_ship_group_template

pg = var_2

local var_0_3 = var_2.dorm3d_ins_redpackage

pg = var_3

local var_0_4 = var_3.emoji_template

function var_0_1.getUIName(arg_1_0)
	return "Dorm3dChatUI"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.rightPanel = var_1.Find(var_2_0, "main/rightPanel")

	local var_2_1 = arg_2_0.rightPanel

	arg_2_0.characterName = var_1.Find(var_2_1, "rightTop/name")

	local var_2_2 = arg_2_0.rightPanel

	arg_2_0.careBtn = var_1.Find(var_2_2, "rightTop/careBtn")

	local var_2_3 = arg_2_0.rightPanel

	arg_2_0.topicBtn = var_1.Find(var_2_3, "rightTop/topicBtn")

	local var_2_4 = arg_2_0.rightPanel

	arg_2_0.backgroundBtn = var_1.Find(var_2_4, "rightTop/backgroundBtn")
	UIItemList = var_1

	local var_2_5 = var_1.New
	local var_2_6 = arg_2_0.rightPanel
	local var_2_7 = var_2.Find(var_2_6, "messageScroll/Viewport/Content")
	local var_2_8 = arg_2_0.rightPanel

	arg_2_0.messageList = var_2_5(var_2_7, var_3.Find(var_2_8, "messageScroll/Viewport/Content/messageCard"))

	local var_2_9 = arg_2_0.rightPanel

	arg_2_0.optionPanel = var_1.Find(var_2_9, "optionPanel")
	UIItemList = var_1

	local var_2_10 = var_1.New
	local var_2_11 = arg_2_0.optionPanel
	local var_2_12 = arg_2_0.optionPanel

	arg_2_0.optionList = var_2_10(var_2_11, var_3.Find(var_2_12, "option"))

	local var_2_13 = arg_2_0._tf

	arg_2_0.topicUI = var_1.Find(var_2_13, "subPages/InstagramTopicUI")

	local var_2_14 = arg_2_0._tf

	arg_2_0.backgroundUI = var_1.Find(var_2_14, "subPages/InstagramBackgroundUI")

	local var_2_15 = arg_2_0._tf

	arg_2_0.redPacketUI = var_1.Find(var_2_15, "subPages/InstagramRedPacketUI")

	local var_2_16 = arg_2_0._tf

	arg_2_0.pictureUI = var_1.Find(var_2_16, "subPages/PictureUI")
	setText = var_1

	local var_2_17 = arg_2_0.topicUI
	local var_2_18 = var_2.Find(var_2_17, "panel/topicScroll/Viewport/Content/topic/waiting")

	i18n = var_2_17

	var_1(var_2_18, var_2_17("juuschat_chattip3"))

	setText = var_1

	local var_2_19 = arg_2_0.topicUI
	local var_2_20 = var_2.Find(var_2_19, "panel/topicScroll/Viewport/Content/topic/selected/Text")

	i18n = var_2_19

	var_1(var_2_20, var_2_19("juuschat_label2"))

	setText = var_1

	local var_2_21 = arg_2_0.backgroundUI
	local var_2_22 = var_2.Find(var_2_21, "panel/backgroundScroll/Viewport/Content/background/selected/Text")

	i18n = var_2_21

	var_1(var_2_22, var_2_21("juuschat_label1"))

	setText = var_1

	local var_2_23 = arg_2_0.backgroundUI
	local var_2_24 = var_2.Find(var_2_23, "panel/backgroundScroll/Viewport/Content/background/lockFrame/Text")

	i18n = var_2_23

	var_1(var_2_24, var_2_23("juuschat_background_tip1"))

	local var_2_25 = arg_2_0.redPacketUI

	arg_2_0.redPacketGot = var_1.Find(var_2_25, "panel/got")

	local var_2_26 = arg_2_0.rightPanel

	arg_2_0.noMessage = var_1.Find(var_2_26, "noMessage")
	setText = var_1

	local var_2_27 = arg_2_0.noMessage
	local var_2_28 = var_2.Find(var_2_27, "Text")

	i18n = var_2_27

	var_1(var_2_28, var_2_27("dorm3d_ins_no_topics"))

	SetActive = var_1

	var_1(arg_2_0.topicUI, false)

	SetActive = var_1

	var_1(arg_2_0.backgroundUI, false)

	SetActive = var_1

	var_1(arg_2_0.redPacketUI, false)

	SetActive = var_1

	var_1(arg_2_0.pictureUI, false)

	arg_2_0.timerList = {}
	arg_2_0.canFresh = false

	local var_2_29 = arg_2_0.rightPanel
	local var_2_30 = var_1.Find(var_2_29, "messageScroll/Scrollbar Vertical")
	local var_2_31 = var_1.GetComponent

	typeof = var_3
	RectTransform = var_4
	arg_2_0.messageScrollWidth = var_2_31(var_2_30, var_3(var_4)).rect.width
	arg_2_0.messageScrollHeight = var_1.rect.height

	local var_2_32 = arg_2_0.topicUI
	local var_2_33 = var_2.Find(var_2_32, "panel/title")
	local var_2_34 = var_2.GetComponent

	typeof = var_4
	Image = var_5

	local var_2_35 = var_2_34(var_2_33, var_4(var_5))

	var_2.SetNativeSize(var_2_35)

	local var_2_36 = arg_2_0.backgroundUI
	local var_2_37 = var_2.Find(var_2_36, "panel/title")
	local var_2_38 = var_2.GetComponent

	typeof = var_4
	Image = var_5

	local var_2_39 = var_2_38(var_2_37, var_4(var_5))

	var_2.SetNativeSize(var_2_39)

	onButton = var_2

	local var_2_40 = arg_2_0
	local var_2_41 = arg_2_0.rightPanel
	local var_2_42 = var_4.Find(var_2_41, "closeBtn")

	local function var_2_43()
		local var_3_0 = arg_2_0

		var_0.closeView(var_3_0)

		return
	end

	SFX_PANEL = var_6

	var_2(var_2_40, var_2_42, var_2_43, var_6)
	arg_2_0:OverlayPanel(arg_2_0._tf)

	return
end

function var_0_1.didEnter(arg_4_0)
	arg_4_0:SetData()
	arg_4_0:UpdateChat(false, false)

	return
end

function var_0_1.UpdateChat(arg_5_0, arg_5_1, arg_5_2)
	SetActive = var_1_10003

	var_1_10003(arg_5_0.rightPanel, true)
	arg_5_0:UpdateChatContent(arg_5_1, arg_5_2)
	arg_5_0:SetTopicPanel(arg_5_0.currentChat)
	arg_5_0:SetBackgroundPanel(arg_5_0.currentChat)

	if not arg_5_1 then
		local var_5_0 = arg_5_0.rightPanel
		local var_5_1 = var_3.GetComponent

		typeof = var_5
		Animation = var_6

		local var_5_2 = var_5_1(var_5_0, var_5(var_6))

		var_3.Stop(var_5_2)
		var_3:Play("anim_newinstagram_chat_right_in")
	end

	return
end

function var_0_1.UpdateChatContent(arg_6_0, arg_6_1, arg_6_2)
	SetActive = var_1_10003

	var_1_10003(arg_6_0.rightPanel, true)

	setText = var_1_10003

	var_1_10003(arg_6_0.characterName, arg_6_0.currentChat.name)

	local var_6_0 = arg_6_0.careBtn
	local var_6_1 = var_3.Find(var_6_0, "care")

	SetActive = var_6_0

	var_6_0(var_6_1, arg_6_0.currentChat.care == 1)

	onButton = var_6_0

	local var_6_2 = arg_6_0
	local var_6_3 = arg_6_0.careBtn

	local function var_6_4()
		local var_7_0 = arg_6_0.currentChat.care == 0 and 1 or 0
		local var_7_1 = arg_6_0
		local var_7_2 = var_2.emit

		Dorm3dChatMediator = var_2_10004

		var_7_2(var_7_1, var_2_10004.CHANGE_CARE, arg_6_0.currentChat.characterId, var_7_0)

		return
	end

	SFX_PANEL = var_1_10008

	var_6_0(var_6_2, var_6_3, var_6_4, var_1_10008)

	local var_6_5 = arg_6_0.rightPanel
	local var_6_6 = var_4.Find(var_6_5, "paintingMask")
	local var_6_7 = var_4.Find(var_6_6, "painting")
	local var_6_8 = arg_6_0.rightPanel
	local var_6_9 = var_6.Find(var_6_8, "groupBackground")
	local var_6_10

	if not arg_6_0.currentChat.groupBackground or arg_6_0.currentChat.groupBackground == "" then
		SetActive = var_6_10

		var_6_10(var_4, true)

		SetActive = var_6_10

		var_6_10(var_6_9, false)

		var_6_10 = "unknown"

		if arg_6_0.currentChat.skinId == 0 then
			local var_6_11 = arg_6_0.currentChat

			var_6_10 = var_8.GetPainting(var_6_11)
		else
			ipairs = var_8

			for iter_6_0, iter_6_1 in var_8(arg_6_0.currentChat.skins) do
				if iter_6_1.id == arg_6_0.currentChat.skinId then
					var_6_10 = iter_6_1.painting
				end
			end
		end

		if not arg_6_0.paintingName then
			setPaintingPrefabAsync = var_8

			var_8(var_6_7, var_6_10, "pifu")

			arg_6_0.paintingName = var_6_10
		elseif arg_6_0.paintingName and arg_6_0.paintingName ~= var_6_10 then
			retPaintingPrefab = var_8

			var_8(var_6_7, arg_6_0.paintingName)

			setPaintingPrefabAsync = var_8

			var_8(var_6_7, var_6_10, "pifu")

			arg_6_0.paintingName = var_6_10
		end
	else
		SetActive = var_6_10

		var_6_10(var_4, false)

		SetActive = var_6_10

		var_6_10(var_6_9, true)

		if arg_6_0.paintingName then
			retPaintingPrefab = var_6_10

			var_6_10(var_6_7, arg_6_0.paintingName)

			arg_6_0.paintingName = nil
		end

		setImageSprite = var_6_10

		local var_6_12 = var_6_9

		LoadSprite = var_9

		var_6_10(var_6_12, var_9("ui/" .. arg_6_0.currentChat.groupBackground), true)
	end

	setActive = var_6_10

	local var_6_13 = arg_6_0.rightPanel

	var_6_10(var_8.Find(var_6_13, "messageScroll"), arg_6_0.currentChat.currentTopic)

	setActive = var_6_10

	var_6_10(var_4, arg_6_0.currentChat.currentTopic)

	setActive = var_6_10

	var_6_10(arg_6_0.noMessage, not arg_6_0.currentChat.currentTopic)

	if not arg_6_0.currentChat.currentTopic then
		return
	end

	local var_6_14 = arg_6_0.currentChat.currentTopic
	local var_6_15 = var_7.GetDisplayWordList(var_6_14)

	if not arg_6_2 then
		arg_6_0:UpdateOptionPanel(arg_6_0.currentChat.currentTopic, var_6_15)
		arg_6_0:UpdateMessageList(arg_6_0.currentChat.currentTopic, var_6_15, arg_6_1, arg_6_0.currentChat.characterId)
	end

	if not arg_6_1 and arg_6_0.currentChat.currentTopic.readFlag == 0 then
		local var_6_16 = arg_6_0
		local var_6_17 = arg_6_0.emit

		Dorm3dChatMediator = var_10

		var_6_17(var_6_16, var_10.SET_READED, arg_6_0.currentChat.characterId, {
			arg_6_0.currentChat.currentTopic.topicId
		})
	end

	return
end

function var_0_1.UpdateMessageList(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	arg_8_0:RemoveAllTimer()

	local var_8_0

	for iter_8_0 = #arg_8_2, 1, -1 do
		if arg_8_2[iter_8_0].ship_group ~= 0 then
			if arg_8_2[iter_8_0].type == 3 then
				local var_8_1 = arg_8_1
				local var_8_2 = arg_8_1.RedPacketGotFlag

				tonumber = var_1_10012

				if var_8_2(var_8_1, var_1_10012(arg_8_2[iter_8_0].param)) then
					var_8_0 = iter_8_0

					break
				end
			end
		end
	end

	local var_8_3 = {}

	if var_8_0 then
		for iter_8_1 = var_8_0, 1, -1 do
			if arg_8_2[iter_8_1].ship_group == 0 then
				table = var_11

				var_11.insert(var_8_3, iter_8_1)
			else
				break
			end
		end
	end

	if arg_8_0.shouldShowOption and arg_8_3 then
		arg_8_0:SetOptionPanelActive(false)
	end

	if arg_8_3 then
		onButton = var_7

		local var_8_4 = arg_8_0
		local var_8_5 = arg_8_0.rightPanel
		local var_8_6 = var_9.Find(var_8_5, "messageScroll")

		local function var_8_7()
			local var_9_0 = arg_8_0

			var_0.SpeedUpMessage(var_9_0)

			return
		end

		SFX_PANEL = var_11

		var_7(var_8_4, var_8_6, var_8_7, var_11)
	end

	GetComponent = var_7

	local var_8_8 = arg_8_0.rightPanel
	local var_8_9 = var_8.Find(var_8_8, "messageScroll")

	typeof = var_8_8
	ScrollRect = var_10

	local var_8_10 = var_7(var_8_9, var_8_8(var_10))

	local function var_8_11(arg_10_0)
		Vector2 = var_2_10001

		local var_10_0 = var_2_10001(0, arg_10_0)

		var_8_10.normalizedPosition = var_10_0

		return
	end

	pg = var_9

	local var_8_12 = var_9.gameset.juuschat_dialogue_trigger_time.key_value / 1000

	pg = var_10

	local var_8_13 = var_8_12 - var_10.gameset.juuschat_entering_time.key_value / 1000

	arg_8_0.playbackInfos = {}

	local var_8_14 = arg_8_0.messageList

	var_12.make(var_8_14, function(arg_11_0, arg_11_1, arg_11_2)
		UIItemList = var_2_10003

		if arg_11_0 == var_2_10003.EventUpdate then
			if arg_8_2[arg_11_1 + 1].ship_group == 0 and var_3.type == 0 then
				SetActive = var_4

				var_4(arg_11_2, false)

				return
			end

			local var_11_0 = arg_11_2:Find("charaMessageCard")
			local var_11_1 = arg_11_2
			local var_11_2 = arg_11_2.Find(var_11_1, "playerReplyCard")

			SetActive = var_11_1

			var_11_1(var_11_0, var_3.ship_group ~= 0)

			SetActive = var_11_1

			var_11_1(var_11_2, var_3.ship_group == 0)

			SetActive = var_11_1

			var_11_1(arg_11_2:Find("nameBar"), false)

			local var_11_3

			if arg_8_3 and var_8_0 and arg_11_1 + 1 > var_8_0 then
				var_11_3 = (arg_11_1 + 1 - var_8_0) * var_8_12 - var_0

				if #var_8_3 > 1 then
					var_11_3 = var_11_3 + (#var_8_3 - 1) * var_8_13
				end
			end

			if var_3.ship_group ~= 0 then
				local var_11_4 = "unknown"

				if var_0_2[var_3.ship_group] then
					var_11_4 = var_0_2[var_3.ship_group].sculpture
				end

				if var_3.type ~= 5 then
					setImageSprite = var_8
					var_2_10010 = arg_11_2

					local var_11_5 = arg_11_2.Find(var_2_10010, "charaMessageCard/charaBg/chara")

					LoadSprite = var_2_10010

					var_8(var_11_5, var_2_10010("qicon/" .. var_11_4), false)
				end

				if var_3.type == 1 then
					local var_11_6 = arg_8_0

					var_8.SetCharaMessageCardActive(var_11_6, var_11_0, {
						3
					})

					setText = var_8
					var_2_10010 = arg_11_2

					var_8(arg_11_2.Find(var_2_10010, "charaMessageCard/msgBox/msg"), var_3.param)

					if arg_8_3 and var_8_0 and arg_11_1 + 1 > var_8_0 then
						SetActive = var_8

						var_8(arg_11_2, false)

						local var_11_7 = arg_8_0

						var_8.StartTimer(var_11_7, function()
							SetActive = var_3_10000

							var_3_10000(arg_11_2, true)

							local var_12_0 = arg_11_2
							local var_12_1 = var_0.Find(var_12_0, "charaMessageCard/charaBg")
							local var_12_2 = var_0.GetComponent

							typeof = var_2
							Animation = var_3_10003

							local var_12_3 = var_12_2(var_12_1, var_2(var_3_10003))

							var_0.Play(var_12_3, "anim_newinstagram_charabg")

							SetActive = var_0

							local var_12_4 = arg_11_2

							var_0(var_1.Find(var_12_4, "charaMessageCard/waiting"), true)

							SetActive = var_0

							local var_12_5 = arg_11_2

							var_0(var_1.Find(var_12_5, "charaMessageCard/msgBox"), false)

							Canvas = var_0

							var_0.ForceUpdateCanvases()

							LeanTween = var_0

							local var_12_6 = var_0.value

							go = var_1

							local var_12_7 = arg_8_0.rightPanel
							local var_12_8 = var_12_6(var_1(var_2.Find(var_12_7, "messageScroll")), var_8_10.normalizedPosition.y, 0, 0.5)
							local var_12_9 = var_0.setOnUpdate

							System = var_2

							local var_12_10 = var_12_9(var_12_8, var_2.Action_float(var_8_11))
							local var_12_11 = var_0.setEase

							LeanTweenType = var_2

							var_12_11(var_12_10, var_2.easeInOutCubic)

							local var_12_12 = arg_8_0

							var_0.StartTimer(var_12_12, function()
								SetActive = var_4_10000

								local var_13_0 = arg_11_2

								var_4_10000(var_1.Find(var_13_0, "charaMessageCard/waiting"), false)

								SetActive = var_4_10000

								local var_13_1 = arg_11_2

								var_4_10000(var_1.Find(var_13_1, "charaMessageCard/msgBox"), true)

								local var_13_2 = arg_11_2
								local var_13_3 = var_0.Find(var_13_2, "charaMessageCard/msgBox")
								local var_13_4 = var_0.GetComponent

								typeof = var_2
								Animation = var_3

								local var_13_5 = var_13_4(var_13_3, var_2(var_3))

								var_0.Play(var_13_5, "anim_newinstagram_chat_common_in")

								local var_13_6, var_13_7

								if arg_11_1 + 1 == #arg_8_2 then
									var_13_6 = arg_8_0
									var_13_7 = var_13_7.emit
									Dorm3dChatMediator = var_2

									var_13_7(var_13_6, var_2.SET_READED, arg_8_4, {
										arg_8_1.topicId
									})
								end

								Canvas = var_13_7

								var_13_7.ForceUpdateCanvases()

								LeanTween = var_0

								local var_13_8 = var_0.value

								go = var_13_6

								local var_13_9 = arg_8_0.rightPanel
								local var_13_10 = var_13_8(var_13_6(var_2.Find(var_13_9, "messageScroll")), var_8_10.normalizedPosition.y, 0, 0.5)
								local var_13_11 = var_0.setOnUpdate

								System = var_2

								local var_13_12 = var_13_11(var_13_10, var_2.Action_float(var_8_11))
								local var_13_13 = var_0.setEase

								LeanTweenType = var_2

								var_13_13(var_13_12, var_2.easeInOutCubic)

								local var_13_14 = arg_8_0
								local var_13_15 = var_0.SetEndAniEvent
								local var_13_16 = arg_11_2

								var_13_15(var_13_14, var_2.Find(var_13_16, "charaMessageCard/msgBox"), function()
									if arg_8_0.shouldShowOption and arg_11_1 + 1 == #arg_8_2 then
										local var_14_0 = arg_8_0

										var_0.SetOptionPanelActive(var_14_0, true)
									end

									return
								end)

								return
							end, var_0)

							return
						end, var_11_3)
					end
				elseif var_3.type == 2 then
					local var_11_8 = arg_8_0

					var_8.SetCharaMessageCardActive(var_11_8, var_11_0, {
						2,
						7
					})

					pg = var_8

					local var_11_9 = var_8.CriMgr.GetInstance()

					var_8.GetCueInfo(var_11_9, "cv-" .. var_3.ship_group, var_3.param[1], function(arg_15_0)
						setText = var_3_10001

						local var_15_0 = arg_11_2
						local var_15_1 = var_2.Find(var_15_0, "charaMessageCard/voiceBox/time")

						tostring = var_15_0
						math = var_4

						local var_15_2 = var_4.ceil

						tonumber = var_3_10005
						tostring = var_3_10006

						var_3_10001(var_15_1, var_15_0(var_15_2(var_3_10005(var_3_10006(arg_15_0.length)) / 1000)) .. "\"")

						return
					end)

					local var_11_10 = arg_8_0.playbackInfos

					var_11_10[var_3.id] = nil
					setActive = var_11_10
					var_2_10010 = arg_11_2

					var_11_10(arg_11_2.Find(var_2_10010, "charaMessageCard/voiceBox/play/pause"), false)

					onButton = var_11_10

					local var_11_11 = arg_8_0

					iter_11_1 = arg_11_2
					var_2_10010 = arg_11_2.Find(iter_11_1, "charaMessageCard/voiceBox/play")

					function iter_11_1()
						local var_16_0 = arg_8_0.playbackInfos[var_0.id].playback
						local var_16_1 = var_0.GetStatus(var_16_0)

						CriAtomExPlayback = var_16_0

						if var_16_1 == var_16_0.Status.Removed then
							arg_8_0.playbackInfos[var_0.id] = nil
						end

						if not arg_8_0.playbackInfos[var_0.id] then
							pg = var_0

							local var_16_2 = var_0.CriMgr.GetInstance()

							var_0.PlaySoundEffect_V3(var_16_2, "event:/cv/" .. var_0.ship_group .. "/" .. var_0.param[1], function(arg_17_0)
								if arg_17_0 then
									arg_8_0.playbackInfos[var_0.id] = arg_17_0
								end

								return
							end)

							setActive = var_0
							var_3_10002 = arg_11_2

							var_0(var_1.Find(var_3_10002, "charaMessageCard/voiceBox/play/pause"), true)
						else
							local var_16_3 = arg_8_0.playbackInfos[var_0.id].playback

							if var_0.IsPaused(var_16_3) then
								local var_16_4 = arg_8_0.playbackInfos[var_0.id].playback
								local var_16_5 = var_0.Resume

								CriWare = var_3_10002

								var_16_5(var_16_4, var_3_10002.CriAtomEx.ResumeMode.PausedPlayback)

								setActive = var_16_5

								local var_16_6 = arg_11_2

								var_16_5(var_1.Find(var_16_6, "charaMessageCard/voiceBox/play/pause"), true)
							else
								local var_16_7 = arg_8_0.playbackInfos[var_0.id].playback

								var_0.Pause(var_16_7)

								setActive = var_0

								local var_16_8 = arg_11_2

								var_0(var_1.Find(var_16_8, "charaMessageCard/voiceBox/play/pause"), false)
							end
						end

						return
					end

					SFX_PANEL = iter_11_0

					var_11_10(var_11_11, var_2_10010, iter_11_1, iter_11_0)

					setText = var_11_10
					var_2_10010 = arg_11_2

					var_11_10(arg_11_2.Find(var_2_10010, "charaMessageCard/voiceMsgBox/voiceMsg/msg"), var_3.param[2])

					if arg_8_3 and var_8_0 and arg_11_1 + 1 > var_8_0 then
						SetActive = var_8

						var_8(arg_11_2, false)

						local var_11_12 = arg_8_0

						var_8.StartTimer(var_11_12, function()
							SetActive = var_3_10000

							var_3_10000(arg_11_2, true)

							local var_18_0 = arg_11_2
							local var_18_1 = var_0.Find(var_18_0, "charaMessageCard/charaBg")
							local var_18_2 = var_0.GetComponent

							typeof = var_2
							Animation = var_3_10003

							local var_18_3 = var_18_2(var_18_1, var_2(var_3_10003))

							var_0.Play(var_18_3, "anim_newinstagram_charabg")

							SetActive = var_0

							local var_18_4 = arg_11_2

							var_0(var_1.Find(var_18_4, "charaMessageCard/waiting"), true)

							SetActive = var_0

							local var_18_5 = arg_11_2

							var_0(var_1.Find(var_18_5, "charaMessageCard/voiceBox"), false)

							SetActive = var_0

							local var_18_6 = arg_11_2

							var_0(var_1.Find(var_18_6, "charaMessageCard/voiceMsgBox"), false)

							Canvas = var_0

							var_0.ForceUpdateCanvases()

							LeanTween = var_0

							local var_18_7 = var_0.value

							go = var_1

							local var_18_8 = arg_8_0.rightPanel
							local var_18_9 = var_18_7(var_1(var_2.Find(var_18_8, "messageScroll")), var_8_10.normalizedPosition.y, 0, 0.5)
							local var_18_10 = var_0.setOnUpdate

							System = var_2

							local var_18_11 = var_18_10(var_18_9, var_2.Action_float(var_8_11))
							local var_18_12 = var_0.setEase

							LeanTweenType = var_2

							var_18_12(var_18_11, var_2.easeInOutCubic)

							local var_18_13 = arg_8_0

							var_0.StartTimer(var_18_13, function()
								SetActive = var_4_10000

								local var_19_0 = arg_11_2

								var_4_10000(var_1.Find(var_19_0, "charaMessageCard/waiting"), false)

								SetActive = var_4_10000

								local var_19_1 = arg_11_2

								var_4_10000(var_1.Find(var_19_1, "charaMessageCard/voiceBox"), true)

								SetActive = var_4_10000

								local var_19_2 = arg_11_2

								var_4_10000(var_1.Find(var_19_2, "charaMessageCard/voiceMsgBox"), true)

								local var_19_3 = arg_11_2
								local var_19_4 = var_0.Find(var_19_3, "charaMessageCard/voiceBox")
								local var_19_5 = var_0.GetComponent

								typeof = var_2
								Animation = var_3

								local var_19_6 = var_19_5(var_19_4, var_2(var_3))

								var_0.Play(var_19_6, "anim_newinstagram_chat_common_in")

								local var_19_7 = arg_11_2
								local var_19_8 = var_0.Find(var_19_7, "charaMessageCard/voiceMsgBox")
								local var_19_9 = var_0.GetComponent

								typeof = var_2
								Animation = var_3

								local var_19_10 = var_19_9(var_19_8, var_2(var_3))

								var_0.Play(var_19_10, "anim_newinstagram_voicetip_in")

								local var_19_11, var_19_12

								if arg_11_1 + 1 == #arg_8_2 then
									var_19_11 = arg_8_0
									var_19_12 = var_19_12.emit
									Dorm3dChatMediator = var_2

									var_19_12(var_19_11, var_2.SET_READED, arg_8_4, {
										arg_8_1.topicId
									})
								end

								Canvas = var_19_12

								var_19_12.ForceUpdateCanvases()

								LeanTween = var_0

								local var_19_13 = var_0.value

								go = var_19_11

								local var_19_14 = arg_8_0.rightPanel
								local var_19_15 = var_19_13(var_19_11(var_2.Find(var_19_14, "messageScroll")), var_8_10.normalizedPosition.y, 0, 0.5)
								local var_19_16 = var_0.setOnUpdate

								System = var_2

								local var_19_17 = var_19_16(var_19_15, var_2.Action_float(var_8_11))
								local var_19_18 = var_0.setEase

								LeanTweenType = var_2

								var_19_18(var_19_17, var_2.easeInOutCubic)

								local var_19_19 = arg_8_0
								local var_19_20 = var_0.SetEndAniEvent
								local var_19_21 = arg_11_2

								var_19_20(var_19_19, var_2.Find(var_19_21, "charaMessageCard/voiceBox"), function()
									if arg_8_0.shouldShowOption and arg_11_1 + 1 == #arg_8_2 then
										local var_20_0 = arg_8_0

										var_0.SetOptionPanelActive(var_20_0, true)
									end

									return
								end)

								return
							end, var_0)

							return
						end, var_11_3)
					end
				elseif var_3.type == 3 then
					local var_11_13 = arg_8_0

					var_8.SetCharaMessageCardActive(var_11_13, var_11_0, {
						5
					})

					local var_11_14 = var_0_3

					tonumber = var_11_13

					local var_11_15 = var_11_14[var_11_13(var_3.param)]

					setText = var_9
					iter_11_1 = arg_11_2

					var_9(arg_11_2.Find(iter_11_1, "charaMessageCard/redPacket/desc"), var_11_15.desc)

					var_2_10010 = arg_8_1

					local var_11_16 = var_9.RedPacketGotFlag(var_2_10010, var_11_15.id)

					SetActive = var_2_10010
					iter_11_0 = arg_11_2

					var_2_10010(arg_11_2.Find(iter_11_0, "charaMessageCard/redPacket/got"), var_11_16)

					iter_11_1 = arg_8_0
					var_2_10010 = var_2_10010.SetRedPacketPanel
					var_2_10013 = arg_11_2

					var_2_10010(iter_11_1, arg_11_2.Find(var_2_10013, "charaMessageCard/redPacket"), var_11_15, var_11_16, var_11_4, arg_8_4, arg_8_1.topicId, var_3.id)

					if arg_8_3 and var_8_0 then
						var_2_10010 = arg_11_1 + 1

						if var_8_0 < var_2_10010 then
							SetActive = var_2_10010

							var_2_10010(arg_11_2, false)

							iter_11_1 = arg_8_0

							var_2_10010.StartTimer(iter_11_1, function()
								SetActive = var_3_10000

								var_3_10000(arg_11_2, true)

								local var_21_0 = arg_11_2
								local var_21_1 = var_0.Find(var_21_0, "charaMessageCard/charaBg")
								local var_21_2 = var_0.GetComponent

								typeof = var_2
								Animation = var_3_10003

								local var_21_3 = var_21_2(var_21_1, var_2(var_3_10003))

								var_0.Play(var_21_3, "anim_newinstagram_charabg")

								SetActive = var_0

								local var_21_4 = arg_11_2

								var_0(var_1.Find(var_21_4, "charaMessageCard/waiting"), true)

								SetActive = var_0

								local var_21_5 = arg_11_2

								var_0(var_1.Find(var_21_5, "charaMessageCard/redPacket"), false)

								Canvas = var_0

								var_0.ForceUpdateCanvases()

								LeanTween = var_0

								local var_21_6 = var_0.value

								go = var_1

								local var_21_7 = arg_8_0.rightPanel
								local var_21_8 = var_21_6(var_1(var_2.Find(var_21_7, "messageScroll")), var_8_10.normalizedPosition.y, 0, 0.5)
								local var_21_9 = var_0.setOnUpdate

								System = var_2

								local var_21_10 = var_21_9(var_21_8, var_2.Action_float(var_8_11))
								local var_21_11 = var_0.setEase

								LeanTweenType = var_2

								var_21_11(var_21_10, var_2.easeInOutCubic)

								local var_21_12 = arg_8_0

								var_0.StartTimer(var_21_12, function()
									SetActive = var_4_10000

									local var_22_0 = arg_11_2

									var_4_10000(var_1.Find(var_22_0, "charaMessageCard/waiting"), false)

									SetActive = var_4_10000

									local var_22_1 = arg_11_2

									var_4_10000(var_1.Find(var_22_1, "charaMessageCard/redPacket"), true)

									local var_22_2 = arg_11_2
									local var_22_3 = var_0.Find(var_22_2, "charaMessageCard/redPacket")
									local var_22_4 = var_0.GetComponent

									typeof = var_2
									Animation = var_3

									local var_22_5 = var_22_4(var_22_3, var_2(var_3))

									var_0.Play(var_22_5, "anim_newinstagram_redpacket_in")

									local var_22_6, var_22_7

									if arg_11_1 + 1 == #arg_8_2 then
										var_22_6 = arg_8_0
										var_22_7 = var_22_7.emit
										Dorm3dChatMediator = var_2

										var_22_7(var_22_6, var_2.SET_READED, arg_8_4, {
											arg_8_1.topicId
										})
									end

									Canvas = var_22_7

									var_22_7.ForceUpdateCanvases()

									LeanTween = var_0

									local var_22_8 = var_0.value

									go = var_22_6

									local var_22_9 = arg_8_0.rightPanel
									local var_22_10 = var_22_8(var_22_6(var_2.Find(var_22_9, "messageScroll")), var_8_10.normalizedPosition.y, 0, 0.5)
									local var_22_11 = var_0.setOnUpdate

									System = var_2

									local var_22_12 = var_22_11(var_22_10, var_2.Action_float(var_8_11))
									local var_22_13 = var_0.setEase

									LeanTweenType = var_2

									var_22_13(var_22_12, var_2.easeInOutCubic)

									local var_22_14 = arg_8_0
									local var_22_15 = var_0.SetEndAniEvent
									local var_22_16 = arg_11_2

									var_22_15(var_22_14, var_2.Find(var_22_16, "charaMessageCard/redPacket"), function()
										if arg_8_0.shouldShowOption and arg_11_1 + 1 == #arg_8_2 then
											local var_23_0 = arg_8_0

											var_0.SetOptionPanelActive(var_23_0, true)
										end

										return
									end)

									return
								end, var_0)

								return
							end, var_11_3)
						end
					end
				elseif var_3.type == 4 then
					local var_11_17 = arg_8_0

					var_8.SetCharaMessageCardActive(var_11_17, var_11_0, {
						4
					})

					local var_11_18 = arg_8_0
					local var_11_19 = var_8.ClearEmoji

					iter_11_1 = arg_11_2

					var_11_19(var_11_18, arg_11_2.Find(iter_11_1, "charaMessageCard/emoji/emoticon"))

					local var_11_20 = arg_8_0
					local var_11_21 = var_8.SetEmoji

					iter_11_1 = arg_11_2
					var_2_10010 = arg_11_2.Find(iter_11_1, "charaMessageCard/emoji/emoticon")
					iter_11_1 = var_0_4
					tonumber = iter_11_0

					var_11_21(var_11_20, var_2_10010, iter_11_1[iter_11_0(var_3.param)].pic)

					if arg_8_3 and var_8_0 and arg_11_1 + 1 > var_8_0 then
						SetActive = var_8

						var_8(arg_11_2, false)

						local var_11_22 = arg_8_0

						var_8.StartTimer(var_11_22, function()
							SetActive = var_3_10000

							var_3_10000(arg_11_2, true)

							local var_24_0 = arg_11_2
							local var_24_1 = var_0.Find(var_24_0, "charaMessageCard/charaBg")
							local var_24_2 = var_0.GetComponent

							typeof = var_2
							Animation = var_3_10003

							local var_24_3 = var_24_2(var_24_1, var_2(var_3_10003))

							var_0.Play(var_24_3, "anim_newinstagram_charabg")

							SetActive = var_0

							local var_24_4 = arg_11_2

							var_0(var_1.Find(var_24_4, "charaMessageCard/waiting"), true)

							SetActive = var_0

							local var_24_5 = arg_11_2

							var_0(var_1.Find(var_24_5, "charaMessageCard/emoji"), false)

							Canvas = var_0

							var_0.ForceUpdateCanvases()

							LeanTween = var_0

							local var_24_6 = var_0.value

							go = var_1

							local var_24_7 = arg_8_0.rightPanel
							local var_24_8 = var_24_6(var_1(var_2.Find(var_24_7, "messageScroll")), var_8_10.normalizedPosition.y, 0, 0.5)
							local var_24_9 = var_0.setOnUpdate

							System = var_2

							local var_24_10 = var_24_9(var_24_8, var_2.Action_float(var_8_11))
							local var_24_11 = var_0.setEase

							LeanTweenType = var_2

							var_24_11(var_24_10, var_2.easeInOutCubic)

							local var_24_12 = arg_8_0

							var_0.StartTimer(var_24_12, function()
								SetActive = var_4_10000

								local var_25_0 = arg_11_2

								var_4_10000(var_1.Find(var_25_0, "charaMessageCard/waiting"), false)

								SetActive = var_4_10000

								local var_25_1 = arg_11_2

								var_4_10000(var_1.Find(var_25_1, "charaMessageCard/emoji"), true)

								local var_25_2 = arg_11_2
								local var_25_3 = var_0.Find(var_25_2, "charaMessageCard/emoji")
								local var_25_4 = var_0.GetComponent

								typeof = var_2
								Animation = var_3

								local var_25_5 = var_25_4(var_25_3, var_2(var_3))

								var_0.Play(var_25_5, "anim_newinstagram_emoji_in")

								local var_25_6, var_25_7

								if arg_11_1 + 1 == #arg_8_2 then
									var_25_6 = arg_8_0
									var_25_7 = var_25_7.emit
									Dorm3dChatMediator = var_2

									var_25_7(var_25_6, var_2.SET_READED, arg_8_4, {
										arg_8_1.topicId
									})
								end

								Canvas = var_25_7

								var_25_7.ForceUpdateCanvases()

								LeanTween = var_0

								local var_25_8 = var_0.value

								go = var_25_6

								local var_25_9 = arg_8_0.rightPanel
								local var_25_10 = var_25_8(var_25_6(var_2.Find(var_25_9, "messageScroll")), var_8_10.normalizedPosition.y, 0, 0.5)
								local var_25_11 = var_0.setOnUpdate

								System = var_2

								local var_25_12 = var_25_11(var_25_10, var_2.Action_float(var_8_11))
								local var_25_13 = var_0.setEase

								LeanTweenType = var_2

								var_25_13(var_25_12, var_2.easeInOutCubic)

								local var_25_14 = arg_8_0
								local var_25_15 = var_0.SetEndAniEvent
								local var_25_16 = arg_11_2

								var_25_15(var_25_14, var_2.Find(var_25_16, "charaMessageCard/emoji"), function()
									if arg_8_0.shouldShowOption and arg_11_1 + 1 == #arg_8_2 then
										local var_26_0 = arg_8_0

										var_0.SetOptionPanelActive(var_26_0, true)
									end

									return
								end)

								return
							end, var_0)

							return
						end, var_11_3)
					end
				elseif var_3.type == 5 then
					local var_11_23 = arg_8_0

					var_8.SetCharaMessageCardActive(var_11_23, var_11_0, {
						6
					})

					local var_11_24 = var_3.param

					string = var_11_23

					for iter_11_0 in var_11_23.gmatch(var_3.param, "'%d+'") do
						string = var_2_10013
						var_2_10013 = var_2_10013.sub(iter_11_0, 2, #iter_11_0 - 1)
						string = var_14

						local var_11_25 = var_14.gsub
						local var_11_26 = var_11_24
						local var_11_27 = iter_11_0
						local var_11_28 = "<color=#93e9ff>"

						var_2_10018 = var_0_2
						tonumber = var_2_10019
						var_11_24 = var_11_25(var_11_26, var_11_27, var_11_28 .. var_2_10018[var_2_10019(var_2_10013)].name .. "</color>")
					end

					setText = var_9
					iter_11_1 = arg_11_2

					var_9(arg_11_2.Find(iter_11_1, "charaMessageCard/systemTip/panel/Text"), var_11_24)

					if arg_8_3 and var_8_0 then
						local var_11_29 = arg_11_1 + 1

						if var_8_0 < var_11_29 then
							SetActive = var_11_29

							var_11_29(arg_11_2, false)

							var_2_10010 = arg_8_0

							var_9.StartTimer(var_2_10010, function()
								SetActive = var_3_10000

								var_3_10000(arg_11_2, true)

								local var_27_0 = arg_11_2
								local var_27_1 = var_0.Find(var_27_0, "charaMessageCard/systemTip")
								local var_27_2 = var_0.GetComponent

								typeof = var_2
								Animation = var_3_10003

								local var_27_3 = var_27_2(var_27_1, var_2(var_3_10003))

								var_0.Play(var_27_3, "anim_newinstagram_tip_in")

								local var_27_4, var_27_5

								if arg_11_1 + 1 == #arg_8_2 then
									var_27_4 = arg_8_0
									var_27_5 = var_27_5.emit
									Dorm3dChatMediator = var_2

									var_27_5(var_27_4, var_2.SET_READED, arg_8_4, {
										arg_8_1.topicId
									})
								end

								Canvas = var_27_5

								var_27_5.ForceUpdateCanvases()

								LeanTween = var_0

								local var_27_6 = var_0.value

								go = var_27_4

								local var_27_7 = arg_8_0.rightPanel
								local var_27_8 = var_27_6(var_27_4(var_2.Find(var_27_7, "messageScroll")), var_8_10.normalizedPosition.y, 0, 0.5)
								local var_27_9 = var_0.setOnUpdate

								System = var_2

								local var_27_10 = var_27_9(var_27_8, var_2.Action_float(var_8_11))
								local var_27_11 = var_0.setEase

								LeanTweenType = var_2

								var_27_11(var_27_10, var_2.easeInOutCubic)

								local var_27_12 = arg_8_0
								local var_27_13 = var_0.SetEndAniEvent
								local var_27_14 = arg_11_2

								var_27_13(var_27_12, var_2.Find(var_27_14, "charaMessageCard/systemTip"), function()
									if arg_8_0.shouldShowOption and arg_11_1 + 1 == #arg_8_2 then
										local var_28_0 = arg_8_0

										var_0.SetOptionPanelActive(var_28_0, true)
									end

									return
								end)

								return
							end, var_11_3)
						end
					end
				elseif var_3.type == 6 then
					local var_11_30 = arg_8_0

					var_8.SetCharaMessageCardActive(var_11_30, var_11_0, {
						8
					})

					setImageSprite = var_8
					var_2_10010 = arg_11_2

					local var_11_31 = arg_11_2.Find(var_2_10010, "charaMessageCard/picture/mask/img")

					LoadSprite = var_2_10010

					var_8(var_11_31, var_2_10010("dorm3dprivatechat/" .. var_3.param), false)

					local var_11_32 = arg_8_0
					local var_11_33 = var_8.SetPicturePanel

					iter_11_1 = arg_11_2

					var_11_33(var_11_32, arg_11_2.Find(iter_11_1, "charaMessageCard/picture/mask/img"), var_3.param)

					if arg_8_3 and var_8_0 and arg_11_1 + 1 > var_8_0 then
						SetActive = var_8

						var_8(arg_11_2, false)

						local var_11_34 = arg_8_0

						var_8.StartTimer(var_11_34, function()
							SetActive = var_3_10000

							var_3_10000(arg_11_2, true)

							local var_29_0 = arg_11_2
							local var_29_1 = var_0.Find(var_29_0, "charaMessageCard/charaBg")
							local var_29_2 = var_0.GetComponent

							typeof = var_2
							Animation = var_3_10003

							local var_29_3 = var_29_2(var_29_1, var_2(var_3_10003))

							var_0.Play(var_29_3, "anim_newinstagram_charabg")

							SetActive = var_0

							local var_29_4 = arg_11_2

							var_0(var_1.Find(var_29_4, "charaMessageCard/waiting"), true)

							SetActive = var_0

							local var_29_5 = arg_11_2

							var_0(var_1.Find(var_29_5, "charaMessageCard/picture"), false)

							Canvas = var_0

							var_0.ForceUpdateCanvases()

							LeanTween = var_0

							local var_29_6 = var_0.value

							go = var_1

							local var_29_7 = arg_8_0.rightPanel
							local var_29_8 = var_29_6(var_1(var_2.Find(var_29_7, "messageScroll")), var_8_10.normalizedPosition.y, 0, 0.5)
							local var_29_9 = var_0.setOnUpdate

							System = var_2

							local var_29_10 = var_29_9(var_29_8, var_2.Action_float(var_8_11))
							local var_29_11 = var_0.setEase

							LeanTweenType = var_2

							var_29_11(var_29_10, var_2.easeInOutCubic)

							local var_29_12 = arg_8_0

							var_0.StartTimer(var_29_12, function()
								SetActive = var_4_10000

								local var_30_0 = arg_11_2

								var_4_10000(var_1.Find(var_30_0, "charaMessageCard/waiting"), false)

								SetActive = var_4_10000

								local var_30_1 = arg_11_2

								var_4_10000(var_1.Find(var_30_1, "charaMessageCard/picture"), true)

								local var_30_2 = arg_11_2
								local var_30_3 = var_0.Find(var_30_2, "charaMessageCard/picture")
								local var_30_4 = var_0.GetComponent

								typeof = var_2
								Animation = var_3

								local var_30_5 = var_30_4(var_30_3, var_2(var_3))

								var_0.Play(var_30_5, "anim_newinstagram_emoji_in")

								local var_30_6, var_30_7

								if arg_11_1 + 1 == #arg_8_2 then
									var_30_6 = arg_8_0
									var_30_7 = var_30_7.emit
									Dorm3dChatMediator = var_2

									var_30_7(var_30_6, var_2.SET_READED, arg_8_4, {
										arg_8_1.topicId
									})
								end

								Canvas = var_30_7

								var_30_7.ForceUpdateCanvases()

								LeanTween = var_0

								local var_30_8 = var_0.value

								go = var_30_6

								local var_30_9 = arg_8_0.rightPanel
								local var_30_10 = var_30_8(var_30_6(var_2.Find(var_30_9, "messageScroll")), var_8_10.normalizedPosition.y, 0, 0.5)
								local var_30_11 = var_0.setOnUpdate

								System = var_2

								local var_30_12 = var_30_11(var_30_10, var_2.Action_float(var_8_11))
								local var_30_13 = var_0.setEase

								LeanTweenType = var_2

								var_30_13(var_30_12, var_2.easeInOutCubic)

								local var_30_14 = arg_8_0
								local var_30_15 = var_0.SetEndAniEvent
								local var_30_16 = arg_11_2

								var_30_15(var_30_14, var_2.Find(var_30_16, "charaMessageCard/picture"), function()
									if arg_8_0.shouldShowOption and arg_11_1 + 1 == #arg_8_2 then
										local var_31_0 = arg_8_0

										var_0.SetOptionPanelActive(var_31_0, true)
									end

									return
								end)

								return
							end, var_0)

							return
						end, var_11_3)
					end
				end
			else
				if var_3.type == 1 then
					local var_11_35 = arg_8_0

					var_7.SetPlayerMessageCardActive(var_11_35, var_11_2, {
						0
					})

					setText = var_7

					var_7(arg_11_2:Find("playerReplyCard/msgBox/msg"), var_3.param)
				elseif var_3.type == 4 then
					local var_11_36 = arg_8_0

					var_7.SetPlayerMessageCardActive(var_11_36, var_11_2, {
						1
					})

					local var_11_37 = arg_8_0
					local var_11_38 = var_7.ClearEmoji

					var_2_10010 = arg_11_2

					var_11_38(var_11_37, arg_11_2.Find(var_2_10010, "playerReplyCard/emoji/emoticon"))

					local var_11_39 = arg_8_0
					local var_11_40 = var_7.SetEmoji

					var_2_10010 = arg_11_2

					local var_11_41 = arg_11_2.Find(var_2_10010, "playerReplyCard/emoji/emoticon")

					var_2_10010 = var_0_4
					tonumber = iter_11_1

					var_11_40(var_11_39, var_11_41, var_2_10010[iter_11_1(var_3.param)].pic)
				elseif var_3.type == 5 then
					local var_11_42 = arg_8_0

					var_7.SetPlayerMessageCardActive(var_11_42, var_11_2, {
						2
					})

					local var_11_43 = var_3.param

					string = var_11_42

					for iter_11_1 in var_11_42.gmatch(var_3.param, "'%d+'") do
						string = iter_11_0
						iter_11_0 = iter_11_0.sub(iter_11_1, 2, #iter_11_1 - 1)
						string = var_13

						local var_11_44 = var_13.gsub
						local var_11_45 = var_11_43
						local var_11_46 = iter_11_1
						local var_11_47 = "<color=#93e9ff>"
						local var_11_48 = var_0_2

						tonumber = var_2_10018
						var_11_43 = var_11_44(var_11_45, var_11_46, var_11_47 .. var_11_48[var_2_10018(iter_11_0)].name .. "</color>")
					end

					setText = var_8
					var_2_10010 = arg_11_2

					var_8(arg_11_2.Find(var_2_10010, "playerReplyCard/systemTip/panel/Text"), var_11_43)
				end

				if arg_8_3 and var_8_0 then
					_ = var_7

					if var_7.contains(var_8_3, arg_11_1 + 1) then
						table = var_7

						local var_11_51

						if var_7.indexof(var_8_3, arg_11_1 + 1) < #var_8_3 then
							SetActive = var_7

							var_7(arg_11_2, false)

							local var_11_49 = arg_8_0
							local var_11_50 = var_7.StartTimer

							function var_11_51()
								SetActive = var_3_10000

								var_3_10000(arg_11_2, true)

								if var_0.type == 1 then
									local var_32_0 = arg_11_2
									local var_32_1 = var_0.Find(var_32_0, "playerReplyCard/msgBox")
									local var_32_2 = var_0.GetComponent

									typeof = var_2
									Animation = var_3_10003

									local var_32_3 = var_32_2(var_32_1, var_2(var_3_10003))

									var_0.Play(var_32_3, "anim_newinstagram_playerchat_common_in")
								elseif var_0.type == 4 then
									local var_32_4 = arg_11_2
									local var_32_5 = var_0.Find(var_32_4, "playerReplyCard/emoji")
									local var_32_6 = var_0.GetComponent

									typeof = var_2
									Animation = var_3_10003

									local var_32_7 = var_32_6(var_32_5, var_2(var_3_10003))

									var_0.Play(var_32_7, "anim_newinstagram_emoji_in")
								elseif var_0.type == 5 then
									local var_32_8 = arg_11_2
									local var_32_9 = var_0.Find(var_32_8, "playerReplyCard/systemTip")
									local var_32_10 = var_0.GetComponent

									typeof = var_2
									Animation = var_3_10003

									local var_32_11 = var_32_10(var_32_9, var_2(var_3_10003))

									var_0.Play(var_32_11, "anim_newinstagram_tip_in")
								end

								local var_32_12, var_32_13

								if arg_11_1 + 1 == #arg_8_2 then
									var_32_12 = arg_8_0
									var_32_13 = var_32_13.emit
									Dorm3dChatMediator = var_2

									var_32_13(var_32_12, var_2.SET_READED, arg_8_4, {
										arg_8_1.topicId
									})
								end

								Canvas = var_32_13

								var_32_13.ForceUpdateCanvases()

								LeanTween = var_0

								local var_32_14 = var_0.value

								go = var_32_12

								local var_32_15 = arg_8_0.rightPanel
								local var_32_16 = var_32_14(var_32_12(var_2.Find(var_32_15, "messageScroll")), var_8_10.normalizedPosition.y, 0, 0.5)
								local var_32_17 = var_0.setOnUpdate

								System = var_2

								local var_32_18 = var_32_17(var_32_16, var_2.Action_float(var_8_11))
								local var_32_19 = var_0.setEase

								LeanTweenType = var_2

								var_32_19(var_32_18, var_2.easeInOutCubic)

								return
							end

							var_2_10010 = #var_8_3
							table = iter_11_1

							var_11_50(var_11_49, var_11_51, (var_2_10010 - iter_11_1.indexof(var_8_3, arg_11_1 + 1)) * var_8_13)
						else
							if var_3.type == 1 then
								local var_11_52 = arg_11_2:Find("playerReplyCard/msgBox")
								local var_11_53 = var_7.GetComponent

								typeof = var_11_51
								Animation = var_2_10010

								local var_11_54 = var_11_53(var_11_52, var_11_51(var_2_10010))

								var_7.Play(var_11_54, "anim_newinstagram_playerchat_common_in")
							elseif var_3.type == 4 then
								local var_11_55 = arg_11_2:Find("playerReplyCard/emoji")
								local var_11_56 = var_7.GetComponent

								typeof = var_11_51
								Animation = var_2_10010

								local var_11_57 = var_11_56(var_11_55, var_11_51(var_2_10010))

								var_7.Play(var_11_57, "anim_newinstagram_emoji_in")
							elseif var_3.type == 5 then
								local var_11_58 = arg_11_2:Find("playerReplyCard/systemTip")
								local var_11_59 = var_7.GetComponent

								typeof = var_11_51
								Animation = var_2_10010

								local var_11_60 = var_11_59(var_11_58, var_11_51(var_2_10010))

								var_7.Play(var_11_60, "anim_newinstagram_tip_in")
							end

							if arg_11_1 + 1 == #arg_8_2 then
								local var_11_61 = arg_8_0
								local var_11_62 = var_7.emit

								Dorm3dChatMediator = var_11_51

								var_11_62(var_11_61, var_11_51.SET_READED, arg_8_4, {
									arg_8_1.topicId
								})
							end
						end
					end
				end
			end

			local var_11_63 = arg_8_1
			local var_11_66

			if not var_7.isWaiting(var_11_63) and arg_11_1 + 1 == #arg_8_2 then
				if arg_8_3 then
					if var_3.ship_group ~= 0 then
						local var_11_64 = arg_8_0

						var_11_66.StartTimer(var_11_64, function()
							setActive = var_3_10000

							local var_33_0 = arg_11_2

							var_3_10000(var_1.Find(var_33_0, "end"), true)

							return
						end, var_11_3 + var_8_12)
					else
						local var_11_65 = arg_8_0

						var_11_66 = var_11_66.StartTimer

						local function var_11_67()
							setActive = var_3_10000

							local var_34_0 = arg_11_2

							var_3_10000(var_1.Find(var_34_0, "end"), true)

							return
						end

						local var_11_68 = #var_8_3

						table = iter_11_1

						var_11_66(var_11_65, var_11_67, (var_11_68 - iter_11_1.indexof(var_8_3, arg_11_1 + 1)) * var_8_13 + var_8_13)
					end
				else
					setActive = var_11_66

					var_11_66(arg_11_2:Find("end"), true)
				end
			else
				setActive = var_11_66

				var_11_66(arg_11_2:Find("end"), false)
			end
		end

		return
	end)

	local var_8_15 = arg_8_0.messageList

	var_12.align(var_8_15, #arg_8_2)

	local var_8_16

	if arg_8_3 then
		Canvas = var_8_16

		var_8_16.ForceUpdateCanvases()

		LeanTween = var_8_16
		var_8_16 = var_8_16.value
		go = var_8_15

		local var_8_17 = arg_8_0.rightPanel
		local var_8_18 = var_8_16(var_8_15(var_14.Find(var_8_17, "messageScroll")), var_8_10.normalizedPosition.y, 0, 0.5)

		var_8_16 = var_8_16.setOnUpdate
		System = var_14

		local var_8_19 = var_8_16(var_8_18, var_14.Action_float(var_8_11))

		var_8_16 = var_8_16.setEase
		LeanTweenType = var_14

		var_8_16(var_8_19, var_14.easeInOutCubic)
	else
		scrollToBottom = var_8_16

		local var_8_20 = arg_8_0.rightPanel

		var_8_16(var_13.Find(var_8_20, "messageScroll"))
	end

	return
end

function var_0_1.SetCharaMessageCardActive(arg_35_0, arg_35_1, arg_35_2)
	_ = var_1_10003

	if var_1_10003.contains(arg_35_2, 6) then
		SetActive = var_3

		var_3(arg_35_1:GetChild(0), false)
	else
		SetActive = var_3

		var_3(arg_35_1:GetChild(0), true)
	end

	for iter_35_0 = 1, arg_35_1.childCount - 1 do
		_ = var_1_10007

		if var_1_10007.contains(arg_35_2, iter_35_0) then
			SetActive = var_1_10007

			var_1_10007(arg_35_1:GetChild(iter_35_0), true)
		else
			SetActive = var_1_10007

			var_1_10007(arg_35_1:GetChild(iter_35_0), false)
		end
	end

	return
end

function var_0_1.SetPlayerMessageCardActive(arg_36_0, arg_36_1, arg_36_2)
	for iter_36_0 = 0, arg_36_1.childCount - 1 do
		_ = var_1_10007

		if var_1_10007.contains(arg_36_2, iter_36_0) then
			SetActive = var_1_10007

			var_1_10007(arg_36_1:GetChild(iter_36_0), true)
		else
			SetActive = var_1_10007

			var_1_10007(arg_36_1:GetChild(iter_36_0), false)
		end
	end

	return
end

function var_0_1.SetEmoji(arg_37_0, arg_37_1, arg_37_2)
	PoolMgr = var_1_10003

	local var_37_0 = var_1_10003.GetInstance()

	var_3.GetPrefab(var_37_0, "emoji/" .. arg_37_2, arg_37_2, true, function(arg_38_0)
		IsNil = var_2_10001

		local var_38_0

		if not var_2_10001(arg_37_1) then
			arg_38_0.name = arg_37_2
			tf = var_38_0
			var_38_0 = var_38_0(arg_38_0)
			var_38_0.sizeDelta = arg_37_1.sizeDelta
			tf = var_38_0
			var_38_0 = var_38_0(arg_38_0)
			Vector2 = var_2
			var_38_0.anchoredPosition = var_2.zero

			local var_38_1 = arg_38_0

			if arg_38_0.GetComponent(var_38_1, "Animator") then
				var_38_0.enabled = true
			end

			setParent = var_38_1

			var_38_1(arg_38_0, arg_37_1, false)
		else
			PoolMgr = var_38_0

			local var_38_2 = var_38_0.GetInstance()

			var_1.ReturnPrefab(var_38_2, "emoji/" .. arg_37_2, arg_37_2, arg_38_0)
		end

		return
	end)

	return
end

function var_0_1.ClearEmoji(arg_39_0, arg_39_1)
	eachChild = var_1_10002

	var_1_10002(arg_39_1, function(arg_40_0)
		go = var_2_10001

		local var_40_0 = var_2_10001(arg_40_0)

		PoolMgr = var_2

		local var_40_1 = var_2.GetInstance()

		var_2.ReturnPrefab(var_40_1, "emoji/" .. var_40_0.name, var_40_0.name, var_40_0)

		return
	end)

	return
end

function var_0_1.UpdateOptionPanel(arg_41_0, arg_41_1, arg_41_2)
	if arg_41_2[#arg_41_2].option then
		type = var_1_10004

		if var_1_10004(var_3) == "table" then
			arg_41_0.shouldShowOption = true
			arg_41_0.optionCount = #var_3

			arg_41_0:SetOptionPanelActive(true)

			local var_41_0 = arg_41_0.optionList

			var_4.make(var_41_0, function(arg_42_0, arg_42_1, arg_42_2)
				UIItemList = var_2_10003

				if arg_42_0 == var_2_10003.EventUpdate then
					local var_42_0 = var_0[arg_42_1 + 1]

					setText = var_4

					local var_42_1 = arg_42_2
					local var_42_2 = arg_42_2.Find(var_42_1, "Text")

					HXSet = var_42_1

					var_4(var_42_2, var_42_1.hxLan(var_42_0[2]))

					onButton = var_4

					local var_42_3 = arg_41_0
					local var_42_4 = arg_42_2

					local function var_42_5()
						local var_43_0 = arg_41_0
						local var_43_1 = var_0.emit

						Dorm3dChatMediator = var_3_10002

						var_43_1(var_43_0, var_3_10002.REPLY, arg_41_1.characterId, arg_41_1.topicId, arg_41_2[#arg_41_2].id, var_42_0[1])

						return
					end

					SFX_PANEL = var_2_10008

					var_4(var_42_3, var_42_4, var_42_5, var_2_10008)
				end

				return
			end)

			local var_41_1 = arg_41_0.optionList

			var_4.align(var_41_1, #var_3)

			goto label_41_0
		end
	end

	arg_41_0:SetOptionPanelActive(false)

	arg_41_0.shouldShowOption = false

	::label_41_0::

	return
end

function var_0_1.SetOptionPanelActive(arg_44_0, arg_44_1)
	SetActive = var_1_10002

	var_1_10002(arg_44_0.optionPanel, arg_44_1)

	local var_44_0 = arg_44_0.rightPanel
	local var_44_1 = var_2.Find(var_44_0, "messageScroll/Viewport/Content")
	local var_44_2 = var_2.GetComponent

	typeof = var_4
	VerticalLayoutGroup = var_1_10005

	local var_44_3 = var_44_2(var_44_1, var_4(var_1_10005))

	UnityEngine = var_44_1

	local var_44_4 = var_44_1.RectOffset.New()

	var_44_4.left = 0
	var_44_4.right = 0
	var_44_4.top = 0

	local var_44_5 = arg_44_0.rightPanel
	local var_44_6 = var_4.Find(var_44_5, "messageScroll/Scrollbar Vertical")
	local var_44_7 = var_4.GetComponent

	typeof = var_6
	RectTransform = var_1_10007

	local var_44_8 = var_44_7(var_44_6, var_6(var_1_10007))

	if arg_44_1 then
		var_44_4.bottom = 42 + 88 * arg_44_0.optionCount
		Vector2 = var_44_6
		var_44_8.sizeDelta = var_44_6(arg_44_0.messageScrollWidth, -var_44_4.bottom)
	else
		var_44_4.bottom = 50
		Vector2 = var_44_6
		var_44_8.sizeDelta = var_44_6(arg_44_0.messageScrollWidth, 0)
	end

	var_44_3.padding = var_44_4
	scrollToBottom = var_44_6

	local var_44_9 = arg_44_0.rightPanel

	var_44_6(var_6.Find(var_44_9, "messageScroll"))

	return
end

function var_0_1.SetTopicPanel(arg_45_0, arg_45_1)
	SetActive = var_1_10002

	local var_45_0 = arg_45_0.topicBtn

	var_1_10002(var_3.Find(var_45_0, "tip"), arg_45_1:GetCharacterEndFlagExceptCurrent() == 0)

	onButton = var_1_10002

	local var_45_1 = arg_45_0
	local var_45_2 = arg_45_0.topicBtn

	local function var_45_3()
		SetActive = var_2_10000

		var_2_10000(arg_45_0.topicUI, true)

		pg = var_2_10000

		local var_46_0 = var_2_10000.UIMgr.GetInstance()

		var_0.BlurPanel(var_46_0, arg_45_0.topicUI)

		local var_46_1 = arg_45_0

		var_46_1.currentTopic = nil
		UIItemList = var_46_1

		local var_46_2 = var_46_1.New
		local var_46_3 = arg_45_0.topicUI
		local var_46_4 = var_1.Find(var_46_3, "panel/topicScroll/Viewport/Content")
		local var_46_5 = arg_45_0.topicUI
		local var_46_6 = var_46_2(var_46_4, var_2.Find(var_46_5, "panel/topicScroll/Viewport/Content/topic"))

		var_0.make(var_46_6, function(arg_47_0, arg_47_1, arg_47_2)
			UIItemList = var_3_10003

			if arg_47_0 == var_3_10003.EventUpdate then
				local var_47_0 = arg_45_1

				var_3.SortTopicList(var_47_0)

				local var_47_1 = arg_45_1.topics[arg_47_1 + 1]

				setScrollText = var_4

				local var_47_2 = arg_47_2
				local var_47_3 = arg_47_2.Find(var_47_2, "mask/name")

				HXSet = var_47_2

				var_4(var_47_3, var_47_2.hxLan(var_47_1.name))

				SetActive = var_4

				var_4(arg_47_2:Find("lock"), not var_47_1.active)

				SetActive = var_4

				local var_47_4 = arg_47_2:Find("waiting")
				local var_47_5

				if var_47_1.active then
					var_47_5 = var_47_1:isWaiting()
				end

				var_4(var_47_4, var_47_5)

				SetActive = var_4

				local var_47_6 = arg_47_2:Find("complete")
				local var_47_7

				if var_47_1.active then
					var_47_7 = var_47_1:IsCompleted()
				end

				var_4(var_47_6, var_47_7)

				SetActive = var_4

				var_4(arg_47_2:Find("selectedFrame"), arg_45_1.currentTopicId == var_47_1.topicId)

				SetActive = var_4

				var_4(arg_47_2:Find("selected"), arg_45_1.currentTopicId == var_47_1.topicId)

				SetActive = var_4

				local var_47_8 = arg_47_2:Find("tip")
				local var_47_9

				if var_47_1.active then
					var_47_9 = not var_47_1:IsCompleted()
				end

				var_4(var_47_8, var_47_9)

				if arg_45_1.currentTopicId == var_47_1.topicId then
					arg_45_0.currentTopic = var_47_1
				end

				if var_47_1.active then
					onButton = var_4

					local var_47_10 = arg_45_0
					local var_47_11 = arg_47_2

					local function var_47_12()
						SetActive = var_4_10000

						local var_48_0 = arg_47_2

						var_4_10000(var_1.Find(var_48_0, "selectedFrame"), true)

						for iter_48_0 = 1, #arg_45_1.topics do
							if iter_48_0 ~= arg_47_1 + 1 then
								SetActive = var_4

								local var_48_1 = arg_45_0.topicUI
								local var_48_2 = var_5.Find(var_48_1, "panel/topicScroll/Viewport/Content")
								local var_48_3 = var_5.GetChild(var_48_2, iter_48_0 - 1)

								var_4(var_5.Find(var_48_3, "selectedFrame"), false)
							end
						end

						arg_45_0.currentTopic = var_47_1

						return
					end

					SFX_PANEL = var_3_10008

					var_4(var_47_10, var_47_11, var_47_12, var_3_10008)
				else
					onButton = var_4

					local var_47_13 = arg_45_0
					local var_47_14 = arg_47_2

					local function var_47_15()
						pg = var_4_10000

						local var_49_0 = var_4_10000.TipsMgr.GetInstance()

						var_0.ShowTips(var_49_0, var_47_1.unlockDesc)

						return
					end

					SFX_PANEL = var_3_10008

					var_4(var_47_13, var_47_14, var_47_15, var_3_10008)
				end
			end

			return
		end)
		var_0:align(#arg_45_1.topics)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10002(var_45_1, var_45_2, var_45_3, var_1_10006)

	onButton = var_1_10002

	local var_45_4 = arg_45_0
	local var_45_5 = arg_45_0.topicUI
	local var_45_6 = var_4.Find(var_45_5, "bg")

	local function var_45_7()
		local var_50_0 = arg_45_0

		var_0.CloseTopicPanel(var_50_0)

		return
	end

	SFX_PANEL = var_6

	var_1_10002(var_45_4, var_45_6, var_45_7, var_6)

	onButton = var_1_10002

	local var_45_8 = arg_45_0
	local var_45_9 = arg_45_0.topicUI
	local var_45_10 = var_4.Find(var_45_9, "panel/bottom/close")

	local function var_45_11()
		local var_51_0 = arg_45_0

		var_0.CloseTopicPanel(var_51_0)

		return
	end

	SFX_PANEL = var_6

	var_1_10002(var_45_8, var_45_10, var_45_11, var_6)

	onButton = var_1_10002

	local var_45_12 = arg_45_0
	local var_45_13 = arg_45_0.topicUI
	local var_45_14 = var_4.Find(var_45_13, "panel/bottom/ok")

	local function var_45_15()
		local var_52_0 = arg_45_0
		local var_52_1 = var_0.emit

		Dorm3dChatMediator = var_2_10002

		var_52_1(var_52_0, var_2_10002.SET_CURRENT_TOPIC, arg_45_0.currentTopic.characterId, arg_45_0.currentTopic.topicId)

		local var_52_2 = arg_45_0

		var_0.CloseTopicPanel(var_52_2)

		local var_52_3 = arg_45_0.rightPanel
		local var_52_4 = var_0.GetComponent

		typeof = var_2
		Animation = var_3

		local var_52_5 = var_52_4(var_52_3, var_2(var_3))

		var_0.Stop(var_52_5)
		var_0:Play("anim_newinstagram_chat_right_in")

		return
	end

	SFX_PANEL = var_6

	var_1_10002(var_45_12, var_45_14, var_45_15, var_6)

	return
end

function var_0_1.CloseTopicPanel(arg_53_0)
	pg = var_1_10001

	local var_53_0 = var_1_10001.UIMgr.GetInstance()
	local var_53_1 = var_1.UnOverlayPanel
	local var_53_2 = arg_53_0.topicUI
	local var_53_3 = arg_53_0._tf

	var_53_1(var_53_0, var_53_2, var_4.Find(var_53_3, "subPages"))

	SetActive = var_53_1

	var_53_1(arg_53_0.topicUI, false)

	return
end

function var_0_1.SetBackgroundPanel(arg_54_0, arg_54_1)
	local var_54_0 = arg_54_1
	local var_54_1 = arg_54_1.GetPaintingId(var_54_0)

	onButton = var_54_0

	local var_54_2 = arg_54_0
	local var_54_3 = arg_54_0.backgroundBtn

	local function var_54_4()
		SetActive = var_2_10000

		var_2_10000(arg_54_0.backgroundUI, true)

		pg = var_2_10000

		local var_55_0 = var_2_10000.UIMgr.GetInstance()

		var_0.BlurPanel(var_55_0, arg_54_0.backgroundUI)

		arg_54_0.currentBgId = nil

		local var_55_1 = arg_54_1
		local var_55_2 = var_0.GetSkins(var_55_1)

		UIItemList = var_55_1

		local var_55_3 = var_55_1.New
		local var_55_4 = arg_54_0.backgroundUI
		local var_55_5 = var_2.Find(var_55_4, "panel/backgroundScroll/Viewport/Content")
		local var_55_6 = arg_54_0.backgroundUI
		local var_55_7 = var_55_3(var_55_5, var_3.Find(var_55_6, "panel/backgroundScroll/Viewport/Content/background"))

		var_1.make(var_55_7, function(arg_56_0, arg_56_1, arg_56_2)
			UIItemList = var_3_10003

			if arg_56_0 == var_3_10003.EventUpdate then
				local var_56_0 = var_55_2[arg_56_1 + 1]
				local var_56_1 = 0

				if var_56_0.id ~= var_54_1 then
					var_56_1 = var_56_0.id
				end

				local var_56_2 = var_56_0.painting

				LoadImageSpriteAsync = var_6

				var_6("herohrzicon/" .. var_56_2, arg_56_2:Find("skinMask/skin"), false)

				setScrollText = var_6

				var_6(arg_56_2:Find("skinMask/Panel/mask/Text"), var_56_0.name)

				getProxy = var_6
				ShipSkinProxy = var_7

				local var_56_3 = var_6(var_7)
				local var_56_4

				if not var_6.hasSkin(var_56_3, var_56_0.id) then
					var_56_4 = var_56_0.skin_type
					ShipSkin = var_56_3

					if var_56_4 ~= var_56_3.SKIN_TYPE_DEFAULT then
						var_56_4 = var_56_0.skin_type
						ShipSkin = var_56_3

						if var_56_4 ~= var_56_3.SKIN_TYPE_PROPOSE then
							var_56_4 = var_56_0.skin_type
							ShipSkin = var_56_3

							if var_56_4 ~= var_56_3.SKIN_TYPE_REMAKE then
								var_56_4 = false

								goto label_56_0
							end
						end
					end

					var_56_4 = true
				end

				::label_56_0::

				SetActive = var_56_3

				var_56_3(arg_56_2:Find("lockFrame"), not var_56_4)

				SetActive = var_56_3

				var_56_3(arg_56_2:Find("selectedFrame"), arg_54_1.skinId == var_56_1)

				SetActive = var_56_3

				var_56_3(arg_56_2:Find("selected"), arg_54_1.skinId == var_56_1)

				local var_56_5

				if arg_54_1.skinId == var_56_1 then
					var_56_5 = arg_54_0
					var_56_5.currentBgId = var_56_1
				end

				onButton = var_56_5

				local var_56_6 = arg_54_0
				local var_56_7 = arg_56_2

				local function var_56_8()
					local var_57_3

					if var_56_4 then
						SetActive = var_57_3
						var_4_10002 = arg_56_2

						var_57_3(var_1.Find(var_4_10002, "selectedFrame"), true)

						for iter_57_0 = 1, #var_55_2 do
							if iter_57_0 ~= arg_56_1 + 1 then
								local var_57_0 = arg_54_0.backgroundUI
								local var_57_1 = var_4.Find(var_57_0, "panel/backgroundScroll/Viewport/Content")
								local var_57_2 = var_4.GetChild(var_57_1, iter_57_0 - 1)

								SetActive = var_57_1

								var_57_1(var_57_2:Find("selectedFrame"), false)
							end
						end

						var_57_3 = arg_54_0
						var_57_3.currentBgId = var_56_1
					else
						pg = var_57_3

						local var_57_4 = var_57_3.TipsMgr.GetInstance()
						local var_57_5 = var_0.ShowTips

						i18n = var_4_10002

						var_57_5(var_57_4, var_4_10002("juuschat_background_tip2"))
					end

					return
				end

				SFX_PANEL = var_3_10011

				var_56_5(var_56_6, var_56_7, var_56_8, var_3_10011)
			end

			return
		end)
		var_1:align(#var_55_2)

		return
	end

	SFX_PANEL = var_1_10007

	var_54_0(var_54_2, var_54_3, var_54_4, var_1_10007)

	onButton = var_54_0

	local var_54_5 = arg_54_0
	local var_54_6 = arg_54_0.backgroundUI
	local var_54_7 = var_5.Find(var_54_6, "bg")

	local function var_54_8()
		local var_58_0 = arg_54_0

		var_0.CloseBackgroundPanel(var_58_0)

		return
	end

	SFX_PANEL = var_7

	var_54_0(var_54_5, var_54_7, var_54_8, var_7)

	onButton = var_54_0

	local var_54_9 = arg_54_0
	local var_54_10 = arg_54_0.backgroundUI
	local var_54_11 = var_5.Find(var_54_10, "panel/bottom/close")

	local function var_54_12()
		local var_59_0 = arg_54_0

		var_0.CloseBackgroundPanel(var_59_0)

		return
	end

	SFX_PANEL = var_7

	var_54_0(var_54_9, var_54_11, var_54_12, var_7)

	onButton = var_54_0

	local var_54_13 = arg_54_0
	local var_54_14 = arg_54_0.backgroundUI
	local var_54_15 = var_5.Find(var_54_14, "panel/bottom/ok")

	local function var_54_16()
		local var_60_0 = arg_54_0
		local var_60_1 = var_0.emit

		Dorm3dChatMediator = var_2_10002

		var_60_1(var_60_0, var_2_10002.SET_CURRENT_BACKGROUND, arg_54_1.characterId, arg_54_0.currentBgId)

		local var_60_2 = arg_54_0

		var_0.CloseBackgroundPanel(var_60_2)

		return
	end

	SFX_PANEL = var_7

	var_54_0(var_54_13, var_54_15, var_54_16, var_7)

	return
end

function var_0_1.CloseBackgroundPanel(arg_61_0)
	pg = var_1_10001

	local var_61_0 = var_1_10001.UIMgr.GetInstance()
	local var_61_1 = var_1.UnOverlayPanel
	local var_61_2 = arg_61_0.backgroundUI
	local var_61_3 = arg_61_0._tf

	var_61_1(var_61_0, var_61_2, var_4.Find(var_61_3, "subPages"))

	SetActive = var_61_1

	var_61_1(arg_61_0.backgroundUI, false)

	return
end

function var_0_1.SetRedPacketPanel(arg_62_0, arg_62_1, arg_62_2, arg_62_3, arg_62_4, arg_62_5, arg_62_6, arg_62_7)
	onButton = var_1_10008

	local var_62_0 = arg_62_0
	local var_62_1 = arg_62_1

	local function var_62_2()
		SetActive = var_2_10000

		var_2_10000(arg_62_0.redPacketUI, true)

		pg = var_2_10000

		local var_63_0 = var_2_10000.UIMgr.GetInstance()

		var_0.BlurPanel(var_63_0, arg_62_0.redPacketUI)

		setImageSprite = var_0

		local var_63_1 = arg_62_0.redPacketUI
		local var_63_2 = var_1.Find(var_63_1, "panel/charaBg/chara")

		LoadSprite = var_63_1

		var_0(var_63_2, var_63_1("qicon/" .. arg_62_4), false)

		if not arg_62_3 then
			SetActive = var_0

			local var_63_3 = arg_62_0.redPacketUI

			var_0(var_1.Find(var_63_3, "panel/get"), true)

			SetActive = var_0

			local var_63_4 = arg_62_0.redPacketUI

			var_0(var_1.Find(var_63_4, "panel/got"), false)

			SetActive = var_0

			local var_63_5 = arg_62_0.redPacketUI

			var_0(var_1.Find(var_63_5, "panel/detail"), false)

			setText = var_0

			local var_63_6 = arg_62_0.redPacketUI

			var_0(var_1.Find(var_63_6, "panel/get/titleBg/title"), arg_62_2.desc)

			onButton = var_0

			local var_63_7 = arg_62_0
			local var_63_8 = arg_62_0.redPacketUI
			local var_63_9 = var_2.Find(var_63_8, "panel/get/getBtn")

			local function var_63_10()
				local var_64_0 = arg_62_0
				local var_64_1 = var_0.emit

				Dorm3dChatMediator = var_3_10002

				var_64_1(var_64_0, var_3_10002.GET_REDPACKET, arg_62_5, arg_62_6, arg_62_7, arg_62_2.id)

				return
			end

			SFX_PANEL = var_4

			var_0(var_63_7, var_63_9, var_63_10, var_4)
		else
			local var_63_11 = arg_62_0

			var_0.UpdateRedPacketUI(var_63_11, arg_62_2.id)
		end

		return
	end

	SFX_PANEL = var_1_10012

	var_1_10008(var_62_0, var_62_1, var_62_2, var_1_10012)

	onButton = var_1_10008

	local var_62_3 = arg_62_0
	local var_62_4 = arg_62_0.redPacketUI
	local var_62_5 = var_10.Find(var_62_4, "bg")

	local function var_62_6()
		local var_65_0 = arg_62_0

		var_0.CloseRedPacketPanel(var_65_0)

		if arg_62_0.canFresh then
			arg_62_0.canFresh = false

			local var_65_1 = arg_62_0.currentChat.currentTopic

			if var_0[#var_0.GetDisplayWordList(var_65_1)].type == 0 then
				local var_65_2 = arg_62_0

				var_1.UpdateChat(var_65_2, false, false)
			else
				local var_65_3 = arg_62_0

				var_1.UpdateChat(var_65_3, true, false)
			end
		end

		return
	end

	SFX_PANEL = var_12

	var_1_10008(var_62_3, var_62_5, var_62_6, var_12)

	return
end

function var_0_1.UpdateRedPacketUI(arg_66_0, arg_66_1)
	local var_66_0 = var_0_3[arg_66_1]

	SetActive = var_1_10003

	local var_66_1 = arg_66_0.redPacketUI

	var_1_10003(var_4.Find(var_66_1, "panel/get"), false)

	SetActive = var_1_10003

	local var_66_2 = arg_66_0.redPacketUI

	var_1_10003(var_4.Find(var_66_2, "panel/got"), true)

	SetActive = var_1_10003

	local var_66_3 = arg_66_0.redPacketUI

	var_1_10003(var_4.Find(var_66_3, "panel/detail"), false)

	Drop = var_1_10003

	local var_66_4 = var_1_10003.Create(var_66_0.content)

	var_66_4.count = 0
	updateDrop = var_4

	local var_66_5 = arg_66_0.redPacketUI

	var_4(var_5.Find(var_66_5, "panel/got/item"), var_66_4)

	onButton = var_4

	local var_66_6 = arg_66_0
	local var_66_7 = arg_66_0.redPacketUI
	local var_66_8 = var_6.Find(var_66_7, "panel/got/item")

	local function var_66_9()
		local var_67_0 = arg_66_0
		local var_67_1 = var_0.emit

		BaseUI = var_2_10002

		var_67_1(var_67_0, var_2_10002.ON_DROP, var_66_4)

		return
	end

	SFX_PANEL = var_8

	var_4(var_66_6, var_66_8, var_66_9, var_8)

	local var_66_10 = arg_66_0.redPacketUI
	local var_66_11 = var_4.Find(var_66_10, "panel/got/item/icon_bg")
	local var_66_12 = var_4.GetComponent

	typeof = var_6
	Image = var_66_9
	var_66_12(var_66_11, var_6(var_66_9)).enabled = false

	local var_66_13 = arg_66_0.redPacketUI
	local var_66_14 = var_4.Find(var_66_13, "panel/got/item/icon_bg/frame")
	local var_66_15 = var_4.GetComponent

	typeof = var_6
	Image = var_66_9

	local var_66_16 = var_66_15(var_66_14, var_6(var_66_9))

	var_66_16.enabled = false
	setText = var_66_16

	local var_66_17 = arg_66_0.redPacketUI

	var_66_16(var_5.Find(var_66_17, "panel/got/awardCount"), var_66_0.content[3])

	return
end

function var_0_1.CloseRedPacketPanel(arg_68_0)
	pg = var_1_10001

	local var_68_0 = var_1_10001.UIMgr.GetInstance()
	local var_68_1 = var_1.UnOverlayPanel
	local var_68_2 = arg_68_0.redPacketUI
	local var_68_3 = arg_68_0._tf

	var_68_1(var_68_0, var_68_2, var_4.Find(var_68_3, "subPages"))

	SetActive = var_68_1

	var_68_1(arg_68_0.redPacketUI, false)

	return
end

function var_0_1.SetPicturePanel(arg_69_0, arg_69_1, arg_69_2)
	onButton = var_1_10003

	local var_69_0 = arg_69_0
	local var_69_1 = arg_69_1

	local function var_69_2()
		setActive = var_2_10000

		var_2_10000(arg_69_0.pictureUI, true)

		pg = var_2_10000

		local var_70_0 = var_2_10000.UIMgr.GetInstance()

		var_0.BlurPanel(var_70_0, arg_69_0.pictureUI)

		setImageSprite = var_0

		local var_70_1 = arg_69_0.pictureUI
		local var_70_2 = var_1.Find(var_70_1, "picture")

		LoadSprite = var_70_1

		var_0(var_70_2, var_70_1("dorm3dprivatechat/" .. arg_69_2), true)

		return
	end

	SFX_PANEL = var_1_10007

	var_1_10003(var_69_0, var_69_1, var_69_2, var_1_10007)

	onButton = var_1_10003

	local var_69_3 = arg_69_0
	local var_69_4 = arg_69_0.pictureUI
	local var_69_5 = var_5.Find(var_69_4, "bg")

	local function var_69_6()
		local var_71_0 = arg_69_0

		var_0.ClosePicturePanel(var_71_0)

		return
	end

	SFX_PANEL = var_7

	var_1_10003(var_69_3, var_69_5, var_69_6, var_7)

	onButton = var_1_10003

	local var_69_7 = arg_69_0
	local var_69_8 = arg_69_0.pictureUI
	local var_69_9 = var_5.Find(var_69_8, "closeBtn")

	local function var_69_10()
		local var_72_0 = arg_69_0

		var_0.ClosePicturePanel(var_72_0)

		return
	end

	SFX_PANEL = var_7

	var_1_10003(var_69_7, var_69_9, var_69_10, var_7)

	return
end

function var_0_1.ClosePicturePanel(arg_73_0)
	pg = var_1_10001

	local var_73_0 = var_1_10001.UIMgr.GetInstance()
	local var_73_1 = var_1.UnOverlayPanel
	local var_73_2 = arg_73_0.pictureUI
	local var_73_3 = arg_73_0._tf

	var_73_1(var_73_0, var_73_2, var_4.Find(var_73_3, "subPages"))

	SetActive = var_73_1

	var_73_1(arg_73_0.pictureUI, false)

	return
end

function var_0_1.SetData(arg_74_0)
	getProxy = var_1_10001
	Dorm3dChatProxy = var_1_10002

	local var_74_0 = var_1_10001(var_1_10002)

	arg_74_0.currentChat = var_1.GetCharacterChatById(var_74_0, arg_74_0.contextData.chatId)
	getProxy = var_1
	Dorm3dChatProxy = var_74_0

	local var_74_1 = var_1(var_74_0)

	var_1.AutoChangeCurrentTopic(var_74_1, arg_74_0.currentChat)

	return
end

function var_0_1.willExit(arg_75_0)
	local var_75_0 = arg_75_0.rightPanel
	local var_75_1 = var_1.Find(var_75_0, "paintingMask/painting")

	if arg_75_0.paintingName then
		retPaintingPrefab = var_2

		var_2(var_75_1, arg_75_0.paintingName)

		arg_75_0.paintingName = nil
	end

	arg_75_0:RemoveAllTimer()

	return
end

function var_0_1.StartTimer(arg_76_0, arg_76_1, arg_76_2)
	Timer = var_1_10003

	local var_76_0 = var_1_10003.New(arg_76_1, arg_76_2, 1)

	var_3.Start(var_76_0)

	table = var_4

	var_4.insert(arg_76_0.timerList, var_3)

	return
end

function var_0_1.RemoveAllTimer(arg_77_0)
	ipairs = var_1_10001

	for iter_77_0, iter_77_1 in var_1_10001(arg_77_0.timerList) do
		iter_77_1:Stop()
	end

	arg_77_0.timerList = {}

	return
end

function var_0_1.StartTimer2(arg_78_0, arg_78_1, arg_78_2)
	Timer = var_1_10003
	arg_78_0.timer = var_1_10003.New(arg_78_1, arg_78_2, 1)

	local var_78_0 = arg_78_0.timer

	var_3.Start(var_78_0)

	return
end

function var_0_1.SpeedUpMessage(arg_79_0)
	pg = var_1_10001

	local var_79_0 = var_1_10001.gameset.juuschat_dialogue_trigger_time.key_value / 1000

	pg = var_1_10002

	local var_79_1 = var_1_10002.gameset.juuschat_entering_time.key_value / 1000

	ipairs = var_1_10003

	for iter_79_0, iter_79_1 in var_1_10003(arg_79_0.timerList) do
		if iter_79_1.running then
			if iter_79_1.duration == var_79_1 then
				iter_79_1.time = 0.05
			elseif iter_79_1.time - var_79_0 < 0.05 then
				iter_79_1.time = 0.05

				arg_79_0:StartTimer2(function()
					local var_80_0 = arg_79_0

					var_0.SpeedUpWaiting(var_80_0)

					return
				end, 0.05)
			else
				iter_79_1.time = iter_79_1.time - var_79_0
			end
		end
	end

	return
end

function var_0_1.SpeedUpWaiting(arg_81_0)
	pg = var_1_10001

	local var_81_0 = var_1_10001.gameset.juuschat_entering_time.key_value / 1000

	ipairs = var_1_10002

	for iter_81_0, iter_81_1 in var_1_10002(arg_81_0.timerList) do
		if iter_81_1.running and iter_81_1.duration == var_81_0 then
			iter_81_1.time = 0.05

			break
		end
	end

	return
end

function var_0_1.ChangeFresh(arg_82_0)
	arg_82_0.canFresh = true

	return
end

function var_0_1.SetEndAniEvent(arg_83_0, arg_83_1, arg_83_2)
	local var_83_0 = arg_83_1
	local var_83_1 = arg_83_1.GetComponent

	typeof = var_1_10005
	DftAniEvent = var_1_10006

	if var_83_1(var_83_0, var_1_10005(var_1_10006)) then
		var_3:SetEndEvent(function()
			arg_83_2()

			local var_84_0 = var_0

			var_0.SetEndEvent(var_84_0, nil)

			return
		end)
	end

	return
end

function var_0_1.onBackPressed(arg_85_0)
	isActive = var_1_10001

	if var_1_10001(arg_85_0.topicUI) then
		arg_85_0:CloseTopicPanel()

		return
	end

	isActive = var_1

	if var_1(arg_85_0.backgroundUI) then
		arg_85_0:CloseBackgroundPanel()

		return
	end

	isActive = var_1

	if var_1(arg_85_0.redPacketUI) then
		arg_85_0:CloseRedPacketPanel()

		return
	end

	isActive = var_1

	if var_1(arg_85_0.pictureUI) then
		arg_85_0:ClosePicturePanel()

		return
	end

	arg_85_0:closeView()

	return
end

return var_0_1
