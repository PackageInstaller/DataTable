local IslandTradeProductListPage = class("IslandTradeProductListPage", import("view.base.BaseSubView"))

function IslandTradeProductListPage:getUIName()
	return "IslandTradeProductListUI"
end

function IslandTradeProductListPage:OnLoaded()
	self.uiitemList = UIItemList.New(self._tf:Find("shopView/Viewport/Content"), self._tf:Find("shopView/Viewport/Content/tpl"))

	return
end

function IslandTradeProductListPage:Show(arg_3_1)
	IslandTradeProductListPage.super.Show(self)

	self.island = arg_3_1

	self:UpdateProductList()

	return
end

function IslandTradeProductListPage:GetDisplays()
	return {
		IslandItem.New({
			num = 1,
			id = IslandItem.PEARL_ID
		})
	}
end

function IslandTradeProductListPage:UpdateProductList()
	local var_5_0 = self:GetDisplays()

	self.uiitemList:make(function(arg_6_0, arg_6_1, arg_6_2)
		if arg_6_0 == UIItemList.EventUpdate then
			self:UpdateItem(arg_6_2, var_5_0[arg_6_1 + 1])
		end

		return
	end)
	self.uiitemList:align(#var_5_0)

	return
end

function IslandTradeProductListPage:GetPrice()
	return (self.island:GetTradeAgency():GetTodayPrice())
end

function IslandTradeProductListPage:UpdateItem(arg_8_1, arg_8_2)
	setText(arg_8_1:Find("name"), arg_8_2:getConfig("name"))
	updateCustomDrop(arg_8_1:Find("item"), Drop.New({
		count = 0,
		type = DROP_TYPE_ISLAND_ITEM,
		id = arg_8_2.id
	}))
	setText(arg_8_1:Find("name"), arg_8_2:getConfig("name"))
	setText(arg_8_1:Find("cost/num"), self:GetPrice())
	onButton(self, arg_8_1, function()
		self:OnClick()

		return
	end, SFX_PANEL)

	return
end

function IslandTradeProductListPage:OnClick()
	self:emit(IslandTradePage.OPEN_CONFIRM_PAGE, IslandConst.TRADE_PURCHASE)

	return
end

return IslandTradeProductListPage
