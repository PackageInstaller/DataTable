local ExchangeSplitItem = class("ExchangeSplitItem", ReduxView)

function ExchangeSplitItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform

	self:Init()
	SetActive(self.gameObject_, true)
end

function ExchangeSplitItem:Init()
	self:InitUI()
end

function ExchangeSplitItem:InitUI()
	self:BindCfgUI()

	self.list = LuaList.New(handler(self, self.SetItem), self.listGo_, ExchangeItemView)
end

function ExchangeSplitItem:SetItem(arg_4_1, arg_4_2)
	arg_4_2:SetData(self.data[arg_4_1])
end

function ExchangeSplitItem:SetData(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	self.data = arg_5_1
	self.titleIndex = arg_5_2
	self.indexList = arg_5_3
	self.index = arg_5_4

	self:Show(true)
	self:UpdateView()
end

function ExchangeSplitItem:UpdateView()
	self.list:StartScrollWithoutAnimator(#self.data)
	SetActive(self.titleGo_.gameObject, false)

	self.titleTxt_.text = ""

	for iter_6_0, iter_6_1 in ipairs(self.indexList) do
		if self.index == iter_6_1 then
			SetActive(self.titleGo_.gameObject, true)

			local var_6_0 = getShopCfg(self.data[1].id)

			self.titleTxt_.text = ItemCfg[var_6_0.give_id].type == ItemConst.ITEM_TYPE.HERO_PIECE and var_6_0.shop_refresh == 4 and GetTips("SHOP_LABLE_5") or ShopConst.ITEM_TYPE_TO_LABEL[ItemCfg[var_6_0.give_id].type] and GetTips(ShopConst.ITEM_TYPE_TO_LABEL[ItemCfg[var_6_0.give_id].type]) or GetTips("SHOP_LABLE_1")
		end
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.transform_)
end

function ExchangeSplitItem:OnEnter()
	self:UpdateView()
end

function ExchangeSplitItem:UpdateTimerView()
	for iter_8_0, iter_8_1 in ipairs(self.list:GetItemList()) do
		iter_8_1:UpdateTimerView()
	end
end

function ExchangeSplitItem:OnExit()
	for iter_9_0, iter_9_1 in ipairs(self.list:GetItemList()) do
		iter_9_1:OnExit()
	end
end

function ExchangeSplitItem:Dispose()
	self.list:Dispose()
	ExchangeSplitItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)
end

function ExchangeSplitItem:GetItemHeight()
	return self.rectGo_.sizeDelta.y
end

function ExchangeSplitItem:SetAsLastSibling()
	self.transform_:SetAsLastSibling()
end

function ExchangeSplitItem:SetAsFirstSibling()
	self.transform_:SetAsFirstSibling()
end

function ExchangeSplitItem:GetIndex()
	return self.index
end

function ExchangeSplitItem:IsActive()
	return true
end

function ExchangeSplitItem:IsTimeBar()
	return false
end

function ExchangeSplitItem:Show(arg_17_1)
	SetActive(self.gameObject_, arg_17_1)
end

return ExchangeSplitItem
