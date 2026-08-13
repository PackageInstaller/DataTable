class = var_0_10000

local var_0_0 = "BaseShopPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BasePanel"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1.super.Ctor(arg_1_0, arg_1_2)
	arg_1_0:attach(arg_1_1)

	arg_1_0.event = arg_1_1.event

	arg_1_0:CustomInit()

	return
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._go
	local var_2_1 = var_1.GetComponent

	typeof = var_1_10003
	CanvasGroup = var_1_10004
	arg_2_0.canvasGroup = var_2_1(var_2_0, var_1_10003(var_1_10004))
	GetComponent = var_1

	local var_2_2 = arg_2_0._tf

	arg_2_0.lScrollrect = var_1(var_2.Find(var_2_2, "scroll"), "LScrollRect")

	local var_2_3 = arg_2_0._tf

	arg_2_0.scrollbar = var_1.Find(var_2_3, "scroll/Scrollbar")

	local var_2_4 = arg_2_0._tf

	arg_2_0.tipTextGo = var_1.Find(var_2_4, "bg/tipBg")

	local var_2_5 = arg_2_0._tf
	local var_2_6 = var_1.Find(var_2_5, "bg/tipBg/tipText")
	local var_2_7 = var_1.GetComponent

	typeof = var_3
	Text = var_4
	arg_2_0.tipText = var_2_7(var_2_6, var_3(var_4))

	local var_2_8 = arg_2_0._tf

	arg_2_0.helpBtn = var_1.Find(var_2_8, "bg/resList/helpBtn")

	local var_2_9 = arg_2_0._tf

	arg_2_0.refreshBtn = var_1.Find(var_2_9, "timeBtn")

	local var_2_10 = arg_2_0._tf
	local var_2_11 = var_1.Find(var_2_10, "timeBtn/Text")
	local var_2_12 = var_1.GetComponent

	typeof = var_3
	Text = var_4
	arg_2_0.timerText = var_2_12(var_2_11, var_3(var_4))

	local var_2_13 = arg_2_0._tf

	arg_2_0.resolveBtn = var_1.Find(var_2_13, "resolveBtn")
	setText = var_1

	local var_2_14 = arg_2_0._tf
	local var_2_15 = var_2.Find(var_2_14, "resolveBtn/Text")

	i18n = var_2_14

	var_1(var_2_15, var_2_14("shop_fragment_resolve"))

	return
end

function var_0_1.CustomInit(arg_3_0)
	return
end

function var_0_1.SetShop(arg_4_0, arg_4_1)
	arg_4_0.shop = arg_4_1

	return
end

function var_0_1.SetPlayer(arg_5_0, arg_5_1)
	arg_5_0.player = arg_5_1

	arg_5_0:OnUpdatePlayer()

	return
end

function var_0_1.SetItems(arg_6_0, arg_6_1)
	arg_6_0.items = arg_6_1

	arg_6_0:OnUpdateItems()

	return
end

function var_0_1.SetUp(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
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

function var_0_1.InitCommodities(arg_8_0)
	local var_8_0 = arg_8_0.shop

	arg_8_0.displays, arg_8_0.cards = var_1.GetCommodities(var_8_0), {}
	arg_8_0.lScrollrect.enabled = true

	local var_8_1 = arg_8_0.lScrollrect

	var_2.SetTotalCount(var_8_1, #arg_8_0.displays, 0)

	return
end

function var_0_1.RefreshUI(arg_9_0)
	setActive = var_1_10001

	var_1_10001(arg_9_0.tipTextGo, false)

	setActive = var_1_10001

	var_1_10001(arg_9_0.helpBtn, false)

	setActive = var_1_10001

	var_1_10001(arg_9_0.resolveBtn, false)

	setActive = var_1_10001

	var_1_10001(arg_9_0.refreshBtn, false)

	return
end

function var_0_1.Show(arg_10_0)
	function arg_10_0.lScrollrect.onInitItem(arg_11_0)
		local var_11_0 = arg_10_0

		var_1.OnInitItem(var_11_0, arg_11_0)

		return
	end

	function arg_10_0.lScrollrect.onUpdateItem(arg_12_0, arg_12_1)
		local var_12_0 = arg_10_0

		var_2.OnUpdateItem(var_12_0, arg_12_0, arg_12_1)

		return
	end

	arg_10_0.canvasGroup.alpha = 1
	arg_10_0.canvasGroup.blocksRaycasts = true

	arg_10_0:PlayBGM()

	return
end

function var_0_1.Hide(arg_13_0)
	arg_13_0:StopBGM()

	pairs = var_1

	for iter_13_0, iter_13_1 in var_1(arg_13_0.cards) do
		iter_13_1:Dispose()
	end

	arg_13_0.displays = {}
	arg_13_0.cards = {}
	ClearLScrollrect = var_1

	var_1(arg_13_0.lScrollrect)

	arg_13_0.canvasGroup.alpha = 0
	arg_13_0.canvasGroup.blocksRaycasts = false

	return
end

function var_0_1.GetResDataList(arg_14_0)
	return {}
end

function var_0_1.RefreshResItemList(arg_15_0)
	local var_15_0

	if not arg_15_0:GetResDataList() then
		var_15_0 = {}
	end

	local var_15_1 = arg_15_0.parent

	var_2.RefreshResItemList(var_15_1, var_15_0)

	return
end

function var_0_1.OnDestroy(arg_16_0)
	arg_16_0:detach()

	return
end

function var_0_1.SetPainting(arg_17_0)
	local var_17_0, var_17_1, var_17_2 = arg_17_0:GetPaintingName()

	if arg_17_0.contextData.paintingView.name ~= var_17_0 then
		local var_17_3 = arg_17_0.contextData.paintingView

		var_4.Init(var_17_3, var_17_0, var_17_1, var_17_2, function()
			local var_18_0 = arg_17_0
			local var_18_1, var_18_2, var_18_3 = var_0.GetPaintingEnterVoice(var_18_0)
			local var_18_4 = arg_17_0.contextData.paintingView

			var_3.Chat(var_18_4, var_18_1, var_18_2, var_18_3, true)

			return
		end, function()
			local var_19_0 = arg_17_0
			local var_19_1, var_19_2, var_19_3 = var_0.GetPaintingTouchVoice(var_19_0)
			local var_19_4 = arg_17_0.contextData.paintingView

			var_3.Chat(var_19_4, var_19_1, var_19_2, var_19_3, false)

			return
		end)
	end

	return
end

function var_0_1.UpdateShop(arg_20_0, arg_20_1)
	arg_20_0:SetShop(arg_20_1)

	pg = var_2

	local var_20_0 = var_2.MsgboxMgr.GetInstance()

	var_2.hide(var_20_0)

	local var_20_1 = arg_20_0.contextData.singleWindow

	if var_2.GetLoaded(var_20_1) then
		local var_20_2 = arg_20_0.contextData.singleWindow

		if var_2.isShowing(var_20_2) then
			local var_20_3 = arg_20_0.contextData.singleWindow

			var_2.ExecuteAction(var_20_3, "Close")
		end
	end

	local var_20_4 = arg_20_0.contextData.multiWindow

	if var_2.GetLoaded(var_20_4) then
		local var_20_5 = arg_20_0.contextData.multiWindow

		if var_2.isShowing(var_20_5) then
			local var_20_6 = arg_20_0.contextData.multiWindow

			var_2.ExecuteAction(var_20_6, "Close")
		end
	end

	arg_20_0:OnUpdateAll()

	return
end

function var_0_1.UpdateCommodity(arg_21_0, arg_21_1, arg_21_2)
	arg_21_0:SetShop(arg_21_1)

	local var_21_0 = arg_21_1
	local var_21_1 = arg_21_1.GetCommodityById(var_21_0, arg_21_2)

	DROP_TYPE_SHIP = var_21_0

	if var_21_0 == var_21_1:getConfig("commodity_type") then
		arg_21_0:OnUpdateAll()
	else
		arg_21_0:OnUpdateCommodity(var_21_1)
	end

	local var_21_2
	local var_21_3
	local var_21_4

	if arg_21_1:IsPurchaseAll() then
		var_21_2, var_21_3, var_21_4 = arg_21_0:GetPaintingAllPurchaseVoice()
	else
		var_21_2, var_21_3, var_21_4 = arg_21_0:GetPaintingCommodityUpdateVoice()
	end

	local var_21_5 = arg_21_0.contextData.paintingView

	var_7.Chat(var_21_5, var_21_2, var_21_3, var_21_4, true)

	return
end

function var_0_1.OnClickCommodity(arg_22_0, arg_22_1, arg_22_2)
	Drop = var_1_10003

	local var_22_0 = var_1_10003.New
	local var_22_1 = {
		type = arg_22_1:getConfig("commodity_type"),
		id = arg_22_1:getConfig("commodity_id")
	}
	local var_22_2 = arg_22_1

	var_22_1.count = arg_22_1.getConfig(var_22_2, "num")

	local var_22_3 = var_22_0(var_22_1).type

	DROP_TYPE_VITEM = var_5

	if var_22_3 == var_5 then
		local var_22_4 = var_3

		if var_3.getConfig(var_22_4, "virtual_type") == 22 then
			getProxy = var_4
			ActivityProxy = var_22_4
			var_22_2 = var_4(var_22_4)

			local var_22_5 = var_4.getActivityById
			local var_22_6 = var_3

			if not var_22_5(var_22_2, var_3.getConfig(var_22_6, "link_id")) or var_5:isEnd() then
				pg = var_22_2

				local var_22_7 = var_22_2.TipsMgr.GetInstance()

				var_22_2 = var_22_2.ShowTips
				i18n = var_22_6

				var_22_2(var_22_7, var_22_6("tip_build_ticket_exchange_expired", var_3:getName()))

				return
			end
		end
	end

	local var_22_8
	local var_22_9 = var_3.type

	DROP_TYPE_EQUIPMENT_SKIN = var_22_2

	if var_22_9 == var_22_2 then
		var_22_8 = arg_22_0.contextData.singleWindowForESkin

		goto label_22_0
	end

	if arg_22_1:getConfig("num_limit") ~= 1 and arg_22_1:getConfig("commodity_type") ~= 4 then
		isa = var_5

		do
			local var_22_10 = arg_22_1

			QuotaCommodity = var_7

			if var_5(var_22_10, var_7) and arg_22_1:GetLimitGoodCount() == 1 then
				var_22_8 = arg_22_0.contextData.singleWindow
			else
				var_22_8 = arg_22_0.contextData.multiWindow
			end
		end

		::label_22_0::

		var_22_8:ExecuteAction("Open", arg_22_1, function(arg_23_0, arg_23_1, arg_23_2)
			local var_23_0 = {}
			local var_23_1 = arg_23_0

			if arg_23_0.getConfig(var_23_1, "commodity_type") ~= 4 then
				local var_23_2 = arg_22_0.shop.type

				ShopArgs = var_23_1

				if var_23_2 == var_23_1.ShopActivity then
					table = var_23_2

					var_23_2.insert(var_23_0, function(arg_24_0)
						local var_24_0 = arg_22_0

						var_1.TipPurchase(var_24_0, arg_23_0, arg_23_1, arg_23_2, arg_24_0)

						return
					end)
				else
					table = var_23_2

					var_23_2.insert(var_23_0, function(arg_25_0)
						local var_25_0 = arg_22_0

						if var_1.getSpecialRule(var_25_0, arg_23_0) then
							arg_25_0()
						end

						return
					end)
				end

				table = var_23_2

				var_23_2.insert(var_23_0, function(arg_26_0)
					local var_26_0 = arg_23_0
					local var_26_2

					if not var_1.canPurchase(var_26_0) then
						pg = var_26_2

						local var_26_1 = var_26_2.TipsMgr.GetInstance()

						var_26_2 = var_26_2.ShowTips
						i18n = var_3_10003

						var_26_2(var_26_1, var_3_10003("buy_countLimit"))

						return
					end

					Drop = var_26_2

					local var_26_3 = var_26_2.New
					local var_26_4 = {}
					local var_26_5 = arg_23_0

					var_26_4.type = var_3.getConfig(var_26_5, "resource_category")

					local var_26_6 = arg_23_0

					var_26_4.id = var_3.getConfig(var_26_6, "resource_type")

					local var_26_7 = var_26_3(var_26_4)
					local var_26_8 = var_1.getOwnedCount(var_26_7)
					local var_26_9 = arg_23_0

					if var_26_8 < var_3.getConfig(var_26_9, "resource_num") * arg_23_1 then
						ItemTipPanel = var_26_8

						local var_26_10 = var_26_8.ShowItemTip
						local var_26_11 = arg_23_0
						local var_26_12 = var_3.getConfig(var_26_11, "resource_category")
						local var_26_13 = arg_23_0

						if not var_26_10(var_26_12, var_4.getConfig(var_26_13, "resource_type")) then
							pg = var_2

							local var_26_14 = var_2.TipsMgr.GetInstance()
							local var_26_15 = var_2.ShowTips

							i18n = var_4

							var_26_15(var_26_14, var_4("common_no_x", var_1:getName()))
						end

						return
					end

					arg_26_0()

					return
				end)

				seriesAsync = var_4

				var_4(var_23_0, function()
					arg_22_2(arg_23_0, arg_23_1)

					return
				end)

				return
			end
		end)

		return
	end
end

function var_0_1.TipPurchase(arg_28_0, arg_28_1, arg_28_2, arg_28_3, arg_28_4)
	pg = var_1_10005

	local var_28_0 = var_1_10005.MsgboxMgr.GetInstance()
	local var_28_1 = var_5.ShowMsgBox
	local var_28_2 = {}

	i18n = var_1_10008
	var_28_2.content = var_1_10008("pt_reconfirm", arg_28_3 or "??")
	var_28_2.onYes = arg_28_4

	var_28_1(var_28_0, var_28_2)

	return
end

function var_0_1.getSpecialRule(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_1
	local var_29_1 = arg_29_1.getConfig(var_29_0, "commodity_type")

	DROP_TYPE_ITEM = var_29_0

	if var_29_1 == var_29_0 then
		local var_29_2 = arg_29_0.shop.type

		ShopArgs = var_29_0

		if var_29_2 == var_29_0.ShopFragment then
			local var_29_3 = arg_29_1
			local var_29_4 = arg_29_1.getConfig(var_29_3, "commodity_id")

			Item = var_29_3

			if var_29_3.getConfigData(var_29_4) and var_3.type == 7 then
				local var_29_5 = #var_3.shiptrans_id

				if 0 < var_29_5 then
					getProxy = var_29_5
					BayProxy = var_5

					local var_29_6 = var_29_5(var_5)

					getProxy = var_5
					BagProxy = var_1_10006

					local var_29_7 = var_5(var_1_10006)

					if not (var_5.getItemCountById(var_29_7, var_29_4) > 0) then
						underscore = var_5

						if var_5.any(var_3.shiptrans_id, function(arg_30_0)
							local var_30_0 = var_29_6

							return var_1.getConfigShipCount(var_30_0, arg_30_0) > 0
						end) then
							pg = var_5

							local var_29_8 = var_5.TipsMgr.GetInstance()
							local var_29_9 = var_5.ShowTips

							i18n = var_7

							var_29_9(var_29_8, var_7("special_transform_limit_reach"))

							return false
						end

						return true
					end
				end
			end
		end
	end
end

function var_0_1.CanOpen(arg_31_0, arg_31_1, arg_31_2)
	return true
end

function var_0_1.GetPaintingName(arg_32_0)
	return "buzhihuo_shop"
end

function var_0_1.GetPaintingEnterVoice(arg_33_0)
	pg = var_1_10001

	local var_33_0 = var_1_10001.navalacademy_shoppingstreet_template[1].words_enter

	string = var_1_10002

	local var_33_1 = var_1_10002.split(var_33_0, "|")

	math = var_3

	return var_33_1[var_3.random(#var_33_1)], "enter_" .. var_3, false
end

function var_0_1.GetPaintingCommodityUpdateVoice(arg_34_0)
	pg = var_1_10001

	local var_34_0 = var_1_10001.navalacademy_shoppingstreet_template[1].words_buy

	string = var_1_10002

	local var_34_1 = var_1_10002.split(var_34_0, "|")

	math = var_3

	return var_34_1[var_3.random(#var_34_1)], "buy_" .. var_3, false
end

function var_0_1.GetPaintingAllPurchaseVoice(arg_35_0)
	return nil, nil, nil
end

function var_0_1.GetPaintingTouchVoice(arg_36_0)
	pg = var_1_10001

	local var_36_0 = var_1_10001.navalacademy_shoppingstreet_template[1].words_touch

	string = var_1_10002

	local var_36_1 = var_1_10002.split(var_36_0, "|")

	math = var_3

	return var_36_1[var_3.random(#var_36_1)], "touch_" .. var_3, false
end

function var_0_1.GetBg(arg_37_0, arg_37_1)
	return
end

function var_0_1.OnSetUp(arg_38_0)
	return
end

function var_0_1.getBGM(arg_39_0)
	return nil
end

function var_0_1.PlayBGM(arg_40_0)
	local var_40_0 = arg_40_0
	local var_40_1 = arg_40_0.getBGM(var_40_0)

	pg = var_40_0

	local var_40_2 = var_40_0.voice_bgm[var_40_1]

	if var_40_1 and var_40_2 then
		pg = var_1_10003

		local var_40_3 = var_1_10003.BgmMgr.GetInstance()

		var_3.Push(var_40_3, var_40_1, var_40_2.bgm)
	end

	return
end

function var_0_1.StopBGM(arg_41_0)
	local var_41_0 = arg_41_0
	local var_41_1 = arg_41_0.getBGM(var_41_0)

	pg = var_41_0

	local var_41_2 = var_41_0.voice_bgm[var_41_1]

	if var_41_1 and var_41_2 then
		pg = var_1_10003

		local var_41_3 = var_1_10003.BgmMgr.GetInstance()

		var_3.Pop(var_41_3, var_41_1)
	end

	return
end

function var_0_1.OnUpdateAll(arg_42_0)
	return
end

function var_0_1.OnUpdateCommodity(arg_43_0, arg_43_1)
	return
end

function var_0_1.OnUpdatePlayer(arg_44_0)
	return
end

function var_0_1.OnUpdateItems(arg_45_0)
	return
end

function var_0_1.OnInitItem(arg_46_0, arg_46_1)
	return
end

function var_0_1.OnUpdateItem(arg_47_0, arg_47_1, arg_47_2)
	return
end

function var_0_1.CanOpenPurchaseWindow(arg_48_0, arg_48_1)
	return arg_48_1:canPurchase()
end

return var_0_1
