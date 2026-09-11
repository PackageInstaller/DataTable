local ExchangeEquipItem = class("ExchangeEquipItem", ReduxView)

function ExchangeEquipItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform

	self:Init()
	SetActive(self.gameObject_, true)
end

function ExchangeEquipItem:Init()
	self:InitUI()
end

function ExchangeEquipItem:InitUI()
	self:BindCfgUI()

	self.list1 = LuaList.New(handler(self, self.SetItem1), self.listGo_, EquipExchangeItem)
end

function ExchangeEquipItem:SetItem1(arg_4_1, arg_4_2)
	arg_4_2:SetData(self.data[arg_4_1], arg_4_1, handler(self, self.ClickCallBack), self.equipData)
end

function ExchangeEquipItem:ClickCallBack(arg_5_1, arg_5_2, arg_5_3)
	if self.equipData ~= arg_5_1 then
		self.clickData = arg_5_1

		arg_5_3.selectController:SetSelectedState("true")
	else
		self.clickData = nil

		arg_5_3.selectController:SetSelectedState("false")
	end

	self.callback(self.index, self.clickData, arg_5_3)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.transform_)
end

function ExchangeEquipItem:SetData(arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5, arg_6_6)
	self.data = arg_6_1
	self.indexList = arg_6_3
	self.index = arg_6_4
	self.callback = arg_6_5
	self.equipData = arg_6_6

	self:Show(true)
	self:UpdateView()
end

function ExchangeEquipItem:UpdateView()
	if self.data == nil then
		SetActive(self.gameObject_, false)

		return
	end

	self.list1:StartScrollWithoutAnimator(#self.data)

	self.titleTxt_.text = ""

	SetActive(self.titleGo_.gameObject, false)

	for iter_7_0, iter_7_1 in ipairs(self.indexList) do
		if self.index == iter_7_1 then
			SetActive(self.titleGo_.gameObject, true)

			self.titleTxt_.text = GetTips("SHOP_LABLE_3")
		end
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.transform_)
end

function ExchangeEquipItem:OnEnter()
	self:UpdateView()
end

function ExchangeEquipItem:OnExit()
	for iter_9_0, iter_9_1 in pairs(self.list1:GetItemList()) do
		iter_9_1:OnExit()
	end
end

function ExchangeEquipItem:UpdateTimerView()
	for iter_10_0, iter_10_1 in ipairs(self.list1:GetItemList()) do
		iter_10_1:UpdateTimerView()
	end
end

function ExchangeEquipItem:Dispose()
	self.list1:Dispose()
	ExchangeEquipItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)
end

function ExchangeEquipItem:GetItemHeight()
	return self.rectGo_.sizeDelta.y
end

function ExchangeEquipItem:SetAsLastSibling()
	self.transform_:SetAsLastSibling()
end

function ExchangeEquipItem:SetAsFirstSibling()
	self.transform_:SetAsFirstSibling()
end

function ExchangeEquipItem:GetIndex()
	return self.index
end

function ExchangeEquipItem:IsActive()
	return true
end

function ExchangeEquipItem:IsTimeBar()
	return false
end

function ExchangeEquipItem:Show(arg_18_1)
	SetActive(self.gameObject_, arg_18_1)
end

return ExchangeEquipItem
