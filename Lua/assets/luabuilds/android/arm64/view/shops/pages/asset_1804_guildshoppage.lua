local GuildShopPage = class("GuildShopPage", import(".MilitaryShopPage"))

function GuildShopPage:CanOpen()
	return true
end

function GuildShopPage:CustomInit()
	self.purchaseWindow = GuildShopPurchasePanel.New(self._tf, self.parent.event)

	return
end

function GuildShopPage:UpdateShop(...)
	GuildShopPage.super.UpdateShop(self, ...)

	if self.purchaseWindow:isShowing() then
		self.purchaseWindow:ExecuteAction("Hide")
	end

	return
end

function GuildShopPage:OnUpdatePlayer()
	self:RefreshResItemList()

	return
end

function GuildShopPage:GetResDataList()
	local var_5_0 = {}

	for iter_5_0, iter_5_1 in ipairs((self.shop:GetResList())) do
		table.insert(var_5_0, {
			type = DROP_TYPE_RESOURCE,
			resID = iter_5_1,
			cnt = self.player:getResource(PlayerConst.ResGuildCoin)
		})
	end

	return var_5_0
end

function GuildShopPage:OnSetUp()
	GuildShopPage.super.OnSetUp(self)
	self:UpdateRefreshBtn()

	return
end

function GuildShopPage:UpdateRefreshBtn()
	setButtonEnabled(self.refreshBtn, self.shop:CanRefresh())

	return
end

function GuildShopPage:RefreshUI()
	setActive(self.tipTextGo, false)
	setActive(self.helpBtn, false)
	setActive(self.resolveBtn, false)
	setActive(self.refreshBtn, true)
	onButton(self, self.refreshBtn, function()
		local var_9_0 = self.shop:GetResetConsume()

		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("guild_shop_refresh_all_tip", var_9_0, i18n("word_guildgold")),
			onYes = function()
				if self.player:getResource(PlayerConst.ResGuildCoin) < var_9_0 then
					pg.TipsMgr.GetInstance():ShowTips(i18n("common_no_resource"))

					return
				else
					self:emit(NewShopMainMediator.REFRESH_GUILD_SHOP, true)
				end

				return
			end
		})

		return
	end, SFX_PANEL)
	setButtonEnabled(self.refreshBtn, self.shop:CanRefresh())

	return
end

function GuildShopPage:OnInitItem(arg_11_1)
	local var_11_0 = GuildGoodsCard.New(arg_11_1)

	onButton(self, var_11_0.go, function()
		if not var_11_0.goodsVO:CanPurchase() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("buy_countLimit"))

			return
		end

		self:OnCardClick(var_11_0)

		return
	end, SFX_PANEL)

	self.cards[arg_11_1] = var_11_0

	return
end

function GuildShopPage:OnCardClick(arg_13_1)
	if arg_13_1.goodsVO:Selectable() then
		self.purchaseWindow:ExecuteAction("Show", {
			id = arg_13_1.goodsVO.id,
			count = arg_13_1.goodsVO:GetMaxCnt(),
			type = arg_13_1.goodsVO:getConfig("type"),
			price = arg_13_1.goodsVO:getConfig("price"),
			displays = arg_13_1.goodsVO:getConfig("goods"),
			num = arg_13_1.goodsVO:getConfig("num")
		})
	else
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			yesText = "text_exchange",
			content = i18n("guild_shop_exchange_tip"),
			onYes = function()
				if not arg_13_1.goodsVO:CanPurchase() then
					pg.TipsMgr.GetInstance():ShowTips(i18n("buy_countLimit"))

					return
				end

				self:emit(NewShopMainMediator.ON_GUILD_SHOPPING, arg_13_1.goodsVO.id, arg_13_1.goodsVO:GetFirstDropId())

				return
			end
		})
	end

	return
end

function GuildShopPage:OnTimeOut()
	self:emit(NewShopMainMediator.REFRESH_GUILD_SHOP, false)

	return
end

function GuildShopPage:OnDestroy()
	GuildShopPage.super.OnDestroy(self)

	if self.purchaseWindow then
		self.purchaseWindow:Destroy()

		self.purchaseWindow = nil
	end

	return
end

return GuildShopPage
