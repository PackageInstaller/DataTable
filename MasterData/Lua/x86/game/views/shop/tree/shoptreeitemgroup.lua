local ShopTreeItemGroup = class("ShopTreeItemGroup", ReduxView)

function ShopTreeItemGroup:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.itemGo_ = arg_1_2

	self:Init()
end

function ShopTreeItemGroup:GetContainer()
	return self.transform_
end

function ShopTreeItemGroup:Init()
	self:InitUI()
	self:AddUIListener()
end

function ShopTreeItemGroup:InitUI()
	self.items_ = {}
	self.toggleGroup_ = self.gameObject_:GetComponent(typeof(ToggleGroup))
end

function ShopTreeItemGroup:SetShopIds(arg_5_1, arg_5_2)
	self.shopIdList_ = arg_5_1

	self:UpdateItems()

	if not self.items_[arg_5_2]:GetToggle().isOn then
		self.items_[arg_5_2]:GetToggle().isOn = true
	else
		self:NotifySelect(arg_5_2, self.shopIdList_[arg_5_2])
	end
end

function ShopTreeItemGroup:UpdateItems()
	for iter_6_0 = 1, #self.shopIdList_ do
		if not self.items_[iter_6_0] then
			self.items_[iter_6_0] = ShopTreeItem.New((Object.Instantiate(self.itemGo_, self.transform_)))
			self.items_[iter_6_0]:GetToggle().group = self.toggleGroup_

			self.items_[iter_6_0]:GetToggle().onValueChanged:AddListener(function(arg_7_0)
				if arg_7_0 then
					self:NotifySelect(iter_6_0, self.shopIdList_[iter_6_0])
				end
			end)
		end

		self.items_[iter_6_0]:SetShopId(self.shopIdList_[iter_6_0])
	end

	while #self.items_ > #self.shopIdList_ do
		SetActive(self.items_[#self.items_].gameObject_, false)
		self:DisposeItem(self.items_[#self.items_])
		table.remove(self.items_, #self.items_)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.transform_)
end

function ShopTreeItemGroup:NotifySelect(arg_8_1, arg_8_2)
	if self.selectedCallback_ then
		self.selectedCallback_(arg_8_1, arg_8_2)
	end
end

function ShopTreeItemGroup:SetSelectCallback(arg_9_1)
	self.selectedCallback_ = arg_9_1
end

function ShopTreeItemGroup:AddUIListener()
	return
end

function ShopTreeItemGroup:OnEnter()
	return
end

function ShopTreeItemGroup:OnExit()
	return
end

function ShopTreeItemGroup:Dispose()
	self:RemoveAllListeners()

	if self.items_ then
		for iter_13_0, iter_13_1 in ipairs(self.items_) do
			self:DisposeItem(iter_13_1)
		end

		self.items_ = nil
	end

	self.selectedCallback_ = nil

	ShopTreeItemGroup.super.Dispose(self)
end

function ShopTreeItemGroup:DisposeItem(arg_14_1)
	arg_14_1:GetToggle().onValueChanged:RemoveAllListeners()
	arg_14_1:Dispose()
end

return ShopTreeItemGroup
