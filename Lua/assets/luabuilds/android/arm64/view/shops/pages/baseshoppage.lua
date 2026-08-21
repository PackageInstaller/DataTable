local var_0_0 = class("BaseShopPage", import("...base.BasePanel"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_2)
	arg_1_0:attach(arg_1_1)

	arg_1_0.event = arg_1_1.event

	arg_1_0:CustomInit()

	return
end

function var_0_0.init(arg_2_0)
	arg_2_0.canvasGroup = arg_2_0._go:GetComponent(typeof(CanvasGroup))
	arg_2_0.lScrollrect = GetComponent(arg_2_0._tf:Find("scroll"), "LScrollRect")
	arg_2_0.scrollbar = arg_2_0._tf:Find("scroll/Scrollbar")
	arg_2_0.tipTextGo = arg_2_0._tf:Find("bg/tipBg")
	arg_2_0.tipText = arg_2_0._tf:Find("bg/tipBg/tipText"):GetComponent(typeof(Text))
	arg_2_0.helpBtn = arg_2_0._tf:Find("bg/resList/helpBtn")
	arg_2_0.refreshBtn = arg_2_0._tf:Find("timeBtn")
	arg_2_0.timerText = arg_2_0._tf:Find("timeBtn/Text"):GetComponent(typeof(Text))
	arg_2_0.resolveBtn = arg_2_0._tf:Find("resolveBtn")

	setText(arg_2_0._tf:Find("resolveBtn/Text"), i18n("shop_fragment_resolve"))

	return
end

function var_0_0.CustomInit(arg_3_0)
	return
end

function var_0_0.SetShop(arg_4_0, arg_4_1)
	arg_4_0.shop = arg_4_1

	return
end

function var_0_0.SetPlayer(arg_5_0, arg_5_1)
	arg_5_0.player = arg_5_1

	arg_5_0:OnUpdatePlayer()

	return
end

function var_0_0.SetItems(arg_6_0, arg_6_1)
	arg_6_0.items = arg_6_1

	arg_6_0:OnUpdateItems()

	return
end

function var_0_0.SetUp(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	arg_7_0:SetShop(arg_7_1)
	arg_7_0:Show()
	arg_7_0:SetPlayer(arg_7_2)
	arg_7_0:SetItems(arg_7_3)
	arg_7_0:InitCommodities()
	arg_7_0:OnSetUp()
	arg_7_0:SetPainting()
	arg_7_0:RefreshUI()

	return
end

function var_0_0.InitCommodities(arg_8_0)
	arg_8_0.displays, arg_8_0.cards = arg_8_0.shop:GetCommodities(), {}
	arg_8_0.lScrollrect.enabled = true

	arg_8_0.lScrollrect:SetTotalCount(#arg_8_0.displays, 0)

	return
end

function var_0_0.RefreshUI(arg_9_0)
	setActive(arg_9_0.tipTextGo, false)
	setActive(arg_9_0.helpBtn, false)
	setActive(arg_9_0.resolveBtn, false)
	setActive(arg_9_0.refreshBtn, false)

	return
end

function var_0_0.Show(arg_10_0)
	function arg_10_0.lScrollrect.onInitItem(arg_11_0)
		arg_10_0:OnInitItem(arg_11_0)

		return
	end

	function arg_10_0.lScrollrect.onUpdateItem(arg_12_0, arg_12_1)
		arg_10_0:OnUpdateItem(arg_12_0, arg_12_1)

		return
	end

	arg_10_0.canvasGroup.alpha = 1
	arg_10_0.canvasGroup.blocksRaycasts = true

	arg_10_0:PlayBGM()

	return
end

function var_0_0.Hide(arg_13_0)
	arg_13_0:StopBGM()

	for iter_13_0, iter_13_1 in pairs(arg_13_0.cards) do
		iter_13_1:Dispose()
	end

	arg_13_0.displays = {}
	arg_13_0.cards = {}

	ClearLScrollrect(arg_13_0.lScrollrect)

	arg_13_0.canvasGroup.alpha = 0
	arg_13_0.canvasGroup.blocksRaycasts = false

	return
end

function var_0_0.GetResDataList(arg_14_0)
	return {}
end

function var_0_0.RefreshResItemList(arg_15_0)
	local var_15_0 = arg_15_0:GetResDataList() or {}

	arg_15_0.parent:RefreshResItemList(var_15_0)

	return
end

function var_0_0.OnDestroy(arg_16_0)
	arg_16_0:detach()

	return
end

function var_0_0.SetPainting(arg_17_0)
	local var_17_0, var_17_1, var_17_2 = arg_17_0:GetPaintingName()

	if arg_17_0.contextData.paintingView.name ~= var_17_0 then
		arg_17_0.contextData.paintingView:Init(var_17_0, var_17_1, var_17_2, function()
			local var_18_0, var_18_1, var_18_2 = arg_17_0:GetPaintingEnterVoice()

			arg_17_0.contextData.paintingView:Chat(var_18_0, var_18_1, var_18_2, true)

			return
		end, function()
			local var_19_0, var_19_1, var_19_2 = arg_17_0:GetPaintingTouchVoice()

			arg_17_0.contextData.paintingView:Chat(var_19_0, var_19_1, var_19_2, false)

			return
		end)
	end

	return
end

function var_0_0.UpdateShop(arg_20_0, arg_20_1)
	arg_20_0:SetShop(arg_20_1)
	pg.MsgboxMgr.GetInstance():hide()

	if arg_20_0.contextData.singleWindow:GetLoaded() and arg_20_0.contextData.singleWindow:isShowing() then
		arg_20_0.contextData.singleWindow:ExecuteAction("Close")
	end

	if arg_20_0.contextData.multiWindow:GetLoaded() and arg_20_0.contextData.multiWindow:isShowing() then
		arg_20_0.contextData.multiWindow:ExecuteAction("Close")
	end

	arg_20_0:OnUpdateAll()

	return
end

function var_0_0.UpdateCommodity(arg_21_0, arg_21_1, arg_21_2)
	arg_21_0:SetShop(arg_21_1)

	local var_21_0 = arg_21_1:GetCommodityById(arg_21_2)

	if DROP_TYPE_SHIP == var_21_0:getConfig("commodity_type") then
		arg_21_0:OnUpdateAll()
	else
		arg_21_0:OnUpdateCommodity(var_21_0)
	end

	local var_21_1
	local var_21_2
	local var_21_3

	if arg_21_1:IsPurchaseAll() then
		var_21_1, var_21_2, var_21_3 = arg_21_0:GetPaintingAllPurchaseVoice()
	else
		var_21_1, var_21_2, var_21_3 = arg_21_0:GetPaintingCommodityUpdateVoice()
	end

	arg_21_0.contextData.paintingView:Chat(var_21_1, var_21_2, var_21_3, true)

	return
end

function var_0_0.OnClickCommodity(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = Drop.New({
		type = arg_22_1:getConfig("commodity_type"),
		id = arg_22_1:getConfig("commodity_id"),
		count = arg_22_1:getConfig("num")
	})

	if var_22_0.type == DROP_TYPE_VITEM and var_22_0:getConfig("virtual_type") == 22 then
		local var_22_1 = getProxy(ActivityProxy):getActivityById(var_22_0:getConfig("link_id"))

		if not var_22_1 or var_22_1:isEnd() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("tip_build_ticket_exchange_expired", var_22_0:getName()))

			return
		end
	end

	;(var_22_0.type == DROP_TYPE_EQUIPMENT_SKIN and arg_22_0.contextData.singleWindowForESkin or (arg_22_1:getConfig("num_limit") == 1 or arg_22_1:getConfig("commodity_type") == 4 or isa(arg_22_1, QuotaCommodity) and arg_22_1:GetLimitGoodCount() == 1) and arg_22_0.contextData.singleWindow or arg_22_0.contextData.multiWindow):ExecuteAction("Open", arg_22_1, function(arg_23_0, arg_23_1, arg_23_2)
		if arg_23_0:getConfig("commodity_type") == 4 or arg_22_0.shop.type == ShopArgs.ShopActivity then
			table.insert({}, function(arg_24_0)
				arg_22_0:TipPurchase(arg_23_0, arg_23_1, arg_23_2, arg_24_0)

				return
			end)
		else
			table.insert({}, function(arg_25_0)
				if arg_22_0:getSpecialRule(arg_23_0) then
					arg_25_0()
				end

				return
			end)
		end

		table.insert({}, function(arg_26_0)
			if not arg_23_0:canPurchase() then
				pg.TipsMgr.GetInstance():ShowTips(i18n("buy_countLimit"))

				return
			end

			local var_26_0 = Drop.New({
				type = arg_23_0:getConfig("resource_category"),
				id = arg_23_0:getConfig("resource_type")
			})

			if var_26_0:getOwnedCount() < arg_23_0:getConfig("resource_num") * arg_23_1 then
				if not ItemTipPanel.ShowItemTip(arg_23_0:getConfig("resource_category"), arg_23_0:getConfig("resource_type")) then
					pg.TipsMgr.GetInstance():ShowTips(i18n("common_no_x", var_26_0:getName()))
				end

				return
			end

			arg_26_0()

			return
		end)
		seriesAsync({}, function()
			arg_22_2(arg_23_0, arg_23_1)

			return
		end)

		return
	end)

	return
end

function var_0_0.TipPurchase(arg_28_0, arg_28_1, arg_28_2, arg_28_3, arg_28_4)
	pg.MsgboxMgr.GetInstance():ShowMsgBox({
		content = i18n("pt_reconfirm", arg_28_3 or "??"),
		onYes = arg_28_4
	})

	return
end

function var_0_0.getSpecialRule(arg_29_0, arg_29_1)
	if arg_29_1:getConfig("commodity_type") == DROP_TYPE_ITEM and arg_29_0.shop.type == ShopArgs.ShopFragment then
		local var_29_0 = arg_29_1:getConfig("commodity_id")
		local var_29_1 = Item.getConfigData(var_29_0)

		if var_29_1 and var_29_1.type == 7 and #var_29_1.shiptrans_id > 0 then
			local var_29_2 = getProxy(BayProxy)

			if getProxy(BagProxy):getItemCountById(var_29_0) > 0 or underscore.any(var_29_1.shiptrans_id, function(arg_30_0)
				return var_29_2:getConfigShipCount(arg_30_0) > 0
			end) then
				pg.TipsMgr.GetInstance():ShowTips(i18n("special_transform_limit_reach"))

				return false
			end
		end
	end

	return true
end

function var_0_0.CanOpen(arg_31_0, arg_31_1, arg_31_2)
	return true
end

function var_0_0.GetPaintingName(arg_32_0)
	return "buzhihuo_shop"
end

function var_0_0.GetPaintingEnterVoice(arg_33_0)
	local var_33_0 = string.split(pg.navalacademy_shoppingstreet_template[1].words_enter, "|")
	local var_33_1 = math.random(#var_33_0)

	return var_33_0[var_33_1], "enter_" .. var_33_1, false
end

function var_0_0.GetPaintingCommodityUpdateVoice(arg_34_0)
	local var_34_0 = string.split(pg.navalacademy_shoppingstreet_template[1].words_buy, "|")
	local var_34_1 = math.random(#var_34_0)

	return var_34_0[var_34_1], "buy_" .. var_34_1, false
end

function var_0_0.GetPaintingAllPurchaseVoice(arg_35_0)
	return nil, nil, nil
end

function var_0_0.GetPaintingTouchVoice(arg_36_0)
	local var_36_0 = string.split(pg.navalacademy_shoppingstreet_template[1].words_touch, "|")
	local var_36_1 = math.random(#var_36_0)

	return var_36_0[var_36_1], "touch_" .. var_36_1, false
end

function var_0_0.GetBg(arg_37_0, arg_37_1)
	return
end

function var_0_0.OnSetUp(arg_38_0)
	return
end

function var_0_0.getBGM(arg_39_0)
	return nil
end

function var_0_0.PlayBGM(arg_40_0)
	local var_40_0 = arg_40_0:getBGM()

	if var_40_0 and pg.voice_bgm[var_40_0] then
		pg.BgmMgr.GetInstance():Push(var_40_0, pg.voice_bgm[var_40_0].bgm)
	end

	return
end

function var_0_0.StopBGM(arg_41_0)
	local var_41_0 = arg_41_0:getBGM()

	if var_41_0 and pg.voice_bgm[var_41_0] then
		pg.BgmMgr.GetInstance():Pop(var_41_0)
	end

	return
end

function var_0_0.OnUpdateAll(arg_42_0)
	return
end

function var_0_0.OnUpdateCommodity(arg_43_0, arg_43_1)
	return
end

function var_0_0.OnUpdatePlayer(arg_44_0)
	return
end

function var_0_0.OnUpdateItems(arg_45_0)
	return
end

function var_0_0.OnInitItem(arg_46_0, arg_46_1)
	return
end

function var_0_0.OnUpdateItem(arg_47_0, arg_47_1, arg_47_2)
	return
end

function var_0_0.CanOpenPurchaseWindow(arg_48_0, arg_48_1)
	return arg_48_1:canPurchase()
end

return var_0_0
