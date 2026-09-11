local HorizontalScrollHelper = class("HorizontalScrollHelper")

function HorizontalScrollHelper:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self.delegateObj_ = arg_1_1
	self.scrollView_ = arg_1_2
	self.isVertical_ = arg_1_3
	self.startIndex_ = 0
	self.endIndex_ = 0
	self.maxIndex_ = 0

	self:OnCtor()
end

function HorizontalScrollHelper:OnCtor()
	self.itemS_ = {}
	self.currentIndex_ = 0
end

function HorizontalScrollHelper:SetSpacing(arg_3_1)
	self.space_ = arg_3_1
end

function HorizontalScrollHelper:SetDataList(arg_4_1)
	self.dataList_ = arg_4_1
	self.maxIndex_ = #arg_4_1
end

function HorizontalScrollHelper:RecycleAllItem()
	for iter_5_0 = #self.itemS_, 1, -1 do
		self:RecycleItem(iter_5_0)
	end

	self.itemS_ = {}
end

function HorizontalScrollHelper:RecycleItem(arg_6_1)
	if self.itemS_[arg_6_1] == nil then
		return
	end

	self.itemS_[arg_6_1]:Show(false)

	if self.itemS_[arg_6_1].pools and self.itemS_[arg_6_1].recycleIndex then
		self.itemS_[arg_6_1].pools:FinishIndex(self.itemS_[arg_6_1].recycleIndex)

		self.itemS_[arg_6_1].isFree = true
	end

	table.remove(self.itemS_, arg_6_1)
end

function HorizontalScrollHelper:Show(arg_7_1)
	local var_7_0 = self.scrollView_:GetViewBounds()
	local var_7_1 = self.scrollView_:GetContentBounds()

	self.startIndex_ = arg_7_1 - 1
	self.endIndex_ = self.startIndex_

	if self.isVertical_ == true then
		for iter_7_0 = self.endIndex_, self.maxIndex_ do
			if var_7_1.max.y <= var_7_0.max.y then
				self:NewItemAtEnd()

				var_7_0 = self.scrollView_:GetViewBounds()
				var_7_1 = self.scrollView_:GetContentBounds()
			else
				break
			end
		end

		while var_7_0.max.y - var_7_0.min.y > var_7_1.max.y - var_7_1.min.y and self.startIndex_ > 0 do
			self:NewItemAtStart()

			var_7_0 = self.scrollView_:GetViewBounds()
			var_7_1 = self.scrollView_:GetContentBounds()
		end
	else
		for iter_7_1 = self.startIndex_, self.maxIndex_ do
			if var_7_1.max.x <= var_7_0.max.x then
				self:NewItemAtEnd()

				var_7_0 = self.scrollView_:GetViewBounds()
				var_7_1 = self.scrollView_:GetContentBounds()
			else
				break
			end
		end

		while var_7_0.max.x - var_7_0.min.x - (var_7_1.max.x - var_7_1.min.x) > 0.001 and self.startIndex_ > 0 do
			self:NewItemAtStart()

			var_7_0 = self.scrollView_:GetViewBounds()
			var_7_1 = self.scrollView_:GetContentBounds()
		end
	end

	self.scrollView_.onUpdateItems = self.scrollView_.onUpdateItems or function(arg_8_0, arg_8_1)
		self:UpdateItems(arg_8_0, arg_8_1)
	end
end

function HorizontalScrollHelper:UpdateItems(arg_9_1, arg_9_2)
	if self.isVertical_ then
		self:UpdateVertical(arg_9_1, arg_9_2)
	else
		self:UpdateHorizontal(arg_9_1, arg_9_2)
	end
end

function HorizontalScrollHelper:UpdateVertical(arg_10_1, arg_10_2)
	if arg_10_1.max.y > arg_10_2.max.y - 0 * self:CaculateItemSize(1) then
		self:NewItemAtStart()
	end

	if arg_10_1.min.y < arg_10_2.min.y - 0 * self:CaculateItemSize(#self.itemS_) then
		self:NewItemAtEnd()
	end

	arg_10_1 = self.scrollView_:GetViewBounds()
	arg_10_2 = self.scrollView_:GetContentBounds()

	if arg_10_1.max.y < arg_10_2.max.y - 1 * self:CaculateItemSize(1) then
		self:RemoveItemAtStart()
	end

	if arg_10_1.min.y > arg_10_2.min.y + 1 * self:CaculateItemSize(#self.itemS_) then
		self:RemoveItemAtEnd()
	end
end

function HorizontalScrollHelper:UpdateHorizontal(arg_11_1, arg_11_2)
	if arg_11_1.min.x < arg_11_2.min.x - 0 * self:CaculateItemSize(1) then
		self:NewItemAtStart()
	end

	if arg_11_1.max.x > arg_11_2.max.x + 0 * self:CaculateItemSize(1) then
		self:NewItemAtEnd()
	end

	arg_11_1 = self.scrollView_:GetViewBounds()
	arg_11_2 = self.scrollView_:GetContentBounds()

	if arg_11_1.min.x > arg_11_2.min.x + 1 * self:CaculateItemSize(1) then
		self:RemoveItemAtStart()
	end

	if arg_11_1.max.x < arg_11_2.max.x - 1 * self:CaculateItemSize(#self.itemS_) then
		self:RemoveItemAtEnd()
	end
end

function HorizontalScrollHelper:NewItemAtStart()
	if self.startIndex_ < 1 then
		return
	end

	table.insert(self.itemS_, 1, self.delegateObj_:GetItem(self.startIndex_))

	self.startIndex_ = self.startIndex_ - 1

	self.itemS_[1]:Show(true)
	self.itemS_[1].gameObject_.transform:SetAsFirstSibling()

	if self.isVertical_ then
		self.scrollView_:AddContentPosition(Vector2(0, self:CaculateItemSize(1) * 1))
	else
		self.scrollView_:AddContentPosition(Vector2(self:CaculateItemSize(1) * -1, 0))
	end
end

function HorizontalScrollHelper:RemoveItemAtStart()
	if self.endIndex_ >= self.maxIndex_ then
		return
	end

	self:RecycleItem(1)

	self.startIndex_ = self.startIndex_ + 1

	if self.isVertical_ then
		self.scrollView_:AddContentPosition(Vector2(0, self:CaculateItemSize(1) * -1))
	else
		self.scrollView_:AddContentPosition(Vector2(self:CaculateItemSize(1), 0))
	end
end

function HorizontalScrollHelper:NewItemAtEnd()
	if self.endIndex_ >= self.maxIndex_ then
		return
	end

	self.endIndex_ = self.endIndex_ + 1

	table.insert(self.itemS_, self.delegateObj_:GetItem(self.endIndex_))
	self.itemS_[#self.itemS_]:Show(true)
	self.itemS_[#self.itemS_].gameObject_.transform:SetAsLastSibling()
end

function HorizontalScrollHelper:RemoveItemAtEnd()
	self:RecycleItem(#self.itemS_)

	self.endIndex_ = self.endIndex_ - 1
end

function HorizontalScrollHelper:CaculateItemSize(arg_16_1)
	if self.isVertical_ then
		return self:CaculateVerticalItemSize(arg_16_1)
	else
		return self:CaculateHorizontalItemSize(arg_16_1)
	end
end

function HorizontalScrollHelper:CaculateVerticalItemSize(arg_17_1)
	local var_17_0 = 0

	if arg_17_1 <= 0 or not self.itemS_[arg_17_1] then
		return var_17_0
	end

	local var_17_1 = self.itemS_[arg_17_1]:GetRectTransform()

	if var_17_1 then
		var_17_0 = var_17_0 + var_17_1.sizeDelta.y + self.space_
	end

	return var_17_0
end

function HorizontalScrollHelper:CaculateHorizontalItemSize(arg_18_1)
	local var_18_0 = 0

	if arg_18_1 <= 0 or not self.itemS_[arg_18_1] then
		return var_18_0
	end

	local var_18_1 = self.itemS_[arg_18_1]:GetRectTransform()

	if var_18_1 then
		var_18_0 = var_18_0 + var_18_1.sizeDelta.x + self.space_
	end

	return var_18_0
end

function HorizontalScrollHelper:GetStartIndex()
	return self.startIndex_
end

function HorizontalScrollHelper:GetEndIndex()
	return self.endIndex_
end

function HorizontalScrollHelper:OnDispose()
	self.scrollView_.onUpdateItems = nil
	self.dataList_ = nil
	self.itemS_ = nil
end

return HorizontalScrollHelper
