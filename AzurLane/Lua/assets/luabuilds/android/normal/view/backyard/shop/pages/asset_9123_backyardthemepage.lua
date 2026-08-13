class = var_0_10000

local var_0_0 = "BackYardThemePage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".BackYardShopBasePage"))

function var_0_1.getUIName(arg_1_0)
	return "BackYardThemePage"
end

function var_0_1.OnLoaded(arg_2_0)
	arg_2_0:LoadList()
	arg_2_0:LoadDetail()

	BackYardLargeSpriteLoader = var_1
	arg_2_0.largeSpLoader = var_1.New(6)

	return
end

function var_0_1.LoadList(arg_3_0)
	arg_3_0._parentTF = arg_3_0._tf.parent

	local var_3_0 = arg_3_0._tf

	arg_3_0.adpter = var_1.Find(var_3_0, "adpter")

	local var_3_1 = arg_3_0._tf

	arg_3_0.themeContainer = var_1.Find(var_3_1, "list/frame")

	local var_3_2 = arg_3_0._tf
	local var_3_3 = var_1.Find(var_3_2, "list/frame/mask/content")

	arg_3_0.scrollRect = var_1.GetComponent(var_3_3, "LScrollRect")

	local var_3_4 = arg_3_0._tf

	arg_3_0.scrollRectWidth = var_1.Find(var_3_4, "list/frame/mask").rect.width

	local var_3_5 = arg_3_0._tf

	arg_3_0.searchInput = var_1.Find(var_3_5, "adpter/search")

	local var_3_6 = arg_3_0.searchInput

	arg_3_0.searchClear = var_1.Find(var_3_6, "clear")
	setText = var_1

	local var_3_7 = arg_3_0.searchInput
	local var_3_8 = var_2.Find(var_3_7, "Placeholder")

	i18n = var_3_7

	var_1(var_3_8, var_3_7("courtyard_label_search_holder"))

	return
end

function var_0_1.LoadDetail(arg_4_0)
	local var_4_0 = arg_4_0._tf

	arg_4_0.purchaseBtn = var_1.Find(var_4_0, "adpter/descript/btn_goumai")

	local var_4_1 = arg_4_0._tf
	local var_4_2 = var_1.Find(var_4_1, "adpter/descript/title")
	local var_4_3 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_4_0.title = var_4_3(var_4_2, var_3(var_1_10004))

	local var_4_4 = arg_4_0._tf
	local var_4_5 = var_1.Find(var_4_4, "adpter/descript/desc")
	local var_4_6 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_4_0.desc = var_4_6(var_4_5, var_3(var_1_10004))

	local var_4_7 = arg_4_0._tf

	arg_4_0.actualPrice = var_1.Find(var_4_7, "adpter/descript/price/actual_price")

	local var_4_8 = arg_4_0._tf
	local var_4_9 = var_1.Find(var_4_8, "adpter/descript/price/actual_price/Text")
	local var_4_10 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_4_0.actualPriceTxt = var_4_10(var_4_9, var_3(var_1_10004))

	local var_4_11 = arg_4_0._tf
	local var_4_12 = var_1.Find(var_4_11, "adpter/descript/price/price/Text")
	local var_4_13 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_4_0.goldTxt = var_4_13(var_4_12, var_3(var_1_10004))

	local var_4_14 = arg_4_0._tf
	local var_4_15 = var_1.Find(var_4_14, "preview")
	local var_4_16 = var_1.GetComponent

	typeof = var_3
	Image = var_1_10004
	arg_4_0.preview = var_4_16(var_4_15, var_3(var_1_10004))

	local var_4_17 = arg_4_0._tf

	arg_4_0.descript = var_1.Find(var_4_17, "adpter/descript")
	BackYardThemeInfoPage = var_1
	arg_4_0.infoPage = var_1.New(arg_4_0._tf.parent, arg_4_0.event, arg_4_0.contextData)

	function arg_4_0.infoPage.OnEnter()
		local var_5_0 = arg_4_0

		var_0.UnBlurView(var_5_0)

		return
	end

	function arg_4_0.infoPage.OnExit()
		local var_6_0 = arg_4_0

		var_0.BlurView(var_6_0)

		return
	end

	function arg_4_0.infoPage.OnPrevTheme()
		local var_7_0 = arg_4_0

		var_0.OnInfoPagePrevTheme(var_7_0)

		return
	end

	local var_4_18 = arg_4_0.infoPage

	function var_4_18.OnNextTheme()
		local var_8_0 = arg_4_0

		var_0.OnInfoPageNextTheme(var_8_0)

		return
	end

	onButton = var_4_18

	local var_4_19 = arg_4_0
	local var_4_20 = arg_4_0.purchaseBtn

	local function var_4_21()
		local var_9_0 = arg_4_0
		local var_9_1 = var_0.GetSelectedIndex(var_9_0)
		local var_9_2 = arg_4_0.infoPage

		var_1.ExecuteAction(var_9_2, "SetUp", var_9_1, arg_4_0.selected, arg_4_0.dorm, arg_4_0.player)

		return
	end

	SFX_PANEL = var_1_10005

	var_4_18(var_4_19, var_4_20, var_4_21, var_1_10005)

	setText = var_4_18

	local var_4_22 = arg_4_0.purchaseBtn
	local var_4_23 = var_2.Find(var_4_22, "Text")

	i18n = var_4_22

	var_4_18(var_4_23, var_4_22("word_buy"))

	return
end

function var_0_1.OnInit(arg_10_0)
	arg_10_0.cards = {}

	function arg_10_0.scrollRect.onInitItem(arg_11_0)
		local var_11_0 = arg_10_0

		var_1.OnInitCard(var_11_0, arg_11_0)

		return
	end

	function arg_10_0.scrollRect.onUpdateItem(arg_12_0, arg_12_1)
		local var_12_0 = arg_10_0

		var_2.OnUpdateCard(var_12_0, arg_12_0, arg_12_1)

		return
	end

	arg_10_0:InitInput()

	onButton = var_1

	local var_10_0 = arg_10_0
	local var_10_1 = arg_10_0.searchClear

	local function var_10_2()
		setInputText = var_2_10000

		var_2_10000(arg_10_0.searchInput, "")

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_10_0, var_10_1, var_10_2, var_1_10005)

	return
end

function var_0_1.InitInput(arg_14_0)
	onInputChanged = var_1_10001

	var_1_10001(arg_14_0, arg_14_0.searchInput, function()
		getInputText = var_2_10000

		local var_15_0 = var_2_10000(arg_14_0.searchInput)

		setActive = var_1

		var_1(arg_14_0.searchClear, var_15_0 ~= "")

		local var_15_1 = arg_14_0

		var_1.OnSearchKeyChange(var_15_1)

		return
	end)

	return
end

function var_0_1.GetData(arg_16_0)
	local var_16_0 = {}

	getProxy = var_1_10002
	DormProxy = var_1_10003

	local var_16_1 = var_1_10002(var_1_10003)
	local var_16_2 = var_2.GetSystemThemes(var_16_1)

	getInputText = var_16_1

	local var_16_3 = var_16_1(arg_16_0.searchInput)
	local var_16_4 = arg_16_0.dorm
	local var_16_5 = var_4.GetPurchasedFurnitures(var_16_4)
	local var_16_6 = {}

	ipairs = var_1_10006

	for iter_16_0, iter_16_1 in var_1_10006(var_16_2) do
		if not iter_16_1:IsOverTime() and iter_16_1:MatchSearchKey(var_16_3) then
			table = var_11

			var_11.insert(var_16_0, iter_16_1)

			var_16_6[iter_16_1.id] = iter_16_1:IsPurchased(var_16_5) and 1 or 0
		end
	end

	pg = var_6

	local var_16_7 = var_6.backyard_theme_template

	local function var_16_8(arg_17_0, arg_17_1)
		if var_16_7[arg_17_0.id].hot == var_16_7[arg_17_1.id].hot then
			return var_16_7[arg_17_0.id].order > var_16_7[arg_17_1.id].order
		else
			return var_16_7[arg_17_0.id].hot > var_16_7[arg_17_1.id].hot
		end

		return
	end

	table = var_8

	var_8.sort(var_16_0, function(arg_18_0, arg_18_1)
		if var_16_6[arg_18_0.id] == var_16_6[arg_18_1.id] then
			if var_16_7[arg_18_0.id].new == var_16_7[arg_18_1.id].new then
				return var_16_8(arg_18_0, arg_18_1)
			else
				return var_16_7[arg_18_0.id].new > var_16_7[arg_18_1.id].new
			end
		else
			return var_2 < var_3
		end

		return
	end)

	return var_16_0
end

function var_0_1.FurnituresUpdated(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0.infoPage

	if var_2.GetLoaded(var_19_0) then
		local var_19_1 = arg_19_0.infoPage

		var_2.ExecuteAction(var_19_1, "FurnituresUpdated", arg_19_1)
	end

	if arg_19_0.card then
		arg_19_0:UpdatePrice(arg_19_0.card)
	end

	arg_19_0:InitThemeList()

	return
end

function var_0_1.OnDormUpdated(arg_20_0)
	local var_20_0 = arg_20_0.infoPage

	if var_1.GetLoaded(var_20_0) then
		local var_20_1 = arg_20_0.infoPage

		var_1.ExecuteAction(var_20_1, "DormUpdated", arg_20_0.dorm)
	end

	return
end

function var_0_1.OnPlayerUpdated(arg_21_0)
	local var_21_0 = arg_21_0.infoPage

	if var_1.GetLoaded(var_21_0) then
		local var_21_1 = arg_21_0.infoPage

		var_1.ExecuteAction(var_21_1, "OnPlayerUpdated", arg_21_0.player)
	end

	return
end

function var_0_1.OnSetUp(arg_22_0)
	arg_22_0:InitThemeList()
	arg_22_0:BlurView()

	return
end

function var_0_1.InitThemeList(arg_23_0)
	arg_23_0.disPlays = arg_23_0:GetData()
	onNextTick = var_1

	var_1(function()
		arg_23_0.scrollRect.enabled = true

		local var_24_0 = arg_23_0.scrollRect

		var_0.SetTotalCount(var_24_0, #arg_23_0.disPlays)

		return
	end)

	return
end

function var_0_1.OnSearchKeyChange(arg_25_0)
	arg_25_0:InitThemeList()

	return
end

function var_0_1.CreateCard(arg_26_0, arg_26_1)
	BackYardThemeCard = var_1_10002

	return (var_1_10002.New(arg_26_1))
end

function var_0_1.OnInitCard(arg_27_0, arg_27_1)
	local var_27_0 = arg_27_0
	local var_27_1 = arg_27_0.CreateCard(var_27_0, arg_27_1)

	onButton = var_27_0

	local var_27_2 = arg_27_0
	local var_27_3 = var_27_1._go

	local function var_27_4()
		local var_28_0 = arg_27_0

		var_0.OnCardClick(var_28_0, var_27_1)

		local var_28_1 = arg_27_0.selected
		local var_28_2 = arg_27_0

		var_28_2.selected = var_27_1.themeVO

		if var_28_1 then
			pairs = var_28_2

			for iter_28_0, iter_28_1 in var_28_2(arg_27_0.cards) do
				if iter_28_1.themeVO.id == var_28_1.id and iter_28_1._go.name ~= "-1" then
					iter_28_1 = preCard

					break
				end
			end

			preCard = var_1

			if var_1 then
				preCard = var_1

				var_1:UpdateSelected(arg_27_0.selected)
			end
		end

		local var_28_3 = var_27_1

		var_1.UpdateSelected(var_28_3, arg_27_0.selected)

		return
	end

	SFX_PANEL = var_1_10007

	var_27_0(var_27_2, var_27_3, var_27_4, var_1_10007)

	arg_27_0.cards[arg_27_1] = var_27_1

	return
end

function var_0_1.OnUpdateCard(arg_29_0, arg_29_1, arg_29_2)
	if not arg_29_0.cards[arg_29_2] then
		arg_29_0:OnInitCard(arg_29_2)
	end

	local var_29_0 = arg_29_0.cards[arg_29_2]
	local var_29_1 = arg_29_0.dorm
	local var_29_2 = var_4.GetPurchasedFurnitures(var_29_1)
	local var_29_3 = arg_29_0.disPlays[arg_29_1 + 1]

	var_29_0:Update(var_29_3, var_29_3:IsPurchased(var_29_2))
	var_29_0:UpdateSelected(arg_29_0.selected)

	if arg_29_0:NoSelected() and arg_29_1 == 0 then
		triggerButton = var_6

		var_6(var_29_0._go)
	end

	return
end

function var_0_1.NoSelected(arg_30_0)
	local var_30_0

	if arg_30_0.selected then
		_ = var_1
		var_30_0 = not var_1.any(arg_30_0.disPlays, function(arg_31_0)
			return arg_31_0.id == arg_30_0.selected.id
		end)

		if false then
			var_30_0 = false
		end
	else
		var_30_0 = true
	end

	return var_30_0
end

function var_0_1.OnCardClick(arg_32_0, arg_32_1)
	arg_32_0:UpdateMainPage(arg_32_1.themeVO)

	return
end

function var_0_1.UpdateMainPage(arg_33_0, arg_33_1)
	if arg_33_1 == arg_33_0.card then
		return
	end

	local var_33_0 = arg_33_1
	local var_33_1 = arg_33_1.getConfig(var_33_0, "name")

	string = var_33_0

	local var_33_2 = var_33_0.gsub(var_33_1, "<size=%d+>", "")
	local var_33_3 = arg_33_0.title

	string = var_5
	var_33_3.text = var_5.gsub(var_33_2, "</size>", "")
	arg_33_0.desc.text = arg_33_1:getConfig("desc")

	local var_33_4 = arg_33_1:getConfig("discount")
	local var_33_5 = arg_33_1
	local var_33_6 = arg_33_1.HasDiscount(var_33_5)

	setActive = var_33_5

	var_33_5(arg_33_0.actualPrice, var_33_6)
	arg_33_0:UpdatePrice(arg_33_1)

	local var_33_7 = arg_33_0.largeSpLoader

	var_6.LoadSpriteAsync(var_33_7, "BackYardTheme/theme_" .. arg_33_1.id, function(arg_34_0)
		IsNil = var_2_10001

		if var_2_10001(arg_33_0.preview) then
			return
		end

		arg_33_0.preview.sprite = arg_34_0
		arg_33_0.preview.enabled = true

		return
	end)

	arg_33_0.card = arg_33_1

	return
end

function var_0_1.UpdatePrice(arg_35_0, arg_35_1)
	local var_35_0, var_35_1 = arg_35_0:CalcThemePrice(arg_35_1)

	arg_35_0.actualPriceTxt.text = var_35_1
	arg_35_0.goldTxt.text = var_35_0

	return
end

function var_0_1.GetAddList(arg_36_0, arg_36_1)
	local var_36_0 = {}
	local var_36_1 = arg_36_1:GetFurnitures()
	local var_36_2 = arg_36_0.dorm
	local var_36_3 = var_4.GetPurchasedFurnitures(var_36_2)

	ipairs = var_36_2

	for iter_36_0, iter_36_1 in var_36_2(var_36_1) do
		if not var_36_3[iter_36_1] then
			table = var_10

			local var_36_4 = var_10.insert
			local var_36_5 = var_36_0

			Furniture = var_1_10012

			var_36_4(var_36_5, var_1_10012.New({
				id = iter_36_1
			}))
		end
	end

	return var_36_0
end

function var_0_1.CalcThemePrice(arg_37_0, arg_37_1)
	local var_37_0 = arg_37_0:GetAddList(arg_37_1)
	local var_37_1 = 0
	local var_37_2 = 0

	ipairs = var_1_10005

	for iter_37_0, iter_37_1 in var_1_10005(var_37_0) do
		var_37_2 = var_37_2 + iter_37_1:getConfig("dorm_icon_price")

		local var_37_3 = iter_37_1
		local var_37_4 = iter_37_1.getPrice

		PlayerConst = var_12
		var_37_1 = var_37_1 + var_37_4(var_37_3, var_12.ResDormMoney)
	end

	return var_37_1, var_37_2
end

local function var_0_2(arg_38_0, arg_38_1)
	local var_38_0

	pairs = var_1_10003

	for iter_38_0, iter_38_1 in var_1_10003(arg_38_0) do
		if iter_38_1.themeVO.id == arg_38_1.id then
			var_38_0 = iter_38_1

			break
		end
	end

	return var_38_0
end

local function var_0_3(arg_39_0, arg_39_1, arg_39_2)
	local var_39_0 = arg_39_0:HeadIndexToValue(arg_39_1)
	local var_39_1 = arg_39_0
	local var_39_2 = arg_39_0.HeadIndexToValue(var_39_1, arg_39_2)

	math = var_39_1

	return var_39_1.abs(var_39_2 - var_39_0)
end

function var_0_1.GetSelectedIndex(arg_40_0)
	local var_40_0 = 0

	ipairs = var_1_10002

	for iter_40_0, iter_40_1 in var_1_10002(arg_40_0.disPlays) do
		if iter_40_1.id == arg_40_0.selected.id then
			var_40_0 = iter_40_0

			break
		end
	end

	return var_40_0
end

function var_0_1.OnSwitchToNextTheme(arg_41_0)
	if arg_41_0:GetSelectedIndex() >= #arg_41_0.disPlays then
		return false
	end

	local var_41_0 = arg_41_0.disPlays[var_1 + 1]
	local var_41_1 = var_0_2(arg_41_0.cards, var_41_0)

	local function var_41_2(arg_42_0)
		go = var_2_10001

		local var_42_0 = var_2_10001(arg_41_0.scrollRect).transform.localPosition.x + arg_41_0.scrollRectWidth / 2

		go = var_2

		local var_42_1 = var_2(arg_41_0.scrollRect).transform.parent

		return var_42_0 < var_2.InverseTransformPoint(var_42_1, arg_42_0._tf.position).x
	end

	local var_41_3

	if not var_41_1 or var_41_1 and var_41_2(var_41_1) then
		var_41_3 = var_0_3(arg_41_0.scrollRect, 1, 2)

		local var_41_4 = arg_41_0.scrollRect

		var_6.ScrollTo(var_41_4, arg_41_0.scrollRect.value + var_41_3, true)

		var_41_1 = var_0_2(arg_41_0.cards, var_41_0)
	end

	if var_41_1 then
		triggerButton = var_41_3

		var_41_3(var_41_1._go)
	end

	return true
end

function var_0_1.OnSwitchToPrevTheme(arg_43_0)
	if arg_43_0:GetSelectedIndex() <= 1 then
		return false
	end

	local var_43_0 = arg_43_0.disPlays[var_1 - 1]
	local var_43_1 = var_0_2(arg_43_0.cards, var_43_0)

	local function var_43_2(arg_44_0)
		go = var_2_10001

		local var_44_0 = var_2_10001(arg_43_0.scrollRect).transform.localPosition.x - arg_43_0.scrollRectWidth / 2

		go = var_2

		local var_44_1 = var_2(arg_43_0.scrollRect).transform.parent

		return var_44_0 > var_2.InverseTransformPoint(var_44_1, arg_44_0._tf.position).x
	end

	local var_43_3

	if not var_43_1 or var_43_1 and var_43_2(var_43_1) then
		var_43_3 = var_0_3(arg_43_0.scrollRect, 1, 2)

		local var_43_4 = arg_43_0.scrollRect

		var_6.ScrollTo(var_43_4, arg_43_0.scrollRect.value - var_43_3, true)

		var_43_1 = var_0_2(arg_43_0.cards, var_43_0)
	end

	if var_43_1 then
		triggerButton = var_43_3

		var_43_3(var_43_1._go)
	end

	return true
end

function var_0_1.OnInfoPagePrevTheme(arg_45_0)
	if arg_45_0:OnSwitchToPrevTheme() then
		triggerButton = var_1

		var_1(arg_45_0.purchaseBtn)
	end

	return
end

function var_0_1.OnInfoPageNextTheme(arg_46_0)
	if arg_46_0:OnSwitchToNextTheme() then
		triggerButton = var_1

		var_1(arg_46_0.purchaseBtn)
	end

	return
end

function var_0_1.Hide(arg_47_0)
	var_0_1.super.Hide(arg_47_0)
	arg_47_0:UnBlurView()

	return
end

function var_0_1.BlurView(arg_48_0)
	pg = var_1_10001

	local var_48_0 = var_1_10001.UIMgr.GetInstance()
	local var_48_1 = var_1.OverlayPanel
	local var_48_2 = arg_48_0.adpter
	local var_48_3 = {}
	local var_48_4 = {}
	local var_48_5 = arg_48_0._tf

	var_48_4[1] = var_6.Find(var_48_5, "adpter/descript")
	var_48_3.pbList = var_48_4

	var_48_1(var_48_0, var_48_2, var_48_3)

	return
end

function var_0_1.UnBlurView(arg_49_0)
	pg = var_1_10001

	local var_49_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_49_0, arg_49_0.adpter, arg_49_0._tf)

	return
end

function var_0_1.OnDestroy(arg_50_0)
	if arg_50_0.largeSpLoader then
		local var_50_0 = arg_50_0.largeSpLoader

		var_1.Dispose(var_50_0)

		arg_50_0.largeSpLoader = nil
	end

	local var_50_1

	if arg_50_0.infoPage then
		var_50_1 = arg_50_0.infoPage
		var_50_1.OnExit = nil
		var_50_1 = arg_50_0.infoPage
		var_50_1.OnEnter = nil
		var_50_1 = arg_50_0.infoPage
		var_50_1.OnPrevTheme = nil
		var_50_1 = arg_50_0.infoPage
		var_50_1.OnNextTheme = nil

		local var_50_2 = arg_50_0.infoPage

		var_50_1.Destroy(var_50_2)
	end

	pairs = var_50_1

	local var_50_3

	if not arg_50_0.cards then
		var_50_3 = {}
	end

	for iter_50_0, iter_50_1 in var_50_1(var_50_3) do
		iter_50_1:Dispose()
	end

	arg_50_0.cards = nil

	arg_50_0:Hide()

	return
end

return var_0_1
