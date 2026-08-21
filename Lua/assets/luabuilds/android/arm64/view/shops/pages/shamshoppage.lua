local var_0_0 = class("ShamShopPage", import(".BaseShopPage"))

function var_0_0.GetPaintingCommodityUpdateVoice(arg_1_0)
	return
end

function var_0_0.CanOpen(arg_2_0, arg_2_1, arg_2_2)
	return pg.SystemOpenMgr.GetInstance():isOpenSystem(arg_2_2.level, "ShamShop")
end

function var_0_0.OnUpdateItems(arg_3_0)
	arg_3_0:RefreshResItemList()

	return
end

function var_0_0.GetResDataList(arg_4_0)
	for iter_4_0, iter_4_1 in ipairs((arg_4_0.shop:GetResList())) do
		local var_4_1 = arg_4_0.items[ChapterConst.ShamMoneyItem]

		table.insert({}, {
			type = DROP_TYPE_ITEM,
			resID = iter_4_1,
			cnt = not arg_4_0.items[ChapterConst.ShamMoneyItem] and 0 or var_4_1.count
		})
	end

	return {}
end

function var_0_0.OnUpdateCommodity(arg_5_0, arg_5_1)
	local var_5_0

	for iter_5_0, iter_5_1 in pairs(arg_5_0.cards) do
		if iter_5_1.goodsVO.id == arg_5_1.id then
			var_5_0 = iter_5_1

			break
		end
	end

	if var_5_0 then
		var_5_0:update(arg_5_1)
	end

	return
end

function var_0_0.RefreshUI(arg_6_0)
	arg_6_0:UpdateTip()
	setActive(arg_6_0.tipTextGo, true)
	setActive(arg_6_0.helpBtn, false)
	setActive(arg_6_0.resolveBtn, false)
	setActive(arg_6_0.refreshBtn, false)

	return
end

function var_0_0.OnInitItem(arg_7_0, arg_7_1)
	local var_7_0 = ActivityGoodsCard.New(arg_7_1)

	onButton(arg_7_0, var_7_0.tf, function()
		if not var_7_0.goodsVO:canPurchase() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("buy_countLimit"))

			return
		end

		arg_7_0:OnClickCommodity(var_7_0.goodsVO, function(arg_9_0, arg_9_1)
			arg_7_0:OnPurchase(arg_9_0, arg_9_1)

			return
		end)

		return
	end, SFX_PANEL)

	arg_7_0.cards[arg_7_1] = var_7_0

	return
end

function var_0_0.OnUpdateItem(arg_10_0, arg_10_1, arg_10_2)
	if not arg_10_0.cards[arg_10_2] then
		arg_10_0:OnInitItem(arg_10_2)
	end

	arg_10_0.cards[arg_10_2]:update(arg_10_0.displays[arg_10_1 + 1])

	return
end

function var_0_0.OnUpdateAll(arg_11_0)
	arg_11_0:InitCommodities()
	arg_11_0:OnSetUp()

	return
end

function var_0_0.OnSetUp(arg_12_0)
	arg_12_0:UpdateTip()

	return
end

function var_0_0.UpdateTip(arg_13_0)
	setText(arg_13_0.tipText, i18n("title_limit_time") .. i18n("shops_rest_day") .. string.format("%02d", arg_13_0.shop:getRestDays()) .. i18n("word_date"))

	return
end

function var_0_0.OnPurchase(arg_14_0, arg_14_1, arg_14_2)
	arg_14_0:emit(NewShopMainMediator.ON_SHAM_SHOPPING, arg_14_1.id, arg_14_2)

	return
end

function var_0_0.OnDestroy(arg_15_0)
	var_0_0.super.OnDestroy(arg_15_0)

	return
end

return var_0_0
