class = var_0_10000

local var_0_0 = "LatestSkinShopLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseUI"))

var_0_1.MODE_OVERVIEW = 1
var_0_1.MODE_EXPERIENCE = 2
var_0_1.MODE_EXPERIENCE_FOR_ITEM = 3

local var_0_2 = 1
local var_0_3 = 2
local var_0_4 = 3
local var_0_5 = 1
local var_0_6 = 2
local var_0_7 = 3
local var_0_8 = 4
local var_0_9 = 5
local var_0_10 = 6
local var_0_11 = 7
local var_0_12 = 8
local var_0_13 = -1
local var_0_14 = -2
local var_0_15 = -3
local var_0_16 = -4
local var_0_17 = 9999
local var_0_18 = 9997
local var_0_19 = 9998

var_0_1.EVT_SHOW_OR_HIDE_PURCHASE_VIEW = "NewSkinShopMainView:EVT_SHOW_OR_HIDE_PURCHASE_VIEW"
var_0_1.EVT_ON_PURCHASE = "NewSkinShopMainView:EVT_ON_PURCHASE"

local function var_0_20(arg_1_0)
	if not var_0_1.obtainBtnSpriteNames then
		var_0_1.obtainBtnSpriteNames = {
			[var_0_5] = "yigoumai_button",
			[var_0_6] = "goumai_button",
			[var_0_7] = "qianwanghuoqu_button",
			[var_0_8] = "item_buy",
			[var_0_9] = "furniture_shop",
			[var_0_10] = "tiyan_btn",
			[var_0_11] = "item_buy",
			[var_0_12] = "buy_with_gift"
		}
	end

	return var_0_1.obtainBtnSpriteNames[arg_1_0]
end

function var_0_1.getUIName(arg_2_0)
	return "LatestSkinShopUI"
end

function var_0_1.getGroupName(arg_3_0)
	return "NewShopMainScene"
end

function var_0_1.init(arg_4_0)
	local var_4_0 = arg_4_0._tf

	arg_4_0.bgs = var_1.Find(var_4_0, "bgs")

	local var_4_1 = arg_4_0._tf

	arg_4_0.adapt = var_1.Find(var_4_1, "adapt")

	local var_4_2 = arg_4_0.adapt

	arg_4_0.top = var_1.Find(var_4_2, "top")

	local var_4_3 = arg_4_0.adapt

	arg_4_0.bottom = var_1.Find(var_4_3, "bottom")

	local var_4_4 = arg_4_0.adapt

	arg_4_0.right = var_1.Find(var_4_4, "right")

	local var_4_5 = arg_4_0.adapt

	arg_4_0.subPage = var_1.Find(var_4_5, "subPage")

	local var_4_6 = arg_4_0.adapt

	arg_4_0.resources = var_1.Find(var_4_6, "top/resources")

	local var_4_7 = arg_4_0.adapt

	arg_4_0.limitTime = var_1.Find(var_4_7, "top/title/limit_time/Text")

	local var_4_8 = arg_4_0.adapt

	arg_4_0.skinName = var_1.Find(var_4_8, "top/title/skin_name_mask/skin_name")

	local var_4_9 = arg_4_0.adapt

	arg_4_0.shipName = var_1.Find(var_4_9, "top/title/name_mask/name")

	local var_4_10 = arg_4_0.adapt

	arg_4_0.changeSkin = var_1.Find(var_4_10, "top/change_skin")
	ChangeSkinToggle = var_1

	local var_4_11 = var_1.New

	findTF = var_4_10
	arg_4_0.changeSkinToggle = var_4_11(var_4_10(arg_4_0.changeSkin, "toggle_ui"))

	local var_4_12 = arg_4_0.adapt

	arg_4_0.showOwnBtn = var_1.Find(var_4_12, "bottom/showOwnBtn")

	local var_4_13 = arg_4_0.adapt

	arg_4_0.filterBtn = var_1.Find(var_4_13, "bottom/filterBtn")

	local var_4_14 = arg_4_0.adapt

	arg_4_0.search = var_1.Find(var_4_14, "bottom/search")

	local var_4_15 = arg_4_0.adapt
	local var_4_16 = var_1.Find(var_4_15, "bottom/scroll/content")

	arg_4_0.scrollrect = var_1.GetComponent(var_4_16, "LScrollRect")

	local var_4_17 = arg_4_0.adapt

	arg_4_0.sdTg = var_1.Find(var_4_17, "right/sdTg")

	local var_4_18 = arg_4_0.adapt

	arg_4_0.hideUITg = var_1.Find(var_4_18, "right/hideUITg")

	local var_4_19 = arg_4_0.adapt

	arg_4_0.charContainer = var_1.Find(var_4_19, "right/char_container")

	local var_4_20 = arg_4_0.charContainer

	arg_4_0.backChara = var_1.Find(var_4_20, "bg/back/chara")

	local var_4_21 = arg_4_0.charContainer

	arg_4_0.charTf = var_1.Find(var_4_21, "char")

	local var_4_22 = arg_4_0.charContainer

	arg_4_0.furnitureContainer = var_1.Find(var_4_22, "fur")

	local var_4_23 = arg_4_0.charContainer

	arg_4_0.switchPreviewBtn = var_1.Find(var_4_23, "switch")

	local var_4_24 = arg_4_0.adapt

	arg_4_0.dynamicToggle = var_1.Find(var_4_24, "right/functionsAndTags/dynamic")

	local var_4_25 = arg_4_0.adapt

	arg_4_0.dynamicIcon = var_1.Find(var_4_25, "right/functionsAndTags/dynamic/icon")

	local var_4_26 = arg_4_0.adapt

	arg_4_0.showBgToggle = var_1.Find(var_4_26, "right/functionsAndTags/showBg")

	local var_4_27 = arg_4_0.adapt

	arg_4_0.dynamicResToggle = var_1.Find(var_4_27, "right/functionsAndTags/dynamic/l2d_res_state")
	UIItemList = var_1

	local var_4_28 = var_1.New
	local var_4_29 = arg_4_0.adapt
	local var_4_30 = var_3.Find(var_4_29, "right/functionsAndTags/tags")
	local var_4_31 = arg_4_0.adapt

	arg_4_0.tagList = var_4_28(var_4_30, var_4.Find(var_4_31, "right/functionsAndTags/tags/tag"))

	local var_4_32 = arg_4_0.adapt

	arg_4_0.giftPackBtn = var_1.Find(var_4_32, "right/giftPackBtn")

	local var_4_33 = arg_4_0.adapt

	arg_4_0.price = var_1.Find(var_4_33, "right/price")

	local var_4_34 = arg_4_0.price

	arg_4_0.btns = var_1.Find(var_4_34, "btns")

	local var_4_35 = arg_4_0.adapt

	arg_4_0.filterUI = var_1.Find(var_4_35, "subPage/filterUI")

	local var_4_36 = arg_4_0.filterUI

	arg_4_0.filterContent = var_1.Find(var_4_36, "panelMask/panel/filterScroll/Viewport/Content")

	local var_4_37 = arg_4_0._tf

	arg_4_0.painting = var_1.Find(var_4_37, "painting")

	local var_4_38 = arg_4_0._tf

	arg_4_0.paintingTF = var_1.Find(var_4_38, "painting/paint")
	arg_4_0.defaultPaintingPosition = arg_4_0.paintingTF.anchoredPosition
	arg_4_0.defaultPaintingScale = arg_4_0.paintingTF.localScale

	local var_4_39 = arg_4_0._tf

	arg_4_0.live2dContainer = var_1.Find(var_4_39, "painting/paint/live2d")

	local var_4_40 = arg_4_0._tf

	arg_4_0.spTF = var_1.Find(var_4_40, "painting/paint/spinePainting")

	local var_4_41 = arg_4_0._tf

	arg_4_0.spBg = var_1.Find(var_4_41, "painting/paintBg/spinePainting")
	setActive = var_1

	var_1(arg_4_0.charContainer, false)

	setActive = var_1

	var_1(arg_4_0.filterUI, false)

	local var_4_42 = arg_4_0.adapt

	arg_4_0.mainTitle = var_1.Find(var_4_42, "top/mainTitle")

	local var_4_43 = arg_4_0.adapt

	arg_4_0.backBtn = var_1.Find(var_4_43, "top/closeBtn")

	local var_4_44 = arg_4_0.adapt

	arg_4_0.homeBtn = var_1.Find(var_4_44, "top/homeBtn")

	local var_4_45 = arg_4_0.adapt

	arg_4_0.giftPack = var_1.Find(var_4_45, "giftPack")
	setActive = var_1

	var_1(arg_4_0.mainTitle, false)

	setActive = var_1

	var_1(arg_4_0.backBtn, false)

	setActive = var_1

	var_1(arg_4_0.homeBtn, false)

	setActive = var_1

	var_1(arg_4_0.giftPack, false)

	arg_4_0.downloads = {}
	arg_4_0.isToggleDynamic = false
	arg_4_0.isToggleShowBg = true
	arg_4_0.isPreviewFurniture = false
	BackYardInteractionPreview = var_1

	local var_4_46 = var_1.New
	local var_4_47 = arg_4_0.furnitureContainer

	Vector3 = var_4
	arg_4_0.interactionPreview = var_4_46(var_4_47, var_4(0, 0, 0))
	SkinVoucherMsgBox = var_1

	local var_4_48 = var_1.New

	pg = var_4_47
	arg_4_0.voucherMsgBox = var_4_48(var_4_47.UIMgr.GetInstance().OverlayMain)
	NewSkinShopPurchaseView = var_1
	arg_4_0.purchaseView = var_1.New(arg_4_0._tf, arg_4_0.event)

	arg_4_0:RegisterEvent()

	setGray = var_1

	local var_4_49 = arg_4_0.btns

	var_1(var_3.Find(var_4_49, "yigoumai_button"), true, true)

	setText = var_1

	local var_4_50 = arg_4_0._tf
	local var_4_51 = var_3.Find(var_4_50, "bgs/empty/Text")

	i18n = var_4

	var_1(var_4_51, var_4("shop_new_unfound"))

	setText = var_1

	local var_4_52 = arg_4_0.adapt
	local var_4_53 = var_3.Find(var_4_52, "top/mainTitle/Text")

	i18n = var_4

	var_1(var_4_53, var_4("shop_new_shop"))

	setText = var_1

	local var_4_54 = arg_4_0.filterBtn
	local var_4_55 = var_3.Find(var_4_54, "Text")

	i18n = var_4

	var_1(var_4_55, var_4("shop_new_sort"))

	setText = var_1

	local var_4_56 = arg_4_0.search
	local var_4_57 = var_3.Find(var_4_56, "holder")

	i18n = var_4

	var_1(var_4_57, var_4("shop_new_search"))

	setText = var_1

	local var_4_58 = arg_4_0.btns
	local var_4_59 = var_3.Find(var_4_58, "yigoumai_button/Text")

	i18n = var_4

	var_1(var_4_59, var_4("shop_new_purchased"))

	setText = var_1

	local var_4_60 = arg_4_0.btns
	local var_4_61 = var_3.Find(var_4_60, "goumai_button/Text")

	i18n = var_4

	var_1(var_4_61, var_4("shop_new_purchase"))

	setText = var_1

	local var_4_62 = arg_4_0.btns
	local var_4_63 = var_3.Find(var_4_62, "qianwanghuoqu_button/Text")

	i18n = var_4

	var_1(var_4_63, var_4("shop_new_claim"))

	setText = var_1

	local var_4_64 = arg_4_0.btns
	local var_4_65 = var_3.Find(var_4_64, "furniture_shop/Text")

	i18n = var_4

	var_1(var_4_65, var_4("shop_new_furniture"))

	setText = var_1

	local var_4_66 = arg_4_0.btns
	local var_4_67 = var_3.Find(var_4_66, "item_buy/Text")

	i18n = var_4

	var_1(var_4_67, var_4("shop_new_discount"))

	setText = var_1

	local var_4_68 = arg_4_0.btns
	local var_4_69 = var_3.Find(var_4_68, "tiyan_btn/Text")

	i18n = var_4

	var_1(var_4_69, var_4("shop_new_try"))

	setText = var_1

	local var_4_70 = arg_4_0.btns
	local var_4_71 = var_3.Find(var_4_70, "buy_with_gift/Text")

	i18n = var_4

	var_1(var_4_71, var_4("shop_new_purchase"))

	setText = var_1

	local var_4_72 = arg_4_0.price
	local var_4_73 = var_3.Find(var_4_72, "btn/tag/Text")

	i18n = var_4

	var_1(var_4_73, var_4("shop_new_gift"))

	setText = var_1

	local var_4_74 = arg_4_0.giftPack
	local var_4_75 = var_3.Find(var_4_74, "panel/desc")

	i18n = var_4

	var_1(var_4_75, var_4("shop_new_gem_transform"))

	setText = var_1

	local var_4_76 = arg_4_0.giftPack
	local var_4_77 = var_3.Find(var_4_76, "price/btns/yigoumai_button/Text")

	i18n = var_4

	var_1(var_4_77, var_4("shop_new_purchased"))

	setText = var_1

	local var_4_78 = arg_4_0.filterUI
	local var_4_79 = var_3.Find(var_4_78, "panelMask/panel/title")

	i18n = var_4

	var_1(var_4_79, var_4("shop_new_sort"))

	setText = var_1

	local var_4_80 = arg_4_0.filterUI
	local var_4_81 = var_3.Find(var_4_80, "panelMask/panel/filterScroll/Viewport/Content/own/subTitleFrame/subTitle")

	i18n = var_4

	var_1(var_4_81, var_4("shop_new_review"))

	setText = var_1

	local var_4_82 = arg_4_0.filterUI
	local var_4_83 = var_3.Find(var_4_82, "panelMask/panel/filterScroll/Viewport/Content/own/options/0/Text")

	i18n = var_4

	var_1(var_4_83, var_4("shop_new_all"))

	setText = var_1

	local var_4_84 = arg_4_0.filterUI
	local var_4_85 = var_3.Find(var_4_84, "panelMask/panel/filterScroll/Viewport/Content/own/options/1/Text")

	i18n = var_4

	var_1(var_4_85, var_4("shop_new_owned"))

	setText = var_1

	local var_4_86 = arg_4_0.filterUI
	local var_4_87 = var_3.Find(var_4_86, "panelMask/panel/filterScroll/Viewport/Content/own/options/2/Text")

	i18n = var_4

	var_1(var_4_87, var_4("shop_new_havent_own"))

	setScrollText = var_1

	local var_4_88 = arg_4_0.filterUI
	local var_4_89 = var_3.Find(var_4_88, "panelMask/panel/filterScroll/Viewport/Content/own/options/3/mask/Text")

	i18n = var_4

	var_1(var_4_89, var_4("shop_new_unused"))

	setText = var_1

	local var_4_90 = arg_4_0.filterUI
	local var_4_91 = var_3.Find(var_4_90, "panelMask/panel/filterScroll/Viewport/Content/type/subTitleFrame/subTitle")

	i18n = var_4

	var_1(var_4_91, var_4("shop_new_type"))

	setText = var_1

	local var_4_92 = arg_4_0.filterUI
	local var_4_93 = var_3.Find(var_4_92, "panelMask/panel/filterScroll/Viewport/Content/type/options/0/Text")

	i18n = var_4

	var_1(var_4_93, var_4("shop_new_all"))

	setText = var_1

	local var_4_94 = arg_4_0.filterUI
	local var_4_95 = var_3.Find(var_4_94, "panelMask/panel/filterScroll/Viewport/Content/type/options/2/Text")

	i18n = var_4

	var_1(var_4_95, var_4("shop_new_static"))

	setText = var_1

	local var_4_96 = arg_4_0.filterUI
	local var_4_97 = var_3.Find(var_4_96, "panelMask/panel/filterScroll/Viewport/Content/type/options/3/Text")

	i18n = var_4

	var_1(var_4_97, var_4("shop_new_dynamic"))

	setText = var_1

	local var_4_98 = arg_4_0.filterUI
	local var_4_99 = var_3.Find(var_4_98, "panelMask/panel/filterScroll/Viewport/Content/type/options/4/Text")

	i18n = var_4

	var_1(var_4_99, var_4("shop_new_static_bg"))

	setText = var_1

	local var_4_100 = arg_4_0.filterUI
	local var_4_101 = var_3.Find(var_4_100, "panelMask/panel/filterScroll/Viewport/Content/type/options/5/Text")

	i18n = var_4

	var_1(var_4_101, var_4("shop_new_dynamic_bg"))

	setText = var_1

	local var_4_102 = arg_4_0.filterUI
	local var_4_103 = var_3.Find(var_4_102, "panelMask/panel/filterScroll/Viewport/Content/type/options/6/Text")

	i18n = var_4

	var_1(var_4_103, var_4("shop_new_bgm"))

	setText = var_1

	local var_4_104 = arg_4_0.filterUI
	local var_4_105 = var_3.Find(var_4_104, "panelMask/panel/filterScroll/Viewport/Content/shipHave/subTitleFrame/subTitle")

	i18n = var_4

	var_1(var_4_105, var_4("shop_new_index"))

	setText = var_1

	local var_4_106 = arg_4_0.filterUI
	local var_4_107 = var_3.Find(var_4_106, "panelMask/panel/filterScroll/Viewport/Content/shipHave/options/0/Text")

	i18n = var_4

	var_1(var_4_107, var_4("shop_new_all"))

	setText = var_1

	local var_4_108 = arg_4_0.filterUI
	local var_4_109 = var_3.Find(var_4_108, "panelMask/panel/filterScroll/Viewport/Content/shipHave/options/1/Text")

	i18n = var_4

	var_1(var_4_109, var_4("shop_new_ship_owned"))

	setText = var_1

	local var_4_110 = arg_4_0.filterUI
	local var_4_111 = var_3.Find(var_4_110, "panelMask/panel/filterScroll/Viewport/Content/shipHave/options/2/Text")

	i18n = var_4

	var_1(var_4_111, var_4("shop_new_ship_havent_owned"))

	setText = var_1

	local var_4_112 = arg_4_0.filterUI
	local var_4_113 = var_3.Find(var_4_112, "panelMask/panel/filterScroll/Viewport/Content/camp/subTitleFrame/subTitle")

	i18n = var_4

	var_1(var_4_113, var_4("shop_new_nation"))

	setText = var_1

	local var_4_114 = arg_4_0.filterUI
	local var_4_115 = var_3.Find(var_4_114, "panelMask/panel/filterScroll/Viewport/Content/rarity/subTitleFrame/subTitle")

	i18n = var_4

	var_1(var_4_115, var_4("shop_new_rarity"))

	setText = var_1

	local var_4_116 = arg_4_0.filterUI
	local var_4_117 = var_3.Find(var_4_116, "panelMask/panel/filterScroll/Viewport/Content/shipType/subTitleFrame/subTitle")

	i18n = var_4

	var_1(var_4_117, var_4("shop_new_category"))

	setText = var_1

	local var_4_118 = arg_4_0.filterUI
	local var_4_119 = var_3.Find(var_4_118, "panelMask/panel/filterScroll/Viewport/Content/themeType/subTitleFrame/subTitle")

	i18n = var_4

	var_1(var_4_119, var_4("shop_new_skin_theme"))

	setText = var_1

	local var_4_120 = arg_4_0.filterUI
	local var_4_121 = var_3.Find(var_4_120, "panelMask/panel/filterScroll/Viewport/Content/tag/subTitleFrame/subTitle")

	i18n = var_4

	var_1(var_4_121, var_4("skin_shop_tag"))

	setText = var_1

	local var_4_122 = arg_4_0.filterUI
	local var_4_123 = var_3.Find(var_4_122, "panelMask/panel/filterScroll/Viewport/Content/tag/options/0/Text")

	i18n = var_4

	var_1(var_4_123, var_4("skin_shop_tag_0"))

	setText = var_1

	local var_4_124 = arg_4_0.filterUI
	local var_4_125 = var_3.Find(var_4_124, "panelMask/panel/filterScroll/Viewport/Content/tag/options/1/Text")

	i18n = var_4

	var_1(var_4_125, var_4("skin_shop_tag_1"))

	setText = var_1

	local var_4_126 = arg_4_0.filterUI
	local var_4_127 = var_3.Find(var_4_126, "panelMask/panel/filterScroll/Viewport/Content/tag/options/2/Text")

	i18n = var_4

	var_1(var_4_127, var_4("skin_shop_tag_2"))

	setText = var_1

	local var_4_128 = arg_4_0.filterUI
	local var_4_129 = var_3.Find(var_4_128, "panelMask/panel/filterScroll/Viewport/Content/tag/options/3/Text")

	i18n = var_4

	var_1(var_4_129, var_4("skin_shop_tag_3"))

	setText = var_1

	local var_4_130 = arg_4_0.filterUI
	local var_4_131 = var_3.Find(var_4_130, "panelMask/panel/filterScroll/Viewport/Content/tag/options/4/Text")

	i18n = var_4

	var_1(var_4_131, var_4("skin_shop_tag_4"))

	setText = var_1

	local var_4_132 = arg_4_0.filterUI
	local var_4_133 = var_3.Find(var_4_132, "panelMask/panel/filterScroll/Viewport/Content/tag/options/5/Text")

	i18n = var_4

	var_1(var_4_133, var_4("skin_shop_tag_5"))

	setText = var_1

	local var_4_134 = arg_4_0.filterUI
	local var_4_135 = var_3.Find(var_4_134, "panelMask/panel/filterScroll/Viewport/Content/tag/options/6/Text")

	i18n = var_4

	var_1(var_4_135, var_4("skin_shop_tag_6"))

	setText = var_1

	local var_4_136 = arg_4_0.filterUI
	local var_4_137 = var_3.Find(var_4_136, "panelMask/panel/bottom/ok/Text")

	i18n = var_4

	var_1(var_4_137, var_4("shop_new_confirm"))

	local var_4_138 = arg_4_0.filterContent

	arg_4_0.uiOwnOptions = var_1.Find(var_4_138, "own/options")

	local var_4_139 = arg_4_0.filterContent

	arg_4_0.uiTypeOptions = var_1.Find(var_4_139, "type/options")

	local var_4_140 = arg_4_0.filterContent

	arg_4_0.uiShipHaveOptions = var_1.Find(var_4_140, "shipHave/options")

	local var_4_141 = arg_4_0.filterContent

	arg_4_0.uiCampOptions = var_1.Find(var_4_141, "camp/options")

	local var_4_142 = arg_4_0.filterContent

	arg_4_0.uiRrarityOptions = var_1.Find(var_4_142, "rarity/options")

	local var_4_143 = arg_4_0.filterContent

	arg_4_0.uiShipTypeOptions = var_1.Find(var_4_143, "shipType/options")

	local var_4_144 = arg_4_0.filterContent

	arg_4_0.uiThemeTypeOptions = var_1.Find(var_4_144, "themeType/options")

	local var_4_145 = arg_4_0.filterContent

	arg_4_0.uiTagTypeOptions = var_1.Find(var_4_145, "tag/options")

	arg_4_0:Overlay()

	return
end

function var_0_1.Overlay(arg_5_0)
	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.OverlayPanel
	local var_5_2 = arg_5_0.adapt
	local var_5_3 = {}
	local var_5_4 = {}
	local var_5_5 = arg_5_0.top

	var_5_4[1] = var_7.Find(var_5_5, "title")

	local var_5_6 = arg_5_0.top

	var_5_4[2] = var_7.Find(var_5_6, "title/limit_time")

	local var_5_7 = arg_5_0.top

	var_5_4[3] = var_7.Find(var_5_7, "title/charaNameBg")
	var_5_4[4] = arg_5_0.showOwnBtn
	var_5_4[5] = arg_5_0.filterBtn
	var_5_4[6] = arg_5_0.search

	local var_5_8 = arg_5_0.charContainer

	var_5_4[7] = var_7.Find(var_5_8, "bg")

	local var_5_9 = arg_5_0.price

	var_5_4[8] = var_7.Find(var_5_9, "consume")

	local var_5_10 = arg_5_0.filterUI

	var_5_4[9] = var_7.Find(var_5_10, "panelMask/panel")
	var_5_3.pbList = var_5_4

	var_5_1(var_5_0, var_5_2, var_5_3)

	return
end

function var_0_1.UnOverlay(arg_6_0)
	arg_6_0:UnOverlayPanel(arg_6_0.adapt, arg_6_0._tf)

	return
end

function var_0_1.didEnter(arg_7_0)
	arg_7_0:InitData()
	arg_7_0:SetFilterPanel()
	arg_7_0:SetResource()

	if arg_7_0.mode == var_0_1.MODE_EXPERIENCE or arg_7_0.mode == var_0_1.MODE_EXPERIENCE_FOR_ITEM then
		pg = var_1

		local var_7_0 = var_1.m02
		local var_7_1 = var_1.sendNotification

		NewShopMainScene = var_1_10004

		var_7_1(var_7_0, var_1_10004.SHOW_OR_HIDE_UI_2, false)

		setActive = var_7_1

		var_7_1(arg_7_0.showOwnBtn, false)

		setActive = var_7_1

		var_7_1(arg_7_0.filterBtn, false)

		setActive = var_7_1

		var_7_1(arg_7_0.search, false)

		local var_7_2 = arg_7_0.top
		local var_7_3 = var_1.Find(var_7_2, "title")

		Vector2 = var_2
		var_7_3.anchoredPosition = var_2(184.2, -208.3)

		local var_7_4 = arg_7_0.top
		local var_7_5 = var_1.Find(var_7_4, "change_skin")

		Vector2 = var_2
		var_7_5.anchoredPosition = var_2(70.7, -337.8)

		local var_7_6 = arg_7_0.right
		local var_7_7 = var_1.Find(var_7_6, "giftPackBtn")

		Vector2 = var_2
		var_7_7.anchoredPosition = var_2(-483, -446.4)

		local var_7_8 = arg_7_0.right
		local var_7_9 = var_1.Find(var_7_8, "price")

		Vector2 = var_2
		var_7_9.anchoredPosition = var_2(-238.3, -140.7)

		local var_7_10 = arg_7_0.bottom
		local var_7_11 = var_1.Find(var_7_10, "scroll")

		Vector2 = var_2
		var_7_11.offsetMin = var_2(17.7, 0)

		local var_7_12 = arg_7_0.bottom
		local var_7_13 = var_1.Find(var_7_12, "scroll")

		Vector2 = var_2
		var_7_13.offsetMax = var_2(-718.7, 227.9)
	end

	arg_7_0:SetGiftPackLayer()

	onDelayTick = var_1

	var_1(function()
		local var_8_0 = {}

		table = var_2_10001

		var_2_10001.insert(var_8_0, function(arg_9_0)
			local var_9_0 = arg_7_0

			var_1.CheckDownloadSkinList(var_9_0, arg_9_0)

			return
		end)

		seriesAsync = var_1

		var_1(var_8_0, function()
			local var_10_0 = arg_7_0

			var_0.SetSkinScroll(var_10_0)

			local var_10_1 = arg_7_0

			var_0.Refresh(var_10_1, true)

			return
		end)

		return
	end, 0.001)

	onButton = var_1

	local var_7_14 = arg_7_0
	local var_7_15 = arg_7_0.backBtn

	local function var_7_16()
		local var_11_0 = arg_7_0

		var_0.closeView(var_11_0)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1(var_7_14, var_7_15, var_7_16, var_1_10006)

	onButton = var_1

	local var_7_17 = arg_7_0
	local var_7_18 = arg_7_0.homeBtn

	local function var_7_19()
		local var_12_0 = arg_7_0

		var_0.emit(var_12_0, var_0_1.ON_HOME)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1(var_7_17, var_7_18, var_7_19, var_1_10006)

	onButton = var_1

	local var_7_20 = arg_7_0
	local var_7_21 = arg_7_0.filterBtn

	local function var_7_22()
		local var_13_0 = arg_7_0

		var_0.OpenFilterPanel(var_13_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_7_20, var_7_21, var_7_22, var_1_10006)

	if arg_7_0.mode == var_0_1.MODE_EXPERIENCE or arg_7_0.mode == var_0_1.MODE_EXPERIENCE_FOR_ITEM then
		getProxy = var_1
		SettingsProxy = var_7_20
		var_7_20 = var_1(var_7_20)

		var_1.SetNextTipTimeLimitSkinShop(var_7_20)
	end

	getProxy = var_1
	PlayerProxy = var_7_20

	local var_7_23 = var_1(var_7_20)
	local var_7_24 = var_1.getRawData(var_7_23).id

	onToggle = var_2

	local var_7_25 = arg_7_0
	local var_7_26 = arg_7_0.sdTg

	local function var_7_27(arg_14_0)
		setActive = var_2_10001

		var_2_10001(arg_7_0.charContainer, arg_14_0)

		PlayerPrefs = var_2_10001

		var_2_10001.SetInt("LatestSkinShopLayerSdTg" .. var_7_24, arg_14_0 and 1 or 0)

		PlayerPrefs = var_1

		var_1.Save()

		return
	end

	SFX_PANEL = var_1_10007

	var_2(var_7_25, var_7_26, var_7_27, var_1_10007)

	PlayerPrefs = var_2

	local var_7_28 = var_2.GetInt("LatestSkinShopLayerSdTg" .. var_7_24, 0)

	triggerToggle = var_7_23

	var_7_23(arg_7_0.sdTg, var_7_28 == 1)

	onToggle = var_7_23

	local var_7_29 = arg_7_0
	local var_7_30 = arg_7_0.hideUITg

	local function var_7_31(arg_15_0)
		setActive = var_2_10001

		var_2_10001(arg_7_0.top, not arg_15_0)

		setActive = var_2_10001

		var_2_10001(arg_7_0.bottom, not arg_15_0)

		pg = var_2_10001

		local var_15_0 = var_2_10001.m02
		local var_15_1 = var_1.sendNotification

		NewShopMainScene = var_4

		var_15_1(var_15_0, var_4.SHOW_OR_HIDE_UI, not arg_15_0)

		return
	end

	SFX_PANEL = var_1_10008

	var_7_23(var_7_29, var_7_30, var_7_31, var_1_10008)

	onInputChanged = var_7_23

	var_7_23(arg_7_0, arg_7_0.search, function()
		local var_16_0 = arg_7_0

		var_0.Refresh(var_16_0, true)

		getInputText = var_0

		local var_16_1 = var_0(arg_7_0.search)

		setActive = var_2_10001

		local var_16_2 = arg_7_0.search

		var_2_10001(var_3.Find(var_16_2, "holder"), var_16_1 == "")

		return
	end)

	onButton = var_7_23

	local var_7_32 = arg_7_0
	local var_7_33 = arg_7_0.showOwnBtn

	local function var_7_34()
		local var_17_0 = arg_7_0
		local var_17_1 = var_0.emit

		LatestSkinShopMediator = var_2_10003

		var_17_1(var_17_0, var_2_10003.OPEN_OWN_SKIN_LAYER)

		return
	end

	SFX_PANEL = var_1_10008

	var_7_23(var_7_32, var_7_33, var_7_34, var_1_10008)

	getProxy = var_7_23
	CommanderManualProxy = var_7_32

	local var_7_35 = var_7_23(var_7_32)

	var_3.TaskProgressAdd(var_7_35, 2021, 1)

	return
end

function var_0_1.SetResource(arg_18_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10003

	local var_18_0 = var_1_10001(var_1_10003)
	local var_18_1 = var_1.getRawData(var_18_0)

	setText = var_1_10002

	local var_18_2 = arg_18_0.resources

	var_1_10002(var_4.Find(var_18_2, "gem/Text"), var_18_1:getTotalGem())

	onButton = var_1_10002

	local var_18_3 = arg_18_0
	local var_18_4 = arg_18_0.resources
	local var_18_5 = var_5.Find(var_18_4, "gem")

	local function var_18_6()
		pg = var_2_10000

		local var_19_0 = var_2_10000.playerResUI

		var_0.ClickGem(var_19_0)

		return
	end

	SFX_PANEL = var_18_4

	var_1_10002(var_18_3, var_18_5, var_18_6, var_18_4)

	return
end

function var_0_1.InitData(arg_20_0)
	local var_20_0

	if not arg_20_0.contextData.type then
		ShopConst = var_20_0
		var_20_0 = var_20_0.PERMANANT_SKIN_SHOP_ID
	end

	arg_20_0.type = var_20_0

	local var_20_1

	if not arg_20_0.contextData.mode then
		var_20_1 = var_0_1.MODE_OVERVIEW
	end

	arg_20_0.mode = var_20_1

	arg_20_0:GetAllCommodities()

	local var_20_2 = arg_20_0

	arg_20_0.GetGiftPackCommodities(var_20_2)

	getProxy = var_1
	ShipSkinProxy = var_20_2

	local var_20_3 = var_1(var_20_2)

	arg_20_0.returnSkins = var_1.GetEncoreSkins(var_20_3)

	arg_20_0:GetSkinClassify()

	local var_20_4 = (arg_20_0.mode == var_0_1.MODE_EXPERIENCE or arg_20_0.mode == var_0_1.MODE_EXPERIENCE_FOR_ITEM) and 1 or 0

	arg_20_0.filterValues = {
		shipHaveType = 0,
		ownType = 0,
		typeType = {
			0
		},
		campType = {
			0
		},
		rarityType = {
			0
		},
		shipType = {
			0
		},
		themeType = {
			var_20_4
		},
		tagType = {
			0
		}
	}
	Clone = var_2
	arg_20_0.filterValuesTemp = var_2(arg_20_0.filterValues)

	return
end

function var_0_1.GetAllCommodities(arg_21_0)
	local var_21_0 = arg_21_0.type

	ShopConst = var_1_10002

	if var_21_0 == var_1_10002.NEW_SKIN_SHOP_ID then
		getProxy = var_21_0
		ShipSkinProxy = var_1_10003
		var_1_10003 = var_21_0(var_1_10003)
		arg_21_0.commodities = var_21_0.GetInTimeSkins(var_1_10003)
	else
		var_21_0 = arg_21_0.type
		ShopConst = var_2

		if var_21_0 == var_2.PERMANANT_SKIN_SHOP_ID then
			getProxy = var_21_0
			ShipSkinProxy = var_1_10003
			var_1_10003 = var_21_0(var_1_10003)
			arg_21_0.commodities = var_21_0.GetPermanentSkins(var_1_10003)
		else
			arg_21_0.commodities = {}
			getProxy = var_21_0
			ShipSkinProxy = var_1_10003
			var_1_10003 = var_21_0(var_1_10003)
			var_21_0 = var_21_0.GetAllSkins(var_1_10003)
			ipairs = var_2

			for iter_21_0, iter_21_1 in var_2(var_21_0) do
				table = var_1_10007
				var_1_10007 = var_1_10007.keyof
				pg = var_1_10009

				if var_1_10007(var_1_10009.shop_skin_subsheet[arg_21_0.type].param, iter_21_1.id) then
					table = var_1_10007

					var_1_10007.insert(arg_21_0.commodities, iter_21_1)
				end
			end
		end
	end

	LOCK_SKIN_US = var_21_0

	if var_21_0 then
		pg = var_21_0

		local var_21_1 = var_21_0.gameset.levellimit_skintype.key_value

		pg = var_2

		local var_21_2 = var_2.gameset.levellimit_skintype.description

		getProxy = var_1_10003
		PlayerProxy = iter_21_0

		local var_21_3 = var_1_10003(iter_21_0)

		if var_21_1 >= var_3.getData(var_21_3).level then
			_ = var_1_10004
			arg_21_0.commodities = var_1_10004.filter(arg_21_0.commodities, function(arg_22_0)
				pg = var_2_10001

				local var_22_0 = var_2_10001.ship_skin_template[arg_22_0:getSkinId()].shop_type_id

				table = var_2

				return var_2.contains(var_21_2, var_22_0)
			end)
		end
	end

	if arg_21_0.mode == var_0_1.MODE_OVERVIEW then
		for iter_21_2 = #arg_21_0.commodities, 1, -1 do
			local var_21_4 = arg_21_0.commodities[iter_21_2]
			local var_21_5 = var_5.getConfig(var_21_4, "genre")

			ShopArgs = var_1_10007

			if var_21_5 == var_1_10007.SkinShopTimeLimit then
				table = var_21_5

				var_21_5.remove(arg_21_0.commodities, iter_21_2)
			end
		end
	end

	return
end

function var_0_1.GetGiftPackCommodities(arg_23_0)
	arg_23_0.giftPackCommodities = {}
	arg_23_0.giftSkinCommodities = {}
	arg_23_0.giftSkinProbabilitys = {}
	ipairs = var_1
	pg = var_1_10003

	for iter_23_0, iter_23_1 in var_1(var_1_10003.pay_data_display.all) do
		pg = var_1_10006

		if var_1_10006.pay_data_display[iter_23_1].skin_inquire_relation ~= 0 then
			pg = var_7

			local var_23_0 = var_7.TimeMgr.GetInstance()

			if var_7.inTime(var_23_0, var_1_10006.time) then
				getProxy = var_7
				ShopsProxy = var_23_0

				local var_23_1 = var_7(var_23_0)
				local var_23_2 = var_7.GetGiftCommodity
				local var_23_3 = iter_23_1

				Goods = var_1_10011

				local var_23_4 = var_23_2(var_23_1, var_23_3, var_1_10011.TYPE_CHARGE)

				arg_23_0.giftPackCommodities[iter_23_1] = var_23_4

				local var_23_5 = var_23_4
				local var_23_6 = var_23_4.GetSkinProbability(var_23_5)
				local var_23_7 = arg_23_0.giftSkinCommodities

				getProxy = var_23_5
				ShipSkinProxy = var_1_10012
				var_1_10012 = var_23_5(var_1_10012)
				var_23_7[iter_23_1] = var_10.GetProbabilitySkins(var_1_10012, var_23_6)

				local var_23_8 = arg_23_0.giftSkinProbabilitys

				getProxy = var_10
				ShipSkinProxy = var_1_10012
				var_1_10012 = var_10(var_1_10012)
				var_23_8[iter_23_1] = var_10.GetSkinProbabilitys(var_1_10012, var_23_6)
			end
		end
	end

	return
end

function var_0_1.SetSkinScroll(arg_24_0)
	arg_24_0.scrollrect.isNewLoadingMethod = true

	function arg_24_0.scrollrect.onInitItem(arg_25_0)
		local var_25_0 = arg_24_0

		var_1.OnInitItem(var_25_0, arg_25_0)

		return
	end

	function arg_24_0.scrollrect.onUpdateItem(arg_26_0, arg_26_1)
		local var_26_0 = arg_24_0

		var_2.OnUpdateItem(var_26_0, arg_26_0, arg_26_1)

		return
	end

	arg_24_0.scrollrect.enabled = true

	return
end

function var_0_1.Refresh(arg_27_0, arg_27_1)
	arg_27_0:ClearCards()

	arg_27_0.cards = {}
	arg_27_0.displays = {}
	getInputText = var_2

	local var_27_0 = var_2(arg_27_0.search)

	ipairs = var_1_10003

	for iter_27_0, iter_27_1 in var_1_10003(arg_27_0.commodities) do
		var_1_10010 = arg_27_0

		if arg_27_0.filterOk(var_1_10010, iter_27_1) then
			var_1_10010 = arg_27_0

			if arg_27_0.IsSearchType(var_1_10010, var_27_0, iter_27_1) then
				table = var_8

				var_8.insert(arg_27_0.displays, iter_27_1)
			end
		end
	end

	local var_27_1 = {}

	ipairs = var_4

	for iter_27_2, iter_27_3 in var_4(arg_27_0.displays) do
		local var_27_2 = iter_27_3.type

		Goods = var_1_10010

		local var_27_4

		if var_27_2 ~= var_1_10010.TYPE_ACTIVITY then
			local var_27_3 = iter_27_3.type

			Goods = var_1_10010

			if var_27_3 ~= var_1_10010.TYPE_ACTIVITY_EXTRA then
				var_27_4 = false

				goto label_27_0
			end
		end

		var_27_4 = true

		::label_27_0::

		var_1_10010 = 0

		if not var_27_4 then
			var_1_10010 = iter_27_3:GetPrice()
		end

		var_27_1[iter_27_3.id] = var_1_10010
	end

	table = var_4

	var_4.sort(arg_27_0.displays, function(arg_28_0, arg_28_1)
		local var_28_0 = arg_27_0

		return var_2.Sort(var_28_0, arg_28_0, arg_28_1, var_27_1)
	end)

	local var_27_5 = #arg_27_0.displays == 0

	setActive = var_5

	local var_27_6 = arg_27_0.bgs

	var_5(var_7.Find(var_27_6, "default"), var_27_5)

	setActive = var_5

	local var_27_7 = arg_27_0.bgs

	var_5(var_7.Find(var_27_7, "diffBg"), not var_27_5)

	setActive = var_5

	local var_27_8 = arg_27_0.bgs

	var_5(var_7.Find(var_27_8, "empty"), var_27_5)

	setActive = var_5

	local var_27_9 = arg_27_0._tf

	var_5(var_7.Find(var_27_9, "leftMask"), not var_27_5)

	setActive = var_5

	local var_27_10 = arg_27_0._tf

	var_5(var_7.Find(var_27_10, "bottomMask"), not var_27_5)

	setActive = var_5

	var_5(arg_27_0.painting, not var_27_5)

	setActive = var_5

	local var_27_11 = arg_27_0.top

	var_5(var_7.Find(var_27_11, "title"), not var_27_5)

	setActive = var_5

	var_5(arg_27_0.changeSkin, not var_27_5)

	setActive = var_5

	var_5(arg_27_0.right, not var_27_5)

	setActive = var_5

	var_5(arg_27_0.right, not var_27_5)

	setActive = var_5

	local var_27_12 = arg_27_0.bottom

	var_5(var_7.Find(var_27_12, "scroll"), not var_27_5)

	if not var_27_5 then
		if arg_27_1 then
			arg_27_0.triggerFirstCard = true

			local var_27_13 = arg_27_0.scrollrect

			var_5.SetTotalCount(var_27_13, #arg_27_0.displays, 0)
		else
			local var_27_14 = arg_27_0.scrollrect

			var_5.SetTotalCount(var_27_14, #arg_27_0.displays)
		end
	end

	return
end

function var_0_1.IsSearchType(arg_29_0, arg_29_1, arg_29_2)
	if not arg_29_1 or arg_29_1 == "" then
		return true
	end

	local var_29_0 = arg_29_2:getSkinId()

	ShipSkin = var_1_10004

	local var_29_1 = var_1_10004.New({
		id = var_29_0
	})

	return var_4.IsMatchKey(var_29_1, arg_29_1)
end

local function var_0_21(arg_30_0, arg_30_1, arg_30_2)
	if arg_30_2[arg_30_0.id] == arg_30_2[arg_30_1.id] then
		return arg_30_0.id < arg_30_1.id
	else
		return var_4 < var_3
	end

	return
end

function var_0_1.Sort(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
	if (arg_31_1.buyCount == 0 and 1 or 0) == (arg_31_2.buyCount == 0 and 1 or 0) then
		if arg_31_1:getConfig("order") == arg_31_2:getConfig("order") then
			return var_0_21(arg_31_1, arg_31_2, arg_31_3)
		else
			return var_6 < var_7
		end
	else
		return var_5 < var_4
	end

	return
end

function var_0_1.filterOk(arg_32_0, arg_32_1)
	local var_32_0 = arg_32_0.filterValues.ownType
	local var_32_1 = arg_32_0.filterValues.typeType
	local var_32_2 = arg_32_0.filterValues.shipHaveType
	local var_32_3 = arg_32_0.filterValues.campType
	local var_32_4 = arg_32_0.filterValues.rarityType
	local var_32_5 = arg_32_0.filterValues.shipType
	local var_32_6 = arg_32_0.filterValues.themeType
	local var_32_7 = arg_32_0.filterValues.tagType
	local var_32_8 = arg_32_1:getSkinId()

	ShipSkin = var_1_10011

	local var_32_9 = var_1_10011.New({
		id = var_32_8
	})
	local var_32_10 = var_11.GetDefaultShipConfig(var_32_9)
	local var_32_11 = arg_32_0
	local var_32_12 = arg_32_0.ToVShip(var_32_11, var_32_10)
	local var_32_15

	if var_32_0 ~= 0 then
		local var_32_13 = false

		getProxy = var_32_11
		ShipSkinProxy = var_1_10017

		local var_32_14 = var_32_11(var_1_10017)

		var_32_11 = var_32_11.hasSkin(var_32_14, var_32_8)
		var_32_15 = var_11:NoUse()

		if var_32_0 == 1 and var_32_11 then
			var_32_13 = true
		end

		if var_32_0 == 2 and not var_32_11 then
			var_32_13 = true
		end

		if var_32_0 == 3 and var_32_11 and var_32_15 then
			var_32_13 = true
		end

		if not var_32_13 then
			return false
		end
	end

	if var_32_1[1] ~= 0 then
		local var_32_16 = false

		ipairs = var_32_11

		for iter_32_0, iter_32_1 in var_32_11(var_32_1) do
			if iter_32_1 == 1 then
				var_1_10022 = var_11

				if not var_11.IsLive2d(var_1_10022) then
					var_1_10022 = var_11

					if var_11.IsLive2dPlus(var_1_10022) then
						var_32_16 = true
					end

					if iter_32_1 == 2 then
						var_1_10022 = var_11

						if not var_11.IsLive2d(var_1_10022) then
							var_1_10022 = var_11

							if not var_11.IsLive2dPlus(var_1_10022) then
								var_1_10022 = var_11

								if not var_11.IsSpine(var_1_10022) then
									var_1_10022 = var_11

									if not var_11.IsSpinePlus(var_1_10022) then
										var_32_16 = true
									end
								end
							end
						end
					end

					if iter_32_1 == 3 then
						var_1_10022 = var_11

						if not var_11.IsSpine(var_1_10022) then
							var_1_10022 = var_11

							if var_11.IsSpinePlus(var_1_10022) then
								var_32_16 = true
							end

							if iter_32_1 == 4 then
								var_1_10022 = var_11

								if var_11.IsBG(var_1_10022) then
									var_32_16 = true
								end
							end

							if iter_32_1 == 5 then
								var_1_10022 = var_11

								if var_11.IsDbg(var_1_10022) then
									var_32_16 = true
								end
							end

							if iter_32_1 == 6 then
								var_1_10022 = var_11

								if var_11.isBgm(var_1_10022) then
									var_32_16 = true
								end
							end

							if var_32_16 then
								break
							end
						end
					end
				end
			end
		end

		if not var_32_16 then
			return false
		end
	end

	if var_32_2 ~= 0 then
		local var_32_17 = false

		var_32_11 = var_11:CantUse()

		if var_32_2 == 1 and not var_32_11 then
			var_32_17 = true
		end

		if var_32_2 == 2 and var_32_11 then
			var_32_17 = true
		end

		if not var_32_17 then
			return false
		end
	end

	if var_32_3[1] ~= 0 then
		if not var_32_10 then
			return false
		end

		local var_32_18 = false

		ipairs = var_32_11

		for iter_32_2, iter_32_3 in var_32_11(var_32_3) do
			ShipIndexCfg = var_1_10020
			var_1_10020 = var_1_10020.camp
			ipairs = var_1_10021

			for iter_32_4, iter_32_5 in var_1_10021(var_1_10020[iter_32_3 + 1].types) do
				Nation = var_1_10026

				if iter_32_5 == var_1_10026.LINK then
					var_1_10026 = var_32_12:getNation()
					Nation = var_1_10027

					if var_1_10027.LINK <= var_1_10026 then
						var_32_18 = true
					end
				elseif iter_32_5 == var_32_12:getNation() then
					var_32_18 = true
				end
			end

			if var_32_18 then
				break
			end
		end

		if not var_32_18 then
			return false
		end
	end

	if var_32_4[1] ~= 0 then
		if not var_32_10 then
			return false
		end

		local var_32_19 = false

		ipairs = var_32_11

		for iter_32_6, iter_32_7 in var_32_11(var_32_4) do
			ShipIndexCfg = var_1_10020
			var_1_10020 = var_1_10020.rarity
			table = var_1_10021

			if var_1_10021.contains(var_1_10020[iter_32_7 + 1].types, var_32_12:getRarity()) then
				var_32_19 = true
			end

			if var_32_19 then
				break
			end
		end

		if not var_32_19 then
			return false
		end
	end

	if var_32_5[1] ~= 0 then
		if not var_32_10 then
			return false
		end

		local var_32_20 = false

		ipairs = var_32_11

		for iter_32_8, iter_32_9 in var_32_11(var_32_5) do
			ShipIndexCfg = var_1_10020

			local var_32_21 = var_1_10020.type[iter_32_9 + 1].types

			if iter_32_9 + 1 < 4 then
				var_1_10022 = var_1_10020[iter_32_9].shipTypes
				table = var_23

				if var_23.contains(var_32_21, var_32_12:getShipType()) then
					var_32_20 = true
				end

				table = var_23

				if var_23.contains(var_32_21, var_32_12:getTeamType()) then
					var_32_20 = true
				end
			else
				table = var_1_10022

				if var_1_10022.contains(var_32_21, var_32_12:getShipType()) then
					var_32_20 = true
				end
			end

			if var_32_20 then
				break
			end
		end

		if not var_32_20 then
			return false
		end
	end

	if var_32_6[1] ~= 0 then
		local var_32_22 = false

		ipairs = var_32_11

		for iter_32_10, iter_32_11 in var_32_11(var_32_6) do
			local var_32_23 = arg_32_0.classifyIds[iter_32_11 + 1]
			local var_32_24 = arg_32_1:getConfig("genre")

			ShopArgs = var_1_10022

			if var_32_24 == var_1_10022.SkinShopTimeLimit then
				if arg_32_0.mode == var_0_1.MODE_EXPERIENCE_FOR_ITEM then
					var_32_22 = var_32_23 == var_0_16 and arg_32_0:ExitSkinExperienceItem(arg_32_1.id)
				else
					var_32_22 = var_32_23 == var_0_14
				end
			elseif var_32_23 == var_0_13 then
				var_32_22 = true
			else
				if var_32_23 == var_0_15 then
					table = var_21

					if var_21.contains(arg_32_0.returnSkins, arg_32_1.id) then
						var_32_22 = true

						goto label_32_0
					end
				end

				if arg_32_0:GetShopTypeIdBySkinId(var_32_8) ~= 0 or not var_0_17 then
					var_1_10022 = var_21
				end

				var_32_22 = var_1_10022 == var_32_23
			end

			::label_32_0::

			if var_32_22 then
				break
			end
		end

		if not var_32_22 then
			return false
		end
	end

	if var_32_7[1] ~= 0 then
		local var_32_25 = false

		table = var_32_11

		local var_32_26 = var_32_11.contains(arg_32_0.returnSkins, arg_32_1.id)

		NewShopSkinCard = var_32_15

		local var_32_27 = var_32_15.GetTagId(arg_32_1, var_32_26)

		table = var_17

		if var_17.keyof(var_32_7, var_32_27) then
			return true
		else
			return false
		end
	end

	return true
end

function var_0_1.ToVShip(arg_33_0, arg_33_1)
	if not arg_33_0.vship then
		arg_33_0.vship = {}

		function arg_33_0.vship.getNation()
			return arg_33_0.vship.config.nationality
		end

		function arg_33_0.vship.getShipType()
			return arg_33_0.vship.config.type
		end

		function arg_33_0.vship.getTeamType()
			ShipType = var_2_10000

			return var_2_10000.GetTeamFromShipType(arg_33_0.vship.config.type)
		end

		function arg_33_0.vship.getRarity()
			return arg_33_0.vship.config.rarity
		end
	end

	arg_33_0.vship.config = arg_33_1

	return arg_33_0.vship
end

function var_0_1.ExitSkinExperienceItem(arg_38_0, arg_38_1)
	if not arg_38_0.cacheSkinExperienceItems then
		getProxy = var_2
		BagProxy = var_1_10004

		local var_38_0 = var_2(var_1_10004)

		arg_38_0.cacheSkinExperienceItems = var_2.GetSkinExperienceItems(var_38_0)
	end

	_ = var_2

	return var_2.any(arg_38_0.cacheSkinExperienceItems, function(arg_39_0)
		return arg_39_0:CanUseForShop(arg_38_1)
	end)
end

function var_0_1.RegisterEvent(arg_40_0)
	arg_40_0:bind(var_0_1.EVT_SHOW_OR_HIDE_PURCHASE_VIEW, function(arg_41_0, arg_41_1)
		local var_41_0 = arg_40_0

		var_2.AdjustPainting(var_41_0, arg_41_1)

		setActive = var_2

		var_2(arg_40_0.top, not arg_41_1)

		setActive = var_2

		var_2(arg_40_0.bottom, not arg_41_1)

		setActive = var_2

		var_2(arg_40_0.right, not arg_41_1)

		if arg_40_0.live2dChar then
			local var_41_1 = arg_40_0.live2dChar

			var_2.setPurchaseOffset(var_41_1, arg_41_1)
		end

		local var_41_2, var_41_6

		if arg_40_0.spineChar then
			if arg_41_1 then
				pg = var_41_6

				if var_41_6.ship_skin_template[arg_40_0.skinId].purchase_offset and #var_41_6 >= 3 then
					var_41_2 = arg_40_0.spineChar

					local var_41_3 = var_3.SetLocalPosition

					Vector3 = var_2_10006

					var_41_3(var_41_2, var_2_10006(var_41_6[1], var_41_6[2], var_41_6[3]))
				end

				if var_41_6 and #var_41_6 >= 4 then
					var_41_2 = arg_40_0.spineChar

					local var_41_4 = var_3.SetLocalScale

					Vector3 = var_2_10006

					var_41_4(var_41_2, var_2_10006(var_41_6[4], var_41_6[4], var_41_6[4]))
				end
			else
				local var_41_5 = arg_40_0.spineChar

				var_41_6 = var_41_6.SetLocalScale
				Vector3 = var_41_2

				var_41_6(var_41_5, var_41_2(0.9, 0.9, 1))

				local var_41_7 = arg_40_0.spineChar

				var_41_6 = var_41_6.SetLocalPosition
				Vector3 = var_41_2

				var_41_6(var_41_7, var_41_2(0, 0, 0))
			end
		end

		pg = var_41_6

		local var_41_8 = var_41_6.m02
		local var_41_9 = var_2.sendNotification

		NewShopMainScene = var_41_2

		var_41_9(var_41_8, var_41_2.SHOW_OR_HIDE_UI, not arg_41_1)

		return
	end)
	arg_40_0:bind(var_0_1.EVT_ON_PURCHASE, function(arg_42_0, arg_42_1)
		local var_42_0 = arg_40_0
		local var_42_1 = var_2.GetObtainBtnState(var_42_0, arg_42_1)
		local var_42_2 = arg_40_0

		var_3.OnClickBtn(var_42_2, var_42_1, arg_42_1)

		return
	end)

	onButton = var_1

	local var_40_0 = arg_40_0
	local var_40_1 = arg_40_0.changeSkin

	local function var_40_2()
		ShipSkin = var_2_10000

		if var_2_10000.IsChangeSkin(arg_40_0.skinId) then
			local var_43_0 = arg_40_0

			ShipSkin = var_2_10001
			var_43_0.changeSkinId = var_2_10001.GetChangeSkinNextId(arg_40_0.skinId)

			local var_43_1 = arg_40_0

			var_0.UpdateMainView(var_43_1, arg_40_0.showingCommodity)
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_40_0, var_40_1, var_40_2, var_1_10006)

	return
end

function var_0_1.OnInitItem(arg_44_0, arg_44_1)
	NewShopSkinCard = var_1_10002

	local var_44_0 = var_1_10002.New(arg_44_1)

	onButton = var_1_10003

	local var_44_1 = arg_44_0
	local var_44_2 = var_44_0._go

	local function var_44_3()
		if not var_44_0.commodity then
			return
		end

		pairs = var_0

		for iter_45_0, iter_45_1 in var_0(arg_44_0.cards) do
			iter_45_1:UpdateSelected(false)
		end

		arg_44_0.selectedId = var_44_0.commodity.id

		local var_45_0 = var_44_0

		var_0.UpdateSelected(var_45_0, true)

		local var_45_1 = arg_44_0

		var_0.UpdateMainView(var_45_1, var_44_0.commodity)

		local var_45_2 = arg_44_0

		var_0.GCHandle(var_45_2)

		return
	end

	SFX_PANEL = var_1_10008

	var_1_10003(var_44_1, var_44_2, var_44_3, var_1_10008)

	arg_44_0.cards[arg_44_1] = var_44_0

	return
end

function var_0_1.OnUpdateItem(arg_46_0, arg_46_1, arg_46_2)
	local var_46_0

	if not arg_46_0.cards[arg_46_2] then
		arg_46_0:OnInitItem(arg_46_2)

		var_46_0 = arg_46_0.cards[arg_46_2]
	end

	if not arg_46_0.displays[arg_46_1 + 1] then
		return
	end

	local var_46_1 = arg_46_0.selectedId == var_4.id

	table = var_6

	local var_46_2 = var_6.contains(arg_46_0.returnSkins, var_4.id)

	var_46_0:Update(var_4, var_46_1, var_46_2)

	if arg_46_0.triggerFirstCard and arg_46_1 == 0 then
		arg_46_0.triggerFirstCard = false
		triggerButton = var_7

		var_7(var_46_0._go)
	end

	return
end

function var_0_1.UpdateMainView(arg_47_0, arg_47_1)
	arg_47_0.skinId = arg_47_1:getSkinId()
	ShipSkin = var_2

	local var_47_0 = var_2.IsChangeSkin(arg_47_0.skinId)

	setActive = var_1_10003

	var_1_10003(arg_47_0.changeSkin, var_47_0)

	if var_47_0 then
		arg_47_0:FlushChangeSkin(arg_47_1)
	end

	ShipSkin = var_1_10003
	arg_47_0.shipSkin = var_1_10003.New({
		id = arg_47_0.skinId
	})

	arg_47_0:FlushName()
	arg_47_0:FlushPreviewBtn(arg_47_1)
	arg_47_0:FlushTimeLimit(arg_47_1)
	arg_47_0:SwitchPreview(arg_47_1, arg_47_0.isPreviewFurniture)
	arg_47_0:FlushPaintingToggle(arg_47_1)
	arg_47_0:FlushTag()
	arg_47_0:FlushBG(arg_47_1)
	arg_47_0:FlushPainting(arg_47_1)
	arg_47_0:FlushPrice(arg_47_1)
	arg_47_0:FlushObtainBtn(arg_47_1)
	arg_47_0:FlushGifgPackBtn(arg_47_1)

	arg_47_0.showingCommodity = arg_47_1

	return
end

function var_0_1.FlushChangeSkin(arg_48_0, arg_48_1)
	ShipSkin = var_1_10002

	local var_48_0 = var_1_10002.GetChangeSkinGroupId(arg_48_0.skinId)

	ShipSkin = var_1_10003

	local var_48_1 = var_1_10003.GetChangeSkinCustomDataId(arg_48_0.skinId, "hide_shop")

	pg = var_4

	local var_48_2 = var_4.gameset.changeskin_switch_block
	local var_48_3 = false
	local var_48_4 = false
	local var_48_5 = arg_48_0.changeSkinToggle
	local var_48_6 = var_7.IsAsmrSkin(var_48_5) and true or false

	if var_48_2 and var_48_2.description then
		local var_48_7 = var_48_2.description

		table = var_48_5

		if var_48_5.contains(var_48_7, var_48_0) then
			HXSet = var_9

			if var_9.isHx() then
				var_48_4 = true
			end
		end
	end

	if var_48_1 and var_48_1 == 1 then
		var_48_3 = true
	end

	if not arg_48_0.changeSkinId then
		arg_48_0.changeSkinId = arg_48_0.skinId
	else
		ShipSkin = var_8

		if var_8.GetChangeSkinGroupId(arg_48_0.changeSkinId) == var_48_0 then
			arg_48_0.skinId = arg_48_0.changeSkinId
		else
			arg_48_0.changeSkinId = arg_48_0.skinId
		end
	end

	local var_48_8 = arg_48_0.changeSkinToggle

	var_8.setSkinData(var_48_8, arg_48_0.skinId)

	if var_48_3 or var_48_4 or var_48_6 then
		setActive = var_8

		var_8(arg_48_0.changeSkin, false)
	else
		setActive = var_8

		var_8(arg_48_0.changeSkin, true)
	end

	return
end

function var_0_1.GCHandle(arg_49_0)
	local var_49_0 = var_0_1
	local var_49_1

	if not var_0_1.GCCNT then
		var_49_1 = 0
	end

	var_49_0.GCCNT = var_49_1 + 1

	if var_0_1.GCCNT == 3 then
		gcAll = var_1

		var_1()

		var_0_1.GCCNT = 0
	end

	return
end

function var_0_1.FlushName(arg_50_0)
	pg = var_1_10001

	local var_50_0 = var_1_10001.ship_skin_template[arg_50_0.skinId]

	setScrollText = var_2

	local var_50_1 = arg_50_0.skinName

	SwitchSpecialChar = var_1_10005

	var_2(var_50_1, var_1_10005(var_50_0.name, true))

	local var_50_2 = var_50_0.skin_type

	ShipSkin = var_1_10003

	if var_50_2 == var_1_10003.SKIN_TYPE_TB then
		setScrollText = var_50_2

		local var_50_3 = arg_50_0.shipName

		NewEducateHelper = var_5

		local var_50_4 = var_5.GetShipNameBySecId

		NewEducateHelper = var_7

		var_50_2(var_50_3, var_50_4(var_7.GetSecIdBySkinId(arg_50_0.skinId)))
	else
		ShipGroup = var_50_2

		local var_50_5 = var_50_2.getDefaultShipConfig(var_50_0.ship_group)

		setScrollText = var_3

		var_3(arg_50_0.shipName, var_50_5.name)
	end

	return
end

function var_0_1.FlushPreviewBtn(arg_51_0, arg_51_1)
	Goods = var_1_10002

	local var_51_0 = var_1_10002.ExistFurniture(arg_51_1.id)

	removeOnButton = var_1_10003

	var_1_10003(arg_51_0.switchPreviewBtn)

	if not var_51_0 and arg_51_0.isPreviewFurniture then
		arg_51_0.isPreviewFurniture = false
	end

	setActive = var_1_10003

	var_1_10003(arg_51_0.switchPreviewBtn, var_51_0)

	if var_51_0 then
		onButton = var_1_10003

		local var_51_1 = arg_51_0
		local var_51_2 = arg_51_0.switchPreviewBtn

		local function var_51_3()
			arg_51_0.isPreviewFurniture = not arg_51_0.isPreviewFurniture

			local var_52_0 = arg_51_0

			var_0.SwitchPreview(var_52_0, arg_51_1, arg_51_0.isPreviewFurniture)

			local var_52_1 = arg_51_0

			var_0.FlushPrice(var_52_1, arg_51_1)

			local var_52_2 = arg_51_0

			var_0.FlushObtainBtn(var_52_2, arg_51_1)

			return
		end

		SFX_PANEL = var_1_10008

		var_1_10003(var_51_1, var_51_2, var_51_3, var_1_10008)
	end

	return
end

function var_0_1.SwitchPreview(arg_53_0, arg_53_1, arg_53_2)
	local var_53_0 = arg_53_0.skinId

	pg = var_1_10004

	local var_53_1 = var_1_10004.ship_skin_template[var_53_0].skin_type

	ShipSkin = var_1_10005

	if var_53_1 == var_1_10005.SKIN_TYPE_TB then
		setActive = var_53_1

		var_53_1(arg_53_0.charContainer, false)

		return
	end

	getProxy = var_53_1
	PlayerProxy = var_1_10006

	local var_53_2 = var_53_1(var_1_10006)
	local var_53_3 = var_4.getRawData(var_53_2).id

	setActive = var_53_5

	local var_53_4 = arg_53_0.charContainer

	PlayerPrefs = var_1_10008

	var_53_5(var_53_4, var_1_10008.GetInt("LatestSkinShopLayerSdTg" .. var_53_3, 0) == 1)

	setActive = var_53_5

	var_53_5(arg_53_0.charTf, not arg_53_2)

	setActive = var_53_5

	var_53_5(arg_53_0.furnitureContainer, arg_53_2)

	local var_53_5

	if not arg_53_2 then
		pg = var_53_5
		var_53_5 = var_53_5.ship_skin_template[var_53_0]

		arg_53_0:FlushChar(var_53_5.prefab, var_53_5.id)

		GetImageSpriteFromAtlasAsync = var_53_2

		var_53_2("qicon/" .. var_53_5.painting, "", arg_53_0.backChara)
	else
		Goods = var_53_5

		local var_53_6 = var_53_5.Id2FurnitureId(arg_53_1.id)

		Goods = var_53_2

		local var_53_7 = var_53_2.GetFurnitureConfig(arg_53_1.id)
		local var_53_8 = arg_53_0.interactionPreview
		local var_53_9 = var_7.Flush
		local var_53_10 = var_53_0
		local var_53_11 = var_53_6
		local var_53_12

		if not var_53_7.scale[2] then
			var_53_12 = 1
		end

		var_53_9(var_53_8, var_53_10, var_53_11, var_53_12, var_53_7.position[2])
	end

	return
end

function var_0_1.FlushChar(arg_54_0, arg_54_1, arg_54_2)
	if arg_54_0.prefabName and arg_54_0.prefabName == arg_54_1 then
		return
	end

	arg_54_0:ReturnChar()

	arg_54_0.prefabName = arg_54_1
	SpineAnimChar = var_3

	local var_54_0 = var_3.New()

	var_3.SetPaint(var_54_0, arg_54_1)
	var_3:Load(true, function(arg_55_0)
		if arg_54_0.prefabName ~= arg_54_1 then
			arg_55_0:Dispose()

			return
		end

		local var_55_0 = arg_54_0

		var_55_0.spineChar = arg_55_0
		pg = var_55_0

		if var_55_0.skinshop_spine_scale[arg_54_2] then
			local var_55_1 = arg_54_0.spineChar
			local var_55_2 = var_2.SetLocalScale

			Vector3 = var_2_10005

			var_55_2(var_55_1, var_2_10005(var_1.skinshop_scale, var_1.skinshop_scale, 1))
		else
			local var_55_3 = arg_54_0.spineChar
			local var_55_4 = var_2.SetLocalScale

			Vector3 = var_2_10005

			var_55_4(var_55_3, var_2_10005(0.9, 0.9, 1))
		end

		local var_55_5 = arg_54_0.spineChar
		local var_55_6 = var_2.SetLocalPosition

		Vector3 = var_2_10005

		var_55_6(var_55_5, var_2_10005(0, 0, 0))

		local var_55_7 = arg_54_0.spineChar
		local var_55_8 = var_2.SetLayer

		Layer = var_5

		var_55_8(var_55_7, var_5.UI)

		local var_55_9 = arg_54_0.spineChar

		var_2.SetParent(var_55_9, arg_54_0.charTf)

		local var_55_10 = arg_54_0.spineChar

		var_2.SetAction(var_55_10, "normal", 0)

		return
	end)

	return
end

function var_0_1.ReturnChar(arg_56_0)
	if arg_56_0.spineChar then
		local var_56_0 = arg_56_0.spineChar

		var_1.Dispose(var_56_0)

		arg_56_0.spineChar = nil
		arg_56_0.prefabName = nil
	end

	return
end

function var_0_1.ClearCards(arg_57_0)
	if not arg_57_0.cards then
		return
	end

	pairs = var_1

	for iter_57_0, iter_57_1 in var_1(arg_57_0.cards) do
		iter_57_1:Dispose()
	end

	arg_57_0.cards = nil

	return
end

function var_0_1.FlushTimeLimit(arg_58_0, arg_58_1)
	local var_58_0 = arg_58_0.skinId
	local var_58_1 = false
	local var_58_2
	local var_58_3

	if arg_58_1:IsActivityExtra() and arg_58_1:ShowMaintenanceTime() then
		var_58_3, var_1_10006 = arg_58_1:GetMaintenanceMonthAndDay()

		function var_58_2()
			i18n = var_2_10000

			return var_2_10000("limit_skin_time_before_maintenance", var_58_3, var_1_10006)
		end

		var_58_1 = true
	else
		local var_58_4 = arg_58_1

		var_58_3 = arg_58_1.getConfig(var_58_4, "genre")
		ShopArgs = var_1_10006

		if var_58_3 == var_1_10006.SkinShopTimeLimit then
			getProxy = var_58_3
			ShipSkinProxy = var_58_4

			local var_58_5 = var_58_3(var_58_4)

			var_58_1 = var_58_3.getSkinById(var_58_5, var_58_0) and var_58_3:isExpireType() and not var_58_3:isExpired()

			if var_58_1 then
				function var_58_2()
					skinTimeStamp = var_2_10000

					local var_60_0 = var_58_3

					return var_2_10000(var_2.getRemainTime(var_60_0))
				end
			end
		else
			pg = var_58_3

			local var_58_6 = var_58_3.TimeMgr.GetInstance()
			local var_58_7

			var_58_3, var_58_7 = var_58_3.inTime(var_58_6, arg_58_1:getConfig("time"))

			if var_58_7 then
				pg = var_58_6

				local var_58_8 = var_58_6.TimeMgr.GetInstance()
				local var_58_9 = var_7.Table2ServerTime(var_58_8, var_58_7)

				function var_58_2()
					skinCommdityTimeStamp = var_2_10000

					return var_2_10000(var_58_9)
				end
			end
		end
	end

	setActive = var_58_3

	local var_58_10 = arg_58_0.top

	var_58_3(var_7.Find(var_58_10, "title/limit_time"), var_58_1)
	arg_58_0:ClearTimer()

	if var_58_1 then
		arg_58_0:AddTimer(var_58_2)
	end

	return
end

function var_0_1.AddTimer(arg_62_0, arg_62_1)
	Timer = var_1_10002
	arg_62_0.timer = var_1_10002.New(function()
		setText = var_2_10000

		var_2_10000(arg_62_0.limitTime, arg_62_1())

		return
	end, 1, -1)

	arg_62_0.timer.func()

	local var_62_0 = arg_62_0.timer

	var_2.Start(var_62_0)

	return
end

function var_0_1.ClearTimer(arg_64_0)
	if arg_64_0.timer then
		local var_64_0 = arg_64_0.timer

		var_1.Stop(var_64_0)

		arg_64_0.timer = nil
	end

	return
end

function var_0_1.FlushPaintingToggle(arg_65_0, arg_65_1)
	removeOnToggle = var_1_10002

	var_1_10002(arg_65_0.dynamicToggle)

	removeOnToggle = var_1_10002

	var_1_10002(arg_65_0.showBgToggle)

	checkABExist = var_1_10002

	local var_65_0 = "painting/"
	local var_65_1 = arg_65_0.shipSkin
	local var_65_2 = var_1_10002(var_65_0 .. var_5.getConfig(var_65_1, "painting") .. "_n")

	if arg_65_0.isToggleShowBg and not var_65_2 then
		triggerToggle = var_3

		var_3(arg_65_0.showBgToggle, false)

		arg_65_0.isToggleShowBg = false
	elseif var_65_2 then
		triggerToggle = var_3

		var_3(arg_65_0.showBgToggle, true)

		arg_65_0.isToggleShowBg = true
	end

	local var_65_3 = arg_65_0.shipSkin
	local var_65_4

	if not var_3.IsSpine(var_65_3) then
		var_65_3 = arg_65_0.shipSkin

		if not var_3.IsLive2d(var_65_3) then
			var_65_3 = arg_65_0.shipSkin

			if not var_3.IsSpinePlus(var_65_3) then
				var_65_3 = arg_65_0.shipSkin
				var_65_4 = var_3.IsLive2dPlus(var_65_3)
			end
		end
	end

	local var_65_5 = arg_65_0.shipSkin
	local var_65_6 = var_4.IsHxDynamicPreview(var_65_5)

	if var_65_4 and not var_65_6 then
		PlayerPrefs = var_65_3

		local var_65_7 = var_65_3.GetInt
		local var_65_8 = "skinShop#l2dPreViewToggle"

		getProxy = var_65_10
		PlayerProxy = var_1_10010
		var_1_10010 = var_65_10(var_1_10010)

		if var_65_7(var_65_8 .. var_65_10.getRawData(var_1_10010).id, 0) == 1 then
			arg_65_0.isToggleDynamic = true
		end
	end

	local var_65_10

	if var_65_4 then
		local var_65_9 = 0

		var_65_10 = arg_65_0.shipSkin

		if var_65_5.IsSpine(var_65_10) then
			var_65_9 = 6
		else
			var_65_10 = arg_65_0.shipSkin

			if var_65_5.IsLive2d(var_65_10) then
				var_65_9 = 1
			else
				var_65_10 = arg_65_0.shipSkin

				if var_65_5.IsSpinePlus(var_65_10) then
					var_65_9 = 7
				else
					var_65_10 = arg_65_0.shipSkin

					if var_65_5.IsLive2dPlus(var_65_10) then
						var_65_9 = 9
					end
				end
			end
		end

		LoadImageSpriteAtlasAsync = var_65_5
		var_65_10 = "SkinIcon"

		local var_65_11 = "type_"

		ShipSkin = var_1_10010

		var_65_5(var_65_10, var_65_11 .. var_1_10010.Tag2Name(var_65_9) .. "_off", arg_65_0.dynamicToggle)

		LoadImageSpriteAtlasAsync = var_65_5
		var_65_10 = "SkinIcon"

		local var_65_12 = "type_"

		ShipSkin = var_1_10010

		local var_65_13 = var_65_12 .. var_1_10010.Tag2Name(var_65_9)
		local var_65_14 = arg_65_0.dynamicToggle

		var_65_5(var_65_10, var_65_13, var_1_10010.Find(var_65_14, "select"))
	end

	if var_65_6 and arg_65_0.isToggleDynamic then
		triggerToggle = var_5

		var_5(arg_65_0.dynamicToggle, false)

		arg_65_0.isToggleDynamic = false
	end

	if arg_65_0.isToggleDynamic and not var_65_4 then
		triggerToggle = var_65_16

		var_65_16(arg_65_0.dynamicToggle, false)

		arg_65_0.isToggleDynamic = false

		goto label_65_0
	end

	if arg_65_0.isToggleDynamic then
		local var_65_15 = arg_65_0.dynamicToggle
		local var_65_16 = var_65_16.GetComponent

		typeof = var_65_10
		Toggle = var_1_10010

		if not var_65_16(var_65_15, var_65_10(var_1_10010)).isOn then
			local var_65_17 = arg_65_0.shipSkin

			if not var_65_16.IsLive2d(var_65_17) then
				var_65_17 = arg_65_0.shipSkin

				if var_65_16.IsLive2dPlus(var_65_17) then
					Live2dConst = var_65_16

					if var_65_16.GetLive2DArm32MatchAble() then
						arg_65_0.isToggleDynamic = false
						getProxy = var_65_16
						PlayerProxy = var_65_17

						local var_65_18 = var_65_16(var_65_17)

						var_65_16 = var_65_16.getRawData(var_65_18).id
						PlayerPrefs = var_65_5

						var_65_5.SetInt("skinShop#l2dPreViewToggle" .. var_65_16, 0)

						PlayerPrefs = var_6

						var_6.Save()

						triggerToggle = var_6

						var_6(arg_65_0.dynamicToggle, false)

						goto label_65_0
					end
				end

				triggerToggle = var_65_16

				var_65_16(arg_65_0.dynamicToggle, true)

				arg_65_0.isToggleDynamic = true

				::label_65_0::

				if var_65_2 then
					onToggle = var_65_16

					local var_65_19 = arg_65_0
					local var_65_20 = arg_65_0.showBgToggle

					local function var_65_21(arg_66_0)
						arg_65_0.isToggleShowBg = arg_66_0

						local var_66_0 = arg_65_0

						var_1.FlushPainting(var_66_0, arg_65_1)

						local var_66_1 = arg_65_0

						var_1.FlushBG(var_66_1, arg_65_1)

						return
					end

					SFX_PANEL = var_1_10010

					var_65_16(var_65_19, var_65_20, var_65_21, var_1_10010)
				end

				local var_65_22 = arg_65_0.shipSkin

				if not var_5.IsSpine(var_65_22) then
					local var_65_23 = arg_65_0.shipSkin

					if not var_5.IsLive2d(var_65_23) then
						local var_65_24 = arg_65_0.shipSkin

						if not var_5.IsSpinePlus(var_65_24) then
							local var_65_25 = arg_65_0.shipSkin

							if var_5.IsLive2dPlus(var_65_25) then
								onToggle = var_5

								local var_65_26 = arg_65_0
								local var_65_27 = arg_65_0.dynamicToggle

								local function var_65_28(arg_67_0)
									local var_67_0 = arg_65_0.shipSkin
									local var_67_1 = var_1.IsHxDynamicPreview(var_67_0)

									if arg_67_0 and var_67_1 then
										pg = var_2_10002

										local var_67_2 = var_2_10002.TipsMgr.GetInstance()

										var_2_10002 = var_2_10002.ShowTips
										i18n = var_2_10005

										var_2_10002(var_67_2, var_2_10005("shop_tag_control_tip"))

										triggerToggle = var_2_10002

										var_2_10002(arg_65_0.dynamicToggle, false)

										setActive = var_2_10002

										var_2_10002(arg_65_0.dynamicResToggle, false)

										return
									end

									if arg_67_0 then
										Live2dConst = var_2_10002

										if var_2_10002.GetLive2DArm32MatchAble() then
											local var_67_3 = arg_65_0.shipSkin

											if not var_2.IsLive2d(var_67_3) then
												local var_67_4 = arg_65_0.shipSkin

												if var_2.IsLive2dPlus(var_67_4) then
													Live2dConst = var_2

													var_2.ShowLive2DArm32Tips()

													triggerToggle = var_2

													var_2(arg_65_0.dynamicToggle, false)

													return
												end

												local var_67_5 = arg_65_0

												var_67_5.isToggleDynamic = arg_67_0
												setActive = var_67_5

												var_67_5(arg_65_0.showBgToggle, not arg_67_0 and var_65_2)

												local var_67_6 = arg_65_0

												var_2.FlushPainting(var_67_6, arg_65_1)

												local var_67_7 = arg_65_0

												var_2.FlushDynamicPaintingResState(var_67_7, arg_65_1)

												local var_67_8 = arg_65_0

												var_2.RecordFlag(var_67_8, arg_67_0)

												return
											end
										end
									end
								end

								SFX_PANEL = var_1_10010

								var_5(var_65_26, var_65_27, var_65_28, var_1_10010)
							end

							setActive = var_5

							var_5(arg_65_0.dynamicIcon, true)

							if arg_65_0.isToggleDynamic then
								arg_65_0:FlushDynamicPaintingResState(arg_65_1)
							elseif var_65_6 then
								setActive = var_5

								var_5(arg_65_0.dynamicResToggle, false)

								setActive = var_5

								var_5(arg_65_0.dynamicIcon, false)
							end

							setActive = var_5

							var_5(arg_65_0.dynamicToggle, var_65_4)

							setActive = var_5

							var_5(arg_65_0.showBgToggle, not arg_65_0.isToggleDynamic and var_65_2)

							return
						end
					end
				end
			end
		end
	end
end

function var_0_1.FlushTag(arg_68_0)
	local var_68_0 = arg_68_0.skinId

	pg = var_1_10002

	local var_68_1 = var_1_10002.ship_skin_template[var_68_0]

	Clone = var_1_10003

	local var_68_2 = var_1_10003(var_68_1.tag)
	local var_68_3 = false

	for iter_68_0 = #var_68_2, 1, -1 do
		if var_68_2[iter_68_0] == 1 or var_9 == 6 or var_9 == 7 or var_9 == 9 then
			local var_68_4 = true

			table = var_1_10010

			var_1_10010.remove(var_68_2, iter_68_0)
		end
	end

	checkABExist = var_5

	local var_68_5 = "painting/"
	local var_68_6 = arg_68_0.shipSkin
	local var_68_7 = var_5(var_68_5 .. var_8.getConfig(var_68_6, "painting") .. "_n")
	local var_68_8 = arg_68_0.tagList

	var_6.make(var_68_8, function(arg_69_0, arg_69_1, arg_69_2)
		UIItemList = var_2_10003

		if arg_69_0 == var_2_10003.EventUpdate then
			local var_69_0 = var_68_2[arg_69_1 + 1]

			LoadSpriteAtlasAsync = var_4

			local var_69_1 = "SkinIcon"
			local var_69_2 = "type_"

			ShipSkin = var_2_10008

			var_4(var_69_1, var_69_2 .. var_2_10008.Tag2Name(var_68_2[arg_69_1 + 1]), function(arg_70_0)
				if arg_68_0.exited then
					return
				end

				local var_70_0 = arg_69_2
				local var_70_1 = var_1.GetComponent

				typeof = var_3_10004
				Image = var_3_10006
				var_70_1(var_70_0, var_3_10004(var_3_10006)).sprite = arg_70_0

				return
			end)
		end

		return
	end)

	local var_68_9 = arg_68_0.tagList

	var_6.align(var_68_9, #var_68_2)

	return
end

function var_0_1.FlushPainting(arg_71_0, arg_71_1)
	local var_71_0 = arg_71_0:GetPaintingState(arg_71_1)

	pg = var_1_10003

	local var_71_1 = var_1_10003.ship_skin_template[arg_71_0.skinId].painting

	ShipSkin = var_4

	local var_71_2 = var_4.GetChangeSkinData(arg_71_0.skinId) and true or false

	if var_71_0 == var_0_3 and not arg_71_0:ExistL2dRes(var_71_1) or var_71_0 == var_0_4 and not arg_71_0:ExistSpineRes(var_71_1) then
		var_71_0 = var_0_2
	end

	if arg_71_0.paintingState and arg_71_0.paintingState.state == var_71_0 and arg_71_0.paintingState.id == arg_71_1.id and arg_71_0.paintingState.showBg == arg_71_0.isToggleShowBg and arg_71_0.paintingState.purchaseFlag == arg_71_1.buyCount and not var_71_2 then
		return
	end

	arg_71_0:ClearPainting()

	if var_71_0 == var_0_2 then
		arg_71_0:LoadMeshPainting(arg_71_1, arg_71_0.isToggleShowBg)
	elseif var_71_0 == var_0_3 then
		arg_71_0:LoadL2dPainting(arg_71_1)
	elseif var_71_0 == var_0_4 then
		arg_71_0:LoadSpinePainting(arg_71_1)
	end

	arg_71_0.paintingState = {
		state = var_71_0,
		id = arg_71_1.id,
		showBg = arg_71_0.isToggleShowBg,
		purchaseFlag = arg_71_1.buyCount
	}

	arg_71_0:AdjustPainting(false)

	return
end

function var_0_1.ClearPainting(arg_72_0)
	if not arg_72_0.paintingState then
		return
	end

	if var_1.state == var_0_2 then
		arg_72_0:ClearMeshPainting()
	elseif var_1.state == var_0_3 then
		arg_72_0:ClearL2dPainting()
	elseif var_1.state == var_0_4 then
		arg_72_0:ClearSpinePainting()
	end

	arg_72_0.paintingState = nil

	return
end

function var_0_1.LoadMeshPainting(arg_73_0, arg_73_1, arg_73_2)
	findTF = var_1_10003

	local var_73_0 = var_1_10003(arg_73_0.paintingTF, "fitter")

	GetOrAddComponent = var_1_10004

	local var_73_1 = var_1_10004(var_73_0, "PaintingScaler")

	var_73_1.FrameName = "chuanwu"
	var_73_1.Tween = 1
	pg = var_5

	local var_73_2 = var_5.ship_skin_template[arg_73_0.skinId].painting
	local var_73_3

	if not arg_73_2 then
		checkABExist = var_7

		if var_7("painting/" .. var_73_3 .. "_n") then
			var_73_3 = var_73_3 .. "_n"
		end
	end

	checkABExist = var_7

	if not var_7("painting/" .. var_73_3) then
		return
	end

	PLATFORM_CODE = var_7
	PLATFORM_CH = var_1_10008

	if var_7 == var_1_10008 then
		checkABExist = var_7

		if var_7("painting/" .. var_73_3 .. "_shop") then
			var_73_3 = var_73_3 .. "_shop"
		end
	end

	pg = var_7

	local var_73_4 = var_7.UIMgr.GetInstance()

	var_7.LoadingOn(var_73_4)

	PoolMgr = var_7

	local var_73_5 = var_7.GetInstance()

	var_7.GetPainting(var_73_5, var_73_3, true, function(arg_74_0)
		pg = var_2_10001

		local var_74_0 = var_2_10001.UIMgr.GetInstance()

		var_1.LoadingOff(var_74_0)

		setParent = var_1

		var_1(arg_74_0, var_73_0, false)

		ShipExpressionHelper = var_1

		local var_74_1 = var_1.SetExpression
		local var_74_2 = var_73_0

		var_74_1(var_3.GetChild(var_74_2, 0), var_73_2)

		arg_73_0.paintingName = var_73_3

		if arg_73_0.paintingState and arg_73_0.paintingState.id ~= arg_73_1.id then
			local var_74_3 = arg_73_0

			var_1.ClearMeshPainting(var_74_3)
		end

		local var_74_4 = arg_74_0.transform
		local var_74_5 = var_1.Find(var_74_4, "shop_hx")
		local var_74_6 = arg_73_0

		var_2.CheckShowShopHx(var_74_6, var_74_5)

		pg = var_2

		local var_74_7 = var_2.SdkMgr.GetInstance()
		local var_74_8 = var_2.GetChannelUIDIncludeHarmony(var_74_7)
		local var_74_9 = arg_74_0.transform
		local var_74_10 = var_3.Find(var_74_9, "shop_hx_ch" .. var_74_8)
		local var_74_11 = arg_73_0

		var_4.CheckShowShopHx(var_74_11, var_74_10)

		return
	end)

	return
end

function var_0_1.ClearMeshPainting(arg_75_0)
	local var_75_0 = arg_75_0.paintingTF
	local var_75_1 = var_1.Find(var_75_0, "fitter")

	if arg_75_0.paintingName and var_75_1.childCount > 0 then
		local var_75_2 = var_75_1:GetChild(0).gameObject.transform
		local var_75_3 = var_3.Find(var_75_2, "shop_hx")

		arg_75_0:RevertShopHx(var_75_3)

		PoolMgr = var_4

		local var_75_4 = var_4.GetInstance()

		var_4.ReturnPainting(var_75_4, arg_75_0.paintingName, var_2)
	end

	arg_75_0.paintingName = nil

	return
end

function var_0_1.LoadL2dPainting(arg_76_0, arg_76_1)
	local var_76_0 = arg_76_0.skinId

	pg = var_1_10003

	local var_76_1 = var_1_10003.ship_skin_template[var_76_0].skin_type
	local var_76_2

	ShipSkin = var_1_10005

	local var_76_3

	if var_76_1 == var_1_10005.SKIN_TYPE_TB then
		VirtualEducateCharShip = var_76_3
		var_76_3 = var_76_3.New
		NewEducateHelper = var_1_10007
		var_76_2 = var_76_3(var_1_10007.GetSecIdBySkinId(var_76_0))
	else
		pg = var_76_3
		var_76_3 = var_76_3.ship_skin_template[var_76_0].ship_group
		ShipGroup = var_1_10006

		local var_76_4 = var_1_10006.getDefaultShipConfig(var_76_3)

		Ship = var_1_10007
		var_76_2 = var_1_10007.New({
			noChangeSkin = true,
			configId = var_76_4.id,
			skin_id = var_76_0
		})
	end

	Live2DPainting = var_76_3

	local var_76_5 = var_76_3.GenerateData
	local var_76_6 = {
		ship = var_76_2
	}

	Vector3 = var_1_10008
	var_76_6.position = var_1_10008(0, 0, -1)
	var_76_6.parent = arg_76_0.live2dContainer
	var_76_6.offset = var_76_2:GetSkinConfig().shop_offset

	local var_76_7 = var_76_5(var_76_6)

	var_76_7.shopPreView = true
	pg = var_6

	local var_76_8 = var_6.UIMgr.GetInstance()

	var_6.LoadingOn(var_76_8)

	Live2DPainting = var_6
	arg_76_0.live2dChar = var_6.New(var_76_7, function(arg_77_0)
		arg_77_0:IgonreReactPos(true)

		local var_77_0 = arg_76_0

		var_1.CheckShowShopHxForL2d(var_77_0, arg_77_0, arg_76_1)

		if arg_76_0.paintingState and arg_76_0.paintingState.id ~= arg_76_1.id then
			local var_77_1 = arg_76_0

			var_1.ClearL2dPainting(var_77_1)
		end

		local var_77_2 = arg_77_0
		local var_77_3 = arg_77_0.setSortingLayer

		LayerWeightConst = var_4

		var_77_3(var_77_2, var_4.L2D_DEFAULT_LAYER)

		pg = var_77_3

		local var_77_4 = var_77_3.UIMgr.GetInstance()

		var_1.LoadingOff(var_77_4)

		return
	end)

	return
end

function var_0_1.ClearL2dPainting(arg_78_0)
	if arg_78_0.live2dChar then
		arg_78_0:RevertShopHxForL2d(arg_78_0.live2dChar)

		local var_78_0 = arg_78_0.live2dChar

		var_1.Dispose(var_78_0)

		arg_78_0.live2dChar = nil
	end

	return
end

function var_0_1.LoadSpinePainting(arg_79_0, arg_79_1)
	local var_79_0 = arg_79_0.skinId

	pg = var_1_10003

	local var_79_1 = var_1_10003.ship_skin_template[var_79_0].skin_type
	local var_79_2

	ShipSkin = var_1_10005

	local var_79_3

	if var_79_1 == var_1_10005.SKIN_TYPE_TB then
		VirtualEducateCharShip = var_79_3
		var_79_3 = var_79_3.New
		NewEducateHelper = var_1_10007
		var_79_2 = var_79_3(var_1_10007.GetSecIdBySkinId(var_79_0))
	else
		pg = var_79_3
		var_79_3 = var_79_3.ship_skin_template[var_79_0].ship_group
		ShipGroup = var_1_10006
		var_1_10006 = var_1_10006.getDefaultShipConfig(var_79_3)
		Ship = var_1_10007
		var_79_2 = var_1_10007.New({
			noChangeSkin = true,
			configId = var_1_10006.id,
			skin_id = var_79_0
		})
	end

	SpinePainting = var_79_3

	local var_79_4 = var_79_3.GenerateData
	local var_79_5 = {
		ship = var_79_2
	}

	Vector3 = var_1_10008
	var_79_5.position = var_1_10008(0, 0, 0)
	var_79_5.parent = arg_79_0.spTF
	var_79_5.effectParent = arg_79_0.spBg
	var_79_5.offset = var_79_2:GetSkinConfig().shop_offset

	local var_79_6 = var_79_4(var_79_5)

	pg = var_1_10006

	local var_79_7 = var_1_10006.UIMgr.GetInstance()

	var_6.LoadingOn(var_79_7)

	SpinePainting = var_6
	arg_79_0.spinePainting = var_6.New(var_79_6, function(arg_80_0)
		arg_80_0:SetShopHx(true)

		if arg_79_0.paintingState and arg_79_0.paintingState.id ~= arg_79_1.id then
			local var_80_0 = arg_79_0

			var_1.ClearSpinePainting(var_80_0)
		end

		local var_80_1 = arg_80_0._tf
		local var_80_2 = var_1.Find(var_80_1, "shop_hx")
		local var_80_3 = arg_79_0

		var_2.CheckShowShopHx(var_80_3, var_80_2)

		pg = var_2

		local var_80_4 = var_2.SdkMgr.GetInstance()
		local var_80_5 = var_2.GetChannelUIDIncludeHarmony(var_80_4)
		local var_80_6 = arg_80_0._tf
		local var_80_7 = var_3.Find(var_80_6, "shop_hx_ch" .. var_80_5)
		local var_80_8 = arg_79_0

		var_4.CheckShowShopHx(var_80_8, var_80_7)

		pg = var_4

		local var_80_9 = var_4.UIMgr.GetInstance()

		var_4.LoadingOff(var_80_9)

		return
	end)

	return
end

function var_0_1.ClearSpinePainting(arg_81_0)
	if arg_81_0.spinePainting and arg_81_0.spinePainting._tf then
		local var_81_0 = arg_81_0.spinePainting._tf
		local var_81_1 = var_1.Find(var_81_0, "shop_hx")

		arg_81_0:RevertShopHx(arg_81_0.shopHx)

		local var_81_2 = arg_81_0.spinePainting

		var_2.Dispose(var_81_2)

		arg_81_0.spinePainting = nil
	end

	return
end

function var_0_1.CheckShowShopHx(arg_82_0, arg_82_1)
	IsNil = var_1_10002

	if var_1_10002(arg_82_1) then
		return
	end

	setActive = var_2

	var_2(arg_82_1, false)

	PLATFORM_CODE = var_2
	PLATFORM_CH = var_1_10003

	if var_2 ~= var_1_10003 then
		return
	end

	HXSet = var_2

	if not var_2.isHx() then
		return
	end

	setActive = var_2

	var_2(arg_82_1, true)

	return
end

function var_0_1.RevertShopHx(arg_83_0, arg_83_1)
	IsNil = var_1_10002

	if not var_1_10002(arg_83_1) then
		setActive = var_2

		var_2(arg_83_1, false)
	end

	return
end

function var_0_1.CheckShowShopHxForL2d(arg_84_0, arg_84_1, arg_84_2)
	PLATFORM_CODE = var_1_10003
	PLATFORM_CH = var_1_10004

	if var_1_10003 ~= var_1_10004 then
		return
	end

	HXSet = var_1_10003

	if not var_1_10003.isHx() then
		return
	end

	local var_84_0 = 1

	arg_84_1:changeParamaterValue("shop_hx", var_84_0)

	return
end

function var_0_1.RevertShopHxForL2d(arg_85_0, arg_85_1)
	arg_85_1:changeParamaterValue("shop_hx", 0)

	return
end

function var_0_1.AdjustPainting(arg_86_0, arg_86_1)
	local var_86_0 = arg_86_0.paintingTF

	pg = var_1_10003

	local var_86_1

	if var_1_10003.ship_skin_newmainui_shift[arg_86_0.skinId] then
		var_86_1 = var_3.skin_shop_shift

		if arg_86_1 then
			Vector2 = var_1_10005
			var_86_0.anchoredPosition = var_1_10005(var_86_1[1] - 440, var_86_1[2] + arg_86_0.defaultPaintingPosition.y)
		else
			Vector2 = var_1_10005
			var_86_0.anchoredPosition = var_1_10005(var_86_1[1] + arg_86_0.defaultPaintingPosition.x, var_86_1[2] + arg_86_0.defaultPaintingPosition.y)
		end

		local var_86_2 = var_86_1[4]

		Vector3 = var_1_10006
		var_86_0.localScale = var_1_10006(var_86_2, var_86_2, 1)
	else
		Vector2 = var_86_1
		var_86_0.anchoredPosition = var_86_1(arg_86_0.defaultPaintingPosition.x, arg_86_0.defaultPaintingPosition.y)
		var_86_0.localScale = arg_86_0.defaultPaintingScale
	end

	return
end

function var_0_1.FlushBG(arg_87_0, arg_87_1, arg_87_2)
	local var_87_0 = arg_87_0.skinId

	pg = var_1_10004

	local var_87_1 = var_1_10004.ship_skin_template[var_87_0]
	local var_87_2
	local var_87_3 = var_87_1.skin_type

	ShipSkin = var_1_10007

	if var_87_3 == var_1_10007.SKIN_TYPE_TB then
		VirtualEducateCharShip = var_87_3
		var_87_3 = var_87_3.New
		NewEducateHelper = var_1_10008
		var_87_2 = var_87_3(var_1_10008.GetSecIdBySkinId(var_87_0))
	else
		ShipGroup = var_87_3

		local var_87_4 = var_87_3.getDefaultShipConfig(var_87_1.ship_group)

		Ship = var_7
		var_87_2 = var_7.New({
			id = 999,
			configId = var_87_4.id,
			skin_id = var_87_0
		})
	end

	local var_87_5 = var_87_2:getShipBgPrint(true)

	pg = var_7

	local var_87_6 = var_7.ship_skin_template[var_87_0].painting

	if not arg_87_0.isToggleShowBg then
		checkABExist = var_8

		if not var_8("painting/" .. var_87_6 .. "_n") then
			if var_87_1.bg_sp ~= "" then
				var_87_5 = var_87_1.bg_sp
			end
		end

		local var_87_8

		if var_87_5 ~= var_87_2:rarity2bgPrintForGet() then
			pg = var_87_8

			local var_87_7 = var_87_8.DynamicBgMgr.GetInstance()

			var_87_8 = var_87_8.LoadBg

			local var_87_9 = arg_87_0
			local var_87_10 = var_87_5
			local var_87_11 = arg_87_0.bgs
			local var_87_12 = var_14.Find(var_87_11, "diffBg")
			local var_87_13 = arg_87_0.bgs

			var_87_8(var_87_7, var_87_9, var_87_10, var_87_12, var_15.Find(var_87_13, "diffBg/bg"), function(arg_88_0)
				if arg_87_2 then
					arg_87_2()
				end

				return
			end, function(arg_89_0)
				if arg_87_2 then
					arg_87_2()
				end

				return
			end)
		else
			pg = var_87_8

			local var_87_14 = var_87_8.DynamicBgMgr.GetInstance()

			var_87_8.ClearBg(var_87_14, arg_87_0:getUIName())

			if arg_87_2 then
				arg_87_2()
			end
		end

		setActive = var_87_8

		local var_87_15 = arg_87_0.bgs

		var_87_8(var_11.Find(var_87_15, "diffBg"), var_8)

		setActive = var_87_8

		local var_87_16 = arg_87_0.bgs

		var_87_8(var_11.Find(var_87_16, "default"), not var_8)

		return
	end
end

function var_0_1.FlushDynamicPaintingResState(arg_90_0, arg_90_1)
	if not arg_90_0.isToggleDynamic then
		return
	end

	local var_90_0 = arg_90_0:GetPaintingState(arg_90_1)
	local var_90_1 = false
	local var_90_2 = ""

	pg = var_5

	local var_90_3 = var_5.ship_skin_template[arg_90_0.skinId].painting
	local var_90_4

	if var_0_3 == var_90_0 then
		local var_90_5

		var_90_4, var_90_5 = arg_90_0:ExistL2dRes(var_90_3)
		var_90_2 = var_90_5
		var_90_1 = var_90_4
	elseif var_0_4 == var_90_0 then
		local var_90_6

		var_90_4, var_90_6 = arg_90_0:ExistSpineRes(var_90_3)
		var_90_2 = var_90_6
		var_90_1 = var_90_4
	end

	setActive = var_90_4

	var_90_4(arg_90_0.dynamicResToggle, not var_90_1)

	removeOnButton = var_90_4

	var_90_4(arg_90_0.dynamicResToggle)

	if not var_90_1 and var_90_2 ~= "" then
		onButton = var_90_4

		local var_90_7 = arg_90_0
		local var_90_8 = arg_90_0.dynamicResToggle

		local function var_90_9()
			local var_91_0 = arg_90_0

			var_0.DownloadDynamicPainting(var_91_0, var_90_2, arg_90_1)

			return
		end

		SFX_PANEL = var_1_10011

		var_90_4(var_90_7, var_90_8, var_90_9, var_1_10011)
	end

	return
end

function var_0_1.DownloadDynamicPainting(arg_92_0, arg_92_1, arg_92_2)
	local var_92_0 = arg_92_0.skinId

	if arg_92_0.downloads[var_92_0] then
		return
	end

	SkinShopDownloadRequest = var_4

	local var_92_1 = var_4.New()

	arg_92_0.downloads[var_92_0] = var_92_1

	var_92_1:Start(arg_92_1, function(arg_93_0)
		if arg_93_0 and arg_92_0.paintingState and arg_92_0.paintingState.id == arg_92_2.id then
			local var_93_0 = arg_92_0

			var_1.FlushPainting(var_93_0, arg_92_2)

			local var_93_1 = arg_92_0

			var_1.FlushDynamicPaintingResState(var_93_1, arg_92_2)
		end

		local var_93_2 = var_92_1

		var_1.Dispose(var_93_2)

		arg_92_0.downloads[var_92_0] = nil

		return
	end)

	return
end

function var_0_1.GetPaintingState(arg_94_0, arg_94_1)
	if arg_94_0.isToggleDynamic then
		local var_94_0 = arg_94_0.shipSkin

		if not var_2.IsLive2d(var_94_0) then
			local var_94_1 = arg_94_0.shipSkin

			if var_2.IsLive2dPlus(var_94_1) then
				do return var_0_3 end

				goto label_94_0
			end

			if arg_94_0.isToggleDynamic then
				local var_94_2 = arg_94_0.shipSkin

				if not var_2.IsSpine(var_94_2) then
					do
						local var_94_3 = arg_94_0.shipSkin

						if var_2.IsSpinePlus(var_94_3) then
							local var_94_4 = arg_94_0.shipSkin

							if var_2.getConfig(var_94_4, "spine_use_live2d") == 1 then
								return var_0_3
							end

							do return var_0_4 end

							goto label_94_0
						end

						return var_0_2
					end

					::label_94_0::

					return
				end
			end
		end
	end
end

function var_0_1.ExistL2dRes(arg_95_0, arg_95_1)
	local var_95_0 = "live2d/"

	string = var_1_10003

	local var_95_1 = var_95_0 .. var_1_10003.lower(arg_95_1)

	HXSet = var_3

	local var_95_2 = var_3.autoHxShiftPath(var_95_1, nil, true)

	checkABExist = var_3

	return var_3(var_95_2), var_95_2
end

function var_0_1.ExistSpineRes(arg_96_0, arg_96_1)
	local var_96_0 = "SpinePainting/"

	string = var_1_10003

	local var_96_1 = var_96_0 .. var_1_10003.lower(arg_96_1)

	HXSet = var_3

	local var_96_2 = var_3.autoHxShiftPath(var_96_1, nil, true)

	checkABExist = var_3

	return var_3(var_96_2), var_96_2
end

function var_0_1.RecordFlag(arg_97_0, arg_97_1)
	getProxy = var_1_10002
	PlayerProxy = var_1_10004

	local var_97_0 = var_1_10002(var_1_10004)
	local var_97_1 = var_2.getRawData(var_97_0).id

	PlayerPrefs = var_1_10003

	var_1_10003.SetInt("skinShop#l2dPreViewToggle" .. var_97_1, arg_97_1 and 1 or 0)

	PlayerPrefs = var_3

	var_3.Save()

	local var_97_2 = arg_97_0
	local var_97_3 = arg_97_0.emit

	LatestSkinShopMediator = var_6

	var_97_3(var_97_2, var_6.ON_RECORD_ANIM_PREVIEW_BTN, arg_97_1)

	return
end

function var_0_1.FlushPrice(arg_98_0, arg_98_1)
	local var_98_0 = arg_98_1
	local var_98_1 = arg_98_1.getConfig(var_98_0, "genre")

	ShopArgs = var_1_10003

	local var_98_2 = var_98_1 == var_1_10003.SkinShopTimeLimit
	local var_98_3 = arg_98_1.type

	Goods = var_98_0

	local var_98_5

	if var_98_3 ~= var_98_0.TYPE_ACTIVITY then
		local var_98_4 = arg_98_1.type

		Goods = var_4

		if var_98_4 ~= var_4.TYPE_ACTIVITY_EXTRA then
			var_98_5 = false

			goto label_98_0
		end
	end

	var_98_5 = true

	::label_98_0::

	if var_98_2 then
		local var_98_6 = arg_98_0.mode

		NewSkinShopScene = var_5

		if var_98_6 == var_5.MODE_EXPERIENCE_FOR_ITEM then
			arg_98_0:UpdateExperiencePrice4Item(arg_98_1)
		else
			arg_98_0:UpdateExperiencePrice(arg_98_1)
		end
	elseif arg_98_0.isPreviewFurniture then
		arg_98_0:UpdateFurniturePrice(arg_98_1)
	elseif var_98_5 then
		-- block empty
	else
		arg_98_0:UpdateCommodityPrice(arg_98_1)
	end

	local var_98_7 = arg_98_1.type

	Goods = var_5

	local var_98_8 = var_98_7 == var_5.TYPE_SKIN

	setActive = var_5

	local var_98_9 = arg_98_0.price

	var_5(var_7.Find(var_98_9, "timeLimit"), var_98_2 and not var_98_5)

	setActive = var_5

	local var_98_10 = arg_98_0.price

	var_5(var_7.Find(var_98_10, "consume"), var_98_8 and not var_98_2 and not var_98_5)

	return
end

function var_0_1.UpdateExperiencePrice4Item(arg_99_0, arg_99_1)
	local var_99_0 = arg_99_1
	local var_99_1 = arg_99_1.getConfig(var_99_0, "resource_num")

	getProxy = var_1_10003
	BagProxy = var_5

	local var_99_2 = var_1_10003(var_5)
	local var_99_3 = var_3.GetSkinExperienceItems(var_99_2)

	_ = var_99_0

	local var_99_4

	if not var_99_0.detect(var_99_3, function(arg_100_0)
		return arg_100_0:CanUseForShop(arg_99_1.id)
	end) or not var_4.count then
		var_99_4 = 0
	end

	if var_99_4 < var_99_1 then
		local var_99_5 = "<color="

		COLOR_RED = var_7

		local var_99_6

		if not (var_99_5 .. var_7 .. ">") then
			var_99_6 = ""
		end

		local var_99_7 = var_99_6 .. var_99_4 .. (var_99_4 < var_99_1 and "</color>" or "")

		setText = var_7

		local var_99_8 = arg_99_0.price

		var_7(var_9.Find(var_99_8, "timeLimit/consume/Text"), var_99_7 .. "/" .. var_99_1)

		return
	end
end

function var_0_1.UpdateExperiencePrice(arg_101_0, arg_101_1)
	local var_101_0 = arg_101_1:getConfig("resource_num")

	getProxy = var_1_10003
	PlayerProxy = var_5

	local var_101_1 = var_1_10003(var_5)
	local var_101_2 = var_3.getRawData(var_101_1)

	if var_3.getSkinTicket(var_101_2) < var_101_0 then
		local var_101_3 = "<color="

		COLOR_RED = var_101_2

		local var_101_4

		if not (var_101_3 .. var_101_2 .. ">") then
			var_101_4 = ""
		end

		local var_101_5 = var_101_4 .. var_3 .. (var_3 < var_101_0 and "</color>" or "")

		setText = var_5

		local var_101_6 = arg_101_0.price

		var_5(var_7.Find(var_101_6, "timeLimit/consume/Text"), var_101_5 .. "/" .. var_101_0)

		return
	end
end

function var_0_1.UpdateCommodityPrice(arg_102_0, arg_102_1)
	local var_102_0 = arg_102_1
	local var_102_1 = arg_102_1.GetPrice(var_102_0)
	local var_102_2 = arg_102_1:getConfig("resource_num")

	setText = var_102_0

	local var_102_3 = arg_102_0.price

	var_102_0(var_6.Find(var_102_3, "consume/Text"), var_102_1)

	setText = var_102_0

	local var_102_4 = arg_102_0.price

	var_102_0(var_6.Find(var_102_4, "consume/originalprice/Text"), var_102_2)

	setActive = var_102_0

	local var_102_5 = arg_102_0.price

	var_102_0(var_6.Find(var_102_5, "consume/originalprice"), var_102_1 ~= var_102_2)

	return
end

function var_0_1.UpdateFurniturePrice(arg_103_0, arg_103_1)
	Goods = var_1_10002

	local var_103_0 = var_1_10002.Id2FurnitureId(arg_103_1.id)

	Furniture = var_1_10003

	local var_103_1 = var_1_10003.New({
		id = var_103_0
	})
	local var_103_2 = var_3.getConfig(var_103_1, "gem_price")

	setText = var_5

	local var_103_3 = arg_103_0.price

	var_5(var_7.Find(var_103_3, "consume/originalprice/Text"), var_103_2)

	local var_103_4 = var_3
	local var_103_5 = var_3.getPrice

	PlayerConst = var_8

	local var_103_6 = var_103_5(var_103_4, var_8.ResDiamond)

	setText = var_103_1

	local var_103_7 = arg_103_0.price

	var_103_1(var_8.Find(var_103_7, "consume/Text"), var_103_6)

	setActive = var_103_1

	local var_103_8 = arg_103_0.price

	var_103_1(var_8.Find(var_103_8, "consume/originalprice"), var_103_2 ~= var_103_6)

	return
end

function var_0_1.FlushObtainBtn(arg_104_0, arg_104_1)
	local var_104_0 = arg_104_0:GetObtainBtnState(arg_104_1)
	local var_104_1 = var_0_20(var_104_0)

	for iter_104_0 = 0, arg_104_0.btns.childCount - 1 do
		local var_104_2 = arg_104_0.btns
		local var_104_3 = var_8.GetChild(var_104_2, iter_104_0)

		setActive = var_1_10009

		var_1_10009(var_104_3, var_104_3.name == var_104_1)
	end

	setActive = var_4

	local var_104_4 = arg_104_0.price

	var_4(var_6.Find(var_104_4, "btn/item"), var_104_0 == var_0_12)

	setActive = var_4

	local var_104_5 = arg_104_0.price

	var_4(var_6.Find(var_104_5, "btn/tag"), var_104_0 == var_0_12)

	if var_104_0 == var_0_12 then
		arg_104_0:FlushGift(arg_104_1)
	end

	onButton = var_4

	local var_104_6 = arg_104_0
	local var_104_7 = arg_104_0.price
	local var_104_8 = var_7.Find(var_104_7, "btn")

	local function var_104_9()
		local var_105_0 = {}

		SkinCouponActivity = var_2_10001

		local var_105_1 = var_2_10001.StaticEncoreActTip(arg_104_1.id)

		tobool = var_2_10002

		if var_2_10002(var_105_1) then
			table = var_2

			var_2.insert(var_105_0, function(arg_106_0)
				pg = var_3_10001

				local var_106_0 = var_3_10001.MsgboxMgr.GetInstance()
				local var_106_1 = var_1.ShowMsgBox
				local var_106_2 = {}

				i18n = var_3_10005
				var_106_2.content = var_3_10005("SkinDiscount_Hint")

				function var_106_2.onYes()
					if var_105_1 then
						local var_107_0 = var_105_1

						if not var_0.isEnd(var_107_0) then
							local var_107_1 = arg_104_0
							local var_107_2 = var_0.emit

							LatestSkinShopMediator = var_4_10003

							var_107_2(var_107_1, var_4_10003.OPEN_ACTIVITY, var_105_1.id)
						end
					end

					return
				end

				var_106_2.onNo = arg_106_0

				var_106_1(var_106_0, var_106_2)

				return
			end)
		end

		local var_105_2 = arg_104_1
		local var_105_3 = var_2.getConfig(var_105_2, "genre")

		ShopArgs = var_3

		if var_105_3 == var_3.SkinShop then
			local var_105_4 = arg_104_1

			if not var_105_3.IsItemDiscountType(var_105_4) then
				SkinCouponActivity = var_105_3

				if #var_105_3.GetOvercountEncoreActs(arg_104_1.id) > 0 then
					table = var_3

					var_3.insert(var_105_0, function(arg_108_0)
						pg = var_3_10001

						local var_108_0 = var_3_10001.MsgboxMgr.GetInstance()
						local var_108_1 = var_1.ShowMsgBox
						local var_108_2 = {}

						i18n = var_3_10005
						var_108_2.content = var_3_10005("SkinDiscount_Last_Coupon")
						var_108_2.onYes = arg_108_0

						var_108_1(var_108_0, var_108_2)

						return
					end)
				end
			end
		end

		seriesAsync = var_105_3

		var_105_3(var_105_0, function()
			if var_104_0 == var_0_6 or var_104_0 == var_0_8 or var_104_0 == var_0_12 then
				local var_109_0 = arg_104_0.purchaseView

				var_0.ExecuteAction(var_109_0, "Show", arg_104_1)
			else
				local var_109_1 = arg_104_0

				var_0.OnClickBtn(var_109_1, var_104_0, arg_104_1)
			end

			return
		end)

		return
	end

	SFX_PANEL = var_104_7

	var_4(var_104_6, var_104_8, var_104_9, var_104_7)

	return
end

function var_0_1.GetObtainBtnState(arg_110_0, arg_110_1)
	local var_110_0 = arg_110_1
	local var_110_1 = arg_110_1.getConfig(var_110_0, "genre")

	ShopArgs = var_1_10003

	if var_110_1 == var_1_10003.SkinShopTimeLimit then
		do return var_0_10 end

		goto label_110_0
	end

	if arg_110_0.isPreviewFurniture then
		getProxy = var_2
		DormProxy = var_110_0

		local var_110_2 = var_2(var_110_0)
		local var_110_3 = var_2.getRawData(var_110_2)
		local var_110_4 = var_2.HasFurniture

		Goods = var_5

		if var_110_4(var_110_3, var_5.Id2FurnitureId(arg_110_1.id)) then
			return var_0_5
		else
			return var_0_9
		end

		goto label_110_0
	end

	local var_110_5 = arg_110_1.type

	Goods = var_3

	if var_110_5 ~= var_3.TYPE_ACTIVITY then
		do
			local var_110_6 = arg_110_1.type

			Goods = var_3

			if var_110_6 == var_3.TYPE_ACTIVITY_EXTRA then
				return var_0_7
			elseif arg_110_1.buyCount > 0 then
				return var_0_5
			elseif arg_110_1:isDisCount() and arg_110_1:IsItemDiscountType() then
				return var_0_8
			elseif arg_110_1:CanUseVoucherType() or arg_110_1:ExistExclusiveDiscountItem() then
				return var_0_11
			elseif #arg_110_1:GetGiftList() > 0 then
				return var_0_12
			else
				return var_0_6
			end
		end

		::label_110_0::

		return
	end
end

function var_0_1.FlushGift(arg_111_0, arg_111_1)
	local var_111_0 = arg_111_1
	local var_111_1 = arg_111_1.GetGiftList(var_111_0)[1]

	updateDrop = var_111_0

	local var_111_2 = arg_111_0.price

	var_111_0(var_6.Find(var_111_2, "btn/item/mask/item"), {
		type = var_111_1.type,
		id = var_111_1.id,
		count = var_111_1.count
	})

	return
end

function var_0_1.OnClickBtn(arg_112_0, arg_112_1, arg_112_2)
	if arg_112_1 == var_0_6 or arg_112_1 == var_0_8 or arg_112_1 == var_0_12 then
		arg_112_0:OnPurchase(arg_112_2)
	elseif arg_112_1 == var_0_11 then
		arg_112_0:OnItemPurchase(arg_112_2)
	elseif arg_112_1 == var_0_7 then
		arg_112_0:OnActivity(arg_112_2)
	elseif arg_112_1 == var_0_9 then
		arg_112_0:OnBackyard(arg_112_2)
	elseif arg_112_1 == var_0_10 then
		local var_112_0 = arg_112_0.mode

		NewSkinShopScene = var_1_10004

		if var_112_0 == var_1_10004.MODE_EXPERIENCE_FOR_ITEM then
			arg_112_0:OnExperience4Item(arg_112_2)
		else
			arg_112_0:OnExperience(arg_112_2)
		end
	end

	return
end

function var_0_1.FlushGifgPackBtn(arg_113_0, arg_113_1)
	local var_113_0 = false
	local var_113_1
	local var_113_2
	local var_113_3

	pairs = var_1_10006

	for iter_113_0, iter_113_1 in var_1_10006(arg_113_0.giftSkinCommodities) do
		ipairs = var_1_10011

		for iter_113_2, iter_113_3 in var_1_10011(iter_113_1) do
			if iter_113_3.id == arg_113_1.id then
				var_113_0 = true

				break
			end
		end

		if var_113_0 then
			var_113_1 = arg_113_0.giftPackCommodities[iter_113_0]
			var_113_2 = arg_113_0.giftSkinCommodities[iter_113_0]
			var_113_3 = arg_113_0.giftSkinProbabilitys[iter_113_0]

			break
		end
	end

	local var_113_5

	if var_113_0 then
		setText = var_6

		local var_113_4 = arg_113_0.giftPackBtn

		var_113_5 = var_113_5.Find(var_113_4, "title")
		i18n = iter_113_0

		var_6(var_113_5, iter_113_0("skinshop_on_sale_tip_2"))

		onButton = var_6
		var_113_5 = arg_113_0

		local var_113_6 = arg_113_0.giftPackBtn

		local function var_113_7()
			local var_114_0 = var_113_1

			if not var_0.isChargeType(var_114_0) then
				return
			end

			local var_114_1 = var_113_1
			local var_114_2 = var_0.GetSkinProbability(var_114_1)

			getProxy = var_2_10001
			ShipSkinProxy = var_2_10003

			local var_114_3 = var_2_10001(var_2_10003)
			local var_114_4 = var_1.GetProbabilitySkins(var_114_3, var_114_2)

			if #var_114_2 <= 0 or #var_114_2 ~= #var_114_4 then
				local var_114_5 = arg_113_0
				local var_114_6 = var_2.emit

				LatestSkinShopMediator = var_2_10005
				var_2_10005 = var_2_10005.OPEN_SCENE

				local var_114_7 = {}

				SCENE = var_2_10007
				var_114_7[1] = var_2_10007.CHARGE

				local var_114_8 = {}

				ChargeScene = var_2_10008
				var_114_8.wrap = var_2_10008.TYPE_PICK
				var_114_7[2] = var_114_8

				var_114_6(var_114_5, var_2_10005, var_114_7)
			else
				local var_114_9 = arg_113_0
				local var_114_10 = var_2.emit

				LatestSkinShopMediator = var_2_10005

				var_114_10(var_114_9, var_2_10005.OPEN_GIFT_PACK_LAYER, var_113_1, var_113_2, var_113_3)
			end

			return
		end

		SFX_PANEL = var_11

		var_6(var_113_5, var_113_6, var_113_7, var_11)
	else
		getProxy = var_6
		ActivityProxy = var_113_5

		local var_113_8 = var_6(var_113_5)

		if var_6.GetFakeGiftPackActivity(var_113_8, arg_113_1) then
			setText = var_6

			local var_113_9 = arg_113_0.giftPackBtn
			local var_113_10 = var_8.Find(var_113_9, "title")

			i18n = var_9

			var_6(var_113_10, var_9("skinshop_on_sale_tip"))

			onButton = var_6

			local var_113_11 = arg_113_0
			local var_113_12 = arg_113_0.giftPackBtn

			local function var_113_13()
				local var_115_0 = arg_113_0
				local var_115_1 = var_0.emit

				LatestSkinShopMediator = var_2_10003

				var_115_1(var_115_0, var_2_10003.OPEN_GIFT_ACT_LAYER, var_113_0.id)

				return
			end

			SFX_PANEL = var_11

			var_6(var_113_11, var_113_12, var_113_13, var_11)
		end
	end

	setActive = var_6

	var_6(arg_113_0.giftPackBtn, var_113_0)

	return
end

function var_0_1.SetGiftPackLayer(arg_116_0)
	return
end

function var_0_1.OnPurchase(arg_117_0, arg_117_1)
	local var_117_0 = arg_117_1.type

	Goods = var_1_10003

	if var_117_0 ~= var_1_10003.TYPE_SKIN then
		return
	end

	if arg_117_1:isDisCount() and arg_117_1:IsItemDiscountType() then
		local var_117_1 = arg_117_0
		local var_117_2 = arg_117_0.emit

		LatestSkinShopMediator = var_1_10005

		var_117_2(var_117_1, var_1_10005.ON_SHOPPING_BY_ACT, arg_117_1.id, 1)
	else
		local var_117_3 = arg_117_0
		local var_117_4 = arg_117_0.emit

		LatestSkinShopMediator = var_1_10005

		var_117_4(var_117_3, var_1_10005.ON_SHOPPING, arg_117_1.id, 1)
	end

	return
end

function var_0_1.OnItemPurchase(arg_118_0, arg_118_1)
	local var_118_0 = arg_118_1.type

	Goods = var_1_10003

	if var_118_0 ~= var_1_10003.TYPE_SKIN then
		return
	end

	local var_118_1 = arg_118_1:GetVoucherIdList()

	getProxy = var_3
	BagProxy = var_1_10005

	local var_118_2 = var_3(var_1_10005)
	local var_118_3 = var_3.GetExclusiveDiscountItem4Shop(var_118_2, arg_118_1.id)

	if #var_118_1 <= 0 and #var_118_3 <= 0 then
		return
	end

	local var_118_4 = {}

	ipairs = var_5

	for iter_118_0, iter_118_1 in var_5(var_118_1) do
		table = var_1_10010

		var_1_10010.insert(var_118_4, iter_118_1)
	end

	ipairs = var_5

	for iter_118_2, iter_118_3 in var_5(var_118_3) do
		table = var_1_10010

		var_1_10010.insert(var_118_4, iter_118_3.id)
	end

	local var_118_5 = arg_118_0.skinId

	pg = var_6

	local var_118_6 = var_6.ship_skin_template[var_118_5]

	SwitchSpecialChar = var_7

	local var_118_7 = var_7(var_118_6.name, true)
	local var_118_8 = arg_118_0.voucherMsgBox

	var_8.ExecuteAction(var_118_8, "Show", {
		itemList = var_118_4,
		skinId = var_118_5,
		skinName = var_118_7,
		price = arg_118_1:GetPrice(),
		onYes = function(arg_119_0)
			if arg_119_0 then
				local var_119_0 = arg_118_0
				local var_119_1 = var_1.emit

				LatestSkinShopMediator = var_2_10004

				var_119_1(var_119_0, var_2_10004.ON_ITEM_PURCHASE, arg_119_0, arg_118_1.id)
			else
				local var_119_2 = arg_118_0
				local var_119_3 = var_1.emit

				LatestSkinShopMediator = var_2_10004

				var_119_3(var_119_2, var_2_10004.ON_SHOPPING, arg_118_1.id, 1)
			end

			return
		end
	})

	return
end

function var_0_1.OnActivity(arg_120_0, arg_120_1)
	local var_120_0 = arg_120_1
	local var_120_1 = arg_120_1.getConfig(var_120_0, "time")
	local var_120_2 = arg_120_1
	local var_120_3 = arg_120_1.getConfig(var_120_2, "activity")

	getProxy = var_120_0
	ActivityProxy = var_6

	local var_120_4 = var_120_0(var_6)
	local var_120_5 = var_4.getActivityById(var_120_4, var_120_3)

	if var_120_3 == 0 then
		pg = var_120_2

		local var_120_6 = var_120_2.TimeMgr.GetInstance()

		if not var_120_2.inTime(var_120_6, var_120_1) then
			if var_120_5 and not var_120_5:isEnd() then
				var_120_2 = arg_120_1.type
				Goods = var_120_4

				if var_120_2 == var_120_4.TYPE_ACTIVITY then
					local var_120_7 = arg_120_0

					var_120_2 = arg_120_0.emit
					LatestSkinShopMediator = var_1_10008

					var_120_2(var_120_7, var_1_10008.GO_SHOPS_LAYER, arg_120_1:getConfig("activity"))
				else
					var_120_2 = arg_120_1.type
					Goods = var_6

					if var_120_2 == var_6.TYPE_ACTIVITY_EXTRA then
						if arg_120_1:getConfig("scene") and #var_120_2 > 0 then
							var_1_10008 = arg_120_0

							local var_120_8 = arg_120_0.emit

							LatestSkinShopMediator = var_1_10009

							var_120_8(var_1_10008, var_1_10009.OPEN_SCENE, var_120_2)
						else
							var_1_10008 = arg_120_0

							local var_120_9 = arg_120_0.emit

							LatestSkinShopMediator = var_1_10009

							var_120_9(var_1_10008, var_1_10009.OPEN_ACTIVITY, var_120_3)
						end
					end
				end
			else
				pg = var_120_2

				local var_120_10 = var_120_2.TipsMgr.GetInstance()
				local var_120_11 = var_5.ShowTips

				i18n = var_1_10008

				var_120_11(var_120_10, var_1_10008("common_activity_not_start"))
			end

			return
		end
	end
end

function var_0_1.OnBackyard(arg_121_0, arg_121_1)
	pg = var_1_10002

	local var_121_0 = var_1_10002.SystemOpenMgr.GetInstance()
	local var_121_1 = var_2.isOpenSystem

	getProxy = var_1_10005
	PlayerProxy = var_1_10007

	local var_121_2 = var_1_10005(var_1_10007)
	local var_121_4

	if not var_121_1(var_121_0, var_5.getRawData(var_121_2).level, "BackYardMediator") then
		pg = var_2

		local var_121_3 = var_2.open_systems_limited[1]

		pg = var_1_10003
		var_121_4 = var_1_10003.TipsMgr.GetInstance()

		local var_121_5 = var_3.ShowTips

		i18n = var_6

		var_121_5(var_121_4, var_6("no_open_system_tip", var_121_3.name, var_121_3.level))

		return
	end

	local var_121_6 = arg_121_0
	local var_121_7 = arg_121_0.emit

	LatestSkinShopMediator = var_121_4

	var_121_7(var_121_6, var_121_4.ON_BACKYARD_SHOP)

	return
end

function var_0_1.OnExperience(arg_122_0, arg_122_1)
	local var_122_0 = arg_122_0.skinId

	getProxy = var_1_10003
	ShipSkinProxy = var_1_10005

	local var_122_1 = var_1_10003(var_1_10005)

	if var_3.getSkinById(var_122_1, var_122_0) and not var_3:isExpireType() then
		pg = var_4

		local var_122_2 = var_4.TipsMgr.GetInstance()
		local var_122_3 = var_4.ShowTips

		i18n = var_1_10007

		var_122_3(var_122_2, var_1_10007("already_have_the_skin"))

		return
	end

	local var_122_4 = arg_122_1
	local var_122_5 = arg_122_1.getConfig(var_122_4, "resource_num")
	local var_122_6 = arg_122_1:getConfig("time_second") * var_122_5

	pg = var_122_4

	local var_122_7 = var_122_4.TimeMgr.GetInstance()
	local var_122_8, var_122_9, var_122_10, var_122_11 = var_6.parseTimeFrom(var_122_7, var_122_6)

	pg = var_1_10010

	local var_122_12 = var_1_10010.ship_skin_template[arg_122_0.skinId].name

	pg = var_11

	local var_122_13 = var_11.MsgboxMgr.GetInstance()
	local var_122_14 = var_11.ShowMsgBox
	local var_122_15 = {}

	i18n = var_1_10015
	var_122_15.content = var_1_10015("exchange_limit_skin_tip", var_122_5, var_122_12, var_122_8, var_122_9)

	function var_122_15.onYes()
		getProxy = var_2_10000
		PlayerProxy = var_2_10002

		local var_123_0 = var_2_10000(var_2_10002)
		local var_123_1 = var_0.getRawData(var_123_0)

		if var_0.getSkinTicket(var_123_1) < var_122_5 then
			pg = var_0

			local var_123_2 = var_0.TipsMgr.GetInstance()
			local var_123_3 = var_0.ShowTips

			i18n = var_2_10003

			var_123_3(var_123_2, var_2_10003("common_no_item_1"))

			return
		end

		local var_123_4 = arg_122_0
		local var_123_5 = var_0.emit

		LatestSkinShopMediator = var_2_10003

		var_123_5(var_123_4, var_2_10003.ON_SHOPPING, arg_122_1.id, 1)

		return
	end

	var_122_14(var_122_13, var_122_15)

	return
end

function var_0_1.OnExperience4Item(arg_124_0, arg_124_1)
	local var_124_0 = arg_124_0.skinId

	getProxy = var_1_10003
	ShipSkinProxy = var_1_10005

	local var_124_1 = var_1_10003(var_1_10005)

	if var_3.getSkinById(var_124_1, var_124_0) and not var_3:isExpireType() then
		pg = var_4

		local var_124_2 = var_4.TipsMgr.GetInstance()
		local var_124_3 = var_4.ShowTips

		i18n = var_1_10007

		var_124_3(var_124_2, var_1_10007("already_have_the_skin"))

		return
	end

	local var_124_4 = arg_124_1
	local var_124_5 = arg_124_1.getConfig(var_124_4, "resource_num")
	local var_124_6 = arg_124_1:getConfig("time_second") * var_124_5

	pg = var_124_4

	local var_124_7 = var_124_4.TimeMgr.GetInstance()
	local var_124_8, var_124_9, var_124_10, var_124_11 = var_6.parseTimeFrom(var_124_7, var_124_6)

	pg = var_1_10010

	local var_124_12 = var_1_10010.ship_skin_template[arg_124_0.skinId].name

	getProxy = var_11
	BagProxy = var_1_10013

	local var_124_13 = var_11(var_1_10013)
	local var_124_14 = var_11.GetSkinExperienceItems(var_124_13)

	_ = var_1_10012

	local var_124_15 = var_1_10012.detect(var_124_14, function(arg_125_0)
		return arg_125_0:CanUseForShop(arg_124_1.id)
	end)

	pg = var_124_13

	local var_124_16 = var_124_13.MsgboxMgr.GetInstance()
	local var_124_17 = var_13.ShowMsgBox
	local var_124_18 = {}

	i18n = var_1_10017
	var_124_18.content = var_1_10017("exchange_limit_skin_tip", var_124_5, var_124_12, var_124_8, var_124_9)

	function var_124_18.onYes()
		if not var_124_15 or var_124_15.count < var_124_5 then
			pg = var_0

			local var_126_0 = var_0.TipsMgr.GetInstance()
			local var_126_1 = var_0.ShowTips

			i18n = var_2_10003

			var_126_1(var_126_0, var_2_10003("common_no_item_1"))

			return
		end

		local var_126_2 = arg_124_0
		local var_126_3 = var_0.emit

		LatestSkinShopMediator = var_2_10003

		var_126_3(var_126_2, var_2_10003.ON_ITEM_EXPERIENCE, var_124_15.id, arg_124_1.id, 1)

		return
	end

	var_124_17(var_124_16, var_124_18)

	return
end

function var_0_1.SetFilterPanel(arg_127_0)
	local var_127_0 = arg_127_0.filterContent
	local var_127_1 = var_1.Find(var_127_0, "own/options")
	local var_127_2 = arg_127_0.filterContent
	local var_127_3 = var_2.Find(var_127_2, "type/options")
	local var_127_4 = arg_127_0.filterContent
	local var_127_5 = var_3.Find(var_127_4, "shipHave/options")
	local var_127_6 = arg_127_0.filterContent
	local var_127_7 = var_4.Find(var_127_6, "camp/options")
	local var_127_8 = arg_127_0.filterContent
	local var_127_9 = var_5.Find(var_127_8, "rarity/options")
	local var_127_10 = arg_127_0.filterContent
	local var_127_11 = var_6.Find(var_127_10, "shipType/options")
	local var_127_12 = arg_127_0.filterContent
	local var_127_13 = var_7.Find(var_127_12, "themeType/options")
	local var_127_14 = arg_127_0.filterContent
	local var_127_15 = var_8.Find(var_127_14, "tag/options")
	local var_127_16 = arg_127_0
	local var_127_17 = arg_127_0.SetOptionList
	local var_127_18 = var_127_7

	ShipIndexConst = var_1_10013

	var_127_17(var_127_16, var_127_18, var_1_10013.CampNames, true)

	local var_127_19 = arg_127_0
	local var_127_20 = arg_127_0.SetOptionList
	local var_127_21 = var_127_9

	ShipIndexConst = var_13

	var_127_20(var_127_19, var_127_21, var_13.RarityNames, true)

	local var_127_22 = arg_127_0
	local var_127_23 = arg_127_0.SetOptionList
	local var_127_24 = var_127_11

	ShipIndexConst = var_13

	var_127_23(var_127_22, var_127_24, var_13.TypeNames, true)
	arg_127_0:SetOptionList(var_127_13, arg_127_0.classifyNames)
	arg_127_0:SetSingleOptions(var_127_1, "ownType")
	arg_127_0:SetMultiOptions(var_127_3, "typeType")
	arg_127_0:SetSingleOptions(var_127_5, "shipHaveType")
	arg_127_0:SetMultiOptions(var_127_7, "campType")
	arg_127_0:SetMultiOptions(var_127_9, "rarityType")
	arg_127_0:SetMultiOptions(var_127_11, "shipType")
	arg_127_0:SetMultiOptions(var_127_13, "themeType")
	arg_127_0:SetMultiOptions(var_127_15, "tagType")
	arg_127_0:HideEmptyOptions()

	onButton = var_9

	local var_127_25 = arg_127_0
	local var_127_26 = arg_127_0.filterUI
	local var_127_27 = var_12.Find(var_127_26, "bg")

	local function var_127_28()
		pairs = var_2_10000

		for iter_128_0, iter_128_1 in var_2_10000(arg_127_0.filterValues) do
			local var_128_0 = arg_127_0.filterValuesTemp

			Clone = var_2_10006
			var_128_0[iter_128_0] = var_2_10006(arg_127_0.filterValues[iter_128_0])
		end

		setActive = var_0

		var_0(arg_127_0.filterUI, false)

		return
	end

	SFX_PANEL = var_127_26

	var_9(var_127_25, var_127_27, var_127_28, var_127_26)

	onButton = var_9

	local var_127_29 = arg_127_0
	local var_127_30 = arg_127_0.filterUI
	local var_127_31 = var_12.Find(var_127_30, "panelMask/panel/closeBtn")

	local function var_127_32()
		pairs = var_2_10000

		for iter_129_0, iter_129_1 in var_2_10000(arg_127_0.filterValues) do
			local var_129_0 = arg_127_0.filterValuesTemp

			Clone = var_2_10006
			var_129_0[iter_129_0] = var_2_10006(arg_127_0.filterValues[iter_129_0])
		end

		setActive = var_0

		var_0(arg_127_0.filterUI, false)

		return
	end

	SFX_PANEL = var_127_30

	var_9(var_127_29, var_127_31, var_127_32, var_127_30)

	onButton = var_9

	local var_127_33 = arg_127_0
	local var_127_34 = arg_127_0.filterUI
	local var_127_35 = var_12.Find(var_127_34, "panelMask/panel/bottom/ok")

	local function var_127_36()
		pairs = var_2_10000

		for iter_130_0, iter_130_1 in var_2_10000(arg_127_0.filterValues) do
			local var_130_0 = arg_127_0.filterValues

			Clone = var_2_10006
			var_130_0[iter_130_0] = var_2_10006(arg_127_0.filterValuesTemp[iter_130_0])
		end

		setActive = var_0

		var_0(arg_127_0.filterUI, false)

		local var_130_1 = arg_127_0

		var_0.Refresh(var_130_1, true)

		return
	end

	SFX_PANEL = var_127_34

	var_9(var_127_33, var_127_35, var_127_36, var_127_34)

	return
end

function var_0_1.OpenFilterPanel(arg_131_0)
	setActive = var_1_10001

	var_1_10001(arg_131_0.filterUI, true)

	local var_131_0 = arg_131_0.filterContent
	local var_131_1 = var_1.Find(var_131_0, "own/options")
	local var_131_2 = arg_131_0.filterContent
	local var_131_3 = var_2.Find(var_131_2, "type/options")
	local var_131_4 = arg_131_0.filterContent
	local var_131_5 = var_3.Find(var_131_4, "shipHave/options")
	local var_131_6 = arg_131_0.filterContent
	local var_131_7 = var_4.Find(var_131_6, "camp/options")
	local var_131_8 = arg_131_0.filterContent
	local var_131_9 = var_5.Find(var_131_8, "rarity/options")
	local var_131_10 = arg_131_0.filterContent
	local var_131_11 = var_6.Find(var_131_10, "shipType/options")
	local var_131_12 = arg_131_0.filterContent
	local var_131_13 = var_7.Find(var_131_12, "themeType/options")
	local var_131_14 = arg_131_0.filterContent
	local var_131_15 = var_8.Find(var_131_14, "tag/options")

	arg_131_0:SetSingleOptions(var_131_1, "ownType", true)
	arg_131_0:SetMultiOptions(var_131_3, "typeType", true)
	arg_131_0:SetSingleOptions(var_131_5, "shipHaveType", true)
	arg_131_0:SetMultiOptions(var_131_7, "campType", true)
	arg_131_0:SetMultiOptions(var_131_9, "rarityType", true)
	arg_131_0:SetMultiOptions(var_131_11, "shipType", true)
	arg_131_0:SetMultiOptions(var_131_13, "themeType", true)
	arg_131_0:SetMultiOptions(var_131_15, "tagType", true)

	return
end

function var_0_1.SetOptionList(arg_132_0, arg_132_1, arg_132_2, arg_132_3)
	UIItemList = var_1_10004

	local var_132_0 = var_1_10004.New(arg_132_1, arg_132_1:GetChild(0))

	var_4.make(var_132_0, function(arg_133_0, arg_133_1, arg_133_2)
		UIItemList = var_2_10003

		if arg_133_0 == var_2_10003.EventUpdate then
			local var_133_0 = arg_132_2[arg_133_1 + 1]

			if arg_132_3 then
				i18n = var_4
				var_133_0 = var_4(var_133_0)
			end

			arg_133_2.name = arg_133_1
			setScrollText = var_4

			var_4(arg_133_2:Find("mask/Text"), var_133_0)
		end

		return
	end)
	var_4:align(#arg_132_2)

	return
end

function var_0_1.SetSingleOptions(arg_134_0, arg_134_1, arg_134_2, arg_134_3)
	for iter_134_0 = 0, arg_134_1.childCount - 1 do
		local var_134_0 = arg_134_1:GetChild(iter_134_0)
		local var_134_1 = arg_134_0
		local var_134_2 = arg_134_0.SetOptionSelect
		local var_134_3 = arg_134_1

		var_134_2(var_134_1, arg_134_1.GetChild(var_134_3, iter_134_0), iter_134_0 == arg_134_0.filterValuesTemp[arg_134_2])

		if not arg_134_3 then
			onButton = var_134_2

			local var_134_4 = arg_134_0
			local var_134_5 = var_134_0

			local function var_134_6()
				arg_134_0.filterValuesTemp[arg_134_2] = iter_134_0

				for iter_135_0 = 0, arg_134_1.childCount - 1 do
					local var_135_0 = arg_134_0
					local var_135_1 = var_4.SetOptionSelect
					local var_135_2 = arg_134_1

					var_135_1(var_135_0, var_7.GetChild(var_135_2, iter_135_0), iter_135_0 == iter_134_0)
				end

				return
			end

			SFX_PANEL = var_134_3

			var_134_2(var_134_4, var_134_5, var_134_6, var_134_3)
		end
	end

	return
end

function var_0_1.SetMultiOptions(arg_136_0, arg_136_1, arg_136_2, arg_136_3)
	for iter_136_0 = 0, arg_136_1.childCount - 1 do
		local var_136_0 = arg_136_1:GetChild(iter_136_0)
		local var_136_1 = arg_136_0
		local var_136_2 = arg_136_0.SetOptionSelect
		local var_136_3 = arg_136_1
		local var_136_4 = arg_136_1.GetChild(var_136_3, iter_136_0)

		table = var_1_10013

		var_136_2(var_136_1, var_136_4, var_1_10013.contains(arg_136_0.filterValuesTemp[arg_136_2], iter_136_0))

		if not arg_136_3 then
			onButton = var_136_2

			local var_136_5 = arg_136_0
			local var_136_6 = var_136_0

			function var_1_10013()
				local var_137_0

				if iter_136_0 == 0 then
					var_137_0 = arg_136_0.filterValuesTemp
					var_137_0[arg_136_2] = {
						0
					}

					for iter_137_0 = 0, arg_136_1.childCount - 1 do
						local var_137_1 = arg_136_0
						local var_137_2 = var_4.SetOptionSelect

						var_2_10009 = arg_136_1

						var_137_2(var_137_1, var_7.GetChild(var_2_10009, iter_137_0), iter_137_0 == 0)
					end
				else
					table = var_137_0

					var_137_0.removebyvalue(arg_136_0.filterValuesTemp[arg_136_2], 0)

					table = var_0

					if var_0.contains(arg_136_0.filterValuesTemp[arg_136_2], iter_136_0) then
						table = var_0

						var_0.removebyvalue(arg_136_0.filterValuesTemp[arg_136_2], iter_136_0)
					else
						table = var_0

						var_0.insert(arg_136_0.filterValuesTemp[arg_136_2], iter_136_0)
					end

					local var_137_3 = true

					for iter_137_1 = 1, arg_136_1.childCount - 1 do
						table = var_2_10005

						if not var_2_10005.contains(arg_136_0.filterValuesTemp[arg_136_2], iter_137_1) then
							local var_137_4 = arg_136_1

							if var_2_10005.GetChild(var_137_4, iter_137_1).gameObject.activeSelf then
								var_137_3 = false

								break
							end
						end
					end

					if #arg_136_0.filterValuesTemp[arg_136_2] == 0 then
						var_137_3 = true
					end

					if var_137_3 and arg_136_2 ~= "tagType" then
						arg_136_0.filterValuesTemp[arg_136_2] = {
							0
						}
					end

					for iter_137_2 = 0, arg_136_1.childCount - 1 do
						local var_137_5 = arg_136_0
						local var_137_6 = var_5.SetOptionSelect
						local var_137_7 = arg_136_1
						local var_137_8 = var_8.GetChild(var_137_7, iter_137_2)

						table = var_2_10009

						var_137_6(var_137_5, var_137_8, var_2_10009.contains(arg_136_0.filterValuesTemp[arg_136_2], iter_137_2))
					end
				end

				return
			end

			SFX_PANEL = var_136_3

			var_136_2(var_136_5, var_136_6, var_1_10013, var_136_3)
		end
	end

	return
end

function var_0_1.SetOptionSelect(arg_138_0, arg_138_1, arg_138_2)
	setActive = var_1_10003

	var_1_10003(arg_138_1:Find("selectedFrame"), arg_138_2)

	local var_138_0

	IsNil = var_1_10004

	local var_138_2

	if var_1_10004(arg_138_1:Find("Text")) then
		local var_138_1 = arg_138_1:Find("mask/Text")

		var_138_2 = var_138_2.GetComponent
		typeof = var_7
		Text = var_9
		var_138_0 = var_138_2(var_138_1, var_7(var_9))
	else
		local var_138_3 = arg_138_1:Find("Text")

		var_138_2 = var_138_2.GetComponent
		typeof = var_7
		Text = var_9
		var_138_0 = var_138_2(var_138_3, var_7(var_9))
	end

	if arg_138_2 then
		Color = var_138_2
		var_138_0.color = var_138_2.New(1, 1, 1, 1)
	else
		Color = var_138_2
		var_138_0.color = var_138_2.New(0, 0, 0, 0.5)
	end

	return
end

function var_0_1.HideEmptyOptions(arg_139_0, arg_139_1, arg_139_2)
	local var_139_0 = {
		typeType = {
			0
		},
		shipHaveType = {
			0
		},
		campType = {
			0
		},
		rarityType = {
			0
		},
		shipType = {
			0
		},
		tagType = {
			0
		}
	}

	ipairs = var_4

	for iter_139_0, iter_139_1 in var_4(arg_139_0.commodities) do
		var_1_10011 = iter_139_1
		var_1_10009 = iter_139_1.getSkinId(var_1_10011)
		ShipSkin = var_1_10010
		var_1_10010 = var_1_10010.New({
			id = var_1_10009
		})
		var_1_10011 = arg_139_0:GetSkinType(var_1_10010)
		ipairs = var_12

		for iter_139_2, iter_139_3 in var_12(var_1_10011) do
			table = var_1_10017

			if not var_1_10017.keyof(var_139_0.typeType, iter_139_3) then
				table = var_1_10017

				var_1_10017.insert(var_139_0.typeType, iter_139_3)
			end
		end

		local var_139_1 = arg_139_0
		local var_139_2 = arg_139_0.GetShipHave(var_139_1, var_1_10010)

		table = var_13

		if not var_13.keyof(var_139_0.shipHaveType, var_139_2) then
			table = var_13

			var_13.insert(var_139_0.shipHaveType, var_139_2)
		end

		local var_139_3 = arg_139_0
		local var_139_4 = arg_139_0.GetCampType(var_139_3, var_1_10010)

		table = var_139_1

		if not var_139_1.keyof(var_139_0.campType, var_139_4) then
			table = var_14

			var_14.insert(var_139_0.campType, var_139_4)
		end

		local var_139_5 = arg_139_0
		local var_139_6 = arg_139_0.GetRarityType(var_139_5, var_1_10010)

		table = var_139_3

		if not var_139_3.keyof(var_139_0.rarityType, var_139_6) then
			table = var_15

			var_15.insert(var_139_0.rarityType, var_139_6)
		end

		var_1_10017 = arg_139_0

		local var_139_7 = arg_139_0.GetShipType(var_1_10017, var_1_10010)

		table = var_139_5

		if not var_139_5.keyof(var_139_0.shipType, var_139_7) then
			table = var_16

			var_16.insert(var_139_0.shipType, var_139_7)
		end

		local var_139_8 = arg_139_0:GetTagType(iter_139_1)

		table = var_1_10017

		if not var_1_10017.keyof(var_139_0.tagType, var_139_8) then
			table = var_1_10017

			var_1_10017.insert(var_139_0.tagType, var_139_8)
		end
	end

	pairs = var_4

	for iter_139_4, iter_139_5 in var_4(var_139_0) do
		table = var_1_10009

		var_1_10009.sort(iter_139_5, function(arg_140_0, arg_140_1)
			return arg_140_0 < arg_140_1
		end)
	end

	for iter_139_6 = 1, arg_139_0.uiTypeOptions.childCount - 1 do
		setActive = iter_139_5

		local var_139_9 = arg_139_0.uiTypeOptions
		local var_139_10 = var_10.GetChild(var_139_9, iter_139_6)

		table = var_1_10011

		iter_139_5(var_139_10, var_1_10011.contains(var_139_0.typeType, iter_139_6))
	end

	for iter_139_7 = 1, arg_139_0.uiShipHaveOptions.childCount - 1 do
		setActive = iter_139_5

		local var_139_11 = arg_139_0.uiShipHaveOptions
		local var_139_12 = var_10.GetChild(var_139_11, iter_139_7)

		table = var_1_10011

		iter_139_5(var_139_12, var_1_10011.contains(var_139_0.shipHaveType, iter_139_7))
	end

	for iter_139_8 = 1, arg_139_0.uiCampOptions.childCount - 1 do
		setActive = iter_139_5

		local var_139_13 = arg_139_0.uiCampOptions
		local var_139_14 = var_10.GetChild(var_139_13, iter_139_8)

		table = var_1_10011

		iter_139_5(var_139_14, var_1_10011.contains(var_139_0.campType, iter_139_8))
	end

	for iter_139_9 = 1, arg_139_0.uiRrarityOptions.childCount - 1 do
		setActive = iter_139_5

		local var_139_15 = arg_139_0.uiRrarityOptions
		local var_139_16 = var_10.GetChild(var_139_15, iter_139_9)

		table = var_1_10011

		iter_139_5(var_139_16, var_1_10011.contains(var_139_0.rarityType, iter_139_9))
	end

	for iter_139_10 = 1, arg_139_0.uiShipTypeOptions.childCount - 1 do
		setActive = iter_139_5

		local var_139_17 = arg_139_0.uiShipTypeOptions
		local var_139_18 = var_10.GetChild(var_139_17, iter_139_10)

		table = var_1_10011

		iter_139_5(var_139_18, var_1_10011.contains(var_139_0.shipType, iter_139_10))
	end

	for iter_139_11 = 1, arg_139_0.uiTagTypeOptions.childCount - 1 do
		setActive = iter_139_5

		local var_139_19 = arg_139_0.uiTagTypeOptions
		local var_139_20 = var_10.GetChild(var_139_19, iter_139_11)

		table = var_1_10011

		iter_139_5(var_139_20, var_1_10011.contains(var_139_0.tagType, iter_139_11))
	end

	return
end

function var_0_1.GetSkinType(arg_141_0, arg_141_1)
	local var_141_0 = {}

	if arg_141_1:IsLive2d() or arg_141_1:IsLive2dPlus() then
		table = var_3

		var_3.insert(var_141_0, 1)
	end

	if not arg_141_1:IsLive2d() and not arg_141_1:IsLive2dPlus() and not arg_141_1:IsSpine() and not arg_141_1:IsSpinePlus() then
		table = var_3

		var_3.insert(var_141_0, 2)
	end

	if arg_141_1:IsSpine() or arg_141_1:IsSpinePlus() then
		table = var_3

		var_3.insert(var_141_0, 3)
	end

	if arg_141_1:IsBG() then
		table = var_3

		var_3.insert(var_141_0, 4)
	end

	if arg_141_1:IsDbg() then
		table = var_3

		var_3.insert(var_141_0, 5)
	end

	if arg_141_1:isBgm() then
		table = var_3

		var_3.insert(var_141_0, 6)
	end

	return var_141_0
end

function var_0_1.GetShipHave(arg_142_0, arg_142_1)
	if arg_142_1:CantUse() then
		return 2
	else
		return 1
	end

	return
end

function var_0_1.GetCampType(arg_143_0, arg_143_1)
	if not arg_143_1:GetDefaultShipConfig() then
		return 0
	end

	local var_143_0 = arg_143_0
	local var_143_1 = arg_143_0.ToVShip(var_143_0, var_2)
	local var_143_2 = var_3.getNation(var_143_1)

	ShipIndexCfg = var_143_0

	local var_143_3 = var_143_0.camp

	ipairs = var_143_1

	for iter_143_0, iter_143_1 in var_143_1(var_143_3) do
		ipairs = var_1_10011

		for iter_143_2, iter_143_3 in var_1_10011(iter_143_1.types) do
			Nation = var_1_10016

			if iter_143_3 == var_1_10016.LINK then
				Nation = var_1_10016

				if var_1_10016.LINK <= var_143_2 then
					return iter_143_0 - 1
				end
			elseif var_143_2 == iter_143_3 then
				return iter_143_0 - 1
			end
		end
	end

	return 0
end

function var_0_1.GetRarityType(arg_144_0, arg_144_1)
	if not arg_144_1:GetDefaultShipConfig() then
		return 0
	end

	local var_144_0 = arg_144_0
	local var_144_1 = arg_144_0.ToVShip(var_144_0, var_2)
	local var_144_2 = var_3.getRarity(var_144_1)

	ShipIndexCfg = var_144_0

	local var_144_3 = var_144_0.rarity

	ipairs = var_144_1

	for iter_144_0, iter_144_1 in var_144_1(var_144_3) do
		table = var_1_10011

		if var_1_10011.contains(iter_144_1.types, var_144_2) then
			return iter_144_0 - 1
		end
	end

	return 0
end

function var_0_1.GetShipType(arg_145_0, arg_145_1)
	if not arg_145_1:GetDefaultShipConfig() then
		return 0
	end

	local var_145_0 = arg_145_0
	local var_145_1 = arg_145_0.ToVShip(var_145_0, var_2)
	local var_145_2 = var_3.getShipType(var_145_1)

	ShipIndexCfg = var_145_0

	local var_145_3 = var_145_0.type

	ipairs = var_145_1

	for iter_145_0, iter_145_1 in var_145_1(var_145_3) do
		pairs = var_1_10011

		for iter_145_2, iter_145_3 in var_1_10011(iter_145_1) do
			table = var_1_10016

			if var_1_10016.keyof(iter_145_3, var_145_2) then
				return iter_145_0 - 1
			end
		end
	end

	return 0
end

function var_0_1.GetTagType(arg_146_0, arg_146_1)
	table = var_1_10002

	local var_146_0 = var_1_10002.contains(arg_146_0.returnSkins, arg_146_1.id)

	NewShopSkinCard = var_1_10003

	if var_1_10003.GetTagId(arg_146_1, var_146_0) > 0 then
		return var_3
	else
		return 0
	end

	return
end

function var_0_1.GetSkinClassify(arg_147_0)
	arg_147_0.classifyIds = {}
	arg_147_0.classifyNames = {}

	local var_147_0 = {}
	local var_147_1 = {}

	ipairs = var_1_10003

	for iter_147_0, iter_147_1 in var_1_10003(arg_147_0.commodities) do
		local var_147_2

		if arg_147_0:GetShopTypeIdBySkinId(iter_147_1:getSkinId()) ~= 0 or not var_0_17 then
			var_147_2 = var_8
		end

		local var_147_3

		if not var_147_1[var_147_2] then
			var_147_3 = 0
		end

		var_147_1[var_147_2] = var_147_3 + 1
	end

	local var_147_4 = {}

	ipairs = var_4

	for iter_147_2, iter_147_3 in var_4(arg_147_0.returnSkins) do
		var_147_4[iter_147_3] = true
	end

	underscore = var_4

	if var_4.any(arg_147_0.commodities, function(arg_148_0)
		return var_147_4[arg_148_0.id]
	end) then
		table = var_4

		var_4.insert(var_147_0, var_0_15)
	end

	ipairs = var_4
	pg = var_6

	for iter_147_4, iter_147_5 in var_4(var_6.skin_page_template.all) do
		if iter_147_5 ~= var_0_18 and iter_147_5 ~= var_0_19 then
			local var_147_5

			if not var_147_1[iter_147_5] then
				var_147_5 = 0
			end

			if var_147_5 > 0 then
				table = var_147_5

				var_147_5.insert(var_147_0, iter_147_5)
			end
		end
	end

	if arg_147_0.mode == var_0_1.MODE_EXPERIENCE then
		table = var_4

		var_4.insert(var_147_0, 1, var_0_14)
	end

	if arg_147_0.mode == var_0_1.MODE_EXPERIENCE_FOR_ITEM then
		table = var_4

		var_4.insert(var_147_0, 1, var_0_16)
	end

	table = var_4

	var_4.insert(var_147_0, 1, var_0_13)

	arg_147_0.classifyIds = var_147_0
	ipairs = var_4

	for iter_147_6, iter_147_7 in var_4(arg_147_0.classifyIds) do
		if iter_147_7 == var_0_13 then
			table = var_9

			local var_147_6 = var_9.insert
			local var_147_7 = arg_147_0.classifyNames

			i18n = var_1_10012

			var_147_6(var_147_7, var_1_10012("shop_filter_all"))
		elseif iter_147_7 == var_0_14 or iter_147_7 == var_0_16 then
			table = var_9

			local var_147_8 = var_9.insert
			local var_147_9 = arg_147_0.classifyNames

			i18n = var_1_10012

			var_147_8(var_147_9, var_1_10012("shop_filter_trial"))
		else
			local var_147_10

			if iter_147_7 == var_0_15 then
				table = var_147_10
				var_147_10 = var_147_10.insert

				local var_147_11 = arg_147_0.classifyNames

				i18n = var_1_10012

				var_147_10(var_147_11, var_1_10012("shop_filter_retro"))
			else
				table = var_147_10

				local var_147_12 = var_147_10.insert
				local var_147_13 = arg_147_0.classifyNames

				pg = var_1_10012

				var_147_12(var_147_13, var_1_10012.skin_page_template[iter_147_7].name)
			end
		end
	end

	return
end

function var_0_1.GetShopTypeIdBySkinId(arg_149_0, arg_149_1)
	pg = var_1_10002

	local var_149_0 = var_1_10002.ship_skin_template.get_id_list_by_shop_type_id

	if not arg_149_0.shopTypeIdList then
		arg_149_0.shopTypeIdList = {}
	end

	if arg_149_0.shopTypeIdList[arg_149_1] then
		return arg_149_0.shopTypeIdList[arg_149_1]
	end

	pairs = var_3

	for iter_149_0, iter_149_1 in var_3(var_149_0) do
		ipairs = var_1_10008

		for iter_149_2, iter_149_3 in var_1_10008(iter_149_1) do
			arg_149_0.shopTypeIdList[iter_149_3] = iter_149_0

			if iter_149_3 == arg_149_1 then
				return iter_149_0
			end
		end
	end

	return
end

function var_0_1.OnShopping(arg_150_0, arg_150_1)
	if not arg_150_0.showingCommodity then
		return
	end

	if arg_150_0.purchaseView then
		local var_150_0 = arg_150_0.purchaseView

		if var_2.GetLoaded(var_150_0) then
			local var_150_1 = arg_150_0.purchaseView

			var_2.Hide(var_150_1)
		end
	end

	if arg_150_0.showingCommodity.id == arg_150_1 then
		arg_150_0:GetAllCommodities()
		arg_150_0:Refresh(true)
	end

	return
end

function var_0_1.OnFurnitureUpdate(arg_151_0, arg_151_1)
	if not arg_151_0.showingCommodity then
		return
	end

	local var_151_0 = arg_151_0.showingCommodity.id

	Goods = var_1_10003

	if var_1_10003.ExistFurniture(var_151_0) then
		Goods = var_3

		if var_3.Id2FurnitureId(var_151_0) == arg_151_1 then
			arg_151_0:GetAllCommodities()
			arg_151_0:Refresh(true)
		end
	end

	return
end

function var_0_1.CheckDownloadSkinList(arg_152_0, arg_152_1)
	local var_152_0 = {}

	ipairs = var_1_10003

	for iter_152_0, iter_152_1 in var_1_10003(arg_152_0.commodities) do
		PaintingGroupConst = var_1_10008

		var_1_10008.AddPaintingNameBySkinID(var_152_0, iter_152_1:getSkinId())
	end

	local var_152_1 = {
		isShowBox = true,
		paintingNameList = var_152_0,
		finishFunc = arg_152_1
	}

	PaintingGroupConst = var_4

	var_4.PaintingDownload(var_152_1)

	return
end

function var_0_1.willExit(arg_153_0)
	arg_153_0:ClearCards()

	ClearLScrollrect = var_1

	var_1(arg_153_0.scrollrect)

	pg = var_1

	local var_153_0 = var_1.DynamicBgMgr.GetInstance()

	var_1.ClearBg(var_153_0, arg_153_0:getUIName())

	if arg_153_0.live2dChar then
		local var_153_1 = arg_153_0.live2dChar

		var_1.Dispose(var_153_1)

		arg_153_0.live2dChar = nil
	end

	if arg_153_0.voucherMsgBox then
		local var_153_2 = arg_153_0.voucherMsgBox

		var_1.Destroy(var_153_2)

		arg_153_0.voucherMsgBox = nil
	end

	if arg_153_0.purchaseView then
		local var_153_3 = arg_153_0.purchaseView

		var_1.Destroy(var_153_3)

		arg_153_0.purchaseView = nil
	end

	pairs = var_1

	for iter_153_0, iter_153_1 in var_1(arg_153_0.downloads) do
		iter_153_1:Dispose()
	end

	arg_153_0.downloads = {}

	arg_153_0:ClearPainting()

	if arg_153_0.interactionPreview then
		local var_153_4 = arg_153_0.interactionPreview

		var_1.Dispose(var_153_4)

		arg_153_0.interactionPreview = nil
	end

	arg_153_0:disposeEvent()
	arg_153_0:ClearTimer()
	arg_153_0:ReturnChar()
	arg_153_0:UnOverlay()

	return
end

function var_0_1.onBackPressed(arg_154_0)
	pg = var_1_10001

	local var_154_0 = var_1_10001.m02
	local var_154_1 = var_1.sendNotification

	NewShopMainScene = var_1_10004

	var_154_1(var_154_0, var_1_10004.CLOSE_VIEW)

	return
end

return var_0_1
