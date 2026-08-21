local var_0_0 = class("NewServerShopPage", import("...base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "NewServerShopPage"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.scrollrect = arg_2_0._tf:Find("scrollView"):GetComponent("LScrollRect")
	arg_2_0.resTxt = arg_2_0._tf:Find("res_pt/Text"):GetComponent(typeof(Text))
	arg_2_0.resIcon = arg_2_0._tf:Find("res_pt/icon")
	arg_2_0.pagefooters = {
		arg_2_0._tf:Find("pagefooter/tpl")
	}
	arg_2_0.pagefooterWid = arg_2_0.pagefooters[1].rect.width
	arg_2_0.pagefooterStartPosX = arg_2_0.pagefooters[1].anchoredPosition.x
	arg_2_0.purchasePage = NewServerShopPurchasePanel.New(arg_2_0._tf, arg_2_0.event, arg_2_0.contextData)
	arg_2_0.multiWindow = NewServerShopMultiWindow.New(arg_2_0._tf, arg_2_0.event)
	arg_2_0.singleWindow = NewServerShopSingleWindow.New(arg_2_0._tf, arg_2_0.event)
	arg_2_0._tf.localPosition = Vector3(-6, -25)

	return
end

function var_0_0.UpdateRes(arg_3_0)
	local var_3_0 = arg_3_0.shop:GetPtId()

	arg_3_0.resTxt.text = getProxy(PlayerProxy):getRawData():getResource(var_3_0)

	if not arg_3_0.isInitResIcon then
		arg_3_0.isInitResIcon = true

		GetImageSpriteFromAtlasAsync(Drop.New({
			type = DROP_TYPE_RESOURCE,
			id = var_3_0
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

	return
end

function var_0_0.OnInitItem(arg_7_0, arg_7_1)
	local var_7_0 = NewServerGoodsCard.New(arg_7_1)

	onButton(arg_7_0, var_7_0._tf, function()
		arg_7_0:OnClickCard(var_7_0)

		return
	end, SFX_PANEL)

	arg_7_0.cards[arg_7_1] = var_7_0

	return
end

function var_0_0.OnClickCard(arg_9_0, arg_9_1)
	local var_9_0, var_9_1 = arg_9_1.commodity:IsOpening(arg_9_0.shop:GetStartTime())

	if not var_9_0 then
		local var_9_2 = var_9_1.day > 0 and var_9_1.day .. i18n("word_date") or ""

		pg.TipsMgr.GetInstance():ShowTips(i18n("newserver_shop_timelimit", var_9_2 .. var_9_1.hour .. i18n("word_hour")))

		return
	end

	if arg_9_1.commodity:Selectable() then
		arg_9_0.purchasePage:ExecuteAction("Show", arg_9_1.commodity)
	else
		((arg_9_1.commodity:getConfig("goods_purchase_limit") == 1 or arg_9_1.commodity:getConfig("type") == 4) and arg_9_0.singleWindow or arg_9_0.multiWindow):ExecuteAction("Open", arg_9_1.commodity, function(arg_10_0, arg_10_1, arg_10_2)
			if not arg_10_0:CanPurchase() then
				pg.TipsMgr.GetInstance():ShowTips(i18n("buy_countLimit"))

				return
			end

			pg.m02:sendNotification(GAME.NEW_SERVER_SHOP_SHOPPING, {
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
	local var_12_0 = getProxy(ShopsProxy):GetNewServerShop(ActivityConst.ACTIVITY_TYPE_NEWSERVER_SHOP)

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

local function var_0_1(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0.pagefooters[arg_16_1]

	if not arg_16_0.pagefooters[arg_16_1] then
		var_16_0 = Object.Instantiate(arg_16_0.pagefooters[1], arg_16_0.pagefooters[1].parent)
		arg_16_0.pagefooters[arg_16_1] = var_16_0
	end

	setActive(var_16_0, true)

	return var_16_0
end

function var_0_0.UpdatePageFooters(arg_17_0)
	local var_17_0 = arg_17_0.shop:GetPhases()

	arg_17_0.pagefooterTrs = {}

	for iter_17_0 = 1, #var_17_0 do
		local var_17_1 = var_0_1(arg_17_0, iter_17_0)

		arg_17_0:UpdatePageFooter(var_17_1, iter_17_0)

		arg_17_0.pagefooterTrs[iter_17_0] = var_17_1
	end

	for iter_17_1 = #var_17_0 + 1, #arg_17_0.pagefooters do
		setActive(arg_17_0.pagefooters[iter_17_1], false)
	end

	local var_17_2 = arg_17_0.contextData.index or 1

	triggerButton(arg_17_0.pagefooterTrs[var_17_2])

	return
end

local var_0_2 = 0

function var_0_0.UpdatePageFooter(arg_18_0, arg_18_1, arg_18_2)
	setAnchoredPosition(arg_18_1, {
		x = arg_18_0.pagefooterStartPosX + (var_0_2 + arg_18_0.pagefooterWid) * (arg_18_2 - 1)
	})

	arg_18_1:Find("Text"):GetComponent(typeof(Image)).sprite = GetSpriteFromAtlas("ui/newservershopui_atlas", "p" .. arg_18_2)
	arg_18_1:Find("mark"):GetComponent(typeof(Image)).sprite = GetSpriteFromAtlas("ui/newservershopui_atlas", "p" .. arg_18_2 .. "_s")

	local var_18_0 = arg_18_1:Find("lock")

	if arg_18_2 ~= 1 then
		var_18_0:GetComponent(typeof(Image)).sprite = GetSpriteFromAtlas("ui/newservershopui_atlas", "p" .. arg_18_2 .. "_l")
	end

	setActive(var_18_0, not arg_18_0.shop:IsOpenPhase(arg_18_2))
	setActive(arg_18_1:Find("tip"), arg_18_0:isPhaseTip(arg_18_2))
	arg_18_0:OnSwitch(arg_18_1, function()
		return arg_18_0.openIndex ~= arg_18_2
	end, function()
		arg_18_0:SwitchPhase(arg_18_2)
		setActive(arg_18_1:Find("tip"), arg_18_0:isPhaseTip(arg_18_2))

		return
	end)

	return
end

function var_0_0.OnSwitch(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	local var_21_0 = arg_21_1:Find("mark")

	local function var_21_1()
		if arg_21_0.markTr then
			setActive(arg_21_0.markTr, false)
		end

		arg_21_0.markTr = var_21_0

		setActive(var_21_0, true)

		return
	end

	onButton(arg_21_0, arg_21_1, function()
		if not arg_21_2() then
			return
		end

		var_21_1()
		arg_21_3()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.SwitchPhase(arg_24_0, arg_24_1)
	arg_24_0.displays = arg_24_0.shop:GetOpeningGoodsList(arg_24_0.shop:GetPhases()[arg_24_1])

	table.sort(arg_24_0.displays, function(arg_25_0, arg_25_1)
		local var_25_0 = arg_25_0:CanPurchase() and 1 or 0
		local var_25_1 = arg_25_1:CanPurchase() and 1 or 0

		if var_25_0 == var_25_1 then
			return arg_25_0.id < arg_25_1.id
		else
			return var_25_1 < var_25_0
		end

		return
	end)
	arg_24_0.scrollrect:SetTotalCount(#arg_24_0.displays)

	arg_24_0.openIndex = arg_24_1

	arg_24_0:updateLocalRedDotData(arg_24_1)

	return
end

function var_0_0.Refresh(arg_26_0)
	arg_26_0:SwitchPhase(arg_26_0.openIndex)
	arg_26_0:UpdateRes()

	return
end

function var_0_0.isPhaseTip(arg_27_0, arg_27_1)
	arg_27_0.playerId = arg_27_0.playerId or getProxy(PlayerProxy):getData().id

	return arg_27_1 ~= 1 and arg_27_0.shop:IsOpenPhase(arg_27_1) and PlayerPrefs.GetInt("newserver_shop_phase_" .. arg_27_1 .. "_" .. arg_27_0.playerId) == 0
end

function var_0_0.updateLocalRedDotData(arg_28_0, arg_28_1)
	if arg_28_0:isPhaseTip(arg_28_1) then
		PlayerPrefs.SetInt("newserver_shop_phase_" .. arg_28_1 .. "_" .. arg_28_0.playerId, 1)
		arg_28_0:emit(NewServerCarnivalMediator.UPDATE_SHOP_RED_DOT)
	end

	return
end

function var_0_0.isTip(arg_29_0)
	arg_29_0.playerId = arg_29_0.playerId or getProxy(PlayerProxy):getData().id

	if PlayerPrefs.GetInt("newserver_shop_first_" .. arg_29_0.playerId) == 0 then
		return true
	end

	for iter_29_0, iter_29_1 in pairs(arg_29_0.shop:GetPhases()) do
		if arg_29_0:isPhaseTip(iter_29_0) then
			return true
		end
	end

	return false
end

function var_0_0.OnDestroy(arg_30_0)
	arg_30_0.scrollrect.onInitItem = nil
	arg_30_0.scrollrect.onUpdateItem = nil

	for iter_30_0, iter_30_1 in pairs(arg_30_0.cards) do
		iter_30_1:Dispose()
	end

	arg_30_0.cards = nil

	arg_30_0.purchasePage:Destroy()

	arg_30_0.purchasePage = nil

	arg_30_0.multiWindow:Destroy()

	arg_30_0.multiWindow = nil

	arg_30_0.singleWindow:Destroy()

	arg_30_0.singleWindow = nil

	var_0_0.super.OnDestroy(arg_30_0)

	return
end

return var_0_0
