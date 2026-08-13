class = var_0_10000

local var_0_0 = "BackYardThemeTemplateListPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...Shop.pages.BackYardThemePage"))

var_0_1.nextClickRefreshTime = 0

function var_0_1.getUIName(arg_1_0)
	return "BackYardThemeTemplateThemePage"
end

function var_0_1.LoadDetail(arg_2_0)
	setActive = var_1_10001

	local var_2_0 = arg_2_0._tf

	var_1_10001(var_3.Find(var_2_0, "adpter/descript"), false)

	return
end

function var_0_1.OnInit(arg_3_0)
	var_0_1.super.OnInit(arg_3_0)

	local var_3_0 = arg_3_0._tf

	arg_3_0.tipBg = var_1.Find(var_3_0, "tip")

	local var_3_1 = {}
	local var_3_2 = arg_3_0._tf

	var_3_1[1] = var_2.Find(var_3_2, "tip1")

	local var_3_3 = arg_3_0._tf

	var_3_1[2] = var_2.Find(var_3_3, "tip2")

	local var_3_4 = arg_3_0._tf

	var_3_1[3] = var_2.Find(var_3_4, "tip3")
	arg_3_0.tips = var_3_1

	local var_3_5 = arg_3_0._tf

	arg_3_0.goBtn = var_1.Find(var_3_5, "go_btn")

	local var_3_6 = arg_3_0._tf

	arg_3_0.helpBtn = var_1.Find(var_3_6, "adpter/help")

	local var_3_7 = arg_3_0._tf
	local var_3_8 = var_1.Find(var_3_7, "preview_raw")
	local var_3_9 = var_1.GetComponent

	typeof = var_4
	RawImage = var_1_10006
	arg_3_0.rawImage = var_3_9(var_3_8, var_4(var_1_10006))

	local var_3_10 = arg_3_0._tf

	arg_3_0.listRect = var_1.Find(var_3_10, "list/frame")

	local var_3_11 = arg_3_0._tf

	arg_3_0.refreshBtns = var_1.Find(var_3_11, "adpter/refresh_btns")

	local var_3_12 = {}
	local var_3_13 = arg_3_0.refreshBtns

	var_3_12[5] = var_2.Find(var_3_13, "random")

	local var_3_14 = arg_3_0.refreshBtns

	var_3_12[3] = var_2.Find(var_3_14, "hot")

	local var_3_15 = arg_3_0.refreshBtns

	var_3_12[2] = var_2.Find(var_3_15, "new")
	arg_3_0.btns = var_3_12
	setText = var_3_12

	local var_3_16 = arg_3_0.refreshBtns
	local var_3_17 = var_3.Find(var_3_16, "random/Text")

	i18n = var_3_15

	var_3_12(var_3_17, var_3_15("word_random"))

	setText = var_3_12

	local var_3_18 = arg_3_0.refreshBtns
	local var_3_19 = var_3.Find(var_3_18, "random/sel/Text")

	i18n = var_4

	var_3_12(var_3_19, var_4("word_random"))

	setText = var_3_12

	local var_3_20 = arg_3_0.refreshBtns
	local var_3_21 = var_3.Find(var_3_20, "hot/Text")

	i18n = var_4

	var_3_12(var_3_21, var_4("word_hot"))

	setText = var_3_12

	local var_3_22 = arg_3_0.refreshBtns
	local var_3_23 = var_3.Find(var_3_22, "hot/sel/Text")

	i18n = var_4

	var_3_12(var_3_23, var_4("word_hot"))

	setText = var_3_12

	local var_3_24 = arg_3_0.refreshBtns
	local var_3_25 = var_3.Find(var_3_24, "new/Text")

	i18n = var_4

	var_3_12(var_3_25, var_4("word_new"))

	setText = var_3_12

	local var_3_26 = arg_3_0.refreshBtns
	local var_3_27 = var_3.Find(var_3_26, "new/sel/Text")

	i18n = var_4

	var_3_12(var_3_27, var_4("word_new"))

	pairs = var_3_12

	for iter_3_0, iter_3_1 in var_3_12(arg_3_0.btns) do
		onButton = var_6

		local var_3_28 = arg_3_0
		local var_3_29 = iter_3_1

		local function var_3_30()
			local var_4_0 = arg_3_0

			if var_0.CanClickRefBtn(var_4_0, iter_3_0) then
				if arg_3_0.selectedRefBtn then
					setActive = var_0

					local var_4_1 = arg_3_0.selectedRefBtn

					var_0(var_2.Find(var_4_1, "sel"), false)

					setActive = var_0

					local var_4_2 = arg_3_0.selectedRefBtn

					var_0(var_2.Find(var_4_2, "Text"), true)
				end

				setActive = var_0

				local var_4_3 = iter_3_1

				var_0(var_2.Find(var_4_3, "sel"), true)

				setActive = var_0

				local var_4_4 = iter_3_1

				var_0(var_2.Find(var_4_4, "Text"), false)

				local var_4_5 = arg_3_0

				var_0.SwitchPage(var_4_5, iter_3_0, 1)

				arg_3_0.selectedRefBtn = iter_3_1
			end

			return
		end

		SFX_PANEL = var_1_10011

		var_6(var_3_28, var_3_29, var_3_30, var_1_10011)
	end

	onButton = var_1

	local var_3_31 = arg_3_0
	local var_3_32 = arg_3_0.helpBtn

	local function var_3_33()
		_backYardThemeTemplateMsgbox = var_2_10000

		local var_5_0 = var_2_10000
		local var_5_1 = var_2_10000.ShowHelp
		local var_5_2 = {}

		pg = var_2_10004
		var_5_2.helps = var_2_10004.gametip.backyard_theme_template_shop_tip.tip

		var_5_1(var_5_0, var_5_2)

		return
	end

	SFX_PANEL = var_6

	var_1(var_3_31, var_3_32, var_3_33, var_6)

	onButton = var_1

	local var_3_34 = arg_3_0
	local var_3_35 = arg_3_0.goBtn

	local function var_3_36()
		local var_6_0 = arg_3_0
		local var_6_1 = var_0.emit

		NewBackYardThemeTemplateMediator = var_2_10003

		var_6_1(var_6_0, var_2_10003.GO_DECORATION)

		return
	end

	SFX_PANEL = var_6

	var_1(var_3_34, var_3_35, var_3_36, var_6)

	local var_3_37 = arg_3_0.scrollRect.onValueChanged

	var_1.RemoveAllListeners(var_3_37)

	local var_3_38 = arg_3_0._tf

	arg_3_0.arrLeftBtnShop = var_1.Find(var_3_38, "list/frame/zuobian_shop")

	local var_3_39 = arg_3_0._tf

	arg_3_0.arrRightBtnShop = var_1.Find(var_3_39, "list/frame/youbian_shop")
	onButton = var_1

	local var_3_40 = arg_3_0
	local var_3_41 = arg_3_0.arrLeftBtnShop

	local function var_3_42()
		local var_7_0 = arg_3_0.pageType

		BackYardConst = var_2_10001

		if var_7_0 == var_2_10001.THEME_TEMPLATE_TYPE_SHOP then
			getProxy = var_7_0
			DormProxy = var_2_10002

			local var_7_1 = var_7_0(var_2_10002).PAGE

			getProxy = var_1
			DormProxy = var_2_10003

			local var_7_2 = var_1(var_2_10003).TYPE

			if var_7_1 > 1 then
				local var_7_3 = arg_3_0

				var_2.SwitchPage(var_7_3, var_7_2, var_7_1 - 1, true)
			end
		end

		return
	end

	SFX_PANEL = var_6

	var_1(var_3_40, var_3_41, var_3_42, var_6)

	onButton = var_1

	local var_3_43 = arg_3_0
	local var_3_44 = arg_3_0.arrRightBtnShop

	local function var_3_45()
		local var_8_0 = arg_3_0.pageType

		BackYardConst = var_2_10001

		if var_8_0 == var_2_10001.THEME_TEMPLATE_TYPE_SHOP then
			getProxy = var_8_0
			DormProxy = var_2_10002

			local var_8_1 = var_8_0(var_2_10002)

			var_8_1.ClickPage = true
			getProxy = var_8_1
			DormProxy = var_2_10002

			local var_8_2 = var_8_1(var_2_10002).PAGE

			getProxy = var_1
			DormProxy = var_2_10003

			local var_8_3 = var_1(var_2_10003).TYPE
			local var_8_4 = arg_3_0

			var_2.SwitchPage(var_8_4, var_8_3, var_8_2 + 1, true)
		end

		return
	end

	SFX_PANEL = var_6

	var_1(var_3_43, var_3_44, var_3_45, var_6)

	local function var_3_46()
		local var_9_0 = arg_3_0.pageType

		BackYardConst = var_2_10001

		if var_9_0 == var_2_10001.THEME_TEMPLATE_TYPE_SHOP then
			BackYardConst = var_9_0

			local var_9_1 = var_9_0.ThemeSortIndex2ServerIndex(arg_3_0.sortIndex, arg_3_0.asc)
			local var_9_2 = arg_3_0
			local var_9_3 = var_1.emit

			NewBackYardThemeTemplateMediator = var_2_10004

			var_9_3(var_9_2, var_2_10004.ON_GET_SPCAIL_TYPE_TEMPLATE, var_9_1)
		else
			local var_9_4 = arg_3_0

			var_0.SetTotalCount(var_9_4)
		end

		return
	end

	BackYardThemeTemplateDescPage = var_2
	arg_3_0.descPages = var_2.New(arg_3_0._tf, arg_3_0.event, arg_3_0.contextData)

	function arg_3_0.descPages.OnSortChange(arg_10_0)
		arg_3_0.asc = arg_10_0

		var_3_46()

		return
	end

	local var_3_47 = arg_3_0.contextData

	BackYardThemeTemplateInfoPage = var_3
	var_3_47.infoPage = var_3.New(arg_3_0._parentTf, arg_3_0.event, arg_3_0.contextData)

	local var_3_48 = arg_3_0.contextData

	BackYardFurnitureMsgBoxPage = var_3
	var_3_48.furnitureMsgBox = var_3.New(arg_3_0._parentTf, arg_3_0.event, arg_3_0.contextData)

	local var_3_49 = arg_3_0.contextData

	BackYardThemeTemplatePurchaseMsgbox = var_3
	var_3_49.themeMsgBox = var_3.New(arg_3_0._parentTf, arg_3_0.event, arg_3_0.contextData)
	setText = var_3_49

	local var_3_50 = arg_3_0.goBtn
	local var_3_51 = var_4.Find(var_3_50, "Text")

	i18n = var_5

	var_3_49(var_3_51, var_5("courtyard_label_go"))

	setText = var_3_49

	local var_3_52 = arg_3_0._tf
	local var_3_53 = var_4.Find(var_3_52, "tip1")

	i18n = var_5

	var_3_49(var_3_53, var_5("courtyard_label_empty_template_list"))

	setText = var_3_49

	local var_3_54 = arg_3_0._tf
	local var_3_55 = var_4.Find(var_3_54, "tip2")

	i18n = var_5

	var_3_49(var_3_55, var_5("courtyard_label_empty_custom_template_list"))

	setText = var_3_49

	local var_3_56 = arg_3_0._tf
	local var_3_57 = var_4.Find(var_3_56, "tip3")

	i18n = var_5

	var_3_49(var_3_57, var_5("courtyard_label_empty_collection_list"))

	return
end

function var_0_1.InitInput(arg_11_0)
	onInputChanged = var_1_10001

	var_1_10001(arg_11_0, arg_11_0.searchInput, function()
		getInputText = var_2_10000

		local var_12_0 = var_2_10000(arg_11_0.searchInput)

		setActive = var_2_10001

		var_2_10001(arg_11_0.searchClear, var_12_0 ~= "")

		return
	end)

	onInputEndEdit = var_1_10001

	var_1_10001(arg_11_0, arg_11_0.searchInput, function()
		local var_13_0 = arg_11_0

		var_0.OnSearchKeyChange(var_13_0)

		return
	end)

	return
end

function var_0_1.UpdateArr(arg_14_0)
	local var_14_0 = arg_14_0.pageType

	BackYardConst = var_1_10002

	local var_14_2

	if var_14_0 == var_1_10002.THEME_TEMPLATE_TYPE_SHOP then
		getProxy = var_14_0
		DormProxy = var_1_10003

		local var_14_1 = var_14_0(var_1_10003).PAGE

		getProxy = var_14_2
		DormProxy = var_1_10004
		var_14_2 = var_14_2(var_1_10004).TYPE
		getProxy = var_1_10003
		DormProxy = var_1_10005

		local var_14_3 = var_1_10003(var_1_10005).lastPages[var_14_2]

		getProxy = var_1_10004
		DormProxy = var_1_10006

		local var_14_4 = var_1_10004(var_1_10006).ClickPage

		setActive = var_1_10005

		var_1_10005(arg_14_0.arrLeftBtnShop, var_14_1 > 1)

		setActive = var_1_10005

		var_1_10005(arg_14_0.arrRightBtnShop, var_14_1 < var_14_3 or not var_14_4)
	else
		local var_14_5 = arg_14_0.pageType

		BackYardConst = var_14_2

		if var_14_5 == var_14_2.THEME_TEMPLATE_TYPE_CUSTOM then
			setActive = var_14_5

			var_14_5(arg_14_0.arrLeftBtnShop, false)

			setActive = var_14_5

			var_14_5(arg_14_0.arrRightBtnShop, false)
		else
			setActive = var_14_5

			var_14_5(arg_14_0.arrLeftBtnShop, false)

			setActive = var_14_5

			var_14_5(arg_14_0.arrRightBtnShop, false)
		end
	end

	return
end

function var_0_1.CanClickRefBtn(arg_15_0, arg_15_1)
	getProxy = var_1_10002
	DormProxy = var_1_10004

	local var_15_0 = var_1_10002(var_1_10004).TYPE

	pg = var_1_10003

	local var_15_1 = var_1_10003.TimeMgr.GetInstance()

	if var_3.GetServerTime(var_15_1) < var_0_1.nextClickRefreshTime then
		math = var_4

		local var_15_2 = var_4.ceil(var_0_1.nextClickRefreshTime - var_3)

		pg = var_15_1

		local var_15_3 = var_15_1.TipsMgr.GetInstance()
		local var_15_4 = var_5.ShowTips

		i18n = var_1_10008

		var_15_4(var_15_3, var_1_10008("backyard_shop_refresh_frequently", var_15_2))

		return false
	end

	if var_15_0 == arg_15_1 and arg_15_1 ~= 5 then
		return false
	end

	return true
end

function var_0_1.SwitchPage(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	getProxy = var_1_10004
	DormProxy = var_1_10006

	local var_16_0 = var_1_10004(var_1_10006).TYPE
	local var_16_1 = arg_16_0.timeType

	if var_16_0 ~= arg_16_1 or arg_16_3 then
		local var_16_2 = arg_16_0
		local var_16_3 = arg_16_0.emit

		NewBackYardThemeTemplateMediator = var_1_10009

		var_16_3(var_16_2, var_1_10009.ON_REFRESH, arg_16_1, arg_16_2, var_16_1, arg_16_3)

		if not arg_16_3 then
			pg = var_16_3

			local var_16_4 = var_16_3.TimeMgr.GetInstance()
			local var_16_5 = var_6.GetServerTime(var_16_4)
			local var_16_6 = var_0_1

			BackYardConst = var_16_4
			var_16_6.nextClickRefreshTime = var_16_4.MANUAL_REFRESH_THEME_TEMPLATE_TIME + var_16_5
		end
	end

	return
end

function var_0_1.UpdateDorm(arg_17_0, arg_17_1)
	arg_17_0.dorm = arg_17_1

	local var_17_0 = arg_17_0.contextData.infoPage

	if var_2.GetLoaded(var_17_0) then
		local var_17_1 = arg_17_0.contextData.infoPage

		if var_2.isShowing(var_17_1) then
			local var_17_2 = arg_17_0.contextData.infoPage

			var_2.ExecuteAction(var_17_2, "DormUpdated", arg_17_1)
		end
	end

	local var_17_3 = arg_17_0.descPages

	if var_2.GetLoaded(var_17_3) then
		local var_17_4 = arg_17_0.descPages

		var_2.ExecuteAction(var_17_4, "UpdateDorm", arg_17_1)
	end

	return
end

function var_0_1.PlayerUpdated(arg_18_0, arg_18_1)
	arg_18_0.player = arg_18_1

	local var_18_0 = arg_18_0.contextData.infoPage

	if var_2.GetLoaded(var_18_0) then
		local var_18_1 = arg_18_0.contextData.infoPage

		if var_2.isShowing(var_18_1) then
			local var_18_2 = arg_18_0.contextData.infoPage

			var_2.ExecuteAction(var_18_2, "OnPlayerUpdated", arg_18_1)
		end
	end

	local var_18_3 = arg_18_0.descPages

	if var_2.GetLoaded(var_18_3) then
		local var_18_4 = arg_18_0.descPages

		var_2.ExecuteAction(var_18_4, "PlayerUpdated", arg_18_1)
	end

	return
end

function var_0_1.FurnituresUpdated(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0.contextData.infoPage

	if var_2.GetLoaded(var_19_0) then
		local var_19_1 = arg_19_0.contextData.infoPage

		if var_2.isShowing(var_19_1) then
			local var_19_2 = arg_19_0.contextData.infoPage

			var_2.ExecuteAction(var_19_2, "FurnituresUpdated", arg_19_1)
		end
	end

	return
end

function var_0_1.ThemeTemplateUpdate(arg_20_0, arg_20_1)
	ipairs = var_1_10002

	for iter_20_0, iter_20_1 in var_1_10002(arg_20_0.list) do
		if iter_20_1.id == arg_20_1.id then
			arg_20_0.list[iter_20_0] = arg_20_1

			break
		end
	end

	pairs = var_2

	for iter_20_2, iter_20_3 in var_2(arg_20_0.cards) do
		if iter_20_3.template.id == arg_20_1.id then
			iter_20_3:Update(arg_20_1)
		end
	end

	local var_20_0 = arg_20_0.descPages

	if var_2.GetLoaded(var_20_0) then
		local var_20_1 = arg_20_0.descPages

		var_2.ThemeTemplateUpdate(var_20_1, arg_20_1)
	end

	return
end

function var_0_1.ThemeTemplatesUpdate(arg_21_0, arg_21_1)
	arg_21_0:Flush(arg_21_1)

	return
end

function var_0_1.OnSearchKeyChange(arg_22_0)
	getInputText = var_1_10001

	local var_22_0 = var_1_10001(arg_22_0.searchInput)
	local var_22_1 = arg_22_0
	local var_22_2 = arg_22_0.emit

	NewBackYardThemeTemplateMediator = var_1_10005

	var_22_2(var_22_1, var_1_10005.ON_SEARCH, arg_22_0.pageType, var_22_0)

	return
end

function var_0_1.ShopSearchKeyChange(arg_23_0, arg_23_1)
	arg_23_0.searchTemplate = arg_23_1

	arg_23_0:InitThemeList()

	pairs = var_2

	for iter_23_0, iter_23_1 in var_2(arg_23_0.cards) do
		if iter_23_1.themeVO.id == arg_23_1.id then
			triggerButton = var_7

			var_7(iter_23_1._tf)

			break
		end
	end

	return
end

function var_0_1.OnSearchKeyEditEnd(arg_24_0)
	getInputText = var_1_10001

	if not var_1_10001(arg_24_0.searchInput) or var_1 == "" then
		local var_24_0 = arg_24_0
		local var_24_1 = arg_24_0.emit

		NewBackYardThemeTemplateMediator = var_1_10005

		var_24_1(var_24_0, var_1_10005.ON_SEARCH, arg_24_0.pageType, var_1)
	end

	return
end

function var_0_1.ClearShopSearchKey(arg_25_0)
	arg_25_0.searchTemplate = nil

	arg_25_0:InitThemeList()
	arg_25_0:ForceActiveFirstCard()

	return
end

function var_0_1.DeleteCustomThemeTemplate(arg_26_0, arg_26_1)
	ipairs = var_1_10002

	for iter_26_0, iter_26_1 in var_1_10002(arg_26_0.list) do
		if iter_26_1.id == arg_26_1 then
			table = var_7

			var_7.remove(arg_26_0.list, iter_26_0)

			break
		end
	end

	arg_26_0:InitThemeList()
	arg_26_0:ForceActiveFirstCard()

	return
end

function var_0_1.DeleteCollectionThemeTemplate(arg_27_0, arg_27_1)
	ipairs = var_1_10002

	for iter_27_0, iter_27_1 in var_1_10002(arg_27_0.list) do
		if iter_27_1.id == arg_27_1 then
			table = var_7

			var_7.remove(arg_27_0.list, iter_27_0)

			break
		end
	end

	arg_27_0:InitThemeList()
	arg_27_0:ForceActiveFirstCard()

	return
end

function var_0_1.AddCollectionThemeTemplate(arg_28_0, arg_28_1)
	table = var_1_10002

	var_1_10002.insert(arg_28_0.list, arg_28_1)
	arg_28_0:InitThemeList()

	return
end

function var_0_1.DeleteShopThemeTemplate(arg_29_0, arg_29_1)
	ipairs = var_1_10002

	for iter_29_0, iter_29_1 in var_1_10002(arg_29_0.list) do
		if iter_29_1.id == arg_29_1 then
			table = var_7

			var_7.remove(arg_29_0.list, iter_29_0)

			break
		end
	end

	arg_29_0:InitThemeList()
	arg_29_0:ForceActiveFirstCard()

	return
end

function var_0_1.ThemeTemplatesErro(arg_30_0)
	arg_30_0:UpdateArr()

	return
end

function var_0_1.GetData(arg_31_0)
	local var_31_0 = arg_31_0.pageType

	BackYardConst = var_1_10002

	if var_31_0 == var_1_10002.THEME_TEMPLATE_TYPE_SHOP then
		table = var_31_0

		var_31_0.sort(arg_31_0.list, function(arg_32_0, arg_32_1)
			return arg_32_0.sortIndex < arg_32_1.sortIndex
		end)
	else
		local var_31_1
		local var_31_2
		local var_31_3 = arg_31_0.pageType

		BackYardConst = var_1_10004

		if var_31_3 == var_1_10004.THEME_TEMPLATE_TYPE_CUSTOM then
			BackYardConst = var_31_3
			var_31_3 = var_31_3.ServerIndex2ThemeSortIndex
			getProxy = var_1_10005
			DormProxy = var_1_10007

			local var_31_4

			var_31_3, var_31_4 = var_31_3(var_1_10005(var_1_10007).TYPE)

			local var_31_5 = var_31_4
			local var_31_6 = var_31_3
		else
			defaultValue = var_31_3

			local var_31_7 = var_31_3(arg_31_0.sortIndex, 1)

			defaultValue = var_3

			local var_31_8 = var_3(arg_31_0.asc, true)
		end
	end

	return arg_31_0.list
end

function var_0_1.OnDormUpdated(arg_33_0)
	return
end

function var_0_1.OnPlayerUpdated(arg_34_0)
	return
end

function var_0_1.BlurView(arg_35_0)
	return
end

function var_0_1.UnBlurView(arg_36_0)
	return
end

function var_0_1.SetUp(arg_37_0, arg_37_1, arg_37_2, arg_37_3, arg_37_4)
	arg_37_0.searchTemplate = nil
	arg_37_0.searchKey = ""
	arg_37_0.pageType = arg_37_1
	arg_37_0.dorm = arg_37_3
	arg_37_0.player = arg_37_4

	local var_37_0 = arg_37_0

	arg_37_0.Flush(var_37_0, arg_37_2)

	local var_37_1 = arg_37_0.pageType

	BackYardConst = var_1_10006

	local var_37_2

	if var_37_1 == var_1_10006.THEME_TEMPLATE_TYPE_SHOP then
		getProxy = var_37_1
		DormProxy = var_37_0
		var_37_1 = var_37_1(var_37_0).TYPE
		getProxy = var_37_2
		DormProxy = var_8
		var_37_2 = var_37_2(var_8).PAGE
		setActive = var_37_0

		local var_37_3 = arg_37_0.btns[var_37_1]

		var_37_0(var_1_10009.Find(var_37_3, "sel"), true)

		arg_37_0.selectedRefBtn = arg_37_0.btns[var_37_1]
		getProxy = var_7
		DormProxy = var_1_10009
		var_1_10009 = var_7(var_1_10009)

		if var_7.NeedRefreshThemeTemplateShop(var_1_10009) then
			var_1_10009 = arg_37_0

			arg_37_0.SwitchPage(var_1_10009, var_37_1, var_37_2, true)
		end
	end

	setActive = var_37_1

	local var_37_4 = arg_37_0.refreshBtns
	local var_37_5 = arg_37_0.pageType

	BackYardConst = var_1_10009

	var_37_1(var_37_4, var_37_5 == var_1_10009.THEME_TEMPLATE_TYPE_SHOP)

	setActive = var_37_1

	local var_37_6 = arg_37_0.searchInput.gameObject
	local var_37_7 = arg_37_0.pageType

	BackYardConst = var_9

	var_37_1(var_37_6, var_37_7 == var_9.THEME_TEMPLATE_TYPE_SHOP)

	local var_37_8 = arg_37_0.pageType

	BackYardConst = var_37_2

	if var_37_8 == var_37_2.THEME_TEMPLATE_TYPE_COLLECTION then
		getProxy = var_37_8
		DormProxy = var_37_6
		var_37_6 = var_37_8(var_37_6)

		if var_37_8.NeedCollectionTip(var_37_6) then
			pg = var_37_8
			var_37_6 = var_37_8.TipsMgr.GetInstance()
			var_37_8 = var_37_8.ShowTips
			i18n = var_8

			var_37_8(var_37_6, var_8("BackYard_collection_be_delete_tip"))
		end
	end

	getProxy = var_37_8
	DormProxy = var_37_6

	local var_37_9 = var_37_8(var_37_6)

	if var_5.NeedShopShowHelp(var_37_9) then
		-- block empty
	end

	local var_37_10 = arg_37_0.pageType

	BackYardConst = var_6

	if var_37_10 ~= var_6.THEME_TEMPLATE_TYPE_SHOP then
		pairs = var_37_10

		for iter_37_0, iter_37_1 in var_37_10(arg_37_0.btns) do
			setActive = var_1_10010

			var_1_10010(iter_37_1:Find("sel"), false)

			setActive = var_1_10010

			var_1_10010(iter_37_1:Find("Text"), true)
		end
	end

	return
end

function var_0_1.Flush(arg_38_0, arg_38_1)
	arg_38_0:Show()

	arg_38_0.list = arg_38_1 or {}

	arg_38_0:InitThemeList()
	arg_38_0:UpdateArr()

	arg_38_0.card = nil
	onNextTick = var_2

	var_2(function()
		local var_39_0 = arg_38_0

		var_0.ForceActiveFirstCard(var_39_0)

		return
	end)

	return
end

function var_0_1.InitThemeList(arg_40_0)
	setActive = var_1_10001

	var_1_10001(arg_40_0.rawImage.gameObject, false)
	arg_40_0:SetTotalCount()

	return
end

function var_0_1.SetTotalCount(arg_41_0)
	arg_41_0.disPlays = {}

	local var_41_0 = arg_41_0:GetData()

	if arg_41_0.searchTemplate then
		table = var_2

		var_2.insert(arg_41_0.disPlays, arg_41_0.searchTemplate)
	else
		ipairs = var_2

		for iter_41_0, iter_41_1 in var_2(var_41_0) do
			if iter_41_1:MatchSearchKey(arg_41_0.searchKey) then
				table = var_7

				var_7.insert(arg_41_0.disPlays, iter_41_1)
			end
		end
	end

	arg_41_0.scrollRect.enabled = true

	local var_41_1 = arg_41_0.scrollRect

	var_2.SetTotalCount(var_41_1, #arg_41_0.disPlays)

	return
end

function var_0_1.ForceActiveFirstCard(arg_42_0)
	local var_42_0 = #arg_42_0.disPlays == 0

	setActive = var_1_10002

	var_1_10002(arg_42_0.tipBg, var_42_0)

	GetOrAddComponent = var_1_10002

	local var_42_1 = arg_42_0.listRect

	typeof = var_5
	CanvasGroup = var_1_10007

	local var_42_2 = var_1_10002(var_42_1, var_5(var_1_10007))

	var_42_2.alpha = var_42_0 and 0 or 1
	var_42_2.blocksRaycasts = not var_42_0
	_ = var_3

	var_3.each(arg_42_0.tips, function(arg_43_0)
		setActive = var_2_10001

		local var_43_0 = arg_43_0
		local var_43_1 = arg_43_0.gameObject.name
		local var_43_2 = "tip"

		tostring = var_2_10006

		var_2_10001(var_43_0, var_43_1 == var_43_2 .. var_2_10006(arg_42_0.pageType) and #arg_42_0.disPlays == 0)

		return
	end)

	setActive = var_3

	local var_42_3 = arg_42_0.goBtn
	local var_42_4 = arg_42_0.pageType

	BackYardConst = var_1_10007

	var_3(var_42_3, var_42_4 == var_1_10007.THEME_TEMPLATE_TYPE_CUSTOM and #arg_42_0.disPlays == 0)

	if #arg_42_0.disPlays == 0 then
		local var_42_5 = arg_42_0.descPages

		var_3.ExecuteAction(var_42_5, "Hide")

		return
	end

	local var_42_6 = arg_42_0.disPlays[1]

	pairs = var_42_1

	for iter_42_0, iter_42_1 in var_42_1(arg_42_0.cards) do
		if var_42_6.id == iter_42_1.template.id then
			triggerButton = var_9

			var_9(iter_42_1._tf)

			break
		end
	end

	return
end

function var_0_1.NoSelected(arg_44_0)
	return false
end

function var_0_1.CreateCard(arg_45_0, arg_45_1)
	BackYardThemeTemplateCard = var_1_10002

	return (var_1_10002.New(arg_45_1))
end

function var_0_1.OnUpdateCard(arg_46_0, arg_46_1, arg_46_2)
	var_0_1.super.OnUpdateCard(arg_46_0, arg_46_1, arg_46_2)

	local var_46_0 = arg_46_0.cards[arg_46_2].template

	if var_4.ShouldFetch(var_46_0) then
		local var_46_1 = arg_46_0
		local var_46_2 = arg_46_0.emit

		NewBackYardThemeTemplateMediator = var_7

		var_46_2(var_46_1, var_7.ON_GET_THEMPLATE_DATA, var_3.template.id, function(arg_47_0)
			local var_47_0 = var_0

			var_1.FlushData(var_47_0, arg_47_0)

			return
		end)
	end

	return
end

function var_0_1.OnCardClick(arg_48_0, arg_48_1)
	if arg_48_1.template == arg_48_0.card then
		return
	end

	local var_48_0 = arg_48_0.descPages

	if var_2.GetLoaded(var_48_0) then
		local var_48_1 = arg_48_0.descPages

		var_2.Hide(var_48_1)
	end

	setActive = var_2

	var_2(arg_48_0.rawImage.gameObject, false)

	local function var_48_2(arg_49_0)
		local var_49_0 = arg_49_0:GetImageMd5()

		BackYardThemeTempalteUtil = var_2_10002

		var_2_10002.GetTexture(arg_49_0:GetTextureName(), var_49_0, function(arg_50_0)
			IsNil = var_3_10001

			if not var_3_10001(arg_48_0.rawImage) and arg_50_0 then
				local var_50_0 = arg_48_0.rawImage

				var_50_0.texture = arg_50_0
				setActive = var_50_0

				var_50_0(arg_48_0.rawImage.gameObject, true)

				local var_50_1 = arg_48_0.rawImage

				var_1.SetNativeSize(var_50_1)
			end

			return
		end)

		local var_49_1 = arg_48_0.descPages

		var_2.ExecuteAction(var_49_1, "SetUp", arg_48_0.pageType, arg_48_1.template, arg_48_0.dorm, arg_48_0.player)

		return
	end

	local var_48_3 = arg_48_1.template

	if var_3.ShouldFetch(var_48_3) then
		local var_48_4 = arg_48_0
		local var_48_5 = arg_48_0.emit

		NewBackYardThemeTemplateMediator = var_1_10006

		var_48_5(var_48_4, var_1_10006.ON_GET_THEMPLATE_DATA, arg_48_1.template.id, function(arg_51_0)
			var_48_2(arg_48_1.template)

			return
		end)
	else
		var_48_2(arg_48_1.template)
	end

	arg_48_0.card = arg_48_1.template

	return
end

function var_0_1.OnDestroy(arg_52_0)
	var_0_1.super.OnDestroy(arg_52_0)

	arg_52_0.descPages.OnSortChange = nil

	local var_52_0 = arg_52_0.descPages

	var_1.Destroy(var_52_0)

	local var_52_1 = arg_52_0.contextData.infoPage

	var_1.Destroy(var_52_1)

	local var_52_2 = arg_52_0.contextData.furnitureMsgBox

	var_1.Destroy(var_52_2)

	local var_52_3 = arg_52_0.contextData.themeMsgBox

	var_1.Destroy(var_52_3)

	IsNil = var_1

	if not var_1(arg_52_0.rawImage.texture) then
		Object = var_1

		var_1.Destroy(arg_52_0.rawImage.texture)

		arg_52_0.rawImage.texture = nil
	end

	return
end

return var_0_1
