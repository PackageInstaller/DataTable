local ShopContentViewWithPoster = class("ShopContentViewWithPoster", ShopContentViewBase)

function ShopContentViewWithPoster.GetAssetPath()
	return
end

function ShopContentViewWithPoster:InitUI()
	self.gameObject_ = Object.Instantiate(Asset.Load(self.GetAssetPath()), self.containerGo_.transform)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()

	self.list_ = LuaList.New(handler(self, self.IndexItem), self.listGo_, ExchangeItemView)
end

function ShopContentViewWithPoster:OnEnter()
	return
end

function ShopContentViewWithPoster:OnExit()
	return
end

function ShopContentViewWithPoster:UpdateListByFilter()
	self:RefreshList()
end

function ShopContentViewWithPoster:GetPoster()
	return getSpriteViaConfig("ShopPoster", self.shopId_)
end

function ShopContentViewWithPoster:RefreshList(arg_7_1)
	self.imageImg_.sprite = self:GetPoster()
	self.shopName.text = ShopListCfg[self.shopId_].remark

	ShopContentViewWithPoster.super.RefreshList(self, arg_7_1)

	self.shopDataList_ = ShopTools.FilterShopDataList(self.shopId_)

	local var_7_0 = {}

	self.selectedPos = self.selectedPos or DormConst.DORM_FURTYPE_OFFSET

	if self.selectedPos ~= DormConst.DORM_FURTYPE_OFFSET then
		for iter_7_0, iter_7_1 in ipairs(self.shopDataList_) do
			local var_7_1 = getShopCfg(iter_7_1.id).give_id

			if self.selectedPos == DormConst.DORM_SUIT_TYPE and BackHomeSuitCfg[var_7_1] or BackHomeFurniture[var_7_1] and self.selectedPos == BackHomeFurniture[var_7_1].type then
				table.insert(var_7_0, iter_7_1)
			end
		end

		self.shopDataList_ = var_7_0
	end

	if arg_7_1 and self.list_:GetNum() == #self.shopDataList_ then
		self.list_:Refresh()
	else
		self.list_:StartScroll(#self.shopDataList_)

		if #self.shopDataList_ == 0 then
			-- block empty
		end
	end
end

function ShopContentViewWithPoster:OnItemClick(arg_8_1)
	return
end

function ShopContentViewWithPoster:IndexItem(arg_9_1, arg_9_2)
	arg_9_2:RegistCallBack(handler(self, self.OnItemClick))
	arg_9_2:SetData(self.shopDataList_[arg_9_1])

	self.contentHeight = self.contentTrs_.rect.height
end

function ShopContentViewWithPoster:ScrollByPosition(arg_10_1, arg_10_2)
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

function ShopContentViewWithPoster:GetLuaList()
	return self.list_
end

function ShopContentViewWithPoster:GetItemList()
	return self.list_:GetItemList()
end

function ShopContentViewWithPoster:Dispose()
	if self.list_ then
		self.list_:Dispose()

		self.list_ = nil
	end

	ShopContentViewWithPoster.super.Dispose(self)
end

return ShopContentViewWithPoster
