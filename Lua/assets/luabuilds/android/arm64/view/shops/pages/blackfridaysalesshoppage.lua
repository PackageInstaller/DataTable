local var_0_0 = class("BlackFridaySalesShopPage", import("...base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "BlackFridaySalesShopPage"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.scrollrect = arg_2_0._tf:Find("scrollView"):GetComponent("LScrollRect")
	arg_2_0.resTxt = arg_2_0._tf:Find("res_pt/Text"):GetComponent(typeof(Text))
	arg_2_0.resIcon = arg_2_0._tf:Find("res_pt/icon")
	arg_2_0.pagefooters = {
		arg_2_0._tf:Find("pagefooter/ptShop"),
		arg_2_0._tf:Find("pagefooter/gemShop"),
		arg_2_0._tf:Find("pagefooter/coinShop")
	}

	setText(arg_2_0._tf:Find("pagefooter/coinShop/Text"), i18n("blackfriday_coinshop"))
	setText(arg_2_0._tf:Find("pagefooter/coinShop/mark"), i18n("blackfriday_coinshop"))
	setText(arg_2_0._tf:Find("pagefooter/gemShop/Text"), i18n("blackfriday_gemshop"))
	setText(arg_2_0._tf:Find("pagefooter/gemShop/mark"), i18n("blackfriday_gemshop"))
	setText(arg_2_0._tf:Find("pagefooter/ptShop/Text"), i18n("blackfriday_ptshop"))
	setText(arg_2_0._tf:Find("pagefooter/ptShop/mark"), i18n("blackfriday_ptshop"))

	arg_2_0.ress = {
		arg_2_0._tf:Find("res_pt/icon_pt"),
		arg_2_0._tf:Find("res_pt/icon_gem"),
		arg_2_0._tf:Find("res_pt/icon_coin")
	}
	arg_2_0.resText = arg_2_0._tf:Find("res_pt/Text")
	arg_2_0.pagefooterWid = arg_2_0.pagefooters[1].rect.width
	arg_2_0.pagefooterStartPosX = arg_2_0.pagefooters[1].anchoredPosition.x
	arg_2_0.purchasePage = BlackFridayServerShopPurchasePanel.New(arg_2_0._tf, arg_2_0.event, arg_2_0.contextData)
	arg_2_0.multiWindow = NewServerShopMultiWindow.New(arg_2_0._tf, arg_2_0.event)
	arg_2_0.singleWindow = NewServerShopSingleWindow.New(arg_2_0._tf, arg_2_0.event)
	arg_2_0._tf.localPosition = Vector3(-6, -25)

	return
end

function var_0_0.UpdateRes(arg_3_0)
	local var_3_0 = arg_3_0.openIndex or 1
	local var_3_1 = arg_3_0.shop:GetResID(var_3_0)

	arg_3_0.resTxt.text = getProxy(PlayerProxy):getRawData():getResource(var_3_1)

	if not arg_3_0.isInitResIcon then
		arg_3_0.isInitResIcon = true

		GetImageSpriteFromAtlasAsync(Drop.New({
			type = DROP_TYPE_RESOURCE,
			id = var_3_1
		}):getIcon(), "", arg_3_0.resIcon)
	end

	return
end

function var_0_0.OnInit(arg_4_0)
	arg_4_0.cards = {}

	function arg_4_0.scrollrect.onInitItem(arg_5_0)
		arg_4_0:OnInitItem(arg_5_0)

		return
	end

	function arg_4_0.scrollrect.onUpdateItem(arg_6_0, arg_6_1)
		arg_4_0:OnUpdateItem(arg_6_0, arg_6_1)

		return
	end

	arg_4_0:Flush()

	return
end

function var_0_0.OnInitItem(arg_7_0, arg_7_1)
	local var_7_0 = BlackFridayGoodsCard.New(arg_7_1)

	onButton(arg_7_0, var_7_0._tf, function()
		arg_7_0:OnClickCard(var_7_0)

		return
	end, SFX_PANEL)

	arg_7_0.cards[arg_7_1] = var_7_0

	return
end

function var_0_0.OnClickCard(arg_9_0, arg_9_1)
	if arg_9_1.commodity:Selectable() then
		arg_9_0.purchasePage:ExecuteAction("Show", arg_9_1.commodity)
	else
		((arg_9_1.commodity:getConfig("goods_purchase_limit") == 1 or arg_9_1.commodity:getConfig("type") == 4) and arg_9_0.singleWindow or arg_9_0.multiWindow):ExecuteAction("Open", arg_9_1.commodity, function(arg_10_0, arg_10_1, arg_10_2)
			if not arg_10_0:CanPurchase() then
				pg.TipsMgr.GetInstance():ShowTips(i18n("buy_countLimit"))

				return
			end

			pg.m02:sendNotification(GAME.NEW_SERVER_SHOP_SHOPPING, {
				actType = ActivityConst.ACTIVITY_TYPE_BLACK_FRIDAY_SHOP,
				id = arg_10_0.id,
				selectedList = arg_10_0:getConfig("goods"),
				count = arg_10_1
			})

			return
		end)
	end

	return
end

function var_0_0.OnUpdateItem(arg_11_0, arg_11_1, arg_11_2)
	if not arg_11_0.cards[arg_11_2] then
		arg_11_0:OnInitItem(arg_11_2)
	end

	arg_11_0.cards[arg_11_2]:Update(arg_11_0.displays[arg_11_1 + 1], arg_11_0.shop)

	return
end

function var_0_0.FetchShop(arg_12_0, arg_12_1)
	local var_12_0 = getProxy(ShopsProxy):GetNewServerShop(ActivityConst.ACTIVITY_TYPE_BLACK_FRIDAY_SHOP)

	if not var_12_0 then
		pg.m02:sendNotification(GAME.GET_NEW_SERVER_SHOP, {
			callback = arg_12_1
		})
	else
		arg_12_1(var_12_0)
	end

	return
end

function var_0_0.SetShop(arg_13_0, arg_13_1)
	arg_13_0.shop = arg_13_1

	return
end

function var_0_0.Flush(arg_14_0)
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

			arg_14_0:Show()
			arg_14_0:UpdatePageFooters()
			arg_14_0:UpdateRes()

			return
		end)
	end

	return
end

function var_0_0.UpdatePageFooters(arg_16_0)
	arg_16_0.pagefooterTrs = {}

	for iter_16_0 = 1, arg_16_0.shop:GetTabCount() do
		arg_16_0:UpdatePageFooter(arg_16_0.pagefooters[iter_16_0], iter_16_0)

		arg_16_0.pagefooterTrs[iter_16_0] = arg_16_0.pagefooters[iter_16_0]
	end

	local var_16_0 = arg_16_0.contextData.index or 1

	triggerButton(arg_16_0.pagefooterTrs[var_16_0])

	return
end

local var_0_1 = 0

function var_0_0.UpdatePageFooter(arg_17_0, arg_17_1, arg_17_2)
	setAnchoredPosition(arg_17_1, {
		x = arg_17_0.pagefooterStartPosX + (var_0_1 + arg_17_0.pagefooterWid) * (arg_17_2 - 1)
	})
	arg_17_0:OnSwitch(arg_17_1, function()
		arg_17_0:SwitchTab(arg_17_2)

		return
	end)

	return
end

function var_0_0.OnSwitch(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = arg_19_1:Find("mark")

	local function var_19_1()
		if arg_19_0.markTr then
			setActive(arg_19_0.markTr, false)
		end

		arg_19_0.markTr = var_19_0

		setActive(var_19_0, true)

		return
	end

	onButton(arg_19_0, arg_19_1, function()
		var_19_1()
		arg_19_2()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.SwitchTab(arg_22_0, arg_22_1)
	arg_22_0.openIndex = arg_22_1

	if arg_22_0.resTF then
		setActive(arg_22_0.resTF, false)
	end

	arg_22_0.resTF = arg_22_0.ress[arg_22_1]

	setActive(arg_22_0.resTF, true)
	arg_22_0:UpdateRes()

	if arg_22_0.shop:GetTabCount() <= 1 then
		setActive(arg_22_0._tf:Find("pagefooter"), false)
	end

	arg_22_0.displays = arg_22_0.shop:GetGoodsByTabs(arg_22_1)

	table.sort(arg_22_0.displays, function(arg_23_0, arg_23_1)
		return arg_23_0.id < arg_23_1.id
	end)
	arg_22_0.scrollrect:SetTotalCount(#arg_22_0.displays)

	return
end

function var_0_0.Refresh(arg_24_0)
	arg_24_0:SwitchTab(arg_24_0.openIndex)
	arg_24_0:UpdateRes()

	return
end

function var_0_0.updateLocalRedDotData(arg_25_0, arg_25_1)
	if arg_25_0:isPhaseTip(arg_25_1) then
		PlayerPrefs.SetInt("newserver_shop_phase_" .. arg_25_1 .. "_" .. arg_25_0.playerId, 1)
		arg_25_0:emit(NewServerCarnivalMediator.UPDATE_SHOP_RED_DOT)
	end

	return
end

function var_0_0.isTip(arg_26_0)
	return false
end

function var_0_0.OnDestroy(arg_27_0)
	arg_27_0.scrollrect.onInitItem = nil
	arg_27_0.scrollrect.onUpdateItem = nil

	for iter_27_0, iter_27_1 in pairs(arg_27_0.cards) do
		iter_27_1:Dispose()
	end

	arg_27_0.cards = nil

	arg_27_0.purchasePage:Destroy()

	arg_27_0.purchasePage = nil

	arg_27_0.multiWindow:Destroy()

	arg_27_0.multiWindow = nil

	arg_27_0.singleWindow:Destroy()

	arg_27_0.singleWindow = nil

	var_0_0.super.OnDestroy(arg_27_0)

	return
end

return var_0_0
