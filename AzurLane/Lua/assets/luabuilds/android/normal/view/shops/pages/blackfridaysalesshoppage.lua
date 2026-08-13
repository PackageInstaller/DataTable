class = var_0_10000

local var_0_0 = "BlackFridaySalesShopPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "BlackFridaySalesShopPage"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_1.Find(var_2_0, "scrollView")

	arg_2_0.scrollrect = var_1.GetComponent(var_2_1, "LScrollRect")

	local var_2_2 = arg_2_0._tf
	local var_2_3 = var_1.Find(var_2_2, "res_pt/Text")
	local var_2_4 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.resTxt = var_2_4(var_2_3, var_3(var_1_10004))

	local var_2_5 = arg_2_0._tf

	arg_2_0.resIcon = var_1.Find(var_2_5, "res_pt/icon")

	local var_2_6 = {}
	local var_2_7 = arg_2_0._tf

	var_2_6[1] = var_2.Find(var_2_7, "pagefooter/ptShop")

	local var_2_8 = arg_2_0._tf

	var_2_6[2] = var_2.Find(var_2_8, "pagefooter/gemShop")

	local var_2_9 = arg_2_0._tf

	var_2_6[3] = var_2.Find(var_2_9, "pagefooter/coinShop")
	arg_2_0.pagefooters = var_2_6
	setText = var_2_6

	local var_2_10 = arg_2_0._tf
	local var_2_11 = var_2.Find(var_2_10, "pagefooter/coinShop/Text")

	i18n = var_2_10

	var_2_6(var_2_11, var_2_10("blackfriday_coinshop"))

	setText = var_2_6

	local var_2_12 = arg_2_0._tf
	local var_2_13 = var_2.Find(var_2_12, "pagefooter/coinShop/mark")

	i18n = var_2_12

	var_2_6(var_2_13, var_2_12("blackfriday_coinshop"))

	setText = var_2_6

	local var_2_14 = arg_2_0._tf
	local var_2_15 = var_2.Find(var_2_14, "pagefooter/gemShop/Text")

	i18n = var_2_14

	var_2_6(var_2_15, var_2_14("blackfriday_gemshop"))

	setText = var_2_6

	local var_2_16 = arg_2_0._tf
	local var_2_17 = var_2.Find(var_2_16, "pagefooter/gemShop/mark")

	i18n = var_2_16

	var_2_6(var_2_17, var_2_16("blackfriday_gemshop"))

	setText = var_2_6

	local var_2_18 = arg_2_0._tf
	local var_2_19 = var_2.Find(var_2_18, "pagefooter/ptShop/Text")

	i18n = var_2_18

	var_2_6(var_2_19, var_2_18("blackfriday_ptshop"))

	setText = var_2_6

	local var_2_20 = arg_2_0._tf
	local var_2_21 = var_2.Find(var_2_20, "pagefooter/ptShop/mark")

	i18n = var_2_20

	var_2_6(var_2_21, var_2_20("blackfriday_ptshop"))

	local var_2_22 = {}
	local var_2_23 = arg_2_0._tf

	var_2_22[1] = var_2.Find(var_2_23, "res_pt/icon_pt")

	local var_2_24 = arg_2_0._tf

	var_2_22[2] = var_2.Find(var_2_24, "res_pt/icon_gem")

	local var_2_25 = arg_2_0._tf

	var_2_22[3] = var_2.Find(var_2_25, "res_pt/icon_coin")
	arg_2_0.ress = var_2_22

	local var_2_26 = arg_2_0._tf

	arg_2_0.resText = var_1.Find(var_2_26, "res_pt/Text")
	arg_2_0.pagefooterWid = arg_2_0.pagefooters[1].rect.width
	arg_2_0.pagefooterStartPosX = arg_2_0.pagefooters[1].anchoredPosition.x
	BlackFridayServerShopPurchasePanel = var_1
	arg_2_0.purchasePage = var_1.New(arg_2_0._tf, arg_2_0.event, arg_2_0.contextData)
	NewServerShopMultiWindow = var_1
	arg_2_0.multiWindow = var_1.New(arg_2_0._tf, arg_2_0.event)
	NewServerShopSingleWindow = var_1
	arg_2_0.singleWindow = var_1.New(arg_2_0._tf, arg_2_0.event)

	local var_2_27 = arg_2_0._tf

	Vector3 = var_2
	var_2_27.localPosition = var_2(-6, -25)

	return
end

function var_0_1.UpdateRes(arg_3_0)
	local var_3_0

	if not arg_3_0.openIndex then
		var_3_0 = 1
	end

	local var_3_1 = arg_3_0.shop
	local var_3_2 = var_2.GetResID(var_3_1, var_3_0)

	getProxy = var_3_1
	PlayerProxy = var_4

	local var_3_3 = var_3_1(var_4)
	local var_3_4 = var_3.getRawData(var_3_3)
	local var_3_5 = var_3.getResource(var_3_4, var_3_2)

	arg_3_0.resTxt.text = var_3_5

	if not arg_3_0.isInitResIcon then
		arg_3_0.isInitResIcon = true
		GetImageSpriteFromAtlasAsync = var_5
		Drop = var_6

		local var_3_6 = var_6.New
		local var_3_7 = {}

		DROP_TYPE_RESOURCE = var_1_10008
		var_3_7.type = var_1_10008
		var_3_7.id = var_3_2

		local var_3_8 = var_3_6(var_3_7)

		var_5(var_6.getIcon(var_3_8), "", arg_3_0.resIcon)
	end

	return
end

function var_0_1.OnInit(arg_4_0)
	arg_4_0.cards = {}

	function arg_4_0.scrollrect.onInitItem(arg_5_0)
		local var_5_0 = arg_4_0

		var_1.OnInitItem(var_5_0, arg_5_0)

		return
	end

	function arg_4_0.scrollrect.onUpdateItem(arg_6_0, arg_6_1)
		local var_6_0 = arg_4_0

		var_2.OnUpdateItem(var_6_0, arg_6_0, arg_6_1)

		return
	end

	arg_4_0:Flush()

	return
end

function var_0_1.OnInitItem(arg_7_0, arg_7_1)
	BlackFridayGoodsCard = var_1_10002

	local var_7_0 = var_1_10002.New(arg_7_1)

	onButton = var_3

	local var_7_1 = arg_7_0
	local var_7_2 = var_7_0._tf

	local function var_7_3()
		local var_8_0 = arg_7_0

		var_0.OnClickCard(var_8_0, var_7_0)

		return
	end

	SFX_PANEL = var_1_10007

	var_3(var_7_1, var_7_2, var_7_3, var_1_10007)

	arg_7_0.cards[arg_7_1] = var_7_0

	return
end

function var_0_1.OnClickCard(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1.commodity

	if var_2.Selectable(var_9_0) then
		local var_9_1 = arg_9_0.purchasePage

		var_3.ExecuteAction(var_9_1, "Show", var_2)
	else
		local var_9_2

		if var_2:getConfig("goods_purchase_limit") == 1 or var_2:getConfig("type") == 4 then
			var_9_2 = arg_9_0.singleWindow
		else
			var_9_2 = arg_9_0.multiWindow
		end

		var_9_2:ExecuteAction("Open", var_2, function(arg_10_0, arg_10_1, arg_10_2)
			local var_10_1

			if not arg_10_0:CanPurchase() then
				pg = var_10_1

				local var_10_0 = var_10_1.TipsMgr.GetInstance()

				var_10_1 = var_10_1.ShowTips
				i18n = var_2_10005

				var_10_1(var_10_0, var_2_10005("buy_countLimit"))

				return
			end

			pg = var_10_1

			local var_10_2 = var_10_1.m02
			local var_10_3 = var_3.sendNotification

			GAME = var_2_10005

			local var_10_4 = var_2_10005.NEW_SERVER_SHOP_SHOPPING
			local var_10_5 = {}

			ActivityConst = var_2_10007
			var_10_5.actType = var_2_10007.ACTIVITY_TYPE_BLACK_FRIDAY_SHOP
			var_10_5.id = arg_10_0.id
			var_10_5.selectedList = arg_10_0:getConfig("goods")
			var_10_5.count = arg_10_1

			var_10_3(var_10_2, var_10_4, var_10_5)

			return
		end)
	end

	return
end

function var_0_1.OnUpdateItem(arg_11_0, arg_11_1, arg_11_2)
	if not arg_11_0.cards[arg_11_2] then
		arg_11_0:OnInitItem(arg_11_2)
	end

	local var_11_0 = arg_11_0.cards[arg_11_2]
	local var_11_1 = arg_11_0.displays[arg_11_1 + 1]

	var_11_0:Update(var_11_1, arg_11_0.shop)

	return
end

function var_0_1.FetchShop(arg_12_0, arg_12_1)
	getProxy = var_1_10002
	ShopsProxy = var_1_10003

	local var_12_0 = var_1_10002(var_1_10003)
	local var_12_1 = var_2.GetNewServerShop

	ActivityConst = var_1_10004

	if not var_12_1(var_12_0, var_1_10004.ACTIVITY_TYPE_BLACK_FRIDAY_SHOP) then
		pg = var_12_0

		local var_12_2 = var_12_0.m02
		local var_12_3 = var_3.sendNotification

		GAME = var_1_10005

		var_12_3(var_12_2, var_1_10005.GET_NEW_SERVER_SHOP, {
			callback = arg_12_1
		})
	else
		arg_12_1(var_2)
	end

	return
end

function var_0_1.SetShop(arg_13_0, arg_13_1)
	arg_13_0.shop = arg_13_1

	return
end

function var_0_1.Flush(arg_14_0)
	if arg_14_0.shop then
		arg_14_0:Show()
		arg_14_0:UpdatePageFooters()
		arg_14_0:UpdateRes()
	else
		arg_14_0:FetchShop(function(arg_15_0)
			if not arg_15_0 then
				return
			end

			arg_14_0.shop = arg_15_0

			local var_15_0 = arg_14_0

			var_1.Show(var_15_0)

			local var_15_1 = arg_14_0

			var_1.UpdatePageFooters(var_15_1)

			local var_15_2 = arg_14_0

			var_1.UpdateRes(var_15_2)

			return
		end)
	end

	return
end

function var_0_1.UpdatePageFooters(arg_16_0)
	local var_16_0 = arg_16_0.shop
	local var_16_1 = var_1.GetTabCount(var_16_0)

	arg_16_0.pagefooterTrs = {}

	for iter_16_0 = 1, var_16_1 do
		local var_16_2 = arg_16_0.pagefooters[iter_16_0]

		arg_16_0:UpdatePageFooter(var_16_2, iter_16_0)

		arg_16_0.pagefooterTrs[iter_16_0] = var_16_2
	end

	local var_16_3

	if not arg_16_0.contextData.index then
		var_16_3 = 1
	end

	triggerButton = var_4

	var_4(arg_16_0.pagefooterTrs[var_16_3])

	return
end

local var_0_2 = 0

function var_0_1.UpdatePageFooter(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_0.pagefooterStartPosX + (var_0_2 + arg_17_0.pagefooterWid) * (arg_17_2 - 1)

	setAnchoredPosition = var_4

	var_4(arg_17_1, {
		x = var_17_0
	})
	arg_17_0:OnSwitch(arg_17_1, function()
		local var_18_0 = arg_17_0

		var_0.SwitchTab(var_18_0, arg_17_2)

		return
	end)

	return
end

function var_0_1.OnSwitch(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = arg_19_1:Find("mark")

	local function var_19_1()
		if arg_19_0.markTr then
			setActive = var_0

			var_0(arg_19_0.markTr, false)
		end

		local var_20_0 = arg_19_0

		var_20_0.markTr = var_19_0
		setActive = var_20_0

		var_20_0(var_19_0, true)

		return
	end

	onButton = var_5

	local var_19_2 = arg_19_0
	local var_19_3 = arg_19_1

	local function var_19_4()
		var_19_1()
		arg_19_2()

		return
	end

	SFX_PANEL = var_1_10009

	var_5(var_19_2, var_19_3, var_19_4, var_1_10009)

	return
end

function var_0_1.SwitchTab(arg_22_0, arg_22_1)
	arg_22_0.openIndex = arg_22_1

	if arg_22_0.resTF then
		setActive = var_2

		var_2(arg_22_0.resTF, false)
	end

	arg_22_0.resTF = arg_22_0.ress[arg_22_1]
	setActive = var_2

	var_2(arg_22_0.resTF, true)
	arg_22_0:UpdateRes()

	local var_22_0 = arg_22_0.shop
	local var_22_1 = var_2.GetGoodsByTabs(var_22_0, arg_22_1)
	local var_22_2 = arg_22_0.shop

	if var_4.GetTabCount(var_22_2) <= 1 then
		setActive = var_4

		local var_22_3 = arg_22_0._tf

		var_4(var_5.Find(var_22_3, "pagefooter"), false)
	end

	arg_22_0.displays = var_22_1
	table = var_4

	var_4.sort(arg_22_0.displays, function(arg_23_0, arg_23_1)
		return arg_23_0.id < arg_23_1.id
	end)

	local var_22_4 = arg_22_0.scrollrect

	var_4.SetTotalCount(var_22_4, #arg_22_0.displays)

	return
end

function var_0_1.Refresh(arg_24_0)
	arg_24_0:SwitchTab(arg_24_0.openIndex)
	arg_24_0:UpdateRes()

	return
end

function var_0_1.updateLocalRedDotData(arg_25_0, arg_25_1)
	if arg_25_0:isPhaseTip(arg_25_1) then
		PlayerPrefs = var_2

		var_2.SetInt("newserver_shop_phase_" .. arg_25_1 .. "_" .. arg_25_0.playerId, 1)

		local var_25_0 = arg_25_0
		local var_25_1 = arg_25_0.emit

		NewServerCarnivalMediator = var_4

		var_25_1(var_25_0, var_4.UPDATE_SHOP_RED_DOT)
	end

	return
end

function var_0_1.isTip(arg_26_0)
	return false
end

function var_0_1.OnDestroy(arg_27_0)
	arg_27_0.scrollrect.onInitItem = nil

	local var_27_0 = arg_27_0.scrollrect

	var_27_0.onUpdateItem = nil
	pairs = var_27_0

	for iter_27_0, iter_27_1 in var_27_0(arg_27_0.cards) do
		iter_27_1:Dispose()
	end

	arg_27_0.cards = nil

	local var_27_1 = arg_27_0.purchasePage

	var_1.Destroy(var_27_1)

	arg_27_0.purchasePage = nil

	local var_27_2 = arg_27_0.multiWindow

	var_1.Destroy(var_27_2)

	arg_27_0.multiWindow = nil

	local var_27_3 = arg_27_0.singleWindow

	var_1.Destroy(var_27_3)

	arg_27_0.singleWindow = nil

	var_0_1.super.OnDestroy(arg_27_0)

	return
end

return var_0_1
