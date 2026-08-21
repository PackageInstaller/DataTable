local var_0_0 = class("InstagramChatLayer", import("...base.BaseUI"))
local var_0_1 = pg.activity_ins_ship_group_template
local var_0_2 = pg.activity_ins_redpackage
local var_0_3 = pg.emoji_template

function var_0_0.getUIName(arg_1_0)
	return "InstagramChatUI"
end

function var_0_0.getGroupName(arg_2_0)
	return "InstagramMainUI"
end

var_0_0.ReadType = {
	"all",
	"hasReaded",
	"waitingForRead"
}
var_0_0.TypeType = {
	"all",
	"single",
	"multiple"
}
var_0_0.CampIds = {
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
var_0_0.CampNames = {
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

function var_0_0.init(arg_3_0)
	arg_3_0.leftPanel = arg_3_0._tf:Find("main/leftPanel")
	arg_3_0.filterBtn = arg_3_0.leftPanel:Find("leftTop/filter")
	arg_3_0.isFiltered = arg_3_0.filterBtn:Find("isFiltered")
	arg_3_0.charaScrollrect = arg_3_0.leftPanel:Find("charaScroll"):GetComponent("LScrollRect")
	arg_3_0.charaScrollContent = arg_3_0.leftPanel:Find("charaScroll/Viewport/Content")
	arg_3_0.rightPanel = arg_3_0._tf:Find("main/rightPanel")
	arg_3_0.rightChatPanel = arg_3_0.rightPanel:Find("chat")
	arg_3_0.rightOfficialAccountsPanel = arg_3_0.rightPanel:Find("officialAccounts")
	arg_3_0.characterName = arg_3_0.rightPanel:Find("chat/rightTop/name")
	arg_3_0.careBtn = arg_3_0.rightPanel:Find("chat/rightTop/careBtn")
	arg_3_0.topicBtn = arg_3_0.rightPanel:Find("chat/rightTop/topicBtn")
	arg_3_0.backgroundBtn = arg_3_0.rightPanel:Find("chat/rightTop/backgroundBtn")
	arg_3_0.messageList = UIItemList.New(arg_3_0.rightPanel:Find("chat/messageScroll/Viewport/Content"), arg_3_0.rightPanel:Find("chat/messageScroll/Viewport/Content/messageCard"))
	arg_3_0.optionPanel = arg_3_0.rightPanel:Find("chat/optionPanel")
	arg_3_0.optionList = UIItemList.New(arg_3_0.optionPanel, arg_3_0.optionPanel:Find("option"))
	arg_3_0.filterUI = arg_3_0._tf:Find("subPages/InstagramFilterUI")
	arg_3_0.topicUI = arg_3_0._tf:Find("subPages/InstagramTopicUI")
	arg_3_0.backgroundUI = arg_3_0._tf:Find("subPages/InstagramBackgroundUI")
	arg_3_0.redPacketUI = arg_3_0._tf:Find("subPages/InstagramRedPacketUI")

	setText(arg_3_0.filterBtn:Find("Text"), i18n("juuschat_filter_title"))
	setText(arg_3_0.filterUI:Find("panel/filterScroll/Viewport/Content/read/subTitleFrame/subTitle"), i18n("juuschat_filter_subtitle1"))
	setText(arg_3_0.filterUI:Find("panel/filterScroll/Viewport/Content/type/subTitleFrame/subTitle"), i18n("juuschat_filter_subtitle2"))
	setText(arg_3_0.filterUI:Find("panel/filterScroll/Viewport/Content/subTitleFrame/subTitle"), i18n("juuschat_filter_subtitle3"))
	setText(arg_3_0.filterUI:Find("panel/filterScroll/Viewport/Content/read/option/Text"), i18n("juuschat_filter_tip1"))
	setText(arg_3_0.filterUI:Find("panel/filterScroll/Viewport/Content/read/option_1/Text"), i18n("juuschat_filter_tip2"))
	setText(arg_3_0.filterUI:Find("panel/filterScroll/Viewport/Content/read/option_2/Text"), i18n("juuschat_filter_tip3"))
	setText(arg_3_0.filterUI:Find("panel/filterScroll/Viewport/Content/type/option/Text"), i18n("juuschat_filter_tip1"))
	setText(arg_3_0.filterUI:Find("panel/filterScroll/Viewport/Content/type/option_1/Text"), i18n("juuschat_filter_tip4"))
	setText(arg_3_0.filterUI:Find("panel/filterScroll/Viewport/Content/type/option_2/Text"), i18n("juuschat_filter_tip5"))
	setText(arg_3_0.topicUI:Find("panel/topicScroll/Viewport/Content/self/topic/waiting"), i18n("juuschat_chattip3"))
	setText(arg_3_0.topicUI:Find("panel/topicScroll/Viewport/Content/self/topic/selected/Text"), i18n("juuschat_label2"))
	setText(arg_3_0.topicUI:Find("panel/topicScroll/Viewport/Content/other/topic/waiting"), i18n("juuschat_chattip3"))
	setText(arg_3_0.topicUI:Find("panel/topicScroll/Viewport/Content/other/topic/selected/Text"), i18n("juuschat_label2"))
	setText(arg_3_0.backgroundUI:Find("panel/backgroundScroll/Viewport/Content/background/selected/Text"), i18n("juuschat_label1"))
	setText(arg_3_0.redPacketUI:Find("panel/got/detailBtn/Text"), i18n("juuschat_redpacket_show_detail"))
	setText(arg_3_0.redPacketUI:Find("panel/detail/title"), i18n("juuschat_redpacket_detail"))
	setText(arg_3_0._tf:Find("main/noFilteredMessageBg/Text"), i18n("juuschat_filter_empty"))
	setText(arg_3_0.backgroundUI:Find("panel/backgroundScroll/Viewport/Content/background/lockFrame/Text"), i18n("juuschat_background_tip1"))

	arg_3_0.redPacketGot = arg_3_0.redPacketUI:Find("panel/got")

	arg_3_0:OverlayPanel(arg_3_0._tf)
	SetActive(arg_3_0.filterUI, false)
	SetActive(arg_3_0.isFiltered, false)
	SetActive(arg_3_0.topicUI, false)
	SetActive(arg_3_0.backgroundUI, false)
	SetActive(arg_3_0.redPacketUI, false)
	SetActive(arg_3_0.rightPanel, false)

	arg_3_0.timerList = {}
	arg_3_0.canFresh = false

	local var_3_0 = arg_3_0.rightPanel:Find("chat/messageScroll/Scrollbar Vertical"):GetComponent(typeof(RectTransform))

	arg_3_0.messageScrollWidth = var_3_0.rect.width
	arg_3_0.messageScrollHeight = var_3_0.rect.height

	arg_3_0.filterUI:Find("panel/title"):GetComponent(typeof(Image)):SetNativeSize()
	arg_3_0.topicUI:Find("panel/title"):GetComponent(typeof(Image)):SetNativeSize()
	arg_3_0.backgroundUI:Find("panel/title"):GetComponent(typeof(Image)):SetNativeSize()
	arg_3_0:InitOfficialAccounts()

	return
end

function var_0_0.didEnter(arg_4_0)
	arg_4_0:SetData()

	function arg_4_0.charaScrollrect.onInitItem(arg_5_0)
		arg_4_0:OnInitItem(arg_5_0)

		return
	end

	function arg_4_0.charaScrollrect.onUpdateItem(arg_6_0, arg_6_1)
		arg_4_0:OnUpdateItem(arg_6_0, arg_6_1)

		return
	end

	arg_4_0:UpdateCharaList(false, false)
	arg_4_0:SetFilterPanel()

	arg_4_0.officialAccountsTimerList = {}
	arg_4_0.officialAccountsItemList = {}

	arg_4_0:AddOfficialAccountsTimer()

	return
end

function var_0_0.InsertOfficialAccounts(arg_7_0)
	if InstagramTools.ExistOfficialAccounts() then
		table.insert(arg_7_0.chatList, 1, {
			chatType = InstagramConst.INSTAGRAM_CHAT_TYPE.OFFICIAL_ACCOUNT
		})
	end

	return
end

function var_0_0.OnInitItem(arg_8_0, arg_8_1)
	return
end

function var_0_0.OnUpdateItem(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0.chatList[arg_9_1 + 1]
	local var_9_1 = tf(arg_9_2)

	setActive(var_9_1, true)

	local var_9_2 = var_9_0.chatType == InstagramConst.INSTAGRAM_CHAT_TYPE.OFFICIAL_ACCOUNT

	setActive(var_9_1:Find("chat"), not (var_9_0.chatType == InstagramConst.INSTAGRAM_CHAT_TYPE.OFFICIAL_ACCOUNT))
	setActive(var_9_1:Find("officialAccounts"), var_9_2)

	if not var_9_2 then
		local var_9_3 = var_9_0.sculpture

		if var_9_0.currentTopic.isII and var_9_0.sculptureII ~= "" then
			var_9_3 = var_9_0.sculptureII
		end

		setImageSprite(var_9_1:Find("chat/charaBg/chara"), LoadSprite("qicon/" .. var_9_3), false)
		setText(var_9_1:Find("chat/name"), var_9_0.name)

		local var_9_4 = var_9_0:GetDisplayWord()

		if not arg_9_0.currentChat or arg_9_0.currentChat.characterId ~= var_9_0.characterId or not arg_9_0.isSlowMsg then
			setText(var_9_1:Find("chat/msg"), var_9_4)
		end

		setText(var_9_1:Find("chat/displayWord"), var_9_4)
		SetActive(var_9_1:Find("chat/care"), var_9_0.care == 1)

		if var_9_0.care == 1 and arg_9_0.careAniTriggerId and arg_9_0.careAniTriggerId == var_9_0.characterId then
			arg_9_0.careAniTriggerId = nil

			var_9_1:Find("chat/care"):GetComponent(typeof(Animation)):Play("anim_newinstagram_care")
		end

		SetActive(var_9_1:Find("chat/tip"), var_9_0:GetCharacterEndFlag() == 0)
		setText(var_9_1:Find("chat/id"), var_9_0.characterId)
		onButton(arg_9_0, var_9_1, function()
			if arg_9_0.currentChat and arg_9_0.currentChat.characterId ~= var_9_0.characterId then
				arg_9_0:ResetCharaTextFunc(arg_9_0.currentChat.characterId)
			end

			arg_9_0.currentChat = var_9_0

			SetActive(arg_9_0.rightPanel, true)
			SetActive(arg_9_0._tf:Find("main/rightNoMessageBg"), false)
			arg_9_0:UpdateChatContent(var_9_0, false, false)
			arg_9_0:SetTopicPanel(var_9_0)
			arg_9_0:SetBackgroundPanel(var_9_0)

			for iter_10_0 = 0, arg_9_0.charaScrollContent.childCount - 1 do
				local var_10_0 = arg_9_0.charaScrollContent:GetChild(iter_10_0)

				SetActive(var_10_0:Find("frame"), false)
			end

			SetActive(var_9_1:Find("frame"), true)

			function arg_9_0.cancelFrame()
				if not IsNil(var_9_1) then
					SetActive(var_9_1:Find("frame"), false)
				end

				return
			end

			local var_10_1 = arg_9_0.rightPanel:GetComponent(typeof(Animation))

			var_10_1:Stop()
			var_10_1:Play("anim_newinstagram_chat_right_in")

			return
		end, SFX_PANEL)
	else
		SetActive(var_9_1:Find("officialAccounts/tip"), getProxy(InstagramProxy):ShouldShowOfficialAccountsTip())
		onButton(arg_9_0, var_9_1, function()
			SetActive(arg_9_0.rightPanel, true)
			SetActive(arg_9_0._tf:Find("main/rightNoMessageBg"), false)

			for iter_12_0 = 0, arg_9_0.charaScrollContent.childCount - 1 do
				local var_12_0 = arg_9_0.charaScrollContent:GetChild(iter_12_0)

				SetActive(var_12_0:Find("frame"), false)
			end

			SetActive(var_9_1:Find("frame"), true)

			function arg_9_0.cancelFrame()
				if not IsNil(var_9_1) then
					SetActive(var_9_1:Find("frame"), false)
				end

				return
			end

			arg_9_0.currentChat = var_9_0

			arg_9_0:UpdateOfficialAccounts(var_9_0)

			local var_12_1 = arg_9_0.rightPanel:GetComponent(typeof(Animation))

			var_12_1:Stop()
			var_12_1:Play("anim_newinstagram_chat_right_in")

			return
		end, SFX_PANEL)
	end

	if arg_9_0.currentChat then
		SetActive(var_9_1:Find("frame"), arg_9_0.currentChat == var_9_0)
	end

	return
end

function var_0_0.UpdateCharaList(arg_14_0, arg_14_1, arg_14_2)
	if not arg_14_0.chatList or #arg_14_0.chatList == 0 then
		SetActive(arg_14_0.leftPanel, false)
		SetActive(arg_14_0.rightPanel, false)
		SetActive(arg_14_0._tf:Find("main/noMessageBg"), true)
		SetActive(arg_14_0._tf:Find("main/noFilteredMessageBg"), false)
		SetActive(arg_14_0._tf:Find("main/rightNoMessageBg"), false)

		return
	end

	if not arg_14_0.currentChat then
		SetActive(arg_14_0.rightPanel, false)
		SetActive(arg_14_0._tf:Find("main/rightNoMessageBg"), true)
	else
		SetActive(arg_14_0.rightPanel, true)
		SetActive(arg_14_0._tf:Find("main/rightNoMessageBg"), false)
	end

	arg_14_0.isSlowMsg = arg_14_1

	arg_14_0:SetFilterResult()

	if arg_14_0.currentChat then
		if arg_14_0.currentChat.chatType == InstagramConst.INSTAGRAM_CHAT_TYPE.OFFICIAL_ACCOUNT then
			arg_14_0:UpdateOfficialAccounts(arg_14_0.currentChat)
		else
			arg_14_0:UpdateChatContent(arg_14_0.currentChat, arg_14_1, arg_14_2)
			arg_14_0:SetTopicPanel(arg_14_0.currentChat)
		end
	end

	return
end

function var_0_0.UpdateChatContent(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	setActive(arg_15_0.rightChatPanel, true)
	setActive(arg_15_0.rightOfficialAccountsPanel, false)
	SetActive(arg_15_0.rightPanel, true)
	setText(arg_15_0.characterName, arg_15_1.name)
	SetActive(arg_15_0.careBtn:Find("care"), arg_15_1.care == 1)
	onButton(arg_15_0, arg_15_0.careBtn, function()
		arg_15_0:emit(InstagramChatMediator.CHANGE_CARE, arg_15_1.characterId, arg_15_1.care == 0 and 1 or 0)

		arg_15_0.careAniTriggerId = arg_15_1.characterId

		return
	end, SFX_PANEL)

	local var_15_0 = arg_15_0.rightPanel:Find("chat/paintingMask")
	local var_15_1 = var_15_0:Find("painting")
	local var_15_2 = arg_15_0.rightPanel:Find("chat/groupBackground")

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

		if not arg_15_0.paintingName then
			setPaintingPrefabAsync(var_15_1, var_15_3, "pifu")

			arg_15_0.paintingName = var_15_3
		elseif arg_15_0.paintingName and arg_15_0.paintingName ~= var_15_3 then
			retPaintingPrefab(var_15_1, arg_15_0.paintingName)
			setPaintingPrefabAsync(var_15_1, var_15_3, "pifu")

			arg_15_0.paintingName = var_15_3
		end
	else
		SetActive(var_15_0, false)
		SetActive(var_15_2, true)

		if arg_15_0.paintingName then
			retPaintingPrefab(var_15_1, arg_15_0.paintingName)

			arg_15_0.paintingName = nil
		end

		setImageSprite(var_15_2, LoadSprite("ui/InstagramChatBackgrounds_atlas", arg_15_1.groupBackground), true)
	end

	local var_15_4 = arg_15_1.currentTopic:GetDisplayWordList()

	if not arg_15_3 then
		arg_15_0:UpdateOptionPanel(arg_15_1.currentTopic, var_15_4)
		arg_15_0:UpdateMessageList(arg_15_1.currentTopic, var_15_4, arg_15_2, arg_15_1.characterId, arg_15_1.type)
	end

	if not arg_15_2 and arg_15_1.currentTopic.readFlag == 0 then
		arg_15_0:emit(InstagramChatMediator.SET_READED, {
			arg_15_1.currentTopic.topicId
		})
	end

	return
end

function var_0_0.UpdateMessageList(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4, arg_17_5)
	arg_17_0:RemoveAllTimer()

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

	if arg_17_0.shouldShowOption and arg_17_3 then
		arg_17_0:SetOptionPanelActive(false)
	end

	if arg_17_3 then
		onButton(arg_17_0, arg_17_0.rightPanel:Find("chat/messageScroll"), function()
			arg_17_0:SpeedUpMessage()

			return
		end, SFX_PANEL)
	end

	local var_17_2 = GetComponent(arg_17_0.rightPanel:Find("chat/messageScroll"), typeof(ScrollRect))

	local function var_17_3(arg_19_0)
		var_17_2.normalizedPosition = Vector2(0, arg_19_0)

		return
	end

	local var_17_4 = pg.gameset.juuschat_dialogue_trigger_time.key_value / 1000 - pg.gameset.juuschat_entering_time.key_value / 1000

	arg_17_0.messageList:make(function(arg_20_0, arg_20_1, arg_20_2)
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
				var_20_3 = (arg_20_1 + 1 - var_17_0) * var_0 - var_0

				if #var_17_1 > 1 then
					var_20_3 = var_20_3 + (#var_17_1 - 1) * var_17_4
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
					arg_17_0:SetCharaMessageCardActive(var_20_1, {
						3
					})
					setText(arg_20_2:Find("charaMessageCard/msgBox/msg"), var_20_0.param)

					if arg_17_3 and var_17_0 and arg_20_1 + 1 > var_17_0 then
						SetActive(arg_20_2, false)
						arg_17_0:StartTimer(function()
							SetActive(arg_20_2, true)
							arg_20_2:Find("charaMessageCard/charaBg"):GetComponent(typeof(Animation)):Play("anim_newinstagram_charabg")
							SetActive(arg_20_2:Find("charaMessageCard/waiting"), true)
							SetActive(arg_20_2:Find("charaMessageCard/msgBox"), false)
							Canvas.ForceUpdateCanvases()
							LeanTween.value(go(arg_17_0.rightPanel:Find("chat/messageScroll")), var_17_2.normalizedPosition.y, 0, 0.5):setOnUpdate(System.Action_float(var_17_3)):setEase(LeanTweenType.easeInOutCubic)
							arg_17_0:StartTimer(function()
								SetActive(arg_20_2:Find("charaMessageCard/waiting"), false)
								SetActive(arg_20_2:Find("charaMessageCard/msgBox"), true)
								arg_20_2:Find("charaMessageCard/msgBox"):GetComponent(typeof(Animation)):Play("anim_newinstagram_chat_common_in")

								if arg_20_1 + 1 ~= #arg_17_2 then
									arg_17_0:ChangeCharaTextFunc(arg_17_4, var_20_0.param)
								else
									arg_17_0:emit(InstagramChatMediator.SET_READED, {
										arg_17_1.topicId
									})
								end

								Canvas.ForceUpdateCanvases()
								LeanTween.value(go(arg_17_0.rightPanel:Find("chat/messageScroll")), var_17_2.normalizedPosition.y, 0, 0.5):setOnUpdate(System.Action_float(var_17_3)):setEase(LeanTweenType.easeInOutCubic)
								arg_17_0:SetEndAniEvent(arg_20_2:Find("charaMessageCard/msgBox"), function()
									if arg_17_0.shouldShowOption and arg_20_1 + 1 == #arg_17_2 then
										arg_17_0:SetOptionPanelActive(true)
									end

									return
								end)

								return
							end, var_0)

							return
						end, var_20_3)
					end
				elseif var_20_0.type == 2 then
					arg_17_0:SetCharaMessageCardActive(var_20_1, {
						2,
						7
					})
					pg.CriMgr.GetInstance():GetCueInfo("cv-" .. var_20_0.ship_group, var_20_0.param[1], function(arg_24_0)
						setText(arg_20_2:Find("charaMessageCard/voiceBox/time"), tostring(math.ceil(tonumber(tostring(arg_24_0.length)) / 1000)) .. "\"")

						return
					end)
					onButton(arg_17_0, arg_20_2:Find("charaMessageCard/voiceBox"), function()
						pg.CriMgr.GetInstance():PlaySoundEffect_V3("event:/cv/" .. var_20_0.ship_group .. "/" .. var_20_0.param[1])

						return
					end, SFX_PANEL)
					setText(arg_20_2:Find("charaMessageCard/voiceMsgBox/voiceMsg/msg"), var_20_0.param[2])

					if arg_17_3 and var_17_0 and arg_20_1 + 1 > var_17_0 then
						SetActive(arg_20_2, false)
						arg_17_0:StartTimer(function()
							SetActive(arg_20_2, true)
							arg_20_2:Find("charaMessageCard/charaBg"):GetComponent(typeof(Animation)):Play("anim_newinstagram_charabg")
							SetActive(arg_20_2:Find("charaMessageCard/waiting"), true)
							SetActive(arg_20_2:Find("charaMessageCard/voiceBox"), false)
							SetActive(arg_20_2:Find("charaMessageCard/voiceMsgBox"), false)
							Canvas.ForceUpdateCanvases()
							LeanTween.value(go(arg_17_0.rightPanel:Find("chat/messageScroll")), var_17_2.normalizedPosition.y, 0, 0.5):setOnUpdate(System.Action_float(var_17_3)):setEase(LeanTweenType.easeInOutCubic)
							arg_17_0:StartTimer(function()
								SetActive(arg_20_2:Find("charaMessageCard/waiting"), false)
								SetActive(arg_20_2:Find("charaMessageCard/voiceBox"), true)
								SetActive(arg_20_2:Find("charaMessageCard/voiceMsgBox"), true)
								arg_20_2:Find("charaMessageCard/voiceBox"):GetComponent(typeof(Animation)):Play("anim_newinstagram_chat_common_in")
								arg_20_2:Find("charaMessageCard/voiceMsgBox"):GetComponent(typeof(Animation)):Play("anim_newinstagram_voicetip_in")

								if arg_20_1 + 1 ~= #arg_17_2 then
									arg_17_0:ChangeCharaTextFunc(arg_17_4, "<color=#ff6666>" .. i18n("juuschat_chattip1") .. "</color>")
								else
									arg_17_0:emit(InstagramChatMediator.SET_READED, {
										arg_17_1.topicId
									})
								end

								Canvas.ForceUpdateCanvases()
								LeanTween.value(go(arg_17_0.rightPanel:Find("chat/messageScroll")), var_17_2.normalizedPosition.y, 0, 0.5):setOnUpdate(System.Action_float(var_17_3)):setEase(LeanTweenType.easeInOutCubic)
								arg_17_0:SetEndAniEvent(arg_20_2:Find("charaMessageCard/voiceBox"), function()
									if arg_17_0.shouldShowOption and arg_20_1 + 1 == #arg_17_2 then
										arg_17_0:SetOptionPanelActive(true)
									end

									return
								end)

								return
							end, var_0)

							return
						end, var_20_3)
					end
				elseif var_20_0.type == 3 then
					arg_17_0:SetCharaMessageCardActive(var_20_1, {
						5
					})

					local var_20_5 = var_0_2[tonumber(var_20_0.param)]

					setText(arg_20_2:Find("charaMessageCard/redPacket/desc"), var_20_5.desc)

					local var_20_6 = arg_17_1:RedPacketGotFlag(var_20_5.id)

					SetActive(arg_20_2:Find("charaMessageCard/redPacket/got"), var_20_6)
					arg_17_0:SetRedPacketPanel(arg_20_2:Find("charaMessageCard/redPacket"), var_20_5, var_20_6, var_20_4, arg_17_1.topicId, var_20_0.id)

					if arg_17_3 and var_17_0 and arg_20_1 + 1 == var_17_0 then
						arg_17_0:ChangeCharaTextFunc(arg_17_4, "<color=#ff6666>" .. i18n("juuschat_chattip2") .. "</color>" .. pg.activity_ins_redpackage[tonumber(var_20_0.param)].desc)
					end

					if arg_17_3 and var_17_0 and arg_20_1 + 1 > var_17_0 then
						SetActive(arg_20_2, false)
						arg_17_0:StartTimer(function()
							SetActive(arg_20_2, true)
							arg_20_2:Find("charaMessageCard/charaBg"):GetComponent(typeof(Animation)):Play("anim_newinstagram_charabg")
							SetActive(arg_20_2:Find("charaMessageCard/waiting"), true)
							SetActive(arg_20_2:Find("charaMessageCard/redPacket"), false)
							Canvas.ForceUpdateCanvases()
							LeanTween.value(go(arg_17_0.rightPanel:Find("chat/messageScroll")), var_17_2.normalizedPosition.y, 0, 0.5):setOnUpdate(System.Action_float(var_17_3)):setEase(LeanTweenType.easeInOutCubic)
							arg_17_0:StartTimer(function()
								SetActive(arg_20_2:Find("charaMessageCard/waiting"), false)
								SetActive(arg_20_2:Find("charaMessageCard/redPacket"), true)
								arg_20_2:Find("charaMessageCard/redPacket"):GetComponent(typeof(Animation)):Play("anim_newinstagram_redpacket_in")

								if arg_20_1 + 1 ~= #arg_17_2 then
									arg_17_0:ChangeCharaTextFunc(arg_17_4, "<color=#ff6666>" .. i18n("juuschat_chattip2") .. "</color>" .. pg.activity_ins_redpackage[tonumber(var_20_0.param)].desc)
								else
									arg_17_0:emit(InstagramChatMediator.SET_READED, {
										arg_17_1.topicId
									})
								end

								Canvas.ForceUpdateCanvases()
								LeanTween.value(go(arg_17_0.rightPanel:Find("chat/messageScroll")), var_17_2.normalizedPosition.y, 0, 0.5):setOnUpdate(System.Action_float(var_17_3)):setEase(LeanTweenType.easeInOutCubic)
								arg_17_0:SetEndAniEvent(arg_20_2:Find("charaMessageCard/redPacket"), function()
									if arg_17_0.shouldShowOption and arg_20_1 + 1 == #arg_17_2 then
										arg_17_0:SetOptionPanelActive(true)
									end

									return
								end)

								return
							end, var_0)

							return
						end, var_20_3)
					end
				elseif var_20_0.type == 4 then
					arg_17_0:SetCharaMessageCardActive(var_20_1, {
						4
					})
					arg_17_0:ClearEmoji(arg_20_2:Find("charaMessageCard/emoji/emoticon"))
					arg_17_0:SetEmoji(arg_20_2:Find("charaMessageCard/emoji/emoticon"), var_0_3[tonumber(var_20_0.param)].pic)

					if arg_17_3 and var_17_0 and arg_20_1 + 1 > var_17_0 then
						SetActive(arg_20_2, false)
						arg_17_0:StartTimer(function()
							SetActive(arg_20_2, true)
							arg_20_2:Find("charaMessageCard/charaBg"):GetComponent(typeof(Animation)):Play("anim_newinstagram_charabg")
							SetActive(arg_20_2:Find("charaMessageCard/waiting"), true)
							SetActive(arg_20_2:Find("charaMessageCard/emoji"), false)
							Canvas.ForceUpdateCanvases()
							LeanTween.value(go(arg_17_0.rightPanel:Find("chat/messageScroll")), var_17_2.normalizedPosition.y, 0, 0.5):setOnUpdate(System.Action_float(var_17_3)):setEase(LeanTweenType.easeInOutCubic)
							arg_17_0:StartTimer(function()
								SetActive(arg_20_2:Find("charaMessageCard/waiting"), false)
								SetActive(arg_20_2:Find("charaMessageCard/emoji"), true)
								arg_20_2:Find("charaMessageCard/emoji"):GetComponent(typeof(Animation)):Play("anim_newinstagram_emoji_in")

								if arg_20_1 + 1 ~= #arg_17_2 then
									arg_17_0:ChangeCharaTextFunc(arg_17_4, (string.gsub(var_0_3[tonumber(var_20_0.param)].desc, "#%w+>", "#28af6e>")))
								else
									arg_17_0:emit(InstagramChatMediator.SET_READED, {
										arg_17_1.topicId
									})
								end

								Canvas.ForceUpdateCanvases()
								LeanTween.value(go(arg_17_0.rightPanel:Find("chat/messageScroll")), var_17_2.normalizedPosition.y, 0, 0.5):setOnUpdate(System.Action_float(var_17_3)):setEase(LeanTweenType.easeInOutCubic)
								arg_17_0:SetEndAniEvent(arg_20_2:Find("charaMessageCard/emoji"), function()
									if arg_17_0.shouldShowOption and arg_20_1 + 1 == #arg_17_2 then
										arg_17_0:SetOptionPanelActive(true)
									end

									return
								end)

								return
							end, var_0)

							return
						end, var_20_3)
					end
				elseif var_20_0.type == 5 then
					arg_17_0:SetCharaMessageCardActive(var_20_1, {
						6
					})

					local var_20_7 = var_20_0.param

					for iter_20_0 in string.gmatch(var_20_0.param, "'%d+'") do
						var_20_7 = string.gsub(var_20_7, iter_20_0, "<color=#93e9ff>" .. var_0_1[tonumber((string.sub(iter_20_0, 2, #iter_20_0 - 1)))].name .. "</color>")
					end

					setText(arg_20_2:Find("charaMessageCard/systemTip/panel/Text"), var_20_7)

					if arg_17_3 and var_17_0 and arg_20_1 + 1 > var_17_0 then
						SetActive(arg_20_2, false)
						arg_17_0:StartTimer(function()
							SetActive(arg_20_2, true)
							arg_20_2:Find("charaMessageCard/systemTip"):GetComponent(typeof(Animation)):Play("anim_newinstagram_tip_in")

							if arg_20_1 + 1 ~= #arg_17_2 then
								arg_17_0:ChangeCharaTextFunc(arg_17_4, var_20_7)
							else
								arg_17_0:emit(InstagramChatMediator.SET_READED, {
									arg_17_1.topicId
								})
							end

							Canvas.ForceUpdateCanvases()
							LeanTween.value(go(arg_17_0.rightPanel:Find("chat/messageScroll")), var_17_2.normalizedPosition.y, 0, 0.5):setOnUpdate(System.Action_float(var_17_3)):setEase(LeanTweenType.easeInOutCubic)
							arg_17_0:SetEndAniEvent(arg_20_2:Find("charaMessageCard/systemTip"), function()
								if arg_17_0.shouldShowOption and arg_20_1 + 1 == #arg_17_2 then
									arg_17_0:SetOptionPanelActive(true)
								end

								return
							end)

							return
						end, var_20_3)
					end
				end
			else
				if var_20_0.type == 1 then
					arg_17_0:SetPlayerMessageCardActive(var_20_2, {
						0
					})
					setText(arg_20_2:Find("playerReplyCard/msgBox/msg"), var_20_0.param)
				elseif var_20_0.type == 4 then
					arg_17_0:SetPlayerMessageCardActive(var_20_2, {
						1
					})
					arg_17_0:ClearEmoji(arg_20_2:Find("playerReplyCard/emoji/emoticon"))
					arg_17_0:SetEmoji(arg_20_2:Find("playerReplyCard/emoji/emoticon"), var_0_3[tonumber(var_20_0.param)].pic)
				elseif var_20_0.type == 5 then
					arg_17_0:SetPlayerMessageCardActive(var_20_2, {
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
						arg_17_0:StartTimer(function()
							SetActive(arg_20_2, true)

							if var_20_0.type == 1 then
								arg_20_2:Find("playerReplyCard/msgBox"):GetComponent(typeof(Animation)):Play("anim_newinstagram_playerchat_common_in")
								arg_17_0:ChangeCharaTextFunc(arg_17_4, var_20_0.param)
							elseif var_20_0.type == 4 then
								arg_20_2:Find("playerReplyCard/emoji"):GetComponent(typeof(Animation)):Play("anim_newinstagram_emoji_in")
								arg_17_0:ChangeCharaTextFunc(arg_17_4, (string.gsub(var_0_3[tonumber(var_20_0.param)].desc, "#%w+>", "#28af6e>")))
							elseif var_20_0.type == 5 then
								arg_20_2:Find("playerReplyCard/systemTip"):GetComponent(typeof(Animation)):Play("anim_newinstagram_tip_in")

								local var_37_0 = var_20_0.param

								for iter_37_0 in string.gmatch(var_20_0.param, "'%d+'") do
									var_37_0 = string.gsub(var_37_0, iter_37_0, "<color=#93e9ff>" .. var_0_1[tonumber((string.sub(iter_37_0, 2, #iter_37_0 - 1)))].name .. "</color>")
								end

								arg_17_0:ChangeCharaTextFunc(arg_17_4, var_37_0)
							end

							if arg_20_1 + 1 == #arg_17_2 then
								arg_17_0:emit(InstagramChatMediator.SET_READED, {
									arg_17_1.topicId
								})
							end

							Canvas.ForceUpdateCanvases()
							LeanTween.value(go(arg_17_0.rightPanel:Find("chat/messageScroll")), var_17_2.normalizedPosition.y, 0, 0.5):setOnUpdate(System.Action_float(var_17_3)):setEase(LeanTweenType.easeInOutCubic)

							return
						end, (#var_17_1 - table.indexof(var_17_1, arg_20_1 + 1)) * var_17_4)
					else
						if var_20_0.type == 1 then
							arg_20_2:Find("playerReplyCard/msgBox"):GetComponent(typeof(Animation)):Play("anim_newinstagram_playerchat_common_in")
							arg_17_0:ChangeCharaTextFunc(arg_17_4, var_20_0.param)
						elseif var_20_0.type == 4 then
							arg_20_2:Find("playerReplyCard/emoji"):GetComponent(typeof(Animation)):Play("anim_newinstagram_emoji_in")
							arg_17_0:ChangeCharaTextFunc(arg_17_4, (string.gsub(var_0_3[tonumber(var_20_0.param)].desc, "#%w+>", "#28af6e>")))
						elseif var_20_0.type == 5 then
							arg_20_2:Find("playerReplyCard/systemTip"):GetComponent(typeof(Animation)):Play("anim_newinstagram_tip_in")

							local var_20_9 = var_20_0.param

							for iter_20_2 in string.gmatch(var_20_0.param, "'%d+'") do
								var_20_9 = string.gsub(var_20_9, iter_20_2, "<color=#93e9ff>" .. var_0_1[tonumber((string.sub(iter_20_2, 2, #iter_20_2 - 1)))].name .. "</color>")
							end

							arg_17_0:ChangeCharaTextFunc(arg_17_4, var_20_9)
						end

						if arg_20_1 + 1 == #arg_17_2 then
							arg_17_0:emit(InstagramChatMediator.SET_READED, {
								arg_17_1.topicId
							})
						end
					end
				end
			end

			if not arg_17_1:isWaiting() and arg_20_1 + 1 == #arg_17_2 then
				if arg_17_3 then
					if var_20_0.ship_group ~= 0 then
						arg_17_0:StartTimer(function()
							setActive(arg_20_2:Find("end"), true)

							return
						end, var_20_3 + var_0)
					else
						arg_17_0:StartTimer(function()
							setActive(arg_20_2:Find("end"), true)

							return
						end, (#var_17_1 - table.indexof(var_17_1, arg_20_1 + 1)) * var_17_4 + var_17_4)
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
	arg_17_0.messageList:align(#arg_17_2)

	if arg_17_3 then
		Canvas.ForceUpdateCanvases()
		LeanTween.value(go(arg_17_0.rightPanel:Find("chat/messageScroll")), var_17_2.normalizedPosition.y, 0, 0.5):setOnUpdate(System.Action_float(function(arg_19_0)
			var_17_2.normalizedPosition = Vector2(0, arg_19_0)

			return
		end)):setEase(LeanTweenType.easeInOutCubic)
	else
		scrollToBottom(arg_17_0.rightPanel:Find("chat/messageScroll"))
	end

	return
end

function var_0_0.SetCharaMessageCardActive(arg_40_0, arg_40_1, arg_40_2)
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

function var_0_0.SetPlayerMessageCardActive(arg_41_0, arg_41_1, arg_41_2)
	for iter_41_0 = 0, arg_41_1.childCount - 1 do
		if _.contains(arg_41_2, iter_41_0) then
			SetActive(arg_41_1:GetChild(iter_41_0), true)
		else
			SetActive(arg_41_1:GetChild(iter_41_0), false)
		end
	end

	return
end

function var_0_0.SetEmoji(arg_42_0, arg_42_1, arg_42_2)
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

function var_0_0.ClearEmoji(arg_44_0, arg_44_1)
	eachChild(arg_44_1, function(arg_45_0)
		local var_45_0 = go(arg_45_0)

		PoolMgr.GetInstance():ReturnPrefab("emoji/" .. var_45_0.name, var_45_0.name, var_45_0)

		return
	end)

	return
end

function var_0_0.UpdateOptionPanel(arg_46_0, arg_46_1, arg_46_2)
	local var_46_0 = arg_46_2[#arg_46_2].option

	if arg_46_2[#arg_46_2].option and type(arg_46_2[#arg_46_2].option) == "table" then
		arg_46_0.shouldShowOption = true
		arg_46_0.optionCount = #arg_46_2[#arg_46_2].option

		arg_46_0:SetOptionPanelActive(true)
		arg_46_0.optionList:make(function(arg_47_0, arg_47_1, arg_47_2)
			if arg_47_0 == UIItemList.EventUpdate then
				setText(arg_47_2:Find("Text"), HXSet.hxLan(var_46_0[arg_47_1 + 1][2]))
				onButton(arg_46_0, arg_47_2, function()
					arg_46_0:emit(InstagramChatMediator.REPLY, arg_46_1.topicId, arg_46_2[#arg_46_2].id, var_0[1])

					return
				end, SFX_PANEL)
			end

			return
		end)
		arg_46_0.optionList:align(#arg_46_2[#arg_46_2].option)
	else
		arg_46_0:SetOptionPanelActive(false)

		arg_46_0.shouldShowOption = false
	end

	return
end

function var_0_0.SetOptionPanelActive(arg_49_0, arg_49_1)
	SetActive(arg_49_0.optionPanel, arg_49_1)

	local var_49_0 = arg_49_0.rightPanel:Find("chat/messageScroll/Viewport/Content"):GetComponent(typeof(VerticalLayoutGroup))
	local var_49_1 = UnityEngine.RectOffset.New()

	var_49_1.left = 0
	var_49_1.right = 0
	var_49_1.top = 0

	local var_49_2 = arg_49_0.rightPanel:Find("chat/messageScroll/Scrollbar Vertical"):GetComponent(typeof(RectTransform))

	if arg_49_1 then
		var_49_1.bottom = 42 + 88 * arg_49_0.optionCount
		var_49_2.sizeDelta = Vector2(arg_49_0.messageScrollWidth, -var_49_1.bottom)
	else
		var_49_1.bottom = 50
		var_49_2.sizeDelta = Vector2(arg_49_0.messageScrollWidth, 0)
	end

	var_49_0.padding = var_49_1

	scrollToBottom(arg_49_0.rightPanel:Find("chat/messageScroll"))

	return
end

function var_0_0.SetFilterPanel(arg_50_0)
	arg_50_0.readFilter = arg_50_0.readFilter or var_0_0.ReadType[1]
	arg_50_0.typeFilter = arg_50_0.typeFilter or var_0_0.TypeType[1]
	arg_50_0.campFilter = arg_50_0.campFilter or {
		var_0_0.CampIds[1]
	}

	local var_50_0 = arg_50_0.filterUI:Find("panel/filterScroll/Viewport/Content/read")
	local var_50_1 = arg_50_0.filterUI:Find("panel/filterScroll/Viewport/Content/type")
	local var_50_2 = arg_50_0.filterUI:Find("panel/filterScroll/Viewport/Content/camp")
	local var_50_3 = UIItemList.New(var_50_2, var_50_2:Find("option"))

	onButton(arg_50_0, arg_50_0.filterBtn, function()
		SetActive(arg_50_0.filterUI, true)
		pg.UIMgr.GetInstance():BlurPanel(arg_50_0.filterUI)

		for iter_51_0, iter_51_1 in ipairs(var_0_0.ReadType) do
			local var_51_0 = var_50_0:GetChild(iter_51_0)

			SetActive(var_51_0:Find("selectedFrame"), arg_50_0.readFilter == iter_51_1)
			onButton(arg_50_0, var_51_0, function()
				for iter_52_0, iter_52_1 in ipairs(var_0_0.ReadType) do
					local var_52_0 = var_50_0:GetChild(iter_52_0)

					SetActive(var_52_0:Find("selectedFrame"), false)
				end

				SetActive(var_0, true)

				return
			end, SFX_PANEL)
		end

		for iter_51_2, iter_51_3 in ipairs(var_0_0.TypeType) do
			local var_51_1 = var_50_1:GetChild(iter_51_2)

			SetActive(var_51_1:Find("selectedFrame"), arg_50_0.typeFilter == iter_51_3)
			onButton(arg_50_0, var_51_1, function()
				for iter_53_0, iter_53_1 in ipairs(var_0_0.TypeType) do
					local var_53_0 = var_50_1:GetChild(iter_53_0)

					SetActive(var_53_0:Find("selectedFrame"), false)
				end

				SetActive(var_0, true)

				return
			end, SFX_PANEL)
		end

		var_50_3:make(function(arg_54_0, arg_54_1, arg_54_2)
			if arg_54_0 == UIItemList.EventUpdate then
				setText(arg_54_2:Find("Text"), i18n(var_0_0.CampNames[arg_54_1 + 1]))
				SetActive(arg_54_2:Find("selectedFrame"), _.contains(arg_50_0.campFilter, var_0_0.CampIds[arg_54_1 + 1]))
				onButton(arg_50_0, arg_54_2, function()
					if arg_54_1 == 0 then
						SetActive(var_0, true)

						for iter_55_0 = 2, #var_0_0.CampIds do
							local var_55_0 = var_50_2:GetChild(iter_55_0 - 1)

							SetActive(var_55_0:Find("selectedFrame"), false)
						end
					else
						SetActive(var_0, not isActive(var_0))

						local var_55_1 = true
						local var_55_2 = true

						for iter_55_1 = 2, #var_0_0.CampIds do
							local var_55_3 = var_50_2:GetChild(iter_55_1 - 1)
							local var_55_4

							if not isActive(var_55_3:Find("selectedFrame")) then
								var_55_1 = false
								var_55_4 = var_50_2:GetChild(iter_55_1 - 1)
							end

							if isActive(var_55_4:Find("selectedFrame")) then
								var_55_2 = false
							end
						end

						if var_55_1 then
							SetActive(var_50_2:GetChild(0):Find("selectedFrame"), true)

							for iter_55_2 = 2, #var_0_0.CampIds do
								local var_55_5 = var_50_2:GetChild(iter_55_2 - 1)

								SetActive(var_55_5:Find("selectedFrame"), false)
							end
						elseif var_55_2 then
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
		var_50_3:align(#var_0_0.CampIds)

		return
	end, SFX_PANEL)
	onButton(arg_50_0, arg_50_0.filterUI:Find("bg"), function()
		arg_50_0:CloseFilterPanel()

		return
	end, SFX_PANEL)
	onButton(arg_50_0, arg_50_0.filterUI:Find("panel/bottom/close"), function()
		arg_50_0:CloseFilterPanel()

		return
	end, SFX_PANEL)
	onButton(arg_50_0, arg_50_0.filterUI:Find("panel/bottom/ok"), function()
		for iter_58_0, iter_58_1 in ipairs(var_0_0.ReadType) do
			local var_58_0 = var_50_0:GetChild(iter_58_0)

			if isActive((var_58_0:Find("selectedFrame"))) then
				arg_50_0.readFilter = iter_58_1
			end
		end

		for iter_58_2, iter_58_3 in ipairs(var_0_0.TypeType) do
			local var_58_1 = var_50_1:GetChild(iter_58_2)

			if isActive((var_58_1:Find("selectedFrame"))) then
				arg_50_0.typeFilter = iter_58_3
			end
		end

		arg_50_0.campFilter = {}

		for iter_58_4, iter_58_5 in ipairs(var_0_0.CampIds) do
			local var_58_2 = var_50_2:GetChild(iter_58_4 - 1)

			if isActive((var_58_2:Find("selectedFrame"))) then
				table.insert(arg_50_0.campFilter, iter_58_5)
			end
		end

		arg_50_0:CloseFilterPanel()
		arg_50_0:SetFilterResult()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.SetFilterResult(arg_59_0)
	local var_59_0 = true
	local var_59_1 = false

	if not arg_59_0.readFilter then
		arg_59_0.readFilter = var_0_0.ReadType[1]
		arg_59_0.typeFilter = var_0_0.TypeType[1]
		arg_59_0.campFilter = {
			var_0_0.CampIds[1]
		}
	end

	arg_59_0.chatList = table.insertto({}, arg_59_0.allChatList)

	for iter_59_0 = #arg_59_0.chatList, 1, -1 do
		local var_59_2 = arg_59_0.chatList[iter_59_0]
		local var_59_3 = true

		if arg_59_0.readFilter ~= "all" and var_59_2:GetCharacterEndFlag() ~= (arg_59_0.readFilter == "hasReaded" and 1 or 0) then
			var_59_3 = false
		end

		if arg_59_0.typeFilter ~= "all" and var_59_2.type ~= (arg_59_0.typeFilter == "single" and 1 or 2) then
			var_59_3 = false
		end

		if not _.contains(arg_59_0.campFilter, 0) and not _.contains(arg_59_0.campFilter, var_59_2.nationality) then
			var_59_3 = false
		end

		if not var_59_3 then
			table.remove(arg_59_0.chatList, iter_59_0)
		end

		if var_59_3 then
			var_59_0 = false
		end

		if arg_59_0.currentChat and arg_59_0.currentChat.characterId == var_59_2.characterId and var_59_3 then
			var_59_1 = true
		end
	end

	local var_59_4 = arg_59_0.readFilter == "all" and arg_59_0.typeFilter == "all" and _.contains(arg_59_0.campFilter, 0)

	SetActive(arg_59_0.isFiltered, not var_59_4)

	if var_59_4 then
		arg_59_0:InsertOfficialAccounts()
	end

	if var_59_0 then
		SetActive(arg_59_0.leftPanel:Find("charaScroll"), false)
		SetActive(arg_59_0._tf:Find("main/noFilteredMessageBg"), true)
		SetActive(arg_59_0.rightPanel, false)
		SetActive(arg_59_0._tf:Find("main/rightNoMessageBg"), false)
	else
		SetActive(arg_59_0.leftPanel:Find("charaScroll"), true)
		arg_59_0.charaScrollrect:SetTotalCount(#arg_59_0.chatList)
		SetActive(arg_59_0._tf:Find("main/noFilteredMessageBg"), false)

		if var_59_1 then
			SetActive(arg_59_0.rightPanel, true)
			SetActive(arg_59_0._tf:Find("main/rightNoMessageBg"), false)
		else
			SetActive(arg_59_0.rightPanel, false)
			SetActive(arg_59_0._tf:Find("main/rightNoMessageBg"), true)

			arg_59_0.currentChat = nil

			if arg_59_0.cancelFrame then
				arg_59_0.cancelFrame()

				arg_59_0.cancelFrame = nil
			end
		end
	end

	return
end

function var_0_0.CloseFilterPanel(arg_60_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_60_0.filterUI, arg_60_0._tf:Find("subPages"))
	SetActive(arg_60_0.filterUI, false)

	return
end

function var_0_0.SetTopicPanel(arg_61_0, arg_61_1)
	SetActive(arg_61_0.topicBtn:Find("tip"), arg_61_1:GetCharacterEndFlagExceptCurrent() == 0)
	onButton(arg_61_0, arg_61_0.topicBtn, function()
		SetActive(arg_61_0.topicUI, true)
		pg.UIMgr.GetInstance():BlurPanel(arg_61_0.topicUI)

		arg_61_0.currentTopic = nil

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

		setActive(arg_61_0.topicUI:Find("panel/topicScroll/Viewport/Content/self"), #var_62_0 > 0)
		setActive(arg_61_0.topicUI:Find("panel/topicScroll/Viewport/Content/other"), #var_62_1 > 0)
		setActive(arg_61_0.topicUI:Find("panel/topicScroll/Viewport/Content/line"), #var_62_0 > 0 and #var_62_1 > 0)

		if #var_62_0 > 0 then
			local var_62_2 = UIItemList.New(arg_61_0.topicUI:Find("panel/topicScroll/Viewport/Content/self"), arg_61_0.topicUI:Find("panel/topicScroll/Viewport/Content/self/topic"))

			var_62_2:make(function(arg_63_0, arg_63_1, arg_63_2)
				if arg_63_0 == UIItemList.EventUpdate then
					arg_61_0:SetTopic(arg_63_2, arg_61_1, var_62_0[arg_63_1 + 1], var_62_0, var_62_1)
				end

				return
			end)
			var_62_2:align(#var_62_0)
		end

		if #var_62_1 > 0 then
			local var_62_3 = UIItemList.New(arg_61_0.topicUI:Find("panel/topicScroll/Viewport/Content/other"), arg_61_0.topicUI:Find("panel/topicScroll/Viewport/Content/other/topic"))

			var_62_3:make(function(arg_64_0, arg_64_1, arg_64_2)
				if arg_64_0 == UIItemList.EventUpdate then
					arg_61_0:SetTopic(arg_64_2, arg_61_1, var_62_1[arg_64_1 + 1], var_62_0, var_62_1)
				end

				return
			end)
			var_62_3:align(#var_62_1)
		end

		return
	end, SFX_PANEL)
	onButton(arg_61_0, arg_61_0.topicUI:Find("bg"), function()
		arg_61_0:CloseTopicPanel()

		return
	end, SFX_PANEL)
	onButton(arg_61_0, arg_61_0.topicUI:Find("panel/bottom/close"), function()
		arg_61_0:CloseTopicPanel()

		return
	end, SFX_PANEL)
	onButton(arg_61_0, arg_61_0.topicUI:Find("panel/bottom/ok"), function()
		arg_61_0:emit(InstagramChatMediator.SET_CURRENT_TOPIC, arg_61_0.currentTopic.topicId)
		arg_61_0:CloseTopicPanel()

		local var_67_0 = arg_61_0.rightPanel:GetComponent(typeof(Animation))

		var_67_0:Stop()
		var_67_0:Play("anim_newinstagram_chat_right_in")

		return
	end, SFX_PANEL)

	return
end

function var_0_0.SetTopic(arg_68_0, arg_68_1, arg_68_2, arg_68_3, arg_68_4, arg_68_5)
	setScrollText(arg_68_1:Find("mask/name"), HXSet.hxLan(arg_68_3.name))
	SetActive(arg_68_1:Find("lock"), not arg_68_3.active)

	local var_68_0 = arg_68_3.active and arg_68_3:isWaiting()

	SetActive(arg_68_1:Find("waiting"), var_68_0)

	local var_68_1 = arg_68_3.active and arg_68_3:IsCompleted()

	SetActive(arg_68_1:Find("complete"), var_68_1)
	SetActive(arg_68_1:Find("selectedFrame"), arg_68_2.currentTopicId == arg_68_3.topicId)
	SetActive(arg_68_1:Find("selected"), arg_68_2.currentTopicId == arg_68_3.topicId)

	local var_68_2 = arg_68_3.active and not arg_68_3:IsCompleted()

	SetActive(arg_68_1:Find("tip"), var_68_2)

	if arg_68_2.currentTopicId == arg_68_3.topicId then
		arg_68_0.currentTopic = arg_68_3
	end

	SetActive(arg_68_1, arg_68_3.active)

	if arg_68_3.active then
		onButton(arg_68_0, arg_68_1, function()
			for iter_69_0 = 1, #arg_68_4 do
				local var_69_0 = arg_68_0.topicUI:Find("panel/topicScroll/Viewport/Content/self"):GetChild(iter_69_0 - 1)

				SetActive(var_69_0:Find("selectedFrame"), false)
			end

			for iter_69_1 = 1, #arg_68_5 do
				local var_69_1 = arg_68_0.topicUI:Find("panel/topicScroll/Viewport/Content/other"):GetChild(iter_69_1 - 1)

				SetActive(var_69_1:Find("selectedFrame"), false)
			end

			SetActive(arg_68_1:Find("selectedFrame"), true)

			arg_68_0.currentTopic = arg_68_3

			return
		end, SFX_PANEL)
	else
		onButton(arg_68_0, arg_68_1, function()
			pg.TipsMgr.GetInstance():ShowTips(arg_68_3.unlockDesc)

			return
		end, SFX_PANEL)
	end

	return
end

function var_0_0.CloseTopicPanel(arg_71_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_71_0.topicUI, arg_71_0._tf:Find("subPages"))
	SetActive(arg_71_0.topicUI, false)

	return
end

function var_0_0.SetBackgroundPanel(arg_72_0, arg_72_1)
	if arg_72_1.type == 2 then
		SetActive(arg_72_0.backgroundBtn, false)

		return
	end

	SetActive(arg_72_0.backgroundBtn, true)
	onButton(arg_72_0, arg_72_0.backgroundBtn, function()
		SetActive(arg_72_0.backgroundUI, true)
		pg.UIMgr.GetInstance():BlurPanel(arg_72_0.backgroundUI)

		arg_72_0.currentBgId = nil

		local var_73_0 = arg_72_1:GetSkins()
		local var_73_1 = UIItemList.New(arg_72_0.backgroundUI:Find("panel/backgroundScroll/Viewport/Content"), arg_72_0.backgroundUI:Find("panel/backgroundScroll/Viewport/Content/background"))

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
						arg_72_0.currentBgId = var_74_0
					end
				else
					local var_74_2 = arg_72_1:GetPaintingId()

					SetActive(arg_74_2:Find("selectedFrame"), var_74_2 == var_74_0)
					SetActive(arg_74_2:Find("selected"), var_74_2 == var_74_0)

					if var_74_2 == var_74_0 then
						arg_72_0.currentBgId = var_74_0
					end
				end

				onButton(arg_72_0, arg_74_2, function()
					if var_74_1 then
						SetActive(arg_74_2:Find("selectedFrame"), true)

						for iter_75_0 = 1, #var_73_0 do
							if iter_75_0 ~= arg_74_1 + 1 then
								local var_75_0 = arg_72_0.backgroundUI:Find("panel/backgroundScroll/Viewport/Content"):GetChild(iter_75_0 - 1)

								SetActive(var_75_0:Find("selectedFrame"), false)
							end
						end

						arg_72_0.currentBgId = var_74_0
					else
						pg.TipsMgr.GetInstance():ShowTips(i18n("juuschat_background_tip2"))
					end

					return
				end, SFX_PANEL)
			end

			return
		end)
		var_73_1:align(#arg_72_1:GetSkins())

		return
	end, SFX_PANEL)
	onButton(arg_72_0, arg_72_0.backgroundUI:Find("bg"), function()
		arg_72_0:CloseBackgroundPanel()

		return
	end, SFX_PANEL)
	onButton(arg_72_0, arg_72_0.backgroundUI:Find("panel/bottom/close"), function()
		arg_72_0:CloseBackgroundPanel()

		return
	end, SFX_PANEL)
	onButton(arg_72_0, arg_72_0.backgroundUI:Find("panel/bottom/ok"), function()
		arg_72_0:emit(InstagramChatMediator.SET_CURRENT_BACKGROUND, arg_72_1.characterId, arg_72_0.currentBgId)
		arg_72_0:CloseBackgroundPanel()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.CloseBackgroundPanel(arg_79_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_79_0.backgroundUI, arg_79_0._tf:Find("subPages"))
	SetActive(arg_79_0.backgroundUI, false)

	return
end

function var_0_0.SetRedPacketPanel(arg_80_0, arg_80_1, arg_80_2, arg_80_3, arg_80_4, arg_80_5, arg_80_6)
	onButton(arg_80_0, arg_80_1, function()
		SetActive(arg_80_0.redPacketUI, true)
		pg.UIMgr.GetInstance():BlurPanel(arg_80_0.redPacketUI)
		setImageSprite(arg_80_0.redPacketUI:Find("panel/charaBg/chara"), LoadSprite("qicon/" .. arg_80_4), false)

		if not arg_80_3 then
			SetActive(arg_80_0.redPacketUI:Find("panel/panelBg"), true)
			SetActive(arg_80_0.redPacketUI:Find("panel/openImg"), false)
			SetActive(arg_80_0.redPacketUI:Find("panel/get"), true)
			SetActive(arg_80_0.redPacketUI:Find("panel/got"), false)
			SetActive(arg_80_0.redPacketUI:Find("panel/detail"), false)
			setText(arg_80_0.redPacketUI:Find("panel/get/titleBg/title"), arg_80_2.desc)
			onButton(arg_80_0, arg_80_0.redPacketUI:Find("panel/get/getBtn"), function()
				arg_80_0:emit(InstagramChatMediator.GET_REDPACKET, arg_80_5, arg_80_6, arg_80_2.id)

				return
			end, SFX_PANEL)
		else
			arg_80_0:UpdateRedPacketUI(arg_80_2.id)
		end

		return
	end, SFX_PANEL)
	onButton(arg_80_0, arg_80_0.redPacketUI:Find("bg"), function()
		arg_80_0:CloseRedPacketPanel()

		if arg_80_0.canFresh then
			arg_80_0.canFresh = false

			local var_83_0 = arg_80_0.currentChat.currentTopic:GetDisplayWordList()

			if var_83_0[#var_83_0].type == 0 then
				arg_80_0:UpdateCharaList(false, false)
			else
				arg_80_0:UpdateCharaList(true, false)
			end
		end

		return
	end, SFX_PANEL)

	return
end

function var_0_0.UpdateRedPacketUI(arg_84_0, arg_84_1)
	local var_84_0 = var_0_2[arg_84_1]

	SetActive(arg_84_0.redPacketUI:Find("panel/panelBg"), true)
	SetActive(arg_84_0.redPacketUI:Find("panel/openImg"), false)
	SetActive(arg_84_0.redPacketUI:Find("panel/get"), false)
	SetActive(arg_84_0.redPacketUI:Find("panel/got"), true)
	SetActive(arg_84_0.redPacketUI:Find("panel/detail"), false)

	local var_84_1 = Drop.Create(var_0_2[arg_84_1].content)

	var_84_1.count = 0

	updateDrop(arg_84_0.redPacketUI:Find("panel/got/item"), var_84_1)
	onButton(arg_84_0, arg_84_0.redPacketUI:Find("panel/got/item"), function()
		arg_84_0:emit(BaseUI.ON_DROP, var_84_1)

		return
	end, SFX_PANEL)

	arg_84_0.redPacketUI:Find("panel/got/item/icon_bg"):GetComponent(typeof(Image)).enabled = false
	arg_84_0.redPacketUI:Find("panel/got/item/icon_bg/frame"):GetComponent(typeof(Image)).enabled = false

	setText(arg_84_0.redPacketUI:Find("panel/got/awardCount"), var_0_2[arg_84_1].content[3])

	if var_0_2[arg_84_1].type == 1 then
		SetActive(arg_84_0.redPacketUI:Find("panel/got/detailBtn"), false)
	else
		SetActive(arg_84_0.redPacketUI:Find("panel/got/detailBtn"), true)
		onButton(arg_84_0, arg_84_0.redPacketUI:Find("panel/got/detailBtn"), function()
			SetActive(arg_84_0.redPacketUI:Find("panel/panelBg"), false)
			SetActive(arg_84_0.redPacketUI:Find("panel/openImg"), true)
			SetActive(arg_84_0.redPacketUI:Find("panel/got"), false)
			SetActive(arg_84_0.redPacketUI:Find("panel/detail"), true)

			local var_86_0 = 0
			local var_86_1 = 0
			local var_86_2 = UIItemList.New(arg_84_0.redPacketUI:Find("panel/detail/detailScroll/Viewport/Content"), arg_84_0.redPacketUI:Find("panel/detail/detailScroll/Viewport/Content/charaGetCard"))

			var_86_2:make(function(arg_87_0, arg_87_1, arg_87_2)
				if arg_87_0 == UIItemList.EventUpdate then
					local var_87_0 = var_84_0.group_receive[arg_87_1 + 1]
					local var_87_1 = {
						var_84_0.group_receive[arg_87_1 + 1][2],
						var_84_0.group_receive[arg_87_1 + 1][3],
						var_84_0.group_receive[arg_87_1 + 1][4]
					}

					if var_84_0.group_receive[arg_87_1 + 1][1] ~= 0 then
						local var_87_2 = "unknown"

						if var_0_1[var_84_0.group_receive[arg_87_1 + 1][1]] then
							var_87_2 = var_0_1[var_84_0.group_receive[arg_87_1 + 1][1]].sculpture
						end

						setImageSprite(arg_87_2:Find("charaBg/chara"), LoadSprite("qicon/" .. var_87_2), false)
					else
						setImageSprite(arg_87_2:Find("charaBg/chara"), GetSpriteFromAtlas("ui/InstagramUI_atlas", "txdi_3"), false)
					end

					local var_87_3 = Drop.Create(var_87_1)

					var_87_3.count = 0

					updateDrop(arg_87_2:Find("item"), var_87_3)
					onButton(arg_84_0, arg_87_2:Find("item"), function()
						arg_84_0:emit(BaseUI.ON_DROP, var_87_3)

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
				local var_86_3 = arg_84_0.redPacketUI:Find("panel/detail/detailScroll/Viewport/Content"):GetChild(iter_86_0 - 1)

				SetActive(var_86_3:Find("charaBg/king"), var_86_0 == iter_86_0 - 1)
			end

			return
		end, SFX_PANEL)
	end

	return
end

function var_0_0.CloseRedPacketPanel(arg_89_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_89_0.redPacketUI, arg_89_0._tf:Find("subPages"))
	SetActive(arg_89_0.redPacketUI, false)

	return
end

function var_0_0.SetData(arg_90_0)
	local var_90_0 = getProxy(InstagramChatProxy)

	arg_90_0.allChatList = var_90_0:GetChatList()
	arg_90_0.chatList = table.insertto({}, arg_90_0.allChatList)

	var_90_0:SortChatList()

	return
end

function var_0_0.willExit(arg_91_0)
	if arg_91_0.paintingName then
		retPaintingPrefab(arg_91_0.rightPanel:Find("chat/paintingMask/painting"), arg_91_0.paintingName)

		arg_91_0.paintingName = nil
	end

	arg_91_0:RemoveAllTimer()
	arg_91_0:EixtOfficialAccounts()

	return
end

function var_0_0.StartTimer(arg_92_0, arg_92_1, arg_92_2)
	local var_92_0 = Timer.New(arg_92_1, arg_92_2, 1)

	var_92_0:Start()
	table.insert(arg_92_0.timerList, var_92_0)

	return
end

function var_0_0.RemoveAllTimer(arg_93_0)
	for iter_93_0, iter_93_1 in ipairs(arg_93_0.timerList) do
		iter_93_1:Stop()
	end

	arg_93_0.timerList = {}

	return
end

function var_0_0.StartTimer2(arg_94_0, arg_94_1, arg_94_2)
	arg_94_0.timer = Timer.New(arg_94_1, arg_94_2, 1)

	arg_94_0.timer:Start()

	return
end

function var_0_0.SpeedUpMessage(arg_95_0)
	for iter_95_0, iter_95_1 in ipairs(arg_95_0.timerList) do
		if iter_95_1.running then
			if iter_95_1.duration == pg.gameset.juuschat_entering_time.key_value / 1000 then
				iter_95_1.time = 0.05
			elseif iter_95_1.time - pg.gameset.juuschat_dialogue_trigger_time.key_value / 1000 < 0.05 then
				iter_95_1.time = 0.05

				arg_95_0:StartTimer2(function()
					arg_95_0:SpeedUpWaiting()

					return
				end, 0.05)
			else
				iter_95_1.time = iter_95_1.time - pg.gameset.juuschat_dialogue_trigger_time.key_value / 1000
			end
		end
	end

	return
end

function var_0_0.SpeedUpWaiting(arg_97_0)
	for iter_97_0, iter_97_1 in ipairs(arg_97_0.timerList) do
		if iter_97_1.running and iter_97_1.duration == pg.gameset.juuschat_entering_time.key_value / 1000 then
			iter_97_1.time = 0.05

			break
		end
	end

	return
end

function var_0_0.ChangeFresh(arg_98_0)
	arg_98_0.canFresh = true

	return
end

function var_0_0.ChangeCharaTextFunc(arg_99_0, arg_99_1, arg_99_2)
	for iter_99_0 = 0, arg_99_0.charaScrollContent.childCount - 1 do
		(function(arg_100_0)
			if arg_100_0:Find("chat/id"):GetComponent(typeof(Text)).text == tostring(arg_99_1) then
				setText(arg_100_0:Find("chat/msg"), arg_99_2)
			end

			return
		end)((arg_99_0.charaScrollContent:GetChild(iter_99_0)))
	end

	return
end

function var_0_0.ResetCharaTextFunc(arg_101_0, arg_101_1)
	for iter_101_0 = 0, arg_101_0.charaScrollContent.childCount - 1 do
		(function(arg_102_0)
			if arg_102_0:Find("chat/id"):GetComponent(typeof(Text)).text == tostring(arg_101_1) then
				setText(arg_102_0:Find("chat/msg"), arg_102_0:Find("chat/displayWord"):GetComponent(typeof(Text)).text)
			end

			return
		end)((arg_101_0.charaScrollContent:GetChild(iter_101_0)))
	end

	return
end

function var_0_0.SetEndAniEvent(arg_103_0, arg_103_1, arg_103_2)
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

function var_0_0.onBackPressed(arg_105_0)
	if isActive(arg_105_0.filterUI) then
		arg_105_0:CloseFilterPanel()

		return
	end

	if isActive(arg_105_0.topicUI) then
		arg_105_0:CloseTopicPanel()

		return
	end

	if isActive(arg_105_0.backgroundUI) then
		arg_105_0:CloseBackgroundPanel()

		return
	end

	if isActive(arg_105_0.redPacketUI) then
		arg_105_0:CloseRedPacketPanel()

		return
	end

	if isActive(arg_105_0.rightOfficialAccountsPanel) and isActive(arg_105_0.rightOfficialAccountsInfoPanel) then
		arg_105_0:ExitOfficialAccountsInfo()

		return
	end

	arg_105_0:emit(InstagramChatMediator.CLOSE_ALL)

	return
end

function var_0_0.InitOfficialAccounts(arg_106_0)
	arg_106_0.rightOfficialAccountsListPanel = arg_106_0.rightOfficialAccountsPanel:Find("officialAccountsPanel")
	arg_106_0.rightOfficialAccountsInfoPanel = arg_106_0.rightOfficialAccountsPanel:Find("officialAccountsInfoPanel")

	setText(arg_106_0.rightOfficialAccountsListPanel:Find("topBg/Text"), i18n("juusoa_title"))
	setText(arg_106_0.rightOfficialAccountsInfoPanel:Find("topBg/Text"), i18n("juusoa_title"))

	arg_106_0.officialAccountsScroll = arg_106_0.rightOfficialAccountsListPanel:Find("charaScroll"):GetComponent("LScrollRect")
	arg_106_0.officialAccountsScroll.onInitItem = handler(arg_106_0, arg_106_0.OfficialAccountsInitItem)
	arg_106_0.officialAccountsScroll.onUpdateItem = handler(arg_106_0, arg_106_0.OfficialAccountsUpdateItem)
	arg_106_0.downloadmgr = BulletinBoardMgr.Inst
	arg_106_0.sprites = {}
	arg_106_0.toDownloadList = {}
	arg_106_0.officialAccountsInfoScroll = arg_106_0.rightOfficialAccountsInfoPanel:Find("scroll"):GetComponent(typeof(ScrollRect))
	arg_106_0.officialAccountsInfoItem = arg_106_0.rightOfficialAccountsInfoPanel:Find("scroll/content/infoItem")
	arg_106_0.commentList = UIItemList.New(arg_106_0.rightOfficialAccountsInfoPanel:Find("scroll/content/commentPanel"), arg_106_0.rightOfficialAccountsInfoPanel:Find("scroll/content/commentPanel/tpl"))
	arg_106_0.commentPanel = arg_106_0.rightOfficialAccountsInfoPanel:Find("last/bg2")
	arg_106_0.optionalPanel = arg_106_0.rightOfficialAccountsInfoPanel:Find("last/bg2/option")

	setActive(arg_106_0.rightOfficialAccountsPanel, false)
	setActive(arg_106_0.rightOfficialAccountsInfoPanel, false)

	return
end

function var_0_0.UpdateOfficialAccounts(arg_107_0, arg_107_1)
	setActive(arg_107_0.rightChatPanel, false)
	setActive(arg_107_0.rightOfficialAccountsPanel, true)
	setActive(arg_107_0.rightOfficialAccountsListPanel, true)
	setActive(arg_107_0.rightOfficialAccountsInfoPanel, false)

	arg_107_0.currentChat = arg_107_1
	arg_107_0.instagramOfficialAccounts = {}

	for iter_107_0, iter_107_1 in pairs(getProxy(InstagramProxy):GetOfficialAccounts()) do
		table.insert(arg_107_0.instagramOfficialAccounts, iter_107_1)
	end

	table.sort(arg_107_0.instagramOfficialAccounts, function(arg_108_0, arg_108_1)
		return arg_108_0.id > arg_108_1.id
	end)
	arg_107_0.officialAccountsScroll:SetTotalCount(#arg_107_0.instagramOfficialAccounts)

	return
end

function var_0_0.OfficialAccountsInitItem(arg_109_0, arg_109_1)
	arg_109_0.officialAccountsItemList[arg_109_1] = InstagramOfficialAccountsItem.New(tf(arg_109_1), arg_109_0)

	return
end

function var_0_0.OfficialAccountsUpdateItem(arg_110_0, arg_110_1, arg_110_2)
	local var_110_0 = arg_110_0.officialAccountsItemList[arg_110_2]

	if arg_110_0.officialAccountsItemList[arg_110_2] == nil then
		arg_110_0:OfficialAccountsInitItem(arg_110_2)

		var_110_0 = arg_110_0.officialAccountsItemList[arg_110_2]
	end

	local var_110_1 = arg_110_0.instagramOfficialAccounts[arg_110_1 + 1]
	local var_110_2 = tf(arg_110_2)

	var_110_0:SetData(arg_110_0.instagramOfficialAccounts[arg_110_1 + 1].id)
	arg_110_0:SetImageByUrl(var_110_1.oaListPic, var_110_2:Find("Image"):GetComponent(typeof(RawImage)))
	onButton(arg_110_0, var_110_2, function()
		arg_110_0.currentOfficalID = var_110_1.id

		pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildJuusOfficialAccountsClick(var_110_1.id))
		arg_110_0:ShowOfficialAccountsInfo(var_110_1)
		arg_110_0:ReadOfficialAccountComment()

		arg_110_0.officialAccountsInfoScroll.verticalNormalizedPosition = 1

		return
	end, SFX_PANEL)

	return
end

function var_0_0.ShowOfficialAccountsInfo(arg_112_0, arg_112_1)
	setActive(arg_112_0.rightOfficialAccountsListPanel, false)
	setActive(arg_112_0.rightOfficialAccountsInfoPanel, true)
	arg_112_0:CloseCommentPanel()
	onButton(arg_112_0, arg_112_0.rightOfficialAccountsInfoPanel:Find("topBg"), function()
		arg_112_0:ExitOfficialAccountsInfo()

		return
	end, SFX_PANEL)
	setScrollText(arg_112_0.officialAccountsInfoItem:Find("title/Text"), arg_112_1:getConfig("title"))
	setText(arg_112_0.officialAccountsInfoItem:Find("content"), arg_112_1.text)
	arg_112_0:SetImageByUrl(arg_112_1:GetImage(), arg_112_0.officialAccountsInfoItem:Find("Image/Image"):GetComponent(typeof(RawImage)))
	setText(arg_112_0.officialAccountsInfoItem:Find("bottom/time"), arg_112_1:GetPushTime())
	arg_112_0:UpdateLinkBtn(arg_112_1.id)
	onButton(arg_112_0, arg_112_0.officialAccountsInfoItem:Find("bottom/time/share"), function()
		arg_112_0:emit(InstagramChatMediator.ON_OFFICIAL_ACCOUNTS_OPERATE, ActivityConst.INSTAGRAM_OP_SHARE, arg_112_1.id)

		return
	end, SFX_PANEL)
	arg_112_0:UpdateCommentList(arg_112_1.id)
	Canvas.ForceUpdateCanvases()
	onToggle(arg_112_0, arg_112_0.commentPanel, function(arg_115_0)
		if arg_115_0 then
			arg_112_0:OpenCommentPanel(arg_112_1.id)
		else
			arg_112_0:CloseCommentPanel()
		end

		return
	end, SFX_PANEL)

	return
end

function var_0_0.ExitOfficialAccountsInfo(arg_116_0)
	setActive(arg_116_0.rightOfficialAccountsListPanel, true)
	setActive(arg_116_0.rightOfficialAccountsInfoPanel, false)

	arg_116_0.currentOfficalID = nil

	return
end

function var_0_0.UpdateLinkBtn(arg_117_0, arg_117_1)
	local var_117_0 = getProxy(InstagramProxy):GetOfficialAccounts()[arg_117_1]
	local var_117_1 = var_117_0:IsLiking()
	local var_117_2 = arg_117_0.officialAccountsInfoItem:Find("bottom/notCare")

	if not var_117_1 then
		onButton(arg_117_0, var_117_2, function()
			arg_117_0:emit(InstagramChatMediator.ON_OFFICIAL_ACCOUNTS_OPERATE, ActivityConst.INSTAGRAM_OP_LIKE, var_117_0.id)

			return
		end, SFX_PANEL)
	else
		removeOnButton(var_117_2)
	end

	setActive(var_117_2, not var_117_1)
	setActive(arg_117_0.officialAccountsInfoItem:Find("bottom/care"), var_117_1)
	setText(arg_117_0.officialAccountsInfoItem:Find("bottom/careText"), i18n("ins_word_like", var_117_0:GetLikeCnt()))

	return
end

function var_0_0.UpdateCommentList(arg_119_0, arg_119_1)
	if arg_119_0.currentOfficalID ~= arg_119_1 then
		return
	end

	local var_119_0 = getProxy(InstagramProxy)
	local var_119_1 = var_119_0:GetOfficialAccounts()[arg_119_1]

	if not var_119_1 then
		return
	end

	local var_119_2, var_119_3 = var_119_1:GetCanDisplayComments()

	table.sort(var_119_2, function(arg_120_0, arg_120_1)
		return arg_120_0.time < arg_120_1.time
	end)
	arg_119_0.commentList:make(function(arg_121_0, arg_121_1, arg_121_2)
		if arg_121_0 == UIItemList.EventUpdate then
			local var_121_0 = var_119_2[arg_121_1 + 1]
			local var_121_1 = var_119_2[arg_121_1 + 1]:HasReply()

			setText(arg_121_2:Find("main/reply"), var_119_2[arg_121_1 + 1]:GetReplyBtnTxt())
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
				onToggle(arg_119_0, arg_121_2:Find("main/bubble"), function(arg_122_0)
					setActive(arg_121_2:Find("replys"), arg_122_0)

					return
				end, SFX_PANEL)
				arg_119_0:UpdateReplys(arg_121_2, var_121_0)
				triggerToggle(arg_121_2:Find("main/bubble"), true)
			else
				setActive(arg_121_2:Find("replys"), false)
				triggerToggle(arg_121_2:Find("main/bubble"), false)
			end

			local var_121_4 = arg_121_2:Find("main/bubble")

			var_121_4:GetComponent(typeof(Toggle)).enabled = var_121_1
		end

		return
	end)
	Canvas.ForceUpdateCanvases()
	arg_119_0.commentList:align(#var_119_2)

	return
end

function var_0_0.UpdateReplys(arg_123_0, arg_123_1, arg_123_2)
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

function var_0_0.OpenCommentPanel(arg_126_0, arg_126_1)
	local var_126_0 = getProxy(InstagramProxy):GetOfficialAccounts()[arg_126_1]

	if not var_126_0:CanOpenComment() then
		return
	end

	setActive(arg_126_0.optionalPanel, true)

	local var_126_1 = var_126_0:GetOptionComment()

	arg_126_0.commentPanel.sizeDelta = Vector2(0, #var_126_1 * 120 + 40)

	local var_126_2 = UIItemList.New(arg_126_0.optionalPanel, arg_126_0.optionalPanel:Find("option1"))

	var_126_2:make(function(arg_127_0, arg_127_1, arg_127_2)
		if arg_127_0 == UIItemList.EventUpdate then
			local var_127_0 = var_126_1[arg_127_1 + 1].id
			local var_127_1 = var_126_1[arg_127_1 + 1].index

			setText(arg_127_2:Find("Text"), HXSet.hxLan(var_126_1[arg_127_1 + 1].text))
			onButton(arg_126_0, arg_127_2, function()
				arg_126_0:emit(InstagramChatMediator.ON_OFFICIAL_ACCOUNTS_OPERATE, ActivityConst.INSTAGRAM_OP_COMMENT, arg_126_1, var_127_0, var_127_1)
				arg_126_0:CloseCommentPanel()

				return
			end, SFX_PANEL)
		end

		return
	end)
	var_126_2:align(#var_126_1)

	return
end

function var_0_0.CloseCommentPanel(arg_129_0)
	arg_129_0.commentPanel.sizeDelta = Vector2(0, 0)

	setActive(arg_129_0.optionalPanel, false)

	return
end

function var_0_0.ReadOfficialAccountComment(arg_130_0)
	if arg_130_0.currentChat and arg_130_0.currentChat.chatType == InstagramConst.INSTAGRAM_CHAT_TYPE.OFFICIAL_ACCOUNT and arg_130_0.currentOfficalID then
		local var_130_0 = getProxy(InstagramProxy):GetOfficialAccounts()[arg_130_0.currentOfficalID]

		if var_130_0 and not var_130_0:IsReaded() then
			arg_130_0:emit(InstagramChatMediator.ON_OFFICIAL_ACCOUNTS_OPERATE, ActivityConst.INSTAGRAM_OP_MARK_READ, arg_130_0.currentOfficalID)
		end
	end

	return
end

function var_0_0.RefreshOfficialAccountTips(arg_131_0)
	for iter_131_0, iter_131_1 in pairs(arg_131_0.officialAccountsItemList) do
		iter_131_1:RefreshTip()
	end

	arg_131_0.charaScrollrect:SetTotalCount(#arg_131_0.chatList)

	return
end

function var_0_0.SetImageByUrl(arg_132_0, arg_132_1, arg_132_2, arg_132_3)
	if not arg_132_1 or arg_132_1 == "" then
		setActive(arg_132_2.gameObject, false)

		if arg_132_3 then
			arg_132_3()
		end
	else
		setActive(arg_132_2.gameObject, true)

		if arg_132_0.sprites[arg_132_1] then
			arg_132_2.texture = arg_132_0.sprites[arg_132_1]

			if arg_132_3 then
				arg_132_3()
			end
		else
			arg_132_2.enabled = false

			arg_132_0.downloadmgr:GetTexture("ins", "1", arg_132_1, UnityEngine.Events.UnityAction_UnityEngine_Texture(function(arg_133_0)
				if arg_132_0.exited then
					return
				end

				if not arg_132_0.sprites then
					return
				end

				arg_132_0.sprites[arg_132_1] = arg_133_0
				arg_132_2.texture = arg_133_0
				arg_132_2.enabled = true

				if arg_132_3 then
					arg_132_3()
				end

				return
			end))
			table.insert(arg_132_0.toDownloadList, arg_132_1)
		end
	end

	return
end

function var_0_0.AddOfficialAccountsTimer(arg_134_0)
	arg_134_0:StopOfficialAccountsTimer()

	local var_134_0 = pg.TimeMgr.GetInstance():GetServerTime()

	for iter_134_0, iter_134_1 in pairs((getProxy(InstagramProxy):GetOfficialAccounts())) do
		local var_134_1 = iter_134_1:GetFastestRefreshTime()

		if var_134_1 then
			if var_134_1 - var_134_0 <= 0 then
				arg_134_0:emit(InstagramChatMediator.ON_OFFICIAL_ACCOUNTS_OPERATE, ActivityConst.INSTAGRAM_OP_UPDATE, iter_134_1.id)
			else
				arg_134_0.officialAccountsTimerList[iter_134_1.id] = Timer.New(function()
					arg_134_0:emit(InstagramChatMediator.ON_OFFICIAL_ACCOUNTS_OPERATE, ActivityConst.INSTAGRAM_OP_UPDATE, iter_134_1.id)

					return
				end, var_134_1 - var_134_0, 1)

				arg_134_0.officialAccountsTimerList[iter_134_1.id]:Start()
			end
		end
	end

	return
end

function var_0_0.StopOfficialAccountsTimer(arg_136_0)
	for iter_136_0, iter_136_1 in pairs(arg_136_0.officialAccountsTimerList) do
		arg_136_0.officialAccountsTimerList[iter_136_0]:Stop()
	end

	arg_136_0.officialAccountsTimerList = {}

	return
end

function var_0_0.EixtOfficialAccounts(arg_137_0)
	arg_137_0:StopOfficialAccountsTimer()

	arg_137_0.officialAccountsItemList = nil
	arg_137_0.exited = true
	arg_137_0.sprites = nil

	local var_137_0 = arg_137_0.toDownloadList or {}

	for iter_137_0, iter_137_1 in ipairs(var_137_0) do
		arg_137_0.downloadmgr:StopLoader(iter_137_1)
	end

	arg_137_0.toDownloadList = {}

	return
end

return var_0_0
