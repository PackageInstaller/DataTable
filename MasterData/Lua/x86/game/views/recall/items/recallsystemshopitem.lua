local RecallSystemShopItem = class("RecallSystemShopItem", (import("game.views.shop.base.ShopItemBase")))

function RecallSystemShopItem:InitUI()
	self:BindCfgUI()

	self.commonItem_ = CommonItemView.New(self.itemGo_, true)
	self.commonData = clone(ItemTemplateData)
end

function RecallSystemShopItem:AddUIListener()
	self:AddBtnListener(self.buyBtn_, nil, function()
		self:ClickFunction()
	end)
	self:AddBtnListener(self.bgBuyBtn_, nil, function()
		self:ClickFunction()
	end)
end

function RecallSystemShopItem:UpdateView()
	CommonTools.SetCommonData(self.commonItem_, {
		id = self.itemCfg.id,
		clickFun = function(self)
			ShowPopItem(POP_ITEM, {
				self.id,
				self.number
			})
		end
	}, self.commonData)

	self.itemNameTxt_.text = string.format("%s x%d", ItemTools.getItemName(self.itemCfg.id), self.shopCfg.give)

	self:SetPriceText()
	self:SetCostIcon()

	if self.shopCfg.limit_num == -1 or self.shopCfg.limit_num == nil then
		SetActive(self.buyLimitGo_, false)
		SetActive(self.buyLimitTxt_.gameObject, false)
		SetActive(self.maskGo_, false)
	elseif self.shopCfg.limit_num - self.data.buyTime > 0 then
		SetActive(self.buyLimitTxt_.gameObject, true)
		SetActive(self.buyLimitGo_, true)
		SetActive(self.maskGo_, false)

		self.buyLimitTxt_.text = string.format("<color=#0d89bf>%d</color>/%d", self.shopCfg.limit_num - self.data.buyTime, self.shopCfg.limit_num)
	else
		SetActive(self.buyLimitTxt_.gameObject, false)
		SetActive(self.buyLimitGo_, false)
		SetActive(self.maskGo_, true)
	end
end

function RecallSystemShopItem:Dispose()
	self.commonItem_:Dispose()
	RecallSystemShopItem.super.Dispose(self)
end

return RecallSystemShopItem
