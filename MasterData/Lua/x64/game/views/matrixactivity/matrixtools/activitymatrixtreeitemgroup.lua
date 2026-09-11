local ActivityMatrixTreeItemGroup = class("ActivityMatrixTreeItemGroup", MatrixTreeItemGroup)

function ActivityMatrixTreeItemGroup:SetData(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	self.tag_ = arg_1_1
	self.list_ = arg_1_3
	self.matrix_activity_id = arg_1_4

	self:UpdateItems()

	if not self.items_[arg_1_2]:GetToggle().isOn then
		self.items_[arg_1_2]:GetToggle().isOn = true
	else
		self:NotifySelect(self.tag_, arg_1_2, self.list_[arg_1_2])
	end
end

function ActivityMatrixTreeItemGroup:UpdateItems()
	for iter_2_0 = 1, #self.list_ do
		if not self.items_[iter_2_0] then
			self.items_[iter_2_0] = ActivityMatrixTreeItem.New((Object.Instantiate(self.itemGo_, self.transform_)))
			self.items_[iter_2_0]:GetToggle().group = self.toggleGroup_

			self.items_[iter_2_0]:GetToggle().onValueChanged:AddListener(function(arg_3_0)
				if arg_3_0 then
					self:NotifySelect(self.tag_, iter_2_0, self.list_[iter_2_0])
				end
			end)
		end

		self.items_[iter_2_0]:SetData(self.tag_, self.list_[iter_2_0], self.matrix_activity_id)
	end

	while #self.items_ > #self.list_ do
		SetActive(self.items_[#self.items_].gameObject_, false)
		self:DisposeItem(self.items_[#self.items_])
		table.remove(self.items_, #self.items_)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.transform_)
end

return ActivityMatrixTreeItemGroup
