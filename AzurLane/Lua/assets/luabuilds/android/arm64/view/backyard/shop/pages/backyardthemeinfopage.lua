class = var_0_10000

local var_0_0 = "BackYardThemeInfoPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("....base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "BackYardThemeInfoPage"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_1.Find(var_2_0, "frame/list")

	arg_2_0.scrollRect = var_1.GetComponent(var_2_1, "LScrollRect")

	local var_2_2 = arg_2_0._tf
	local var_2_3 = var_1.Find(var_2_2, "frame/name")
	local var_2_4 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.nameTxt = var_2_4(var_2_3, var_4(var_1_10006))

	local var_2_5 = arg_2_0._tf
	local var_2_6 = var_1.Find(var_2_5, "frame/icon/Image")
	local var_2_7 = var_1.GetComponent

	typeof = var_4
	Image = var_1_10006
	arg_2_0.icon = var_2_7(var_2_6, var_4(var_1_10006))

	local var_2_8 = arg_2_0._tf
	local var_2_9 = var_1.Find(var_2_8, "frame/desc")
	local var_2_10 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.desc = var_2_10(var_2_9, var_4(var_1_10006))

	local var_2_11 = arg_2_0._tf

	arg_2_0.backBtn = var_1.Find(var_2_11, "frame/back")

	local var_2_12 = arg_2_0._tf

	arg_2_0.leftArrBtn = var_1.Find(var_2_12, "arr_left")

	local var_2_13 = arg_2_0._tf

	arg_2_0.rightArrBtn = var_1.Find(var_2_13, "arr_right")

	local var_2_14 = arg_2_0._tf
	local var_2_15 = var_1.Find(var_2_14, "res_gem/Text")
	local var_2_16 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.gemTxt = var_2_16(var_2_15, var_4(var_1_10006))

	local var_2_17 = arg_2_0._tf
	local var_2_18 = var_1.Find(var_2_17, "res_gold/Text")
	local var_2_19 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.goldTxt = var_2_19(var_2_18, var_4(var_1_10006))

	local var_2_20 = arg_2_0._tf

	arg_2_0.gemAddBtn = var_1.Find(var_2_20, "res_gem/jiahao")

	local var_2_21 = arg_2_0._tf

	arg_2_0.goldAddBtn = var_1.Find(var_2_21, "res_gold/jiahao")

	local var_2_22 = arg_2_0._tf

	arg_2_0.purchaseBtn = var_1.Find(var_2_22, "frame/purchase_btn")

	local var_2_23 = arg_2_0._tf

	arg_2_0.purchaseAllBtn = var_1.Find(var_2_23, "frame/purchase_all_btn")
	setText = var_1

	local var_2_24 = arg_2_0.purchaseBtn
	local var_2_25 = var_3.Find(var_2_24, "Text")

	i18n = var_4

	var_1(var_2_25, var_4("fur_onekey_buy"))

	setText = var_1

	local var_2_26 = arg_2_0.purchaseAllBtn
	local var_2_27 = var_3.Find(var_2_26, "Text")

	i18n = var_4

	var_1(var_2_27, var_4("fur_all_buy"))

	return
end

function var_0_1.OnInit(arg_3_0)
	arg_3_0.cards = {}

	function arg_3_0.scrollRect.onInitItem(arg_4_0)
		local var_4_0 = arg_3_0

		var_1.OnInitCard(var_4_0, arg_4_0)

		return
	end

	local var_3_0 = arg_3_0.scrollRect

	function var_3_0.onUpdateItem(arg_5_0, arg_5_1)
		local var_5_0 = arg_3_0

		var_2.OnUpdateCard(var_5_0, arg_5_0, arg_5_1)

		return
	end

	onButton = var_3_0

	local var_3_1 = arg_3_0
	local var_3_2 = arg_3_0.backBtn

	local function var_3_3()
		local var_6_0 = arg_3_0

		var_0.Hide(var_6_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_3_0(var_3_1, var_3_2, var_3_3, var_1_10006)

	onButton = var_3_0

	local var_3_4 = arg_3_0
	local var_3_5 = arg_3_0._tf

	local function var_3_6()
		local var_7_0 = arg_3_0

		var_0.Hide(var_7_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_3_0(var_3_4, var_3_5, var_3_6, var_1_10006)

	onButton = var_3_0

	local var_3_7 = arg_3_0
	local var_3_8 = arg_3_0.purchaseBtn

	local function var_3_9()
		local var_8_0 = arg_3_0.contextData.themeMsgBox

		var_0.ExecuteAction(var_8_0, "SetUp", arg_3_0.themeVO, arg_3_0.dorm, arg_3_0.player)

		return
	end

	SFX_PANEL = var_1_10006

	var_3_0(var_3_7, var_3_8, var_3_9, var_1_10006)

	onButton = var_3_0

	local var_3_10 = arg_3_0
	local var_3_11 = arg_3_0.purchaseAllBtn

	local function var_3_12()
		local var_9_0 = arg_3_0.contextData.themeAllMsgBox

		var_0.ExecuteAction(var_9_0, "SetUp", arg_3_0.themeVO, arg_3_0.dorm, arg_3_0.player)

		return
	end

	SFX_PANEL = var_1_10006

	var_3_0(var_3_10, var_3_11, var_3_12, var_1_10006)

	onButton = var_3_0

	local var_3_13 = arg_3_0
	local var_3_14 = arg_3_0.leftArrBtn

	local function var_3_15()
		if arg_3_0.OnPrevTheme then
			arg_3_0.OnPrevTheme()
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_3_0(var_3_13, var_3_14, var_3_15, var_1_10006)

	onButton = var_3_0

	local var_3_16 = arg_3_0
	local var_3_17 = arg_3_0.rightArrBtn

	local function var_3_18()
		if arg_3_0.OnNextTheme then
			arg_3_0.OnNextTheme()
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_3_0(var_3_16, var_3_17, var_3_18, var_1_10006)

	onButton = var_3_0

	local var_3_19 = arg_3_0
	local var_3_20 = arg_3_0.goldAddBtn

	local function var_3_21()
		local var_12_0 = arg_3_0
		local var_12_1 = var_0.emit

		NewBackYardShopMediator = var_2_10003

		local var_12_2 = var_2_10003.ON_CHARGE

		PlayerConst = var_2_10004

		var_12_1(var_12_0, var_12_2, var_2_10004.ResDormMoney)

		return
	end

	SFX_PANEL = var_1_10006

	var_3_0(var_3_19, var_3_20, var_3_21, var_1_10006)

	onButton = var_3_0

	local var_3_22 = arg_3_0
	local var_3_23 = arg_3_0.gemAddBtn

	local function var_3_24()
		local var_13_0 = arg_3_0
		local var_13_1 = var_0.emit

		NewBackYardShopMediator = var_2_10003

		local var_13_2 = var_2_10003.ON_CHARGE

		PlayerConst = var_2_10004

		var_13_1(var_13_0, var_13_2, var_2_10004.ResDiamond)

		return
	end

	SFX_PANEL = var_1_10006

	var_3_0(var_3_22, var_3_23, var_3_24, var_1_10006)

	return
end

function var_0_1.OnPlayerUpdated(arg_14_0, arg_14_1)
	arg_14_0.player = arg_14_1

	arg_14_0:UpdateRes()

	return
end

function var_0_1.DormUpdated(arg_15_0, arg_15_1)
	arg_15_0.dorm = arg_15_1

	return
end

function var_0_1.FurnituresUpdated(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0.dorm
	local var_16_1 = var_2.GetPurchasedFurnitures(var_16_0)

	ipairs = var_1_10003

	for iter_16_0, iter_16_1 in var_1_10003(arg_16_1) do
		local var_16_2 = var_16_1[iter_16_1]

		arg_16_0:OnDisplayUpdated(var_16_2)
		arg_16_0:OnCardUpdated(var_16_2)
	end

	arg_16_0:UpdatePurchaseBtn()

	return
end

function var_0_1.OnDisplayUpdated(arg_17_0, arg_17_1)
	ipairs = var_1_10002

	for iter_17_0, iter_17_1 in var_1_10002(arg_17_0.displays) do
		if iter_17_1.id == arg_17_1.id then
			arg_17_0.displays[iter_17_0] = arg_17_1
		end
	end

	return
end

function var_0_1.OnCardUpdated(arg_18_0, arg_18_1)
	pairs = var_1_10002

	for iter_18_0, iter_18_1 in var_1_10002(arg_18_0.cards) do
		if iter_18_1.furniture.id == arg_18_1.id then
			iter_18_1:Update(arg_18_1)
		end
	end

	return
end

function var_0_1.SetUp(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4)
	arg_19_0:Show()

	arg_19_0.index = arg_19_1
	arg_19_0.dorm = arg_19_3
	arg_19_0.themeVO = arg_19_2
	arg_19_0.player = arg_19_4

	arg_19_0:InitFurnitureList()
	arg_19_0:UpdateThemeInfo()
	arg_19_0:UpdateRes()

	return
end

function var_0_1.UpdateRes(arg_20_0)
	local var_20_0 = arg_20_0.gemTxt
	local var_20_1 = arg_20_0.player

	var_20_0.text = var_2.getTotalGem(var_20_1)

	local var_20_2 = arg_20_0.goldTxt
	local var_20_3 = arg_20_0.player
	local var_20_4 = var_2.getResource

	PlayerConst = var_1_10005
	var_20_2.text = var_20_4(var_20_3, var_1_10005.ResDormMoney)

	return
end

function var_0_1.InitFurnitureList(arg_21_0)
	local var_21_0 = arg_21_0.themeVO
	local var_21_1 = var_1.GetFurnitures(var_21_0)
	local var_21_2 = arg_21_0.dorm
	local var_21_3 = var_2.GetPurchasedFurnitures(var_21_2)

	arg_21_0.displays = {}
	ipairs = var_3

	for iter_21_0, iter_21_1 in var_3(var_21_1) do
		local var_21_4

		if not var_21_3[iter_21_1] then
			Furniture = var_1_10009
			var_21_4 = var_1_10009.New({
				id = iter_21_1
			})
		end

		table = var_1_10009

		var_1_10009.insert(arg_21_0.displays, var_21_4)
	end

	table = var_3

	var_3.sort(arg_21_0.displays, function(arg_22_0, arg_22_1)
		if (arg_22_0:canPurchase() and 1 or 0) == (arg_22_1:canPurchase() and 1 or 0) then
			return arg_22_0.id < arg_22_1.id
		else
			return var_3 < var_2
		end

		return
	end)

	local var_21_5 = arg_21_0.scrollRect

	var_3.SetTotalCount(var_21_5, #arg_21_0.displays)

	return
end

function var_0_1.OnInitCard(arg_23_0, arg_23_1)
	BackYardFurnitureCard = var_1_10002

	local var_23_0 = var_1_10002.New(arg_23_1)

	onButton = var_1_10003

	local var_23_1 = arg_23_0
	local var_23_2 = var_23_0._go

	local function var_23_3()
		local var_24_0 = var_23_0.furniture

		if var_0.canPurchase(var_24_0) then
			local var_24_1 = arg_23_0.contextData.furnitureMsgBox

			var_0.ExecuteAction(var_24_1, "SetUp", var_23_0.furniture, arg_23_0.dorm, arg_23_0.player)
		end

		return
	end

	SFX_PANEL = var_1_10008

	var_1_10003(var_23_1, var_23_2, var_23_3, var_1_10008)

	arg_23_0.cards[arg_23_1] = var_23_0

	return
end

function var_0_1.OnUpdateCard(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0

	if not arg_25_0.cards[arg_25_2] then
		arg_25_0:OnInitCard(arg_25_2)

		var_25_0 = arg_25_0.cards[arg_25_2]
	end

	local var_25_1 = arg_25_0.displays[arg_25_1 + 1]

	var_25_0:Update(var_25_1)

	return
end

function var_0_1.UpdateThemeInfo(arg_26_0)
	local var_26_0 = arg_26_0.themeVO
	local var_26_1 = arg_26_0.nameTxt

	HXSet = var_1_10003
	var_26_1.text = var_1_10003.hxLan(var_26_0:getConfig("name"))
	GetSpriteFromAtlasAsync = var_26_1

	var_26_1("BackYardTheme/theme_" .. var_26_0.id, "", function(arg_27_0)
		IsNil = var_2_10001

		if var_2_10001(arg_26_0.icon) then
			return
		end

		arg_26_0.icon.sprite = arg_27_0

		return
	end)

	local var_26_2 = arg_26_0.icon

	var_2.SetNativeSize(var_26_2)

	local var_26_3 = arg_26_0.desc

	HXSet = var_3
	var_26_3.text = var_3.hxLan(var_26_0:getConfig("desc"))

	arg_26_0:UpdatePurchaseBtn()

	return
end

function var_0_1.UpdatePurchaseBtn(arg_28_0)
	local var_28_0 = arg_28_0.themeVO
	local var_28_1 = var_1.GetFurnitures(var_28_0)
	local var_28_2 = arg_28_0.dorm
	local var_28_3 = var_2.GetPurchasedFurnitures(var_28_2)

	_ = var_28_0

	local var_28_4 = var_28_0.any(var_28_1, function(arg_29_0)
		return not var_28_3[arg_29_0]
	end)

	setActive = var_28_2

	var_28_2(arg_28_0.purchaseBtn, var_28_4)

	_ = var_28_2

	local var_28_5 = var_28_2.any(var_28_1, function(arg_30_0)
		local var_30_0 = arg_28_0.dorm
		local var_30_1 = var_1.GetOwnFurnitureCount(var_30_0, arg_30_0)

		pg = var_2_10002

		return var_30_1 < var_2_10002.furniture_data_template[arg_30_0].count
	end)

	setActive = var_5

	var_5(arg_28_0.purchaseAllBtn, var_28_5)

	return
end

function var_0_1.Show(arg_31_0)
	var_0_1.super.Show(arg_31_0)

	pg = var_1

	local var_31_0 = var_1.UIMgr.GetInstance()

	var_1.OverlayPanel(var_31_0, arg_31_0._tf)

	if arg_31_0.OnEnter then
		arg_31_0.OnEnter()
	end

	return
end

function var_0_1.Hide(arg_32_0)
	var_0_1.super.Hide(arg_32_0)

	pg = var_1

	local var_32_0 = var_1.UIMgr.GetInstance()
	local var_32_1 = var_1.UnOverlayPanel
	local var_32_2 = arg_32_0._tf

	pg = var_1_10005

	var_32_1(var_32_0, var_32_2, var_1_10005.UIMgr.GetInstance().UIMain)

	if arg_32_0.OnExit then
		arg_32_0.OnExit()
	end

	return
end

function var_0_1.OnDestroy(arg_33_0)
	arg_33_0:Hide()

	pairs = var_1

	for iter_33_0, iter_33_1 in var_1(arg_33_0.cards) do
		iter_33_1:Clear()
	end

	return
end

return var_0_1
