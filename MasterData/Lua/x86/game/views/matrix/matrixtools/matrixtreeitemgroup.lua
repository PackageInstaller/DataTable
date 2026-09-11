local MatrixTreeItemGroup = class("MatrixTreeItemGroup", ReduxView)

function MatrixTreeItemGroup:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.itemGo_ = arg_1_2

	self:Init()
end

function MatrixTreeItemGroup:GetContainer()
	return self.transform_
end

function MatrixTreeItemGroup:Init()
	self:InitUI()
end

function MatrixTreeItemGroup:InitUI()
	self.items_ = {}
	self.toggleGroup_ = self.gameObject_:GetComponent(typeof(ToggleGroup))
end

function MatrixTreeItemGroup:SetData(arg_5_1, arg_5_2, arg_5_3)
	self.tag_ = arg_5_1
	self.list_ = arg_5_3

	self:UpdateItems()

	if not self.items_[arg_5_2]:GetToggle().isOn then
		self.items_[arg_5_2]:GetToggle().isOn = true
	else
		self:NotifySelect(self.tag_, arg_5_2, self.list_[arg_5_2])
	end
end

function MatrixTreeItemGroup:UpdateItems()
	for iter_6_0 = 1, #self.list_ do
		if not self.items_[iter_6_0] then
			self.items_[iter_6_0] = MatrixTreeItem.New((Object.Instantiate(self.itemGo_, self.transform_)))
			self.items_[iter_6_0]:GetToggle().group = self.toggleGroup_

			self.items_[iter_6_0]:GetToggle().onValueChanged:AddListener(function(arg_7_0)
				if arg_7_0 then
					self:NotifySelect(self.tag_, iter_6_0, self.list_[iter_6_0])
				end
			end)
		end

		self.items_[iter_6_0]:SetData(self.tag_, self.list_[iter_6_0])
	end

	while #self.items_ > #self.list_ do
		SetActive(self.items_[#self.items_].gameObject_, false)
		self:DisposeItem(self.items_[#self.items_])
		table.remove(self.items_, #self.items_)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.transform_)
end

function MatrixTreeItemGroup:NotifySelect(arg_8_1, arg_8_2, arg_8_3)
	if self.selectedCallback_ then
		self.selectedCallback_(arg_8_1, arg_8_2, arg_8_3)
	end
end

function MatrixTreeItemGroup:SetSelectCallback(arg_9_1)
	self.selectedCallback_ = arg_9_1
end

function MatrixTreeItemGroup:Dispose()
	self:RemoveAllListeners()

	if self.items_ then
		for iter_10_0, iter_10_1 in ipairs(self.items_) do
			self:DisposeItem(iter_10_1)
		end

		self.items_ = nil
	end

	self.selectedCallback_ = nil

	MatrixTreeItemGroup.super.Dispose(self)
end

function MatrixTreeItemGroup:DisposeItem(arg_11_1)
	arg_11_1:GetToggle().onValueChanged:RemoveAllListeners()
	arg_11_1:Dispose()
end

return MatrixTreeItemGroup
