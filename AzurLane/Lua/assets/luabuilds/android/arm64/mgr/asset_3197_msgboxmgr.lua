pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
singletonClass = var_0_10001
var_0.MsgboxMgr = var_0_10001("MsgboxMgr")
var_1.BUTTON_BLUE = 1
var_1.BUTTON_GRAY = 2
var_1.BUTTON_RED = 3
var_1.BUTTON_MEDAL = 4
var_1.BUTTON_RETREAT = 5
var_1.BUTTON_PREPAGE = 6
var_1.BUTTON_NEXTPAGE = 7
var_1.BUTTON_BLUE_WITH_ICON = 8
var_1.BUTTON_YELLOW = 9
var_1.TITLE_INFORMATION = "infomation"
var_1.TITLE_SETTING = "setting"
var_1.TITLE_WARNING = "warning"
var_1.TITLE_OBTAIN = "obtain"
var_1.TITLE_CADPA = "cadpa"
var_1.TEXT_CANCEL = "text_cancel"
var_1.TEXT_CONFIRM = "text_confirm"

local var_0_1 = 1
local var_0_2 = MSGBOX_TYPE_NORMAL
local var_0_3 = 2
local var_0_4 = MSGBOX_TYPE_INPUT
local var_0_5 = 3
local var_0_6 = MSGBOX_TYPE_SINGLE_ITEM
local var_0_7 = 4
local var_0_8 = MSGBOX_TYPE_EXCHANGE
local var_0_9 = 5
local var_0_10 = MSGBOX_TYPE_DROP_ITEM
local var_0_11 = 6
local var_0_12 = MSGBOX_TYPE_ITEM_BOX
local var_0_13 = 7
local var_0_14 = MSGBOX_TYPE_HELP
local var_0_15 = 8
local var_0_16 = MSGBOX_TYPE_SECONDPWD
local var_0_17 = 9
local var_0_18 = MSGBOX_TYPE_OBTAIN
local var_0_19 = 10
local var_0_20 = MSGBOX_TYPE_ITEMTIP
local var_0_21 = 11
local var_0_22 = MSGBOX_TYPE_JUST_FOR_SHOW
local var_0_23 = 12
local var_0_24 = MSGBOX_TYPE_MONTH_CARD_TIP
local var_0_25 = 13
local var_0_26 = MSGBOX_TYPE_WORLD_RESET
local var_0_27 = 14
local var_0_28 = MSGBOX_TYPE_WORLD_STAMINA_EXCHANGE
local var_0_29 = 15
local var_0_30 = MSGBOX_TYPE_STORY_CANCEL_TIP
local var_0_31 = 16
local var_0_32 = MSGBOX_TYPE_META_SKILL_UNLOCK
local var_0_33 = 17
local var_0_34 = MSGBOX_TYPE_CONFIRM_REFORGE_SPWEAPON
local var_0_35 = 18
local var_0_36 = MSGBOX_TYPE_ACCOUNTDELETE
local var_0_37 = 19
local var_0_38 = MSGBOX_TYPE_STRENGTHEN_BACK
local var_0_39 = 20
local var_0_40 = MSGBOX_TYPE_CONTENT_ITEMS
local var_0_41 = 21
local var_0_42 = MSGBOX_TYPE_BLUEPRINT_UNLOCK_ITEM
local var_0_43 = 22
local var_0_44 = MSGBOX_TYPE_CONFIRM_DELETE
local var_0_45 = 23
local var_0_46 = MSGBOX_TYPE_SUBPATTERN
local var_0_47 = 24
local var_0_48 = MSGBOX_TYPE_FILE_DOWNLOAD
local var_0_49 = 25
local var_0_50 = MSGBOX_TYPE_LIKN_COLLECT_GUIDE
local var_0_51 = 26
local var_0_52 = MSGBOX_TYPE_DROP_ITEM_ESKIN

var_1.enable = false
require = var_2

local var_0_53 = var_2("Mgr.const.MsgboxBtnNameMap")

function var_1.Init(arg_1_0, arg_1_1)
	print = var_1_10002

	var_1_10002("initializing msgbox manager...")

	LoadAndInstantiateAsync = var_1_10002

	var_1_10002("ui", "MsgBox", function(arg_2_0)
		arg_1_0._go = arg_2_0

		local var_2_0 = arg_1_0._go

		var_1.SetActive(var_2_0, false)

		arg_1_0._tf = arg_1_0._go.transform

		local var_2_1 = arg_1_0._tf

		var_1.SetParent(var_2_1, var_0.UIMgr.GetInstance().OverlayMain, false)

		local var_2_2 = arg_1_0
		local var_2_3 = arg_1_0._tf

		var_2_2._window = var_2.Find(var_2_3, "window")
		setActive = var_2_2

		var_2_2(arg_1_0._window, true)

		local var_2_4 = arg_1_0
		local var_2_5 = arg_1_0._window

		var_2_4._top = var_2.Find(var_2_5, "top")

		local var_2_6 = arg_1_0
		local var_2_7 = arg_1_0._top

		var_2_6._titleList = var_2.Find(var_2_7, "bg")

		local var_2_8 = arg_1_0
		local var_2_9 = arg_1_0._top

		var_2_8._closeBtn = var_2.Find(var_2_9, "btnBack")
		setText = var_2_8

		local var_2_10 = arg_1_0._titleList
		local var_2_11 = var_3.Find(var_2_10, "infomation/title")

		i18n = var_2_9

		var_2_8(var_2_11, var_2_9("words_information"))

		setText = var_2_8

		local var_2_12 = arg_1_0._titleList
		local var_2_13 = var_3.Find(var_2_12, "cadpa/title")

		i18n = var_4

		var_2_8(var_2_13, var_4("cadpa_tip1"))

		local var_2_14 = arg_1_0
		local var_2_15 = arg_1_0._tf

		var_2_14._res = var_2.Find(var_2_15, "res")

		local var_2_16 = arg_1_0
		local var_2_17 = arg_1_0._window

		var_2_16._msgPanel = var_2.Find(var_2_17, "msg_panel")

		local var_2_18 = arg_1_0
		local var_2_19 = arg_1_0._msgPanel
		local var_2_20 = var_2.Find(var_2_19, "content")

		var_2_18.contentText = var_2.GetComponent(var_2_20, "RichText")

		local var_2_21 = arg_1_0.contentText
		local var_2_22 = var_1.AddSprite
		local var_2_23 = "diamond"
		local var_2_24 = arg_1_0._res
		local var_2_25 = var_5.Find(var_2_24, "diamond")
		local var_2_26 = var_5.GetComponent

		typeof = var_8
		Image = var_2_10010

		var_2_22(var_2_21, var_2_23, var_2_26(var_2_25, var_8(var_2_10010)).sprite)

		local var_2_27 = arg_1_0.contentText
		local var_2_28 = var_1.AddSprite
		local var_2_29 = "gold"
		local var_2_30 = arg_1_0._res
		local var_2_31 = var_5.Find(var_2_30, "gold")
		local var_2_32 = var_5.GetComponent

		typeof = var_8
		Image = var_2_10010

		var_2_28(var_2_27, var_2_29, var_2_32(var_2_31, var_8(var_2_10010)).sprite)

		local var_2_33 = arg_1_0.contentText
		local var_2_34 = var_1.AddSprite
		local var_2_35 = "oil"
		local var_2_36 = arg_1_0._res
		local var_2_37 = var_5.Find(var_2_36, "oil")
		local var_2_38 = var_5.GetComponent

		typeof = var_8
		Image = var_2_10010

		var_2_34(var_2_33, var_2_35, var_2_38(var_2_37, var_8(var_2_10010)).sprite)

		local var_2_39 = arg_1_0.contentText
		local var_2_40 = var_1.AddSprite
		local var_2_41 = "world_money"
		local var_2_42 = arg_1_0._res
		local var_2_43 = var_5.Find(var_2_42, "world_money")
		local var_2_44 = var_5.GetComponent

		typeof = var_8
		Image = var_2_10010

		var_2_40(var_2_39, var_2_41, var_2_44(var_2_43, var_8(var_2_10010)).sprite)

		local var_2_45 = arg_1_0.contentText
		local var_2_46 = var_1.AddSprite
		local var_2_47 = "port_money"
		local var_2_48 = arg_1_0._res
		local var_2_49 = var_5.Find(var_2_48, "port_money")
		local var_2_50 = var_5.GetComponent

		typeof = var_8
		Image = var_2_10010

		var_2_46(var_2_45, var_2_47, var_2_50(var_2_49, var_8(var_2_10010)).sprite)

		local var_2_51 = arg_1_0.contentText
		local var_2_52 = var_1.AddSprite
		local var_2_53 = "guildicon"
		local var_2_54 = arg_1_0._res
		local var_2_55 = var_5.Find(var_2_54, "guildicon")
		local var_2_56 = var_5.GetComponent

		typeof = var_8
		Image = var_2_10010

		var_2_52(var_2_51, var_2_53, var_2_56(var_2_55, var_8(var_2_10010)).sprite)

		local var_2_57 = arg_1_0
		local var_2_58 = arg_1_0._window

		var_2_57._exchangeShipPanel = var_2.Find(var_2_58, "exchange_ship_panel")

		local var_2_59 = arg_1_0
		local var_2_60 = arg_1_0._window

		var_2_59._itemPanel = var_2.Find(var_2_60, "item_panel")

		local var_2_61 = arg_1_0
		local var_2_62 = arg_1_0._itemPanel
		local var_2_63 = var_2.Find(var_2_62, "Text")
		local var_2_64 = var_2.GetComponent

		typeof = var_5
		Text = var_2_55
		var_2_61._itemText = var_2_64(var_2_63, var_5(var_2_55))

		local var_2_65 = arg_1_0
		local var_2_66 = arg_1_0._itemPanel

		var_2_65._itemListItemContainer = var_2.Find(var_2_66, "scrollview/list")

		local var_2_67 = arg_1_0
		local var_2_68 = arg_1_0._itemListItemContainer

		var_2_67._itemListItemTpl = var_2.Find(var_2_68, "item")

		local var_2_69 = arg_1_0
		local var_2_70 = arg_1_0._window

		var_2_69._eskinPanel = var_2.Find(var_2_70, "eskin_panel")

		local var_2_71 = arg_1_0
		local var_2_72 = arg_1_0._eskinPanel
		local var_2_73 = var_2.Find(var_2_72, "Text")
		local var_2_74 = var_2.GetComponent

		typeof = var_5
		Text = var_2_55
		var_2_71._eskinText = var_2_74(var_2_73, var_5(var_2_55))

		local var_2_75 = arg_1_0
		local var_2_76 = arg_1_0._eskinPanel

		var_2_75._eskinListItemContainer = var_2.Find(var_2_76, "scrollview/list")

		local var_2_77 = arg_1_0
		local var_2_78 = arg_1_0._eskinListItemContainer

		var_2_77._eskinListItemTpl = var_2.Find(var_2_78, "item")

		local var_2_79 = arg_1_0
		local var_2_80 = arg_1_0._window

		var_2_79._sigleItemPanel = var_2.Find(var_2_80, "single_item_panel")

		local var_2_81 = arg_1_0
		local var_2_82 = arg_1_0._sigleItemPanel

		var_2_81._singleItemshipTypeTF = var_2.Find(var_2_82, "display_panel/name_container/shiptype")

		local var_2_83 = arg_1_0
		local var_2_84 = arg_1_0._sigleItemPanel

		var_2_83.singleItemIntro = var_2.Find(var_2_84, "display_panel/desc/Text")

		local var_2_85 = arg_1_0.singleItemIntro
		local var_2_86 = var_1.GetComponent(var_2_85, "RichText")
		local var_2_87 = var_1.AddSprite
		local var_2_88 = "diamond"
		local var_2_89 = arg_1_0._res
		local var_2_90 = var_6.Find(var_2_89, "diamond")
		local var_2_91 = var_6.GetComponent

		typeof = var_9
		Image = var_2_10011

		var_2_87(var_2_86, var_2_88, var_2_91(var_2_90, var_9(var_2_10011)).sprite)

		local var_2_92 = var_1
		local var_2_93 = var_1.AddSprite
		local var_2_94 = "gold"
		local var_2_95 = arg_1_0._res
		local var_2_96 = var_6.Find(var_2_95, "gold")
		local var_2_97 = var_6.GetComponent

		typeof = var_9
		Image = var_2_10011

		var_2_93(var_2_92, var_2_94, var_2_97(var_2_96, var_9(var_2_10011)).sprite)

		local var_2_98 = var_1
		local var_2_99 = var_1.AddSprite
		local var_2_100 = "oil"
		local var_2_101 = arg_1_0._res
		local var_2_102 = var_6.Find(var_2_101, "oil")
		local var_2_103 = var_6.GetComponent

		typeof = var_9
		Image = var_2_10011

		var_2_99(var_2_98, var_2_100, var_2_103(var_2_102, var_9(var_2_10011)).sprite)

		local var_2_104 = var_1
		local var_2_105 = var_1.AddSprite
		local var_2_106 = "world_money"
		local var_2_107 = arg_1_0._res
		local var_2_108 = var_6.Find(var_2_107, "world_money")
		local var_2_109 = var_6.GetComponent

		typeof = var_9
		Image = var_2_10011

		var_2_105(var_2_104, var_2_106, var_2_109(var_2_108, var_9(var_2_10011)).sprite)

		local var_2_110 = var_1
		local var_2_111 = var_1.AddSprite
		local var_2_112 = "port_money"
		local var_2_113 = arg_1_0._res
		local var_2_114 = var_6.Find(var_2_113, "port_money")
		local var_2_115 = var_6.GetComponent

		typeof = var_9
		Image = var_2_10011

		var_2_111(var_2_110, var_2_112, var_2_115(var_2_114, var_9(var_2_10011)).sprite)

		local var_2_116 = var_1
		local var_2_117 = var_1.AddSprite
		local var_2_118 = "world_boss"
		local var_2_119 = arg_1_0._res
		local var_2_120 = var_6.Find(var_2_119, "world_boss")
		local var_2_121 = var_6.GetComponent

		typeof = var_9
		Image = var_2_10011

		var_2_117(var_2_116, var_2_118, var_2_121(var_2_120, var_9(var_2_10011)).sprite)

		local var_2_122 = arg_1_0
		local var_2_123 = arg_1_0._sigleItemPanel

		var_2_122._singleItemSubIntroTF = var_3.Find(var_2_123, "sub_intro")
		setText = var_2_122

		local var_2_124 = arg_1_0._sigleItemPanel
		local var_2_125 = var_4.Find(var_2_124, "ship_group/locked/Text")

		i18n = var_2_123

		var_2_122(var_2_125, var_2_123("tag_ship_locked"))

		setText = var_2_122

		local var_2_126 = arg_1_0._sigleItemPanel
		local var_2_127 = var_4.Find(var_2_126, "ship_group/unlocked/Text")

		i18n = var_5

		var_2_122(var_2_127, var_5("tag_ship_unlocked"))

		local var_2_128 = arg_1_0
		local var_2_129 = arg_1_0._window

		var_2_128._inputPanel = var_3.Find(var_2_129, "input_panel")

		local var_2_130 = arg_1_0
		local var_2_131 = arg_1_0._inputPanel
		local var_2_132 = var_3.Find(var_2_131, "label")
		local var_2_133 = var_3.GetComponent

		typeof = var_6
		Text = var_2_120
		var_2_130._inputTitle = var_2_133(var_2_132, var_6(var_2_120))

		local var_2_134 = arg_1_0
		local var_2_135 = arg_1_0._inputPanel

		var_2_134._inputTF = var_3.Find(var_2_135, "InputField")

		local var_2_136 = arg_1_0
		local var_2_137 = arg_1_0._inputTF
		local var_2_138 = var_3.GetComponent

		typeof = var_6
		InputField = var_2_120
		var_2_136._inputField = var_2_138(var_2_137, var_6(var_2_120))

		local var_2_139 = arg_1_0
		local var_2_140 = arg_1_0._inputTF
		local var_2_141 = var_3.Find(var_2_140, "Placeholder")
		local var_2_142 = var_3.GetComponent

		typeof = var_6
		Text = var_2_120
		var_2_139._placeholderTF = var_2_142(var_2_141, var_6(var_2_120))

		local var_2_143 = arg_1_0
		local var_2_144 = arg_1_0._inputPanel

		var_2_143._inputConfirmBtn = var_3.Find(var_2_144, "btns/confirm_btn")

		local var_2_145 = arg_1_0
		local var_2_146 = arg_1_0._inputPanel

		var_2_145._inputCancelBtn = var_3.Find(var_2_146, "btns/cancel_btn")

		local var_2_147 = arg_1_0
		local var_2_148 = arg_1_0._window

		var_2_147._helpPanel = var_3.Find(var_2_148, "help_panel")

		local var_2_149 = arg_1_0
		local var_2_150 = arg_1_0._tf

		var_2_149._helpBgTF = var_3.Find(var_2_150, "bg_help")

		local var_2_151 = arg_1_0
		local var_2_152 = arg_1_0._helpPanel

		var_2_151._helpList = var_3.Find(var_2_152, "list")

		local var_2_153 = arg_1_0
		local var_2_154 = arg_1_0._helpPanel

		var_2_153._helpTpl = var_3.Find(var_2_154, "list/help_tpl")

		local var_2_155 = arg_1_0
		local var_2_156 = arg_1_0._window

		var_2_155._worldResetPanel = var_3.Find(var_2_156, "world_reset_panel")

		local var_2_157 = arg_1_0
		local var_2_158 = arg_1_0._window

		var_2_157._worldShopBtn = var_3.Find(var_2_158, "world_shop_btn")

		local var_2_159 = arg_1_0
		local var_2_160 = arg_1_0._window

		var_2_159._remasterPanel = var_3.Find(var_2_160, "remaster_info")

		local var_2_161 = arg_1_0
		local var_2_162 = arg_1_0._window

		var_2_161._obtainPanel = var_3.Find(var_2_162, "obtain_panel")

		local var_2_163 = arg_1_0
		local var_2_164 = arg_1_0._window

		var_2_163._otherPanel = var_3.Find(var_2_164, "other_panel")

		local var_2_165 = arg_1_0
		local var_2_166 = arg_1_0._window

		var_2_165._countSelect = var_3.Find(var_2_166, "count_select")

		local var_2_167 = arg_1_0

		PageUtil = var_3

		local var_2_168 = var_3.New
		local var_2_169 = arg_1_0._countSelect
		local var_2_170 = var_5.Find(var_2_169, "value_bg/left")
		local var_2_171 = arg_1_0._countSelect
		local var_2_172 = var_6.Find(var_2_171, "value_bg/right")
		local var_2_173 = arg_1_0._countSelect
		local var_2_174 = var_7.Find(var_2_173, "max")
		local var_2_175 = arg_1_0._countSelect

		var_2_167._pageUtil = var_2_168(var_2_170, var_2_172, var_2_174, var_8.Find(var_2_175, "value_bg/value"))

		local var_2_176 = arg_1_0
		local var_2_177 = arg_1_0._countSelect

		var_2_176._countDescTxt = var_3.Find(var_2_177, "desc_txt")

		local var_2_178 = arg_1_0
		local var_2_179 = arg_1_0._window

		var_2_178._sliders = var_3.Find(var_2_179, "sliders")

		local var_2_180 = arg_1_0
		local var_2_181 = arg_1_0._sliders

		var_2_180._discountInfo = var_3.Find(var_2_181, "discountInfo")

		local var_2_182 = arg_1_0
		local var_2_183 = arg_1_0._sliders

		var_2_182._discountDate = var_3.Find(var_2_183, "discountDate")

		local var_2_184 = arg_1_0
		local var_2_185 = arg_1_0._sliders

		var_2_184._discount = var_3.Find(var_2_185, "discountInfo/discount")

		local var_2_186 = arg_1_0
		local var_2_187 = arg_1_0._sliders

		var_2_186._strike = var_3.Find(var_2_187, "strike")

		local var_2_188 = arg_1_0
		local var_2_189 = arg_1_0._window
		local var_2_190 = var_3.Find(var_2_189, "stopRemind")
		local var_2_191 = var_3.GetComponent

		typeof = var_6
		Toggle = var_8
		var_2_188.stopRemindToggle = var_2_191(var_2_190, var_6(var_8))

		local var_2_192 = arg_1_0

		tf = var_3

		local var_2_193 = var_3(arg_1_0.stopRemindToggle.gameObject)
		local var_2_194 = var_3.Find(var_2_193, "Label")
		local var_2_195 = var_3.GetComponent

		typeof = var_6
		Text = var_8
		var_2_192.stopRemindText = var_2_195(var_2_194, var_6(var_8))

		local var_2_196 = arg_1_0
		local var_2_197 = arg_1_0._window

		var_2_196._btnContainer = var_3.Find(var_2_197, "button_container")

		local var_2_198 = arg_1_0

		Vector2 = var_3
		var_2_198._defaultSize = var_3(930, 620)

		local var_2_199 = arg_1_0

		Vector2 = var_3
		var_2_199._defaultHelpSize = var_3(870, 480)

		local var_2_200 = arg_1_0

		Vector2 = var_3
		var_2_200._defaultHelpPos = var_3(0, -40)
		arg_1_0.pools = {}
		arg_1_0.panelDict = {}
		arg_1_0.timers = {}

		arg_1_1()

		return
	end, true, true)

	return
end

function var_1.getMsgBoxOb(arg_3_0)
	return arg_3_0._go
end

local function var_0_54(arg_4_0, arg_4_1)
	arg_4_0:commonSetting(arg_4_1)

	SetActive = var_2

	var_2(arg_4_0._msgPanel, true)

	local var_4_0 = arg_4_0.contentText
	local var_4_1

	if not arg_4_0.settings.alignment then
		TextAnchor = var_4_1
		var_4_1 = var_4_1.MiddleCenter
	end

	var_4_0.alignment = var_4_1

	local var_4_2 = arg_4_0.contentText
	local var_4_3

	if not arg_4_0.settings.fontSize then
		var_4_3 = 36
	end

	var_4_2.fontSize = var_4_3

	local var_4_4 = arg_4_0.contentText
	local var_4_5

	if not arg_4_0.settings.content then
		var_4_5 = ""
	end

	var_4_4.text = var_4_5

	arg_4_0:Loaded(arg_4_1)

	return
end

local function var_0_55(arg_5_0, arg_5_1)
	arg_5_0:commonSetting(arg_5_1)

	setActive = var_2

	var_2(arg_5_0._inputPanel, true)

	setActive = var_2

	var_2(arg_5_0._btnContainer, false)

	local var_5_0 = arg_5_0._inputTitle
	local var_5_1

	if not arg_5_1.title then
		var_5_1 = ""
	end

	var_5_0.text = var_5_1

	local var_5_2 = arg_5_0._placeholderTF
	local var_5_3

	if not arg_5_1.placeholder then
		var_5_3 = ""
	end

	var_5_2.text = var_5_3

	local var_5_4 = arg_5_0._inputField
	local var_5_5

	if not arg_5_1.limit then
		var_5_5 = 0
	end

	var_5_4.characterLimit = var_5_5
	setActive = var_5_4

	var_5_4(arg_5_0._inputCancelBtn, not arg_5_1.hideNo)

	local var_5_6 = arg_5_0
	local var_5_7 = arg_5_0.updateButton
	local var_5_8 = arg_5_0._inputCancelBtn
	local var_5_9

	if not arg_5_1.noText then
		var_5_9 = var_0.TEXT_CANCEL
	end

	var_5_7(var_5_6, var_5_8, var_5_9)

	local var_5_10 = arg_5_0
	local var_5_11 = arg_5_0.updateButton
	local var_5_12 = arg_5_0._inputConfirmBtn
	local var_5_13

	if not arg_5_1.yesText then
		var_5_13 = var_0.TEXT_CONFIRM
	end

	var_5_11(var_5_10, var_5_12, var_5_13)

	onButton = var_5_11

	local var_5_14 = arg_5_0
	local var_5_15 = arg_5_0._inputCancelBtn

	local function var_5_16()
		local var_6_0 = arg_5_0

		var_0.hide(var_6_0)

		return
	end

	SFX_CANCEL = var_1_10007

	var_5_11(var_5_14, var_5_15, var_5_16, var_1_10007)

	onButton = var_5_11

	local var_5_17 = arg_5_0
	local var_5_18 = arg_5_0._inputConfirmBtn

	local function var_5_19()
		if arg_5_1.onYes then
			arg_5_1.onYes(arg_5_0._inputField.text)
		end

		local var_7_0 = arg_5_0

		var_0.hide(var_7_0)

		return
	end

	SFX_CONFIRM = var_1_10007

	var_5_11(var_5_17, var_5_18, var_5_19, var_1_10007)
	arg_5_0:Loaded(arg_5_1)

	return
end

local function var_0_56(arg_8_0, arg_8_1)
	arg_8_0:commonSetting(arg_8_1)

	SetActive = var_2

	var_2(arg_8_0._exchangeShipPanel, true)

	setActive = var_2
	findTF = var_4

	var_2(var_4(arg_8_0._exchangeShipPanel, "icon_bg/own"), false)

	updateDrop = var_2

	var_2(arg_8_0._exchangeShipPanel, arg_8_1.drop)

	local var_8_0 = arg_8_0._exchangeShipPanel
	local var_8_1 = var_2.Find(var_8_0, "intro_view/Viewport/intro")

	SetActive = var_1_10003

	local var_8_2 = var_8_1
	local var_8_3 = arg_8_1.drop.type

	DROP_TYPE_SHIP = var_7

	local var_8_10

	if var_8_3 ~= var_7 then
		local var_8_4 = arg_8_1.drop.type

		DROP_TYPE_RESOURCE = var_7

		if var_8_4 ~= var_7 then
			local var_8_5 = arg_8_1.drop.type

			DROP_TYPE_ITEM = var_7

			if var_8_5 ~= var_7 then
				local var_8_6 = arg_8_1.drop.type

				DROP_TYPE_FURNITURE = var_7

				if var_8_6 ~= var_7 then
					local var_8_7 = arg_8_1.drop.type

					DROP_TYPE_STRATEGY = var_7

					if var_8_7 ~= var_7 then
						local var_8_8 = arg_8_1.drop.type

						DROP_TYPE_SKIN = var_7

						if var_8_8 ~= var_7 then
							local var_8_9 = arg_8_1.drop.type

							DROP_TYPE_SKIN_TIMELIMIT = var_7

							if var_8_9 ~= var_7 then
								var_8_10 = false

								goto label_8_0
							end
						end
					end
				end
			end
		end
	end

	var_8_10 = true

	::label_8_0::

	var_1_10003(var_8_2, var_8_10)

	local var_8_11 = arg_8_0.settings.numUpdate

	setActive = var_8_0

	var_8_0(arg_8_0.singleItemIntro, var_8_11 == nil)

	setActive = var_8_0

	var_8_0(arg_8_0._countDescTxt, var_8_11 ~= nil)

	setText = var_8_0

	local var_8_12 = arg_8_0._exchangeShipPanel
	local var_8_13 = var_6.Find(var_8_12, "name_mode/name")
	local var_8_15

	if not arg_8_1.name then
		local var_8_14 = arg_8_1.drop

		if not var_7.getConfig(var_8_14, "name") then
			var_8_15 = ""
		end
	end

	var_8_0(var_8_13, var_8_15)

	setText = var_8_0

	local var_8_16 = arg_8_0._exchangeShipPanel
	local var_8_17 = var_6.Find(var_8_16, "name_mode/name/name")

	getText = var_8_15

	local var_8_18 = arg_8_0._exchangeShipPanel

	var_8_0(var_8_17, var_8_15(var_9.Find(var_8_18, "name_mode/name")))

	local var_8_19 = var_0.ship_data_statistics[arg_8_1.drop.id].skin_id

	ShipWordHelper = var_5

	local var_8_20 = var_5.GetWordAndCV
	local var_8_21 = var_8_19

	ShipWordHelper = var_8_16

	local var_8_22 = var_8_16.WORD_TYPE_DROP
	local var_8_23

	PLATFORM_CODE = var_1_10010
	PLATFORM_US = var_8_18

	local var_8_24, var_8_25, var_8_26 = var_8_20(var_8_21, var_8_22, var_8_23, var_1_10010 ~= var_8_18)

	setText = var_8_22

	local var_8_27 = var_8_1

	if not var_8_26 then
		::label_8_1::

		i18n = var_8_18
		var_8_18 = var_8_18("ship_drop_desc_default")
	end

	var_8_22(var_8_27, var_8_18)

	if arg_8_1.intro then
		setText = var_8

		var_8(var_8_1, arg_8_1.intro)
	end

	if arg_8_1.enabelYesBtn ~= nil then
		local var_8_28 = arg_8_0._btnContainer
		local var_8_29 = var_8.GetChild(var_8_28, 1)

		setButtonEnabled = var_8_23

		var_8_23(var_8_29, arg_8_1.enabelYesBtn)

		eachChild = var_8_23

		var_8_23(var_8_29, function(arg_9_0)
			local var_9_0 = arg_8_1.enabelYesBtn and 1 or 0.3

			GetOrAddComponent = var_2_10002

			local var_9_1 = arg_9_0

			typeof = var_2_10005
			CanvasGroup = var_2_10007
			var_2_10002(var_9_1, var_2_10005(var_2_10007)).alpha = var_9_0

			return
		end)
	end

	if arg_8_1.show_medal then
		local var_8_30 = arg_8_0
		local var_8_31 = arg_8_0.createBtn
		local var_8_32 = {
			sibling = 0,
			hideEvent = true,
			text = arg_8_1.show_medal.desc,
			btnType = var_0.BUTTON_MEDAL
		}

		SFX_UI_BUILDING_EXCHANGE = var_12
		var_8_32.sound = var_12

		var_8_31(var_8_30, var_8_32)
	end

	arg_8_0:Loaded(arg_8_1)

	return
end

local function var_0_57(arg_10_0, arg_10_1)
	arg_10_0:commonSetting(arg_10_1)

	SetActive = var_2

	var_2(arg_10_0._itemPanel, true)

	setActive = var_2

	var_2(arg_10_0._itemText, arg_10_1.content)

	local var_10_0 = arg_10_0._itemText
	local var_10_1

	if not arg_10_1.content then
		var_10_1 = ""
	end

	var_10_0.text = var_10_1

	local var_10_2 = arg_10_1.items
	local var_10_3 = arg_10_1.itemFunc

	UIItemList = var_4

	var_4.StaticAlign(arg_10_0._itemListItemContainer, arg_10_0._itemListItemTpl, #var_10_2, function(arg_11_0, arg_11_1, arg_11_2)
		arg_11_1 = arg_11_1 + 1
		UIItemList = var_2_10003

		if arg_11_0 == var_2_10003.EventUpdate then
			local var_11_0 = var_10_2[arg_11_1]

			updateDrop = var_2_10004

			var_2_10004(arg_11_2:Find("IconTpl"), var_11_0, {
				anonymous = var_11_0.anonymous,
				hideName = var_11_0.hideName
			})

			local var_11_1 = arg_11_2:Find("IconTpl/name")

			setText = var_2_10005

			local var_11_2 = var_11_1

			shortenString = var_8
			getText = var_2_10010

			var_2_10005(var_11_2, var_8(var_2_10010(var_11_1), 6))

			onButton = var_2_10005

			local var_11_3 = arg_10_0
			local var_11_4 = arg_11_2

			local function var_11_5()
				if var_11_0.anonymous then
					return
				elseif var_10_3 then
					var_10_3(var_11_0)
				end

				return
			end

			SFX_UI_CLICK = var_10

			var_2_10005(var_11_3, var_11_4, var_11_5, var_10)
		end

		return
	end)
	arg_10_0:Loaded(arg_10_1)

	return
end

local function var_0_58(arg_13_0, arg_13_1)
	arg_13_0:commonSetting(arg_13_1)

	SetActive = var_2

	var_2(arg_13_0._eskinPanel, true)

	setActive = var_2

	var_2(arg_13_0._eskinText, arg_13_1.content)

	local var_13_0 = arg_13_0._eskinText
	local var_13_1

	if not arg_13_1.content then
		var_13_1 = ""
	end

	var_13_0.text = var_13_1

	local var_13_2 = arg_13_1.items
	local var_13_3 = arg_13_1.itemFunc

	UIItemList = var_4

	var_4.StaticAlign(arg_13_0._eskinListItemContainer, arg_13_0._eskinListItemTpl, #var_13_2, function(arg_14_0, arg_14_1, arg_14_2)
		arg_14_1 = arg_14_1 + 1
		UIItemList = var_2_10003

		if arg_14_0 == var_2_10003.EventUpdate then
			local var_14_0 = var_13_2[arg_14_1]

			updateDrop = var_2_10004

			var_2_10004(arg_14_2:Find("IconTpl"), var_14_0, {
				anonymous = var_14_0.anonymous,
				hideName = var_14_0.hideName
			})

			setText = var_2_10004

			local var_14_1 = arg_14_2:Find("own/Text")

			i18n = var_7

			var_2_10004(var_14_1, var_7("equip_skin_detail_count") .. var_14_0:getOwnedCount())

			onButton = var_2_10004

			local var_14_2 = arg_13_0
			local var_14_3 = arg_14_2

			local function var_14_4()
				if var_14_0.anonymous then
					return
				elseif var_13_3 then
					var_13_3(var_14_0)
				end

				return
			end

			SFX_UI_CLICK = var_9

			var_2_10004(var_14_2, var_14_3, var_14_4, var_9)
		end

		return
	end)
	arg_13_0:Loaded(arg_13_1)

	return
end

local function var_0_59(arg_16_0, arg_16_1)
	arg_16_0:commonSetting(arg_16_1)

	SetActive = var_2

	var_2(arg_16_0._sigleItemPanel, true)

	SetActive = var_2

	local var_16_0 = arg_16_0._sigleItemPanel

	var_2(var_4.Find(var_16_0, "ship_group"), false)

	SetActive = var_2

	var_2(arg_16_0._singleItemshipTypeTF, false)

	SetActive = var_2

	local var_16_1 = arg_16_0._sigleItemPanel

	var_2(var_4.Find(var_16_1, "left/detail"), false)

	setActive = var_2

	local var_16_2 = arg_16_0._sigleItemPanel

	var_2(var_4.Find(var_16_2, "combat_skin"), false)

	setActive = var_2

	local var_16_3 = arg_16_0._sigleItemPanel

	var_2(var_4.Find(var_16_3, "source_panel"), false)

	local var_16_4 = arg_16_0._sigleItemPanel
	local var_16_5 = var_2.Find(var_16_4, "display_panel")
	local var_16_6 = var_2.GetComponent

	typeof = var_5
	RectTransform = var_7

	local var_16_7 = var_16_6(var_16_5, var_5(var_7))

	Vector2 = var_1_10003
	var_16_7.sizeDelta = var_1_10003(var_16_7.sizeDelta.x, -114.5)

	local var_16_8 = arg_16_0.singleItemIntro

	SetActive = var_16_5

	var_16_5(var_16_8, true)

	setText = var_16_5

	local var_16_9 = var_16_8
	local var_16_10

	if not arg_16_1.content then
		var_16_10 = ""
	end

	var_16_5(var_16_9, var_16_10)

	local var_16_11 = arg_16_0._sigleItemPanel
	local var_16_12 = var_4.Find(var_16_11, "left/IconTpl")

	setText = var_5

	var_5(var_16_12:Find("icon_bg/count"), "")

	SetActive = var_5

	var_5(var_16_12:Find("icon_bg/startpl"), false)

	SetCompomentEnabled = var_5

	local var_16_13 = var_16_12:Find("icon_bg")

	typeof = var_8
	Image = var_10

	var_5(var_16_13, var_8(var_10), not arg_16_1.hideIconBG)

	SetCompomentEnabled = var_5

	local var_16_14 = var_16_12:Find("icon_bg/frame")

	typeof = var_8
	Image = var_10

	var_5(var_16_14, var_8(var_10), not arg_16_1.hideIconBG)

	local var_16_15

	var_16_15, setFrame = var_16_12:Find("icon_bg/frame"), var_16_11

	local var_16_16

	if not arg_16_1.frame then
		var_16_16 = 1
	end

	var_16_11(var_16_15, var_16_16)

	GetImageSpriteFromAtlasAsync = var_16_11

	local var_16_17 = "weaponframes"
	local var_16_18 = "bg"
	local var_16_19

	if not arg_16_1.frame then
		var_16_19 = 1
	end

	var_16_11(var_16_17, var_16_18 .. var_16_19, var_16_12:Find("icon_bg"))

	GetImageSpriteFromAtlasAsync = var_16_11

	local var_16_20 = arg_16_1.iconPath[1]
	local var_16_21

	if not arg_16_1.iconPath[2] then
		var_16_21 = ""
	end

	var_16_11(var_16_20, var_16_21, var_16_12:Find("icon_bg/icon"))

	setText = var_16_11

	local var_16_22 = arg_16_0._sigleItemPanel
	local var_16_23 = var_8.Find(var_16_22, "display_panel/name_container/name/Text")
	local var_16_24

	if not arg_16_1.name then
		var_16_24 = ""
	end

	var_16_11(var_16_23, var_16_24)
	arg_16_0:Loaded(arg_16_1)

	return
end

local function var_0_60(arg_17_0, arg_17_1)
	arg_17_0:commonSetting(arg_17_1)

	SetActive = var_2

	var_2(arg_17_0._sigleItemPanel, true)

	local var_17_0 = arg_17_1.drop
	local var_17_1 = arg_17_0._sigleItemPanel
	local var_17_2 = var_3.Find(var_17_1, "left/IconTpl")

	setActive = var_4

	local var_17_3 = var_17_2
	local var_17_4 = var_17_2.Find(var_17_3, "timelimit")
	local var_17_5 = var_17_0.type

	DROP_TYPE_SKIN_TIMELIMIT = var_17_3

	var_4(var_17_4, var_17_5 == var_17_3)

	updateDrop = var_4

	var_4(var_17_2, var_17_0)

	setActive = var_4

	local var_17_6 = arg_17_0._singleItemshipTypeTF
	local var_17_7 = var_17_0.type

	DROP_TYPE_SHIP = var_17_3

	var_4(var_17_6, var_17_7 == var_17_3)

	setActive = var_4

	local var_17_8 = arg_17_0._sigleItemPanel

	var_4(var_6.Find(var_17_8, "combat_skin"), false)

	setActive = var_4

	local var_17_9 = arg_17_0._sigleItemPanel

	var_4(var_6.Find(var_17_9, "source_panel"), false)

	local var_17_10 = arg_17_0._sigleItemPanel
	local var_17_11 = var_4.Find(var_17_10, "display_panel")
	local var_17_12 = var_4.GetComponent

	typeof = var_7
	RectTransform = var_9

	local var_17_13 = var_17_12(var_17_11, var_7(var_9))

	Vector2 = var_17_1
	var_17_13.sizeDelta = var_17_1(var_17_13.sizeDelta.x, -114.5)

	local var_17_14 = var_17_0.type

	DROP_TYPE_SHIP = var_17_11

	local var_17_15

	if var_17_14 == var_17_11 then
		GetImageSpriteFromAtlasAsync = var_17_14
		var_17_15 = "shiptype"
		shipType2print = var_8

		var_17_14(var_17_15, var_8(var_17_0:getConfig("type")), arg_17_0._singleItemshipTypeTF, false)
	else
		local var_17_16 = var_17_0.type

		DROP_TYPE_ITEM = var_17_11

		if var_17_16 == var_17_11 then
			ItemTipPanel = var_17_16

			if not var_17_16.GetDropLackConfig(var_17_0) or not var_5.description then
				var_17_11 = {}
			end

			if #var_17_11 > 0 then
				Vector2 = var_17_15
				var_17_13.sizeDelta = var_17_15(var_17_13.sizeDelta.x, -170.5)
				UIItemList = var_17_15
				var_17_15 = var_17_15.StaticAlign
				var_1_10011 = arg_17_0._sigleItemPanel

				local var_17_17 = var_9.Find(var_1_10011, "source_panel/Viewport/Content")
				local var_17_18 = arg_17_0._sigleItemPanel

				var_17_15(var_17_17, var_10.Find(var_17_18, "source_panel/Viewport/Content/sourceItem"), #var_17_11, function(arg_18_0, arg_18_1, arg_18_2)
					UIItemList = var_2_10003

					if arg_18_0 == var_2_10003.EventUpdate then
						local var_18_0 = var_17_11[arg_18_1 + 1]

						unpack = var_4

						local var_18_1, var_18_2, var_18_3 = var_4(var_18_0)

						setText = var_2_10007

						var_2_10007(arg_18_2:Find("desc"), var_18_1)

						setText = var_2_10007

						local var_18_4 = arg_18_2:Find("btn/Text")

						i18n = var_10

						var_2_10007(var_18_4, var_10("feast_res_window_go_label"))

						unpack = var_2_10007

						local var_18_5, var_18_6 = var_2_10007(var_18_2)
						local var_18_7 = #var_18_5
						local var_18_8 = 0 < var_18_7

						if var_18_3 and var_18_3 ~= 0 and var_18_8 then
							getProxy = var_10
							ActivityProxy = var_12

							local var_18_9 = var_10(var_12)

							var_18_8 = var_10.IsActivityNotEnd(var_18_9, var_18_3)
						end

						setActive = var_10

						var_10(arg_18_2:Find("btn"), var_18_8)

						onButton = var_10

						local var_18_10 = arg_17_0
						local var_18_11 = arg_18_2
						local var_18_12 = arg_18_2.Find(var_18_11, "btn")

						local function var_18_13()
							ItemTipPanel = var_3_10000

							var_3_10000.ConfigGoScene(var_18_5, var_18_6, function()
								local var_20_0 = arg_17_0

								var_0.hide(var_20_0)

								return
							end)

							return
						end

						SFX_PANEL = var_18_11

						var_10(var_18_10, var_18_12, var_18_13, var_18_11)
					end

					return
				end)

				setActive = var_17_15
				var_1_10011 = arg_17_0._sigleItemPanel

				var_17_15(var_9.Find(var_1_10011, "source_panel"), true)
			else
				setActive = var_17_15
				var_1_10011 = arg_17_0._sigleItemPanel

				var_17_15(var_9.Find(var_1_10011, "source_panel"), false)
			end
		else
			local var_17_19 = var_17_0.type

			DROP_TYPE_COMBAT_UI_STYLE = var_17_11

			if var_17_19 == var_17_11 then
				Vector2 = var_17_19
				var_17_13.sizeDelta = var_17_19(var_17_13.sizeDelta.x, -170.5)

				local var_17_20 = var_0.item_data_battleui[var_17_0.id].rare_display

				UIItemList = var_17_11
				var_17_11 = var_17_11.New

				local var_17_21 = arg_17_0._sigleItemPanel
				local var_17_22 = var_8.Find(var_17_21, "combat_skin/elementList")

				var_1_10011 = arg_17_0._sigleItemPanel

				local var_17_23 = var_17_11(var_17_22, var_9.Find(var_1_10011, "combat_skin/elementList/main"))

				var_17_11.make(var_17_23, function(arg_21_0, arg_21_1, arg_21_2)
					UIItemList = var_2_10003

					if arg_21_0 == var_2_10003.EventUpdate then
						local var_21_0 = var_17_20[arg_21_1 + 1]

						GetImageSpriteFromAtlasAsync = var_4

						local var_21_1 = "ui/combatskinrare"

						CombatSkinConst = var_2_10007

						var_4(var_21_1, var_2_10007.TYPE_ICON_NAME[var_21_0], arg_21_2:Find("icon"), true)

						setScrollText = var_4

						local var_21_2 = arg_21_2:Find("TextMask/Text")

						i18n = var_7

						var_4(var_21_2, var_7("battleui_display" .. var_21_0))
					end

					return
				end)
				var_17_11:align(#var_17_20)

				setActive = var_17_15
				var_1_10011 = arg_17_0._sigleItemPanel

				var_17_15(var_9.Find(var_1_10011, "combat_skin"), true)
			end
		end
	end

	local var_17_24 = var_17_0.type

	DROP_TYPE_SHIP = var_17_11

	local var_17_25 = var_17_24 == var_17_11
	local var_17_26 = arg_17_0._sigleItemPanel
	local var_17_27 = var_6.Find(var_17_26, "ship_group")

	SetActive = var_17_15

	var_17_15(var_17_27, var_17_25)

	if var_17_25 then
		tobool = var_17_15
		getProxy = var_9
		CollectionProxy = var_1_10011
		var_1_10011 = var_9(var_1_10011)

		local var_17_28 = var_17_15(var_9.getShipGroup(var_1_10011, var_0.ship_data_template[var_17_0.id].group_type))

		SetActive = var_17_26

		var_17_26(var_17_27:Find("unlocked"), var_17_28)

		SetActive = var_17_26

		var_17_26(var_17_27:Find("locked"), not var_17_28)
	end

	local var_17_30

	if arg_17_1.windowSize then
		local var_17_29 = arg_17_0._window

		Vector2 = var_17_26

		if not arg_17_1.windowSize.x then
			var_17_30 = arg_17_0._defaultSize.x
		end

		if not arg_17_1.windowSize.y then
			var_1_10011 = arg_17_0._defaultSize.y
		end

		var_17_29.sizeDelta = var_17_26(var_17_30, var_1_10011)
	end

	local var_17_31 = arg_17_0.singleItemIntro
	local var_17_32 = arg_17_0._singleItemSubIntroTF
	local var_17_33 = arg_17_0.settings.numUpdate

	setActive = var_17_30

	var_17_30(arg_17_0._countDescTxt, var_17_33 ~= nil)

	SetActive = var_17_30

	var_17_30(var_17_31, var_17_33 == nil)

	local var_17_34, var_17_35

	if not arg_17_1.name then
		var_17_34 = var_17_0

		if not var_17_0.getConfig(var_17_34, "name") then
			var_17_35 = ""
		end
	end

	setText = var_1_10011

	local var_17_36 = arg_17_0._sigleItemPanel

	var_1_10011(var_13.Find(var_17_36, "display_panel/name_container/name/Text"), var_17_35)

	UpdateOwnDisplay = var_1_10011

	local var_17_37 = arg_17_0._sigleItemPanel

	var_1_10011(var_13.Find(var_17_37, "left/own"), var_17_0)

	RegisterDetailButton = var_1_10011

	local var_17_38 = arg_17_0
	local var_17_39 = arg_17_0._sigleItemPanel

	var_1_10011(var_17_38, var_14.Find(var_17_39, "left/detail"), var_17_0)

	if arg_17_1.content and arg_17_1.content ~= "" then
		setText = var_11

		var_11(var_17_31, arg_17_1.content)
	else
		local var_17_40 = var_17_0.type

		DROP_TYPE_WORLD_COLLECTION = var_17_34

		if var_17_40 == var_17_34 then
			local var_17_41 = var_17_0
			local var_17_42 = var_17_0.MsgboxIntroSet
			local var_17_43 = arg_17_1
			local var_17_44 = var_17_31
			local var_17_45 = arg_17_0._sigleItemPanel

			var_17_42(var_17_41, var_17_43, var_17_44, var_16.Find(var_17_45, "name_mode/name_mask/name"))
		else
			var_17_0:MsgboxIntroSet(arg_17_1, var_17_31)
		end
	end

	if arg_17_1.intro then
		setText = var_11

		var_11(var_17_31, arg_17_1.intro)
	end

	setText = var_11

	local var_17_46 = var_17_32
	local var_17_47

	if not arg_17_1.subIntro and not arg_17_1.extendDesc then
		var_17_47 = ""
	end

	var_11(var_17_46, var_17_47)

	if arg_17_1.enabelYesBtn ~= nil then
		local var_17_48 = arg_17_0._btnContainer
		local var_17_49 = var_11.GetChild(var_17_48, 1)

		setButtonEnabled = var_17_34

		var_17_34(var_17_49, arg_17_1.enabelYesBtn)

		eachChild = var_17_34

		var_17_34(var_17_49, function(arg_22_0)
			local var_22_0 = arg_17_1.enabelYesBtn and 1 or 0.3

			GetOrAddComponent = var_2_10002

			local var_22_1 = arg_22_0

			typeof = var_2_10005
			CanvasGroup = var_2_10007
			var_2_10002(var_22_1, var_2_10005(var_2_10007)).alpha = var_22_0

			return
		end)
	end

	if arg_17_1.show_medal then
		local var_17_50 = arg_17_0
		local var_17_51 = arg_17_0.createBtn
		local var_17_52 = {
			sibling = 0,
			hideEvent = true,
			text = arg_17_1.show_medal.desc,
			btnType = var_0.BUTTON_MEDAL
		}

		SFX_UI_BUILDING_EXCHANGE = var_15
		var_17_52.sound = var_15

		var_17_51(var_17_50, var_17_52)
	end

	arg_17_0:Loaded(arg_17_1)

	return
end

local function var_0_61(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0

	arg_23_0.commonSetting(var_23_0, arg_23_1)

	setActive = var_2
	findTF = var_23_0

	var_2(var_23_0(arg_23_0._helpPanel, "bg"), not arg_23_1.helps.pageMode)

	setActive = var_2

	var_2(arg_23_0._helpBgTF, arg_23_1.helps.pageMode)

	setActive = var_2

	local var_23_1 = arg_23_0._helpPanel

	var_2(var_4.Find(var_23_1, "btn_blueprint"), arg_23_1.show_blueprint)

	local var_23_3

	if arg_23_1.show_blueprint then
		onButton = var_2

		local var_23_2 = arg_23_0

		var_23_3 = arg_23_0._helpPanel

		local var_23_4 = var_5.Find(var_23_3, "btn_blueprint")

		function var_23_1()
			local var_24_0 = arg_23_0

			var_0.hide(var_24_0)

			local var_24_1 = var_0.m02
			local var_24_2 = var_0.sendNotification

			GAME = var_2_10003

			local var_24_3 = var_2_10003.GO_SCENE

			SCENE = var_2_10004

			var_24_2(var_24_1, var_24_3, var_2_10004.SHIPBLUEPRINT, {
				shipGroupId = arg_23_1.show_blueprint
			})

			return
		end

		SFX_PANEL = var_23_3

		var_2(var_23_2, var_23_4, var_23_1, var_23_3)
	end

	if arg_23_1.helps.helpSize then
		local var_23_5 = arg_23_0._helpPanel

		Vector2 = var_1_10003

		local var_23_6

		if not arg_23_1.helps.helpSize.x then
			var_23_6 = arg_23_0._defaultHelpSize.x
		end

		if not arg_23_1.helps.helpSize.y then
			var_23_1 = arg_23_0._defaultHelpSize.y
		end

		var_23_5.sizeDelta = var_1_10003(var_23_6, var_23_1)
	end

	if arg_23_1.helps.helpPos then
		setAnchoredPosition = var_2

		local var_23_7 = arg_23_0._helpPanel
		local var_23_8 = {}

		if not arg_23_1.helps.helpPos.x then
			var_23_1 = arg_23_0._defaultHelpPos.x
		end

		var_23_8.x = var_23_1

		if not arg_23_1.helps.helpPos.y then
			var_23_1 = arg_23_0._defaultHelpPos.y
		end

		var_23_8.y = var_23_1

		var_2(var_23_7, var_23_8)
	end

	if arg_23_1.helps.windowSize then
		local var_23_9 = arg_23_0._window

		Vector2 = var_1_10003

		local var_23_10

		if not arg_23_1.helps.windowSize.x then
			var_23_10 = arg_23_0._defaultSize.x
		end

		if not arg_23_1.helps.windowSize.y then
			var_23_1 = arg_23_0._defaultSize.y
		end

		var_23_9.sizeDelta = var_1_10003(var_23_10, var_23_1)
	end

	local var_23_11

	if arg_23_1.helps.windowPos then
		var_23_11 = arg_23_0._window
		Vector2 = var_1_10003

		local var_23_12

		if not arg_23_1.helps.windowSize.x then
			var_23_12 = arg_23_0._defaultSize.x
		end

		if not arg_23_1.helps.windowSize.y then
			var_23_1 = arg_23_0._defaultSize.y
		end

		var_23_11.sizeDelta = var_1_10003(var_23_12, var_23_1)
		setAnchoredPosition = var_23_11

		local var_23_13 = arg_23_0._window
		local var_23_14 = {}

		if not arg_23_1.helps.windowPos.x then
			var_23_1 = 0
		end

		var_23_14.x = var_23_1

		if not arg_23_1.helps.windowPos.y then
			var_23_1 = 0
		end

		var_23_14.y = var_23_1

		var_23_11(var_23_13, var_23_14)
	else
		setAnchoredPosition = var_23_11

		var_23_11(arg_23_0._window, {
			x = 0,
			y = 0
		})
	end

	if arg_23_1.helps.buttonsHeight then
		setAnchoredPosition = var_2

		var_2(arg_23_0._btnContainer, {
			y = arg_23_1.helps.buttonsHeight
		})
	end

	if arg_23_1.helps.disableScroll then
		local var_23_15 = arg_23_0._helpPanel
		local var_23_16 = var_2.Find(var_23_15, "list")

		SetCompomentEnabled = var_1_10003
		var_23_3 = arg_23_0._helpPanel

		local var_23_17 = var_5.Find(var_23_3, "list")

		typeof = var_23_1
		ScrollRect = var_8

		var_1_10003(var_23_17, var_23_1(var_8), not arg_23_1.helps.disableScroll)

		setAnchoredPosition = var_1_10003

		local var_23_18 = var_23_16

		Vector2 = var_6

		var_1_10003(var_23_18, var_6.zero)

		setActive = var_1_10003
		findTF = var_23_18

		var_1_10003(var_23_18(arg_23_0._helpPanel, "Scrollbar"), false)
	end

	if arg_23_1.helps.ImageMode then
		setActive = var_2

		var_2(arg_23_0._top, false)

		setActive = var_2
		findTF = var_4

		var_2(var_4(arg_23_0._window, "bg"), false)
	else
		setActive = var_2

		var_2(arg_23_0._top, true)

		setActive = var_2
		findTF = var_4

		var_2(var_4(arg_23_0._window, "bg"), true)
	end

	for iter_23_0 = #arg_23_0.settings.helps, arg_23_0._helpList.childCount - 1 do
		Destroy = var_23_3

		local var_23_19 = arg_23_0._helpList

		var_23_3(var_1_10009.GetChild(var_23_19, iter_23_0))
	end

	for iter_23_1 = arg_23_0._helpList.childCount, #var_2 - 1 do
		cloneTplTo = var_23_3

		var_23_3(arg_23_0._helpTpl, arg_23_0._helpList)
	end

	ipairs = var_3

	for iter_23_2, iter_23_3 in var_3(var_2) do
		local var_23_20 = arg_23_0._helpList
		local var_23_21 = var_8.GetChild(var_23_20, iter_23_2 - 1)

		setActive = var_1_10009

		var_1_10009(var_23_21, true)

		var_1_10009 = var_23_21:Find("icon")
		setActive = var_23_20

		var_23_20(var_1_10009, iter_23_3.icon)

		setActive = var_23_20
		findTF = var_12

		var_23_20(var_12(var_23_21, "line"), iter_23_3.line)

		local var_23_24

		if iter_23_3.icon then
			local var_23_22 = 1

			if arg_23_1.helps.ImageMode then
				var_23_22 = 1.5
			end

			local var_23_23 = var_1_10009.transform

			Vector2 = var_12

			if not iter_23_3.icon.scale then
				var_23_24 = var_23_22
			end

			local var_23_25

			if not iter_23_3.icon.scale then
				var_23_25 = var_23_22
			end

			var_23_23.localScale = var_12(var_23_24, var_23_25)

			local var_23_26 = iter_23_3.icon.path
			local var_23_27

			if not iter_23_3.icon.posX or not iter_23_3.icon.posX then
				var_23_27 = -20
			end

			local var_23_28

			if not iter_23_3.icon.posY or not iter_23_3.icon.posY then
				var_23_28 = 0
			end

			LoadSprite = var_23_24
			var_23_24 = var_23_24(iter_23_3.icon.atlas, iter_23_3.icon.path)
			setImageSprite = var_23_25

			local var_23_29 = var_1_10009
			local var_23_30 = var_1_10009.GetComponent

			typeof = var_1_10020
			Image = var_1_10022

			var_23_25(var_23_30(var_23_29, var_1_10020(var_1_10022)), var_23_24, true)

			setAnchoredPosition = var_23_25

			var_23_25(var_1_10009, {
				x = var_23_27,
				y = var_23_28
			})

			setActive = var_23_25

			var_23_25(var_1_10009:Find("corner"), arg_23_1.helps.pageMode)
		end

		local var_23_31 = var_23_21:Find("richText")
		local var_23_32 = var_10.GetComponent(var_23_31, "RichText")
		local var_23_33

		if iter_23_3.rawIcon then
			var_23_33 = iter_23_3.rawIcon.name
			var_23_24 = var_23_32

			local var_23_34 = var_23_32.AddSprite
			local var_23_35 = var_23_33

			GetSpriteFromAtlas = var_1_10016

			var_23_34(var_23_24, var_23_35, var_1_10016(iter_23_3.rawIcon.atlas, var_23_33))

			HXSet = var_23_34

			local var_23_36 = var_23_34.hxLan

			if not iter_23_3.info then
				var_23_24 = ""
			end

			local var_23_37 = var_23_36(var_23_24)

			setText = var_13

			var_13(var_23_21, "")

			string = var_13
			var_23_32.text = var_13.format("<icon name=%s w=0.7 h=0.7/>%s", var_23_33, var_23_37)

			goto label_23_0
		end

		setText = var_23_33

		local var_23_38 = var_23_21

		HXSet = var_23_24

		local var_23_39 = var_23_24.hxLan

		if iter_23_3.info then
			SwitchSpecialChar = var_1_10016

			if not var_1_10016(iter_23_3.info, true) then
				var_1_10016 = ""
			end

			var_23_33(var_23_38, var_23_39(var_1_10016))

			::label_23_0::

			setActive = var_23_33

			var_23_33(var_23_32.gameObject, iter_23_3.rawIcon)
		end
	end

	local var_23_40

	if not arg_23_1.helps.defaultpage then
		var_23_40 = 1
	end

	arg_23_0.helpPage = var_23_40

	if arg_23_1.helps.pageMode then
		arg_23_0:switchHelpPage(arg_23_0.helpPage)
	end

	arg_23_0:Loaded(arg_23_1)

	return
end

local function var_0_62(arg_25_0, arg_25_1)
	arg_25_0:commonSetting(arg_25_1)

	setActive = var_2

	var_2(arg_25_0._otherPanel, true)

	tf = var_2

	local var_25_0 = var_2(arg_25_1.secondaryUI)
	local var_25_1 = arg_25_0._window

	Vector2 = var_4
	var_25_1.sizeDelta = var_4(960, arg_25_0._defaultSize.y)
	setActive = var_25_1

	var_25_1(var_25_0, true)

	local var_25_2 = arg_25_1.mode

	getProxy = var_4
	SecondaryPWDProxy = var_6

	local var_25_3 = var_4(var_6)
	local var_25_4 = var_4.getRawData(var_25_3)
	local var_25_5 = var_25_0
	local var_25_6 = var_25_0.Find(var_25_5, "showresttime")
	local var_25_7 = var_25_0:Find("settips")

	if var_25_2 == "showresttime" then
		setActive = var_25_5

		var_25_5(var_25_6, true)

		setActive = var_25_5

		var_25_5(var_25_7, false)

		local var_25_8 = var_25_6:Find("desc")

		var_25_5 = var_25_5.GetComponent
		typeof = var_11
		Text = var_1_10013
		var_25_5 = var_25_5(var_25_8, var_11(var_1_10013))

		if arg_25_0.timers.secondaryUItimer then
			local var_25_9 = arg_25_0.timers.secondaryUItimer

			var_9.Stop(var_25_9)
		end

		;(function()
			local var_26_0 = var_0.TimeMgr.GetInstance()
			local var_26_1 = var_0.GetServerTime(var_26_0)
			local var_26_2

			if not var_25_4.fail_cd or not (var_25_4.fail_cd - var_26_1) then
				var_26_2 = 0
			end

			var_26_2 = var_26_2 < 0 and 0 or var_26_2
			math = var_2

			local var_26_3 = var_2.floor(var_26_2 / 0)
			local var_26_4

			if 0 < var_26_3 then
				var_26_4 = var_25_5
				string = var_4

				local var_26_5 = var_4.format

				i18n = var_2_10006

				local var_26_6 = var_2_10006("tips_fail_secondarypwd_much_times")

				var_2_10007 = var_26_3
				i18n = var_2_10008
				var_26_4.text = var_26_5(var_26_6, var_2_10007 .. var_2_10008("word_date"))
			else
				math = var_26_4

				local var_26_8

				if var_26_4.floor(var_26_2 / 16) > 0 then
					local var_26_7 = var_25_5

					string = var_26_8
					var_26_8 = var_26_8.format
					i18n = var_2_10007

					local var_26_9 = var_2_10007("tips_fail_secondarypwd_much_times")

					var_2_10008 = var_3
					i18n = var_9
					var_26_7.text = var_26_8(var_26_9, var_2_10008 .. var_9("word_hour"))
				else
					local var_26_10 = ""

					math = var_26_8

					local var_26_11 = var_26_8.floor(var_26_2 / 60)
					local var_26_12

					if 0 < var_26_11 then
						var_26_12 = var_26_10

						local var_26_13 = var_26_11

						i18n = var_2_10008
						var_26_10 = var_26_12 .. var_26_13 .. var_2_10008("word_minute")
					end

					math = var_26_12

					local var_26_14 = var_26_12.max(var_26_2 - var_26_11 * 60, 0)
					local var_26_15 = var_25_5

					string = var_8

					local var_26_16 = var_8.format

					i18n = var_2_10010

					local var_26_17 = var_2_10010("tips_fail_secondarypwd_much_times")
					local var_26_18 = var_26_10
					local var_26_19 = var_26_14

					i18n = var_2_10013
					var_26_15.text = var_26_16(var_26_17, var_26_18 .. var_26_19 .. var_2_10013("word_second"))
				end
			end

			return
		end)()

		Timer = var_10
		var_1_10013 = var_10.New(var_9, 1, -1)

		var_10.Start(var_1_10013)

		arg_25_0.timers.secondaryUItimer = var_10
	elseif var_25_2 == "settips" then
		setActive = var_25_5

		var_25_5(var_25_6, false)

		setActive = var_25_5

		var_25_5(var_25_7, true)

		local var_25_10 = var_25_7:Find("InputField")
		local var_25_11 = var_8.GetComponent

		typeof = var_11
		InputField = var_1_10013

		local var_25_12 = var_25_11(var_25_10, var_11(var_1_10013))

		arg_25_1.references.inputfield = var_25_12

		local var_25_13

		if not arg_25_1.references.lasttext then
			var_25_13 = ""
		end

		var_25_12.text = var_25_13

		local var_25_14 = 20
		local var_25_15 = var_25_12.onValueChanged

		var_10.AddListener(var_25_15, function()
			utf8_to_unicode = var_2_10000

			local var_27_0, var_27_1 = var_2_10000(var_25_12.text)

			if var_27_1 > var_25_14 then
				local var_27_2 = var_25_12

				SecondaryPasswordMediator = var_2_10003
				var_27_2.text = var_2_10003.ClipUnicodeStr(var_25_12.text, var_25_14)
			end

			return
		end)

		local function var_25_16()
			PLATFORM_CODE = var_2_10000
			PLATFORM_JP = var_2_10001

			if var_2_10000 ~= var_2_10001 then
				PLATFORM_CODE = var_2_10000
				PLATFORM_US = var_2_10001

				if var_2_10000 == var_2_10001 then
					return false
				end

				local var_28_0 = var_25_12.text

				wordVer = var_2_10001

				local var_28_1, var_28_2 = var_2_10001(var_28_0, {
					isReplace = true
				})

				if var_28_1 > 0 or var_28_2 ~= var_28_0 then
					local var_28_3 = var_0.TipsMgr.GetInstance()
					local var_28_4 = var_3.ShowTips

					i18n = var_2_10006

					var_28_4(var_28_3, var_2_10006("secondarypassword_illegal_tip"))

					var_25_12.text = var_28_2

					return true
				else
					return false
				end

				return
			end
		end

		local var_25_17 = arg_25_0
		local var_25_18 = arg_25_0.createBtn
		local var_25_19 = {
			text = var_0.TEXT_CONFIRM,
			btnType = var_0.BUTTON_BLUE,
			onCallback = arg_25_0.settings.onYes
		}

		SFX_CONFIRM = var_15
		var_25_19.sound = var_15
		var_25_19.noQuit = var_25_16

		var_25_18(var_25_17, var_25_19)
	end

	arg_25_0:Loaded(arg_25_1)

	return
end

local function var_0_63(arg_29_0, arg_29_1)
	arg_29_0:commonSetting(arg_29_1)

	setActive = var_2

	var_2(arg_29_0._worldResetPanel, true)

	setActive = var_2

	var_2(arg_29_0._worldShopBtn, false)

	setText = var_2

	local var_29_0 = arg_29_0._worldResetPanel

	var_2(var_4.Find(var_29_0, "content/Text"), arg_29_1.tipWord)

	local var_29_1 = arg_29_0._worldResetPanel
	local var_29_2 = var_2.Find(var_29_1, "IconTpl")

	setActive = var_1_10003

	var_1_10003(var_29_2, false)

	local var_29_3 = arg_29_0._worldResetPanel
	local var_29_4 = var_3.Find(var_29_3, "content/item_list")

	removeAllChildren = var_29_1

	var_29_1(var_29_4)

	ipairs = var_29_1

	for iter_29_0, iter_29_1 in var_29_1(arg_29_1.drops) do
		cloneTplTo = var_1_10009
		var_1_10009 = var_1_10009(var_29_2, var_29_4)
		updateDrop = var_1_10010

		var_1_10010(var_1_10009, iter_29_1)

		findTF = var_1_10010
		var_1_10010 = var_1_10010(var_1_10009, "name")
		changeToScrollText = var_11

		local var_29_5 = var_1_10010

		getText = var_1_10014

		var_11(var_29_5, var_1_10014(var_1_10010))

		if arg_29_1.itemFunc then
			onButton = var_11

			local var_29_6 = arg_29_0

			var_1_10014 = var_1_10009

			local function var_29_7()
				arg_29_1.itemFunc(iter_29_1)

				return
			end

			SFX_PANEL = var_16

			var_11(var_29_6, var_1_10014, var_29_7, var_16)
		end
	end

	onButton = var_4

	local var_29_8 = arg_29_0
	local var_29_9 = arg_29_0._worldShopBtn

	local function var_29_10()
		local var_31_0 = arg_29_0

		var_0.hide(var_31_0)

		existCall = var_0

		return var_0(arg_29_1.goShop)
	end

	SFX_MAIN = var_1_10009

	var_4(var_29_8, var_29_9, var_29_10, var_1_10009)
	arg_29_0:Loaded(arg_29_1)

	return
end

local function var_0_64(arg_32_0)
	if not arg_32_0 then
		return false
	end

	ipairs = var_1_10001

	for iter_32_0, iter_32_1 in var_1_10001(arg_32_0) do
		local var_32_0 = iter_32_1[2] and var_6[1] == "SHOP"
		local var_32_1

		if var_6[2] then
			var_32_1 = var_6[2].warp == "meta"
		end

		if var_32_0 and var_32_1 then
			return true
		end
	end

	return false
end

local function var_0_65(arg_33_0)
	if not arg_33_0 then
		return false
	end

	ipairs = var_1_10001

	for iter_33_0, iter_33_1 in var_1_10001(arg_33_0) do
		if iter_33_1[2] and var_6[1] == "GETBOAT" then
			return true
		end
	end

	return false
end

local function var_0_66(arg_34_0)
	Ship = var_1_10001

	if var_1_10001.isMetaShipByConfigID(arg_34_0.shipId) then
		MetaCharacterConst = var_1

		local var_34_0 = var_1.GetMetaShipGroupIDByConfigID(arg_34_0.shipId)

		getProxy = var_1_10002
		MetaCharacterProxy = var_1_10004

		local var_34_1 = var_1_10002(var_1_10004)
		local var_34_2

		if var_2.getMetaProgressVOByID(var_34_1, var_34_0) and not var_2:isInAct() then
			var_34_2 = var_2:isInArchive()
		end

		local var_34_3 = var_0_64(arg_34_0.list)
		local var_34_4 = var_0_65(arg_34_0.list)

		return var_34_2 or var_34_3 or var_34_4
	end

	return true
end

local function var_0_67(arg_35_0, arg_35_1)
	arg_35_0:commonSetting(arg_35_1)

	local var_35_0 = arg_35_0._window

	Vector2 = var_1_10003
	var_35_0.sizeDelta = var_1_10003(arg_35_0._defaultSize.x, 520)
	setActive = var_35_0

	var_35_0(arg_35_0._obtainPanel, true)

	setActive = var_35_0

	var_35_0(arg_35_0._btnContainer, false)

	local var_35_1 = {}

	DROP_TYPE_SHIP = var_3
	var_35_1.type = var_3
	var_35_1.id = arg_35_1.shipId
	updateDrop = var_3

	var_3(arg_35_0._obtainPanel, var_35_1, arg_35_1)

	local var_35_2 = var_0_66(arg_35_1)
	local var_35_3

	if not arg_35_0.obtainSkipList then
		UIItemList = var_35_3
		var_35_3 = var_35_3.New

		local var_35_4 = arg_35_0._obtainPanel
		local var_35_5 = var_6.Find(var_35_4, "skipable_list")
		local var_35_6 = arg_35_0._obtainPanel

		var_35_3 = var_35_3(var_35_5, var_7.Find(var_35_6, "skipable_list/tpl"))
	end

	arg_35_0.obtainSkipList = var_35_3

	local var_35_7 = arg_35_0.obtainSkipList

	var_4.make(var_35_7, function(arg_36_0, arg_36_1, arg_36_2)
		UIItemList = var_2_10003

		if arg_36_0 == var_2_10003.EventUpdate then
			local var_36_0 = arg_35_1.list[arg_36_1 + 1][1]
			local var_36_1 = var_3[2]
			local var_36_2 = var_3[3]

			HXSet = var_2_10007

			local var_36_3 = var_2_10007.hxLan(var_36_0)
			local var_36_4 = arg_36_2:Find("mask/title")
			local var_36_5 = var_7.GetComponent(var_36_4, "ScrollText")

			var_7.SetText(var_36_5, var_36_3)

			setActive = var_7

			local var_36_6 = arg_36_2:Find("skip_btn")
			local var_36_7

			if var_35_2 then
				var_36_7 = var_36_1[1] ~= "" and var_36_1[1] ~= "COLLECTSHIP"
			end

			var_7(var_36_6, var_36_7)

			if var_36_1[1] ~= "" then
				onButton = var_7

				local var_36_8 = arg_35_0
				local var_36_9 = arg_36_2
				local var_36_10 = arg_36_2.Find(var_36_9, "skip_btn")

				local function var_36_11()
					if var_36_2 and var_36_2 ~= 0 then
						getProxy = var_0
						ActivityProxy = var_3_10002

						local var_37_0 = var_0(var_3_10002)

						if var_0.getActivityById(var_37_0, var_36_2) then
							var_3_10003 = var_0

							if var_0.isEnd(var_3_10003) then
								var_3_10003 = var_0.TipsMgr.GetInstance()
								var_3_10001 = var_3_10001.ShowTips
								i18n = var_3_10004

								var_3_10001(var_3_10003, var_3_10004("collection_way_is_unopen"))

								do return end

								goto label_37_0

								if var_36_1[1] == "SHOP" then
									local var_37_1 = var_36_1[2].warp

									NewShopsScene = var_3_10001

									if var_37_1 == var_3_10001.TYPE_MILITARY_SHOP then
										local var_37_2 = var_0.SystemOpenMgr.GetInstance()
										local var_37_3 = var_0.isOpenSystem

										getProxy = var_3_10003
										PlayerProxy = var_3_10005

										local var_37_4 = var_3_10003(var_3_10005)

										if not var_37_3(var_37_2, var_3_10003.getData(var_37_4).level, "MilitaryExerciseMediator") then
											local var_37_5 = var_0.TipsMgr.GetInstance()
											local var_37_6 = var_0.ShowTips

											i18n = var_3_10003

											var_37_6(var_37_5, var_3_10003("military_shop_no_open_tip"))

											do return end

											goto label_37_0
										end
									end
								end

								if var_36_1[1] == "LEVEL" and var_36_1[2] then
									local var_37_7 = var_36_1[2].chapterid

									getProxy = var_3_10001
									ChapterProxy = var_3_10003
									var_3_10004 = var_3_10001(var_3_10003)

									local var_37_8 = var_3_10001.getChapterById(var_3_10004, var_37_7)

									if var_2.isUnlock(var_37_8) then
										if var_3_10001:getActiveChapter() and var_3_10003.id ~= var_37_7 then
											var_3_10006 = arg_35_0
											var_3_10004 = var_3_10004.ShowMsgBox

											local var_37_9 = {}

											i18n = var_3_10008
											var_37_9.content = var_3_10008("collect_chapter_is_activation")

											function var_37_9.onYes()
												local var_38_0 = var_0.m02
												local var_38_1 = var_0.sendNotification

												GAME = var_4_10003

												local var_38_2 = var_4_10003.CHAPTER_OP
												local var_38_3 = {}

												ChapterConst = var_4_10005
												var_38_3.type = var_4_10005.OpRetreat

												var_38_1(var_38_0, var_38_2, var_38_3)

												return
											end

											var_3_10004(var_3_10006, var_37_9)

											return
										else
											var_3_10004 = {
												mapIdx = var_2:getConfig("map")
											}

											if var_2.active then
												var_3_10004.chapterId = var_2.id
											else
												var_3_10004.openChapterId = var_37_7
											end

											local var_37_10 = var_0.m02
											local var_37_11 = var_5.sendNotification

											GAME = var_8

											local var_37_12 = var_8.GO_SCENE

											SCENE = var_3_10009

											var_37_11(var_37_10, var_37_12, var_3_10009.LEVEL, var_3_10004)
										end
									else
										local var_37_13 = var_0.TipsMgr.GetInstance()

										var_3_10003 = var_3_10003.ShowTips
										i18n = var_3_10006

										var_3_10003(var_37_13, var_3_10006("acquisitionmode_is_not_open"))

										return
									end
								elseif var_36_1[1] == "COLLECTSHIP" then
									local var_37_14 = arg_35_1.mediatorName

									CollectionMediator = var_3_10001

									if var_37_14 == var_3_10001.__cname then
										local var_37_15 = var_0.m02
										local var_37_16 = var_0.sendNotification

										CollectionMediator = var_3_10003

										var_37_16(var_37_15, var_3_10003.EVENT_OBTAIN_SKIP, {
											toggle = 2,
											displayGroupId = var_36_1[2].shipGroupId
										})
									else
										local var_37_17 = var_0.m02
										local var_37_18 = var_0.sendNotification

										GAME = var_3_10003
										var_3_10003 = var_3_10003.GO_SCENE
										SCENE = var_3_10004

										var_37_18(var_37_17, var_3_10003, var_3_10004.COLLECTSHIP, {
											toggle = 2,
											displayGroupId = var_36_1[2].shipGroupId
										})
									end
								elseif var_36_1[1] == "SHOP" then
									local var_37_19 = var_0.m02
									local var_37_20 = var_0.sendNotification

									GAME = var_3_10003
									var_3_10003 = var_3_10003.GO_SCENE
									SCENE = var_3_10004

									var_37_20(var_37_19, var_3_10003, var_3_10004[var_36_1[1]], var_36_1[2])
								else
									local var_37_21 = var_0.m02
									local var_37_22 = var_0.sendNotification

									GAME = var_3_10003

									local var_37_23 = var_3_10003.GO_SCENE

									SCENE = var_3_10004

									var_37_22(var_37_21, var_37_23, var_3_10004[var_36_1[1]], var_36_1[2])
								end
							end

							::label_37_0::

							local var_37_24 = arg_35_0

							var_0.hide(var_37_24)

							return
						end
					end
				end

				SFX_PANEL = var_36_9

				var_7(var_36_8, var_36_10, var_36_11, var_36_9)
			end
		end

		return
	end)

	local var_35_8 = arg_35_0.obtainSkipList

	var_4.align(var_35_8, #arg_35_1.list)
	arg_35_0:Loaded(arg_35_1)

	return
end

function var_1.nextPage(arg_39_0)
	arg_39_0.helpPage = arg_39_0.helpPage + 1

	if arg_39_0.helpPage < 1 then
		arg_39_0.helpPage = 1
	end

	if arg_39_0.helpPage > arg_39_0._helpList.childCount then
		arg_39_0.helpPage = 1
	end

	arg_39_0:switchHelpPage(arg_39_0.helpPage)

	return
end

function var_1.prePage(arg_40_0)
	arg_40_0.helpPage = arg_40_0.helpPage - 1

	if arg_40_0.helpPage < 1 then
		arg_40_0.helpPage = arg_40_0._helpList.childCount
	end

	if arg_40_0.helpPage > arg_40_0._helpList.childCount then
		arg_40_0.helpPage = arg_40_0._helpList.childCount
	end

	arg_40_0:switchHelpPage(arg_40_0.helpPage)

	return
end

function var_1.switchHelpPage(arg_41_0, arg_41_1)
	for iter_41_0 = 1, arg_41_0._helpList.childCount do
		local var_41_0 = arg_41_0._helpList
		local var_41_1 = var_6.GetChild(var_41_0, iter_41_0 - 1)

		setActive = var_1_10007

		var_1_10007(var_41_1, arg_41_1 == iter_41_0)

		setText = var_1_10007

		var_1_10007(var_41_1:Find("icon/corner/Text"), iter_41_0)
	end

	return
end

function var_1.commonSetting(arg_42_0, arg_42_1)
	rtf = var_1_10002

	local var_42_0 = var_1_10002(arg_42_0._window)

	var_42_0.sizeDelta = arg_42_0._defaultSize
	rtf = var_42_0
	var_42_0(arg_42_0._helpPanel).sizeDelta = arg_42_0._defaultHelpSize
	arg_42_0.enable = true

	var_0.DelegateInfo.New(arg_42_0)

	setActive = var_2

	var_2(arg_42_0._msgPanel, false)

	setActive = var_2

	var_2(arg_42_0._exchangeShipPanel, false)

	setActive = var_2

	var_2(arg_42_0._itemPanel, false)

	setActive = var_2

	var_2(arg_42_0._eskinPanel, false)

	setActive = var_2

	var_2(arg_42_0._sigleItemPanel, false)

	setActive = var_2

	var_2(arg_42_0._inputPanel, false)

	setActive = var_2

	var_2(arg_42_0._obtainPanel, false)

	setActive = var_2

	var_2(arg_42_0._otherPanel, false)

	setActive = var_2

	var_2(arg_42_0._worldResetPanel, false)

	setActive = var_2

	var_2(arg_42_0._worldShopBtn, false)

	setActive = var_2

	var_2(arg_42_0._helpBgTF, false)

	setActive = var_2

	var_2(arg_42_0._helpPanel, arg_42_1.helps)

	pairs = var_2

	for iter_42_0, iter_42_1 in var_2(arg_42_0.panelDict) do
		local var_42_1 = iter_42_1.buffer

		var_7.Hide(var_42_1)
	end

	setActive = var_2

	var_2(arg_42_0._btnContainer, true)

	local var_42_2 = arg_42_0.stopRemindToggle
	local var_42_3

	if not arg_42_1.toggleStatus then
		var_42_3 = false
	end

	var_42_2.isOn = var_42_3
	setActive = var_42_2
	go = var_4

	var_42_2(var_4(arg_42_0.stopRemindToggle), arg_42_1.showStopRemind)

	local var_42_4 = arg_42_0.stopRemindText
	local var_42_5

	if not arg_42_1.stopRamindContent then
		i18n = var_42_5
		var_42_5 = var_42_5("dont_remind_today")
	end

	var_42_4.text = var_42_5
	removeAllChildren = var_42_4

	var_42_4(arg_42_0._btnContainer)

	arg_42_0.settings = arg_42_1
	SetActive = var_42_4

	var_42_4(arg_42_0._go, true)

	local var_42_6

	if not arg_42_0.settings.needCounter then
		var_42_6 = false
	end

	setActive = var_42_5

	var_42_5(arg_42_0._countSelect, var_42_6)

	local var_42_7 = arg_42_0.settings.numUpdate
	local var_42_8

	if not arg_42_0.settings.addNum then
		var_42_8 = 1
	end

	local var_42_9

	if not arg_42_0.settings.maxNum then
		var_42_9 = -1
	end

	local var_42_10

	if not arg_42_0.settings.defaultNum then
		var_42_10 = 1
	end

	local var_42_11 = arg_42_0._pageUtil

	var_7.setNumUpdate(var_42_11, function(arg_43_0)
		if var_42_7 ~= nil then
			var_42_7(arg_42_0._countDescTxt, arg_43_0)
		end

		return
	end)

	local var_42_12 = arg_42_0._pageUtil

	var_7.setAddNum(var_42_12, var_42_8)

	local var_42_13 = arg_42_0._pageUtil

	var_7.setMaxNum(var_42_13, var_42_9)

	local var_42_14 = arg_42_0._pageUtil

	var_7.setDefaultNum(var_42_14, var_42_10)

	setActive = var_7

	var_7(arg_42_0._sliders, arg_42_0.settings.discount)

	local var_42_16

	if arg_42_0.settings.discount then
		local var_42_15 = arg_42_0._discount

		var_42_16 = var_42_16.GetComponent
		typeof = var_10
		Text = var_1_10012
		var_42_16 = var_42_16(var_42_15, var_10(var_1_10012))
		var_42_16.text = arg_42_0.settings.discount.discount .. "%OFF"

		local var_42_17 = arg_42_0._discountDate

		var_42_16 = var_42_16.GetComponent
		typeof = var_10
		Text = var_1_10012
		var_42_16 = var_42_16(var_42_17, var_10(var_1_10012))
		var_42_16.text = arg_42_0.settings.discount.date
	end

	setActive = var_42_16

	var_42_16(arg_42_0._remasterPanel, arg_42_0.settings.remaster)

	if arg_42_0.settings.remaster then
		local var_42_18 = arg_42_0.settings.remaster

		setText = var_1_10008
		var_1_10012 = arg_42_0._remasterPanel

		var_1_10008(var_10.Find(var_1_10012, "content/Text"), var_42_18.word)

		setText = var_1_10008
		var_1_10012 = arg_42_0._remasterPanel

		local var_42_19 = var_10.Find(var_1_10012, "content/count")
		local var_42_20

		if not var_42_18.number then
			var_42_20 = ""
		end

		var_1_10008(var_42_19, var_42_20)

		setText = var_1_10008
		var_1_10012 = arg_42_0._remasterPanel

		var_1_10008(var_10.Find(var_1_10012, "btn/pic"), var_42_18.btn_text)

		onButton = var_1_10008

		local var_42_21 = arg_42_0
		local var_42_22 = arg_42_0._remasterPanel

		var_1_10008(var_42_21, var_11.Find(var_42_22, "btn"), function()
			if var_42_18.btn_call then
				var_42_18.btn_call()
			end

			local var_44_0 = arg_42_0

			var_0.hide(var_44_0)

			return
		end)
	end

	local var_42_23

	if not arg_42_0.settings.hideNo then
		var_42_23 = false
	end

	local var_42_24

	if not arg_42_0.settings.hideYes then
		var_42_24 = false
	end

	local var_42_25

	if not arg_42_0.settings.modal then
		var_42_25 = false
	end

	local var_42_26

	if not arg_42_0.settings.onYes then
		function var_42_26()
			return
		end
	end

	local var_42_27

	if not arg_42_0.settings.onNo then
		function var_42_27()
			return
		end
	end

	onButton = var_1_10012

	local var_42_28 = arg_42_0

	tf = var_1_10015

	local var_42_29 = var_1_10015(arg_42_0._go)
	local var_42_30 = var_15.Find(var_42_29, "bg")

	local function var_42_31()
		if arg_42_0.settings.onClose then
			arg_42_0.settings.onClose()
		else
			var_42_27()
		end

		local var_47_0 = arg_42_0

		var_0.hide(var_47_0)

		return
	end

	SFX_CANCEL = var_42_29

	var_1_10012(var_42_28, var_42_30, var_42_31, var_42_29)

	SetCompomentEnabled = var_1_10012
	tf = var_42_28

	local var_42_32 = var_42_28(arg_42_0._go)
	local var_42_33 = var_14.Find(var_42_32, "bg")

	typeof = var_42_30
	Button = var_17

	var_1_10012(var_42_33, var_42_30(var_17), not var_42_25)

	local var_42_34
	local var_42_35
	local var_42_36

	if not var_42_23 then
		var_42_36 = arg_42_0

		local var_42_37 = arg_42_0.createBtn
		local var_42_38 = {}
		local var_42_39

		if not arg_42_0.settings.noText then
			var_42_39 = var_0.TEXT_CANCEL
		end

		var_42_38.text = var_42_39

		local var_42_40

		if not arg_42_0.settings.noBtnType then
			var_42_40 = var_0.BUTTON_GRAY
		end

		var_42_38.btnType = var_42_40
		var_42_38.onCallback = var_42_27

		if not arg_42_1.noSound then
			SFX_CANCEL = var_18
		end

		var_42_38.sound = var_18

		local var_42_41 = var_42_37(var_42_36, var_42_38)
	end

	if not var_42_24 then
		var_42_36 = arg_42_0

		local var_42_42 = arg_42_0.createBtn
		local var_42_43 = {}
		local var_42_44

		if not arg_42_0.settings.yesText then
			var_42_44 = var_0.TEXT_CONFIRM
		end

		var_42_43.text = var_42_44

		local var_42_45

		if not arg_42_0.settings.yesBtnType then
			var_42_45 = var_0.BUTTON_BLUE
		end

		var_42_43.btnType = var_42_45
		var_42_43.onCallback = var_42_26

		if not arg_42_1.yesSound then
			SFX_CONFIRM = var_18
		end

		var_42_43.sound = var_18

		local var_42_46

		if arg_42_0.settings.yesSize then
			TextAnchor = var_42_46
			var_42_46 = var_42_46.MiddleCenter
		end

		var_42_43.alignment = var_42_46
		var_42_43.gray = arg_42_0.settings.yesGray
		var_42_43.delayButton = arg_42_0.settings.delayConfirm
		var_42_35 = var_42_42(var_42_36, var_42_43)

		if arg_42_0.settings.yesSize then
			var_42_35.sizeDelta = arg_42_0.settings.yesSize
		end
	end

	if arg_42_0.settings.yseBtnLetf then
		var_42_36 = var_42_35

		var_42_35.SetAsFirstSibling(var_42_36)
	end

	local var_42_47
	local var_42_48 = arg_42_0.settings.type

	MSGBOX_TYPE_HELP = var_42_36

	if var_42_48 == var_42_36 and arg_42_0.settings.helps.pageMode and #arg_42_0.settings.helps > 1 then
		local var_42_49 = arg_42_0
		local var_42_50 = arg_42_0.createBtn
		local var_42_51 = {
			noQuit = true,
			btnType = var_0.BUTTON_PREPAGE,
			onCallback = function()
				local var_48_0 = arg_42_0

				var_0.prePage(var_48_0)

				return
			end
		}

		SFX_CANCEL = var_19
		var_42_51.sound = var_19

		var_42_50(var_42_49, var_42_51)

		var_42_47 = #arg_42_0.settings.helps
	end

	if arg_42_0.settings.custom ~= nil then
		ipairs = var_42_53

		for iter_42_2, iter_42_3 in var_42_53(arg_42_0.settings.custom) do
			arg_42_0:createBtn(iter_42_3)
		end
	end

	local var_42_53

	if not var_42_47 then
		-- block empty
	elseif 1 < var_42_47 then
		local var_42_52 = arg_42_0

		var_42_53 = arg_42_0.createBtn

		local var_42_54 = {
			noQuit = true,
			btnType = var_0.BUTTON_NEXTPAGE,
			onCallback = function()
				local var_49_0 = arg_42_0

				var_0.nextPage(var_49_0)

				return
			end
		}

		SFX_CONFIRM = var_19
		var_42_54.sound = var_19

		var_42_53(var_42_52, var_42_54)
	end

	setActive = var_42_53

	var_42_53(arg_42_0._closeBtn, not arg_42_1.hideClose)

	onButton = var_42_53

	local var_42_55 = arg_42_0
	local var_42_56 = arg_42_0._closeBtn

	local function var_42_57()
		local var_50_0 = arg_42_0.settings.onClose

		if arg_42_0.settings and arg_42_0.settings.hideClose and not var_50_0 and arg_42_0.settings.onYes then
			arg_42_0.settings.onYes()
		end

		local var_50_1 = arg_42_0

		var_1.hide(var_50_1)

		if var_50_0 then
			var_50_0()
		else
			var_42_27()
		end

		return
	end

	SFX_CANCEL = var_1_10020

	var_42_53(var_42_55, var_42_56, var_42_57, var_1_10020)

	local var_42_58

	if not arg_42_0.settings.title then
		var_42_58 = var_0.TITLE_INFORMATION
	end

	local var_42_59 = 0
	local var_42_60 = arg_42_0._titleList.transform.childCount

	while var_42_59 < var_42_60 do
		var_1_10020 = arg_42_0._titleList.transform

		local var_42_61 = var_18.GetChild(var_1_10020, var_42_59)

		SetActive = var_42_57

		var_42_57(var_42_61, var_42_61.name == var_42_58)

		var_42_59 = var_42_59 + 1
	end

	local var_42_62 = arg_42_0._go.transform.localPosition
	local var_42_63 = arg_42_0._go.transform

	Vector3 = var_1_10020

	local var_42_64 = var_42_62.x
	local var_42_65 = var_42_62.y
	local var_42_66

	if not arg_42_0.settings.zIndex then
		var_42_66 = 0
	end

	var_42_63.localPosition = var_1_10020(var_42_64, var_42_65, var_42_66)

	local var_42_67

	if not arg_42_0.settings.locked then
		var_42_67 = false
	end

	arg_42_0.locked = var_42_67

	return
end

function var_1.createBtn(arg_51_0, arg_51_1)
	local var_51_0

	if not arg_51_1.btnType then
		var_51_0 = var_0.BUTTON_BLUE
	end

	local var_51_1 = arg_51_1.noQuit
	local var_51_2 = arg_51_0._go.transform
	local var_51_3 = var_4.Find(var_51_2, "custom_btn_list/custom_button_" .. var_51_0)

	cloneTplTo = var_1_10005

	local var_51_4 = var_1_10005(var_51_3, arg_51_0._btnContainer)
	local var_51_5

	if arg_51_1.label then
		go = var_51_5
		var_51_5 = var_51_5(var_51_4)
		var_51_5.name = arg_51_1.label
	end

	SetActive = var_51_5

	var_51_5(var_51_4, true)

	if arg_51_1.scale then
		local var_51_6

		if not arg_51_1.scale.x then
			var_51_6 = 1
		end

		local var_51_7

		if not arg_51_1.scale.y then
			var_51_7 = 1
		end

		Vector2 = var_8
		var_51_4.localScale = var_8(var_51_6, var_51_7)
	end

	local var_51_8
	local var_51_9

	if var_51_0 == var_0.BUTTON_MEDAL then
		setText = var_7
		var_1_10011 = var_51_4

		var_7(var_51_4.Find(var_1_10011, "text"), arg_51_1.text)

		var_51_9 = var_51_4
		var_51_8 = var_51_4.Find(var_51_9, "text")
	elseif var_51_0 ~= var_0.BUTTON_RETREAT and var_51_0 ~= var_0.BUTTON_PREPAGE and var_51_0 ~= var_0.BUTTON_NEXTPAGE then
		var_51_9 = arg_51_0

		arg_51_0.updateButton(var_51_9, var_51_4, arg_51_1.text, arg_51_1.alignment)

		var_51_9 = var_51_4
		var_51_8 = var_51_4.Find(var_51_9, "pic")
	end

	if var_51_0 == var_0.BUTTON_BLUE_WITH_ICON and arg_51_1.iconName then
		var_51_9 = var_51_4
		var_1_10010, setImageSprite = var_51_4.Find(var_51_9, "ticket/icon"), var_8
		LoadSprite = var_1_10011

		var_8(var_1_10010, var_1_10011(arg_51_1.iconName[1], arg_51_1.iconName[2]))
	end

	local var_51_10
	local var_51_11

	if arg_51_1.delayButton then
		var_51_11 = arg_51_1.delayButton
		getText = var_51_9

		local var_51_12 = var_51_9(var_51_8)

		Timer = var_1_10010
		var_51_10 = var_1_10010.New(function()
			var_51_11 = var_51_11 - 1

			if var_51_11 > 0 then
				setText = var_0

				local var_52_0 = var_51_8
				local var_52_1 = var_51_12

				string = var_2_10004

				var_0(var_52_0, var_52_1 .. var_2_10004.format("(%d)", var_51_11))
			else
				setText = var_0

				var_0(var_51_8, var_51_12)

				setGray = var_0

				var_0(var_51_4, arg_51_1.gray, true)

				var_51_10 = nil
			end

			return
		end, 1, var_51_11)
		arg_51_0.timers[var_51_4] = var_51_10

		var_51_10:Start()

		setText = var_10

		local var_51_13 = var_51_8
		local var_51_14 = var_51_12

		string = var_14

		var_10(var_51_13, var_51_14 .. var_14.format("(%d)", var_51_11))

		setGray = var_10

		var_10(var_51_4, true, true)
	else
		setGray = var_51_11

		var_51_11(var_51_4, arg_51_1.gray, true)
	end

	if not arg_51_1.hideEvent then
		onButton = var_8

		local var_51_15 = arg_51_0
		local var_51_16 = var_51_4

		local function var_51_17()
			if var_51_10 then
				return
			end

			type = var_0

			if var_0(var_51_1) == "function" then
				if var_51_1() then
					return
				else
					local var_53_0 = arg_51_0

					var_0.hide(var_53_0)
				end
			elseif not var_51_1 then
				local var_53_1 = arg_51_0

				var_0.hide(var_53_1)
			end

			existCall = var_0

			return var_0(arg_51_1.onCallback)
		end

		if not arg_51_1.sound then
			SFX_CONFIRM = var_13
		end

		var_8(var_51_15, var_51_16, var_51_17, var_13)
	end

	if arg_51_1.sibling then
		var_51_4:SetSiblingIndex(arg_51_1.sibling)
	end

	return var_51_4
end

function var_1.updateButton(arg_54_0, arg_54_1, arg_54_2, arg_54_3)
	local var_54_0 = var_0_53[arg_54_2]
	local var_54_1 = arg_54_1:Find("pic")

	IsNil = var_1_10006

	if var_1_10006(var_54_1) then
		return
	end

	if var_54_0 then
		setText = var_6

		local var_54_2 = var_54_1

		i18n = var_1_10009

		var_6(var_54_2, var_1_10009(var_54_0))
	else
		string = var_6

		local var_54_4

		if var_6.len(arg_54_2) > 12 then
			GetComponent = var_54_4

			local var_54_3 = var_54_1

			typeof = var_1_10009
			Text = var_1_10011
			var_54_4 = var_54_4(var_54_3, var_1_10009(var_1_10011))
			var_54_4.resizeTextForBestFit = true
		end

		setText = var_54_4

		var_54_4(var_54_1, arg_54_2)
	end

	if arg_54_3 then
		local var_54_5 = var_54_1
		local var_54_6 = var_54_1.GetComponent

		typeof = var_1_10009
		Text = var_1_10011
		var_54_6(var_54_5, var_1_10009(var_1_10011)).alignment = arg_54_3
	end

	return
end

function var_1.Loaded(arg_55_0, arg_55_1)
	local var_55_0 = var_0.UIMgr.GetInstance()

	var_2.BlurPanel(var_55_0, arg_55_0._tf, {
		groupName = arg_55_1.groupName,
		parent = arg_55_1.parent
	})

	local var_55_1 = var_0.m02
	local var_55_2 = var_2.sendNotification

	GAME = var_5

	var_55_2(var_55_1, var_5.OPEN_MSGBOX_DONE)

	return
end

function var_1.Clear(arg_56_0)
	pairs = var_1_10001

	for iter_56_0, iter_56_1 in var_1_10001(arg_56_0.panelDict) do
		iter_56_1:Destroy()
	end

	table = var_1

	var_1.clear(arg_56_0.panelDict)

	rtf = var_1

	local var_56_0 = var_1(arg_56_0._window)

	var_56_0.sizeDelta = arg_56_0._defaultSize
	rtf = var_56_0

	local var_56_1 = var_56_0(arg_56_0._helpPanel)

	var_56_1.sizeDelta = arg_56_0._defaultHelpSize
	setAnchoredPosition = var_56_1

	var_56_1(arg_56_0._window, {
		x = 0,
		y = 0
	})

	setAnchoredPosition = var_56_1

	var_56_1(arg_56_0._btnContainer, {
		y = 15
	})

	setAnchoredPosition = var_56_1

	var_56_1(arg_56_0._helpPanel, {
		x = arg_56_0._defaultHelpPos.x,
		y = arg_56_0._defaultHelpPos.y
	})

	SetCompomentEnabled = var_56_1

	local var_56_2 = arg_56_0._helpPanel
	local var_56_3 = var_3.Find(var_56_2, "list")

	typeof = var_4
	ScrollRect = var_6

	var_56_1(var_56_3, var_4(var_6), true)

	setActive = var_56_1

	var_56_1(arg_56_0._top, true)

	setActive = var_56_1
	findTF = var_3

	var_56_1(var_3(arg_56_0._window, "bg"), true)

	setActive = var_56_1

	local var_56_4 = arg_56_0._sigleItemPanel

	var_56_1(var_3.Find(var_56_4, "left/own"), false)

	local var_56_5 = arg_56_0._sigleItemPanel
	local var_56_6 = var_1.Find(var_56_5, "left/IconTpl")

	SetCompomentEnabled = var_2

	local var_56_7 = var_56_6:Find("icon_bg")

	typeof = var_56_4
	Image = var_7

	var_2(var_56_7, var_56_4(var_7), true)

	SetCompomentEnabled = var_2

	local var_56_8 = var_56_6:Find("icon_bg/frame")

	typeof = var_5
	Image = var_7

	var_2(var_56_8, var_5(var_7), true)

	setActive = var_2

	var_2(var_56_6:Find("icon_bg/slv"), false)

	setActive = var_2

	var_2(arg_56_0.singleItemIntro, false)

	setText = var_2

	var_2(arg_56_0._singleItemSubIntroTF, "")

	for iter_56_2 = 0, arg_56_0._helpList.childCount - 1 do
		local var_56_9 = arg_56_0._helpList
		local var_56_10 = var_6.GetChild(var_56_9, iter_56_2)
		local var_56_11 = var_6.Find(var_56_10, "icon")
		local var_56_12 = var_6.GetComponent

		typeof = var_9
		Image = var_1_10011
		var_56_12(var_56_11, var_9(var_1_10011)).sprite = nil
	end

	pairs = var_2

	for iter_56_3, iter_56_4 in var_2(arg_56_0.pools) do
		if iter_56_4 then
			PoolMgr = var_7

			local var_56_13 = var_7.GetInstance()

			var_7.ReturnUI(var_56_13, iter_56_4.name, iter_56_4)
		end
	end

	arg_56_0.pools = {}
	pairs = var_2

	for iter_56_5, iter_56_6 in var_2(arg_56_0.timers) do
		iter_56_6:Stop()
	end

	arg_56_0.timers = {}

	var_0.DelegateInfo.Dispose(arg_56_0)

	removeAllChildren = var_2

	var_2(arg_56_0._btnContainer)

	local var_56_14 = var_0.UIMgr.GetInstance()

	var_2.UnOverlayPanel(var_56_14, arg_56_0._tf, var_0.UIMgr.GetInstance().OverlayMain)

	local var_56_15 = arg_56_0.contentText

	var_2.RemoveAllListeners(var_56_15)

	arg_56_0.settings = nil
	arg_56_0.enable = false
	arg_56_0.locked = nil

	return
end

function var_1.ShowMsgBox(arg_57_0, arg_57_1)
	if arg_57_0.locked then
		return
	end

	if not arg_57_1.type then
		MSGBOX_TYPE_NORMAL = var_2
	end

	switch = var_1_10003

	local var_57_0 = var_2
	local var_57_1 = {}

	MSGBOX_TYPE_NORMAL = var_1_10007
	var_57_1[var_1_10007] = function()
		var_0_54(arg_57_0, arg_57_1)

		return
	end
	MSGBOX_TYPE_INPUT = var_1_10007
	var_57_1[var_1_10007] = function()
		var_0_55(arg_57_0, arg_57_1)

		return
	end
	MSGBOX_TYPE_SINGLE_ITEM = var_1_10007
	var_57_1[var_1_10007] = function()
		var_0_60(arg_57_0, arg_57_1)

		return
	end
	MSGBOX_TYPE_EXCHANGE = var_1_10007
	var_57_1[var_1_10007] = function()
		var_0_56(arg_57_0, arg_57_1)

		return
	end
	MSGBOX_TYPE_DROP_ITEM = var_1_10007
	var_57_1[var_1_10007] = function()
		var_0_59(arg_57_0, arg_57_1)

		return
	end
	MSGBOX_TYPE_ITEM_BOX = var_1_10007
	var_57_1[var_1_10007] = function()
		var_0_57(arg_57_0, arg_57_1)

		return
	end
	MSGBOX_TYPE_DROP_ITEM_ESKIN = var_1_10007
	var_57_1[var_1_10007] = function()
		var_0_58(arg_57_0, arg_57_1)

		return
	end
	MSGBOX_TYPE_HELP = var_1_10007
	var_57_1[var_1_10007] = function()
		local var_65_0 = arg_57_1

		defaultValue = var_2_10001
		var_65_0.hideNo = var_2_10001(arg_57_1.hideNo, true)

		local var_65_1 = arg_57_1

		defaultValue = var_1
		var_65_1.hideYes = var_1(arg_57_1.hideYes, true)

		var_0_61(arg_57_0, arg_57_1)

		return
	end
	MSGBOX_TYPE_SECONDPWD = var_1_10007
	var_57_1[var_1_10007] = function()
		PoolMgr = var_2_10000

		local var_66_0 = var_2_10000.GetInstance()

		var_0.GetUI(var_66_0, "Msgbox4SECPWD", true, function(arg_67_0)
			arg_57_0.pools.SedondaryUI = arg_67_0

			if arg_57_1.onPreShow then
				arg_57_1.onPreShow()
			end

			local var_67_0 = arg_57_1

			var_67_0.secondaryUI = arg_67_0
			SetParent = var_67_0

			var_67_0(arg_67_0, arg_57_0._otherPanel, false)
			var_0_62(arg_57_0, arg_57_1)

			return
		end)

		return
	end
	MSGBOX_TYPE_WORLD_RESET = var_1_10007
	var_57_1[var_1_10007] = function()
		var_0_63(arg_57_0, arg_57_1)

		return
	end
	MSGBOX_TYPE_OBTAIN = var_1_10007
	var_57_1[var_1_10007] = function()
		local var_69_0 = arg_57_1
		local var_69_1

		if not arg_57_1.title then
			var_69_1 = var_0.TITLE_OBTAIN
		end

		var_69_0.title = var_69_1

		var_0_67(arg_57_0, arg_57_1)

		return
	end
	MSGBOX_TYPE_ITEMTIP = var_1_10007
	var_57_1[var_1_10007] = function()
		local var_70_0 = arg_57_0
		local var_70_1 = var_0.GetPanel

		ItemTipPanel = var_2_10003

		local var_70_2 = var_70_1(var_70_0, var_2_10003).buffer

		var_1.UpdateView(var_70_2, arg_57_1)

		return
	end
	MSGBOX_TYPE_JUST_FOR_SHOW = var_1_10007
	var_57_1[var_1_10007] = function()
		local var_71_0 = arg_57_0
		local var_71_1 = var_0.GetPanel

		ItemShowPanel = var_2_10003

		local var_71_2 = var_71_1(var_71_0, var_2_10003).buffer

		var_1.UpdateView(var_71_2, arg_57_1)

		return
	end
	MSGBOX_TYPE_MONTH_CARD_TIP = var_1_10007
	var_57_1[var_1_10007] = function()
		local var_72_0 = arg_57_0
		local var_72_1 = var_0.GetPanel

		MonthCardOutDateTipPanel = var_2_10003

		local var_72_2 = var_72_1(var_72_0, var_2_10003).buffer

		var_1.UpdateView(var_72_2, arg_57_1)

		return
	end
	MSGBOX_TYPE_STORY_CANCEL_TIP = var_1_10007
	var_57_1[var_1_10007] = function()
		local var_73_0 = arg_57_0
		local var_73_1 = var_0.GetPanel

		StoryCancelTipPanel = var_2_10003

		local var_73_2 = var_73_1(var_73_0, var_2_10003).buffer

		var_1.UpdateView(var_73_2, arg_57_1)

		return
	end
	MSGBOX_TYPE_META_SKILL_UNLOCK = var_1_10007
	var_57_1[var_1_10007] = function()
		local var_74_0 = arg_57_0
		local var_74_1 = var_0.GetPanel

		MetaSkillUnlockPanel = var_2_10003

		local var_74_2 = var_74_1(var_74_0, var_2_10003).buffer

		var_1.UpdateView(var_74_2, arg_57_1)

		return
	end
	MSGBOX_TYPE_ACCOUNTDELETE = var_1_10007
	var_57_1[var_1_10007] = function()
		local var_75_0 = arg_57_0
		local var_75_1 = var_0.GetPanel

		AccountDeletePanel = var_2_10003

		local var_75_2 = var_75_1(var_75_0, var_2_10003).buffer

		var_1.UpdateView(var_75_2, arg_57_1)

		return
	end
	MSGBOX_TYPE_STRENGTHEN_BACK = var_1_10007
	var_57_1[var_1_10007] = function()
		local var_76_0 = arg_57_0
		local var_76_1 = var_0.GetPanel

		StrengthenBackPanel = var_2_10003

		local var_76_2 = var_76_1(var_76_0, var_2_10003).buffer

		var_1.UpdateView(var_76_2, arg_57_1)

		return
	end
	MSGBOX_TYPE_CONTENT_ITEMS = var_1_10007
	var_57_1[var_1_10007] = function()
		local var_77_0 = arg_57_0
		local var_77_1 = var_0.GetPanel

		Msgbox4ContentItems = var_2_10003

		local var_77_2 = var_77_1(var_77_0, var_2_10003).buffer

		var_1.UpdateView(var_77_2, arg_57_1)

		return
	end
	MSGBOX_TYPE_BLUEPRINT_UNLOCK_ITEM = var_1_10007
	var_57_1[var_1_10007] = function()
		local var_78_0 = arg_57_0
		local var_78_1 = var_0.GetPanel

		Msgbox4BlueprintUnlockItem = var_2_10003

		local var_78_2 = var_78_1(var_78_0, var_2_10003).buffer

		var_1.UpdateView(var_78_2, arg_57_1)

		return
	end
	MSGBOX_TYPE_CONFIRM_DELETE = var_1_10007
	var_57_1[var_1_10007] = function()
		local var_79_0 = arg_57_0
		local var_79_1 = var_0.GetPanel

		ConfirmEquipmentDeletePanel = var_2_10003

		local var_79_2 = var_79_1(var_79_0, var_2_10003).buffer

		var_1.UpdateView(var_79_2, arg_57_1)

		return
	end
	MSGBOX_TYPE_CONFIRM_REFORGE_SPWEAPON = var_1_10007
	var_57_1[var_1_10007] = function()
		local var_80_0 = arg_57_0
		local var_80_1 = var_0.GetPanel

		Msgbox4SpweaponConfirm = var_2_10003

		local var_80_2 = var_80_1(var_80_0, var_2_10003).buffer

		var_1.UpdateView(var_80_2, arg_57_1)

		return
	end
	MSGBOX_TYPE_SUBPATTERN = var_1_10007
	var_57_1[var_1_10007] = function()
		local var_81_0 = arg_57_0
		local var_81_1 = var_0.GetPanel(var_81_0, arg_57_1.patternClass).buffer

		var_1.UpdateView(var_81_1, arg_57_1)

		return
	end
	MSGBOX_TYPE_FILE_DOWNLOAD = var_1_10007
	var_57_1[var_1_10007] = function()
		local var_82_0 = arg_57_0
		local var_82_1 = var_0.GetPanel

		FileDownloadPanel = var_2_10003

		local var_82_2 = var_82_1(var_82_0, var_2_10003).buffer

		var_1.UpdateView(var_82_2, arg_57_1)

		return
	end
	MSGBOX_TYPE_LIKN_COLLECT_GUIDE = var_1_10007
	var_57_1[var_1_10007] = function()
		local var_83_0 = arg_57_0
		local var_83_1 = var_0.GetPanel

		Msgbox4LinkCollectGuide = var_2_10003

		local var_83_2 = var_83_1(var_83_0, var_2_10003).buffer

		var_1.UpdateView(var_83_2, arg_57_1)

		return
	end

	var_1_10003(var_57_0, var_57_1)

	return
end

function var_1.GetPanel(arg_84_0, arg_84_1)
	if not arg_84_0.panelDict[arg_84_1] then
		arg_84_0.panelDict[arg_84_1] = arg_84_1.New(arg_84_0)

		local var_84_0 = arg_84_0.panelDict[arg_84_1]

		var_2.Load(var_84_0)

		local var_84_1 = arg_84_0.panelDict[arg_84_1].buffer

		var_2.SetParent(var_84_1, arg_84_0._window)
	end

	return arg_84_0.panelDict[arg_84_1]
end

function var_1.CloseAndHide(arg_85_0)
	if not arg_85_0.enable then
		return
	end

	local var_85_0

	if not arg_85_0.settings.onClose and (var_1.hideNo or not var_1.onNo) then
		var_85_0 = nil
	end

	existCall = var_1_10003

	var_1_10003(var_85_0)
	arg_85_0:hide()

	return
end

function var_1.hide(arg_86_0)
	if not arg_86_0.enable then
		return
	end

	local var_86_0 = arg_86_0._go

	var_1.SetActive(var_86_0, false)
	arg_86_0:Clear()

	local var_86_1 = var_0.m02
	local var_86_2 = var_1.sendNotification

	GAME = var_4

	var_86_2(var_86_1, var_4.CLOSE_MSGBOX_DONE)

	return
end

function var_1.emit(arg_87_0, arg_87_1, ...)
	if not arg_87_0.analogyMediator then
		arg_87_0.analogyMediator = {
			addSubLayers = function(arg_88_0, arg_88_1)
				local var_88_0 = var_0.m02
				local var_88_1 = var_2.sendNotification

				GAME = var_2_10005

				local var_88_2 = var_2_10005.LOAD_LAYERS
				local var_88_3 = {}

				getProxy = var_2_10007
				ContextProxy = var_2_10009

				local var_88_4 = var_2_10007(var_2_10009)

				var_88_3.parentContext = var_7.getCurrentContext(var_88_4)
				var_88_3.context = arg_88_1

				var_88_1(var_88_0, var_88_2, var_88_3)

				return
			end,
			sendNotification = function(arg_89_0, ...)
				local var_89_0 = var_0.m02

				var_1.sendNotification(var_89_0, ...)

				return
			end,
			viewComponent = arg_87_0
		}
	end

	ContextMediator = var_2

	return var_2.CommonBindDic[arg_87_1](arg_87_0.analogyMediator, arg_87_1, ...)
end

function var_1.closeView(arg_90_0)
	arg_90_0:hide()

	return
end

return var_1
