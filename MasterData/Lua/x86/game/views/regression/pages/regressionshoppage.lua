local RegressionShopPage = class("RegressionShopPage", (import("game.views.shop.base.ShopContentViewBase")))

function RegressionShopPage:OnCtor(arg_1_1)
	local var_1_0 = Object.Instantiate(Asset.Load("UI/ReturnUI/RegressionShopUI"), arg_1_1)

	self.gameObject_ = var_1_0
	self.transform_ = var_1_0.transform

	self:Init()
end

function RegressionShopPage:Init()
	self:InitUI()
	self:AddUIListener()
end

function RegressionShopPage:InitUI()
	self:BindCfgUI()

	self.list_ = LuaList.New(handler(self, self.IndexItem), self.listGo_, ExchangeItemView)
end

function RegressionShopPage:AddUIListener()
	return
end

function RegressionShopPage:SetData()
	self:SetShopId(25)
	self:RefreshList()
end

function RegressionShopPage:RefreshList(arg_6_1)
	self:UpdateBarByShopId()

	self.shopDataList_ = self:GetShopGoodList(self.shopId_)

	if arg_6_1 and self.list_:GetNum() == #self.shopDataList_ then
		self.list_:Refresh()
	else
		self.list_:StartScroll(#self.shopDataList_)
	end
end

function RegressionShopPage:IndexItem(arg_7_1, arg_7_2)
	arg_7_2:RegistCallBack(handler(self, self.OnShopClick))
	arg_7_2:SetData(self.shopDataList_[arg_7_1])
end

function RegressionShopPage:GetLuaList()
	return self.list_
end

function RegressionShopPage:GetItemList()
	return self.list_:GetItemList()
end

function RegressionShopPage:ScrollByPosition(arg_10_1, arg_10_2)
	local var_10_0

	if arg_10_2 then
		for iter_10_0, iter_10_1 in ipairs(self.shopDataList_) do
			if iter_10_1.id == arg_10_2 then
				var_10_0 = iter_10_0

				break
			end
		end
	end

	if var_10_0 ~= nil then
		self.list_:ScrollToIndex(var_10_0)
	elseif arg_10_1 then
		self.list_:SetScrolledPosition(arg_10_1)
	end
end

function RegressionShopPage:SetActive(arg_11_1)
	SetActive(self.gameObject_, arg_11_1)
end

function RegressionShopPage:Dispose()
	if self.list_ then
		self.list_:Dispose()

		self.list_ = nil
	end

	RegressionShopPage.super.Dispose(self)
end

return RegressionShopPage
