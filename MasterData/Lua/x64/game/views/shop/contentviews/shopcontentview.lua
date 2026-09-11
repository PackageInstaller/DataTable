local ShopContentView = class("ShopContentView", ShopContentViewBase)

function ShopContentView:InitUI()
	local var_1_0 = Asset.Load("Widget/System/Shop/contentViews/defaultView")

	var_1_0.name = "shopContentUI"
	self.gameObject_ = Object.Instantiate(var_1_0, self.containerGo_.transform)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()

	self.list_ = LuaList.New(handler(self, self.IndexItem), self.listGo_, ExchangeItemView)
end

function ShopContentView:RefreshList(arg_2_1)
	ShopContentView.super.RefreshList(self, arg_2_1)
	self:UpdateBarByShopId()

	self.shopDataList_ = self:GetShopGoodList(self.shopId_)

	if arg_2_1 and self.list_:GetNum() == #self.shopDataList_ then
		self.list_:Refresh()
	else
		self.list_:StartScroll(#self.shopDataList_)
	end
end

function ShopContentView:IndexItem(arg_3_1, arg_3_2)
	arg_3_2:RegistCallBack(handler(self, self.OnShopClick))
	arg_3_2:SetData(self.shopDataList_[arg_3_1])
end

function ShopContentView:GetLuaList()
	return self.list_
end

function ShopContentView:GetItemList()
	return self.list_:GetItemList()
end

function ShopContentView:ScrollByPosition(arg_6_1, arg_6_2)
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

function ShopContentView:Dispose()
	if self.list_ then
		self.list_:Dispose()

		self.list_ = nil
	end

	ShopContentView.super.Dispose(self)
end

function ShopContentView:GetItemList()
	return self.list_:GetItemList()
end

return ShopContentView
