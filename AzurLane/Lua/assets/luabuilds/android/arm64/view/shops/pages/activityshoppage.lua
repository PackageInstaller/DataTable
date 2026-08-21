local var_0_0 = class("ActivityShopPage", import(".BaseShopPage"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	return
end

function var_0_0.getBGM(arg_2_0)
	return string.format("ActivityShop%s", arg_2_0.shop.activityId)
end

function var_0_0.GetPaintingName(arg_3_0)
	assert(arg_3_0.shop)

	if pg.activity_template[arg_3_0.shop.activityId] and pg.activity_template[arg_3_0.shop.activityId].config_client then
		if pg.activity_template[arg_3_0.shop.activityId].config_client.use_secretary or getProxy(ActivityProxy):checkHxActivity(arg_3_0.shop.activityId) then
			local var_3_0 = getProxy(PlayerProxy)
			local var_3_1 = getProxy(SettingsProxy):getCurrentSecretaryIndex()

			arg_3_0.tempFlagShip = getProxy(BayProxy):getShipById(var_3_0:getData().characters[1])

			return arg_3_0.tempFlagShip:getPainting(), true, "build"
		elseif pg.activity_template[arg_3_0.shop.activityId].config_client.painting then
			return pg.activity_template[arg_3_0.shop.activityId].config_client.painting, true
		end
	end

	return "aijiang_pt"
end

function var_0_0.GetBg(arg_4_0, arg_4_1)
	return (arg_4_1:getBgPath())
end

function var_0_0.GetPaintingEnterVoice(arg_5_0)
	local var_5_0, var_5_1, var_5_2 = arg_5_0.shop:GetEnterVoice()

	return var_5_1, var_5_0, var_5_2
end

function var_0_0.GetPaintingCommodityUpdateVoice(arg_6_0)
	local var_6_0, var_6_1, var_6_2 = arg_6_0.shop:GetPurchaseVoice()

	return var_6_1, var_6_0, var_6_2
end

function var_0_0.GetPaintingAllPurchaseVoice(arg_7_0)
	local var_7_0, var_7_1, var_7_2 = arg_7_0.shop:GetPurchaseAllVoice()

	return var_7_1, var_7_0, var_7_2
end

function var_0_0.GetPaintingTouchVoice(arg_8_0)
	local var_8_0, var_8_1, var_8_2 = arg_8_0.shop:GetTouchVoice()

	return var_8_1, var_8_0, var_8_2
end

function var_0_0.init(arg_9_0)
	var_0_0.super.init(arg_9_0)

	arg_9_0.scrollRectSpecial = arg_9_0._tf:Find("scrollRectSpecial")
	arg_9_0.groupList = UIItemList.New(arg_9_0.scrollRectSpecial:Find("viewport/view"), arg_9_0.scrollRectSpecial:Find("viewport/view/group"))

	return
end

function var_0_0.OnInit(arg_10_0)
	return
end

function var_0_0.OnUpdatePlayer(arg_11_0)
	arg_11_0:RefreshResItemList()

	return
end

function var_0_0.GetResDataList(arg_12_0)
	for iter_12_0, iter_12_1 in ipairs((arg_12_0.shop:GetResList())) do
		table.insert({}, {
			type = DROP_TYPE_RESOURCE,
			resID = iter_12_1,
			cnt = arg_12_0.player:getResource(iter_12_1)
		})
	end

	return {}
end

function var_0_0.OnSetUp(arg_13_0)
	arg_13_0:SetResIcon()
	arg_13_0:UpdateTip()

	return
end

function var_0_0.OnUpdateAll(arg_14_0)
	arg_14_0:InitCommodities()

	return
end

function var_0_0.OnUpdateCommodity(arg_15_0, arg_15_1)
	local var_15_0

	for iter_15_0, iter_15_1 in pairs(arg_15_0.cards) do
		if iter_15_1.goodsVO.id == arg_15_1.id then
			var_15_0 = iter_15_1

			break
		end
	end

	if var_15_0 then
		local var_15_1, var_15_2, var_15_3 = arg_15_0.shop:getBgPath()

		var_15_0:update(arg_15_1, nil, var_15_2, var_15_3)
	end

	return
end

function var_0_0.SetResIcon(arg_16_0, arg_16_1)
	arg_16_0:RefreshResItemList()

	return
end

function var_0_0.RefreshUI(arg_17_0)
	setActive(arg_17_0.tipTextGo, true)
	setActive(arg_17_0.helpBtn, false)
	setActive(arg_17_0.resolveBtn, false)
	setActive(arg_17_0.refreshBtn, false)

	return
end

function var_0_0.UpdateTip(arg_18_0)
	arg_18_0.tipText.text = "<size=" .. (#arg_18_0.shop:GetResList() > 1 and 25 or 27) .. ">" .. i18n("activity_shop_lable", arg_18_0.shop:getOpenTime()) .. "</size>"

	return
end

function var_0_0.OnInitItem(arg_19_0, arg_19_1)
	local var_19_0 = ActivityGoodsCard.New(arg_19_1)

	onButton(arg_19_0, var_19_0.tf, function()
		arg_19_0:OnClickCommodity(var_19_0.goodsVO, function(arg_21_0, arg_21_1)
			arg_19_0:OnPurchase(arg_21_0, arg_21_1)

			return
		end)

		return
	end, SFX_PANEL)

	arg_19_0.cards[arg_19_1] = var_19_0

	return
end

function var_0_0.OnUpdateItem(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = arg_22_0.cards[arg_22_2]

	if not arg_22_0.cards[arg_22_2] then
		arg_22_0:OnInitItem(arg_22_2)

		var_22_0 = arg_22_0.cards[arg_22_2]
	end

	local var_22_1 = arg_22_0.displays[arg_22_1 + 1]
	local var_22_2, var_22_3, var_22_4 = arg_22_0.shop:getBgPath()

	var_22_0:update(var_22_1, nil, var_22_3, var_22_4)

	return
end

function var_0_0.TipPurchase(arg_23_0, arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	local var_23_0, var_23_1 = arg_23_1:GetTranCntWhenFull(arg_23_2)

	if var_23_0 > 0 then
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("pt_shop_tran_tip", math.max(arg_23_2 - var_23_0, 0), arg_23_3, var_23_0 * var_23_1.count, var_23_1:getConfig("name")),
			onYes = arg_23_4
		})
	else
		arg_23_4()
	end

	return
end

function var_0_0.OnPurchase(arg_24_0, arg_24_1, arg_24_2)
	if arg_24_1:getConfig("commodity_type") == DROP_TYPE_ITEM then
		local var_24_0 = getProxy(BagProxy):RawGetItemById((arg_24_1:getConfig("commodity_id")))

		if var_24_0 and var_24_0:IsShipExpType() and var_24_0:IsMaxCnt() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("item_is_max_cnt"))

			return
		end
	end

	arg_24_0:emit(NewShopMainMediator.ON_ACT_SHOPPING, arg_24_0.shop.activityId, 1, arg_24_1.id, arg_24_2)

	return
end

function var_0_0.OnClickCommodity(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = arg_25_1:CheckCntLimit()

	if not var_25_0 then
		return
	end

	if var_25_0 and not arg_25_1:CheckArgLimit() then
		local var_25_1, var_25_2, var_25_3, var_25_4 = arg_25_1:CheckArgLimit()

		if var_25_2 == ShopArgs.LIMIT_ARGS_META_SHIP_EXISTENCE then
			local var_25_5 = ShipGroup.getDefaultShipConfig(var_25_4) or {}
			local var_25_6 = pg.TipsMgr.GetInstance()

			var_25_6:ShowTips(i18n("meta_shop_exchange_limit_tip", var_25_7))
		elseif var_25_2 == ShopArgs.LIMIT_ARGS_SALE_START_TIME then
			pg.TipsMgr.GetInstance():ShowTips(i18n("meta_shop_exchange_limit_2_tip", ({
				year = var_25_4[1][1],
				month = var_25_4[1][2],
				day = var_25_4[1][3],
				hour = var_25_4[2][1],
				min = var_25_4[2][2],
				sec = var_25_4[2][3]
			}).year, ({
				year = var_25_4[1][1],
				month = var_25_4[1][2],
				day = var_25_4[1][3],
				hour = var_25_4[2][1],
				min = var_25_4[2][2],
				sec = var_25_4[2][3]
			}).month, ({
				year = var_25_4[1][1],
				month = var_25_4[1][2],
				day = var_25_4[1][3],
				hour = var_25_4[2][1],
				min = var_25_4[2][2],
				sec = var_25_4[2][3]
			}).day, ({
				year = var_25_4[1][1],
				month = var_25_4[1][2],
				day = var_25_4[1][3],
				hour = var_25_4[2][1],
				min = var_25_4[2][2],
				sec = var_25_4[2][3]
			}).hour, ({
				year = var_25_4[1][1],
				month = var_25_4[1][2],
				day = var_25_4[1][3],
				hour = var_25_4[2][1],
				min = var_25_4[2][2],
				sec = var_25_4[2][3]
			}).min, ({
				year = var_25_4[1][1],
				month = var_25_4[1][2],
				day = var_25_4[1][3],
				hour = var_25_4[2][1],
				min = var_25_4[2][2],
				sec = var_25_4[2][3]
			}).sec))
		end

		return
	end

	var_0_0.super.OnClickCommodity(arg_25_0, arg_25_1, arg_25_2)

	return
end

function var_0_0.Show(arg_26_0)
	if pg.activity_template[arg_26_0.shop.activityId] and pg.activity_template[arg_26_0.shop.activityId].config_client and pg.activity_template[arg_26_0.shop.activityId].config_client.category then
		setActive(go(arg_26_0.lScrollrect), false)
		setActive(arg_26_0.scrollRectSpecial, true)
		arg_26_0.groupList:make(function(arg_27_0, arg_27_1, arg_27_2)
			if arg_27_0 == UIItemList.EventUpdate then
				local var_27_0 = arg_26_0.splitCommodities[arg_27_1 + 1]

				setText(arg_27_2:Find("title/name"), i18n(arg_26_0.spiltNameCodes[arg_27_1 + 1]))

				local var_27_1 = UIItemList.New(arg_27_2:Find("items"), arg_27_2:Find("items/ActivityShopNewTpl"))

				var_27_1:make(function(arg_28_0, arg_28_1, arg_28_2)
					if arg_28_0 == UIItemList.EventUpdate then
						local var_28_0 = ActivityGoodsCard.New(arg_28_2)

						arg_26_0.cards[arg_28_2] = var_28_0

						onButton(arg_26_0, var_28_0.tf, function()
							arg_26_0:OnClickCommodity(var_28_0.goodsVO, function(arg_30_0, arg_30_1)
								arg_26_0:OnPurchase(arg_30_0, arg_30_1)

								return
							end)

							return
						end, SFX_PANEL)

						local var_28_1, var_28_2, var_28_3 = arg_26_0.shop:getBgPath()

						var_28_0:update(var_27_0[arg_28_1 + 1], nil, var_28_2, var_28_3)
					end

					return
				end)
				var_27_1:align(#arg_26_0.splitCommodities[arg_27_1 + 1])
			end

			return
		end)
		arg_26_0.groupList:align(#arg_26_0.splitCommodities)

		arg_26_0.canvasGroup.alpha = 1
		arg_26_0.canvasGroup.blocksRaycasts = true
	else
		setActive(go(arg_26_0.lScrollrect), true)

		if arg_26_0.scrollRectSpecial then
			setActive(arg_26_0.scrollRectSpecial, false)
		end

		var_0_0.super.Show(arg_26_0)
	end

	if arg_26_0.shop:GetBGM() ~= "" then
		pg.BgmMgr.GetInstance():Push(arg_26_0.__cname, arg_26_0.shop:GetBGM())
	end

	return
end

function var_0_0.Hide(arg_31_0)
	if pg.activity_template[arg_31_0.shop.activityId] and pg.activity_template[arg_31_0.shop.activityId].config_client and pg.activity_template[arg_31_0.shop.activityId].config_client.category then
		for iter_31_0, iter_31_1 in pairs(arg_31_0.cards) do
			iter_31_1:Dispose()
		end

		arg_31_0.splitCommodities = {}
		arg_31_0.spiltNameCodes = {}
		arg_31_0.cards = {}
		arg_31_0.canvasGroup.alpha = 0
		arg_31_0.canvasGroup.blocksRaycasts = false
	else
		var_0_0.super.Hide(arg_31_0)
	end

	setActive(go(arg_31_0.lScrollrect), true)

	if arg_31_0.scrollRectSpecial then
		setActive(arg_31_0.scrollRectSpecial, false)
	end

	if arg_31_0.shop:GetBGM() ~= "" then
		pg.BgmMgr.GetInstance():Pop(arg_31_0.__cname)
	end

	return
end

function var_0_0.SetUp(arg_32_0, arg_32_1, arg_32_2, arg_32_3)
	arg_32_0:SetShop(arg_32_1)
	arg_32_0:InitCommodities()

	arg_32_0.cards = {}

	arg_32_0:Show()
	arg_32_0:SetPlayer(arg_32_2)
	arg_32_0:SetItems(arg_32_3)
	arg_32_0:InitCommodities()
	arg_32_0:OnSetUp()
	arg_32_0:SetPainting()
	arg_32_0:RefreshUI()

	return
end

function var_0_0.InitCommodities(arg_33_0)
	if pg.activity_template[arg_33_0.shop.activityId] and pg.activity_template[arg_33_0.shop.activityId].config_client and pg.activity_template[arg_33_0.shop.activityId].config_client.category then
		arg_33_0.splitCommodities = arg_33_0.shop:GetSplitCommodities()
		arg_33_0.spiltNameCodes = arg_33_0.shop:GetSplitNameCodes()

		arg_33_0.groupList:align(#arg_33_0.splitCommodities)
	else
		var_0_0.super.InitCommodities(arg_33_0)
	end

	return
end

return var_0_0
