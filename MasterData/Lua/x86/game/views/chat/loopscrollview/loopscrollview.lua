local LoopScrollView = class("LoopScrollView", BaseView)

function LoopScrollView:Ctor(arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6, arg_1_7, arg_1_8)
	self.parentView_ = arg_1_1
	self.scrollView_ = arg_1_2
	self.viewPort_ = arg_1_4
	self.rectGrid_ = arg_1_3
	self.itemList_ = {}
	self.contentHeight_ = 0
	self.itemSpace_ = arg_1_6
	self.padding_ = arg_1_3:GetComponent("HorizontalOrVerticalLayoutGroup").padding
	self.currentHeight_ = arg_1_5
	self.isBottom_ = arg_1_7
	self.isHorizontal = arg_1_8

	self:AddListeners()
end

function LoopScrollView:Dispose()
	self:RemoveAllListeners()

	self.itemList_ = nil
end

function LoopScrollView:AddListeners()
	self:AddToggleListener(self.scrollView_, function(arg_4_0)
		if self.isHorizontal then
			if arg_4_0.x < 0 or arg_4_0.x == 0 and self.rectGrid_.anchoredPosition.x > 0 then
				self:DeleteItem(false)
				self:AddHeadItem()
			elseif arg_4_0.x > 1 or arg_4_0.x == 1 and self.rectGrid_.anchoredPosition.x < 0 then
				self:DeleteItem(true)
				self:AddTailItem()
			end
		elseif arg_4_0.y < 0 or arg_4_0.y == 0 and self.rectGrid_.anchoredPosition.y > 0 then
			self:DeleteItem(true)
			self:AddTailItem()
		elseif arg_4_0.y > 1 or arg_4_0.y == 1 and self.rectGrid_.anchoredPosition.y < 0 then
			self:DeleteItem(false)
			self:AddHeadItem()
		end
	end)
end

function LoopScrollView:GetContentHeight()
	if self.isHorizontal then
		return self.currentHeight_ - self.padding_.left
	else
		return self.currentHeight_ - self.padding_.top
	end
end

function LoopScrollView:SetContentHeight(arg_6_1)
	self.currentHeight_ = arg_6_1
end

function LoopScrollView:RestoredScroll(arg_7_1, arg_7_2)
	self:NavigateIndex(arg_7_1)
	LayoutRebuilder.ForceRebuildLayoutImmediate(self.rectGrid_)

	if self.isHorizontal then
		self.scrollView_.horizontalNormalizedPosition = arg_7_2
	else
		self.scrollView_.verticalNormalizedPosition = arg_7_2
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(self.rectGrid_)
end

function LoopScrollView:NavigateIndex(arg_8_1, arg_8_2, arg_8_3)
	arg_8_2 = arg_8_2 or 0

	if not arg_8_3 then
		if self.isHorizontal then
			self.scrollView_.horizontalNormalizedPosition = 0.9999
		else
			self.scrollView_.verticalNormalizedPosition = 0.9999
		end
	end

	for iter_8_0 = #self.itemList_, 1, -1 do
		self.parentView_:LsRemoveItem(self.itemList_[iter_8_0])
		table.remove(self.itemList_, #self.itemList_)
	end

	self.contentHeight_ = 0

	local var_8_0 = self.parentView_:LsGetItemData()

	for iter_8_1 = arg_8_1, #var_8_0 do
		local var_8_1 = self.parentView_:LsAddItem(var_8_0[iter_8_1], iter_8_1)

		table.insert(self.itemList_, var_8_1)
		var_8_1.itemView:SetAsLastSibling()

		if var_8_1.itemView:IsActive() then
			self.contentHeight_ = self.contentHeight_ + self.itemSpace_ + var_8_1.itemView:GetItemHeight()
		end

		if self.contentHeight_ >= self:GetContentHeight() + math.abs(arg_8_2) then
			break
		end
	end

	if self.isBottom_ and self.contentHeight_ < self:GetContentHeight() then
		self:Scroll2End()
	end
end

function LoopScrollView:Scroll2End()
	for iter_9_0 = #self.itemList_, 1, -1 do
		self.parentView_:LsRemoveItem(self.itemList_[iter_9_0])
		table.remove(self.itemList_, iter_9_0)
	end

	self.contentHeight_ = 0

	local var_9_0 = self.parentView_:LsGetItemData()

	for iter_9_1 = #var_9_0, 1, -1 do
		local var_9_1 = self.parentView_:LsAddItem(var_9_0[iter_9_1], iter_9_1)

		table.insert(self.itemList_, 1, var_9_1)
		var_9_1.itemView:SetAsFirstSibling()

		if var_9_1.itemView:IsActive() then
			self.contentHeight_ = self.contentHeight_ + self.itemSpace_ + var_9_1.itemView:GetItemHeight()
		end

		if self.contentHeight_ >= self:GetContentHeight() then
			break
		end
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(self.rectGrid_)

	if self.isHorizontal then
		self.scrollView_.horizontalNormalizedPosition = 0.0001
	else
		self.scrollView_.verticalNormalizedPosition = 0.0001
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(self.rectGrid_)
end

function LoopScrollView:RefreshScrollView(arg_10_1, arg_10_2)
	local var_10_0 = 0.99999
	local var_10_1

	if arg_10_2 then
		var_10_0 = self.isHorizontal and self.scrollView_.horizontalNormalizedPosition or self.scrollView_.verticalNormalizedPosition
		var_10_1 = self.rectGrid_.localPosition
	else
		var_10_1 = Vector2.zero
	end

	if #self.itemList_ <= 0 then
		self:NavigateIndex(1)

		if self.isHorizontal then
			self.scrollView_.horizontalNormalizedPosition = var_10_0
		else
			self.scrollView_.verticalNormalizedPosition = var_10_0
		end

		LayoutRebuilder.ForceRebuildLayoutImmediate(self.rectGrid_)

		return
	end

	local var_10_3 = self.itemList_[1].itemView:GetIndex()

	if self.itemList_[1].itemView:IsActive() == false then
		self:NavigateIndex(var_10_3)

		if self.isHorizontal then
			self.scrollView_.horizontalNormalizedPosition = var_10_0
		else
			self.scrollView_.verticalNormalizedPosition = var_10_0
		end

		LayoutRebuilder.ForceRebuildLayoutImmediate(self.rectGrid_)

		return
	end

	local var_10_4 = self.parentView_:LsGetItemData()

	if #var_10_4 <= 0 then
		self:DeleteAllItem()

		if self.isHorizontal then
			self.scrollView_.horizontalNormalizedPosition = var_10_0
		else
			self.scrollView_.verticalNormalizedPosition = var_10_0
		end

		LayoutRebuilder.ForceRebuildLayoutImmediate(self.rectGrid_)

		return
	end

	local var_10_5 = var_10_4[var_10_3]

	if arg_10_1 then
		self:DeleteAllItem()

		if self.isHorizontal then
			self:NavigateIndex(var_10_3, var_10_1.x)
		else
			self:NavigateIndex(var_10_3, var_10_1.y)
		end

		self.rectGrid_.localPosition = var_10_1

		if self.isHorizontal then
			self.scrollView_.horizontalNormalizedPosition = var_10_0
		else
			self.scrollView_.verticalNormalizedPosition = var_10_0
		end

		if self.contentHeight_ < self:GetContentHeight() then
			self:Scroll2End()
		end

		return
	else
		self.parentView_:LsUpdateItem(self.itemList_[1], var_10_5, var_10_3)

		for iter_10_0 = #self.itemList_, 2, -1 do
			self.parentView_:LsRemoveItem(self.itemList_[iter_10_0])
			table.remove(self.itemList_, iter_10_0)
		end

		self.contentHeight_ = self.itemSpace_ + self.itemList_[1].itemView:GetItemHeight()
	end

	self:AddTail2End()
	LayoutRebuilder.ForceRebuildLayoutImmediate(self.rectGrid_)

	if self.isHorizontal then
		self.scrollView_.horizontalNormalizedPosition = var_10_0
	else
		self.scrollView_.verticalNormalizedPosition = var_10_0
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(self.rectGrid_)
end

function LoopScrollView:AddTail2End()
	local var_11_0 = self.parentView_:LsGetItemData()

	if #var_11_0 <= 0 then
		return
	end

	while self.contentHeight_ < self:GetContentHeight() do
		if #self.itemList_ > 0 and self.itemList_[#self.itemList_].itemView:GetIndex() + 1 > #var_11_0 then
			break
		end

		self:AddTailItem()
	end

	self:AddTailItem()

	while self.contentHeight_ < self:GetContentHeight() do
		if #self.itemList_ > 0 and self.itemList_[1].itemView:GetIndex() - 1 <= 0 then
			break
		end

		self:AddHeadItem()
	end
end

function LoopScrollView:DeleteIndex(arg_12_1)
	for iter_12_0 = #self.itemList_, arg_12_1, -1 do
		self.parentView_:LsRemoveItem(self.itemList_[iter_12_0])

		if self.itemList_[iter_12_0].itemView:IsActive() then
			self.contentHeight_ = self.contentHeight_ - self.itemSpace_ - self.itemList_[iter_12_0].itemView:GetItemHeight()
		end

		table.remove(self.itemList_, #self.itemList_)
	end

	self:AddTail2End()
end

function LoopScrollView:DeleteItem(arg_13_1)
	while self.contentHeight_ > self:GetContentHeight() do
		local var_13_0 = 1

		if arg_13_1 then
			self:DeleteHeadItem()
		else
			self:DeleteTailItem()

			var_13_0 = #self.itemList_
		end

		if var_13_0 <= 0 then
			break
		end

		local var_13_1 = self.itemList_[var_13_0]

		if self.itemList_[var_13_0] == nil then
			break
		end

		if self.contentHeight_ - self.itemSpace_ - var_13_1.itemView:GetItemHeight() < self:GetContentHeight() then
			break
		end
	end
end

function LoopScrollView:DeleteHeadItem()
	local var_14_0 = self.itemList_[1]

	if self.contentHeight_ - self.itemSpace_ - self.itemList_[1].itemView:GetItemHeight() > self:GetContentHeight() then
		self.parentView_:LsRemoveItem(var_14_0)
		table.remove(self.itemList_, 1)

		if var_14_0.itemView:IsActive() then
			if self.isHorizontal then
				self.scrollView_:AddContentPosition(Vector2(self.itemSpace_ + var_14_0.itemView:GetItemHeight(), 0))
			else
				self.scrollView_:AddContentPosition(Vector2(0, -self.itemSpace_ - var_14_0.itemView:GetItemHeight()))
			end

			self.contentHeight_ = self.contentHeight_ - self.itemSpace_ - var_14_0.itemView:GetItemHeight()
		else
			self:DeleteHeadItem()
		end
	end
end

function LoopScrollView:DeleteTailItem()
	if self.contentHeight_ - self.itemSpace_ - self.itemList_[#self.itemList_].itemView:GetItemHeight() > self:GetContentHeight() then
		self.parentView_:LsRemoveItem(self.itemList_[#self.itemList_])
		table.remove(self.itemList_, #self.itemList_)

		if self.itemList_[#self.itemList_].itemView:IsActive() then
			self.contentHeight_ = self.contentHeight_ - self.itemSpace_ - self.itemList_[#self.itemList_].itemView:GetItemHeight()
		else
			self:DeleteTailItem()
		end
	end
end

function LoopScrollView:AddTailItem()
	local var_16_0 = self.parentView_:LsGetItemData()

	if #var_16_0 <= 0 then
		return
	end

	local var_16_1 = 1

	if #self.itemList_ > 0 then
		var_16_1 = self.itemList_[#self.itemList_].itemView:GetIndex() + 1

		if var_16_1 > #var_16_0 then
			return
		end
	end

	local var_16_2 = self.parentView_:LsAddItem(var_16_0[var_16_1], var_16_1)

	table.insert(self.itemList_, var_16_2)
	var_16_2.itemView:SetAsLastSibling()

	if var_16_2.itemView:IsActive() then
		self.contentHeight_ = self.contentHeight_ + self.itemSpace_ + var_16_2.itemView:GetItemHeight()
	else
		self:AddTailItem()
	end
end

function LoopScrollView:AddHeadItem()
	local var_17_0 = self.parentView_:LsGetItemData()

	if #var_17_0 <= 0 then
		return
	end

	local var_17_1 = 1

	if #self.itemList_ > 0 then
		var_17_1 = self.itemList_[1].itemView:GetIndex()
		var_17_1 = var_17_1 - 1

		if var_17_1 <= 0 then
			return
		end
	end

	local var_17_2 = self.parentView_:LsAddItem(var_17_0[var_17_1], var_17_1)

	table.insert(self.itemList_, 1, var_17_2)
	var_17_2.itemView:SetAsFirstSibling()

	if var_17_2.itemView:IsActive() then
		self.contentHeight_ = self.contentHeight_ + self.itemSpace_ + var_17_2.itemView:GetItemHeight()

		if self.isHorizontal then
			self.scrollView_:AddContentPosition(Vector2(-self.itemSpace_ - var_17_2.itemView:GetItemHeight(), 0))
		else
			self.scrollView_:AddContentPosition(Vector2(0, self.itemSpace_ + var_17_2.itemView:GetItemHeight()))
		end
	else
		self:AddHeadItem()
	end
end

function LoopScrollView:DeleteAllItem()
	for iter_18_0 = #self.itemList_, 1, -1 do
		self.parentView_:LsRemoveItem(self.itemList_[iter_18_0])
		table.remove(self.itemList_, iter_18_0)
	end

	self.contentHeight_ = 0
end

function LoopScrollView:GetFirstItemHeight()
	if not self.itemList_[1] then
		return 0
	end

	return self.itemList_[1].itemView:GetItemHeight() + self.itemSpace_
end

function LoopScrollView:GetLastItemHeight()
	if not self.itemList_[#self.itemList_] then
		return 0
	end

	return self.itemList_[#self.itemList_].itemView:GetItemHeight() + self.itemSpace_
end

function LoopScrollView:GetItemList()
	return self.itemList_
end

function LoopScrollView:IsFillContent()
	return self.contentHeight_ >= self:GetContentHeight()
end

return LoopScrollView
