local NewServerShopPurchasePanel = class("NewServerShopPurchasePanel", import(".GuildShopPurchasePanel"))

function NewServerShopPurchasePanel:Show(arg_1_1)
	local var_1_0 = arg_1_1:GetConsume()

	self.commodity = arg_1_1

	NewServerShopPurchasePanel.super.Show(self, {
		id = arg_1_1.id,
		count = arg_1_1:GetCanPurchaseCnt(),
		type = arg_1_1:GetDropType(),
		price = var_1_0.count,
		displays = arg_1_1:GetSelectableGoods()
	})

	self.limitOnePurchase = arg_1_1:LimitPurchaseSubGoods()
	self.descTxt.text = self.limitOnePurchase and i18n("new_server_shop_sel_goods_tip") or ""

	GetImageSpriteFromAtlasAsync(var_1_0:getConfig("icon"), "", self.resIcon)

	return
end

function NewServerShopPurchasePanel:UpdateItem(arg_2_1, arg_2_2, arg_2_3)
	NewServerShopPurchasePanel.super.UpdateItem(self, arg_2_1, arg_2_2, arg_2_3)
	setActive(arg_2_3:Find("mask"), not self.commodity:CanPurchaseSubGoods(arg_2_2))

	return
end

function NewServerShopPurchasePanel:ClickItem(arg_3_1, arg_3_2)
	if self.limitOnePurchase and not self.commodity:CanPurchaseSubGoods(arg_3_2) then
		return
	end

	NewServerShopPurchasePanel.super.ClickItem(self, arg_3_1, arg_3_2)

	return
end

function NewServerShopPurchasePanel:PressAddBtn(arg_4_1, arg_4_2)
	if self.limitOnePurchase and table.contains(self.selectedList, arg_4_2) then
		return
	end

	NewServerShopPurchasePanel.super.PressAddBtn(self, arg_4_1, arg_4_2)

	return
end

function NewServerShopPurchasePanel:OnConfirm()
	pg.m02:sendNotification(GAME.NEW_SERVER_SHOP_SHOPPING, {
		id = self.commodity.id,
		selectedList = self.selectedList
	})

	return
end

return NewServerShopPurchasePanel
