local NewGridScrollHelper = class("NewGridScrollHelper")

function NewGridScrollHelper:Ctor(arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6, arg_1_7)
	arg_1_7 = arg_1_7 or 10
	self.handler_ = arg_1_1
	self.itemPath_ = arg_1_2
	self.pool_ = ObjectPoolItem.New()

	self.pool_:InitFromObjectPool(arg_1_6, arg_1_2, arg_1_7)

	self.itemClass_ = arg_1_3
	self.delegateFunc_ = arg_1_4
	self.scrollObj_ = arg_1_5
	self.scrollRect_ = self.scrollObj_:GetComponent("ScrollRectEx")
	self.layOut_ = arg_1_6
	self.layOutGroup_ = arg_1_6.gameObject:GetComponent("GridLayoutGroup")

	self:OnCtor()

	if not self.ctored_ then
		ReduxFactory.GetInstance():OnManagedObjCtor(self)
	end

	self.ctored_ = true
end

function NewGridScrollHelper:OnCtor()
	self.items_ = {}
	self.itemGos_ = {}
	self.headIndex_ = 0
	self.tailIndex_ = 0
	self.perLineNum_ = self.layOutGroup_.constraintCount
	self.viewSize_ = self.scrollObj_:GetComponent("RectTransform").rect.size
	self.perPageNum_ = 0
	self.perPageNum_ = self.scrollRect_.vertical and self.perLineNum_ * (math.ceil((self.viewSize_.y - self.layOutGroup_.padding.top + self.layOutGroup_.spacing.y) / (self.layOutGroup_.cellSize.y + self.layOutGroup_.spacing.y)) + 2) or self.perLineNum_ * (math.ceil((self.viewSize_.x - self.layOutGroup_.padding.left + self.layOutGroup_.spacing.x) / (self.layOutGroup_.cellSize.x + self.layOutGroup_.spacing.x)) + 2)

	self.scrollRect_.onValueChanged:AddListener(function(arg_3_0)
		self:OnScroll(arg_3_0)
	end)
end

function NewGridScrollHelper:StartScroll(arg_4_1)
	self.maxNum_ = arg_4_1

	self:RecycleAllItem()

	self.headIndex_ = 0
	self.tailIndex_ = 0

	for iter_4_0 = 1, self.perPageNum_ do
		if not self:GenerateNewItem(true) then
			break
		end
	end

	if self.tailIndex_ > 0 then
		self.headIndex_ = 1
	end
end

function NewGridScrollHelper:RecycleAllItem()
	for iter_5_0, iter_5_1 in pairs(self.items_) do
		self:RecycleItem(iter_5_0, false)
	end
end

function NewGridScrollHelper:RecycleItem(arg_6_1, arg_6_2)
	arg_6_2 = arg_6_2 or false

	local var_6_0 = self.items_[arg_6_1]

	if self.items_[arg_6_1] then
		SetActive(var_6_0.gameObject_, arg_6_2)
		self.pool_:Return(var_6_0.gameObject_)

		if var_6_0.Dispose then
			var_6_0:Dispose()
		end

		self.items_[arg_6_1] = nil
		self.itemGos_[arg_6_1] = nil

		manager.classPool:ReturnClass(var_6_0)
	end
end

function NewGridScrollHelper:GetItemS()
	local var_7_0 = {}

	for iter_7_0 = self.headIndex_, self.tailIndex_ do
		table.insert(var_7_0, self.items_[iter_7_0])
	end

	return var_7_0
end

function NewGridScrollHelper:Dispose()
	if self.pool_ then
		self.pool_:Dispose()

		self.pool_ = nil
	end

	for iter_8_0 = self.headIndex_, self.tailIndex_ do
		if self.items_[iter_8_0] and self.items_[iter_8_0].Dispose then
			self.items_[iter_8_0]:Dispose()
		end
	end

	self.scrollRect_.onValueChanged:RemoveAllListeners()

	self.items_ = nil
	self.itemGos = nil
	self.headIndex_ = nil
	self.tailIndex_ = nil
	self.callBackFunc_ = nil

	ReduxFactory.GetInstance():OnManagedObjDisposed(self)
end

function NewGridScrollHelper:RegistScrollCallBack(arg_9_1)
	self.callBackFunc_ = arg_9_1
end

function NewGridScrollHelper:OnScroll(arg_10_1)
	local var_10_0 = self.scrollRect_.vertical

	if self.scrollRect_.vertical then
		local var_10_1 = arg_10_1.y or arg_10_1.x

		if var_10_1 < 0 then
			if var_10_0 then
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
		elseif var_10_1 > 1 then
			if var_10_0 then
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

function NewGridScrollHelper:CaculateOffset(arg_11_1)
	if self.scrollRect_.vertical then
		return Vector2(0, (arg_11_1 or nil) and (-(self.layOutGroup_.cellSize.y + self.layOutGroup_.spacing.y) or self.layOutGroup_.cellSize.y + self.layOutGroup_.spacing.y))
	else
		return Vector2(arg_11_1 and self.layOutGroup_.cellSize.x + self.layOutGroup_.spacing.x or -(self.layOutGroup_.cellSize.x + self.layOutGroup_.spacing.x), 0)
	end
end

function NewGridScrollHelper:RefreshItemSiblingIndex()
	for iter_12_0 = self.headIndex_, self.tailIndex_ do
		if self.items_[iter_12_0].gameObject_ then
			self.items_[iter_12_0].gameObject_.transform:SetSiblingIndex(iter_12_0 - self.headIndex_)
		end
	end
end

function NewGridScrollHelper:RecycleOnelineItem(arg_13_1)
	local var_13_0 = 0
	local var_13_1 = 0

	if arg_13_1 then
		var_13_0 = self.headIndex_
		var_13_1 = self.headIndex_ + self.perLineNum_ - 1
	else
		var_13_0 = math.floor((self.tailIndex_ - self.headIndex_) / self.perLineNum_) * self.perLineNum_ + self.headIndex_
		var_13_1 = self.tailIndex_
	end

	for iter_13_0 = var_13_0, var_13_1 do
		if self.items_[iter_13_0] then
			self:RecycleItem(iter_13_0)
		end
	end

	if arg_13_1 then
		self.headIndex_ = self.headIndex_ + self.perLineNum_
	else
		self.tailIndex_ = self.tailIndex_ - (var_13_1 - var_13_0 + 1)
	end

	self:RefreshItemSiblingIndex()
end

function NewGridScrollHelper:GenerateOneLineItem(arg_14_1)
	local var_14_0 = 0

	for iter_14_0 = 1, self.perLineNum_ do
		if self:GenerateNewItem(arg_14_1) then
			var_14_0 = var_14_0 + 1
		end
	end

	return var_14_0 > 0
end

function NewGridScrollHelper:GenerateNewItem(arg_15_1)
	local var_15_0 = ((arg_15_1 or nil) and (self.tailIndex_ or self.headIndex_)) + (arg_15_1 and 1 or -1)

	if ((arg_15_1 or nil) and (self.tailIndex_ or self.headIndex_)) + (arg_15_1 and 1 or -1) < 1 then
		return false
	end

	if var_15_0 <= self.maxNum_ then
		local var_15_1 = self.pool_:Get()

		SetActive(var_15_1, true)

		var_15_1.name = "item" .. var_15_0

		local var_15_2 = self.delegateFunc_(var_15_0, var_15_1, (manager.classPool:GetOrCreateClass(self.itemClass_, self.handler_, var_15_1)))

		if var_15_2 then
			if arg_15_1 then
				self.tailIndex_ = var_15_0
			else
				self.headIndex_ = var_15_0
			end

			self.items_[var_15_0] = var_15_2
			self.itemGos_[var_15_0] = var_15_1

			var_15_1.transform:SetSiblingIndex(var_15_0 - self.headIndex_)

			return var_15_0
		end
	end

	return false
end

function NewGridScrollHelper:RefreshList()
	for iter_16_0 = self.headIndex_, self.tailIndex_ do
		self.delegateFunc_(iter_16_0, self.items_[iter_16_0].gameObject_, self.items_[iter_16_0])
	end
end

return NewGridScrollHelper
