local QuotaShopPage = class("QuotaShopPage", import(".BaseShopPage"))

function QuotaShopPage:GetPaintingCommodityUpdateVoice()
	return
end

function QuotaShopPage:CanOpen(arg_2_1, arg_2_2)
	return pg.SystemOpenMgr.GetInstance():isOpenSystem(arg_2_2.level, "QuotaShop")
end

function QuotaShopPage:RefreshUI()
	self:UpdateTip()
	setActive(self.tipTextGo, true)
	setActive(self.helpBtn, false)
	setActive(self.resolveBtn, false)
	setActive(self.refreshBtn, false)

	return
end

function QuotaShopPage:UpdateTip()
	setText(self.tipText, i18n("quota_shop_description"))

	return
end

function QuotaShopPage:OnUpdateItems()
	self:RefreshResItemList()

	return
end

function QuotaShopPage:GetResDataList()
	local var_6_0 = {}

	for iter_6_0, iter_6_1 in ipairs((self.shop:GetResList())) do
		local var_6_2 = self.items[ChapterConst.ShamMoneyItem]

		table.insert(var_6_0, {
			type = DROP_TYPE_ITEM,
			resID = iter_6_1,
			cnt = not self.items[ChapterConst.ShamMoneyItem] and 0 or var_6_2.count
		})
	end

	return var_6_0
end

function QuotaShopPage:OnUpdateCommodity(arg_7_1)
	local var_7_0

	for iter_7_0, iter_7_1 in pairs(self.cards) do
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

function QuotaShopPage:OnInitItem(arg_8_1)
	local var_8_0 = QuotaGoodsCard.New(arg_8_1)

	onButton(self, var_8_0.tf, function()
		if not var_8_0.goodsVO:canPurchase() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("buy_countLimit"))

			return
		end

		self:OnClickCommodity(var_8_0.goodsVO, function(arg_10_0, arg_10_1)
			self:OnPurchase(arg_10_0, arg_10_1)

			return
		end)

		return
	end, SFX_PANEL)

	self.cards[arg_8_1] = var_8_0

	return
end

function QuotaShopPage:OnUpdateItem(arg_11_1, arg_11_2)
	if not self.cards[arg_11_2] then
		self:OnInitItem(arg_11_2)
	end

	self.cards[arg_11_2]:update(self.displays[arg_11_1 + 1])

	return
end

function QuotaShopPage:OnUpdateAll()
	self:InitCommodities()

	return
end

function QuotaShopPage:OnPurchase(arg_13_1, arg_13_2)
	self:emit(NewShopMainMediator.ON_QUOTA_SHOPPING, arg_13_1.id, arg_13_2)

	return
end

function QuotaShopPage:OnDestroy()
	QuotaShopPage.super.OnDestroy(self)

	return
end

return QuotaShopPage
