local ShamShopPage = class("ShamShopPage", import(".BaseShopPage"))

function ShamShopPage:GetPaintingCommodityUpdateVoice()
	return
end

function ShamShopPage:CanOpen(arg_2_1, arg_2_2)
	return pg.SystemOpenMgr.GetInstance():isOpenSystem(arg_2_2.level, "ShamShop")
end

function ShamShopPage:OnUpdateItems()
	self:RefreshResItemList()

	return
end

function ShamShopPage:GetResDataList()
	local var_4_0 = {}

	for iter_4_0, iter_4_1 in ipairs((self.shop:GetResList())) do
		local var_4_2 = self.items[ChapterConst.ShamMoneyItem]

		table.insert(var_4_0, {
			type = DROP_TYPE_ITEM,
			resID = iter_4_1,
			cnt = not self.items[ChapterConst.ShamMoneyItem] and 0 or var_4_2.count
		})
	end

	return var_4_0
end

function ShamShopPage:OnUpdateCommodity(arg_5_1)
	local var_5_0

	for iter_5_0, iter_5_1 in pairs(self.cards) do
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

function ShamShopPage:RefreshUI()
	self:UpdateTip()
	setActive(self.tipTextGo, true)
	setActive(self.helpBtn, false)
	setActive(self.resolveBtn, false)
	setActive(self.refreshBtn, false)

	return
end

function ShamShopPage:OnInitItem(arg_7_1)
	local var_7_0 = ActivityGoodsCard.New(arg_7_1)

	onButton(self, var_7_0.tf, function()
		if not var_7_0.goodsVO:canPurchase() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("buy_countLimit"))

			return
		end

		self:OnClickCommodity(var_7_0.goodsVO, function(arg_9_0, arg_9_1)
			self:OnPurchase(arg_9_0, arg_9_1)

			return
		end)

		return
	end, SFX_PANEL)

	self.cards[arg_7_1] = var_7_0

	return
end

function ShamShopPage:OnUpdateItem(arg_10_1, arg_10_2)
	if not self.cards[arg_10_2] then
		self:OnInitItem(arg_10_2)
	end

	self.cards[arg_10_2]:update(self.displays[arg_10_1 + 1])

	return
end

function ShamShopPage:OnUpdateAll()
	self:InitCommodities()
	self:OnSetUp()

	return
end

function ShamShopPage:OnSetUp()
	self:UpdateTip()

	return
end

function ShamShopPage:UpdateTip()
	setText(self.tipText, i18n("title_limit_time") .. i18n("shops_rest_day") .. string.format("%02d", self.shop:getRestDays()) .. i18n("word_date"))

	return
end

function ShamShopPage:OnPurchase(arg_14_1, arg_14_2)
	self:emit(NewShopMainMediator.ON_SHAM_SHOPPING, arg_14_1.id, arg_14_2)

	return
end

function ShamShopPage:OnDestroy()
	ShamShopPage.super.OnDestroy(self)

	return
end

return ShamShopPage
