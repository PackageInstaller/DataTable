class = var_0_10000

local var_0_0 = "BackYardDecrationLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseUI"))

var_0_1.INNER_SELECTED_FURNITRUE = "BackYardDecrationLayer:INNER_SELECTED_FURNITRUE"

local var_0_2 = 1
local var_0_3 = 2
local var_0_4 = 3
local var_0_5 = 4
local var_0_6 = 5
local var_0_7 = 6
local var_0_8 = 7
local var_0_9 = 8
local var_0_10 = 9

function var_0_1.getUIName(arg_1_0)
	return "BackYardDecorationUI"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_1.GetComponent

	typeof = var_1_10004
	Animation = var_1_10006
	arg_2_0.animation = var_2_1(var_2_0, var_1_10004(var_1_10006))

	local var_2_2 = arg_2_0._tf
	local var_2_3 = var_1.GetComponent

	typeof = var_4
	DftAniEvent = var_1_10006
	arg_2_0.dftAniEvent = var_2_3(var_2_2, var_4(var_1_10006))

	local var_2_4 = arg_2_0._tf

	arg_2_0.adpter = var_1.Find(var_2_4, "adpter")

	local var_2_5 = arg_2_0._tf

	arg_2_0.pageConainer = var_1.Find(var_2_5, "adpter/bottom/animroot/root/pages")

	local var_2_6 = arg_2_0._tf
	local var_2_7 = var_1.Find(var_2_6, "adpter/bottom")
	local var_2_8 = var_1.GetComponent

	typeof = var_4
	Animation = var_1_10006
	arg_2_0.bAnimtion = var_2_8(var_2_7, var_4(var_1_10006))

	local var_2_9 = arg_2_0._tf

	arg_2_0.shopBtn = var_1.Find(var_2_9, "adpter/shop_btn")

	local var_2_10 = arg_2_0._tf

	arg_2_0.saveBtn = var_1.Find(var_2_10, "adpter/bottom/animroot/save_btn")

	local var_2_11 = arg_2_0._tf

	arg_2_0.clearBtn = var_1.Find(var_2_11, "adpter/bottom/animroot/clear_btn")

	local var_2_12 = arg_2_0._tf

	arg_2_0.bottomTr = var_1.Find(var_2_12, "adpter/bottom")

	local var_2_13 = arg_2_0._tf

	arg_2_0.orderBtn = var_1.Find(var_2_13, "adpter/bottom/animroot/root/fliter_container/order")

	local var_2_14 = arg_2_0.orderBtn
	local var_2_15 = var_1.Find(var_2_14, "Text")
	local var_2_16 = var_1.GetComponent

	typeof = var_4
	Image = var_1_10006
	arg_2_0.orderBtnTxt = var_2_16(var_2_15, var_4(var_1_10006))

	local var_2_17 = arg_2_0.orderBtn

	arg_2_0.orderBtnIcon = var_1.Find(var_2_17, "icon")

	local var_2_18 = arg_2_0._tf

	arg_2_0.filterBtn = var_1.Find(var_2_18, "adpter/bottom/animroot/root/fliter_container/filter")

	local var_2_19 = arg_2_0.filterBtn
	local var_2_20 = var_1.Find(var_2_19, "Text")
	local var_2_21 = var_1.GetComponent

	typeof = var_4
	Image = var_1_10006
	arg_2_0.filterBtnTxt = var_2_21(var_2_20, var_4(var_1_10006))

	local var_2_22 = arg_2_0.filterBtnTxt

	GetSpriteFromAtlas = var_1_10002
	var_2_22.sprite = var_1_10002("ui/NewBackYardDecorateUI_atlas", "text_default")

	local var_2_23 = arg_2_0.filterBtnTxt

	var_1.SetNativeSize(var_2_23)

	local var_2_24 = arg_2_0._tf

	arg_2_0.searchInput = var_1.Find(var_2_24, "adpter/bottom/animroot/root/fliter_container/search/search")
	setText = var_1

	local var_2_25 = arg_2_0.searchInput
	local var_2_26 = var_3.Find(var_2_25, "holder")

	i18n = var_4

	var_1(var_2_26, var_4("courtyard_label_search_holder"))

	local var_2_27 = arg_2_0._tf

	arg_2_0.searchClear = var_1.Find(var_2_27, "adpter/bottom/animroot/root/fliter_container/search/search/clear")

	local var_2_28 = arg_2_0._tf

	arg_2_0.hideBtn = var_1.Find(var_2_28, "adpter/bottom/animroot/root/fliter_container/hide")

	local var_2_29 = arg_2_0._tf

	arg_2_0.showBtn = var_1.Find(var_2_29, "adpter/bottom/animroot/show_btn")

	local var_2_30 = arg_2_0._tf

	arg_2_0.showPutListBtn = var_1.Find(var_2_30, "adpter/putlist_btn")
	BackYardDecorationThemePage = var_1
	arg_2_0.themePage = var_1.New(arg_2_0.pageConainer, arg_2_0.event, arg_2_0.contextData)
	BackYardDecorationFurniturePage = var_1
	arg_2_0.furniturePage = var_1.New(arg_2_0.pageConainer, arg_2_0.event, arg_2_0.contextData)
	BackYardDecorationPutlistPage = var_1
	arg_2_0.putListPage = var_1.New(arg_2_0.adpter, arg_2_0.event, arg_2_0.contextData)

	function arg_2_0.putListPage.OnShow(arg_3_0)
		setActive = var_2_10001

		var_2_10001(arg_2_0.showPutListBtn, not arg_3_0)

		return
	end

	function arg_2_0.putListPage.OnShowImmediately()
		setActive = var_2_10000

		var_2_10000(arg_2_0.showPutListBtn, false)

		return
	end

	local var_2_31 = arg_2_0.contextData

	BackYardDecorationDecBox = var_2
	var_2_31.furnitureDescMsgBox = var_2.New(arg_2_0._tf, arg_2_0.event, arg_2_0.contextData)

	local var_2_32 = arg_2_0.contextData

	BackYardDecorationFilterPanel = var_2
	var_2_32.filterPanel = var_2.New(arg_2_0._tf, arg_2_0.event, arg_2_0.contextData)
	arg_2_0.pages = {
		[var_0_2] = arg_2_0.themePage,
		[var_0_3] = arg_2_0.furniturePage,
		[var_0_4] = arg_2_0.furniturePage,
		[var_0_5] = arg_2_0.furniturePage,
		[var_0_6] = arg_2_0.furniturePage,
		[var_0_7] = arg_2_0.furniturePage,
		[var_0_8] = arg_2_0.furniturePage,
		[var_0_9] = arg_2_0.furniturePage,
		[var_0_10] = arg_2_0.furniturePage
	}

	local var_2_33 = arg_2_0._tf

	arg_2_0.themeTag = var_1.Find(var_2_33, "adpter/bottom/animroot/root/theme")
	setText = var_1

	local var_2_34 = arg_2_0.shopBtn
	local var_2_35 = var_3.Find(var_2_34, "Text")

	i18n = var_4

	var_1(var_2_35, var_4("courtyard_label_shop_1"))

	setText = var_1

	local var_2_36 = arg_2_0.showPutListBtn
	local var_2_37 = var_3.Find(var_2_36, "Text")

	i18n = var_4

	var_1(var_2_37, var_4("courtyard_label_placed_furniture"))

	setText = var_1

	local var_2_38 = arg_2_0.saveBtn
	local var_2_39 = var_3.Find(var_2_38, "Text")

	i18n = var_4

	var_1(var_2_39, var_4("courtyard_label_save"))

	setText = var_1

	local var_2_40 = arg_2_0.clearBtn
	local var_2_41 = var_3.Find(var_2_40, "Text")

	i18n = var_4

	var_1(var_2_41, var_4("courtyard_label_clear"))

	return
end

function var_0_1.didEnter(arg_5_0)
	BackYardDecorationFilterPanel = var_1_10001
	arg_5_0.orderMode = var_1_10001.ORDER_MODE_DASC

	local function var_5_0(arg_6_0)
		local var_6_0 = ""

		BackYardDecorationFilterPanel = var_2_10002

		local var_6_1

		if arg_6_0 == var_2_10002.ORDER_MODE_ASC then
			var_6_0 = "text_asc"
			var_6_1 = arg_5_0.orderBtnIcon
			Vector3 = var_2_10003
			var_6_1.localEulerAngles = var_2_10003(0, 0, 0)
		else
			BackYardDecorationFilterPanel = var_6_1

			if arg_6_0 == var_6_1.ORDER_MODE_DASC then
				var_6_0 = "text_dasc"

				local var_6_2 = arg_5_0.orderBtnIcon

				Vector3 = var_2_10003
				var_6_2.localEulerAngles = var_2_10003(0, 0, 180)
			end
		end

		local var_6_3 = arg_5_0.orderBtnTxt

		GetSpriteFromAtlas = var_2_10003
		var_6_3.sprite = var_2_10003("ui/NewBackYardDecorateUI_atlas", var_6_0)

		local var_6_4 = arg_5_0.orderBtnTxt

		var_2.SetNativeSize(var_6_4)

		return
	end

	onToggle = var_1_10002

	local var_5_1 = arg_5_0
	local var_5_2 = arg_5_0.orderBtn

	local function var_5_3(arg_7_0)
		local var_7_0 = arg_5_0

		if arg_7_0 then
			BackYardDecorationFilterPanel = var_2_10002

			if not var_2_10002.ORDER_MODE_ASC then
				BackYardDecorationFilterPanel = var_2_10002
				var_2_10002 = var_2_10002.ORDER_MODE_DASC
			end

			var_7_0.orderMode = var_2_10002

			if arg_5_0.pageType then
				local var_7_1 = arg_5_0.pages[arg_5_0.pageType]

				var_1.ExecuteAction(var_7_1, "OrderModeUpdated", arg_5_0.orderMode)
			end

			var_5_0(arg_5_0.orderMode)

			return
		end
	end

	SFX_PANEL = var_1_10007

	var_1_10002(var_5_1, var_5_2, var_5_3, var_1_10007)
	var_5_0(arg_5_0.orderMode)

	onButton = var_2

	local var_5_4 = arg_5_0
	local var_5_5 = arg_5_0.shopBtn

	local function var_5_6()
		local var_8_0 = arg_5_0
		local var_8_1 = var_0.emit

		BackYardDecorationMediator = var_2_10003

		var_8_1(var_8_0, var_2_10003.OPEN_SHOP)

		return
	end

	SFX_PANEL = var_1_10007

	var_2(var_5_4, var_5_5, var_5_6, var_1_10007)

	onButton = var_2

	local var_5_7 = arg_5_0
	local var_5_8 = arg_5_0.searchClear

	local function var_5_9()
		setInputText = var_2_10000

		var_2_10000(arg_5_0.searchInput, "")

		return
	end

	SFX_PANEL = var_1_10007

	var_2(var_5_7, var_5_8, var_5_9, var_1_10007)

	onButton = var_2

	local var_5_10 = arg_5_0
	local var_5_11 = arg_5_0.saveBtn

	local function var_5_12()
		local var_10_0 = arg_5_0.dftAniEvent

		var_0.SetEndEvent(var_10_0, function()
			local var_11_0 = arg_5_0.dftAniEvent

			var_0.SetEndEvent(var_11_0, nil)

			local var_11_1 = arg_5_0
			local var_11_2 = var_0.emit

			BackYardDecorationMediator = var_3

			var_11_2(var_11_1, var_3.SAVE_ALL)

			return
		end)

		local var_10_1 = arg_5_0.animation

		var_0.Play(var_10_1, "anim_courtyard_decoration_out")

		return
	end

	SFX_PANEL = var_1_10007

	var_2(var_5_10, var_5_11, var_5_12, var_1_10007)

	onButton = var_2

	local var_5_13 = arg_5_0
	local var_5_14 = arg_5_0.clearBtn

	local function var_5_15()
		local var_12_0 = arg_5_0
		local var_12_1 = var_0.emit

		BackYardDecorationMediator = var_2_10003

		var_12_1(var_12_0, var_2_10003.ClEAR_ALL, true)

		return
	end

	SFX_PANEL = var_1_10007

	var_2(var_5_13, var_5_14, var_5_15, var_1_10007)

	onButton = var_2

	local var_5_16 = arg_5_0
	local var_5_17 = arg_5_0.filterBtn

	local function var_5_18()
		if not arg_5_0.pageType then
			return
		end

		local var_13_0 = arg_5_0.pages[arg_5_0.pageType]

		var_0.ShowFilterPanel(var_13_0, function(arg_14_0)
			local var_14_0

			i18n = var_3_10002

			if var_3_10002("backyard_sort_tag_price") == arg_14_0 then
				var_14_0 = "text_price"
			else
				i18n = var_2

				if var_2("backyard_sort_tag_comfortable") == arg_14_0 then
					var_14_0 = "text_comfortable"
				else
					i18n = var_2
					var_14_0 = var_2("backyard_sort_tag_size") == arg_14_0 and "text_area" or "text_default"
				end
			end

			local var_14_1 = arg_5_0.filterBtnTxt

			GetSpriteFromAtlas = var_3_10003
			var_14_1.sprite = var_3_10003("ui/NewBackYardDecorateUI_atlas", var_14_0)

			local var_14_2 = arg_5_0.filterBtnTxt

			var_2.SetNativeSize(var_14_2)

			return
		end)

		return
	end

	SFX_PANEL = var_1_10007

	var_2(var_5_16, var_5_17, var_5_18, var_1_10007)

	onInputChanged = var_2

	var_2(arg_5_0, arg_5_0.searchInput, function(arg_15_0)
		if not arg_5_0.pageType then
			return
		end

		setActive = var_1

		var_1(arg_5_0.searchClear, arg_15_0 ~= "")

		local var_15_0 = arg_5_0.pages[arg_5_0.pageType]

		var_1.ExecuteAction(var_15_0, "SearchKeyUpdated", arg_15_0)

		return
	end)

	onButton = var_2

	local var_5_19 = arg_5_0
	local var_5_20 = arg_5_0.showPutListBtn

	local function var_5_21()
		local var_16_0 = arg_5_0.putListPage

		var_0.ExecuteAction(var_16_0, "SetUp", 0, arg_5_0.dorm, arg_5_0.themes, arg_5_0.orderMode)

		return
	end

	SFX_PANEL = var_1_10007

	var_2(var_5_19, var_5_20, var_5_21, var_1_10007)

	onToggle = var_2

	local var_5_22 = arg_5_0
	local var_5_23 = arg_5_0.themeTag

	local function var_5_24(arg_17_0)
		if arg_17_0 then
			local var_17_0 = arg_5_0

			var_1.SwitchToPage(var_17_0, var_0_2)
		end

		return
	end

	SFX_PANEL = var_1_10007

	var_2(var_5_22, var_5_23, var_5_24, var_1_10007)

	onButton = var_2

	local var_5_25 = arg_5_0
	local var_5_26 = arg_5_0.hideBtn

	local function var_5_27()
		local var_18_0 = arg_5_0.bAnimtion

		var_0.Play(var_18_0, "anim_courtyard_decoration_bottomout")

		return
	end

	SFX_PANEL = var_1_10007

	var_2(var_5_25, var_5_26, var_5_27, var_1_10007)

	onButton = var_2

	local var_5_28 = arg_5_0
	local var_5_29 = arg_5_0.showBtn

	local function var_5_30()
		local var_19_0 = arg_5_0.bAnimtion

		var_0.Play(var_19_0, "anim_courtyard_decoration_bottomin")

		return
	end

	SFX_PANEL = var_1_10007

	var_2(var_5_28, var_5_29, var_5_30, var_1_10007)

	local var_5_31 = {}
	local var_5_32 = arg_5_0._tf

	var_5_31[1] = var_3.Find(var_5_32, "adpter/bottom/animroot/root/tags/1")

	local var_5_33 = arg_5_0._tf

	var_5_31[2] = var_3.Find(var_5_33, "adpter/bottom/animroot/root/tags/2")

	local var_5_34 = arg_5_0._tf

	var_5_31[3] = var_3.Find(var_5_34, "adpter/bottom/animroot/root/tags/3")

	local var_5_35 = arg_5_0._tf

	var_5_31[4] = var_3.Find(var_5_35, "adpter/bottom/animroot/root/tags/4")

	local var_5_36 = arg_5_0._tf

	var_5_31[5] = var_3.Find(var_5_36, "adpter/bottom/animroot/root/tags/5")

	local var_5_37 = arg_5_0._tf

	var_5_31[6] = var_3.Find(var_5_37, "adpter/bottom/animroot/root/tags/6")

	local var_5_38 = arg_5_0._tf

	var_5_31[7] = var_3.Find(var_5_38, "adpter/bottom/animroot/root/tags/7")

	local var_5_39 = arg_5_0._tf

	var_5_31[8] = var_3.Find(var_5_39, "adpter/bottom/animroot/root/tags/8")
	arg_5_0.tags = var_5_31
	onNextTick = var_5_31

	var_5_31(function()
		local var_20_0 = arg_5_0
		local var_20_1 = var_0.emit

		BackYardDecorationMediator = var_2_10003

		var_20_1(var_20_0, var_2_10003.ON_SET_UP)

		return
	end)

	return
end

function var_0_1.SetDorm(arg_21_0, arg_21_1)
	arg_21_0.dorm = arg_21_1

	return
end

function var_0_1.UpdateDorm(arg_22_0, arg_22_1)
	arg_22_0.dorm = arg_22_1

	if arg_22_0.pageType then
		local var_22_0 = arg_22_0.pages[arg_22_0.pageType]

		var_2.ExecuteAction(var_22_0, "DormUpdated", arg_22_0.dorm)
	end

	local var_22_1 = arg_22_0.putListPage

	if var_2.GetLoaded(var_22_1) then
		local var_22_2 = arg_22_0.putListPage

		if var_2.isShowing(var_22_2) then
			local var_22_3 = arg_22_0.putListPage

			var_2.ExecuteAction(var_22_3, "DormUpdated", arg_22_0.dorm)
		end
	end

	return
end

function var_0_1.OnApplyThemeBefore(arg_23_0)
	if arg_23_0.pageType then
		local var_23_0 = arg_23_0.pages[arg_23_0.pageType]

		var_1.ExecuteAction(var_23_0, "OnApplyThemeBefore")
	end

	return
end

function var_0_1.OnApplyThemeAfter(arg_24_0, arg_24_1)
	if arg_24_0.pageType then
		local var_24_0 = arg_24_0.pages[arg_24_0.pageType]

		var_2.ExecuteAction(var_24_0, "OnApplyThemeAfter", arg_24_1)
	end

	return
end

function var_0_1.UpdateFurnitrue(arg_25_0, arg_25_1)
	if arg_25_0.pageType then
		local var_25_0 = arg_25_0.pages[arg_25_0.pageType]

		var_2.ExecuteAction(var_25_0, "FurnitureUpdated", arg_25_1)
	end

	return
end

function var_0_1.SetThemes(arg_26_0, arg_26_1)
	arg_26_0.themes = arg_26_1

	return
end

function var_0_1.CustomThemeAdded(arg_27_0, arg_27_1)
	arg_27_0.themes[arg_27_1.id] = arg_27_1

	if arg_27_0.pageType then
		local var_27_0 = arg_27_0.pages[arg_27_0.pageType]

		var_2.ExecuteAction(var_27_0, "CustomThemeAdded", arg_27_1)
	end

	return
end

function var_0_1.CustomThemeDeleted(arg_28_0, arg_28_1)
	arg_28_0.themes[arg_28_1] = nil

	if arg_28_0.pageType then
		local var_28_0 = arg_28_0.pages[arg_28_0.pageType]

		var_2.ExecuteAction(var_28_0, "CustomThemeDeleted", arg_28_1)
	end

	return
end

function var_0_1.ThemeUpdated(arg_29_0)
	if arg_29_0.pageType then
		local var_29_0 = arg_29_0.pages[arg_29_0.pageType]

		var_1.ExecuteAction(var_29_0, "ThemeUpdated")
	end

	return
end

function var_0_1.UpdateTagTF(arg_30_0, arg_30_1, arg_30_2)
	onToggle = var_1_10003

	local var_30_0 = arg_30_0
	local var_30_1 = arg_30_2

	local function var_30_2(arg_31_0)
		if arg_31_0 then
			local var_31_0 = arg_30_0

			var_1.SwitchToPage(var_31_0, arg_30_1)
		end

		return
	end

	SFX_PANEL = var_1_10008

	var_1_10003(var_30_0, var_30_1, var_30_2, var_1_10008)

	return
end

function var_0_1.InitPages(arg_32_0)
	ipairs = var_1_10001

	for iter_32_0, iter_32_1 in var_1_10001(arg_32_0.tags) do
		arg_32_0:UpdateTagTF(iter_32_0 + 1, iter_32_1)
	end

	triggerToggle = var_1

	var_1(arg_32_0.themeTag, true)

	return
end

function var_0_1.SwitchToPage(arg_33_0, arg_33_1)
	if arg_33_0.pageType == arg_33_1 then
		return
	end

	if arg_33_0.page then
		local var_33_0 = arg_33_0.page

		if not var_2.GetLoaded(var_33_0) then
			return
		end
	end

	local var_33_1 = arg_33_0.pages[arg_33_1]

	if arg_33_0.page and arg_33_0.page ~= var_33_1 then
		local var_33_2 = arg_33_0.page

		var_3.ExecuteAction(var_33_2, "Hide")
	end

	var_33_1:ExecuteAction("SetUp", arg_33_1, arg_33_0.dorm, arg_33_0.themes, arg_33_0.orderMode)

	arg_33_0.page = var_33_1
	arg_33_0.pageType = arg_33_1
	setActive = var_3

	var_3(arg_33_0.filterBtn, arg_33_0.pageType ~= var_0_2)

	return
end

function var_0_1.willExit(arg_34_0)
	local var_34_0 = arg_34_0.dftAniEvent

	var_1.SetEndEvent(var_34_0, nil)

	local var_34_1 = arg_34_0.themePage

	var_1.Destroy(var_34_1)

	local var_34_2 = arg_34_0.furniturePage

	var_1.Destroy(var_34_2)

	local var_34_3 = arg_34_0.putListPage

	var_1.Destroy(var_34_3)

	local var_34_4 = arg_34_0.contextData.furnitureDescMsgBox

	var_1.Destroy(var_34_4)

	local var_34_5 = arg_34_0.contextData.filterPanel

	var_1.Destroy(var_34_5)

	BackYardThemeTempalteUtil = var_1

	var_1.ClearAllCache()

	return
end

function var_0_1.onBackPressed(arg_35_0)
	local var_35_0 = arg_35_0.themePage

	if var_1.OnBackPressed(var_35_0) then
		return
	end

	local var_35_1 = arg_35_0.furniturePage

	if var_1.OnBackPressed(var_35_1) then
		return
	end

	local var_35_2 = arg_35_0.putListPage

	if var_1.OnBackPressed(var_35_2) then
		return
	end

	local var_35_3 = arg_35_0.contextData.furnitureDescMsgBox

	if var_1.GetLoaded(var_35_3) then
		local var_35_4 = arg_35_0.contextData.furnitureDescMsgBox

		if var_1.isShowing(var_35_4) then
			local var_35_5 = arg_35_0.contextData.furnitureDescMsgBox

			var_1.Hide(var_35_5)

			return
		end
	end

	local var_35_6 = arg_35_0.contextData.filterPanel

	if var_1.GetLoaded(var_35_6) then
		local var_35_7 = arg_35_0.contextData.filterPanel

		if var_1.isShowing(var_35_7) then
			local var_35_8 = arg_35_0.contextData.filterPanel

			var_1.Hide(var_35_8)

			return
		end
	end

	triggerButton = var_1

	var_1(arg_35_0.saveBtn)

	return
end

return var_0_1
