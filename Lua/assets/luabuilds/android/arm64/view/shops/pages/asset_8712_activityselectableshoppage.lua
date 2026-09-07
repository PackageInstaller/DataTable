local ActivitySelectableShopPage = class("ActivitySelectableShopPage", import(".ActivityShopPage"))

function ActivitySelectableShopPage:CustomInit()
	self.purchaseWindow = ActivityShopPurchasePanel.New(self._tf, self.event)

	self:SetPurchaseConfirmCb()

	return
end

function ActivitySelectableShopPage:UpdateShop(...)
	ActivitySelectableShopPage.super.UpdateShop(self, ...)

	if self.purchaseWindow:isShowing() then
		self.purchaseWindow:ExecuteAction("Hide")
	end

	return
end

function ActivitySelectableShopPage:SetPurchaseConfirmCb(arg_3_1)
	assert("false", "请参考MetaShopPage实现该方法")

	return
end

function ActivitySelectableShopPage:OnInitItem(arg_4_1)
	local var_4_0 = ActivityGoodsCard.New(arg_4_1)

	onButton(self, var_4_0.tf, function()
		if var_4_0.goodsVO:Selectable() then
			self.purchaseWindow:ExecuteAction("Show", {
				icon = "props/21000",
				id = var_4_0.goodsVO.id,
				count = var_4_0.goodsVO:getConfig("num_limit"),
				type = var_4_0.goodsVO:getConfig("commodity_type"),
				price = var_4_0.goodsVO:getConfig("resource_num"),
				displays = var_4_0.goodsVO:getConfig("commodity_id_list"),
				num = var_4_0.goodsVO:getConfig("num")
			})
		else
			self:OnClickCommodity(var_4_0.goodsVO, function(arg_6_0, arg_6_1)
				self:OnPurchase(arg_6_0, arg_6_1)

				return
			end)
		end

		return
	end, SFX_PANEL)

	self.cards[arg_4_1] = var_4_0

	return
end

function ActivitySelectableShopPage:OnDestroy()
	ActivitySelectableShopPage.super.OnDestroy(self)
	self.purchaseWindow:Destroy()

	return
end

return ActivitySelectableShopPage
