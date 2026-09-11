local PolyhedronShopItem = class("PolyhedronShopItem", PolyhedronRewardItem)

function PolyhedronShopItem:InitUI()
	PolyhedronShopItem.super.InitUI(self)
	self.shopControlle:SetSelectedIndex(1)
end

function PolyhedronShopItem:AddUIListener()
	PolyhedronShopItem.super.AddUIListener(self)
	self:AddBtnListener(self.m_shopBtn, nil, function()
		if self.polyhedronInfo:GetCoinCount() < self.priceNum then
			ShowTips("LACK_CURRENCY")

			return
		end

		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("MATRIX_SHOP_BUY_CONFIRM"),
			OkCallback = function()
				PolyhedronAction.QueryBuyShopItem(self.shop_index)
			end,
			CancelCallback = function()
				return
			end
		})
	end)
end

function PolyhedronShopItem:SetData(arg_6_1, arg_6_2, arg_6_3)
	PolyhedronShopItem.super.SetData(self, arg_6_1, arg_6_2, arg_6_3)

	self.shop_index = arg_6_2.shop_index
	self.polyhedronInfo = arg_6_1
	self.priceNum = arg_6_2.price

	local var_6_0 = arg_6_1:GetShopOriginalPrice(arg_6_2.class)

	self.m_shopCost.text = arg_6_2.price

	if var_6_0 ~= arg_6_2.price then
		self.m_discountLab.text = var_6_0

		self.shopDiscountControlle:SetSelectedIndex(1)
	else
		self.shopDiscountControlle:SetSelectedIndex(0)
	end

	self.coinId = arg_6_1:GetPolyhedronCoinId()
	self.m_shopIcon.sprite = ItemTools.getItemLittleSprite(self.coinId)
end

return PolyhedronShopItem
