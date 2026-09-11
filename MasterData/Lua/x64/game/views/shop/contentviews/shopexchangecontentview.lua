local ShopExchangeContentView = class("ShopExchangeContentView", ShopContentViewBase)

function ShopExchangeContentView:InitUI()
	local var_1_0 = Asset.Load("Widget/System/Shop/contentViews/defaultView")

	var_1_0.name = "exchangeContentUI"
	self.gameObject_ = Object.Instantiate(var_1_0, self.containerGo_.transform)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()

	self.list_ = LuaList.New(handler(self, self.IndexItem), self.listGo_, ExchangeItemView)
end

function ShopExchangeContentView:RefreshList(arg_2_1)
	ShopExchangeContentView.super.RefreshList(self, arg_2_1)

	self.shopDataList_ = self:GetExchangeGoodList(self.shopId_)

	if arg_2_1 and self.list_:GetNum() == #self.shopDataList_ then
		self.list_:Refresh()
	else
		self.list_:StartScroll(#self.shopDataList_)
	end
end

function ShopExchangeContentView:IndexItem(arg_3_1, arg_3_2)
	arg_3_2:SetData(self.shopDataList_[arg_3_1])
end

function ShopExchangeContentView:GetLuaList()
	return self.list_
end

function ShopExchangeContentView:GetItemList()
	return self.list_:GetItemList()
end

function ShopExchangeContentView:ScrollByPosition(arg_6_1, arg_6_2)
	local var_6_0

	if arg_6_2 then
		for iter_6_0, iter_6_1 in ipairs(self.shopDataList_) do
			if iter_6_1.id == arg_6_2 then
				var_6_0 = iter_6_0

				break
			end
		end
	end

	if var_6_0 ~= nil then
		self.list_:ScrollToIndex(var_6_0)
	elseif arg_6_1 then
		self.list_:SetScrolledPosition(arg_6_1)
	end
end

function ShopExchangeContentView:GetExchangeGoodList()
	return ShopTools.FilterShopDataList(self.shopId_, ShopListCfg[self.shopId_].chain_last_visible == 1)
end

function ShopExchangeContentView:Dispose()
	if self.list_ then
		self.list_:Dispose()

		self.list_ = nil
	end

	ShopExchangeContentView.super.Dispose(self)
end

return ShopExchangeContentView
