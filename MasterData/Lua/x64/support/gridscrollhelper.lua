local GridScrollHelper = class("GridScrollHelper")

function GridScrollHelper:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self.delegateFunc_ = arg_1_1
	self.scrollObj_ = arg_1_2
	self.scrollRect_ = self.scrollObj_:GetComponent("ScrollRectEx")
	self.layOut_ = arg_1_3
	self.layOutGroup_ = arg_1_3.gameObject:GetComponent("GridLayoutGroup")

	self:OnCtor()

	if not self.ctored_ then
		ReduxFactory.GetInstance():OnManagedObjCtor(self)
	end

	self.ctored_ = true
end

function GridScrollHelper:OnCtor()
	self.items_ = {}
	self.headIndex_ = 0
	self.tailIndex_ = 0
	self.perLineNum_ = self.layOutGroup_.constraintCount

	self:SetPageInfo(self.perLineNum_)
	self.scrollRect_.onValueChanged:AddListener(function(arg_3_0)
		self:OnScroll(arg_3_0)
	end)
end

function GridScrollHelper:SetPageInfo(arg_4_1)
	self.perPageNum_ = 0
	self.viewSize_ = self.scrollObj_:GetComponent("RectTransform").rect.size

	if self.scrollRect_.vertical then
		local var_4_0 = math.ceil((self.viewSize_.y - self.layOutGroup_.padding.top + self.layOutGroup_.spacing.y) / (self.layOutGroup_.cellSize.y + self.layOutGroup_.spacing.y))

		self.lineNum_ = var_4_0
		self.perPageNum_ = arg_4_1 * (var_4_0 + 2)
	else
		local var_4_1 = math.ceil((self.viewSize_.x - self.layOutGroup_.padding.left + self.layOutGroup_.spacing.x) / (self.layOutGroup_.cellSize.x + self.layOutGroup_.spacing.x))

		self.lineNum_ = var_4_1
		self.perPageNum_ = arg_4_1 * (var_4_1 + 2)
	end
end

function GridScrollHelper:ResetPageInfo()
	self.perLineNum_ = math.floor((self.layOutGroup_.transform.rect.width + self.layOutGroup_.spacing.x) / (self.layOutGroup_.cellSize.x + self.layOutGroup_.spacing.x))

	self:SetPageInfo(self.perLineNum_)
end

function GridScrollHelper:StartScroll(arg_6_1, arg_6_2, arg_6_3)
	self.maxNum_ = arg_6_1

	self:RecycleAllItem(arg_6_1)

	arg_6_2 = not arg_6_2 and 0 or arg_6_2 - 1
	arg_6_3 = arg_6_3 or 0
	self.headIndex_ = arg_6_2
	self.tailIndex_ = arg_6_2

	for iter_6_0 = 1, self.perPageNum_ do
		if not self:GenerateNewItem(true) then
			break
		end
	end

	if self.scrollRect_.vertical then
		self.scrollRect_.verticalNormalizedPosition = 1 - arg_6_3
	else
		self.scrollRect_.horizontalNormalizedPosition = arg_6_3
	end

	if self.tailIndex_ > 0 then
		self.headIndex_ = self.headIndex_ + 1
	end
end

function GridScrollHelper:GetHeadIndex()
	return self.headIndex_
end

function GridScrollHelper:GetPosition()
	if self.scrollRect_.vertical then
		return 1 - self.scrollRect_.verticalNormalizedPosition
	else
		return self.scrollRect_.horizontalNormalizedPosition
	end
end

function GridScrollHelper:RecycleAllItem(arg_9_1)
	if self.headIndex_ and self.tailIndex_ then
		for iter_9_0 = self.headIndex_, self.tailIndex_ do
			self:RecycleItem(iter_9_0, false)
		end
	end
end

function GridScrollHelper:RecycleItem(arg_10_1, arg_10_2)
	arg_10_2 = arg_10_2 or false

	local var_10_0 = self.items_[arg_10_1]

	if self.items_[arg_10_1] then
		SetActive(var_10_0.gameObject_, arg_10_2)

		if var_10_0.pools and var_10_0.recycleIndex then
			var_10_0.pools:FinishIndex(var_10_0.recycleIndex)
		end

		if var_10_0.Dispose then
			var_10_0:Dispose()
		else
			manager.classPool:ReturnClass(var_10_0)
		end

		self.items_[arg_10_1] = nil
	end
end

function GridScrollHelper:GetItemS()
	local var_11_0 = {}

	for iter_11_0 = self.headIndex_, self.tailIndex_ do
		table.insert(var_11_0, self.items_[iter_11_0])
	end

	return var_11_0
end

function GridScrollHelper:Dispose()
	for iter_12_0 = self.headIndex_, self.tailIndex_ do
		if self.items_[iter_12_0] and self.items_[iter_12_0].Dispose then
			self.items_[iter_12_0]:Dispose()
		end
	end

	self.scrollRect_.onValueChanged:RemoveAllListeners()

	self.items_ = nil
	self.headIndex_ = nil
	self.tailIndex_ = nil
	self.callBackFunc_ = nil

	ReduxFactory.GetInstance():OnManagedObjDisposed(self)
end

function GridScrollHelper:RegistScrollCallBack(arg_13_1)
	self.callBackFunc_ = arg_13_1
end

function GridScrollHelper:OnScroll(arg_14_1)
	local var_14_0 = self.scrollRect_.vertical

	if self.scrollRect_.vertical then
		local var_14_1 = arg_14_1.y or arg_14_1.x

		if var_14_1 < 0 then
			if var_14_0 then
				if self.tailIndex_ < self.maxNum_ then
					self:RecycleOnelineItem(true)
					self:GenerateOneLineItem(true)
					self.scrollRect_:AddContentPosition(self:CaculateOffset(true))
				end
			elseif self.headIndex_ > 1 then
				self:RecycleOnelineItem(false)
				self:GenerateOneLineItem(false)
				self.scrollRect_:AddContentPosition(self:CaculateOffset(false))
			end
		elseif var_14_1 > 1 then
			if var_14_0 then
				if self.headIndex_ > 1 then
					self:RecycleOnelineItem(false)
					self:GenerateOneLineItem(false)
					self.scrollRect_:AddContentPosition(self:CaculateOffset(false))
				end
			elseif self.tailIndex_ < self.maxNum_ then
				self:RecycleOnelineItem(true)
				self:GenerateOneLineItem(true)
				self.scrollRect_:AddContentPosition(self:CaculateOffset(true))
			end
		end

		if self.callBackFunc_ then
			self.callBackFunc_()
		end
	end
end

function GridScrollHelper:CaculateOffset(arg_15_1)
	if self.scrollRect_.vertical then
		return Vector2(0, (arg_15_1 or nil) and (-(self.layOutGroup_.cellSize.y + self.layOutGroup_.spacing.y) or self.layOutGroup_.cellSize.y + self.layOutGroup_.spacing.y))
	else
		return Vector2(arg_15_1 and self.layOutGroup_.cellSize.x + self.layOutGroup_.spacing.x or -(self.layOutGroup_.cellSize.x + self.layOutGroup_.spacing.x), 0)
	end
end

function GridScrollHelper:RefreshItemSiblingIndex()
	for iter_16_0 = self.headIndex_, self.tailIndex_ do
		if self.items_[iter_16_0].gameObject_ then
			self.items_[iter_16_0].gameObject_.transform:SetSiblingIndex(iter_16_0 - self.headIndex_)
		end
	end
end

function GridScrollHelper:RecycleOnelineItem(arg_17_1)
	local var_17_0 = 0
	local var_17_1 = 0

	if arg_17_1 then
		var_17_0 = self.headIndex_
		var_17_1 = self.headIndex_ + self.perLineNum_ - 1
	else
		var_17_0 = math.floor((self.tailIndex_ - self.headIndex_) / self.perLineNum_) * self.perLineNum_ + self.headIndex_
		var_17_1 = self.tailIndex_
	end

	for iter_17_0 = var_17_0, var_17_1 do
		if self.items_[iter_17_0] then
			self:RecycleItem(iter_17_0)
		end
	end

	if arg_17_1 then
		self.headIndex_ = self.headIndex_ + self.perLineNum_
	else
		self.tailIndex_ = self.tailIndex_ - (var_17_1 - var_17_0 + 1)
	end

	self:RefreshItemSiblingIndex()
end

function GridScrollHelper:GenerateOneLineItem(arg_18_1)
	local var_18_0 = 0

	for iter_18_0 = 1, self.perLineNum_ do
		if self:GenerateNewItem(arg_18_1) then
			var_18_0 = var_18_0 + 1
		end
	end

	return var_18_0 > 0
end

function GridScrollHelper:GenerateNewItem(arg_19_1)
	local var_19_0 = ((arg_19_1 or nil) and (self.tailIndex_ or self.headIndex_)) + (arg_19_1 and 1 or -1)

	if ((arg_19_1 or nil) and (self.tailIndex_ or self.headIndex_)) + (arg_19_1 and 1 or -1) < 1 then
		return false
	end

	local var_19_1 = self.delegateFunc_(var_19_0)

	if var_19_1 then
		if arg_19_1 then
			self.tailIndex_ = var_19_0
		else
			self.headIndex_ = var_19_0
		end

		self.items_[var_19_0] = var_19_1

		var_19_1.gameObject_.transform:SetSiblingIndex(var_19_0 - self.headIndex_)

		return var_19_0
	end

	return false
end

return GridScrollHelper
