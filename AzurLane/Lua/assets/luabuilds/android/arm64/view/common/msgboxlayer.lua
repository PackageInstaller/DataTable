class = var_0_10000

local var_0_0 = "MsgboxLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))

require = var_0_10001

local var_0_2 = var_0_10001("Mgr.const.MsgboxBtnNameMap")

var_0_1.BUTTON_BLUE = 1
var_0_1.BUTTON_GRAY = 2
var_0_1.BUTTON_RED = 3
var_0_1.BUTTON_MEDAL = 4
var_0_1.BUTTON_RETREAT = 5
var_0_1.BUTTON_PREPAGE = 6
var_0_1.BUTTON_NEXTPAGE = 7
var_0_1.BUTTON_BLUE_WITH_ICON = 8
var_0_1.TITLE_INFORMATION = "infomation"
var_0_1.TITLE_SETTING = "setting"
var_0_1.TITLE_WARNING = "warning"
var_0_1.TITLE_OBTAIN = "obtain"
var_0_1.TITLE_CADPA = "cadpa"
var_0_1.TEXT_CANCEL = "text_cancel"
var_0_1.TEXT_CONFIRM = "text_confirm"

function var_0_1.getUIName(arg_1_0)
	return "MsgBoxUI"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0._window = var_1.Find(var_2_0, "window")
	setActive = var_1

	var_1(arg_2_0._window, true)

	local var_2_1 = arg_2_0._window

	arg_2_0._top = var_1.Find(var_2_1, "top")

	local var_2_2 = arg_2_0._top

	arg_2_0._titleList = var_1.Find(var_2_2, "bg")

	local var_2_3 = arg_2_0._top

	arg_2_0._closeBtn = var_1.Find(var_2_3, "btnBack")
	setText = var_1

	local var_2_4 = arg_2_0._titleList
	local var_2_5 = var_3.Find(var_2_4, "infomation/title")

	i18n = var_4

	var_1(var_2_5, var_4("words_information"))

	setText = var_1

	local var_2_6 = arg_2_0._titleList
	local var_2_7 = var_3.Find(var_2_6, "cadpa/title")

	i18n = var_4

	var_1(var_2_7, var_4("cadpa_tip1"))

	local var_2_8 = arg_2_0._tf

	arg_2_0._res = var_1.Find(var_2_8, "res")

	local var_2_9 = arg_2_0._window

	arg_2_0._msgPanel = var_1.Find(var_2_9, "msg_panel")

	local var_2_10 = arg_2_0._msgPanel
	local var_2_11 = var_1.Find(var_2_10, "content")

	arg_2_0.contentText = var_1.GetComponent(var_2_11, "RichText")

	local var_2_12 = arg_2_0.contentText
	local var_2_13 = var_1.AddSprite
	local var_2_14 = "diamond"
	local var_2_15 = arg_2_0._res
	local var_2_16 = var_5.Find(var_2_15, "diamond")
	local var_2_17 = var_5.GetComponent

	typeof = var_8
	Image = var_1_10010

	var_2_13(var_2_12, var_2_14, var_2_17(var_2_16, var_8(var_1_10010)).sprite)

	local var_2_18 = arg_2_0.contentText
	local var_2_19 = var_1.AddSprite
	local var_2_20 = "gold"
	local var_2_21 = arg_2_0._res
	local var_2_22 = var_5.Find(var_2_21, "gold")
	local var_2_23 = var_5.GetComponent

	typeof = var_8
	Image = var_1_10010

	var_2_19(var_2_18, var_2_20, var_2_23(var_2_22, var_8(var_1_10010)).sprite)

	local var_2_24 = arg_2_0.contentText
	local var_2_25 = var_1.AddSprite
	local var_2_26 = "oil"
	local var_2_27 = arg_2_0._res
	local var_2_28 = var_5.Find(var_2_27, "oil")
	local var_2_29 = var_5.GetComponent

	typeof = var_8
	Image = var_1_10010

	var_2_25(var_2_24, var_2_26, var_2_29(var_2_28, var_8(var_1_10010)).sprite)

	local var_2_30 = arg_2_0.contentText
	local var_2_31 = var_1.AddSprite
	local var_2_32 = "world_money"
	local var_2_33 = arg_2_0._res
	local var_2_34 = var_5.Find(var_2_33, "world_money")
	local var_2_35 = var_5.GetComponent

	typeof = var_8
	Image = var_1_10010

	var_2_31(var_2_30, var_2_32, var_2_35(var_2_34, var_8(var_1_10010)).sprite)

	local var_2_36 = arg_2_0.contentText
	local var_2_37 = var_1.AddSprite
	local var_2_38 = "port_money"
	local var_2_39 = arg_2_0._res
	local var_2_40 = var_5.Find(var_2_39, "port_money")
	local var_2_41 = var_5.GetComponent

	typeof = var_8
	Image = var_1_10010

	var_2_37(var_2_36, var_2_38, var_2_41(var_2_40, var_8(var_1_10010)).sprite)

	local var_2_42 = arg_2_0.contentText
	local var_2_43 = var_1.AddSprite
	local var_2_44 = "guildicon"
	local var_2_45 = arg_2_0._res
	local var_2_46 = var_5.Find(var_2_45, "guildicon")
	local var_2_47 = var_5.GetComponent

	typeof = var_8
	Image = var_1_10010

	var_2_43(var_2_42, var_2_44, var_2_47(var_2_46, var_8(var_1_10010)).sprite)

	local var_2_48 = arg_2_0._window

	arg_2_0._exchangeShipPanel = var_1.Find(var_2_48, "exchange_ship_panel")

	local var_2_49 = arg_2_0._window

	arg_2_0._itemPanel = var_1.Find(var_2_49, "item_panel")

	local var_2_50 = arg_2_0._itemPanel
	local var_2_51 = var_1.Find(var_2_50, "Text")
	local var_2_52 = var_1.GetComponent

	typeof = var_4
	Text = var_6
	arg_2_0._itemText = var_2_52(var_2_51, var_4(var_6))

	local var_2_53 = arg_2_0._itemPanel

	arg_2_0._itemListItemContainer = var_1.Find(var_2_53, "scrollview/list")

	local var_2_54 = arg_2_0._itemListItemContainer

	arg_2_0._itemListItemTpl = var_1.Find(var_2_54, "item")

	local var_2_55 = arg_2_0._window

	arg_2_0._eskinPanel = var_1.Find(var_2_55, "eskin_panel")

	local var_2_56 = arg_2_0._eskinPanel
	local var_2_57 = var_1.Find(var_2_56, "Text")
	local var_2_58 = var_1.GetComponent

	typeof = var_4
	Text = var_6
	arg_2_0._eskinText = var_2_58(var_2_57, var_4(var_6))

	local var_2_59 = arg_2_0._eskinPanel

	arg_2_0._eskinListItemContainer = var_1.Find(var_2_59, "scrollview/list")

	local var_2_60 = arg_2_0._eskinListItemContainer

	arg_2_0._eskinListItemTpl = var_1.Find(var_2_60, "item")

	local var_2_61 = arg_2_0._window

	arg_2_0._sigleItemPanel = var_1.Find(var_2_61, "single_item_panel")

	local var_2_62 = arg_2_0._sigleItemPanel

	arg_2_0._singleItemshipTypeTF = var_1.Find(var_2_62, "display_panel/name_container/shiptype")

	local var_2_63 = arg_2_0._sigleItemPanel

	arg_2_0.singleItemIntro = var_1.Find(var_2_63, "display_panel/desc/Text")

	local var_2_64 = arg_2_0.singleItemIntro
	local var_2_65 = var_1.GetComponent(var_2_64, "RichText")
	local var_2_66 = var_1.AddSprite
	local var_2_67 = "diamond"
	local var_2_68 = arg_2_0._res
	local var_2_69 = var_6.Find(var_2_68, "diamond")
	local var_2_70 = var_6.GetComponent

	typeof = var_9
	Image = var_1_10011

	var_2_66(var_2_65, var_2_67, var_2_70(var_2_69, var_9(var_1_10011)).sprite)

	local var_2_71 = var_1
	local var_2_72 = var_1.AddSprite
	local var_2_73 = "gold"
	local var_2_74 = arg_2_0._res
	local var_2_75 = var_6.Find(var_2_74, "gold")
	local var_2_76 = var_6.GetComponent

	typeof = var_9
	Image = var_1_10011

	var_2_72(var_2_71, var_2_73, var_2_76(var_2_75, var_9(var_1_10011)).sprite)

	local var_2_77 = var_1
	local var_2_78 = var_1.AddSprite
	local var_2_79 = "oil"
	local var_2_80 = arg_2_0._res
	local var_2_81 = var_6.Find(var_2_80, "oil")
	local var_2_82 = var_6.GetComponent

	typeof = var_9
	Image = var_1_10011

	var_2_78(var_2_77, var_2_79, var_2_82(var_2_81, var_9(var_1_10011)).sprite)

	local var_2_83 = var_1
	local var_2_84 = var_1.AddSprite
	local var_2_85 = "world_money"
	local var_2_86 = arg_2_0._res
	local var_2_87 = var_6.Find(var_2_86, "world_money")
	local var_2_88 = var_6.GetComponent

	typeof = var_9
	Image = var_1_10011

	var_2_84(var_2_83, var_2_85, var_2_88(var_2_87, var_9(var_1_10011)).sprite)

	local var_2_89 = var_1
	local var_2_90 = var_1.AddSprite
	local var_2_91 = "port_money"
	local var_2_92 = arg_2_0._res
	local var_2_93 = var_6.Find(var_2_92, "port_money")
	local var_2_94 = var_6.GetComponent

	typeof = var_9
	Image = var_1_10011

	var_2_90(var_2_89, var_2_91, var_2_94(var_2_93, var_9(var_1_10011)).sprite)

	local var_2_95 = var_1
	local var_2_96 = var_1.AddSprite
	local var_2_97 = "world_boss"
	local var_2_98 = arg_2_0._res
	local var_2_99 = var_6.Find(var_2_98, "world_boss")
	local var_2_100 = var_6.GetComponent

	typeof = var_9
	Image = var_1_10011

	var_2_96(var_2_95, var_2_97, var_2_100(var_2_99, var_9(var_1_10011)).sprite)

	local var_2_101 = arg_2_0._sigleItemPanel

	arg_2_0._singleItemSubIntroTF = var_2.Find(var_2_101, "sub_intro")
	setText = var_2

	local var_2_102 = arg_2_0._sigleItemPanel
	local var_2_103 = var_4.Find(var_2_102, "ship_group/locked/Text")

	i18n = var_5

	var_2(var_2_103, var_5("tag_ship_locked"))

	setText = var_2

	local var_2_104 = arg_2_0._sigleItemPanel
	local var_2_105 = var_4.Find(var_2_104, "ship_group/unlocked/Text")

	i18n = var_5

	var_2(var_2_105, var_5("tag_ship_unlocked"))

	local var_2_106 = arg_2_0._window

	arg_2_0._inputPanel = var_2.Find(var_2_106, "input_panel")

	local var_2_107 = arg_2_0._inputPanel
	local var_2_108 = var_2.Find(var_2_107, "label")
	local var_2_109 = var_2.GetComponent

	typeof = var_5
	Text = var_7
	arg_2_0._inputTitle = var_2_109(var_2_108, var_5(var_7))

	local var_2_110 = arg_2_0._inputPanel

	arg_2_0._inputTF = var_2.Find(var_2_110, "InputField")

	local var_2_111 = arg_2_0._inputTF
	local var_2_112 = var_2.GetComponent

	typeof = var_5
	InputField = var_7
	arg_2_0._inputField = var_2_112(var_2_111, var_5(var_7))

	local var_2_113 = arg_2_0._inputTF
	local var_2_114 = var_2.Find(var_2_113, "Placeholder")
	local var_2_115 = var_2.GetComponent

	typeof = var_5
	Text = var_7
	arg_2_0._placeholderTF = var_2_115(var_2_114, var_5(var_7))

	local var_2_116 = arg_2_0._inputPanel

	arg_2_0._inputConfirmBtn = var_2.Find(var_2_116, "btns/confirm_btn")

	local var_2_117 = arg_2_0._inputPanel

	arg_2_0._inputCancelBtn = var_2.Find(var_2_117, "btns/cancel_btn")

	local var_2_118 = arg_2_0._window

	arg_2_0._helpPanel = var_2.Find(var_2_118, "help_panel")

	local var_2_119 = arg_2_0._tf

	arg_2_0._helpBgTF = var_2.Find(var_2_119, "bg_help")

	local var_2_120 = arg_2_0._helpPanel

	arg_2_0._helpList = var_2.Find(var_2_120, "list")

	local var_2_121 = arg_2_0._helpPanel

	arg_2_0._helpTpl = var_2.Find(var_2_121, "list/help_tpl")

	local var_2_122 = arg_2_0._window

	arg_2_0._worldResetPanel = var_2.Find(var_2_122, "world_reset_panel")

	local var_2_123 = arg_2_0._window

	arg_2_0._worldShopBtn = var_2.Find(var_2_123, "world_shop_btn")

	local var_2_124 = arg_2_0._window

	arg_2_0._remasterPanel = var_2.Find(var_2_124, "remaster_info")

	local var_2_125 = arg_2_0._window

	arg_2_0._obtainPanel = var_2.Find(var_2_125, "obtain_panel")

	local var_2_126 = arg_2_0._window

	arg_2_0._otherPanel = var_2.Find(var_2_126, "other_panel")

	local var_2_127 = arg_2_0._window

	arg_2_0._countSelect = var_2.Find(var_2_127, "count_select")
	PageUtil = var_2

	local var_2_128 = var_2.New
	local var_2_129 = arg_2_0._countSelect
	local var_2_130 = var_4.Find(var_2_129, "value_bg/left")
	local var_2_131 = arg_2_0._countSelect
	local var_2_132 = var_5.Find(var_2_131, "value_bg/right")
	local var_2_133 = arg_2_0._countSelect
	local var_2_134 = var_6.Find(var_2_133, "max")
	local var_2_135 = arg_2_0._countSelect

	arg_2_0._pageUtil = var_2_128(var_2_130, var_2_132, var_2_134, var_7.Find(var_2_135, "value_bg/value"))

	local var_2_136 = arg_2_0._countSelect

	arg_2_0._countDescTxt = var_2.Find(var_2_136, "desc_txt")

	local var_2_137 = arg_2_0._window

	arg_2_0._sliders = var_2.Find(var_2_137, "sliders")

	local var_2_138 = arg_2_0._sliders

	arg_2_0._discountInfo = var_2.Find(var_2_138, "discountInfo")

	local var_2_139 = arg_2_0._sliders

	arg_2_0._discountDate = var_2.Find(var_2_139, "discountDate")

	local var_2_140 = arg_2_0._sliders

	arg_2_0._discount = var_2.Find(var_2_140, "discountInfo/discount")

	local var_2_141 = arg_2_0._sliders

	arg_2_0._strike = var_2.Find(var_2_141, "strike")

	local var_2_142 = arg_2_0._window
	local var_2_143 = var_2.Find(var_2_142, "stopRemind")
	local var_2_144 = var_2.GetComponent

	typeof = var_5
	Toggle = var_7
	arg_2_0.stopRemindToggle = var_2_144(var_2_143, var_5(var_7))
	tf = var_2

	local var_2_145 = var_2(arg_2_0.stopRemindToggle.gameObject)
	local var_2_146 = var_2.Find(var_2_145, "Label")
	local var_2_147 = var_2.GetComponent

	typeof = var_5
	Text = var_7
	arg_2_0.stopRemindText = var_2_147(var_2_146, var_5(var_7))

	local var_2_148 = arg_2_0._window

	arg_2_0._btnContainer = var_2.Find(var_2_148, "button_container")
	Vector2 = var_2
	arg_2_0._defaultSize = var_2(930, 620)
	Vector2 = var_2
	arg_2_0._defaultHelpSize = var_2(870, 480)
	Vector2 = var_2
	arg_2_0._defaultHelpPos = var_2(0, -40)
	arg_2_0.pools = {}
	arg_2_0.panelDict = {}
	arg_2_0.timers = {}

	return
end

function var_0_1.didEnter(arg_3_0)
	arg_3_0:showMsgBox(arg_3_0.contextData)

	return
end

function var_0_1.showMsgBox(arg_4_0, arg_4_1)
	if not arg_4_1.type then
		MSGBOX_TYPE_NORMAL = var_2
	end

	switch = var_1_10003

	local var_4_0 = var_2
	local var_4_1 = {}

	MSGBOX_TYPE_NORMAL = var_1_10007
	var_4_1[var_1_10007] = function()
		local var_5_0 = arg_4_0

		var_0.showNormalMsgBox(var_5_0, arg_4_1)

		return
	end
	MSGBOX_TYPE_HELP = var_1_10007
	var_4_1[var_1_10007] = function()
		local var_6_0 = arg_4_1

		defaultValue = var_2_10001
		var_6_0.hideNo = var_2_10001(arg_4_1.hideNo, true)

		local var_6_1 = arg_4_1

		defaultValue = var_1
		var_6_1.hideYes = var_1(arg_4_1.hideYes, true)

		local var_6_2 = arg_4_0

		var_0.showHelpWindow(var_6_2, arg_4_1)

		return
	end

	var_1_10003(var_4_0, var_4_1)

	return
end

function var_0_1.showNormalMsgBox(arg_7_0, arg_7_1)
	arg_7_0:commonSetting(arg_7_1)

	SetActive = var_2

	var_2(arg_7_0._msgPanel, true)

	local var_7_0 = arg_7_0.contentText
	local var_7_1

	if not arg_7_0.settings.alignment then
		TextAnchor = var_7_1
		var_7_1 = var_7_1.MiddleCenter
	end

	var_7_0.alignment = var_7_1

	local var_7_2 = arg_7_0.contentText
	local var_7_3

	if not arg_7_0.settings.fontSize then
		var_7_3 = 36
	end

	var_7_2.fontSize = var_7_3

	local var_7_4 = arg_7_0.contentText
	local var_7_5

	if not arg_7_0.settings.content then
		var_7_5 = ""
	end

	var_7_4.text = var_7_5

	arg_7_0:Loaded(arg_7_1)

	return
end

function var_0_1.showHelpWindow(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0

	arg_8_0.commonSetting(var_8_0, arg_8_1)

	setActive = var_2
	findTF = var_8_0

	var_2(var_8_0(arg_8_0._helpPanel, "bg"), not arg_8_1.helps.pageMode)

	setActive = var_2

	var_2(arg_8_0._helpBgTF, arg_8_1.helps.pageMode)

	setActive = var_2

	local var_8_1 = arg_8_0._helpPanel

	var_2(var_4.Find(var_8_1, "btn_blueprint"), arg_8_1.show_blueprint)

	local var_8_3

	if arg_8_1.show_blueprint then
		onButton = var_2

		local var_8_2 = arg_8_0

		var_8_3 = arg_8_0._helpPanel

		local var_8_4 = var_5.Find(var_8_3, "btn_blueprint")

		function var_8_1()
			local var_9_0 = arg_8_0

			var_0.hide(var_9_0)

			pg = var_0

			local var_9_1 = var_0.m02
			local var_9_2 = var_0.sendNotification

			GAME = var_2_10003

			local var_9_3 = var_2_10003.GO_SCENE

			SCENE = var_2_10004

			var_9_2(var_9_1, var_9_3, var_2_10004.SHIPBLUEPRINT, {
				shipGroupId = arg_8_1.show_blueprint
			})

			return
		end

		SFX_PANEL = var_8_3

		var_2(var_8_2, var_8_4, var_8_1, var_8_3)
	end

	if arg_8_1.helps.helpSize then
		local var_8_5 = arg_8_0._helpPanel

		Vector2 = var_1_10003

		local var_8_6

		if not arg_8_1.helps.helpSize.x then
			var_8_6 = arg_8_0._defaultHelpSize.x
		end

		if not arg_8_1.helps.helpSize.y then
			var_8_1 = arg_8_0._defaultHelpSize.y
		end

		var_8_5.sizeDelta = var_1_10003(var_8_6, var_8_1)
	end

	if arg_8_1.helps.helpPos then
		setAnchoredPosition = var_2

		local var_8_7 = arg_8_0._helpPanel
		local var_8_8 = {}

		if not arg_8_1.helps.helpPos.x then
			var_8_1 = arg_8_0._defaultHelpPos.x
		end

		var_8_8.x = var_8_1

		if not arg_8_1.helps.helpPos.y then
			var_8_1 = arg_8_0._defaultHelpPos.y
		end

		var_8_8.y = var_8_1

		var_2(var_8_7, var_8_8)
	end

	if arg_8_1.helps.windowSize then
		local var_8_9 = arg_8_0._window

		Vector2 = var_1_10003

		local var_8_10

		if not arg_8_1.helps.windowSize.x then
			var_8_10 = arg_8_0._defaultSize.x
		end

		if not arg_8_1.helps.windowSize.y then
			var_8_1 = arg_8_0._defaultSize.y
		end

		var_8_9.sizeDelta = var_1_10003(var_8_10, var_8_1)
	end

	local var_8_11

	if arg_8_1.helps.windowPos then
		var_8_11 = arg_8_0._window
		Vector2 = var_1_10003

		local var_8_12

		if not arg_8_1.helps.windowSize.x then
			var_8_12 = arg_8_0._defaultSize.x
		end

		if not arg_8_1.helps.windowSize.y then
			var_8_1 = arg_8_0._defaultSize.y
		end

		var_8_11.sizeDelta = var_1_10003(var_8_12, var_8_1)
		setAnchoredPosition = var_8_11

		local var_8_13 = arg_8_0._window
		local var_8_14 = {}

		if not arg_8_1.helps.windowPos.x then
			var_8_1 = 0
		end

		var_8_14.x = var_8_1

		if not arg_8_1.helps.windowPos.y then
			var_8_1 = 0
		end

		var_8_14.y = var_8_1

		var_8_11(var_8_13, var_8_14)
	else
		setAnchoredPosition = var_8_11

		var_8_11(arg_8_0._window, {
			x = 0,
			y = 0
		})
	end

	if arg_8_1.helps.buttonsHeight then
		setAnchoredPosition = var_2

		var_2(arg_8_0._btnContainer, {
			y = arg_8_1.helps.buttonsHeight
		})
	end

	if arg_8_1.helps.disableScroll then
		local var_8_15 = arg_8_0._helpPanel
		local var_8_16 = var_2.Find(var_8_15, "list")

		SetCompomentEnabled = var_1_10003
		var_8_3 = arg_8_0._helpPanel

		local var_8_17 = var_5.Find(var_8_3, "list")

		typeof = var_8_1
		ScrollRect = var_8

		var_1_10003(var_8_17, var_8_1(var_8), not arg_8_1.helps.disableScroll)

		setAnchoredPosition = var_1_10003

		local var_8_18 = var_8_16

		Vector2 = var_6

		var_1_10003(var_8_18, var_6.zero)

		setActive = var_1_10003
		findTF = var_8_18

		var_1_10003(var_8_18(arg_8_0._helpPanel, "Scrollbar"), false)
	end

	if arg_8_1.helps.ImageMode then
		setActive = var_2

		var_2(arg_8_0._top, false)

		setActive = var_2
		findTF = var_4

		var_2(var_4(arg_8_0._window, "bg"), false)
	end

	for iter_8_0 = #arg_8_0.settings.helps, arg_8_0._helpList.childCount - 1 do
		Destroy = var_8_3

		local var_8_19 = arg_8_0._helpList

		var_8_3(var_1_10009.GetChild(var_8_19, iter_8_0))
	end

	for iter_8_1 = arg_8_0._helpList.childCount, #var_2 - 1 do
		cloneTplTo = var_8_3

		var_8_3(arg_8_0._helpTpl, arg_8_0._helpList)
	end

	ipairs = var_3

	for iter_8_2, iter_8_3 in var_3(var_2) do
		local var_8_20 = arg_8_0._helpList
		local var_8_21 = var_8.GetChild(var_8_20, iter_8_2 - 1)

		setActive = var_1_10009

		var_1_10009(var_8_21, true)

		var_1_10009 = var_8_21:Find("icon")
		setActive = var_8_20

		var_8_20(var_1_10009, iter_8_3.icon)

		setActive = var_8_20
		findTF = var_12

		var_8_20(var_12(var_8_21, "line"), iter_8_3.line)

		local var_8_24

		if iter_8_3.icon then
			local var_8_22 = 1

			if arg_8_1.helps.ImageMode then
				var_8_22 = 1.5
			end

			local var_8_23 = var_1_10009.transform

			Vector2 = var_12

			if not iter_8_3.icon.scale then
				var_8_24 = var_8_22
			end

			local var_8_25

			if not iter_8_3.icon.scale then
				var_8_25 = var_8_22
			end

			var_8_23.localScale = var_12(var_8_24, var_8_25)

			local var_8_26 = iter_8_3.icon.path
			local var_8_27

			if not iter_8_3.icon.posX or not iter_8_3.icon.posX then
				var_8_27 = -20
			end

			local var_8_28

			if not iter_8_3.icon.posY or not iter_8_3.icon.posY then
				var_8_28 = 0
			end

			LoadSprite = var_8_24
			var_8_24 = var_8_24(iter_8_3.icon.atlas, iter_8_3.icon.path)
			setImageSprite = var_8_25

			local var_8_29 = var_1_10009
			local var_8_30 = var_1_10009.GetComponent

			typeof = var_1_10020
			Image = var_1_10022

			var_8_25(var_8_30(var_8_29, var_1_10020(var_1_10022)), var_8_24, true)

			setAnchoredPosition = var_8_25

			var_8_25(var_1_10009, {
				x = var_8_27,
				y = var_8_28
			})

			setActive = var_8_25

			var_8_25(var_1_10009:Find("corner"), arg_8_1.helps.pageMode)
		end

		local var_8_31 = var_8_21:Find("richText")
		local var_8_32 = var_10.GetComponent(var_8_31, "RichText")
		local var_8_33

		if iter_8_3.rawIcon then
			var_8_33 = iter_8_3.rawIcon.name
			var_8_24 = var_8_32

			local var_8_34 = var_8_32.AddSprite
			local var_8_35 = var_8_33

			GetSpriteFromAtlas = var_1_10016

			var_8_34(var_8_24, var_8_35, var_1_10016(iter_8_3.rawIcon.atlas, var_8_33))

			HXSet = var_8_34

			local var_8_36 = var_8_34.hxLan

			if not iter_8_3.info then
				var_8_24 = ""
			end

			local var_8_37 = var_8_36(var_8_24)

			setText = var_13

			var_13(var_8_21, "")

			string = var_13
			var_8_32.text = var_13.format("<icon name=%s w=0.7 h=0.7/>%s", var_8_33, var_8_37)

			goto label_8_0
		end

		setText = var_8_33

		local var_8_38 = var_8_21

		HXSet = var_8_24

		local var_8_39 = var_8_24.hxLan

		if iter_8_3.info then
			SwitchSpecialChar = var_1_10016

			if not var_1_10016(iter_8_3.info, true) then
				var_1_10016 = ""
			end

			var_8_33(var_8_38, var_8_39(var_1_10016))

			::label_8_0::

			setActive = var_8_33

			var_8_33(var_8_32.gameObject, iter_8_3.rawIcon)
		end
	end

	local var_8_40

	if not arg_8_1.helps.defaultpage then
		var_8_40 = 1
	end

	arg_8_0.helpPage = var_8_40

	if arg_8_1.helps.pageMode then
		arg_8_0:switchHelpPage(arg_8_0.helpPage)
	end

	arg_8_0:Loaded(arg_8_1)

	return
end

function var_0_1.switchHelpPage(arg_10_0, arg_10_1)
	for iter_10_0 = 1, arg_10_0._helpList.childCount do
		local var_10_0 = arg_10_0._helpList
		local var_10_1 = var_6.GetChild(var_10_0, iter_10_0 - 1)

		setActive = var_1_10007

		var_1_10007(var_10_1, arg_10_1 == iter_10_0)

		setText = var_1_10007

		var_1_10007(var_10_1:Find("icon/corner/Text"), iter_10_0)
	end

	return
end

function var_0_1.commonSetting(arg_11_0, arg_11_1)
	rtf = var_1_10002

	local var_11_0 = var_1_10002(arg_11_0._window)

	var_11_0.sizeDelta = arg_11_0._defaultSize
	rtf = var_11_0
	var_11_0(arg_11_0._helpPanel).sizeDelta = arg_11_0._defaultHelpSize
	arg_11_0.enable = true
	setActive = var_2

	var_2(arg_11_0._msgPanel, false)

	setActive = var_2

	var_2(arg_11_0._exchangeShipPanel, false)

	setActive = var_2

	var_2(arg_11_0._itemPanel, false)

	setActive = var_2

	var_2(arg_11_0._sigleItemPanel, false)

	setActive = var_2

	var_2(arg_11_0._inputPanel, false)

	setActive = var_2

	var_2(arg_11_0._obtainPanel, false)

	setActive = var_2

	var_2(arg_11_0._otherPanel, false)

	setActive = var_2

	var_2(arg_11_0._worldResetPanel, false)

	setActive = var_2

	var_2(arg_11_0._worldShopBtn, false)

	setActive = var_2

	var_2(arg_11_0._helpBgTF, false)

	setActive = var_2

	var_2(arg_11_0._helpPanel, arg_11_1.helps)

	pairs = var_2

	for iter_11_0, iter_11_1 in var_2(arg_11_0.panelDict) do
		local var_11_1 = iter_11_1.buffer

		var_7.Hide(var_11_1)
	end

	setActive = var_2

	var_2(arg_11_0._btnContainer, true)

	local var_11_2 = arg_11_0.stopRemindToggle
	local var_11_3

	if not arg_11_1.toggleStatus then
		var_11_3 = false
	end

	var_11_2.isOn = var_11_3
	setActive = var_11_2
	go = var_4

	var_11_2(var_4(arg_11_0.stopRemindToggle), arg_11_1.showStopRemind)

	local var_11_4 = arg_11_0.stopRemindText
	local var_11_5

	if not arg_11_1.stopRamindContent then
		i18n = var_11_5
		var_11_5 = var_11_5("dont_remind_today")
	end

	var_11_4.text = var_11_5
	removeAllChildren = var_11_4

	var_11_4(arg_11_0._btnContainer)

	arg_11_0.settings = arg_11_1
	SetActive = var_11_4

	var_11_4(arg_11_0._go, true)

	local var_11_6

	if not arg_11_0.settings.needCounter then
		var_11_6 = false
	end

	setActive = var_11_5

	var_11_5(arg_11_0._countSelect, var_11_6)

	local var_11_7 = arg_11_0.settings.numUpdate
	local var_11_8

	if not arg_11_0.settings.addNum then
		var_11_8 = 1
	end

	local var_11_9

	if not arg_11_0.settings.maxNum then
		var_11_9 = -1
	end

	local var_11_10

	if not arg_11_0.settings.defaultNum then
		var_11_10 = 1
	end

	local var_11_11 = arg_11_0._pageUtil

	var_7.setNumUpdate(var_11_11, function(arg_12_0)
		if var_11_7 ~= nil then
			var_11_7(arg_11_0._countDescTxt, arg_12_0)
		end

		return
	end)

	local var_11_12 = arg_11_0._pageUtil

	var_7.setAddNum(var_11_12, var_11_8)

	local var_11_13 = arg_11_0._pageUtil

	var_7.setMaxNum(var_11_13, var_11_9)

	local var_11_14 = arg_11_0._pageUtil

	var_7.setDefaultNum(var_11_14, var_11_10)

	setActive = var_7

	var_7(arg_11_0._sliders, arg_11_0.settings.discount)

	local var_11_16

	if arg_11_0.settings.discount then
		local var_11_15 = arg_11_0._discount

		var_11_16 = var_11_16.GetComponent
		typeof = var_10
		Text = var_1_10012
		var_11_16 = var_11_16(var_11_15, var_10(var_1_10012))
		var_11_16.text = arg_11_0.settings.discount.discount .. "%OFF"

		local var_11_17 = arg_11_0._discountDate

		var_11_16 = var_11_16.GetComponent
		typeof = var_10
		Text = var_1_10012
		var_11_16 = var_11_16(var_11_17, var_10(var_1_10012))
		var_11_16.text = arg_11_0.settings.discount.date
	end

	setActive = var_11_16

	var_11_16(arg_11_0._remasterPanel, arg_11_0.settings.remaster)

	if arg_11_0.settings.remaster then
		local var_11_18 = arg_11_0.settings.remaster

		setText = var_1_10008
		var_1_10012 = arg_11_0._remasterPanel

		var_1_10008(var_10.Find(var_1_10012, "content/Text"), var_11_18.word)

		setText = var_1_10008
		var_1_10012 = arg_11_0._remasterPanel

		local var_11_19 = var_10.Find(var_1_10012, "content/count")
		local var_11_20

		if not var_11_18.number then
			var_11_20 = ""
		end

		var_1_10008(var_11_19, var_11_20)

		setText = var_1_10008
		var_1_10012 = arg_11_0._remasterPanel

		var_1_10008(var_10.Find(var_1_10012, "btn/pic"), var_11_18.btn_text)

		onButton = var_1_10008

		local var_11_21 = arg_11_0
		local var_11_22 = arg_11_0._remasterPanel

		var_1_10008(var_11_21, var_11.Find(var_11_22, "btn"), function()
			if var_11_18.btn_call then
				var_11_18.btn_call()
			end

			local var_13_0 = arg_11_0

			var_0.hide(var_13_0)

			return
		end)
	end

	local var_11_23

	if not arg_11_0.settings.hideNo then
		var_11_23 = false
	end

	local var_11_24

	if not arg_11_0.settings.hideYes then
		var_11_24 = false
	end

	local var_11_25

	if not arg_11_0.settings.modal then
		var_11_25 = false
	end

	local var_11_26

	if not arg_11_0.settings.onYes then
		function var_11_26()
			return
		end
	end

	local var_11_27

	if not arg_11_0.settings.onNo then
		function var_11_27()
			return
		end
	end

	onButton = var_1_10012

	local var_11_28 = arg_11_0

	tf = var_1_10015

	local var_11_29 = var_1_10015(arg_11_0._go)
	local var_11_30 = var_15.Find(var_11_29, "bg")

	local function var_11_31()
		if arg_11_0.settings.onClose then
			arg_11_0.settings.onClose()
		else
			var_11_27()
		end

		local var_16_0 = arg_11_0

		var_0.hide(var_16_0)

		return
	end

	SFX_CANCEL = var_11_29

	var_1_10012(var_11_28, var_11_30, var_11_31, var_11_29)

	SetCompomentEnabled = var_1_10012
	tf = var_11_28

	local var_11_32 = var_11_28(arg_11_0._go)
	local var_11_33 = var_14.Find(var_11_32, "bg")

	typeof = var_11_30
	Button = var_17

	var_1_10012(var_11_33, var_11_30(var_17), not var_11_25)

	local var_11_34
	local var_11_35

	if not var_11_23 then
		local var_11_36 = arg_11_0
		local var_11_37 = arg_11_0.createBtn
		local var_11_38 = {}
		local var_11_39

		if not arg_11_0.settings.noText then
			var_11_39 = var_0_1.TEXT_CANCEL
		end

		var_11_38.text = var_11_39

		local var_11_40

		if not arg_11_0.settings.noBtnType then
			var_11_40 = var_0_1.BUTTON_GRAY
		end

		var_11_38.btnType = var_11_40
		var_11_38.onCallback = var_11_27

		if not arg_11_1.noSound then
			SFX_CANCEL = var_18
		end

		var_11_38.sound = var_18

		local var_11_41 = var_11_37(var_11_36, var_11_38)
	end

	if not var_11_24 then
		local var_11_42 = arg_11_0
		local var_11_43 = arg_11_0.createBtn
		local var_11_44 = {}
		local var_11_45

		if not arg_11_0.settings.yesText then
			var_11_45 = var_0_1.TEXT_CONFIRM
		end

		var_11_44.text = var_11_45

		local var_11_46

		if not arg_11_0.settings.yesBtnType then
			var_11_46 = var_0_1.BUTTON_BLUE
		end

		var_11_44.btnType = var_11_46
		var_11_44.onCallback = var_11_26

		if not arg_11_1.yesSound then
			SFX_CONFIRM = var_18
		end

		var_11_44.sound = var_18

		local var_11_47

		if arg_11_0.settings.yesSize then
			TextAnchor = var_11_47
			var_11_47 = var_11_47.MiddleCenter
		end

		var_11_44.alignment = var_11_47
		var_11_35 = var_11_43(var_11_42, var_11_44)

		if arg_11_0.settings.yesSize then
			var_11_35.sizeDelta = arg_11_0.settings.yesSize
		end

		setGray = var_14

		var_14(var_11_35, arg_11_0.settings.yesGray, true)
	end

	if arg_11_0.settings.yseBtnLetf then
		var_11_35:SetAsFirstSibling()
	end

	if arg_11_0.settings.custom ~= nil then
		ipairs = var_14

		for iter_11_2, iter_11_3 in var_14(arg_11_0.settings.custom) do
			arg_11_0:createBtn(iter_11_3)
		end
	end

	setActive = var_14

	var_14(arg_11_0._closeBtn, not arg_11_1.hideClose)

	onButton = var_14

	local var_11_48 = arg_11_0
	local var_11_49 = arg_11_0._closeBtn

	local function var_11_50()
		local var_17_0 = arg_11_0.settings.onClose

		if arg_11_0.settings and arg_11_0.settings.hideClose and not var_17_0 and arg_11_0.settings.onYes then
			arg_11_0.settings.onYes()
		end

		local var_17_1 = arg_11_0

		var_1.hide(var_17_1)

		if var_17_0 then
			var_17_0()
		else
			var_11_27()
		end

		return
	end

	SFX_CANCEL = var_1_10019

	var_14(var_11_48, var_11_49, var_11_50, var_1_10019)

	local var_11_51

	if not arg_11_0.settings.title then
		var_11_51 = var_0_1.TITLE_INFORMATION
	end

	local var_11_52 = 0
	local var_11_53 = arg_11_0._titleList.transform.childCount

	while var_11_52 < var_11_53 do
		var_1_10019 = arg_11_0._titleList.transform

		local var_11_54 = var_17.GetChild(var_1_10019, var_11_52)

		SetActive = var_11_50

		var_11_50(var_11_54, var_11_54.name == var_11_51)

		var_11_52 = var_11_52 + 1
	end

	local var_11_55 = arg_11_0._go.transform.localPosition
	local var_11_56 = arg_11_0._go.transform

	Vector3 = var_1_10019

	local var_11_57 = var_11_55.x
	local var_11_58 = var_11_55.y
	local var_11_59

	if not arg_11_0.settings.zIndex then
		var_11_59 = 0
	end

	var_11_56.localPosition = var_1_10019(var_11_57, var_11_58, var_11_59)

	local var_11_60

	if not arg_11_0.settings.locked then
		var_11_60 = false
	end

	arg_11_0.locked = var_11_60

	arg_11_0:AddSprites()

	return
end

function var_0_1.AddSprites(arg_18_0)
	local var_18_0 = arg_18_0.contextData

	table = var_1_10002

	local var_18_1 = var_1_10002.Foreach
	local var_18_2

	if not var_18_0.contextSprites then
		var_18_2 = {}
	end

	var_18_1(var_18_2, function(arg_19_0, arg_19_1)
		local var_19_0 = arg_18_0.contentText
		local var_19_1 = var_2.AddSprite
		local var_19_2 = arg_19_1.name

		LoadSprite = var_2_10006

		var_19_1(var_19_0, var_19_2, var_2_10006(arg_19_1.path, arg_19_1.name))

		return
	end)

	return
end

function var_0_1.createBtn(arg_20_0, arg_20_1)
	local var_20_0

	if not arg_20_1.btnType then
		var_20_0 = var_0_1.BUTTON_BLUE
	end

	local var_20_1 = arg_20_1.noQuit
	local var_20_2 = arg_20_0._go.transform
	local var_20_3 = var_4.Find(var_20_2, "custom_btn_list/custom_button_" .. var_20_0)

	cloneTplTo = var_1_10005

	local var_20_4 = var_1_10005(var_20_3, arg_20_0._btnContainer)
	local var_20_5

	if arg_20_1.label then
		go = var_20_5
		var_20_5 = var_20_5(var_20_4)
		var_20_5.name = arg_20_1.label
	end

	SetActive = var_20_5

	var_20_5(var_20_4, true)

	local var_20_7

	if arg_20_1.scale then
		local var_20_6

		if not arg_20_1.scale.x then
			var_20_6 = 1
		end

		if not arg_20_1.scale.y then
			var_20_7 = 1
		end

		Vector2 = var_8
		var_20_4.localScale = var_8(var_20_6, var_20_7)
	end

	if var_20_0 == var_0_1.BUTTON_MEDAL then
		setText = var_6
		var_1_10010 = var_20_4

		var_6(var_20_4.Find(var_1_10010, "text"), arg_20_1.text)
	elseif var_20_0 ~= var_0_1.BUTTON_RETREAT and var_20_0 ~= var_0_1.BUTTON_PREPAGE and var_20_0 ~= var_0_1.BUTTON_NEXTPAGE then
		arg_20_0:updateButton(var_20_4, arg_20_1.text, arg_20_1.alignment)
	end

	if var_20_0 == var_0_1.BUTTON_BLUE_WITH_ICON and arg_20_1.iconName then
		local var_20_8

		var_20_8, setImageSprite = var_20_4:Find("ticket/icon"), var_20_7
		LoadSprite = var_1_10010

		var_20_7(var_20_8, var_1_10010(arg_20_1.iconName[1], arg_20_1.iconName[2]))
	end

	if not arg_20_1.hideEvent then
		onButton = var_6

		local var_20_9 = arg_20_0
		local var_20_10 = var_20_4

		local function var_20_11()
			type = var_2_10000

			if var_2_10000(var_20_1) == "function" then
				if var_20_1() then
					return
				else
					local var_21_0 = arg_20_0

					var_0.hide(var_21_0)
				end
			elseif not var_20_1 then
				local var_21_1 = arg_20_0

				var_0.hide(var_21_1)
			end

			existCall = var_0

			return var_0(arg_20_1.onCallback)
		end

		if not arg_20_1.sound then
			SFX_CONFIRM = var_11
		end

		var_6(var_20_9, var_20_10, var_20_11, var_11)
	end

	if arg_20_1.sibling then
		var_20_4:SetSiblingIndex(arg_20_1.sibling)
	end

	return var_20_4
end

function var_0_1.updateButton(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	local var_22_0 = var_0_2[arg_22_2]
	local var_22_1 = arg_22_1:Find("pic")

	IsNil = var_1_10006

	if var_1_10006(var_22_1) then
		return
	end

	if var_22_0 then
		setText = var_6

		local var_22_2 = var_22_1

		i18n = var_1_10009

		var_6(var_22_2, var_1_10009(var_22_0))
	else
		string = var_6

		local var_22_4

		if var_6.len(arg_22_2) > 12 then
			GetComponent = var_22_4

			local var_22_3 = var_22_1

			typeof = var_1_10009
			Text = var_1_10011
			var_22_4 = var_22_4(var_22_3, var_1_10009(var_1_10011))
			var_22_4.resizeTextForBestFit = true
		end

		setText = var_22_4

		var_22_4(var_22_1, arg_22_2)
	end

	if arg_22_3 then
		local var_22_5 = var_22_1
		local var_22_6 = var_22_1.GetComponent

		typeof = var_1_10009
		Text = var_1_10011
		var_22_6(var_22_5, var_1_10009(var_1_10011)).alignment = arg_22_3
	end

	return
end

function var_0_1.Loaded(arg_23_0, arg_23_1)
	pg = var_1_10002

	local var_23_0 = var_1_10002.UIMgr.GetInstance()

	var_2.BlurPanel(var_23_0, arg_23_0._tf, {
		groupName = arg_23_1.groupName,
		parent = arg_23_1.parent
	})

	pg = var_2

	local var_23_1 = var_2.m02
	local var_23_2 = var_2.sendNotification

	GAME = var_5

	var_23_2(var_23_1, var_5.OPEN_MSGBOX_DONE)

	return
end

function var_0_1.Clear(arg_24_0)
	pairs = var_1_10001

	for iter_24_0, iter_24_1 in var_1_10001(arg_24_0.panelDict) do
		var_1_10008 = iter_24_1

		iter_24_1.Destroy(var_1_10008)
	end

	table = var_1

	var_1.clear(arg_24_0.panelDict)

	rtf = var_1

	local var_24_0 = var_1(arg_24_0._window)

	var_24_0.sizeDelta = arg_24_0._defaultSize
	rtf = var_24_0

	local var_24_1 = var_24_0(arg_24_0._helpPanel)

	var_24_1.sizeDelta = arg_24_0._defaultHelpSize
	setAnchoredPosition = var_24_1

	var_24_1(arg_24_0._window, {
		x = 0,
		y = 0
	})

	setAnchoredPosition = var_24_1

	var_24_1(arg_24_0._btnContainer, {
		y = 15
	})

	setAnchoredPosition = var_24_1

	var_24_1(arg_24_0._helpPanel, {
		x = arg_24_0._defaultHelpPos.x,
		y = arg_24_0._defaultHelpPos.y
	})

	SetCompomentEnabled = var_24_1

	local var_24_2 = arg_24_0._helpPanel
	local var_24_3 = var_3.Find(var_24_2, "list")

	typeof = var_4
	ScrollRect = var_6

	var_24_1(var_24_3, var_4(var_6), true)

	setActive = var_24_1

	var_24_1(arg_24_0._top, true)

	setActive = var_24_1
	findTF = var_3

	var_24_1(var_3(arg_24_0._window, "bg"), true)

	setActive = var_24_1

	local var_24_4 = arg_24_0._sigleItemPanel

	var_24_1(var_3.Find(var_24_4, "left/own"), false)

	local var_24_5 = arg_24_0._sigleItemPanel
	local var_24_6 = var_1.Find(var_24_5, "left/IconTpl")

	SetCompomentEnabled = var_2

	local var_24_7 = var_24_6:Find("icon_bg")

	typeof = var_24_4
	Image = var_7

	var_2(var_24_7, var_24_4(var_7), true)

	SetCompomentEnabled = var_2

	local var_24_8 = var_24_6:Find("icon_bg/frame")

	typeof = var_5
	Image = var_7

	var_2(var_24_8, var_5(var_7), true)

	setActive = var_2

	var_2(var_24_6:Find("icon_bg/slv"), false)

	findTF = var_2

	local var_24_9 = var_2(var_24_6, "icon_bg/icon")

	Vector2 = var_24_5
	var_24_9.pivot = var_24_5(0.5, 0.5)
	Vector2 = var_3
	var_24_9.sizeDelta = var_3(-4, -4)
	Vector2 = var_3
	var_24_9.anchoredPosition = var_3(0, 0)
	setActive = var_3

	var_3(arg_24_0.singleItemIntro, false)

	setText = var_3

	var_3(arg_24_0._singleItemSubIntroTF, "")

	for iter_24_2 = 0, arg_24_0._helpList.childCount - 1 do
		local var_24_10 = arg_24_0._helpList
		local var_24_11 = var_7.GetChild(var_24_10, iter_24_2)
		local var_24_12 = var_7.Find(var_24_11, "icon")
		local var_24_13 = var_7.GetComponent

		typeof = var_10
		Image = var_1_10012
		var_24_13(var_24_12, var_10(var_1_10012)).sprite = nil
	end

	pairs = var_3

	for iter_24_3, iter_24_4 in var_3(arg_24_0.pools) do
		if iter_24_4 then
			PoolMgr = var_1_10008

			local var_24_14 = var_1_10008.GetInstance()

			var_1_10008.ReturnUI(var_24_14, iter_24_4.name, iter_24_4)
		end
	end

	arg_24_0.pools = {}
	pairs = var_3

	for iter_24_5, iter_24_6 in var_3(arg_24_0.timers) do
		iter_24_6:Stop()
	end

	arg_24_0.timers = {}
	removeAllChildren = var_3

	var_3(arg_24_0._btnContainer)

	local var_24_15 = arg_24_0.contentText

	var_3.RemoveAllListeners(var_24_15)

	arg_24_0.settings = nil
	arg_24_0.enable = false
	arg_24_0.locked = nil

	return
end

function var_0_1.willExit(arg_25_0)
	local var_25_0 = arg_25_0._pageUtil

	var_1.Dispose(var_25_0)

	return
end

function var_0_1.hide(arg_26_0)
	if not arg_26_0.enable then
		return
	end

	arg_26_0:Clear()
	arg_26_0:closeView()

	pg = var_1

	local var_26_0 = var_1.m02
	local var_26_1 = var_1.sendNotification

	GAME = var_1_10004

	var_26_1(var_26_0, var_1_10004.CLOSE_MSGBOX_DONE)

	return
end

return var_0_1
