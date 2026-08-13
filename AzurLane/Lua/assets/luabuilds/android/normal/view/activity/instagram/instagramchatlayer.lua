class = var_0_10000

local var_0_0 = "InstagramChatLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseUI"))

pg = var_0_0

local var_0_2 = var_0_0.activity_ins_ship_group_template

pg = var_2

local var_0_3 = var_2.activity_ins_redpackage

pg = var_3

local var_0_4 = var_3.emoji_template

function var_0_1.getUIName(arg_1_0)
	return "InstagramChatUI"
end

function var_0_1.getGroupName(arg_2_0)
	return "InstagramMainUI"
end

var_0_1.ReadType = {
	"all",
	"hasReaded",
	"waitingForRead"
}
var_0_1.TypeType = {
	"all",
	"single",
	"multiple"
}
var_0_1.CampIds = {
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
var_0_1.CampNames = {
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

function var_0_1.init(arg_3_0)
	local var_3_0 = arg_3_0._tf

	arg_3_0.leftPanel = var_1.Find(var_3_0, "main/leftPanel")

	local var_3_1 = arg_3_0.leftPanel

	arg_3_0.filterBtn = var_1.Find(var_3_1, "leftTop/filter")

	local var_3_2 = arg_3_0.filterBtn

	arg_3_0.isFiltered = var_1.Find(var_3_2, "isFiltered")

	local var_3_3 = arg_3_0.leftPanel
	local var_3_4 = var_1.Find(var_3_3, "charaScroll")

	arg_3_0.charaScrollrect = var_1.GetComponent(var_3_4, "LScrollRect")

	local var_3_5 = arg_3_0.leftPanel

	arg_3_0.charaScrollContent = var_1.Find(var_3_5, "charaScroll/Viewport/Content")

	local var_3_6 = arg_3_0._tf

	arg_3_0.rightPanel = var_1.Find(var_3_6, "main/rightPanel")

	local var_3_7 = arg_3_0.rightPanel

	arg_3_0.rightChatPanel = var_1.Find(var_3_7, "chat")

	local var_3_8 = arg_3_0.rightPanel

	arg_3_0.rightOfficialAccountsPanel = var_1.Find(var_3_8, "officialAccounts")

	local var_3_9 = arg_3_0.rightPanel

	arg_3_0.characterName = var_1.Find(var_3_9, "chat/rightTop/name")

	local var_3_10 = arg_3_0.rightPanel

	arg_3_0.careBtn = var_1.Find(var_3_10, "chat/rightTop/careBtn")

	local var_3_11 = arg_3_0.rightPanel

	arg_3_0.topicBtn = var_1.Find(var_3_11, "chat/rightTop/topicBtn")

	local var_3_12 = arg_3_0.rightPanel

	arg_3_0.backgroundBtn = var_1.Find(var_3_12, "chat/rightTop/backgroundBtn")
	UIItemList = var_1

	local var_3_13 = var_1.New
	local var_3_14 = arg_3_0.rightPanel
	local var_3_15 = var_2.Find(var_3_14, "chat/messageScroll/Viewport/Content")
	local var_3_16 = arg_3_0.rightPanel

	arg_3_0.messageList = var_3_13(var_3_15, var_3.Find(var_3_16, "chat/messageScroll/Viewport/Content/messageCard"))

	local var_3_17 = arg_3_0.rightPanel

	arg_3_0.optionPanel = var_1.Find(var_3_17, "chat/optionPanel")
	UIItemList = var_1

	local var_3_18 = var_1.New
	local var_3_19 = arg_3_0.optionPanel
	local var_3_20 = arg_3_0.optionPanel

	arg_3_0.optionList = var_3_18(var_3_19, var_3.Find(var_3_20, "option"))

	local var_3_21 = arg_3_0._tf

	arg_3_0.filterUI = var_1.Find(var_3_21, "subPages/InstagramFilterUI")

	local var_3_22 = arg_3_0._tf

	arg_3_0.topicUI = var_1.Find(var_3_22, "subPages/InstagramTopicUI")

	local var_3_23 = arg_3_0._tf

	arg_3_0.backgroundUI = var_1.Find(var_3_23, "subPages/InstagramBackgroundUI")

	local var_3_24 = arg_3_0._tf

	arg_3_0.redPacketUI = var_1.Find(var_3_24, "subPages/InstagramRedPacketUI")
	setText = var_1

	local var_3_25 = arg_3_0.filterBtn
	local var_3_26 = var_2.Find(var_3_25, "Text")

	i18n = var_3_25

	var_1(var_3_26, var_3_25("juuschat_filter_title"))

	setText = var_1

	local var_3_27 = arg_3_0.filterUI
	local var_3_28 = var_2.Find(var_3_27, "panel/filterScroll/Viewport/Content/read/subTitleFrame/subTitle")

	i18n = var_3_27

	var_1(var_3_28, var_3_27("juuschat_filter_subtitle1"))

	setText = var_1

	local var_3_29 = arg_3_0.filterUI
	local var_3_30 = var_2.Find(var_3_29, "panel/filterScroll/Viewport/Content/type/subTitleFrame/subTitle")

	i18n = var_3_29

	var_1(var_3_30, var_3_29("juuschat_filter_subtitle2"))

	setText = var_1

	local var_3_31 = arg_3_0.filterUI
	local var_3_32 = var_2.Find(var_3_31, "panel/filterScroll/Viewport/Content/subTitleFrame/subTitle")

	i18n = var_3_31

	var_1(var_3_32, var_3_31("juuschat_filter_subtitle3"))

	setText = var_1

	local var_3_33 = arg_3_0.filterUI
	local var_3_34 = var_2.Find(var_3_33, "panel/filterScroll/Viewport/Content/read/option/Text")

	i18n = var_3_33

	var_1(var_3_34, var_3_33("juuschat_filter_tip1"))

	setText = var_1

	local var_3_35 = arg_3_0.filterUI
	local var_3_36 = var_2.Find(var_3_35, "panel/filterScroll/Viewport/Content/read/option_1/Text")

	i18n = var_3_35

	var_1(var_3_36, var_3_35("juuschat_filter_tip2"))

	setText = var_1

	local var_3_37 = arg_3_0.filterUI
	local var_3_38 = var_2.Find(var_3_37, "panel/filterScroll/Viewport/Content/read/option_2/Text")

	i18n = var_3_37

	var_1(var_3_38, var_3_37("juuschat_filter_tip3"))

	setText = var_1

	local var_3_39 = arg_3_0.filterUI
	local var_3_40 = var_2.Find(var_3_39, "panel/filterScroll/Viewport/Content/type/option/Text")

	i18n = var_3_39

	var_1(var_3_40, var_3_39("juuschat_filter_tip1"))

	setText = var_1

	local var_3_41 = arg_3_0.filterUI
	local var_3_42 = var_2.Find(var_3_41, "panel/filterScroll/Viewport/Content/type/option_1/Text")

	i18n = var_3_41

	var_1(var_3_42, var_3_41("juuschat_filter_tip4"))

	setText = var_1

	local var_3_43 = arg_3_0.filterUI
	local var_3_44 = var_2.Find(var_3_43, "panel/filterScroll/Viewport/Content/type/option_2/Text")

	i18n = var_3_43

	var_1(var_3_44, var_3_43("juuschat_filter_tip5"))

	setText = var_1

	local var_3_45 = arg_3_0.topicUI
	local var_3_46 = var_2.Find(var_3_45, "panel/topicScroll/Viewport/Content/self/topic/waiting")

	i18n = var_3_45

	var_1(var_3_46, var_3_45("juuschat_chattip3"))

	setText = var_1

	local var_3_47 = arg_3_0.topicUI
	local var_3_48 = var_2.Find(var_3_47, "panel/topicScroll/Viewport/Content/self/topic/selected/Text")

	i18n = var_3_47

	var_1(var_3_48, var_3_47("juuschat_label2"))

	setText = var_1

	local var_3_49 = arg_3_0.topicUI
	local var_3_50 = var_2.Find(var_3_49, "panel/topicScroll/Viewport/Content/other/topic/waiting")

	i18n = var_3_49

	var_1(var_3_50, var_3_49("juuschat_chattip3"))

	setText = var_1

	local var_3_51 = arg_3_0.topicUI
	local var_3_52 = var_2.Find(var_3_51, "panel/topicScroll/Viewport/Content/other/topic/selected/Text")

	i18n = var_3_51

	var_1(var_3_52, var_3_51("juuschat_label2"))

	setText = var_1

	local var_3_53 = arg_3_0.backgroundUI
	local var_3_54 = var_2.Find(var_3_53, "panel/backgroundScroll/Viewport/Content/background/selected/Text")

	i18n = var_3_53

	var_1(var_3_54, var_3_53("juuschat_label1"))

	setText = var_1

	local var_3_55 = arg_3_0.redPacketUI
	local var_3_56 = var_2.Find(var_3_55, "panel/got/detailBtn/Text")

	i18n = var_3_55

	var_1(var_3_56, var_3_55("juuschat_redpacket_show_detail"))

	setText = var_1

	local var_3_57 = arg_3_0.redPacketUI
	local var_3_58 = var_2.Find(var_3_57, "panel/detail/title")

	i18n = var_3_57

	var_1(var_3_58, var_3_57("juuschat_redpacket_detail"))

	setText = var_1

	local var_3_59 = arg_3_0._tf
	local var_3_60 = var_2.Find(var_3_59, "main/noFilteredMessageBg/Text")

	i18n = var_3_59

	var_1(var_3_60, var_3_59("juuschat_filter_empty"))

	setText = var_1

	local var_3_61 = arg_3_0.backgroundUI
	local var_3_62 = var_2.Find(var_3_61, "panel/backgroundScroll/Viewport/Content/background/lockFrame/Text")

	i18n = var_3_61

	var_1(var_3_62, var_3_61("juuschat_background_tip1"))

	local var_3_63 = arg_3_0.redPacketUI

	arg_3_0.redPacketGot = var_1.Find(var_3_63, "panel/got")

	arg_3_0:OverlayPanel(arg_3_0._tf)

	SetActive = var_1

	var_1(arg_3_0.filterUI, false)

	SetActive = var_1

	var_1(arg_3_0.isFiltered, false)

	SetActive = var_1

	var_1(arg_3_0.topicUI, false)

	SetActive = var_1

	var_1(arg_3_0.backgroundUI, false)

	SetActive = var_1

	var_1(arg_3_0.redPacketUI, false)

	SetActive = var_1

	var_1(arg_3_0.rightPanel, false)

	arg_3_0.timerList = {}
	arg_3_0.canFresh = false

	local var_3_64 = arg_3_0.rightPanel
	local var_3_65 = var_1.Find(var_3_64, "chat/messageScroll/Scrollbar Vertical")
	local var_3_66 = var_1.GetComponent

	typeof = var_3
	RectTransform = var_4
	arg_3_0.messageScrollWidth = var_3_66(var_3_65, var_3(var_4)).rect.width
	arg_3_0.messageScrollHeight = var_1.rect.height

	local var_3_67 = arg_3_0.filterUI
	local var_3_68 = var_2.Find(var_3_67, "panel/title")
	local var_3_69 = var_2.GetComponent

	typeof = var_4
	Image = var_5

	local var_3_70 = var_3_69(var_3_68, var_4(var_5))

	var_2.SetNativeSize(var_3_70)

	local var_3_71 = arg_3_0.topicUI
	local var_3_72 = var_2.Find(var_3_71, "panel/title")
	local var_3_73 = var_2.GetComponent

	typeof = var_4
	Image = var_5

	local var_3_74 = var_3_73(var_3_72, var_4(var_5))

	var_2.SetNativeSize(var_3_74)

	local var_3_75 = arg_3_0.backgroundUI
	local var_3_76 = var_2.Find(var_3_75, "panel/title")
	local var_3_77 = var_2.GetComponent

	typeof = var_4
	Image = var_5

	local var_3_78 = var_3_77(var_3_76, var_4(var_5))

	var_2.SetNativeSize(var_3_78)
	arg_3_0:InitOfficialAccounts()

	return
end

function var_0_1.didEnter(arg_4_0)
	arg_4_0:SetData()

	function arg_4_0.charaScrollrect.onInitItem(arg_5_0)
		local var_5_0 = arg_4_0

		var_1.OnInitItem(var_5_0, arg_5_0)

		return
	end

	function arg_4_0.charaScrollrect.onUpdateItem(arg_6_0, arg_6_1)
		local var_6_0 = arg_4_0

		var_2.OnUpdateItem(var_6_0, arg_6_0, arg_6_1)

		return
	end

	arg_4_0:UpdateCharaList(false, false)
	arg_4_0:SetFilterPanel()

	arg_4_0.officialAccountsTimerList = {}
	arg_4_0.officialAccountsItemList = {}

	arg_4_0:AddOfficialAccountsTimer()

	return
end

function var_0_1.InsertOfficialAccounts(arg_7_0)
	InstagramTools = var_1_10001

	if var_1_10001.ExistOfficialAccounts() then
		table = var_1

		local var_7_0 = var_1.insert
		local var_7_1 = arg_7_0.chatList
		local var_7_2 = 1
		local var_7_3 = {}

		InstagramConst = var_1_10005
		var_7_3.chatType = var_1_10005.INSTAGRAM_CHAT_TYPE.OFFICIAL_ACCOUNT

		var_7_0(var_7_1, var_7_2, var_7_3)
	end

	return
end

function var_0_1.OnInitItem(arg_8_0, arg_8_1)
	return
end

function var_0_1.OnUpdateItem(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0.chatList[arg_9_1 + 1]

	tf = var_4

	local var_9_1 = var_4(arg_9_2)

	setActive = var_5

	var_5(var_9_1, true)

	local var_9_2 = var_9_0.chatType

	InstagramConst = var_6

	local var_9_3 = var_9_2 == var_6.INSTAGRAM_CHAT_TYPE.OFFICIAL_ACCOUNT

	setActive = var_9_4

	var_9_4(var_9_1:Find("chat"), not var_9_3)

	setActive = var_9_4

	var_9_4(var_9_1:Find("officialAccounts"), var_9_3)

	local var_9_4

	if not var_9_3 then
		var_9_4 = var_9_0.sculpture

		if var_9_0.currentTopic.isII and var_9_0.sculptureII ~= "" then
			var_9_4 = var_9_0.sculptureII
		end

		setImageSprite = var_7

		local var_9_5 = var_9_1
		local var_9_6 = var_9_1.Find(var_9_5, "chat/charaBg/chara")

		LoadSprite = var_9_5

		var_7(var_9_6, var_9_5("qicon/" .. var_9_4), false)

		setText = var_7

		var_7(var_9_1:Find("chat/name"), var_9_0.name)

		local var_9_7 = var_9_0:GetDisplayWord()

		if not arg_9_0.currentChat or arg_9_0.currentChat.characterId ~= var_9_0.characterId or not arg_9_0.isSlowMsg then
			setText = var_8
			var_1_10010 = var_9_1

			var_8(var_9_1.Find(var_1_10010, "chat/msg"), var_9_7)
		end

		setText = var_8
		var_1_10010 = var_9_1

		var_8(var_9_1.Find(var_1_10010, "chat/displayWord"), var_9_7)

		SetActive = var_8
		var_1_10010 = var_9_1

		local var_9_8 = var_9_1.Find(var_1_10010, "chat/care")

		var_1_10010 = var_9_0.care == 1

		var_8(var_9_8, var_1_10010)

		local var_9_10

		if var_9_0.care == 1 and arg_9_0.careAniTriggerId and arg_9_0.careAniTriggerId == var_9_0.characterId then
			arg_9_0.careAniTriggerId = nil

			local var_9_9 = var_9_1:Find("chat/care")

			var_9_10 = var_9_10.GetComponent
			typeof = var_1_10010
			Animation = var_11

			local var_9_11 = var_9_10(var_9_9, var_1_10010(var_11))

			var_9_10.Play(var_9_11, "anim_newinstagram_care")
		end

		SetActive = var_9_10
		var_1_10010 = var_9_1

		local var_9_12 = var_9_1.Find(var_1_10010, "chat/tip")

		var_1_10010 = var_9_0:GetCharacterEndFlag() == 0

		var_9_10(var_9_12, var_1_10010)

		setText = var_9_10
		var_1_10010 = var_9_1

		var_9_10(var_9_1.Find(var_1_10010, "chat/id"), var_9_0.characterId)

		onButton = var_9_10

		local var_9_13 = arg_9_0

		var_1_10010 = var_9_1

		local function var_9_14()
			if arg_9_0.currentChat and arg_9_0.currentChat.characterId ~= var_9_0.characterId then
				local var_10_0 = arg_9_0

				var_0.ResetCharaTextFunc(var_10_0, arg_9_0.currentChat.characterId)
			end

			local var_10_1 = arg_9_0

			var_10_1.currentChat = var_9_0
			SetActive = var_10_1

			var_10_1(arg_9_0.rightPanel, true)

			SetActive = var_10_1

			local var_10_2 = arg_9_0._tf

			var_10_1(var_1.Find(var_10_2, "main/rightNoMessageBg"), false)

			local var_10_3 = arg_9_0

			var_0.UpdateChatContent(var_10_3, var_9_0, false, false)

			local var_10_4 = arg_9_0

			var_0.SetTopicPanel(var_10_4, var_9_0)

			local var_10_5 = arg_9_0

			var_0.SetBackgroundPanel(var_10_5, var_9_0)

			for iter_10_0 = 0, arg_9_0.charaScrollContent.childCount - 1 do
				SetActive = var_4

				local var_10_6 = arg_9_0.charaScrollContent
				local var_10_7 = var_5.GetChild(var_10_6, iter_10_0)

				var_4(var_5.Find(var_10_7, "frame"), false)
			end

			SetActive = var_0

			local var_10_8 = var_9_1

			var_0(var_1.Find(var_10_8, "frame"), true)

			function arg_9_0.cancelFrame()
				IsNil = var_3_10000

				if not var_3_10000(var_9_1) then
					SetActive = var_0

					local var_11_0 = var_9_1

					var_0(var_1.Find(var_11_0, "frame"), false)
				end

				return
			end

			local var_10_9 = arg_9_0.rightPanel
			local var_10_10 = var_0.GetComponent

			typeof = var_2
			Animation = var_3

			local var_10_11 = var_10_10(var_10_9, var_2(var_3))

			var_0.Stop(var_10_11)
			var_0:Play("anim_newinstagram_chat_right_in")

			return
		end

		SFX_PANEL = var_1_10012

		var_9_10(var_9_13, var_1_10010, var_9_14, var_1_10012)
	else
		SetActive = var_9_4

		local var_9_15 = var_9_1
		local var_9_16 = var_9_1.Find(var_9_15, "officialAccounts/tip")

		getProxy = var_9_15
		InstagramProxy = var_9

		local var_9_17 = var_9_15(var_9)

		var_9_4(var_9_16, var_8.ShouldShowOfficialAccountsTip(var_9_17))

		onButton = var_9_4

		local var_9_18 = arg_9_0
		local var_9_19 = var_9_1

		local function var_9_20()
			SetActive = var_2_10000

			var_2_10000(arg_9_0.rightPanel, true)

			SetActive = var_2_10000

			local var_12_0 = arg_9_0._tf

			var_2_10000(var_1.Find(var_12_0, "main/rightNoMessageBg"), false)

			for iter_12_0 = 0, arg_9_0.charaScrollContent.childCount - 1 do
				SetActive = var_2_10004

				local var_12_1 = arg_9_0.charaScrollContent
				local var_12_2 = var_5.GetChild(var_12_1, iter_12_0)

				var_2_10004(var_5.Find(var_12_2, "frame"), false)
			end

			SetActive = var_0

			local var_12_3 = var_9_1

			var_0(var_1.Find(var_12_3, "frame"), true)

			function arg_9_0.cancelFrame()
				IsNil = var_3_10000

				if not var_3_10000(var_9_1) then
					SetActive = var_0

					local var_13_0 = var_9_1

					var_0(var_1.Find(var_13_0, "frame"), false)
				end

				return
			end

			arg_9_0.currentChat = var_9_0

			local var_12_4 = arg_9_0

			var_0.UpdateOfficialAccounts(var_12_4, var_9_0)

			local var_12_5 = arg_9_0.rightPanel
			local var_12_6 = var_0.GetComponent

			typeof = var_2
			Animation = var_3

			local var_12_7 = var_12_6(var_12_5, var_2(var_3))

			var_0.Stop(var_12_7)
			var_0:Play("anim_newinstagram_chat_right_in")

			return
		end

		SFX_PANEL = var_1_10010

		var_9_4(var_9_18, var_9_19, var_9_20, var_1_10010)
	end

	if arg_9_0.currentChat then
		SetActive = var_6

		var_6(var_9_1:Find("frame"), arg_9_0.currentChat == var_9_0)
	end

	return
end

function var_0_1.UpdateCharaList(arg_14_0, arg_14_1, arg_14_2)
	if not arg_14_0.chatList or #arg_14_0.chatList == 0 then
		SetActive = var_3

		var_3(arg_14_0.leftPanel, false)

		SetActive = var_3

		var_3(arg_14_0.rightPanel, false)

		SetActive = var_3

		local var_14_0 = arg_14_0._tf

		var_3(var_4.Find(var_14_0, "main/noMessageBg"), true)

		SetActive = var_3

		local var_14_1 = arg_14_0._tf

		var_3(var_4.Find(var_14_1, "main/noFilteredMessageBg"), false)

		SetActive = var_3

		local var_14_2 = arg_14_0._tf

		var_3(var_4.Find(var_14_2, "main/rightNoMessageBg"), false)

		return
	end

	if not arg_14_0.currentChat then
		SetActive = var_3

		var_3(arg_14_0.rightPanel, false)

		SetActive = var_3

		local var_14_3 = arg_14_0._tf

		var_3(var_4.Find(var_14_3, "main/rightNoMessageBg"), true)
	else
		SetActive = var_3

		var_3(arg_14_0.rightPanel, true)

		SetActive = var_3

		local var_14_4 = arg_14_0._tf

		var_3(var_4.Find(var_14_4, "main/rightNoMessageBg"), false)
	end

	arg_14_0.isSlowMsg = arg_14_1

	local var_14_5 = arg_14_0

	arg_14_0.SetFilterResult(var_14_5)

	if arg_14_0.currentChat then
		local var_14_6 = arg_14_0.currentChat.chatType

		InstagramConst = var_14_5

		if var_14_6 == var_14_5.INSTAGRAM_CHAT_TYPE.OFFICIAL_ACCOUNT then
			arg_14_0:UpdateOfficialAccounts(arg_14_0.currentChat)
		else
			arg_14_0:UpdateChatContent(arg_14_0.currentChat, arg_14_1, arg_14_2)
			arg_14_0:SetTopicPanel(arg_14_0.currentChat)
		end
	end

	return
end

function var_0_1.UpdateChatContent(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	setActive = var_1_10004

	var_1_10004(arg_15_0.rightChatPanel, true)

	setActive = var_1_10004

	var_1_10004(arg_15_0.rightOfficialAccountsPanel, false)

	SetActive = var_1_10004

	var_1_10004(arg_15_0.rightPanel, true)

	setText = var_1_10004

	var_1_10004(arg_15_0.characterName, arg_15_1.name)

	local var_15_0 = arg_15_0.careBtn
	local var_15_1 = var_4.Find(var_15_0, "care")

	SetActive = var_15_0

	var_15_0(var_15_1, arg_15_1.care == 1)

	onButton = var_15_0

	local var_15_2 = arg_15_0
	local var_15_3 = arg_15_0.careBtn

	local function var_15_4()
		local var_16_0 = arg_15_1.care == 0 and 1 or 0
		local var_16_1 = arg_15_0
		local var_16_2 = var_2.emit

		InstagramChatMediator = var_2_10004

		var_16_2(var_16_1, var_2_10004.CHANGE_CARE, arg_15_1.characterId, var_16_0)

		arg_15_0.careAniTriggerId = arg_15_1.characterId

		return
	end

	SFX_PANEL = var_1_10009

	var_15_0(var_15_2, var_15_3, var_15_4, var_1_10009)

	local var_15_5 = arg_15_0.rightPanel
	local var_15_6 = var_5.Find(var_15_5, "chat/paintingMask")
	local var_15_7 = var_5.Find(var_15_6, "painting")
	local var_15_8 = arg_15_0.rightPanel
	local var_15_9 = var_7.Find(var_15_8, "chat/groupBackground")
	local var_15_10

	if arg_15_1.type == 1 then
		SetActive = var_15_10

		var_15_10(var_5, true)

		SetActive = var_15_10

		var_15_10(var_15_9, false)

		var_15_10 = "unknown"

		if arg_15_1.skinId == 0 then
			var_15_10 = arg_15_1:GetPainting()
		else
			ipairs = var_9

			for iter_15_0, iter_15_1 in var_9(arg_15_1.skins) do
				if iter_15_1.id == arg_15_1.skinId then
					var_15_10 = iter_15_1.painting
				end
			end
		end

		if not arg_15_0.paintingName then
			setPaintingPrefabAsync = var_9

			var_9(var_15_7, var_15_10, "pifu")

			arg_15_0.paintingName = var_15_10
		elseif arg_15_0.paintingName and arg_15_0.paintingName ~= var_15_10 then
			retPaintingPrefab = var_9

			var_9(var_15_7, arg_15_0.paintingName)

			setPaintingPrefabAsync = var_9

			var_9(var_15_7, var_15_10, "pifu")

			arg_15_0.paintingName = var_15_10
		end
	else
		SetActive = var_15_10

		var_15_10(var_5, false)

		SetActive = var_15_10

		var_15_10(var_15_9, true)

		if arg_15_0.paintingName then
			retPaintingPrefab = var_8

			var_8(var_15_7, arg_15_0.paintingName)

			arg_15_0.paintingName = nil
		end

		setImageSprite = var_8

		local var_15_11 = var_15_9

		LoadSprite = var_10

		var_8(var_15_11, var_10("ui/InstagramChatBackgrounds_atlas", arg_15_1.groupBackground), true)
	end

	local var_15_12 = arg_15_1.currentTopic
	local var_15_13 = var_8.GetDisplayWordList(var_15_12)

	if not arg_15_3 then
		arg_15_0:UpdateOptionPanel(arg_15_1.currentTopic, var_15_13)
		arg_15_0:UpdateMessageList(arg_15_1.currentTopic, var_15_13, arg_15_2, arg_15_1.characterId, arg_15_1.type)
	end

	if not arg_15_2 and arg_15_1.currentTopic.readFlag == 0 then
		local var_15_14 = arg_15_0
		local var_15_15 = arg_15_0.emit

		InstagramChatMediator = var_1_10011

		var_15_15(var_15_14, var_1_10011.SET_READED, {
			arg_15_1.currentTopic.topicId
		})
	end

	return
end

function var_0_1.UpdateMessageList(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4, arg_17_5)
	arg_17_0:RemoveAllTimer()

	local var_17_0

	for iter_17_0 = #arg_17_2, 1, -1 do
		if arg_17_2[iter_17_0].ship_group ~= 0 then
			if arg_17_2[iter_17_0].type == 3 then
				local var_17_1 = arg_17_1
				local var_17_2 = arg_17_1.RedPacketGotFlag

				tonumber = var_1_10013

				if var_17_2(var_17_1, var_1_10013(arg_17_2[iter_17_0].param)) then
					var_17_0 = iter_17_0

					break
				end
			end
		end
	end

	local var_17_3 = {}

	if var_17_0 then
		for iter_17_1 = var_17_0, 1, -1 do
			if arg_17_2[iter_17_1].ship_group == 0 then
				table = var_12

				var_12.insert(var_17_3, iter_17_1)
			else
				break
			end
		end
	end

	if arg_17_0.shouldShowOption and arg_17_3 then
		arg_17_0:SetOptionPanelActive(false)
	end

	if arg_17_3 then
		onButton = var_8

		local var_17_4 = arg_17_0
		local var_17_5 = arg_17_0.rightPanel
		local var_17_6 = var_10.Find(var_17_5, "chat/messageScroll")

		local function var_17_7()
			local var_18_0 = arg_17_0

			var_0.SpeedUpMessage(var_18_0)

			return
		end

		SFX_PANEL = var_12

		var_8(var_17_4, var_17_6, var_17_7, var_12)
	end

	GetComponent = var_8

	local var_17_8 = arg_17_0.rightPanel
	local var_17_9 = var_9.Find(var_17_8, "chat/messageScroll")

	typeof = var_17_8
	ScrollRect = var_11

	local var_17_10 = var_8(var_17_9, var_17_8(var_11))

	local function var_17_11(arg_19_0)
		Vector2 = var_2_10001

		local var_19_0 = var_2_10001(0, arg_19_0)

		var_17_10.normalizedPosition = var_19_0

		return
	end

	pg = var_10

	local var_17_12 = var_10.gameset.juuschat_dialogue_trigger_time.key_value / 1000

	pg = var_11

	local var_17_13 = var_17_12 - var_11.gameset.juuschat_entering_time.key_value / 1000
	local var_17_14 = arg_17_0.messageList

	var_13.make(var_17_14, function(arg_20_0, arg_20_1, arg_20_2)
		UIItemList = var_2_10003

		if arg_20_0 == var_2_10003.EventUpdate then
			if arg_17_2[arg_20_1 + 1].ship_group == 0 and var_3.type == 0 then
				SetActive = var_4

				var_4(arg_20_2, false)

				return
			end

			local var_20_0 = arg_20_2:Find("charaMessageCard")
			local var_20_1 = arg_20_2
			local var_20_2 = arg_20_2.Find(var_20_1, "playerReplyCard")

			SetActive = var_20_1

			var_20_1(var_20_0, var_3.ship_group ~= 0)

			SetActive = var_20_1

			var_20_1(var_20_2, var_3.ship_group == 0)

			if var_3.ship_group ~= 0 and arg_17_5 == 2 and var_3.type ~= 5 then
				SetActive = var_6

				var_6(arg_20_2:Find("nameBar"), true)

				setText = var_6

				var_6(arg_20_2:Find("nameBar/Text"), var_0_2[var_3.ship_group].name)
			else
				SetActive = var_6

				var_6(arg_20_2:Find("nameBar"), false)
			end

			local var_20_3

			if arg_17_3 and var_17_0 and arg_20_1 + 1 > var_17_0 then
				var_20_3 = (arg_20_1 + 1 - var_17_0) * var_17_12 - var_0

				if #var_17_3 > 1 then
					var_20_3 = var_20_3 + (#var_17_3 - 1) * var_17_13
				end
			end

			if var_3.ship_group ~= 0 then
				local var_20_4 = "unknown"

				if var_0_2[var_3.ship_group] then
					if var_3.ship_group == arg_17_4 and arg_17_1.isII and var_8.sculpture_ii ~= "" then
						var_20_4 = var_8.sculpture_ii
					else
						var_20_4 = var_8.sculpture
					end
				end

				if var_3.type ~= 5 then
					setImageSprite = var_9
					iter_20_2 = arg_20_2
					var_2_10010 = arg_20_2.Find(iter_20_2, "charaMessageCard/charaBg/chara")
					LoadSprite = iter_20_2

					var_9(var_2_10010, iter_20_2("qicon/" .. var_20_4), false)
				end

				if var_3.type == 1 then
					var_2_10010 = arg_17_0

					var_9.SetCharaMessageCardActive(var_2_10010, var_20_0, {
						3
					})

					setText = var_9
					iter_20_2 = arg_20_2

					var_9(arg_20_2.Find(iter_20_2, "charaMessageCard/msgBox/msg"), var_3.param)

					if arg_17_3 and var_17_0 then
						local var_20_5 = arg_20_1 + 1

						if var_17_0 < var_20_5 then
							SetActive = var_20_5

							var_20_5(arg_20_2, false)

							var_2_10010 = arg_17_0

							var_9.StartTimer(var_2_10010, function()
								SetActive = var_3_10000

								var_3_10000(arg_20_2, true)

								local var_21_0 = arg_20_2
								local var_21_1 = var_0.Find(var_21_0, "charaMessageCard/charaBg")
								local var_21_2 = var_0.GetComponent

								typeof = var_2
								Animation = var_3_10003

								local var_21_3 = var_21_2(var_21_1, var_2(var_3_10003))

								var_0.Play(var_21_3, "anim_newinstagram_charabg")

								SetActive = var_0

								local var_21_4 = arg_20_2

								var_0(var_1.Find(var_21_4, "charaMessageCard/waiting"), true)

								SetActive = var_0

								local var_21_5 = arg_20_2

								var_0(var_1.Find(var_21_5, "charaMessageCard/msgBox"), false)

								Canvas = var_0

								var_0.ForceUpdateCanvases()

								LeanTween = var_0

								local var_21_6 = var_0.value

								go = var_1

								local var_21_7 = arg_17_0.rightPanel
								local var_21_8 = var_21_6(var_1(var_2.Find(var_21_7, "chat/messageScroll")), var_17_10.normalizedPosition.y, 0, 0.5)
								local var_21_9 = var_0.setOnUpdate

								System = var_2

								local var_21_10 = var_21_9(var_21_8, var_2.Action_float(var_17_11))
								local var_21_11 = var_0.setEase

								LeanTweenType = var_2

								var_21_11(var_21_10, var_2.easeInOutCubic)

								local var_21_12 = arg_17_0

								var_0.StartTimer(var_21_12, function()
									SetActive = var_4_10000

									local var_22_0 = arg_20_2

									var_4_10000(var_1.Find(var_22_0, "charaMessageCard/waiting"), false)

									SetActive = var_4_10000

									local var_22_1 = arg_20_2

									var_4_10000(var_1.Find(var_22_1, "charaMessageCard/msgBox"), true)

									local var_22_2 = arg_20_2
									local var_22_3 = var_0.Find(var_22_2, "charaMessageCard/msgBox")
									local var_22_4 = var_0.GetComponent

									typeof = var_2
									Animation = var_3

									local var_22_5 = var_22_4(var_22_3, var_2(var_3))

									var_0.Play(var_22_5, "anim_newinstagram_chat_common_in")

									local var_22_6, var_22_7

									if arg_20_1 + 1 ~= #arg_17_2 then
										var_22_6 = arg_17_0

										var_22_7.ChangeCharaTextFunc(var_22_6, arg_17_4, var_0.param)
									else
										var_22_6 = arg_17_0
										var_22_7 = var_22_7.emit
										InstagramChatMediator = var_2

										var_22_7(var_22_6, var_2.SET_READED, {
											arg_17_1.topicId
										})
									end

									Canvas = var_22_7

									var_22_7.ForceUpdateCanvases()

									LeanTween = var_0

									local var_22_8 = var_0.value

									go = var_22_6

									local var_22_9 = arg_17_0.rightPanel
									local var_22_10 = var_22_8(var_22_6(var_2.Find(var_22_9, "chat/messageScroll")), var_17_10.normalizedPosition.y, 0, 0.5)
									local var_22_11 = var_0.setOnUpdate

									System = var_2

									local var_22_12 = var_22_11(var_22_10, var_2.Action_float(var_17_11))
									local var_22_13 = var_0.setEase

									LeanTweenType = var_2

									var_22_13(var_22_12, var_2.easeInOutCubic)

									local var_22_14 = arg_17_0
									local var_22_15 = var_0.SetEndAniEvent
									local var_22_16 = arg_20_2

									var_22_15(var_22_14, var_2.Find(var_22_16, "charaMessageCard/msgBox"), function()
										if arg_17_0.shouldShowOption and arg_20_1 + 1 == #arg_17_2 then
											local var_23_0 = arg_17_0

											var_0.SetOptionPanelActive(var_23_0, true)
										end

										return
									end)

									return
								end, var_0)

								return
							end, var_20_3)
						end
					end
				elseif var_3.type == 2 then
					var_2_10010 = arg_17_0

					var_9.SetCharaMessageCardActive(var_2_10010, var_20_0, {
						2,
						7
					})

					pg = var_9
					var_2_10010 = var_9.CriMgr.GetInstance()

					var_9.GetCueInfo(var_2_10010, "cv-" .. var_3.ship_group, var_3.param[1], function(arg_24_0)
						setText = var_3_10001

						local var_24_0 = arg_20_2
						local var_24_1 = var_2.Find(var_24_0, "charaMessageCard/voiceBox/time")

						tostring = var_24_0
						math = var_4

						local var_24_2 = var_4.ceil

						tonumber = var_3_10005
						tostring = var_3_10006

						var_3_10001(var_24_1, var_24_0(var_24_2(var_3_10005(var_3_10006(arg_24_0.length)) / 1000)) .. "\"")

						return
					end)

					onButton = var_9
					var_2_10010 = arg_17_0
					var_2_10012 = arg_20_2
					iter_20_2 = arg_20_2.Find(var_2_10012, "charaMessageCard/voiceBox")

					function var_2_10012()
						pg = var_3_10000

						local var_25_0 = var_3_10000.CriMgr.GetInstance()

						var_0.PlaySoundEffect_V3(var_25_0, "event:/cv/" .. var_0.ship_group .. "/" .. var_0.param[1])

						return
					end

					SFX_PANEL = var_13

					var_9(var_2_10010, iter_20_2, var_2_10012, var_13)

					setText = var_9
					iter_20_2 = arg_20_2

					var_9(arg_20_2.Find(iter_20_2, "charaMessageCard/voiceMsgBox/voiceMsg/msg"), var_3.param[2])

					if arg_17_3 and var_17_0 then
						local var_20_6 = arg_20_1 + 1

						if var_17_0 < var_20_6 then
							SetActive = var_20_6

							var_20_6(arg_20_2, false)

							var_2_10010 = arg_17_0

							var_9.StartTimer(var_2_10010, function()
								SetActive = var_3_10000

								var_3_10000(arg_20_2, true)

								local var_26_0 = arg_20_2
								local var_26_1 = var_0.Find(var_26_0, "charaMessageCard/charaBg")
								local var_26_2 = var_0.GetComponent

								typeof = var_2
								Animation = var_3_10003

								local var_26_3 = var_26_2(var_26_1, var_2(var_3_10003))

								var_0.Play(var_26_3, "anim_newinstagram_charabg")

								SetActive = var_0

								local var_26_4 = arg_20_2

								var_0(var_1.Find(var_26_4, "charaMessageCard/waiting"), true)

								SetActive = var_0

								local var_26_5 = arg_20_2

								var_0(var_1.Find(var_26_5, "charaMessageCard/voiceBox"), false)

								SetActive = var_0

								local var_26_6 = arg_20_2

								var_0(var_1.Find(var_26_6, "charaMessageCard/voiceMsgBox"), false)

								Canvas = var_0

								var_0.ForceUpdateCanvases()

								LeanTween = var_0

								local var_26_7 = var_0.value

								go = var_1

								local var_26_8 = arg_17_0.rightPanel
								local var_26_9 = var_26_7(var_1(var_2.Find(var_26_8, "chat/messageScroll")), var_17_10.normalizedPosition.y, 0, 0.5)
								local var_26_10 = var_0.setOnUpdate

								System = var_2

								local var_26_11 = var_26_10(var_26_9, var_2.Action_float(var_17_11))
								local var_26_12 = var_0.setEase

								LeanTweenType = var_2

								var_26_12(var_26_11, var_2.easeInOutCubic)

								local var_26_13 = arg_17_0

								var_0.StartTimer(var_26_13, function()
									SetActive = var_4_10000

									local var_27_0 = arg_20_2

									var_4_10000(var_1.Find(var_27_0, "charaMessageCard/waiting"), false)

									SetActive = var_4_10000

									local var_27_1 = arg_20_2

									var_4_10000(var_1.Find(var_27_1, "charaMessageCard/voiceBox"), true)

									SetActive = var_4_10000

									local var_27_2 = arg_20_2

									var_4_10000(var_1.Find(var_27_2, "charaMessageCard/voiceMsgBox"), true)

									local var_27_3 = arg_20_2
									local var_27_4 = var_0.Find(var_27_3, "charaMessageCard/voiceBox")
									local var_27_5 = var_0.GetComponent

									typeof = var_2
									Animation = var_3

									local var_27_6 = var_27_5(var_27_4, var_2(var_3))

									var_0.Play(var_27_6, "anim_newinstagram_chat_common_in")

									local var_27_7 = arg_20_2
									local var_27_8 = var_0.Find(var_27_7, "charaMessageCard/voiceMsgBox")
									local var_27_9 = var_0.GetComponent

									typeof = var_2
									Animation = var_3

									local var_27_10 = var_27_9(var_27_8, var_2(var_3))

									var_0.Play(var_27_10, "anim_newinstagram_voicetip_in")

									local var_27_11, var_27_12, var_27_13

									if arg_20_1 + 1 ~= #arg_17_2 then
										var_27_11 = arg_17_0
										var_27_12 = var_27_12.ChangeCharaTextFunc
										var_27_13 = arg_17_4

										local var_27_14 = "<color=#ff6666>"

										i18n = var_4_10004

										var_27_12(var_27_11, var_27_13, var_27_14 .. var_4_10004("juuschat_chattip1") .. "</color>")
									else
										var_27_11 = arg_17_0
										var_27_12 = var_27_12.emit
										InstagramChatMediator = var_27_13

										var_27_12(var_27_11, var_27_13.SET_READED, {
											arg_17_1.topicId
										})
									end

									Canvas = var_27_12

									var_27_12.ForceUpdateCanvases()

									LeanTween = var_0

									local var_27_15 = var_0.value

									go = var_27_11

									local var_27_16 = arg_17_0.rightPanel
									local var_27_17 = var_27_15(var_27_11(var_2.Find(var_27_16, "chat/messageScroll")), var_17_10.normalizedPosition.y, 0, 0.5)
									local var_27_18 = var_0.setOnUpdate

									System = var_2

									local var_27_19 = var_27_18(var_27_17, var_2.Action_float(var_17_11))
									local var_27_20 = var_0.setEase

									LeanTweenType = var_2

									var_27_20(var_27_19, var_2.easeInOutCubic)

									local var_27_21 = arg_17_0
									local var_27_22 = var_0.SetEndAniEvent
									local var_27_23 = arg_20_2

									var_27_22(var_27_21, var_2.Find(var_27_23, "charaMessageCard/voiceBox"), function()
										if arg_17_0.shouldShowOption and arg_20_1 + 1 == #arg_17_2 then
											local var_28_0 = arg_17_0

											var_0.SetOptionPanelActive(var_28_0, true)
										end

										return
									end)

									return
								end, var_0)

								return
							end, var_20_3)
						end
					end
				elseif var_3.type == 3 then
					var_2_10010 = arg_17_0

					var_9.SetCharaMessageCardActive(var_2_10010, var_20_0, {
						5
					})

					local var_20_7 = var_0_3

					tonumber = var_2_10010

					local var_20_8 = var_20_7[var_2_10010(var_3.param)]

					setText = var_2_10010
					var_2_10012 = arg_20_2

					var_2_10010(arg_20_2.Find(var_2_10012, "charaMessageCard/redPacket/desc"), var_20_8.desc)

					iter_20_2 = arg_17_1
					var_2_10010 = var_2_10010.RedPacketGotFlag(iter_20_2, var_20_8.id)
					SetActive = iter_20_2

					iter_20_2(arg_20_2:Find("charaMessageCard/redPacket/got"), var_2_10010)

					var_2_10012 = arg_17_0
					iter_20_2 = iter_20_2.SetRedPacketPanel
					var_2_10014 = arg_20_2

					iter_20_2(var_2_10012, arg_20_2.Find(var_2_10014, "charaMessageCard/redPacket"), var_20_8, var_2_10010, var_20_4, arg_17_1.topicId, var_3.id)

					if arg_17_3 and var_17_0 and arg_20_1 + 1 == var_17_0 then
						var_2_10012 = arg_17_0
						iter_20_2 = iter_20_2.ChangeCharaTextFunc

						local var_20_9 = arg_17_4

						var_2_10014 = "<color=#ff6666>"
						i18n = var_15

						local var_20_10 = var_15("juuschat_chattip2")
						local var_20_11 = "</color>"

						pg = var_17

						local var_20_12 = var_17.activity_ins_redpackage

						tonumber = var_2_10018

						iter_20_2(var_2_10012, var_20_9, var_2_10014 .. var_20_10 .. var_20_11 .. var_20_12[var_2_10018(var_3.param)].desc)
					end

					if arg_17_3 and var_17_0 then
						iter_20_2 = arg_20_1 + 1

						if var_17_0 < iter_20_2 then
							SetActive = iter_20_2

							iter_20_2(arg_20_2, false)

							var_2_10012 = arg_17_0

							iter_20_2.StartTimer(var_2_10012, function()
								SetActive = var_3_10000

								var_3_10000(arg_20_2, true)

								local var_29_0 = arg_20_2
								local var_29_1 = var_0.Find(var_29_0, "charaMessageCard/charaBg")
								local var_29_2 = var_0.GetComponent

								typeof = var_2
								Animation = var_3_10003

								local var_29_3 = var_29_2(var_29_1, var_2(var_3_10003))

								var_0.Play(var_29_3, "anim_newinstagram_charabg")

								SetActive = var_0

								local var_29_4 = arg_20_2

								var_0(var_1.Find(var_29_4, "charaMessageCard/waiting"), true)

								SetActive = var_0

								local var_29_5 = arg_20_2

								var_0(var_1.Find(var_29_5, "charaMessageCard/redPacket"), false)

								Canvas = var_0

								var_0.ForceUpdateCanvases()

								LeanTween = var_0

								local var_29_6 = var_0.value

								go = var_1

								local var_29_7 = arg_17_0.rightPanel
								local var_29_8 = var_29_6(var_1(var_2.Find(var_29_7, "chat/messageScroll")), var_17_10.normalizedPosition.y, 0, 0.5)
								local var_29_9 = var_0.setOnUpdate

								System = var_2

								local var_29_10 = var_29_9(var_29_8, var_2.Action_float(var_17_11))
								local var_29_11 = var_0.setEase

								LeanTweenType = var_2

								var_29_11(var_29_10, var_2.easeInOutCubic)

								local var_29_12 = arg_17_0

								var_0.StartTimer(var_29_12, function()
									SetActive = var_4_10000

									local var_30_0 = arg_20_2

									var_4_10000(var_1.Find(var_30_0, "charaMessageCard/waiting"), false)

									SetActive = var_4_10000

									local var_30_1 = arg_20_2

									var_4_10000(var_1.Find(var_30_1, "charaMessageCard/redPacket"), true)

									local var_30_2 = arg_20_2
									local var_30_3 = var_0.Find(var_30_2, "charaMessageCard/redPacket")
									local var_30_4 = var_0.GetComponent

									typeof = var_2
									Animation = var_3

									local var_30_5 = var_30_4(var_30_3, var_2(var_3))

									var_0.Play(var_30_5, "anim_newinstagram_redpacket_in")

									local var_30_6, var_30_7, var_30_8

									if arg_20_1 + 1 ~= #arg_17_2 then
										var_30_6 = arg_17_0
										var_30_7 = var_30_7.ChangeCharaTextFunc
										var_30_8 = arg_17_4

										local var_30_9 = "<color=#ff6666>"

										i18n = var_4_10004

										local var_30_10 = var_4_10004("juuschat_chattip2")
										local var_30_11 = "</color>"

										pg = var_4_10006

										local var_30_12 = var_4_10006.activity_ins_redpackage

										tonumber = var_4_10007

										var_30_7(var_30_6, var_30_8, var_30_9 .. var_30_10 .. var_30_11 .. var_30_12[var_4_10007(var_0.param)].desc)
									else
										var_30_6 = arg_17_0
										var_30_7 = var_30_7.emit
										InstagramChatMediator = var_30_8

										var_30_7(var_30_6, var_30_8.SET_READED, {
											arg_17_1.topicId
										})
									end

									Canvas = var_30_7

									var_30_7.ForceUpdateCanvases()

									LeanTween = var_0

									local var_30_13 = var_0.value

									go = var_30_6

									local var_30_14 = arg_17_0.rightPanel
									local var_30_15 = var_30_13(var_30_6(var_2.Find(var_30_14, "chat/messageScroll")), var_17_10.normalizedPosition.y, 0, 0.5)
									local var_30_16 = var_0.setOnUpdate

									System = var_2

									local var_30_17 = var_30_16(var_30_15, var_2.Action_float(var_17_11))
									local var_30_18 = var_0.setEase

									LeanTweenType = var_2

									var_30_18(var_30_17, var_2.easeInOutCubic)

									local var_30_19 = arg_17_0
									local var_30_20 = var_0.SetEndAniEvent
									local var_30_21 = arg_20_2

									var_30_20(var_30_19, var_2.Find(var_30_21, "charaMessageCard/redPacket"), function()
										if arg_17_0.shouldShowOption and arg_20_1 + 1 == #arg_17_2 then
											local var_31_0 = arg_17_0

											var_0.SetOptionPanelActive(var_31_0, true)
										end

										return
									end)

									return
								end, var_0)

								return
							end, var_20_3)
						end
					end
				elseif var_3.type == 4 then
					var_2_10010 = arg_17_0

					var_9.SetCharaMessageCardActive(var_2_10010, var_20_0, {
						4
					})

					var_2_10010 = arg_17_0

					local var_20_13 = var_9.ClearEmoji

					var_2_10012 = arg_20_2

					var_20_13(var_2_10010, arg_20_2.Find(var_2_10012, "charaMessageCard/emoji/emoticon"))

					var_2_10010 = arg_17_0

					local var_20_14 = var_9.SetEmoji

					var_2_10012 = arg_20_2
					iter_20_2 = arg_20_2.Find(var_2_10012, "charaMessageCard/emoji/emoticon")
					var_2_10012 = var_0_4
					tonumber = var_13

					var_20_14(var_2_10010, iter_20_2, var_2_10012[var_13(var_3.param)].pic)

					if arg_17_3 and var_17_0 then
						local var_20_15 = arg_20_1 + 1

						if var_17_0 < var_20_15 then
							SetActive = var_20_15

							var_20_15(arg_20_2, false)

							var_2_10010 = arg_17_0

							var_9.StartTimer(var_2_10010, function()
								SetActive = var_3_10000

								var_3_10000(arg_20_2, true)

								local var_32_0 = arg_20_2
								local var_32_1 = var_0.Find(var_32_0, "charaMessageCard/charaBg")
								local var_32_2 = var_0.GetComponent

								typeof = var_2
								Animation = var_3_10003

								local var_32_3 = var_32_2(var_32_1, var_2(var_3_10003))

								var_0.Play(var_32_3, "anim_newinstagram_charabg")

								SetActive = var_0

								local var_32_4 = arg_20_2

								var_0(var_1.Find(var_32_4, "charaMessageCard/waiting"), true)

								SetActive = var_0

								local var_32_5 = arg_20_2

								var_0(var_1.Find(var_32_5, "charaMessageCard/emoji"), false)

								Canvas = var_0

								var_0.ForceUpdateCanvases()

								LeanTween = var_0

								local var_32_6 = var_0.value

								go = var_1

								local var_32_7 = arg_17_0.rightPanel
								local var_32_8 = var_32_6(var_1(var_2.Find(var_32_7, "chat/messageScroll")), var_17_10.normalizedPosition.y, 0, 0.5)
								local var_32_9 = var_0.setOnUpdate

								System = var_2

								local var_32_10 = var_32_9(var_32_8, var_2.Action_float(var_17_11))
								local var_32_11 = var_0.setEase

								LeanTweenType = var_2

								var_32_11(var_32_10, var_2.easeInOutCubic)

								local var_32_12 = arg_17_0

								var_0.StartTimer(var_32_12, function()
									SetActive = var_4_10000

									local var_33_0 = arg_20_2

									var_4_10000(var_1.Find(var_33_0, "charaMessageCard/waiting"), false)

									SetActive = var_4_10000

									local var_33_1 = arg_20_2

									var_4_10000(var_1.Find(var_33_1, "charaMessageCard/emoji"), true)

									local var_33_2 = arg_20_2
									local var_33_3 = var_0.Find(var_33_2, "charaMessageCard/emoji")
									local var_33_4 = var_0.GetComponent

									typeof = var_2
									Animation = var_3

									local var_33_5 = var_33_4(var_33_3, var_2(var_3))

									var_0.Play(var_33_5, "anim_newinstagram_emoji_in")

									local var_33_6, var_33_7, var_33_8

									if arg_20_1 + 1 ~= #arg_17_2 then
										var_33_6 = var_0_4
										tonumber = var_33_8
										var_33_6 = var_33_6[var_33_8(var_0.param)].desc
										string = var_33_8
										var_33_6 = var_33_8.gsub(var_33_6, "#%w+>", "#28af6e>")
										var_33_7 = arg_17_0

										var_33_8.ChangeCharaTextFunc(var_33_7, arg_17_4, var_33_6)
									else
										var_33_8 = arg_17_0
										var_33_6 = var_33_6.emit
										InstagramChatMediator = var_33_7

										var_33_6(var_33_8, var_33_7.SET_READED, {
											arg_17_1.topicId
										})
									end

									Canvas = var_33_6

									var_33_6.ForceUpdateCanvases()

									LeanTween = var_0

									local var_33_9 = var_0.value

									go = var_33_8

									local var_33_10 = arg_17_0.rightPanel
									local var_33_11 = var_33_9(var_33_8(var_2.Find(var_33_10, "chat/messageScroll")), var_17_10.normalizedPosition.y, 0, 0.5)
									local var_33_12 = var_0.setOnUpdate

									System = var_2

									local var_33_13 = var_33_12(var_33_11, var_2.Action_float(var_17_11))
									local var_33_14 = var_0.setEase

									LeanTweenType = var_2

									var_33_14(var_33_13, var_2.easeInOutCubic)

									local var_33_15 = arg_17_0
									local var_33_16 = var_0.SetEndAniEvent
									local var_33_17 = arg_20_2

									var_33_16(var_33_15, var_2.Find(var_33_17, "charaMessageCard/emoji"), function()
										if arg_17_0.shouldShowOption and arg_20_1 + 1 == #arg_17_2 then
											local var_34_0 = arg_17_0

											var_0.SetOptionPanelActive(var_34_0, true)
										end

										return
									end)

									return
								end, var_0)

								return
							end, var_20_3)
						end
					end
				elseif var_3.type == 5 then
					var_2_10010 = arg_17_0

					var_9.SetCharaMessageCardActive(var_2_10010, var_20_0, {
						6
					})

					local var_20_16 = var_3.param

					string = var_2_10010

					for iter_20_0 in var_2_10010.gmatch(var_3.param, "'%d+'") do
						string = var_2_10014
						var_2_10014 = var_2_10014.sub(iter_20_0, 2, #iter_20_0 - 1)
						string = var_15

						local var_20_17 = var_15.gsub
						local var_20_18 = var_20_16
						local var_20_19 = iter_20_0

						var_2_10018 = "<color=#93e9ff>"

						local var_20_20 = var_0_2

						tonumber = var_2_10020
						var_20_16 = var_20_17(var_20_18, var_20_19, var_2_10018 .. var_20_20[var_2_10020(var_2_10014)].name .. "</color>")
					end

					setText = var_2_10010
					var_2_10012 = arg_20_2

					var_2_10010(arg_20_2.Find(var_2_10012, "charaMessageCard/systemTip/panel/Text"), var_20_16)

					if arg_17_3 and var_17_0 then
						var_2_10010 = arg_20_1 + 1

						if var_17_0 < var_2_10010 then
							SetActive = var_2_10010

							var_2_10010(arg_20_2, false)

							iter_20_2 = arg_17_0

							var_2_10010.StartTimer(iter_20_2, function()
								SetActive = var_3_10000

								var_3_10000(arg_20_2, true)

								local var_35_0 = arg_20_2
								local var_35_1 = var_0.Find(var_35_0, "charaMessageCard/systemTip")
								local var_35_2 = var_0.GetComponent

								typeof = var_2
								Animation = var_3_10003

								local var_35_3 = var_35_2(var_35_1, var_2(var_3_10003))

								var_0.Play(var_35_3, "anim_newinstagram_tip_in")

								local var_35_4, var_35_5

								if arg_20_1 + 1 ~= #arg_17_2 then
									var_35_4 = arg_17_0

									var_35_5.ChangeCharaTextFunc(var_35_4, arg_17_4, var_20_16)
								else
									var_35_4 = arg_17_0
									var_35_5 = var_35_5.emit
									InstagramChatMediator = var_2

									var_35_5(var_35_4, var_2.SET_READED, {
										arg_17_1.topicId
									})
								end

								Canvas = var_35_5

								var_35_5.ForceUpdateCanvases()

								LeanTween = var_0

								local var_35_6 = var_0.value

								go = var_35_4

								local var_35_7 = arg_17_0.rightPanel
								local var_35_8 = var_35_6(var_35_4(var_2.Find(var_35_7, "chat/messageScroll")), var_17_10.normalizedPosition.y, 0, 0.5)
								local var_35_9 = var_0.setOnUpdate

								System = var_2

								local var_35_10 = var_35_9(var_35_8, var_2.Action_float(var_17_11))
								local var_35_11 = var_0.setEase

								LeanTweenType = var_2

								var_35_11(var_35_10, var_2.easeInOutCubic)

								local var_35_12 = arg_17_0
								local var_35_13 = var_0.SetEndAniEvent
								local var_35_14 = arg_20_2

								var_35_13(var_35_12, var_2.Find(var_35_14, "charaMessageCard/systemTip"), function()
									if arg_17_0.shouldShowOption and arg_20_1 + 1 == #arg_17_2 then
										local var_36_0 = arg_17_0

										var_0.SetOptionPanelActive(var_36_0, true)
									end

									return
								end)

								return
							end, var_20_3)
						end
					end
				end
			else
				if var_3.type == 1 then
					local var_20_21 = arg_17_0

					var_7.SetPlayerMessageCardActive(var_20_21, var_20_2, {
						0
					})

					setText = var_7

					var_7(arg_20_2:Find("playerReplyCard/msgBox/msg"), var_3.param)
				elseif var_3.type == 4 then
					local var_20_22 = arg_17_0

					var_7.SetPlayerMessageCardActive(var_20_22, var_20_2, {
						1
					})

					local var_20_23 = arg_17_0
					local var_20_24 = var_7.ClearEmoji

					var_2_10010 = arg_20_2

					var_20_24(var_20_23, arg_20_2.Find(var_2_10010, "playerReplyCard/emoji/emoticon"))

					local var_20_25 = arg_17_0
					local var_20_26 = var_7.SetEmoji

					var_2_10010 = arg_20_2

					local var_20_27 = arg_20_2.Find(var_2_10010, "playerReplyCard/emoji/emoticon")

					var_2_10010 = var_0_4
					tonumber = iter_20_2

					var_20_26(var_20_25, var_20_27, var_2_10010[iter_20_2(var_3.param)].pic)
				elseif var_3.type == 5 then
					local var_20_28 = arg_17_0

					var_7.SetPlayerMessageCardActive(var_20_28, var_20_2, {
						2
					})

					local var_20_29 = var_3.param

					string = var_20_28

					for iter_20_2 in var_20_28.gmatch(var_3.param, "'%d+'") do
						string = var_2_10012
						var_2_10012 = var_2_10012.sub(iter_20_2, 2, #iter_20_2 - 1)
						string = var_13

						local var_20_30 = var_13.gsub
						local var_20_31 = var_20_29
						local var_20_32 = iter_20_2
						local var_20_33 = "<color=#93e9ff>"
						local var_20_34 = var_0_2

						tonumber = var_2_10018
						var_20_29 = var_20_30(var_20_31, var_20_32, var_20_33 .. var_20_34[var_2_10018(var_2_10012)].name .. "</color>")
					end

					setText = var_8
					var_2_10010 = arg_20_2

					var_8(arg_20_2.Find(var_2_10010, "playerReplyCard/systemTip/panel/Text"), var_20_29)
				end

				if arg_17_3 and var_17_0 then
					_ = var_7

					if var_7.contains(var_17_3, arg_20_1 + 1) then
						table = var_7

						local var_20_37

						if var_7.indexof(var_17_3, arg_20_1 + 1) < #var_17_3 then
							SetActive = var_7

							var_7(arg_20_2, false)

							local var_20_35 = arg_17_0
							local var_20_36 = var_7.StartTimer

							function var_20_37()
								SetActive = var_3_10000

								var_3_10000(arg_20_2, true)

								local var_37_12

								if var_0.type == 1 then
									local var_37_0 = arg_20_2
									local var_37_1 = var_0.Find(var_37_0, "playerReplyCard/msgBox")
									local var_37_2 = var_0.GetComponent

									typeof = var_37_12
									Animation = var_3_10003

									local var_37_3 = var_37_2(var_37_1, var_37_12(var_3_10003))

									var_0.Play(var_37_3, "anim_newinstagram_playerchat_common_in")

									local var_37_4 = arg_17_0

									var_0.ChangeCharaTextFunc(var_37_4, arg_17_4, var_0.param)
								elseif var_0.type == 4 then
									local var_37_5 = arg_20_2
									local var_37_6 = var_0.Find(var_37_5, "playerReplyCard/emoji")
									local var_37_7 = var_0.GetComponent

									typeof = var_37_12
									Animation = var_3_10003

									local var_37_8 = var_37_7(var_37_6, var_37_12(var_3_10003))

									var_0.Play(var_37_8, "anim_newinstagram_emoji_in")

									local var_37_9 = var_0_4

									tonumber = var_37_8

									local var_37_10 = var_37_9[var_37_8(var_0.param)].desc

									string = var_1

									local var_37_11 = var_1.gsub(var_37_10, "#%w+>", "#28af6e>")

									var_37_12 = arg_17_0

									var_1.ChangeCharaTextFunc(var_37_12, arg_17_4, var_37_11)
								elseif var_0.type == 5 then
									local var_37_13 = arg_20_2
									local var_37_14 = var_0.Find(var_37_13, "playerReplyCard/systemTip")
									local var_37_15 = var_0.GetComponent

									typeof = var_37_12
									Animation = var_3_10003

									local var_37_16 = var_37_15(var_37_14, var_37_12(var_3_10003))

									var_0.Play(var_37_16, "anim_newinstagram_tip_in")

									local var_37_17 = var_0.param

									string = var_37_16

									for iter_37_0 in var_37_16.gmatch(var_0.param, "'%d+'") do
										string = var_3_10005
										var_3_10005 = var_3_10005.sub(iter_37_0, 2, #iter_37_0 - 1)
										string = var_6

										local var_37_18 = var_6.gsub
										local var_37_19 = var_37_17
										local var_37_20 = iter_37_0
										local var_37_21 = "<color=#93e9ff>"
										local var_37_22 = var_0_2

										tonumber = var_3_10011
										var_37_17 = var_37_18(var_37_19, var_37_20, var_37_21 .. var_37_22[var_3_10011(var_3_10005)].name .. "</color>")
									end

									var_37_12 = arg_17_0

									var_1.ChangeCharaTextFunc(var_37_12, arg_17_4, var_37_17)
								end

								local var_37_23, var_37_24

								if arg_20_1 + 1 == #arg_17_2 then
									var_37_23 = arg_17_0
									var_37_24 = var_37_24.emit
									InstagramChatMediator = var_37_12

									var_37_24(var_37_23, var_37_12.SET_READED, {
										arg_17_1.topicId
									})
								end

								Canvas = var_37_24

								var_37_24.ForceUpdateCanvases()

								LeanTween = var_0

								local var_37_25 = var_0.value

								go = var_37_23

								local var_37_26 = arg_17_0.rightPanel
								local var_37_27 = var_37_25(var_37_23(var_2.Find(var_37_26, "chat/messageScroll")), var_17_10.normalizedPosition.y, 0, 0.5)
								local var_37_28 = var_0.setOnUpdate

								System = var_2

								local var_37_29 = var_37_28(var_37_27, var_2.Action_float(var_17_11))
								local var_37_30 = var_0.setEase

								LeanTweenType = var_2

								var_37_30(var_37_29, var_2.easeInOutCubic)

								return
							end

							var_2_10010 = #var_17_3
							table = iter_20_2

							var_20_36(var_20_35, var_20_37, (var_2_10010 - iter_20_2.indexof(var_17_3, arg_20_1 + 1)) * var_17_13)
						else
							if var_3.type == 1 then
								local var_20_38 = arg_20_2:Find("playerReplyCard/msgBox")
								local var_20_39 = var_7.GetComponent

								typeof = var_20_37
								Animation = var_2_10010

								local var_20_40 = var_20_39(var_20_38, var_20_37(var_2_10010))

								var_7.Play(var_20_40, "anim_newinstagram_playerchat_common_in")

								local var_20_41 = arg_17_0

								var_7.ChangeCharaTextFunc(var_20_41, arg_17_4, var_3.param)
							elseif var_3.type == 4 then
								local var_20_42 = arg_20_2:Find("playerReplyCard/emoji")
								local var_20_43 = var_7.GetComponent

								typeof = var_20_37
								Animation = var_2_10010

								local var_20_44 = var_20_43(var_20_42, var_20_37(var_2_10010))

								var_7.Play(var_20_44, "anim_newinstagram_emoji_in")

								local var_20_45 = var_0_4

								tonumber = var_20_44

								local var_20_46 = var_20_45[var_20_44(var_3.param)].desc

								string = var_8

								local var_20_47 = var_8.gsub(var_20_46, "#%w+>", "#28af6e>")

								var_20_37 = arg_17_0

								var_8.ChangeCharaTextFunc(var_20_37, arg_17_4, var_20_47)
							elseif var_3.type == 5 then
								local var_20_48 = arg_20_2:Find("playerReplyCard/systemTip")
								local var_20_49 = var_7.GetComponent

								typeof = var_20_37
								Animation = var_2_10010

								local var_20_50 = var_20_49(var_20_48, var_20_37(var_2_10010))

								var_7.Play(var_20_50, "anim_newinstagram_tip_in")

								local var_20_51 = var_3.param

								string = var_20_50

								for iter_20_2 in var_20_50.gmatch(var_3.param, "'%d+'") do
									string = var_2_10012
									var_2_10012 = var_2_10012.sub(iter_20_2, 2, #iter_20_2 - 1)
									string = var_13

									local var_20_52 = var_13.gsub
									local var_20_53 = var_20_51
									local var_20_54 = iter_20_2
									local var_20_55 = "<color=#93e9ff>"
									local var_20_56 = var_0_2

									tonumber = var_2_10018
									var_20_51 = var_20_52(var_20_53, var_20_54, var_20_55 .. var_20_56[var_2_10018(var_2_10012)].name .. "</color>")
								end

								var_20_37 = arg_17_0

								var_8.ChangeCharaTextFunc(var_20_37, arg_17_4, var_20_51)
							end

							if arg_20_1 + 1 == #arg_17_2 then
								local var_20_57 = arg_17_0
								local var_20_58 = var_7.emit

								InstagramChatMediator = var_20_37

								var_20_58(var_20_57, var_20_37.SET_READED, {
									arg_17_1.topicId
								})
							end
						end
					end
				end
			end

			local var_20_59 = arg_17_1
			local var_20_62

			if not var_7.isWaiting(var_20_59) and arg_20_1 + 1 == #arg_17_2 then
				if arg_17_3 then
					if var_3.ship_group ~= 0 then
						local var_20_60 = arg_17_0

						var_20_62.StartTimer(var_20_60, function()
							setActive = var_3_10000

							local var_38_0 = arg_20_2

							var_3_10000(var_1.Find(var_38_0, "end"), true)

							return
						end, var_20_3 + var_17_12)
					else
						local var_20_61 = arg_17_0

						var_20_62 = var_20_62.StartTimer

						local function var_20_63()
							setActive = var_3_10000

							local var_39_0 = arg_20_2

							var_3_10000(var_1.Find(var_39_0, "end"), true)

							return
						end

						local var_20_64 = #var_17_3

						table = iter_20_2

						var_20_62(var_20_61, var_20_63, (var_20_64 - iter_20_2.indexof(var_17_3, arg_20_1 + 1)) * var_17_13 + var_17_13)
					end
				else
					setActive = var_20_62

					var_20_62(arg_20_2:Find("end"), true)
				end
			else
				setActive = var_20_62

				var_20_62(arg_20_2:Find("end"), false)
			end
		end

		return
	end)

	local var_17_15 = arg_17_0.messageList

	var_13.align(var_17_15, #arg_17_2)

	local var_17_16

	if arg_17_3 then
		Canvas = var_17_16

		var_17_16.ForceUpdateCanvases()

		LeanTween = var_17_16
		var_17_16 = var_17_16.value
		go = var_17_15

		local var_17_17 = arg_17_0.rightPanel
		local var_17_18 = var_17_16(var_17_15(var_15.Find(var_17_17, "chat/messageScroll")), var_17_10.normalizedPosition.y, 0, 0.5)

		var_17_16 = var_17_16.setOnUpdate
		System = var_15

		local var_17_19 = var_17_16(var_17_18, var_15.Action_float(var_17_11))

		var_17_16 = var_17_16.setEase
		LeanTweenType = var_15

		var_17_16(var_17_19, var_15.easeInOutCubic)
	else
		scrollToBottom = var_17_16

		local var_17_20 = arg_17_0.rightPanel

		var_17_16(var_14.Find(var_17_20, "chat/messageScroll"))
	end

	return
end

function var_0_1.SetCharaMessageCardActive(arg_40_0, arg_40_1, arg_40_2)
	_ = var_1_10003

	if var_1_10003.contains(arg_40_2, 6) then
		SetActive = var_3

		var_3(arg_40_1:GetChild(0), false)
	else
		SetActive = var_3

		var_3(arg_40_1:GetChild(0), true)
	end

	for iter_40_0 = 1, arg_40_1.childCount - 1 do
		_ = var_1_10007

		if var_1_10007.contains(arg_40_2, iter_40_0) then
			SetActive = var_1_10007

			var_1_10007(arg_40_1:GetChild(iter_40_0), true)
		else
			SetActive = var_1_10007

			var_1_10007(arg_40_1:GetChild(iter_40_0), false)
		end
	end

	return
end

function var_0_1.SetPlayerMessageCardActive(arg_41_0, arg_41_1, arg_41_2)
	for iter_41_0 = 0, arg_41_1.childCount - 1 do
		_ = var_1_10007

		if var_1_10007.contains(arg_41_2, iter_41_0) then
			SetActive = var_1_10007

			var_1_10007(arg_41_1:GetChild(iter_41_0), true)
		else
			SetActive = var_1_10007

			var_1_10007(arg_41_1:GetChild(iter_41_0), false)
		end
	end

	return
end

function var_0_1.SetEmoji(arg_42_0, arg_42_1, arg_42_2)
	PoolMgr = var_1_10003

	local var_42_0 = var_1_10003.GetInstance()

	var_3.GetPrefab(var_42_0, "emoji/" .. arg_42_2, arg_42_2, true, function(arg_43_0)
		IsNil = var_2_10001

		local var_43_0

		if not var_2_10001(arg_42_1) then
			arg_43_0.name = arg_42_2
			tf = var_43_0
			var_43_0 = var_43_0(arg_43_0)
			var_43_0.sizeDelta = arg_42_1.sizeDelta
			tf = var_43_0
			var_43_0 = var_43_0(arg_43_0)
			Vector2 = var_2
			var_43_0.anchoredPosition = var_2.zero

			local var_43_1 = arg_43_0

			if arg_43_0.GetComponent(var_43_1, "Animator") then
				var_43_0.enabled = true
			end

			setParent = var_43_1

			var_43_1(arg_43_0, arg_42_1, false)
		else
			PoolMgr = var_43_0

			local var_43_2 = var_43_0.GetInstance()

			var_1.ReturnPrefab(var_43_2, "emoji/" .. arg_42_2, arg_42_2, arg_43_0)
		end

		return
	end)

	return
end

function var_0_1.ClearEmoji(arg_44_0, arg_44_1)
	eachChild = var_1_10002

	var_1_10002(arg_44_1, function(arg_45_0)
		go = var_2_10001

		local var_45_0 = var_2_10001(arg_45_0)

		PoolMgr = var_2

		local var_45_1 = var_2.GetInstance()

		var_2.ReturnPrefab(var_45_1, "emoji/" .. var_45_0.name, var_45_0.name, var_45_0)

		return
	end)

	return
end

function var_0_1.UpdateOptionPanel(arg_46_0, arg_46_1, arg_46_2)
	if arg_46_2[#arg_46_2].option then
		type = var_1_10004

		if var_1_10004(var_3) == "table" then
			arg_46_0.shouldShowOption = true
			arg_46_0.optionCount = #var_3

			arg_46_0:SetOptionPanelActive(true)

			local var_46_0 = arg_46_0.optionList

			var_4.make(var_46_0, function(arg_47_0, arg_47_1, arg_47_2)
				UIItemList = var_2_10003

				if arg_47_0 == var_2_10003.EventUpdate then
					local var_47_0 = var_0[arg_47_1 + 1]

					setText = var_4

					local var_47_1 = arg_47_2
					local var_47_2 = arg_47_2.Find(var_47_1, "Text")

					HXSet = var_47_1

					var_4(var_47_2, var_47_1.hxLan(var_47_0[2]))

					onButton = var_4

					local var_47_3 = arg_46_0
					local var_47_4 = arg_47_2

					local function var_47_5()
						local var_48_0 = arg_46_0
						local var_48_1 = var_0.emit

						InstagramChatMediator = var_3_10002

						var_48_1(var_48_0, var_3_10002.REPLY, arg_46_1.topicId, arg_46_2[#arg_46_2].id, var_47_0[1])

						return
					end

					SFX_PANEL = var_2_10008

					var_4(var_47_3, var_47_4, var_47_5, var_2_10008)
				end

				return
			end)

			local var_46_1 = arg_46_0.optionList

			var_4.align(var_46_1, #var_3)

			goto label_46_0
		end
	end

	arg_46_0:SetOptionPanelActive(false)

	arg_46_0.shouldShowOption = false

	::label_46_0::

	return
end

function var_0_1.SetOptionPanelActive(arg_49_0, arg_49_1)
	SetActive = var_1_10002

	var_1_10002(arg_49_0.optionPanel, arg_49_1)

	local var_49_0 = arg_49_0.rightPanel
	local var_49_1 = var_2.Find(var_49_0, "chat/messageScroll/Viewport/Content")
	local var_49_2 = var_2.GetComponent

	typeof = var_4
	VerticalLayoutGroup = var_1_10005

	local var_49_3 = var_49_2(var_49_1, var_4(var_1_10005))

	UnityEngine = var_49_1

	local var_49_4 = var_49_1.RectOffset.New()

	var_49_4.left = 0
	var_49_4.right = 0
	var_49_4.top = 0

	local var_49_5 = arg_49_0.rightPanel
	local var_49_6 = var_4.Find(var_49_5, "chat/messageScroll/Scrollbar Vertical")
	local var_49_7 = var_4.GetComponent

	typeof = var_6
	RectTransform = var_1_10007

	local var_49_8 = var_49_7(var_49_6, var_6(var_1_10007))

	if arg_49_1 then
		var_49_4.bottom = 42 + 88 * arg_49_0.optionCount
		Vector2 = var_49_6
		var_49_8.sizeDelta = var_49_6(arg_49_0.messageScrollWidth, -var_49_4.bottom)
	else
		var_49_4.bottom = 50
		Vector2 = var_49_6
		var_49_8.sizeDelta = var_49_6(arg_49_0.messageScrollWidth, 0)
	end

	var_49_3.padding = var_49_4
	scrollToBottom = var_49_6

	local var_49_9 = arg_49_0.rightPanel

	var_49_6(var_6.Find(var_49_9, "chat/messageScroll"))

	return
end

function var_0_1.SetFilterPanel(arg_50_0)
	local var_50_0

	if not arg_50_0.readFilter then
		var_50_0 = var_0_1.ReadType[1]
	end

	arg_50_0.readFilter = var_50_0

	local var_50_1

	if not arg_50_0.typeFilter then
		var_50_1 = var_0_1.TypeType[1]
	end

	arg_50_0.typeFilter = var_50_1

	local var_50_2

	if not arg_50_0.campFilter then
		var_50_2 = {
			var_0_1.CampIds[1]
		}
	end

	arg_50_0.campFilter = var_50_2

	local var_50_3 = arg_50_0.filterUI
	local var_50_4 = var_1.Find(var_50_3, "panel/filterScroll/Viewport/Content/read")
	local var_50_5 = arg_50_0.filterUI
	local var_50_6 = var_2.Find(var_50_5, "panel/filterScroll/Viewport/Content/type")
	local var_50_7 = arg_50_0.filterUI
	local var_50_8 = var_3.Find(var_50_7, "panel/filterScroll/Viewport/Content/camp")

	UIItemList = var_50_7

	local var_50_9 = var_50_7.New(var_50_8, var_50_8:Find("option"))

	onButton = var_5

	local var_50_10 = arg_50_0
	local var_50_11 = arg_50_0.filterBtn

	local function var_50_12()
		SetActive = var_2_10000

		var_2_10000(arg_50_0.filterUI, true)

		pg = var_2_10000

		local var_51_0 = var_2_10000.UIMgr.GetInstance()

		var_0.BlurPanel(var_51_0, arg_50_0.filterUI)

		ipairs = var_0

		for iter_51_0, iter_51_1 in var_0(var_0_1.ReadType) do
			local var_51_1 = var_50_4
			local var_51_2 = var_5.GetChild(var_51_1, iter_51_0)
			local var_51_3 = var_5.Find(var_51_2, "selectedFrame")

			SetActive = var_51_2

			var_51_2(var_51_3, arg_50_0.readFilter == iter_51_1)

			onButton = var_51_2

			local var_51_4 = arg_50_0
			local var_51_5 = var_5

			local function var_51_6()
				ipairs = var_3_10000

				for iter_52_0, iter_52_1 in var_3_10000(var_0_1.ReadType) do
					SetActive = var_3_10005

					local var_52_0 = var_50_4
					local var_52_1 = var_6.GetChild(var_52_0, iter_52_0)

					var_3_10005(var_6.Find(var_52_1, "selectedFrame"), false)
				end

				SetActive = var_0

				var_0(var_51_3, true)

				return
			end

			SFX_PANEL = var_2_10011

			var_51_2(var_51_4, var_51_5, var_51_6, var_2_10011)
		end

		ipairs = var_0

		for iter_51_2, iter_51_3 in var_0(var_0_1.TypeType) do
			local var_51_7 = var_50_6
			local var_51_8 = var_5.GetChild(var_51_7, iter_51_2)
			local var_51_9 = var_5.Find(var_51_8, "selectedFrame")

			SetActive = var_51_8

			var_51_8(var_51_9, arg_50_0.typeFilter == iter_51_3)

			onButton = var_51_8

			local var_51_10 = arg_50_0
			local var_51_11 = var_5

			local function var_51_12()
				ipairs = var_3_10000

				for iter_53_0, iter_53_1 in var_3_10000(var_0_1.TypeType) do
					SetActive = var_3_10005

					local var_53_0 = var_50_6
					local var_53_1 = var_6.GetChild(var_53_0, iter_53_0)

					var_3_10005(var_6.Find(var_53_1, "selectedFrame"), false)
				end

				SetActive = var_0

				var_0(var_51_9, true)

				return
			end

			SFX_PANEL = var_2_10011

			var_51_8(var_51_10, var_51_11, var_51_12, var_2_10011)
		end

		local var_51_13 = var_50_9

		var_0.make(var_51_13, function(arg_54_0, arg_54_1, arg_54_2)
			UIItemList = var_3_10003

			if arg_54_0 == var_3_10003.EventUpdate then
				setText = var_3

				local var_54_0 = arg_54_2
				local var_54_1 = arg_54_2.Find(var_54_0, "Text")

				i18n = var_54_0

				var_3(var_54_1, var_54_0(var_0_1.CampNames[arg_54_1 + 1]))

				local var_54_2 = arg_54_2
				local var_54_3 = arg_54_2.Find(var_54_2, "selectedFrame")

				SetActive = var_54_2

				local var_54_4 = var_54_3

				_ = var_6

				var_54_2(var_54_4, var_6.contains(arg_50_0.campFilter, var_0_1.CampIds[arg_54_1 + 1]))

				onButton = var_54_2

				local var_54_5 = arg_50_0
				local var_54_6 = arg_54_2

				local function var_54_7()
					if arg_54_1 == 0 then
						SetActive = var_0

						var_0(var_54_3, true)

						for iter_55_0 = 2, #var_0_1.CampIds do
							SetActive = var_4_10004
							var_4_10006 = var_50_8
							var_4_10006 = var_5.GetChild(var_4_10006, iter_55_0 - 1)

							var_4_10004(var_5.Find(var_4_10006, "selectedFrame"), false)
						end
					else
						SetActive = var_0

						local var_55_0 = var_54_3

						isActive = var_4_10002

						var_0(var_55_0, not var_4_10002(var_54_3))

						local var_55_1 = true
						local var_55_2 = true

						for iter_55_1 = 2, #var_0_1.CampIds do
							isActive = var_4_10006

							local var_55_3 = var_50_8
							local var_55_4 = var_7.GetChild(var_55_3, iter_55_1 - 1)

							if not var_4_10006(var_7.Find(var_55_4, "selectedFrame")) then
								var_55_1 = false
							end

							isActive = var_4_10006

							local var_55_5 = var_50_8
							local var_55_6 = var_7.GetChild(var_55_5, iter_55_1 - 1)

							if var_4_10006(var_7.Find(var_55_6, "selectedFrame")) then
								var_55_2 = false
							end
						end

						if var_55_1 then
							SetActive = var_2

							local var_55_7 = var_50_8
							local var_55_8 = var_3.GetChild(var_55_7, 0)

							var_2(var_3.Find(var_55_8, "selectedFrame"), true)

							for iter_55_2 = 2, #var_0_1.CampIds do
								SetActive = var_4_10006

								local var_55_9 = var_50_8
								local var_55_10 = var_7.GetChild(var_55_9, iter_55_2 - 1)

								var_4_10006(var_7.Find(var_55_10, "selectedFrame"), false)
							end
						elseif var_55_2 then
							SetActive = var_2

							local var_55_11 = var_50_8
							local var_55_12 = var_3.GetChild(var_55_11, 0)

							var_2(var_3.Find(var_55_12, "selectedFrame"), true)
						else
							SetActive = var_2

							local var_55_13 = var_50_8
							local var_55_14 = var_3.GetChild(var_55_13, 0)

							var_2(var_3.Find(var_55_14, "selectedFrame"), false)
						end
					end

					return
				end

				SFX_PANEL = var_8

				var_54_2(var_54_5, var_54_6, var_54_7, var_8)
			end

			return
		end)

		local var_51_14 = var_50_9

		var_0.align(var_51_14, #var_0_1.CampIds)

		return
	end

	SFX_PANEL = var_1_10009

	var_5(var_50_10, var_50_11, var_50_12, var_1_10009)

	onButton = var_5

	local var_50_13 = arg_50_0
	local var_50_14 = arg_50_0.filterUI
	local var_50_15 = var_7.Find(var_50_14, "bg")

	local function var_50_16()
		local var_56_0 = arg_50_0

		var_0.CloseFilterPanel(var_56_0)

		return
	end

	SFX_PANEL = var_9

	var_5(var_50_13, var_50_15, var_50_16, var_9)

	onButton = var_5

	local var_50_17 = arg_50_0
	local var_50_18 = arg_50_0.filterUI
	local var_50_19 = var_7.Find(var_50_18, "panel/bottom/close")

	local function var_50_20()
		local var_57_0 = arg_50_0

		var_0.CloseFilterPanel(var_57_0)

		return
	end

	SFX_PANEL = var_9

	var_5(var_50_17, var_50_19, var_50_20, var_9)

	onButton = var_5

	local var_50_21 = arg_50_0
	local var_50_22 = arg_50_0.filterUI
	local var_50_23 = var_7.Find(var_50_22, "panel/bottom/ok")

	local function var_50_24()
		ipairs = var_2_10000

		for iter_58_0, iter_58_1 in var_2_10000(var_0_1.ReadType) do
			local var_58_0 = var_50_4
			local var_58_1 = var_5.GetChild(var_58_0, iter_58_0)
			local var_58_2 = var_5.Find(var_58_1, "selectedFrame")

			isActive = var_58_1

			if var_58_1(var_58_2) then
				arg_50_0.readFilter = iter_58_1
			end
		end

		ipairs = var_0

		for iter_58_2, iter_58_3 in var_0(var_0_1.TypeType) do
			local var_58_3 = var_50_6
			local var_58_4 = var_5.GetChild(var_58_3, iter_58_2)
			local var_58_5 = var_5.Find(var_58_4, "selectedFrame")

			isActive = var_58_4

			if var_58_4(var_58_5) then
				arg_50_0.typeFilter = iter_58_3
			end
		end

		local var_58_6 = arg_50_0

		var_58_6.campFilter = {}
		ipairs = var_58_6

		for iter_58_4, iter_58_5 in var_58_6(var_0_1.CampIds) do
			local var_58_7 = var_50_8
			local var_58_8 = var_5.GetChild(var_58_7, iter_58_4 - 1)
			local var_58_9 = var_5.Find(var_58_8, "selectedFrame")

			isActive = var_58_8

			if var_58_8(var_58_9) then
				table = var_7

				var_7.insert(arg_50_0.campFilter, iter_58_5)
			end
		end

		local var_58_10 = arg_50_0

		var_0.CloseFilterPanel(var_58_10)

		local var_58_11 = arg_50_0

		var_0.SetFilterResult(var_58_11)

		return
	end

	SFX_PANEL = var_9

	var_5(var_50_21, var_50_23, var_50_24, var_9)

	return
end

function var_0_1.SetFilterResult(arg_59_0)
	local var_59_0 = true
	local var_59_1 = false

	if not arg_59_0.readFilter then
		arg_59_0.readFilter = var_0_1.ReadType[1]
		arg_59_0.typeFilter = var_0_1.TypeType[1]
		arg_59_0.campFilter = {
			var_0_1.CampIds[1]
		}
	end

	table = var_3
	arg_59_0.chatList = var_3.insertto({}, arg_59_0.allChatList)

	for iter_59_0 = #arg_59_0.chatList, 1, -1 do
		local var_59_2 = arg_59_0.chatList[iter_59_0]
		local var_59_3 = true

		if arg_59_0.readFilter ~= "all" then
			local var_59_4 = arg_59_0.readFilter == "hasReaded" and 1 or 0

			if var_59_2:GetCharacterEndFlag() ~= var_59_4 then
				var_59_3 = false
			end
		end

		local var_59_5

		if arg_59_0.typeFilter ~= "all" then
			var_59_5 = arg_59_0.typeFilter == "single" and 1 or 2

			if var_59_2.type ~= var_59_5 then
				var_59_3 = false
			end
		end

		_ = var_59_5

		if not var_59_5.contains(arg_59_0.campFilter, 0) then
			_ = var_9

			if not var_9.contains(arg_59_0.campFilter, var_59_2.nationality) then
				var_59_3 = false
			end
		end

		if not var_59_3 then
			table = var_9

			var_9.remove(arg_59_0.chatList, iter_59_0)
		end

		if var_59_3 then
			var_59_0 = false
		end

		if arg_59_0.currentChat and arg_59_0.currentChat.characterId == var_59_2.characterId and var_59_3 then
			var_59_1 = true
		end
	end

	local var_59_6

	if arg_59_0.readFilter == "all" and arg_59_0.typeFilter == "all" then
		_ = var_3
		var_59_6 = var_3.contains(arg_59_0.campFilter, 0)
	else
		var_59_6 = false
	end

	if false then
		var_59_6 = true
	end

	SetActive = var_4

	var_4(arg_59_0.isFiltered, not var_59_6)

	if var_59_6 then
		arg_59_0:InsertOfficialAccounts()
	end

	if var_59_0 then
		SetActive = var_4

		local var_59_7 = arg_59_0.leftPanel

		var_4(var_5.Find(var_59_7, "charaScroll"), false)

		SetActive = var_4

		local var_59_8 = arg_59_0._tf

		var_4(var_5.Find(var_59_8, "main/noFilteredMessageBg"), true)

		SetActive = var_4

		var_4(arg_59_0.rightPanel, false)

		SetActive = var_4

		local var_59_9 = arg_59_0._tf

		var_4(var_5.Find(var_59_9, "main/rightNoMessageBg"), false)
	else
		SetActive = var_4

		local var_59_10 = arg_59_0.leftPanel

		var_4(var_5.Find(var_59_10, "charaScroll"), true)

		local var_59_11 = arg_59_0.charaScrollrect

		var_4.SetTotalCount(var_59_11, #arg_59_0.chatList)

		SetActive = var_4

		local var_59_12 = arg_59_0._tf

		var_4(var_5.Find(var_59_12, "main/noFilteredMessageBg"), false)

		if var_59_1 then
			SetActive = var_4

			var_4(arg_59_0.rightPanel, true)

			SetActive = var_4

			local var_59_13 = arg_59_0._tf

			var_4(var_5.Find(var_59_13, "main/rightNoMessageBg"), false)
		else
			SetActive = var_4

			var_4(arg_59_0.rightPanel, false)

			SetActive = var_4

			local var_59_14 = arg_59_0._tf

			var_4(var_5.Find(var_59_14, "main/rightNoMessageBg"), true)

			arg_59_0.currentChat = nil

			if arg_59_0.cancelFrame then
				arg_59_0.cancelFrame()

				arg_59_0.cancelFrame = nil
			end
		end
	end

	return
end

function var_0_1.CloseFilterPanel(arg_60_0)
	pg = var_1_10001

	local var_60_0 = var_1_10001.UIMgr.GetInstance()
	local var_60_1 = var_1.UnOverlayPanel
	local var_60_2 = arg_60_0.filterUI
	local var_60_3 = arg_60_0._tf

	var_60_1(var_60_0, var_60_2, var_4.Find(var_60_3, "subPages"))

	SetActive = var_60_1

	var_60_1(arg_60_0.filterUI, false)

	return
end

function var_0_1.SetTopicPanel(arg_61_0, arg_61_1)
	SetActive = var_1_10002

	local var_61_0 = arg_61_0.topicBtn

	var_1_10002(var_3.Find(var_61_0, "tip"), arg_61_1:GetCharacterEndFlagExceptCurrent() == 0)

	onButton = var_1_10002

	local var_61_1 = arg_61_0
	local var_61_2 = arg_61_0.topicBtn

	local function var_61_3()
		SetActive = var_2_10000

		var_2_10000(arg_61_0.topicUI, true)

		pg = var_2_10000

		local var_62_0 = var_2_10000.UIMgr.GetInstance()

		var_0.BlurPanel(var_62_0, arg_61_0.topicUI)

		arg_61_0.currentTopic = nil

		local var_62_1 = arg_61_1

		var_0.SortTopicList(var_62_1)

		local var_62_2 = {}
		local var_62_3 = {}

		ipairs = var_2

		for iter_62_0, iter_62_1 in var_2(arg_61_1.topics) do
			if iter_62_1.active then
				if iter_62_1.isII then
					table = var_7

					var_7.insert(var_62_3, iter_62_1)
				else
					table = var_7

					var_7.insert(var_62_2, iter_62_1)
				end
			end
		end

		setActive = var_2

		local var_62_4 = arg_61_0.topicUI

		var_2(var_3.Find(var_62_4, "panel/topicScroll/Viewport/Content/self"), #var_62_2 > 0)

		setActive = var_2

		local var_62_5 = arg_61_0.topicUI

		var_2(var_3.Find(var_62_5, "panel/topicScroll/Viewport/Content/other"), #var_62_3 > 0)

		setActive = var_2

		local var_62_6 = arg_61_0.topicUI

		var_2(var_3.Find(var_62_6, "panel/topicScroll/Viewport/Content/line"), #var_62_2 > 0 and #var_62_3 > 0)

		if #var_62_2 > 0 then
			UIItemList = var_2

			local var_62_7 = var_2.New
			local var_62_8 = arg_61_0.topicUI
			local var_62_9 = var_3.Find(var_62_8, "panel/topicScroll/Viewport/Content/self")
			local var_62_10 = arg_61_0.topicUI
			local var_62_11 = var_62_7(var_62_9, var_4.Find(var_62_10, "panel/topicScroll/Viewport/Content/self/topic"))

			var_2.make(var_62_11, function(arg_63_0, arg_63_1, arg_63_2)
				UIItemList = var_3_10003

				if arg_63_0 == var_3_10003.EventUpdate then
					local var_63_0 = var_62_2[arg_63_1 + 1]
					local var_63_1 = arg_61_0

					var_4.SetTopic(var_63_1, arg_63_2, arg_61_1, var_63_0, var_62_2, var_62_3)
				end

				return
			end)
			var_2:align(#var_62_2)
		end

		if #var_62_3 > 0 then
			UIItemList = var_2

			local var_62_12 = var_2.New
			local var_62_13 = arg_61_0.topicUI
			local var_62_14 = var_3.Find(var_62_13, "panel/topicScroll/Viewport/Content/other")
			local var_62_15 = arg_61_0.topicUI
			local var_62_16 = var_62_12(var_62_14, var_4.Find(var_62_15, "panel/topicScroll/Viewport/Content/other/topic"))

			var_2.make(var_62_16, function(arg_64_0, arg_64_1, arg_64_2)
				UIItemList = var_3_10003

				if arg_64_0 == var_3_10003.EventUpdate then
					local var_64_0 = var_62_3[arg_64_1 + 1]
					local var_64_1 = arg_61_0

					var_4.SetTopic(var_64_1, arg_64_2, arg_61_1, var_64_0, var_62_2, var_62_3)
				end

				return
			end)
			var_2:align(#var_62_3)
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10002(var_61_1, var_61_2, var_61_3, var_1_10006)

	onButton = var_1_10002

	local var_61_4 = arg_61_0
	local var_61_5 = arg_61_0.topicUI
	local var_61_6 = var_4.Find(var_61_5, "bg")

	local function var_61_7()
		local var_65_0 = arg_61_0

		var_0.CloseTopicPanel(var_65_0)

		return
	end

	SFX_PANEL = var_6

	var_1_10002(var_61_4, var_61_6, var_61_7, var_6)

	onButton = var_1_10002

	local var_61_8 = arg_61_0
	local var_61_9 = arg_61_0.topicUI
	local var_61_10 = var_4.Find(var_61_9, "panel/bottom/close")

	local function var_61_11()
		local var_66_0 = arg_61_0

		var_0.CloseTopicPanel(var_66_0)

		return
	end

	SFX_PANEL = var_6

	var_1_10002(var_61_8, var_61_10, var_61_11, var_6)

	onButton = var_1_10002

	local var_61_12 = arg_61_0
	local var_61_13 = arg_61_0.topicUI
	local var_61_14 = var_4.Find(var_61_13, "panel/bottom/ok")

	local function var_61_15()
		local var_67_0 = arg_61_0
		local var_67_1 = var_0.emit

		InstagramChatMediator = var_2_10002

		var_67_1(var_67_0, var_2_10002.SET_CURRENT_TOPIC, arg_61_0.currentTopic.topicId)

		local var_67_2 = arg_61_0

		var_0.CloseTopicPanel(var_67_2)

		local var_67_3 = arg_61_0.rightPanel
		local var_67_4 = var_0.GetComponent

		typeof = var_2
		Animation = var_3

		local var_67_5 = var_67_4(var_67_3, var_2(var_3))

		var_0.Stop(var_67_5)
		var_0:Play("anim_newinstagram_chat_right_in")

		return
	end

	SFX_PANEL = var_6

	var_1_10002(var_61_12, var_61_14, var_61_15, var_6)

	return
end

function var_0_1.SetTopic(arg_68_0, arg_68_1, arg_68_2, arg_68_3, arg_68_4, arg_68_5)
	setScrollText = var_1_10006

	local var_68_0 = arg_68_1
	local var_68_1 = arg_68_1.Find(var_68_0, "mask/name")

	HXSet = var_68_0

	var_1_10006(var_68_1, var_68_0.hxLan(arg_68_3.name))

	SetActive = var_1_10006

	var_1_10006(arg_68_1:Find("lock"), not arg_68_3.active)

	SetActive = var_1_10006

	local var_68_2 = arg_68_1:Find("waiting")
	local var_68_3

	if arg_68_3.active then
		var_68_3 = arg_68_3:isWaiting()
	end

	var_1_10006(var_68_2, var_68_3)

	SetActive = var_1_10006

	local var_68_4 = arg_68_1:Find("complete")
	local var_68_5

	if arg_68_3.active then
		var_68_5 = arg_68_3:IsCompleted()
	end

	var_1_10006(var_68_4, var_68_5)

	SetActive = var_1_10006

	var_1_10006(arg_68_1:Find("selectedFrame"), arg_68_2.currentTopicId == arg_68_3.topicId)

	SetActive = var_1_10006

	var_1_10006(arg_68_1:Find("selected"), arg_68_2.currentTopicId == arg_68_3.topicId)

	SetActive = var_1_10006

	local var_68_6 = arg_68_1:Find("tip")
	local var_68_7

	if arg_68_3.active then
		var_68_7 = not arg_68_3:IsCompleted()
	end

	var_1_10006(var_68_6, var_68_7)

	if arg_68_2.currentTopicId == arg_68_3.topicId then
		arg_68_0.currentTopic = arg_68_3
	end

	SetActive = var_6

	var_6(arg_68_1, arg_68_3.active)

	if arg_68_3.active then
		onButton = var_6

		local var_68_8 = arg_68_0
		local var_68_9 = arg_68_1

		local function var_68_10()
			for iter_69_0 = 1, #arg_68_4 do
				SetActive = var_2_10004

				local var_69_0 = arg_68_0.topicUI
				local var_69_1 = var_5.Find(var_69_0, "panel/topicScroll/Viewport/Content/self")
				local var_69_2 = var_5.GetChild(var_69_1, iter_69_0 - 1)

				var_2_10004(var_5.Find(var_69_2, "selectedFrame"), false)
			end

			for iter_69_1 = 1, #arg_68_5 do
				SetActive = var_2_10004

				local var_69_3 = arg_68_0.topicUI
				local var_69_4 = var_5.Find(var_69_3, "panel/topicScroll/Viewport/Content/other")
				local var_69_5 = var_5.GetChild(var_69_4, iter_69_1 - 1)

				var_2_10004(var_5.Find(var_69_5, "selectedFrame"), false)
			end

			SetActive = var_0

			local var_69_6 = arg_68_1

			var_0(var_1.Find(var_69_6, "selectedFrame"), true)

			arg_68_0.currentTopic = arg_68_3

			return
		end

		SFX_PANEL = var_1_10010

		var_6(var_68_8, var_68_9, var_68_10, var_1_10010)
	else
		onButton = var_6

		local var_68_11 = arg_68_0
		local var_68_12 = arg_68_1

		local function var_68_13()
			pg = var_2_10000

			local var_70_0 = var_2_10000.TipsMgr.GetInstance()

			var_0.ShowTips(var_70_0, arg_68_3.unlockDesc)

			return
		end

		SFX_PANEL = var_1_10010

		var_6(var_68_11, var_68_12, var_68_13, var_1_10010)
	end

	return
end

function var_0_1.CloseTopicPanel(arg_71_0)
	pg = var_1_10001

	local var_71_0 = var_1_10001.UIMgr.GetInstance()
	local var_71_1 = var_1.UnOverlayPanel
	local var_71_2 = arg_71_0.topicUI
	local var_71_3 = arg_71_0._tf

	var_71_1(var_71_0, var_71_2, var_4.Find(var_71_3, "subPages"))

	SetActive = var_71_1

	var_71_1(arg_71_0.topicUI, false)

	return
end

function var_0_1.SetBackgroundPanel(arg_72_0, arg_72_1)
	if arg_72_1.type == 2 then
		SetActive = var_2

		var_2(arg_72_0.backgroundBtn, false)

		return
	end

	SetActive = var_2

	var_2(arg_72_0.backgroundBtn, true)

	onButton = var_2

	local var_72_0 = arg_72_0
	local var_72_1 = arg_72_0.backgroundBtn

	local function var_72_2()
		SetActive = var_2_10000

		var_2_10000(arg_72_0.backgroundUI, true)

		pg = var_2_10000

		local var_73_0 = var_2_10000.UIMgr.GetInstance()

		var_0.BlurPanel(var_73_0, arg_72_0.backgroundUI)

		arg_72_0.currentBgId = nil

		local var_73_1 = arg_72_1
		local var_73_2 = var_0.GetSkins(var_73_1)

		UIItemList = var_73_1

		local var_73_3 = var_73_1.New
		local var_73_4 = arg_72_0.backgroundUI
		local var_73_5 = var_2.Find(var_73_4, "panel/backgroundScroll/Viewport/Content")
		local var_73_6 = arg_72_0.backgroundUI
		local var_73_7 = var_73_3(var_73_5, var_3.Find(var_73_6, "panel/backgroundScroll/Viewport/Content/background"))

		var_1.make(var_73_7, function(arg_74_0, arg_74_1, arg_74_2)
			UIItemList = var_3_10003

			if arg_74_0 == var_3_10003.EventUpdate then
				local var_74_0 = var_73_2[arg_74_1 + 1].id
				local var_74_1 = var_3.painting

				LoadImageSpriteAsync = var_3_10006

				var_3_10006("herohrzicon/" .. var_74_1, arg_74_2:Find("skinMask/skin"), false)

				setScrollText = var_3_10006

				var_3_10006(arg_74_2:Find("skinMask/Panel/mask/Text"), var_3.name)

				getProxy = var_3_10006
				ShipSkinProxy = var_7

				local var_74_2 = var_3_10006(var_7)
				local var_74_3

				if not var_6.hasSkin(var_74_2, var_3.id) then
					var_74_3 = var_3.skin_type
					ShipSkin = var_74_2

					if var_74_3 ~= var_74_2.SKIN_TYPE_DEFAULT then
						var_74_3 = var_3.skin_type
						ShipSkin = var_74_2

						if var_74_3 ~= var_74_2.SKIN_TYPE_PROPOSE then
							var_74_3 = var_3.skin_type
							ShipSkin = var_74_2

							if var_74_3 ~= var_74_2.SKIN_TYPE_REMAKE then
								var_74_3 = false

								goto label_74_0
							end
						end
					end

					var_74_3 = true
				end

				::label_74_0::

				SetActive = var_74_2

				var_74_2(arg_74_2:Find("lockFrame"), not var_74_3)

				local var_74_4

				if arg_72_1.skinId ~= 0 then
					SetActive = var_74_4

					var_74_4(arg_74_2:Find("selectedFrame"), arg_72_1.skinId == var_74_0)

					SetActive = var_74_4

					var_74_4(arg_74_2:Find("selected"), arg_72_1.skinId == var_74_0)

					if arg_72_1.skinId == var_74_0 then
						var_74_4 = arg_72_0
						var_74_4.currentBgId = var_74_0
					end
				else
					local var_74_5 = arg_72_1

					var_74_4 = var_74_4.GetPaintingId(var_74_5)
					SetActive = var_74_5

					var_74_5(arg_74_2:Find("selectedFrame"), var_74_4 == var_74_0)

					SetActive = var_74_5

					var_74_5(arg_74_2:Find("selected"), var_74_4 == var_74_0)

					if var_74_4 == var_74_0 then
						arg_72_0.currentBgId = var_74_0
					end
				end

				onButton = var_74_4

				local var_74_6 = arg_72_0
				local var_74_7 = arg_74_2

				local function var_74_8()
					local var_75_3

					if var_74_3 then
						SetActive = var_75_3
						var_4_10002 = arg_74_2

						var_75_3(var_1.Find(var_4_10002, "selectedFrame"), true)

						for iter_75_0 = 1, #var_73_2 do
							if iter_75_0 ~= arg_74_1 + 1 then
								local var_75_0 = arg_72_0.backgroundUI
								local var_75_1 = var_4.Find(var_75_0, "panel/backgroundScroll/Viewport/Content")
								local var_75_2 = var_4.GetChild(var_75_1, iter_75_0 - 1)

								SetActive = var_75_1

								var_75_1(var_75_2:Find("selectedFrame"), false)
							end
						end

						var_75_3 = arg_72_0
						var_75_3.currentBgId = var_74_0
					else
						pg = var_75_3

						local var_75_4 = var_75_3.TipsMgr.GetInstance()
						local var_75_5 = var_0.ShowTips

						i18n = var_4_10002

						var_75_5(var_75_4, var_4_10002("juuschat_background_tip2"))
					end

					return
				end

				SFX_PANEL = var_3_10011

				var_74_4(var_74_6, var_74_7, var_74_8, var_3_10011)
			end

			return
		end)
		var_1:align(#var_73_2)

		return
	end

	SFX_PANEL = var_1_10006

	var_2(var_72_0, var_72_1, var_72_2, var_1_10006)

	onButton = var_2

	local var_72_3 = arg_72_0
	local var_72_4 = arg_72_0.backgroundUI
	local var_72_5 = var_4.Find(var_72_4, "bg")

	local function var_72_6()
		local var_76_0 = arg_72_0

		var_0.CloseBackgroundPanel(var_76_0)

		return
	end

	SFX_PANEL = var_6

	var_2(var_72_3, var_72_5, var_72_6, var_6)

	onButton = var_2

	local var_72_7 = arg_72_0
	local var_72_8 = arg_72_0.backgroundUI
	local var_72_9 = var_4.Find(var_72_8, "panel/bottom/close")

	local function var_72_10()
		local var_77_0 = arg_72_0

		var_0.CloseBackgroundPanel(var_77_0)

		return
	end

	SFX_PANEL = var_6

	var_2(var_72_7, var_72_9, var_72_10, var_6)

	onButton = var_2

	local var_72_11 = arg_72_0
	local var_72_12 = arg_72_0.backgroundUI
	local var_72_13 = var_4.Find(var_72_12, "panel/bottom/ok")

	local function var_72_14()
		local var_78_0 = arg_72_0
		local var_78_1 = var_0.emit

		InstagramChatMediator = var_2_10002

		var_78_1(var_78_0, var_2_10002.SET_CURRENT_BACKGROUND, arg_72_1.characterId, arg_72_0.currentBgId)

		local var_78_2 = arg_72_0

		var_0.CloseBackgroundPanel(var_78_2)

		return
	end

	SFX_PANEL = var_6

	var_2(var_72_11, var_72_13, var_72_14, var_6)

	return
end

function var_0_1.CloseBackgroundPanel(arg_79_0)
	pg = var_1_10001

	local var_79_0 = var_1_10001.UIMgr.GetInstance()
	local var_79_1 = var_1.UnOverlayPanel
	local var_79_2 = arg_79_0.backgroundUI
	local var_79_3 = arg_79_0._tf

	var_79_1(var_79_0, var_79_2, var_4.Find(var_79_3, "subPages"))

	SetActive = var_79_1

	var_79_1(arg_79_0.backgroundUI, false)

	return
end

function var_0_1.SetRedPacketPanel(arg_80_0, arg_80_1, arg_80_2, arg_80_3, arg_80_4, arg_80_5, arg_80_6)
	onButton = var_1_10007

	local var_80_0 = arg_80_0
	local var_80_1 = arg_80_1

	local function var_80_2()
		SetActive = var_2_10000

		var_2_10000(arg_80_0.redPacketUI, true)

		pg = var_2_10000

		local var_81_0 = var_2_10000.UIMgr.GetInstance()

		var_0.BlurPanel(var_81_0, arg_80_0.redPacketUI)

		setImageSprite = var_0

		local var_81_1 = arg_80_0.redPacketUI
		local var_81_2 = var_1.Find(var_81_1, "panel/charaBg/chara")

		LoadSprite = var_81_1

		var_0(var_81_2, var_81_1("qicon/" .. arg_80_4), false)

		if not arg_80_3 then
			SetActive = var_0

			local var_81_3 = arg_80_0.redPacketUI

			var_0(var_1.Find(var_81_3, "panel/panelBg"), true)

			SetActive = var_0

			local var_81_4 = arg_80_0.redPacketUI

			var_0(var_1.Find(var_81_4, "panel/openImg"), false)

			SetActive = var_0

			local var_81_5 = arg_80_0.redPacketUI

			var_0(var_1.Find(var_81_5, "panel/get"), true)

			SetActive = var_0

			local var_81_6 = arg_80_0.redPacketUI

			var_0(var_1.Find(var_81_6, "panel/got"), false)

			SetActive = var_0

			local var_81_7 = arg_80_0.redPacketUI

			var_0(var_1.Find(var_81_7, "panel/detail"), false)

			setText = var_0

			local var_81_8 = arg_80_0.redPacketUI

			var_0(var_1.Find(var_81_8, "panel/get/titleBg/title"), arg_80_2.desc)

			onButton = var_0

			local var_81_9 = arg_80_0
			local var_81_10 = arg_80_0.redPacketUI
			local var_81_11 = var_2.Find(var_81_10, "panel/get/getBtn")

			local function var_81_12()
				local var_82_0 = arg_80_0
				local var_82_1 = var_0.emit

				InstagramChatMediator = var_3_10002

				var_82_1(var_82_0, var_3_10002.GET_REDPACKET, arg_80_5, arg_80_6, arg_80_2.id)

				return
			end

			SFX_PANEL = var_4

			var_0(var_81_9, var_81_11, var_81_12, var_4)
		else
			local var_81_13 = arg_80_0

			var_0.UpdateRedPacketUI(var_81_13, arg_80_2.id)
		end

		return
	end

	SFX_PANEL = var_1_10011

	var_1_10007(var_80_0, var_80_1, var_80_2, var_1_10011)

	onButton = var_1_10007

	local var_80_3 = arg_80_0
	local var_80_4 = arg_80_0.redPacketUI
	local var_80_5 = var_9.Find(var_80_4, "bg")

	local function var_80_6()
		local var_83_0 = arg_80_0

		var_0.CloseRedPacketPanel(var_83_0)

		if arg_80_0.canFresh then
			arg_80_0.canFresh = false

			local var_83_1 = arg_80_0.currentChat.currentTopic

			if var_0[#var_0.GetDisplayWordList(var_83_1)].type == 0 then
				local var_83_2 = arg_80_0

				var_1.UpdateCharaList(var_83_2, false, false)
			else
				local var_83_3 = arg_80_0

				var_1.UpdateCharaList(var_83_3, true, false)
			end
		end

		return
	end

	SFX_PANEL = var_11

	var_1_10007(var_80_3, var_80_5, var_80_6, var_11)

	return
end

function var_0_1.UpdateRedPacketUI(arg_84_0, arg_84_1)
	local var_84_0 = var_0_3[arg_84_1]

	SetActive = var_1_10003

	local var_84_1 = arg_84_0.redPacketUI

	var_1_10003(var_4.Find(var_84_1, "panel/panelBg"), true)

	SetActive = var_1_10003

	local var_84_2 = arg_84_0.redPacketUI

	var_1_10003(var_4.Find(var_84_2, "panel/openImg"), false)

	SetActive = var_1_10003

	local var_84_3 = arg_84_0.redPacketUI

	var_1_10003(var_4.Find(var_84_3, "panel/get"), false)

	SetActive = var_1_10003

	local var_84_4 = arg_84_0.redPacketUI

	var_1_10003(var_4.Find(var_84_4, "panel/got"), true)

	SetActive = var_1_10003

	local var_84_5 = arg_84_0.redPacketUI

	var_1_10003(var_4.Find(var_84_5, "panel/detail"), false)

	Drop = var_1_10003

	local var_84_6 = var_1_10003.Create(var_84_0.content)

	var_84_6.count = 0
	updateDrop = var_4

	local var_84_7 = arg_84_0.redPacketUI

	var_4(var_5.Find(var_84_7, "panel/got/item"), var_84_6)

	onButton = var_4

	local var_84_8 = arg_84_0
	local var_84_9 = arg_84_0.redPacketUI
	local var_84_10 = var_6.Find(var_84_9, "panel/got/item")

	local function var_84_11()
		local var_85_0 = arg_84_0
		local var_85_1 = var_0.emit

		BaseUI = var_2_10002

		var_85_1(var_85_0, var_2_10002.ON_DROP, var_84_6)

		return
	end

	SFX_PANEL = var_8

	var_4(var_84_8, var_84_10, var_84_11, var_8)

	local var_84_12 = arg_84_0.redPacketUI
	local var_84_13 = var_4.Find(var_84_12, "panel/got/item/icon_bg")
	local var_84_14 = var_4.GetComponent

	typeof = var_6
	Image = var_84_11
	var_84_14(var_84_13, var_6(var_84_11)).enabled = false

	local var_84_15 = arg_84_0.redPacketUI
	local var_84_16 = var_4.Find(var_84_15, "panel/got/item/icon_bg/frame")
	local var_84_17 = var_4.GetComponent

	typeof = var_6
	Image = var_84_11

	local var_84_18 = var_84_17(var_84_16, var_6(var_84_11))

	var_84_18.enabled = false
	setText = var_84_18

	local var_84_19 = arg_84_0.redPacketUI

	var_84_18(var_5.Find(var_84_19, "panel/got/awardCount"), var_84_0.content[3])

	if var_84_0.type == 1 then
		SetActive = var_4

		local var_84_20 = arg_84_0.redPacketUI

		var_4(var_5.Find(var_84_20, "panel/got/detailBtn"), false)
	else
		SetActive = var_4

		local var_84_21 = arg_84_0.redPacketUI

		var_4(var_5.Find(var_84_21, "panel/got/detailBtn"), true)

		onButton = var_4

		local var_84_22 = arg_84_0
		local var_84_23 = arg_84_0.redPacketUI
		local var_84_24 = var_6.Find(var_84_23, "panel/got/detailBtn")

		local function var_84_25()
			SetActive = var_2_10000

			local var_86_0 = arg_84_0.redPacketUI

			var_2_10000(var_1.Find(var_86_0, "panel/panelBg"), false)

			SetActive = var_2_10000

			local var_86_1 = arg_84_0.redPacketUI

			var_2_10000(var_1.Find(var_86_1, "panel/openImg"), true)

			SetActive = var_2_10000

			local var_86_2 = arg_84_0.redPacketUI

			var_2_10000(var_1.Find(var_86_2, "panel/got"), false)

			SetActive = var_2_10000

			local var_86_3 = arg_84_0.redPacketUI

			var_2_10000(var_1.Find(var_86_3, "panel/detail"), true)

			local var_86_4 = 0
			local var_86_5 = 0

			UIItemList = var_2

			local var_86_6 = var_2.New
			local var_86_7 = arg_84_0.redPacketUI
			local var_86_8 = var_3.Find(var_86_7, "panel/detail/detailScroll/Viewport/Content")
			local var_86_9 = arg_84_0.redPacketUI
			local var_86_10 = var_86_6(var_86_8, var_4.Find(var_86_9, "panel/detail/detailScroll/Viewport/Content/charaGetCard"))

			var_2.make(var_86_10, function(arg_87_0, arg_87_1, arg_87_2)
				UIItemList = var_3_10003

				if arg_87_0 == var_3_10003.EventUpdate then
					local var_87_0 = var_84_0.group_receive[arg_87_1 + 1][1]
					local var_87_1 = {
						var_3[2],
						var_3[3],
						var_3[4]
					}
					local var_87_2

					if var_3[1] ~= 0 then
						var_87_2 = "unknown"

						if var_0_2[var_87_0] then
							var_87_2 = var_0_2[var_87_0].sculpture
						end

						setImageSprite = var_7

						local var_87_3 = arg_87_2
						local var_87_4 = arg_87_2.Find(var_87_3, "charaBg/chara")

						LoadSprite = var_87_3

						var_7(var_87_4, var_87_3("qicon/" .. var_87_2), false)
					else
						setImageSprite = var_87_2

						local var_87_5 = arg_87_2
						local var_87_6 = arg_87_2.Find(var_87_5, "charaBg/chara")

						GetSpriteFromAtlas = var_87_5

						var_87_2(var_87_6, var_87_5("ui/InstagramUI_atlas", "txdi_3"), false)
					end

					Drop = var_87_2

					local var_87_7 = var_87_2.Create(var_87_1)

					var_87_7.count = 0
					updateDrop = var_7

					var_7(arg_87_2:Find("item"), var_87_7)

					onButton = var_7

					local var_87_8 = arg_84_0
					local var_87_9 = arg_87_2:Find("item")

					local function var_87_10()
						local var_88_0 = arg_84_0
						local var_88_1 = var_0.emit

						BaseUI = var_4_10002

						var_88_1(var_88_0, var_4_10002.ON_DROP, var_87_7)

						return
					end

					SFX_PANEL = var_11

					var_7(var_87_8, var_87_9, var_87_10, var_11)

					local var_87_11 = arg_87_2:Find("item/icon_bg")
					local var_87_12 = var_7.GetComponent

					typeof = var_9
					Image = var_87_10
					var_87_12(var_87_11, var_9(var_87_10)).enabled = false

					local var_87_13 = arg_87_2:Find("item/icon_bg/frame")
					local var_87_14 = var_7.GetComponent

					typeof = var_9
					Image = var_87_10

					local var_87_15 = var_87_14(var_87_13, var_9(var_87_10))

					var_87_15.enabled = false
					setText = var_87_15

					var_87_15(arg_87_2:Find("awardCount"), var_3[4])

					if var_3[4] > var_86_5 then
						var_86_4 = arg_87_1
						var_86_5 = var_3[4]
					end
				end

				return
			end)
			var_2:align(#var_84_0.group_receive)

			for iter_86_0 = 1, #var_84_0.group_receive do
				SetActive = var_2_10007

				local var_86_11 = arg_84_0.redPacketUI
				local var_86_12 = var_8.Find(var_86_11, "panel/detail/detailScroll/Viewport/Content")
				local var_86_13 = var_8.GetChild(var_86_12, iter_86_0 - 1)

				var_2_10007(var_8.Find(var_86_13, "charaBg/king"), var_86_4 == iter_86_0 - 1)
			end

			return
		end

		SFX_PANEL = var_8

		var_4(var_84_22, var_84_24, var_84_25, var_8)
	end

	return
end

function var_0_1.CloseRedPacketPanel(arg_89_0)
	pg = var_1_10001

	local var_89_0 = var_1_10001.UIMgr.GetInstance()
	local var_89_1 = var_1.UnOverlayPanel
	local var_89_2 = arg_89_0.redPacketUI
	local var_89_3 = arg_89_0._tf

	var_89_1(var_89_0, var_89_2, var_4.Find(var_89_3, "subPages"))

	SetActive = var_89_1

	var_89_1(arg_89_0.redPacketUI, false)

	return
end

function var_0_1.SetData(arg_90_0)
	getProxy = var_1_10001
	InstagramChatProxy = var_1_10002

	local var_90_0 = var_1_10001(var_1_10002)

	arg_90_0.allChatList = var_1.GetChatList(var_90_0)
	table = var_2
	arg_90_0.chatList = var_2.insertto({}, arg_90_0.allChatList)

	var_1:SortChatList()

	return
end

function var_0_1.willExit(arg_91_0)
	local var_91_0 = arg_91_0.rightPanel
	local var_91_1 = var_1.Find(var_91_0, "chat/paintingMask/painting")

	if arg_91_0.paintingName then
		retPaintingPrefab = var_2

		var_2(var_91_1, arg_91_0.paintingName)

		arg_91_0.paintingName = nil
	end

	arg_91_0:RemoveAllTimer()
	arg_91_0:EixtOfficialAccounts()

	return
end

function var_0_1.StartTimer(arg_92_0, arg_92_1, arg_92_2)
	Timer = var_1_10003

	local var_92_0 = var_1_10003.New(arg_92_1, arg_92_2, 1)

	var_3.Start(var_92_0)

	table = var_4

	var_4.insert(arg_92_0.timerList, var_3)

	return
end

function var_0_1.RemoveAllTimer(arg_93_0)
	ipairs = var_1_10001

	for iter_93_0, iter_93_1 in var_1_10001(arg_93_0.timerList) do
		iter_93_1:Stop()
	end

	arg_93_0.timerList = {}

	return
end

function var_0_1.StartTimer2(arg_94_0, arg_94_1, arg_94_2)
	Timer = var_1_10003
	arg_94_0.timer = var_1_10003.New(arg_94_1, arg_94_2, 1)

	local var_94_0 = arg_94_0.timer

	var_3.Start(var_94_0)

	return
end

function var_0_1.SpeedUpMessage(arg_95_0)
	pg = var_1_10001

	local var_95_0 = var_1_10001.gameset.juuschat_dialogue_trigger_time.key_value / 1000

	pg = var_1_10002

	local var_95_1 = var_1_10002.gameset.juuschat_entering_time.key_value / 1000

	ipairs = var_1_10003

	for iter_95_0, iter_95_1 in var_1_10003(arg_95_0.timerList) do
		if iter_95_1.running then
			if iter_95_1.duration == var_95_1 then
				iter_95_1.time = 0.05
			elseif iter_95_1.time - var_95_0 < 0.05 then
				iter_95_1.time = 0.05

				arg_95_0:StartTimer2(function()
					local var_96_0 = arg_95_0

					var_0.SpeedUpWaiting(var_96_0)

					return
				end, 0.05)
			else
				iter_95_1.time = iter_95_1.time - var_95_0
			end
		end
	end

	return
end

function var_0_1.SpeedUpWaiting(arg_97_0)
	pg = var_1_10001

	local var_97_0 = var_1_10001.gameset.juuschat_entering_time.key_value / 1000

	ipairs = var_1_10002

	for iter_97_0, iter_97_1 in var_1_10002(arg_97_0.timerList) do
		if iter_97_1.running and iter_97_1.duration == var_97_0 then
			iter_97_1.time = 0.05

			break
		end
	end

	return
end

function var_0_1.ChangeFresh(arg_98_0)
	arg_98_0.canFresh = true

	return
end

function var_0_1.ChangeCharaTextFunc(arg_99_0, arg_99_1, arg_99_2)
	local function var_99_0(arg_100_0)
		local var_100_0 = arg_100_0:Find("chat/id")
		local var_100_1 = var_1.GetComponent

		typeof = var_3
		Text = var_2_10004

		local var_100_2 = var_100_1(var_100_0, var_3(var_2_10004)).text

		tostring = var_100_0

		if var_100_2 == var_100_0(arg_99_1) then
			setText = var_100_2

			var_100_2(arg_100_0:Find("chat/msg"), arg_99_2)
		end

		return
	end

	for iter_99_0 = 0, arg_99_0.charaScrollContent.childCount - 1 do
		local var_99_1 = arg_99_0.charaScrollContent
		local var_99_2 = var_8.GetChild(var_99_1, iter_99_0)

		var_99_0(var_99_2)
	end

	return
end

function var_0_1.ResetCharaTextFunc(arg_101_0, arg_101_1)
	local function var_101_0(arg_102_0)
		local var_102_0 = arg_102_0:Find("chat/id")
		local var_102_1 = var_1.GetComponent

		typeof = var_3
		Text = var_2_10004

		local var_102_2 = var_102_1(var_102_0, var_3(var_2_10004)).text

		tostring = var_102_0

		if var_102_2 == var_102_0(arg_101_1) then
			setText = var_102_2

			local var_102_3 = arg_102_0:Find("chat/msg")
			local var_102_4 = arg_102_0:Find("chat/displayWord")
			local var_102_5 = var_3.GetComponent

			typeof = var_5
			Text = var_2_10006

			var_102_2(var_102_3, var_102_5(var_102_4, var_5(var_2_10006)).text)
		end

		return
	end

	for iter_101_0 = 0, arg_101_0.charaScrollContent.childCount - 1 do
		local var_101_1 = arg_101_0.charaScrollContent
		local var_101_2 = var_7.GetChild(var_101_1, iter_101_0)

		var_101_0(var_101_2)
	end

	return
end

function var_0_1.SetEndAniEvent(arg_103_0, arg_103_1, arg_103_2)
	local var_103_0 = arg_103_1
	local var_103_1 = arg_103_1.GetComponent

	typeof = var_1_10005
	DftAniEvent = var_1_10006

	if var_103_1(var_103_0, var_1_10005(var_1_10006)) then
		var_3:SetEndEvent(function()
			arg_103_2()

			local var_104_0 = var_0

			var_0.SetEndEvent(var_104_0, nil)

			return
		end)
	end

	return
end

function var_0_1.onBackPressed(arg_105_0)
	isActive = var_1_10001

	if var_1_10001(arg_105_0.filterUI) then
		arg_105_0:CloseFilterPanel()

		return
	end

	isActive = var_1

	if var_1(arg_105_0.topicUI) then
		arg_105_0:CloseTopicPanel()

		return
	end

	isActive = var_1

	if var_1(arg_105_0.backgroundUI) then
		arg_105_0:CloseBackgroundPanel()

		return
	end

	isActive = var_1

	if var_1(arg_105_0.redPacketUI) then
		arg_105_0:CloseRedPacketPanel()

		return
	end

	isActive = var_1

	if var_1(arg_105_0.rightOfficialAccountsPanel) then
		isActive = var_1

		if var_1(arg_105_0.rightOfficialAccountsInfoPanel) then
			arg_105_0:ExitOfficialAccountsInfo()

			return
		end
	end

	local var_105_0 = arg_105_0
	local var_105_1 = arg_105_0.emit

	InstagramChatMediator = var_1_10003

	var_105_1(var_105_0, var_1_10003.CLOSE_ALL)

	return
end

function var_0_1.InitOfficialAccounts(arg_106_0)
	local var_106_0 = arg_106_0.rightOfficialAccountsPanel

	arg_106_0.rightOfficialAccountsListPanel = var_1.Find(var_106_0, "officialAccountsPanel")

	local var_106_1 = arg_106_0.rightOfficialAccountsPanel

	arg_106_0.rightOfficialAccountsInfoPanel = var_1.Find(var_106_1, "officialAccountsInfoPanel")
	setText = var_1

	local var_106_2 = arg_106_0.rightOfficialAccountsListPanel
	local var_106_3 = var_2.Find(var_106_2, "topBg/Text")

	i18n = var_106_2

	var_1(var_106_3, var_106_2("juusoa_title"))

	setText = var_1

	local var_106_4 = arg_106_0.rightOfficialAccountsInfoPanel
	local var_106_5 = var_2.Find(var_106_4, "topBg/Text")

	i18n = var_106_4

	var_1(var_106_5, var_106_4("juusoa_title"))

	local var_106_6 = arg_106_0.rightOfficialAccountsListPanel
	local var_106_7 = var_1.Find(var_106_6, "charaScroll")

	arg_106_0.officialAccountsScroll = var_1.GetComponent(var_106_7, "LScrollRect")

	local var_106_8 = arg_106_0.officialAccountsScroll

	handler = var_106_7
	var_106_8.onInitItem = var_106_7(arg_106_0, arg_106_0.OfficialAccountsInitItem)

	local var_106_9 = arg_106_0.officialAccountsScroll

	handler = var_2
	var_106_9.onUpdateItem = var_2(arg_106_0, arg_106_0.OfficialAccountsUpdateItem)
	BulletinBoardMgr = var_106_9
	arg_106_0.downloadmgr = var_106_9.Inst
	arg_106_0.sprites = {}
	arg_106_0.toDownloadList = {}

	local var_106_10 = arg_106_0.rightOfficialAccountsInfoPanel
	local var_106_11 = var_1.Find(var_106_10, "scroll")
	local var_106_12 = var_1.GetComponent

	typeof = var_3
	ScrollRect = var_4
	arg_106_0.officialAccountsInfoScroll = var_106_12(var_106_11, var_3(var_4))

	local var_106_13 = arg_106_0.rightOfficialAccountsInfoPanel

	arg_106_0.officialAccountsInfoItem = var_1.Find(var_106_13, "scroll/content/infoItem")
	UIItemList = var_1

	local var_106_14 = var_1.New
	local var_106_15 = arg_106_0.rightOfficialAccountsInfoPanel
	local var_106_16 = var_2.Find(var_106_15, "scroll/content/commentPanel")
	local var_106_17 = arg_106_0.rightOfficialAccountsInfoPanel

	arg_106_0.commentList = var_106_14(var_106_16, var_3.Find(var_106_17, "scroll/content/commentPanel/tpl"))

	local var_106_18 = arg_106_0.rightOfficialAccountsInfoPanel

	arg_106_0.commentPanel = var_1.Find(var_106_18, "last/bg2")

	local var_106_19 = arg_106_0.rightOfficialAccountsInfoPanel

	arg_106_0.optionalPanel = var_1.Find(var_106_19, "last/bg2/option")
	setActive = var_1

	var_1(arg_106_0.rightOfficialAccountsPanel, false)

	setActive = var_1

	var_1(arg_106_0.rightOfficialAccountsInfoPanel, false)

	return
end

function var_0_1.UpdateOfficialAccounts(arg_107_0, arg_107_1)
	setActive = var_1_10002

	var_1_10002(arg_107_0.rightChatPanel, false)

	setActive = var_1_10002

	var_1_10002(arg_107_0.rightOfficialAccountsPanel, true)

	setActive = var_1_10002

	var_1_10002(arg_107_0.rightOfficialAccountsListPanel, true)

	setActive = var_1_10002

	var_1_10002(arg_107_0.rightOfficialAccountsInfoPanel, false)

	arg_107_0.currentChat = arg_107_1
	arg_107_0.instagramOfficialAccounts = {}
	pairs = var_2
	getProxy = var_3
	InstagramProxy = var_4

	local var_107_0 = var_3(var_4)

	for iter_107_0, iter_107_1 in var_2(var_3.GetOfficialAccounts(var_107_0)) do
		table = var_1_10007

		var_1_10007.insert(arg_107_0.instagramOfficialAccounts, iter_107_1)
	end

	table = var_2

	var_2.sort(arg_107_0.instagramOfficialAccounts, function(arg_108_0, arg_108_1)
		return arg_108_0.id > arg_108_1.id
	end)

	local var_107_1 = arg_107_0.officialAccountsScroll

	var_2.SetTotalCount(var_107_1, #arg_107_0.instagramOfficialAccounts)

	return
end

function var_0_1.OfficialAccountsInitItem(arg_109_0, arg_109_1)
	local var_109_0 = arg_109_0.officialAccountsItemList

	InstagramOfficialAccountsItem = var_1_10003

	local var_109_1 = var_1_10003.New

	tf = var_1_10004
	var_109_0[arg_109_1] = var_109_1(var_1_10004(arg_109_1), arg_109_0)

	return
end

function var_0_1.OfficialAccountsUpdateItem(arg_110_0, arg_110_1, arg_110_2)
	local var_110_0

	if arg_110_0.officialAccountsItemList[arg_110_2] == nil then
		arg_110_0:OfficialAccountsInitItem(arg_110_2)

		var_110_0 = arg_110_0.officialAccountsItemList[arg_110_2]
	end

	local var_110_1 = arg_110_0.instagramOfficialAccounts[arg_110_1 + 1]

	tf = var_5

	local var_110_2 = var_5(arg_110_2)

	var_110_0:SetData(var_110_1.id)

	local var_110_3 = arg_110_0
	local var_110_4 = arg_110_0.SetImageByUrl
	local var_110_5 = var_110_1.oaListPic
	local var_110_6 = var_110_2:Find("Image")
	local var_110_7 = var_9.GetComponent

	typeof = var_11
	RawImage = var_1_10012

	var_110_4(var_110_3, var_110_5, var_110_7(var_110_6, var_11(var_1_10012)))

	onButton = var_110_4

	local var_110_8 = arg_110_0
	local var_110_9 = var_110_2

	local function var_110_10()
		local var_111_0 = arg_110_0

		var_111_0.currentOfficalID = var_110_1.id
		pg = var_111_0

		local var_111_1 = var_111_0.GameTrackerMgr.GetInstance()
		local var_111_2 = var_0.Record

		GameTrackerBuilder = var_2_10002

		var_111_2(var_111_1, var_2_10002.BuildJuusOfficialAccountsClick(var_110_1.id))

		local var_111_3 = arg_110_0

		var_0.ShowOfficialAccountsInfo(var_111_3, var_110_1)

		local var_111_4 = arg_110_0

		var_0.ReadOfficialAccountComment(var_111_4)

		arg_110_0.officialAccountsInfoScroll.verticalNormalizedPosition = 1

		return
	end

	SFX_PANEL = var_110_6

	var_110_4(var_110_8, var_110_9, var_110_10, var_110_6)

	return
end

function var_0_1.ShowOfficialAccountsInfo(arg_112_0, arg_112_1)
	setActive = var_1_10002

	var_1_10002(arg_112_0.rightOfficialAccountsListPanel, false)

	setActive = var_1_10002

	var_1_10002(arg_112_0.rightOfficialAccountsInfoPanel, true)
	arg_112_0:CloseCommentPanel()

	onButton = var_2

	local var_112_0 = arg_112_0
	local var_112_1 = arg_112_0.rightOfficialAccountsInfoPanel
	local var_112_2 = var_4.Find(var_112_1, "topBg")

	local function var_112_3()
		local var_113_0 = arg_112_0

		var_0.ExitOfficialAccountsInfo(var_113_0)

		return
	end

	SFX_PANEL = var_6

	var_2(var_112_0, var_112_2, var_112_3, var_6)

	setScrollText = var_2

	local var_112_4 = arg_112_0.officialAccountsInfoItem

	var_2(var_3.Find(var_112_4, "title/Text"), arg_112_1:getConfig("title"))

	setText = var_2

	local var_112_5 = arg_112_0.officialAccountsInfoItem

	var_2(var_3.Find(var_112_5, "content"), arg_112_1.text)

	local var_112_6 = arg_112_0
	local var_112_7 = arg_112_0.SetImageByUrl
	local var_112_8 = arg_112_1:GetImage()
	local var_112_9 = arg_112_0.officialAccountsInfoItem
	local var_112_10 = var_5.Find(var_112_9, "Image/Image")
	local var_112_11 = var_5.GetComponent

	typeof = var_7
	RawImage = var_1_10008

	var_112_7(var_112_6, var_112_8, var_112_11(var_112_10, var_7(var_1_10008)))

	setText = var_112_7

	local var_112_12 = arg_112_0.officialAccountsInfoItem

	var_112_7(var_3.Find(var_112_12, "bottom/time"), arg_112_1:GetPushTime())
	arg_112_0:UpdateLinkBtn(arg_112_1.id)

	onButton = var_2

	local var_112_13 = arg_112_0
	local var_112_14 = arg_112_0.officialAccountsInfoItem
	local var_112_15 = var_4.Find(var_112_14, "bottom/time/share")

	local function var_112_16()
		local var_114_0 = arg_112_0
		local var_114_1 = var_0.emit

		InstagramChatMediator = var_2_10002

		local var_114_2 = var_2_10002.ON_OFFICIAL_ACCOUNTS_OPERATE

		ActivityConst = var_2_10003

		var_114_1(var_114_0, var_114_2, var_2_10003.INSTAGRAM_OP_SHARE, arg_112_1.id)

		return
	end

	SFX_PANEL = var_6

	var_2(var_112_13, var_112_15, var_112_16, var_6)
	arg_112_0:UpdateCommentList(arg_112_1.id)

	Canvas = var_2

	var_2.ForceUpdateCanvases()

	onToggle = var_2

	local var_112_17 = arg_112_0
	local var_112_18 = arg_112_0.commentPanel

	local function var_112_19(arg_115_0)
		if arg_115_0 then
			local var_115_0 = arg_112_0

			var_1.OpenCommentPanel(var_115_0, arg_112_1.id)
		else
			local var_115_1 = arg_112_0

			var_1.CloseCommentPanel(var_115_1)
		end

		return
	end

	SFX_PANEL = var_6

	var_2(var_112_17, var_112_18, var_112_19, var_6)

	return
end

function var_0_1.ExitOfficialAccountsInfo(arg_116_0)
	setActive = var_1_10001

	var_1_10001(arg_116_0.rightOfficialAccountsListPanel, true)

	setActive = var_1_10001

	var_1_10001(arg_116_0.rightOfficialAccountsInfoPanel, false)

	arg_116_0.currentOfficalID = nil

	return
end

function var_0_1.UpdateLinkBtn(arg_117_0, arg_117_1)
	getProxy = var_1_10002
	InstagramProxy = var_1_10003

	local var_117_0 = var_1_10002(var_1_10003)
	local var_117_1 = var_2.GetOfficialAccounts(var_117_0)[arg_117_1]
	local var_117_2 = var_2.IsLiking(var_117_1)
	local var_117_3 = arg_117_0.officialAccountsInfoItem
	local var_117_4 = var_4.Find(var_117_3, "bottom/notCare")

	if not var_117_2 then
		onButton = var_117_3

		local var_117_5 = arg_117_0
		local var_117_6 = var_117_4

		local function var_117_7()
			local var_118_0 = arg_117_0
			local var_118_1 = var_0.emit

			InstagramChatMediator = var_2_10002

			local var_118_2 = var_2_10002.ON_OFFICIAL_ACCOUNTS_OPERATE

			ActivityConst = var_2_10003

			var_118_1(var_118_0, var_118_2, var_2_10003.INSTAGRAM_OP_LIKE, var_0.id)

			return
		end

		SFX_PANEL = var_1_10009

		var_117_3(var_117_5, var_117_6, var_117_7, var_1_10009)
	else
		removeOnButton = var_117_3

		var_117_3(var_117_4)
	end

	setActive = var_117_3

	var_117_3(var_117_4, not var_117_2)

	setActive = var_117_3

	local var_117_8 = arg_117_0.officialAccountsInfoItem

	var_117_3(var_6.Find(var_117_8, "bottom/care"), var_117_2)

	setText = var_117_3

	local var_117_9 = arg_117_0.officialAccountsInfoItem
	local var_117_10 = var_6.Find(var_117_9, "bottom/careText")

	i18n = var_117_9

	var_117_3(var_117_10, var_117_9("ins_word_like", var_2:GetLikeCnt()))

	return
end

function var_0_1.UpdateCommentList(arg_119_0, arg_119_1)
	if arg_119_0.currentOfficalID ~= arg_119_1 then
		return
	end

	getProxy = var_2
	InstagramProxy = var_1_10003

	local var_119_0 = var_2(var_1_10003)

	if not var_2.GetOfficialAccounts(var_119_0)[arg_119_1] then
		return
	end

	local var_119_1, var_119_2 = var_2:GetCanDisplayComments()

	table = var_1_10005

	var_1_10005.sort(var_119_1, function(arg_120_0, arg_120_1)
		return arg_120_0.time < arg_120_1.time
	end)

	local var_119_3 = arg_119_0.commentList

	var_5.make(var_119_3, function(arg_121_0, arg_121_1, arg_121_2)
		UIItemList = var_2_10003

		if arg_121_0 == var_2_10003.EventUpdate then
			local var_121_0 = var_119_1[arg_121_1 + 1]
			local var_121_1 = var_3.HasReply(var_121_0)

			setText = var_121_0

			var_121_0(arg_121_2:Find("main/reply"), var_3:GetReplyBtnTxt())

			local var_121_2 = var_3
			local var_121_3 = var_3.GetContent(var_121_2)

			SwitchSpecialChar = var_121_2

			local var_121_4 = var_121_2(var_121_3)

			setText = var_6

			local var_121_5 = arg_121_2
			local var_121_6 = arg_121_2.Find(var_121_5, "main/content")

			HXSet = var_121_5

			var_6(var_121_6, var_121_5.hxLan(var_121_4))

			setText = var_6

			var_6(arg_121_2:Find("main/bubble/Text"), var_3:GetReplyCnt())

			setText = var_6

			local var_121_7 = arg_121_2:Find("main/time")
			local var_121_8 = var_3

			var_6(var_121_7, var_3.GetTime(var_121_8))

			local var_121_9 = var_3
			local var_121_10 = var_3.GetType(var_121_9)

			Instagram = var_121_9

			if var_121_10 == var_121_9.TYPE_PLAYER_COMMENT then
				local var_121_11

				var_121_10, var_121_11 = var_3:GetIcon()
				setImageSprite = var_8

				local var_121_12 = arg_121_2

				var_121_8 = arg_121_2.Find(var_121_12, "main/head/icon")
				GetSpriteFromAtlas = var_121_12

				var_8(var_121_8, var_121_12(var_121_10, var_121_11))
			else
				setImageSprite = var_121_10

				local var_121_13 = arg_121_2
				local var_121_14 = arg_121_2.Find(var_121_13, "main/head/icon")

				LoadSprite = var_121_13

				var_121_10(var_121_14, var_121_13("qicon/" .. var_3:GetIcon()), false)
			end

			if var_121_1 then
				onToggle = var_121_10

				local var_121_15 = arg_119_0

				var_121_8 = arg_121_2

				local var_121_16 = arg_121_2.Find(var_121_8, "main/bubble")

				function var_121_8(arg_122_0)
					setActive = var_3_10001

					local var_122_0 = arg_121_2

					var_3_10001(var_2.Find(var_122_0, "replys"), arg_122_0)

					return
				end

				SFX_PANEL = var_10

				var_121_10(var_121_15, var_121_16, var_121_8, var_10)

				local var_121_17 = arg_119_0

				var_121_10.UpdateReplys(var_121_17, arg_121_2, var_3)

				triggerToggle = var_121_10

				var_121_10(arg_121_2:Find("main/bubble"), true)
			else
				setActive = var_121_10

				var_121_10(arg_121_2:Find("replys"), false)

				triggerToggle = var_121_10

				var_121_10(arg_121_2:Find("main/bubble"), false)
			end

			local var_121_18 = arg_121_2:Find("main/bubble")
			local var_121_19 = var_6.GetComponent

			typeof = var_8
			Toggle = var_121_8
			var_121_19(var_121_18, var_8(var_121_8)).enabled = var_121_1
		end

		return
	end)

	Canvas = var_5

	var_5.ForceUpdateCanvases()

	local var_119_4 = arg_119_0.commentList

	var_5.align(var_119_4, #var_119_1)

	return
end

function var_0_1.UpdateReplys(arg_123_0, arg_123_1, arg_123_2)
	local var_123_0, var_123_1 = arg_123_2:GetCanDisplayReply()

	UIItemList = var_1_10005

	local var_123_2 = var_1_10005.New(arg_123_1:Find("replys"), arg_123_1:Find("replys/sub"))

	table = var_6

	var_6.sort(var_123_0, function(arg_124_0, arg_124_1)
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
		UIItemList = var_2_10003

		if arg_125_0 == var_2_10003.EventUpdate then
			local var_125_0 = var_123_0[arg_125_1 + 1]

			setImageSprite = var_4

			local var_125_1 = arg_125_2
			local var_125_2 = arg_125_2.Find(var_125_1, "head/icon")

			LoadSprite = var_125_1

			var_4(var_125_2, var_125_1("qicon/" .. var_125_0:GetIcon()), false)

			local var_125_3 = var_125_0
			local var_125_4 = var_125_0.GetContent(var_125_3)

			SwitchSpecialChar = var_125_3

			local var_125_5 = var_125_3(var_125_4)

			setText = var_5

			local var_125_6 = arg_125_2
			local var_125_7 = arg_125_2.Find(var_125_6, "content")

			HXSet = var_125_6

			var_5(var_125_7, var_125_6.hxLan(var_125_5))
		end

		return
	end)
	var_123_2:align(#var_123_0)

	return
end

function var_0_1.OpenCommentPanel(arg_126_0, arg_126_1)
	getProxy = var_1_10002
	InstagramProxy = var_1_10003

	local var_126_0 = var_1_10002(var_1_10003)
	local var_126_1 = var_2.GetOfficialAccounts(var_126_0)[arg_126_1]

	if not var_2.CanOpenComment(var_126_1) then
		return
	end

	setActive = var_3

	var_3(arg_126_0.optionalPanel, true)

	local var_126_2 = var_2:GetOptionComment()
	local var_126_3 = arg_126_0.commentPanel

	Vector2 = var_5
	var_126_3.sizeDelta = var_5(0, #var_126_2 * 120 + 40)
	UIItemList = var_126_3

	local var_126_4 = var_126_3.New
	local var_126_5 = arg_126_0.optionalPanel
	local var_126_6 = arg_126_0.optionalPanel
	local var_126_7 = var_126_4(var_126_5, var_6.Find(var_126_6, "option1"))

	var_4.make(var_126_7, function(arg_127_0, arg_127_1, arg_127_2)
		UIItemList = var_2_10003

		if arg_127_0 == var_2_10003.EventUpdate then
			local var_127_0 = arg_127_1 + 1
			local var_127_1 = var_126_2[var_127_0].text
			local var_127_2 = var_126_2[var_127_0].id
			local var_127_3 = var_126_2[var_127_0].index

			setText = var_2_10007

			local var_127_4 = arg_127_2
			local var_127_5 = arg_127_2.Find(var_127_4, "Text")

			HXSet = var_127_4

			var_2_10007(var_127_5, var_127_4.hxLan(var_127_1))

			onButton = var_2_10007

			local var_127_6 = arg_126_0
			local var_127_7 = arg_127_2

			local function var_127_8()
				local var_128_0 = arg_126_0
				local var_128_1 = var_0.emit

				InstagramChatMediator = var_3_10002

				local var_128_2 = var_3_10002.ON_OFFICIAL_ACCOUNTS_OPERATE

				ActivityConst = var_3_10003

				var_128_1(var_128_0, var_128_2, var_3_10003.INSTAGRAM_OP_COMMENT, arg_126_1, var_127_2, var_127_3)

				local var_128_3 = arg_126_0

				var_0.CloseCommentPanel(var_128_3)

				return
			end

			SFX_PANEL = var_2_10011

			var_2_10007(var_127_6, var_127_7, var_127_8, var_2_10011)
		end

		return
	end)
	var_4:align(#var_126_2)

	return
end

function var_0_1.CloseCommentPanel(arg_129_0)
	local var_129_0 = arg_129_0.commentPanel

	Vector2 = var_1_10002
	var_129_0.sizeDelta = var_1_10002(0, 0)
	setActive = var_129_0

	var_129_0(arg_129_0.optionalPanel, false)

	return
end

function var_0_1.ReadOfficialAccountComment(arg_130_0)
	if arg_130_0.currentChat then
		local var_130_0 = arg_130_0.currentChat.chatType

		InstagramConst = var_1_10002

		if var_130_0 == var_1_10002.INSTAGRAM_CHAT_TYPE.OFFICIAL_ACCOUNT and arg_130_0.currentOfficalID then
			getProxy = var_1
			InstagramProxy = var_2

			local var_130_1 = var_1(var_2)

			if var_1.GetOfficialAccounts(var_130_1)[arg_130_0.currentOfficalID] and not var_1:IsReaded() then
				local var_130_2 = arg_130_0
				local var_130_3 = arg_130_0.emit

				InstagramChatMediator = var_1_10004

				local var_130_4 = var_1_10004.ON_OFFICIAL_ACCOUNTS_OPERATE

				ActivityConst = var_1_10005

				var_130_3(var_130_2, var_130_4, var_1_10005.INSTAGRAM_OP_MARK_READ, arg_130_0.currentOfficalID)
			end
		end
	end

	return
end

function var_0_1.RefreshOfficialAccountTips(arg_131_0)
	pairs = var_1_10001

	for iter_131_0, iter_131_1 in var_1_10001(arg_131_0.officialAccountsItemList) do
		iter_131_1:RefreshTip()
	end

	local var_131_0 = arg_131_0.charaScrollrect

	var_1.SetTotalCount(var_131_0, #arg_131_0.chatList)

	return
end

function var_0_1.SetImageByUrl(arg_132_0, arg_132_1, arg_132_2, arg_132_3)
	if not arg_132_1 or arg_132_1 == "" then
		setActive = var_1_10004

		var_1_10004(arg_132_2.gameObject, false)

		if arg_132_3 then
			arg_132_3()
		end
	else
		setActive = var_1_10004

		var_1_10004(arg_132_2.gameObject, true)

		if arg_132_0.sprites[arg_132_1] then
			arg_132_2.texture = var_4

			if arg_132_3 then
				arg_132_3()
			end
		else
			arg_132_2.enabled = false

			local var_132_0 = arg_132_0.downloadmgr
			local var_132_1 = var_5.GetTexture
			local var_132_2 = "ins"
			local var_132_3 = "1"
			local var_132_4 = arg_132_1

			UnityEngine = var_1_10010

			var_132_1(var_132_0, var_132_2, var_132_3, var_132_4, var_1_10010.Events.UnityAction_UnityEngine_Texture(function(arg_133_0)
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

			table = var_132_1

			var_132_1.insert(arg_132_0.toDownloadList, arg_132_1)
		end
	end

	return
end

function var_0_1.AddOfficialAccountsTimer(arg_134_0)
	local var_134_0 = arg_134_0

	arg_134_0.StopOfficialAccountsTimer(var_134_0)

	getProxy = var_1
	InstagramProxy = var_134_0

	local var_134_1 = var_1(var_134_0)
	local var_134_2 = var_1.GetOfficialAccounts(var_134_1)

	pg = var_134_1

	local var_134_3 = var_134_1.TimeMgr.GetInstance()
	local var_134_4 = var_2.GetServerTime(var_134_3)

	pairs = var_134_3

	for iter_134_0, iter_134_1 in var_134_3(var_134_2) do
		if iter_134_1:GetFastestRefreshTime() then
			if var_8 - var_134_4 <= 0 then
				local var_134_5 = arg_134_0
				local var_134_6 = arg_134_0.emit

				InstagramChatMediator = var_1_10012
				var_1_10012 = var_1_10012.ON_OFFICIAL_ACCOUNTS_OPERATE
				ActivityConst = var_1_10013

				var_134_6(var_134_5, var_1_10012, var_1_10013.INSTAGRAM_OP_UPDATE, iter_134_1.id)
			else
				local var_134_7 = arg_134_0.officialAccountsTimerList
				local var_134_8 = iter_134_1.id

				Timer = var_1_10012
				var_134_7[var_134_8] = var_1_10012.New(function()
					local var_135_0 = arg_134_0
					local var_135_1 = var_0.emit

					InstagramChatMediator = var_2_10002

					local var_135_2 = var_2_10002.ON_OFFICIAL_ACCOUNTS_OPERATE

					ActivityConst = var_2_10003

					var_135_1(var_135_0, var_135_2, var_2_10003.INSTAGRAM_OP_UPDATE, iter_134_1.id)

					return
				end, var_9, 1)

				local var_134_9 = arg_134_0.officialAccountsTimerList[iter_134_1.id]

				var_10.Start(var_134_9)
			end
		end
	end

	return
end

function var_0_1.StopOfficialAccountsTimer(arg_136_0)
	pairs = var_1_10001

	for iter_136_0, iter_136_1 in var_1_10001(arg_136_0.officialAccountsTimerList) do
		local var_136_0 = arg_136_0.officialAccountsTimerList[iter_136_0]

		var_6.Stop(var_136_0)
	end

	arg_136_0.officialAccountsTimerList = {}

	return
end

function var_0_1.EixtOfficialAccounts(arg_137_0)
	arg_137_0:StopOfficialAccountsTimer()

	arg_137_0.officialAccountsItemList = nil
	arg_137_0.exited = true
	arg_137_0.sprites = nil
	ipairs = var_1

	local var_137_0

	if not arg_137_0.toDownloadList then
		var_137_0 = {}
	end

	for iter_137_0, iter_137_1 in var_1(var_137_0) do
		local var_137_1 = arg_137_0.downloadmgr

		var_6.StopLoader(var_137_1, iter_137_1)
	end

	arg_137_0.toDownloadList = {}

	return
end

return var_0_1
