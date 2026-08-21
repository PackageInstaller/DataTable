local var_0_0 = class("QuotaShopPage", import(".BaseShopPage"))

function var_0_0.GetPaintingCommodityUpdateVoice(arg_1_0)
	return
end

function var_0_0.CanOpen(arg_2_0, arg_2_1, arg_2_2)
	return pg.SystemOpenMgr.GetInstance():isOpenSystem(arg_2_2.level, "QuotaShop")
end

function var_0_0.RefreshUI(arg_3_0)
	arg_3_0:UpdateTip()
	setActive(arg_3_0.tipTextGo, true)
	setActive(arg_3_0.helpBtn, false)
	setActive(arg_3_0.resolveBtn, false)
	setActive(arg_3_0.refreshBtn, false)

	return
end

function var_0_0.UpdateTip(arg_4_0)
	setText(arg_4_0.tipText, i18n("quota_shop_description"))

	return
end

function var_0_0.OnUpdateItems(arg_5_0)
	arg_5_0:RefreshResItemList()

	return
end

function var_0_0.GetResDataList(arg_6_0)
	for iter_6_0, iter_6_1 in ipairs((arg_6_0.shop:GetResList())) do
		local var_6_1 = arg_6_0.items[ChapterConst.ShamMoneyItem]

		table.insert({}, {
			type = DROP_TYPE_ITEM,
			resID = iter_6_1,
			cnt = not arg_6_0.items[ChapterConst.ShamMoneyItem] and 0 or var_6_1.count
		})
	end

	return {}
end

function var_0_0.OnUpdateCommodity(arg_7_0, arg_7_1)
	local var_7_0

	for iter_7_0, iter_7_1 in pairs(arg_7_0.cards) do
		if iter_7_1.goodsVO.id == arg_7_1.id then
			var_7_0 = iter_7_1

			break
		end
	end

	if var_7_0 then
		var_7_0:update(arg_7_1)
	end

	return
end

function var_0_0.OnInitItem(arg_8_0, arg_8_1)
	local var_8_0 = QuotaGoodsCard.New(arg_8_1)

	onButton(arg_8_0, var_8_0.tf, function()
		if not var_8_0.goodsVO:canPurchase() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("buy_countLimit"))

			return
		end

		arg_8_0:OnClickCommodity(var_8_0.goodsVO, function(arg_10_0, arg_10_1)
			arg_8_0:OnPurchase(arg_10_0, arg_10_1)

			return
		end)

		return
	end, SFX_PANEL)

	arg_8_0.cards[arg_8_1] = var_8_0

	return
end

function var_0_0.OnUpdateItem(arg_11_0, arg_11_1, arg_11_2)
	if not arg_11_0.cards[arg_11_2] then
		arg_11_0:OnInitItem(arg_11_2)
	end

	arg_11_0.cards[arg_11_2]:update(arg_11_0.displays[arg_11_1 + 1])

	return
end

function var_0_0.OnUpdateAll(arg_12_0)
	arg_12_0:InitCommodities()

	return
end

function var_0_0.OnPurchase(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0:emit(NewShopMainMediator.ON_QUOTA_SHOPPING, arg_13_1.id, arg_13_2)

	return
end

function var_0_0.OnDestroy(arg_14_0)
	var_0_0.super.OnDestroy(arg_14_0)

	return
end

return var_0_0
