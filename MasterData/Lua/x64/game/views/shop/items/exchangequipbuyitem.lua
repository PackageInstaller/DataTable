local ExchangEquipBuyItem = class("ExchangEquipBuyItem", ReduxView)

function ExchangEquipBuyItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform

	self:Init()
	SetActive(self.gameObject_, true)
end

function ExchangEquipBuyItem:Init()
	self:InitUI()
end

function ExchangEquipBuyItem:InitUI()
	self:BindCfgUI()

	self.list = LuaList.New(handler(self, self.SetItem), self.listGo_, EquipGoodsItem)
end

function ExchangEquipBuyItem:SetItem(arg_4_1, arg_4_2)
	arg_4_2:SetData(self.data[arg_4_1], arg_4_1)
end

function ExchangEquipBuyItem:SetData(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	self.data = arg_5_1
	self.index = arg_5_4

	self:Show(true)
	self:UpdateView()
end

function ExchangEquipBuyItem:UpdateTimerView()
	for iter_6_0, iter_6_1 in pairs(self.list:GetItemList()) do
		iter_6_1:UpdateTimerView()
	end
end

function ExchangEquipBuyItem:UpdateView()
	self.list:StartScrollWithoutAnimator(#self.data)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.transform_)
end

function ExchangEquipBuyItem:OnEnter()
	self:UpdateView()
end

function ExchangEquipBuyItem:OnExit()
	for iter_9_0, iter_9_1 in pairs(self.list:GetItemList()) do
		iter_9_1:OnExit()
	end
end

function ExchangEquipBuyItem:Dispose()
	self.list:Dispose()
	ExchangEquipBuyItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)
end

function ExchangEquipBuyItem:GetItemHeight()
	return self.rectGo_.sizeDelta.y
end

function ExchangEquipBuyItem:SetAsLastSibling()
	self.transform_:SetAsLastSibling()
end

function ExchangEquipBuyItem:SetAsFirstSibling()
	self.transform_:SetAsFirstSibling()
end

function ExchangEquipBuyItem:GetIndex()
	return self.index
end

function ExchangEquipBuyItem:IsActive()
	return true
end

function ExchangEquipBuyItem:IsTimeBar()
	return false
end

function ExchangEquipBuyItem:Show(arg_17_1)
	SetActive(self.gameObject_, arg_17_1)
end

return ExchangEquipBuyItem
