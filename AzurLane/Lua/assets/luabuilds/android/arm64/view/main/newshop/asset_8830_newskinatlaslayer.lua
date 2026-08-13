class = var_0_10000

local var_0_0 = "NewSkinAtlasLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseUI"))
local var_0_2 = -1
local var_0_3 = 9999

function var_0_1.getUIName(arg_1_0)
	return "NewSkinAtlasUI"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.bg = var_1.Find(var_2_0, "bg")

	local var_2_1 = arg_2_0._tf

	arg_2_0.empty = var_1.Find(var_2_1, "empty")

	local var_2_2 = arg_2_0._tf

	arg_2_0.backBtn = var_1.Find(var_2_2, "adapt/top/closeBtn")

	local var_2_3 = arg_2_0._tf

	arg_2_0.homeBtn = var_1.Find(var_2_3, "adapt/top/homeBtn")

	local var_2_4 = arg_2_0._tf

	arg_2_0.resources = var_1.Find(var_2_4, "adapt/top/resources")

	local var_2_5 = arg_2_0._tf

	arg_2_0.filterBtn = var_1.Find(var_2_5, "adapt/top/filterBtn")

	local var_2_6 = arg_2_0._tf

	arg_2_0.search = var_1.Find(var_2_6, "adapt/top/search")

	local var_2_7 = arg_2_0._tf
	local var_2_8 = var_1.Find(var_2_7, "scroll")

	arg_2_0.scrollrect = var_1.GetComponent(var_2_8, "LScrollRect")

	local var_2_9 = arg_2_0._tf

	arg_2_0.filterUI = var_1.Find(var_2_9, "subPage/filterUI")

	local var_2_10 = arg_2_0.filterUI

	arg_2_0.filterContent = var_1.Find(var_2_10, "panelMask/panel/filterScroll/Viewport/Content")
	setActive = var_1

	var_1(arg_2_0.filterUI, false)

	setText = var_1

	local var_2_11 = arg_2_0.empty
	local var_2_12 = var_3.Find(var_2_11, "Text")

	i18n = var_4

	var_1(var_2_12, var_4("shop_new_unfound"))

	setText = var_1

	local var_2_13 = arg_2_0._tf
	local var_2_14 = var_3.Find(var_2_13, "adapt/top/title/Text")

	i18n = var_4

	var_1(var_2_14, var_4("shop_new_shop"))

	setText = var_1

	local var_2_15 = arg_2_0._tf
	local var_2_16 = var_3.Find(var_2_15, "adapt/top/have/Text")

	i18n = var_4

	var_1(var_2_16, var_4("shop_new_owned_skin"))

	setText = var_1

	local var_2_17 = arg_2_0.filterBtn
	local var_2_18 = var_3.Find(var_2_17, "Text")

	i18n = var_4

	var_1(var_2_18, var_4("shop_new_sort"))

	setText = var_1

	local var_2_19 = arg_2_0.search
	local var_2_20 = var_3.Find(var_2_19, "holder")

	i18n = var_4

	var_1(var_2_20, var_4("shop_new_search"))

	setText = var_1

	local var_2_21 = arg_2_0.filterUI
	local var_2_22 = var_3.Find(var_2_21, "panelMask/panel/title")

	i18n = var_4

	var_1(var_2_22, var_4("shop_new_sort"))

	setText = var_1

	local var_2_23 = arg_2_0.filterUI
	local var_2_24 = var_3.Find(var_2_23, "panelMask/panel/filterScroll/Viewport/Content/own/subTitleFrame/subTitle")

	i18n = var_4

	var_1(var_2_24, var_4("shop_new_review"))

	setText = var_1

	local var_2_25 = arg_2_0.filterUI
	local var_2_26 = var_3.Find(var_2_25, "panelMask/panel/filterScroll/Viewport/Content/own/options/0/Text")

	i18n = var_4

	var_1(var_2_26, var_4("shop_new_all"))

	setScrollText = var_1

	local var_2_27 = arg_2_0.filterUI
	local var_2_28 = var_3.Find(var_2_27, "panelMask/panel/filterScroll/Viewport/Content/own/options/1/mask/Text")

	i18n = var_4

	var_1(var_2_28, var_4("shop_new_unused"))

	setText = var_1

	local var_2_29 = arg_2_0.filterUI
	local var_2_30 = var_3.Find(var_2_29, "panelMask/panel/filterScroll/Viewport/Content/type/subTitleFrame/subTitle")

	i18n = var_4

	var_1(var_2_30, var_4("shop_new_type"))

	setText = var_1

	local var_2_31 = arg_2_0.filterUI
	local var_2_32 = var_3.Find(var_2_31, "panelMask/panel/filterScroll/Viewport/Content/type/options/0/Text")

	i18n = var_4

	var_1(var_2_32, var_4("shop_new_all"))

	setText = var_1

	local var_2_33 = arg_2_0.filterUI
	local var_2_34 = var_3.Find(var_2_33, "panelMask/panel/filterScroll/Viewport/Content/type/options/2/Text")

	i18n = var_4

	var_1(var_2_34, var_4("shop_new_static"))

	setText = var_1

	local var_2_35 = arg_2_0.filterUI
	local var_2_36 = var_3.Find(var_2_35, "panelMask/panel/filterScroll/Viewport/Content/type/options/3/Text")

	i18n = var_4

	var_1(var_2_36, var_4("shop_new_dynamic"))

	setText = var_1

	local var_2_37 = arg_2_0.filterUI
	local var_2_38 = var_3.Find(var_2_37, "panelMask/panel/filterScroll/Viewport/Content/type/options/4/Text")

	i18n = var_4

	var_1(var_2_38, var_4("shop_new_static_bg"))

	setText = var_1

	local var_2_39 = arg_2_0.filterUI
	local var_2_40 = var_3.Find(var_2_39, "panelMask/panel/filterScroll/Viewport/Content/type/options/5/Text")

	i18n = var_4

	var_1(var_2_40, var_4("shop_new_dynamic_bg"))

	setText = var_1

	local var_2_41 = arg_2_0.filterUI
	local var_2_42 = var_3.Find(var_2_41, "panelMask/panel/filterScroll/Viewport/Content/type/options/6/Text")

	i18n = var_4

	var_1(var_2_42, var_4("shop_new_bgm"))

	setText = var_1

	local var_2_43 = arg_2_0.filterUI
	local var_2_44 = var_3.Find(var_2_43, "panelMask/panel/filterScroll/Viewport/Content/shipHave/subTitleFrame/subTitle")

	i18n = var_4

	var_1(var_2_44, var_4("shop_new_index"))

	setText = var_1

	local var_2_45 = arg_2_0.filterUI
	local var_2_46 = var_3.Find(var_2_45, "panelMask/panel/filterScroll/Viewport/Content/shipHave/options/0/Text")

	i18n = var_4

	var_1(var_2_46, var_4("shop_new_all"))

	setText = var_1

	local var_2_47 = arg_2_0.filterUI
	local var_2_48 = var_3.Find(var_2_47, "panelMask/panel/filterScroll/Viewport/Content/shipHave/options/1/Text")

	i18n = var_4

	var_1(var_2_48, var_4("shop_new_ship_owned"))

	setText = var_1

	local var_2_49 = arg_2_0.filterUI
	local var_2_50 = var_3.Find(var_2_49, "panelMask/panel/filterScroll/Viewport/Content/shipHave/options/2/Text")

	i18n = var_4

	var_1(var_2_50, var_4("shop_new_ship_havent_owned"))

	setText = var_1

	local var_2_51 = arg_2_0.filterUI
	local var_2_52 = var_3.Find(var_2_51, "panelMask/panel/filterScroll/Viewport/Content/camp/subTitleFrame/subTitle")

	i18n = var_4

	var_1(var_2_52, var_4("shop_new_nation"))

	setText = var_1

	local var_2_53 = arg_2_0.filterUI
	local var_2_54 = var_3.Find(var_2_53, "panelMask/panel/filterScroll/Viewport/Content/rarity/subTitleFrame/subTitle")

	i18n = var_4

	var_1(var_2_54, var_4("shop_new_rarity"))

	setText = var_1

	local var_2_55 = arg_2_0.filterUI
	local var_2_56 = var_3.Find(var_2_55, "panelMask/panel/filterScroll/Viewport/Content/shipType/subTitleFrame/subTitle")

	i18n = var_4

	var_1(var_2_56, var_4("shop_new_category"))

	setText = var_1

	local var_2_57 = arg_2_0.filterUI
	local var_2_58 = var_3.Find(var_2_57, "panelMask/panel/filterScroll/Viewport/Content/themeType/subTitleFrame/subTitle")

	i18n = var_4

	var_1(var_2_58, var_4("shop_new_skin_theme"))

	setText = var_1

	local var_2_59 = arg_2_0.filterUI
	local var_2_60 = var_3.Find(var_2_59, "panelMask/panel/bottom/ok/Text")

	i18n = var_4

	var_1(var_2_60, var_4("shop_new_confirm"))

	pg = var_1

	local var_2_61 = var_1.UIMgr.GetInstance()
	local var_2_62 = var_1.OverlayPanel
	local var_2_63 = arg_2_0._tf
	local var_2_64 = {}
	local var_2_65 = {
		arg_2_0.bg
	}
	local var_2_66 = arg_2_0.filterUI

	var_2_65[2] = var_7.Find(var_2_66, "panelMask/panel")
	var_2_64.pbList = var_2_65

	var_2_62(var_2_61, var_2_63, var_2_64)

	return
end

function var_0_1.didEnter(arg_3_0)
	arg_3_0:InitData()
	arg_3_0:SetFilterPanel()
	arg_3_0:SetResource()
	arg_3_0:SetSkinScroll()
	arg_3_0:Refresh()

	onButton = var_1

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.backBtn

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.closeView(var_4_0)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1(var_3_0, var_3_1, var_3_2, var_1_10006)

	onButton = var_1

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.homeBtn

	local function var_3_5()
		local var_5_0 = arg_3_0

		var_0.emit(var_5_0, var_0_1.ON_HOME)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1(var_3_3, var_3_4, var_3_5, var_1_10006)

	onButton = var_1

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.filterBtn

	local function var_3_8()
		local var_6_0 = arg_3_0

		var_0.OpenFilterPanel(var_6_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_3_6, var_3_7, var_3_8, var_1_10006)

	onInputChanged = var_1

	var_1(arg_3_0, arg_3_0.search, function()
		local var_7_0 = arg_3_0

		var_0.Refresh(var_7_0)

		getInputText = var_0

		local var_7_1 = var_0(arg_3_0.search)

		setActive = var_2_10001

		local var_7_2 = arg_3_0.search

		var_2_10001(var_3.Find(var_7_2, "holder"), var_7_1 == "")

		return
	end)

	return
end

function var_0_1.InitData(arg_8_0)
	getProxy = var_1_10001
	ShipSkinProxy = var_1_10003

	local var_8_0 = var_1_10001(var_1_10003)

	arg_8_0.skins = var_1.GetOwnSkins(var_8_0)

	for iter_8_0 = #arg_8_0.skins, 1, -1 do
		local var_8_1 = arg_8_0.skins[iter_8_0]

		ShipSkin = var_1_10006

		if var_1_10006.GetChangeSkinIndex(var_8_1.id) and var_1_10006 ~= 1 then
			table = var_1_10007

			var_1_10007.remove(arg_8_0.skins, iter_8_0)
		end
	end

	arg_8_0:GetSkinClassify()

	arg_8_0.filterValues = {
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
			0
		}
	}
	Clone = var_1
	arg_8_0.filterValuesTemp = var_1(arg_8_0.filterValues)

	return
end

function var_0_1.SetResource(arg_9_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10003

	local var_9_0 = var_1_10001(var_1_10003)
	local var_9_1 = var_1.getRawData(var_9_0)

	setText = var_1_10002

	local var_9_2 = arg_9_0.resources

	var_1_10002(var_4.Find(var_9_2, "gem/Text"), var_9_1:getTotalGem())

	onButton = var_1_10002

	local var_9_3 = arg_9_0
	local var_9_4 = arg_9_0.resources
	local var_9_5 = var_5.Find(var_9_4, "gem")

	local function var_9_6()
		pg = var_2_10000

		local var_10_0 = var_2_10000.playerResUI

		var_0.ClickGem(var_10_0)

		return
	end

	SFX_PANEL = var_9_4

	var_1_10002(var_9_3, var_9_5, var_9_6, var_9_4)

	return
end

function var_0_1.SetSkinScroll(arg_11_0)
	arg_11_0.scrollrect.isNewLoadingMethod = true

	function arg_11_0.scrollrect.onInitItem(arg_12_0)
		local var_12_0 = arg_11_0

		var_1.OnInitItem(var_12_0, arg_12_0)

		return
	end

	function arg_11_0.scrollrect.onUpdateItem(arg_13_0, arg_13_1)
		local var_13_0 = arg_11_0

		var_2.OnUpdateItem(var_13_0, arg_13_0, arg_13_1)

		return
	end

	function arg_11_0.scrollrect.onReturnItem(arg_14_0, arg_14_1)
		local var_14_0 = arg_11_0

		var_2.OnReturnItem(var_14_0, arg_14_0, arg_14_1)

		return
	end

	return
end

function var_0_1.OnInitItem(arg_15_0, arg_15_1)
	ClearTweenItemAlphaAndWhite = var_1_10002

	var_1_10002(arg_15_1)

	return
end

function var_0_1.ReturnIndex(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0.scrollShowClassifyIds[arg_16_1]

	if arg_16_0.indexDic[arg_16_1] then
		for iter_16_0 = #arg_16_0.groupDic[var_16_0], 1, -1 do
			if arg_16_0.groupDic[var_16_0][iter_16_0] == arg_16_1 then
				table = var_7

				var_7.remove(arg_16_0.groupDic[var_16_0], iter_16_0)
			end
		end
	end

	arg_16_0.indexDic[arg_16_1] = false

	return
end

function var_0_1.RegisterIndex(arg_17_0, arg_17_1)
	arg_17_0.indexDic[arg_17_1] = true

	if arg_17_0.scrollShowClassifyIds[arg_17_1] then
		local var_17_0 = arg_17_0.groupDic
		local var_17_1

		if not arg_17_0.groupDic[var_2] then
			var_17_1 = {}
		end

		var_17_0[var_2] = var_17_1
		table = var_17_0

		var_17_0.insert(arg_17_0.groupDic[var_2], arg_17_1)
	end

	return
end

function var_0_1.ChangeClassifyName(arg_18_0, arg_18_1)
	ipairs = var_1_10002

	for iter_18_0, iter_18_1 in var_1_10002(arg_18_1) do
		local var_18_0

		pairs = var_1_10008

		for iter_18_2, iter_18_3 in var_1_10008(arg_18_0.goDic) do
			if iter_18_1 == iter_18_3 then
				var_18_0 = iter_18_2

				break
			end
		end

		if var_18_0 then
			var_1_10008 = arg_18_0.scrollShowClassifyIds[iter_18_1]

			local var_18_1 = arg_18_0.classifyNames

			table = var_10

			local var_18_2 = var_18_1[var_10.indexof(arg_18_0.classifyIds, var_1_10008)]
			local var_18_3

			if not arg_18_0.groupDic[var_1_10008] then
				var_18_3 = {}
			end

			local var_18_4 = var_18_3[1] == iter_18_1

			setActive = iter_18_2
			tf = var_13

			local var_18_5 = var_13(var_18_0)

			iter_18_2(var_13.Find(var_18_5, "titleBar"), var_18_4)

			if var_18_4 then
				setText = iter_18_2
				tf = var_13

				local var_18_6 = var_13(var_18_0)

				iter_18_2(var_13.Find(var_18_6, "titleBar/title"), var_18_2)

				local var_18_7 = arg_18_0._tf
				local var_18_8 = var_11.Find(var_18_7, "scroll/content")
				local var_18_9 = var_11.GetComponent

				typeof = var_14
				VerticalLayoutGroup = var_16

				local var_18_10 = var_18_9(var_18_8, var_14(var_16)).spacing
				local var_18_11 = arg_18_0.scrollClassifyNum[var_1_10008]

				tf = var_18_8

				local var_18_12 = var_18_8(var_18_0)
				local var_18_13 = var_13.GetComponent

				typeof = var_16
				LayoutElement = var_1_10018

				local var_18_14 = var_18_13(var_18_12, var_16(var_1_10018)).preferredHeight * var_18_11 + var_18_10 * (var_18_11 - 1)
				local var_18_15 = (arg_18_0.scrollShouldShowName[iter_18_1] - 1) * (var_13 + var_18_10)

				setSizeDelta = var_16
				tf = var_1_10018

				local var_18_16 = var_1_10018(var_18_0)

				var_1_10018 = var_1_10018.Find(var_18_16, "titleBar")

				local var_18_17 = {}

				tf = var_18_16

				local var_18_18 = var_18_16(var_18_0)

				var_18_17.x = var_20.Find(var_18_18, "titleBar").rect.width
				var_18_17.y = var_18_14

				var_16(var_1_10018, var_18_17)

				setAnchoredPosition = var_16
				tf = var_1_10018

				local var_18_19 = var_1_10018(var_18_0)

				var_16(var_1_10018.Find(var_18_19, "titleBar"), {
					y = var_18_15
				})
			end
		end
	end

	return
end

function var_0_1.GetDisplayIndex(arg_19_0, arg_19_1)
	local var_19_0

	if not arg_19_0.groupDic[arg_19_1] then
		var_19_0 = {}
	end

	return var_19_0[1]
end

function var_0_1.ClickTrigger(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = arg_20_0
	local var_20_1 = arg_20_0.emit

	NewSkinAtlasMediator = var_1_10006

	var_20_1(var_20_0, var_1_10006.OPEN_SHOW_LAYER, arg_20_2)

	return
end

function var_0_1.OnUpdateItem(arg_21_0, arg_21_1, arg_21_2)
	TweenItemAlphaAndWhite = var_1_10003

	var_1_10003(arg_21_2)

	arg_21_1 = arg_21_1 + 1

	local var_21_0 = arg_21_0.scrollDisplays[arg_21_1]

	if arg_21_0.goDic[arg_21_2] and arg_21_0.goDic[arg_21_2] ~= arg_21_1 then
		local var_21_1 = arg_21_0.scrollShowClassifyIds[arg_21_0.goDic[arg_21_2]]
		local var_21_2 = arg_21_0
		local var_21_3 = arg_21_0.GetDisplayIndex(var_21_2, var_21_1)

		arg_21_0:ReturnIndex(arg_21_0.goDic[arg_21_2])

		if var_21_3 ~= arg_21_0:GetDisplayIndex(var_21_1) then
			local var_21_4 = {}

			table = var_21_2

			var_21_2.insert(var_21_4, var_21_3)

			table = var_7

			var_7.insert(var_21_4, arg_21_0:GetDisplayIndex(var_21_1))
			arg_21_0:ChangeClassifyName(var_21_4)
		end
	end

	arg_21_0.goDic[arg_21_2] = arg_21_1

	local var_21_5 = arg_21_0.scrollShowClassifyIds[arg_21_1]
	local var_21_6 = arg_21_0:GetDisplayIndex(var_21_5)

	arg_21_0:RegisterIndex(arg_21_1)

	local var_21_7 = {}

	if var_21_6 ~= arg_21_0:GetDisplayIndex(var_21_5) then
		table = var_7

		var_7.insert(var_21_7, var_21_6)
	end

	table = var_7

	var_7.insert(var_21_7, arg_21_1)

	local var_21_8 = arg_21_0

	arg_21_0.ChangeClassifyName(var_21_8, var_21_7)

	if var_21_0 then
		UIItemList = var_7

		local var_21_9 = var_7.New

		tf = var_21_8

		local var_21_10 = var_21_8(arg_21_2)
		local var_21_11 = var_9.Find(var_21_10, "skins")

		tf = var_10

		local var_21_12 = var_10(arg_21_2)
		local var_21_13 = var_21_9(var_21_11, var_10.Find(var_21_12, "skins/SkinAtlasCard"))

		var_7.make(var_21_13, function(arg_22_0, arg_22_1, arg_22_2)
			UIItemList = var_2_10003

			if arg_22_0 == var_2_10003.EventUpdate then
				local var_22_0 = var_21_0[arg_22_1 + 1]

				SkinAtlasCard = var_4

				local var_22_1 = var_4.New(arg_22_2)

				table = var_2_10005

				var_2_10005.insert(arg_21_0.cards, var_22_1)
				var_22_1:Update(var_22_0, arg_22_1 + 1)

				onButton = var_5

				local var_22_2 = arg_21_0
				local var_22_3 = arg_22_2

				local function var_22_4()
					local var_23_0 = arg_21_0

					var_0.ClickTrigger(var_23_0, var_22_1, var_22_0)

					return
				end

				SFX_PANEL = var_2_10010

				var_5(var_22_2, var_22_3, var_22_4, var_2_10010)

				onButton = var_5

				local var_22_5 = arg_21_0
				local var_22_6 = var_22_1.changeSkinUI

				local function var_22_7()
					local var_24_0 = var_22_1

					var_0.changeSkinNext(var_24_0)

					return
				end

				SFX_PANEL = var_2_10010

				var_5(var_22_5, var_22_6, var_22_7, var_2_10010)
			end

			return
		end)
		var_7:align(#var_21_0)
	end

	return
end

function var_0_1.OnReturnItem(arg_25_0, arg_25_1, arg_25_2)
	ClearTweenItemAlphaAndWhite = var_1_10003

	var_1_10003(arg_25_2)

	if arg_25_0.exited then
		return
	end

	if arg_25_0.goDic[arg_25_2] then
		local var_25_0 = arg_25_0.scrollShowClassifyIds[arg_25_0.goDic[arg_25_2]]
		local var_25_1 = arg_25_0
		local var_25_2 = arg_25_0.GetDisplayIndex(var_25_1, var_25_0)

		arg_25_0:ReturnIndex(arg_25_0.goDic[arg_25_2])

		if var_25_2 ~= arg_25_0:GetDisplayIndex(var_25_0) then
			local var_25_3 = {}

			table = var_25_1

			var_25_1.insert(var_25_3, var_25_2)

			table = var_6

			var_6.insert(var_25_3, arg_25_0:GetDisplayIndex(var_25_0))
			arg_25_0:ChangeClassifyName(var_25_3)
		end
	end

	return
end

function var_0_1.Refresh(arg_26_0)
	arg_26_0.showClassifyIds = {}
	arg_26_0.displays = {}
	getInputText = var_1

	local var_26_0 = var_1(arg_26_0.search)

	Clone = var_1_10002

	local var_26_1 = var_1_10002(arg_26_0.classifyIds)

	Clone = var_3

	local var_26_2 = var_3(arg_26_0.classifyNames)

	table = var_4

	var_4.remove(var_26_1, 1)

	table = var_4

	var_4.remove(var_26_2, 1)

	pairs = var_4

	for iter_26_0, iter_26_1 in var_4(arg_26_0.skins) do
		if arg_26_0:filterOk(iter_26_1) and arg_26_0:IsSearchType(var_26_0, iter_26_1) then
			local var_26_3

			if arg_26_0:GetShopTypeIdBySkinId(iter_26_1.id) ~= 0 or not var_0_3 then
				var_26_3 = var_1_10009
			end

			local var_26_4

			if not arg_26_0.displays[var_26_3] then
				var_26_4 = arg_26_0.displays
				var_26_4[var_26_3] = {}
			end

			table = var_26_4

			var_26_4.insert(arg_26_0.displays[var_26_3], iter_26_1)
		end
	end

	ipairs = var_4

	for iter_26_2, iter_26_3 in var_4(var_26_1) do
		if arg_26_0.displays[iter_26_3] then
			table = var_1_10009

			var_1_10009.insert(arg_26_0.showClassifyIds, iter_26_3)
		end
	end

	setActive = var_4

	var_4(arg_26_0.empty, #arg_26_0.showClassifyIds == 0)

	arg_26_0.scrollShowClassifyIds = {}
	arg_26_0.scrollDisplays = {}
	arg_26_0.scrollShouldShowName = {}
	arg_26_0.scrollClassifyNum = {}
	ipairs = var_4

	for iter_26_4, iter_26_5 in var_4(arg_26_0.showClassifyIds) do
		Clone = var_1_10009
		var_1_10009 = var_1_10009(arg_26_0.displays[iter_26_5])

		local var_26_5 = false
		local var_26_6 = arg_26_0.scrollClassifyNum

		math = var_1_10012
		var_26_6[iter_26_5] = var_1_10012.ceil(#var_1_10009 / 8)

		local var_26_7 = 1

		while #var_1_10009 > 8 do
			table = var_1_10012

			var_1_10012.insert(arg_26_0.scrollShowClassifyIds, iter_26_5)

			table = var_1_10012

			var_1_10012.insert(arg_26_0.scrollShouldShowName, var_26_7)

			var_26_7 = var_26_7 + 1
			var_26_5 = var_26_5 or true
			var_1_10012 = {}

			for iter_26_6 = 1, 8 do
				table = var_1_10017
				var_1_10017 = var_1_10017.insert

				local var_26_8 = var_1_10012

				table = var_1_10020

				var_1_10017(var_26_8, var_1_10020.remove(var_1_10009, 1))
			end

			table = var_13

			var_13.insert(arg_26_0.scrollDisplays, var_1_10012)
		end

		if #var_1_10009 > 0 then
			table = var_1_10012

			var_1_10012.insert(arg_26_0.scrollShowClassifyIds, iter_26_5)

			table = var_1_10012

			var_1_10012.insert(arg_26_0.scrollShouldShowName, var_26_7)

			local var_26_9

			var_26_9 = var_26_5 or true
			table = var_1_10012

			var_1_10012.insert(arg_26_0.scrollDisplays, var_1_10009)
		end
	end

	arg_26_0.indexDic = {}
	arg_26_0.groupDic = {}
	arg_26_0.goDic = {}

	if arg_26_0.cards then
		ipairs = var_4

		for iter_26_7, iter_26_8 in var_4(arg_26_0.cards) do
			iter_26_8:Dispose()
		end
	end

	arg_26_0.cards = {}

	local var_26_10 = arg_26_0.scrollrect

	var_4.SetTotalCount(var_26_10, #arg_26_0.scrollShowClassifyIds, 0)

	return
end

function var_0_1.IsSearchType(arg_27_0, arg_27_1, arg_27_2)
	if not arg_27_1 or arg_27_1 == "" then
		return true
	end

	local var_27_0 = arg_27_2.id

	ShipSkin = var_1_10004

	local var_27_1 = var_1_10004.New({
		id = var_27_0
	})

	return var_4.IsMatchKey(var_27_1, arg_27_1)
end

function var_0_1.SetFilterPanel(arg_28_0)
	local var_28_0 = arg_28_0.filterContent
	local var_28_1 = var_1.Find(var_28_0, "own/options")
	local var_28_2 = arg_28_0.filterContent
	local var_28_3 = var_2.Find(var_28_2, "type/options")
	local var_28_4 = arg_28_0.filterContent
	local var_28_5 = var_3.Find(var_28_4, "shipHave/options")
	local var_28_6 = arg_28_0.filterContent
	local var_28_7 = var_4.Find(var_28_6, "camp/options")
	local var_28_8 = arg_28_0.filterContent
	local var_28_9 = var_5.Find(var_28_8, "rarity/options")
	local var_28_10 = arg_28_0.filterContent
	local var_28_11 = var_6.Find(var_28_10, "shipType/options")
	local var_28_12 = arg_28_0.filterContent
	local var_28_13 = var_7.Find(var_28_12, "themeType/options")
	local var_28_14 = arg_28_0
	local var_28_15 = arg_28_0.SetOptionList
	local var_28_16 = var_28_7

	ShipIndexConst = var_1_10012

	var_28_15(var_28_14, var_28_16, var_1_10012.CampNames, true)

	local var_28_17 = arg_28_0
	local var_28_18 = arg_28_0.SetOptionList
	local var_28_19 = var_28_9

	ShipIndexConst = var_12

	var_28_18(var_28_17, var_28_19, var_12.RarityNames, true)

	local var_28_20 = arg_28_0
	local var_28_21 = arg_28_0.SetOptionList
	local var_28_22 = var_28_11

	ShipIndexConst = var_12

	var_28_21(var_28_20, var_28_22, var_12.TypeNames, true)
	arg_28_0:SetOptionList(var_28_13, arg_28_0.classifyNames)
	arg_28_0:SetSingleOptions(var_28_1, "ownType")
	arg_28_0:SetMultiOptions(var_28_3, "typeType")
	arg_28_0:SetSingleOptions(var_28_5, "shipHaveType")
	arg_28_0:SetMultiOptions(var_28_7, "campType")
	arg_28_0:SetMultiOptions(var_28_9, "rarityType")
	arg_28_0:SetMultiOptions(var_28_11, "shipType")
	arg_28_0:SetMultiOptions(var_28_13, "themeType")

	onButton = var_8

	local var_28_23 = arg_28_0
	local var_28_24 = arg_28_0.filterUI
	local var_28_25 = var_11.Find(var_28_24, "bg")

	local function var_28_26()
		pairs = var_2_10000

		for iter_29_0, iter_29_1 in var_2_10000(arg_28_0.filterValues) do
			local var_29_0 = arg_28_0.filterValuesTemp

			Clone = var_2_10006
			var_29_0[iter_29_0] = var_2_10006(arg_28_0.filterValues[iter_29_0])
		end

		setActive = var_0

		var_0(arg_28_0.filterUI, false)

		return
	end

	SFX_PANEL = var_28_24

	var_8(var_28_23, var_28_25, var_28_26, var_28_24)

	onButton = var_8

	local var_28_27 = arg_28_0
	local var_28_28 = arg_28_0.filterUI
	local var_28_29 = var_11.Find(var_28_28, "panelMask/panel/closeBtn")

	local function var_28_30()
		pairs = var_2_10000

		for iter_30_0, iter_30_1 in var_2_10000(arg_28_0.filterValues) do
			local var_30_0 = arg_28_0.filterValuesTemp

			Clone = var_2_10006
			var_30_0[iter_30_0] = var_2_10006(arg_28_0.filterValues[iter_30_0])
		end

		setActive = var_0

		var_0(arg_28_0.filterUI, false)

		return
	end

	SFX_PANEL = var_28_28

	var_8(var_28_27, var_28_29, var_28_30, var_28_28)

	onButton = var_8

	local var_28_31 = arg_28_0
	local var_28_32 = arg_28_0.filterUI
	local var_28_33 = var_11.Find(var_28_32, "panelMask/panel/bottom/ok")

	local function var_28_34()
		pairs = var_2_10000

		for iter_31_0, iter_31_1 in var_2_10000(arg_28_0.filterValues) do
			local var_31_0 = arg_28_0.filterValues

			Clone = var_2_10006
			var_31_0[iter_31_0] = var_2_10006(arg_28_0.filterValuesTemp[iter_31_0])
		end

		setActive = var_0

		var_0(arg_28_0.filterUI, false)

		local var_31_1 = arg_28_0

		var_0.Refresh(var_31_1)

		return
	end

	SFX_PANEL = var_28_32

	var_8(var_28_31, var_28_33, var_28_34, var_28_32)

	return
end

function var_0_1.OpenFilterPanel(arg_32_0)
	setActive = var_1_10001

	var_1_10001(arg_32_0.filterUI, true)

	local var_32_0 = arg_32_0.filterContent
	local var_32_1 = var_1.Find(var_32_0, "own/options")
	local var_32_2 = arg_32_0.filterContent
	local var_32_3 = var_2.Find(var_32_2, "type/options")
	local var_32_4 = arg_32_0.filterContent
	local var_32_5 = var_3.Find(var_32_4, "shipHave/options")
	local var_32_6 = arg_32_0.filterContent
	local var_32_7 = var_4.Find(var_32_6, "camp/options")
	local var_32_8 = arg_32_0.filterContent
	local var_32_9 = var_5.Find(var_32_8, "rarity/options")
	local var_32_10 = arg_32_0.filterContent
	local var_32_11 = var_6.Find(var_32_10, "shipType/options")
	local var_32_12 = arg_32_0.filterContent
	local var_32_13 = var_7.Find(var_32_12, "themeType/options")

	arg_32_0:SetSingleOptions(var_32_1, "ownType", true)
	arg_32_0:SetMultiOptions(var_32_3, "typeType", true)
	arg_32_0:SetSingleOptions(var_32_5, "shipHaveType", true)
	arg_32_0:SetMultiOptions(var_32_7, "campType", true)
	arg_32_0:SetMultiOptions(var_32_9, "rarityType", true)
	arg_32_0:SetMultiOptions(var_32_11, "shipType", true)
	arg_32_0:SetMultiOptions(var_32_13, "themeType", true)

	return
end

function var_0_1.SetOptionList(arg_33_0, arg_33_1, arg_33_2, arg_33_3)
	UIItemList = var_1_10004

	local var_33_0 = var_1_10004.New(arg_33_1, arg_33_1:GetChild(0))

	var_4.make(var_33_0, function(arg_34_0, arg_34_1, arg_34_2)
		UIItemList = var_2_10003

		if arg_34_0 == var_2_10003.EventUpdate then
			local var_34_0 = arg_33_2[arg_34_1 + 1]

			if arg_33_3 then
				i18n = var_4
				var_34_0 = var_4(var_34_0)
			end

			arg_34_2.name = arg_34_1
			setScrollText = var_4

			var_4(arg_34_2:Find("mask/Text"), var_34_0)
		end

		return
	end)
	var_4:align(#arg_33_2)

	return
end

function var_0_1.SetSingleOptions(arg_35_0, arg_35_1, arg_35_2, arg_35_3)
	for iter_35_0 = 0, arg_35_1.childCount - 1 do
		local var_35_0 = arg_35_1:GetChild(iter_35_0)
		local var_35_1 = arg_35_0
		local var_35_2 = arg_35_0.SetOptionSelect
		local var_35_3 = arg_35_1

		var_35_2(var_35_1, arg_35_1.GetChild(var_35_3, iter_35_0), iter_35_0 == arg_35_0.filterValuesTemp[arg_35_2])

		if not arg_35_3 then
			onButton = var_35_2

			local var_35_4 = arg_35_0
			local var_35_5 = var_35_0

			local function var_35_6()
				arg_35_0.filterValuesTemp[arg_35_2] = iter_35_0

				for iter_36_0 = 0, arg_35_1.childCount - 1 do
					local var_36_0 = arg_35_0
					local var_36_1 = var_4.SetOptionSelect
					local var_36_2 = arg_35_1

					var_36_1(var_36_0, var_7.GetChild(var_36_2, iter_36_0), iter_36_0 == iter_35_0)
				end

				return
			end

			SFX_PANEL = var_35_3

			var_35_2(var_35_4, var_35_5, var_35_6, var_35_3)
		end
	end

	return
end

function var_0_1.SetMultiOptions(arg_37_0, arg_37_1, arg_37_2, arg_37_3)
	for iter_37_0 = 0, arg_37_1.childCount - 1 do
		local var_37_0 = arg_37_1:GetChild(iter_37_0)
		local var_37_1 = arg_37_0
		local var_37_2 = arg_37_0.SetOptionSelect
		local var_37_3 = arg_37_1
		local var_37_4 = arg_37_1.GetChild(var_37_3, iter_37_0)

		table = var_1_10013

		var_37_2(var_37_1, var_37_4, var_1_10013.contains(arg_37_0.filterValuesTemp[arg_37_2], iter_37_0))

		if not arg_37_3 then
			onButton = var_37_2

			local var_37_5 = arg_37_0
			local var_37_6 = var_37_0

			function var_1_10013()
				local var_38_0

				if iter_37_0 == 0 then
					var_38_0 = arg_37_0.filterValuesTemp
					var_38_0[arg_37_2] = {
						0
					}

					for iter_38_0 = 0, arg_37_1.childCount - 1 do
						local var_38_1 = arg_37_0
						local var_38_2 = var_4.SetOptionSelect

						var_2_10009 = arg_37_1

						var_38_2(var_38_1, var_7.GetChild(var_2_10009, iter_38_0), iter_38_0 == 0)
					end
				else
					table = var_38_0

					var_38_0.removebyvalue(arg_37_0.filterValuesTemp[arg_37_2], 0)

					table = var_0

					if var_0.contains(arg_37_0.filterValuesTemp[arg_37_2], iter_37_0) then
						table = var_0

						var_0.removebyvalue(arg_37_0.filterValuesTemp[arg_37_2], iter_37_0)
					else
						table = var_0

						var_0.insert(arg_37_0.filterValuesTemp[arg_37_2], iter_37_0)
					end

					local var_38_3 = true

					for iter_38_1 = 1, arg_37_1.childCount - 1 do
						table = var_2_10005

						if not var_2_10005.contains(arg_37_0.filterValuesTemp[arg_37_2], iter_38_1) then
							var_38_3 = false

							break
						end
					end

					if #arg_37_0.filterValuesTemp[arg_37_2] == 0 then
						var_38_3 = true
					end

					if var_38_3 then
						arg_37_0.filterValuesTemp[arg_37_2] = {
							0
						}
					end

					for iter_38_2 = 0, arg_37_1.childCount - 1 do
						local var_38_4 = arg_37_0
						local var_38_5 = var_5.SetOptionSelect
						local var_38_6 = arg_37_1
						local var_38_7 = var_8.GetChild(var_38_6, iter_38_2)

						table = var_2_10009

						var_38_5(var_38_4, var_38_7, var_2_10009.contains(arg_37_0.filterValuesTemp[arg_37_2], iter_38_2))
					end
				end

				return
			end

			SFX_PANEL = var_37_3

			var_37_2(var_37_5, var_37_6, var_1_10013, var_37_3)
		end
	end

	return
end

function var_0_1.SetOptionSelect(arg_39_0, arg_39_1, arg_39_2)
	setActive = var_1_10003

	var_1_10003(arg_39_1:Find("selectedFrame"), arg_39_2)

	local var_39_0

	IsNil = var_1_10004

	local var_39_2

	if var_1_10004(arg_39_1:Find("Text")) then
		local var_39_1 = arg_39_1:Find("mask/Text")

		var_39_2 = var_39_2.GetComponent
		typeof = var_7
		Text = var_9
		var_39_0 = var_39_2(var_39_1, var_7(var_9))
	else
		local var_39_3 = arg_39_1:Find("Text")

		var_39_2 = var_39_2.GetComponent
		typeof = var_7
		Text = var_9
		var_39_0 = var_39_2(var_39_3, var_7(var_9))
	end

	if arg_39_2 then
		Color = var_39_2
		var_39_0.color = var_39_2.New(1, 1, 1, 1)
	else
		Color = var_39_2
		var_39_0.color = var_39_2.New(0, 0, 0, 0.5)
	end

	return
end

function var_0_1.GetSkinClassify(arg_40_0)
	Clone = var_1_10001
	pg = var_1_10003
	arg_40_0.classifyIds = var_1_10001(var_1_10003.skin_page_template.all)
	table = var_1

	var_1.insert(arg_40_0.classifyIds, 1, var_0_2)

	arg_40_0.classifyNames = {}
	ipairs = var_1

	for iter_40_0, iter_40_1 in var_1(arg_40_0.classifyIds) do
		local var_40_0

		if iter_40_1 == var_0_2 then
			table = var_40_0
			var_40_0 = var_40_0.insert

			local var_40_1 = arg_40_0.classifyNames

			i18n = var_1_10009

			var_40_0(var_40_1, var_1_10009("index_all"))
		else
			table = var_40_0

			local var_40_2 = var_40_0.insert
			local var_40_3 = arg_40_0.classifyNames

			pg = var_1_10009

			var_40_2(var_40_3, var_1_10009.skin_page_template[iter_40_1].name)
		end
	end

	return
end

function var_0_1.filterOk(arg_41_0, arg_41_1)
	local var_41_0 = arg_41_0.filterValues.ownType
	local var_41_1 = arg_41_0.filterValues.typeType
	local var_41_2 = arg_41_0.filterValues.shipHaveType
	local var_41_3 = arg_41_0.filterValues.campType
	local var_41_4 = arg_41_0.filterValues.rarityType
	local var_41_5 = arg_41_0.filterValues.shipType
	local var_41_6 = arg_41_0.filterValues.themeType
	local var_41_7 = arg_41_1.id

	if not arg_41_1:GetDefaultShipConfig() then
		return false
	end

	local var_41_8 = arg_41_0
	local var_41_9 = arg_41_0.ToVShip(var_41_8, var_10)

	if var_41_0 ~= 0 then
		local var_41_10 = false

		getProxy = var_41_8
		ShipSkinProxy = var_1_10015

		local var_41_11 = var_41_8(var_1_10015)

		var_41_8 = var_41_8.hasSkin(var_41_11, var_41_7)

		local var_41_12 = arg_41_1:NoUse()

		if var_41_0 == 1 and var_41_8 and var_41_12 then
			var_41_10 = true
		end

		if not var_41_10 then
			return false
		end
	end

	if var_41_1[1] ~= 0 then
		local var_41_13 = false

		ipairs = var_41_8

		for iter_41_0, iter_41_1 in var_41_8(var_41_1) do
			if iter_41_1 == 1 and (arg_41_1:IsLive2d() or arg_41_1:IsLive2dPlus()) then
				var_41_13 = true
			end

			if iter_41_1 == 2 and not arg_41_1:IsLive2d() and not arg_41_1:IsLive2dPlus() and not arg_41_1:IsSpine() and not arg_41_1:IsSpinePlus() then
				var_41_13 = true
			end

			if iter_41_1 == 3 and (arg_41_1:IsSpine() or arg_41_1:IsSpinePlus()) then
				var_41_13 = true
			end

			if iter_41_1 == 4 and arg_41_1:IsBG() then
				var_41_13 = true
			end

			if iter_41_1 == 5 and arg_41_1:IsDbg() then
				var_41_13 = true
			end

			if iter_41_1 == 6 and arg_41_1:isBgm() then
				var_41_13 = true
			end

			if var_41_13 then
				break
			end
		end

		if not var_41_13 then
			return false
		end
	end

	if var_41_2 ~= 0 then
		local var_41_14 = false

		var_41_8 = arg_41_1:CantUse()

		if var_41_2 == 1 and not var_41_8 then
			var_41_14 = true
		end

		if var_41_2 == 2 and var_41_8 then
			var_41_14 = true
		end

		if not var_41_14 then
			return false
		end
	end

	if var_41_3[1] ~= 0 then
		local var_41_15 = false

		ipairs = var_41_8

		for iter_41_2, iter_41_3 in var_41_8(var_41_3) do
			ShipIndexCfg = var_1_10018
			var_1_10018 = var_1_10018.camp
			ipairs = var_1_10019

			for iter_41_4, iter_41_5 in var_1_10019(var_1_10018[iter_41_3 + 1].types) do
				Nation = var_1_10024

				if iter_41_5 == var_1_10024.LINK then
					var_1_10024 = var_41_9:getNation()
					Nation = var_1_10025

					if var_1_10025.LINK <= var_1_10024 then
						var_41_15 = true
					end
				elseif iter_41_5 == var_41_9:getNation() then
					var_41_15 = true
				end
			end

			if var_41_15 then
				break
			end
		end

		if not var_41_15 then
			return false
		end
	end

	if var_41_4[1] ~= 0 then
		local var_41_16 = false

		ipairs = var_41_8

		for iter_41_6, iter_41_7 in var_41_8(var_41_4) do
			ShipIndexCfg = var_1_10018
			var_1_10018 = var_1_10018.rarity
			table = var_1_10019

			if var_1_10019.contains(var_1_10018[iter_41_7 + 1].types, var_41_9:getRarity()) then
				var_41_16 = true
			end

			if var_41_16 then
				break
			end
		end

		if not var_41_16 then
			return false
		end
	end

	if var_41_5[1] ~= 0 then
		local var_41_17 = false

		ipairs = var_41_8

		for iter_41_8, iter_41_9 in var_41_8(var_41_5) do
			ShipIndexCfg = var_1_10018

			local var_41_18 = var_1_10018.type[iter_41_9 + 1].types
			local var_41_19

			if iter_41_9 + 1 < 4 then
				var_41_19 = var_1_10018[iter_41_9].shipTypes
				table = var_21

				if var_21.contains(var_41_18, var_41_9:getShipType()) then
					var_41_17 = true
				end

				table = var_21

				if var_21.contains(var_41_18, var_41_9:getTeamType()) then
					var_41_17 = true
				end
			else
				table = var_41_19

				if var_41_19.contains(var_41_18, var_41_9:getShipType()) then
					var_41_17 = true
				end
			end

			if var_41_17 then
				break
			end
		end

		if not var_41_17 then
			return false
		end
	end

	if var_41_6[1] ~= 0 then
		local var_41_20 = false

		ipairs = var_41_8

		for iter_41_10, iter_41_11 in var_41_8(var_41_6) do
			if arg_41_0.classifyIds[iter_41_11 + 1] == var_0_2 then
				var_41_20 = true
			else
				local var_41_21

				if arg_41_0:GetShopTypeIdBySkinId(var_41_7) ~= 0 or not var_0_3 then
					var_41_21 = var_19
				end

				var_41_20 = var_41_21 == var_18
			end

			if var_41_20 then
				break
			end
		end

		if not var_41_20 then
			return false
		end
	end

	return true
end

function var_0_1.ToVShip(arg_42_0, arg_42_1)
	if not arg_42_0.vship then
		arg_42_0.vship = {}

		function arg_42_0.vship.getNation()
			return arg_42_0.vship.config.nationality
		end

		function arg_42_0.vship.getShipType()
			return arg_42_0.vship.config.type
		end

		function arg_42_0.vship.getTeamType()
			ShipType = var_2_10000

			return var_2_10000.GetTeamFromShipType(arg_42_0.vship.config.type)
		end

		function arg_42_0.vship.getRarity()
			return arg_42_0.vship.config.rarity
		end
	end

	arg_42_0.vship.config = arg_42_1

	return arg_42_0.vship
end

function var_0_1.GetShopTypeIdBySkinId(arg_47_0, arg_47_1)
	pg = var_1_10002

	local var_47_0 = var_1_10002.ship_skin_template.get_id_list_by_shop_type_id

	if not arg_47_0.shopTypeIdList then
		arg_47_0.shopTypeIdList = {}
	end

	if arg_47_0.shopTypeIdList[arg_47_1] then
		return arg_47_0.shopTypeIdList[arg_47_1]
	end

	pairs = var_3

	for iter_47_0, iter_47_1 in var_3(var_47_0) do
		ipairs = var_1_10008

		for iter_47_2, iter_47_3 in var_1_10008(iter_47_1) do
			arg_47_0.shopTypeIdList[iter_47_3] = iter_47_0

			if iter_47_3 == arg_47_1 then
				return iter_47_0
			end
		end
	end

	return
end

function var_0_1.willExit(arg_48_0)
	ipairs = var_1_10001

	for iter_48_0, iter_48_1 in var_1_10001(arg_48_0.cards) do
		iter_48_1:Dispose()
	end

	arg_48_0.cards = nil
	pg = var_1

	local var_48_0 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_48_0, arg_48_0._tf)

	return
end

function var_0_1.onBackPressed(arg_49_0)
	var_0_1.super.onBackPressed(arg_49_0)

	return
end

return var_0_1
