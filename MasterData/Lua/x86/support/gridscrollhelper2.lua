local GridScrollHelper2 = class("GridScrollHelper2")
local var_0_1 = 2
local Pool = class("Pool")

function Pool:Ctor(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	self._parent = arg_1_3
	self._template = arg_1_2
	self._class = arg_1_1
	self._pool = {}
	self._tmpList = {}

	for iter_1_0 = 1, arg_1_4 do
		self:AddPool()
	end
end

function Pool:AddPool()
	self._pool[#self._pool + 1] = self._class.New((Object.Instantiate(self._template, self._parent.transform)))
end

function Pool:Get()
	if #self._tmpList >= 1 then
		self._tmpList[#self._tmpList] = nil

		return self._tmpList[#self._tmpList]
	end

	if #self._pool >= 1 then
		self._pool[#self._pool] = nil

		SetActive(self._pool[#self._pool].gameObject_, true)

		return self._pool[#self._pool]
	end

	self:AddPool()

	self._pool[#self._pool] = nil

	return self._pool[#self._pool]
end

function Pool:Release(arg_4_1)
	if arg_4_1.gameObject_.activeSelf then
		self._tmpList[#self._tmpList + 1] = arg_4_1

		return
	end

	self._pool[#self._pool + 1] = arg_4_1
end

function Pool:ClearTmp()
	for iter_5_0 = 1, #self._tmpList do
		SetActive(self._tmpList[iter_5_0].gameObject_, false)

		self._pool[#self._pool + 1] = self._tmpList[iter_5_0]
	end

	self._tmpList = {}
end

function Pool:Dispose()
	for iter_6_0, iter_6_1 in ipairs(self._pool) do
		Object.Destroy(iter_6_1.gameObject_)
		iter_6_1:Dispose()
	end

	self._pool = nil
	self._tmpList = nil
	self._template = nil
end

function GridScrollHelper2:Ctor(arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5)
	self.delegateFunc_ = arg_7_1
	self.scrollObj_ = arg_7_2
	self.scrollRect_ = self.scrollObj_:GetComponent("ScrollRectEx")
	self.layOut_ = arg_7_3
	self.layOutGroup_ = arg_7_3.gameObject:GetComponent("GridLayoutGroup")
	self.objectPool_ = Pool.New(arg_7_5, arg_7_4, arg_7_3, 0)

	self:OnCtor()

	if not self.ctored_ then
		ReduxFactory.GetInstance():OnManagedObjCtor(self)
	end

	self.ctored_ = true
end

function GridScrollHelper2:SetPageInfo(arg_8_1)
	self.perPageNum_ = 0
	self.viewSize_ = self.scrollObj_:GetComponent("RectTransform").rect.size

	if self.scrollRect_.vertical then
		local var_8_0 = math.ceil((self.viewSize_.y - self.layOutGroup_.padding.top + self.layOutGroup_.spacing.y) / (self.layOutGroup_.cellSize.y + self.layOutGroup_.spacing.y))

		self.perPageNum_ = arg_8_1 * (var_8_0 + var_0_1)
		self.lineNum_ = var_8_0
	else
		local var_8_1 = math.ceil((self.viewSize_.x - self.layOutGroup_.padding.left + self.layOutGroup_.spacing.x) / (self.layOutGroup_.cellSize.x + self.layOutGroup_.spacing.x))

		self.perPageNum_ = arg_8_1 * (var_8_1 + var_0_1)
		self.lineNum_ = var_8_1
	end
end

function GridScrollHelper2:ResetPageInfo()
	self.perLineNum_ = math.floor((self.layOutGroup_.transform.rect.width + self.layOutGroup_.spacing.x) / (self.layOutGroup_.cellSize.x + self.layOutGroup_.spacing.x))

	self:SetPageInfo(self.perLineNum_)
end

function GridScrollHelper2:RightStartIndex(arg_10_1)
	local var_10_0 = math.ceil(self.maxNum_ / self.perLineNum_)
	local var_10_1 = math.ceil(arg_10_1 / self.perLineNum_)

	if var_10_0 <= self.lineNum_ + var_0_1 then
		return 1
	end

	if var_10_1 > var_10_0 - (self.lineNum_ + var_0_1) and var_10_0 - (self.lineNum_ + var_0_1) > 0 then
		return (var_10_0 - (self.lineNum_ + var_0_1)) * self.perLineNum_ + 1
	end

	return (var_10_1 - 1) * self.perLineNum_ + 1
end

function GridScrollHelper2:GetHeadIndex()
	return self.headIndex_
end

function GridScrollHelper2:RecycleAllItem(arg_12_1)
	if self.headIndex_ and self.tailIndex_ then
		for iter_12_0 = self.headIndex_, self.tailIndex_ do
			self:RecycleItem(iter_12_0, true)
		end
	end
end

function GridScrollHelper2:GetPosition()
	if self.scrollRect_.vertical then
		return 1 - self.scrollRect_.verticalNormalizedPosition
	else
		return self.scrollRect_.horizontalNormalizedPosition
	end
end

function GridScrollHelper2:OnCtor()
	self.items_ = {}
	self.headIndex_ = 1
	self.tailIndex_ = 0
	self.perLineNum_ = self.layOutGroup_.constraintCount

	self:SetPageInfo(self.perLineNum_)
end

function GridScrollHelper2:CaculateOffset(arg_15_1)
	if self.scrollRect_.vertical then
		return Vector2(0, (arg_15_1 or nil) and (-(self.layOutGroup_.cellSize.y + self.layOutGroup_.spacing.y) or self.layOutGroup_.cellSize.y + self.layOutGroup_.spacing.y))
	else
		return Vector2(arg_15_1 and self.layOutGroup_.cellSize.x + self.layOutGroup_.spacing.x or -(self.layOutGroup_.cellSize.x + self.layOutGroup_.spacing.x), 0)
	end
end

function GridScrollHelper2:RefreshItemSiblingIndex()
	if self.headIndex_ > self.tailIndex_ then
		return
	end

	for iter_16_0 = self.headIndex_, self.tailIndex_ do
		if self.items_[iter_16_0].gameObject_ then
			self.items_[iter_16_0].gameObject_.transform:SetSiblingIndex(iter_16_0 - self.headIndex_ + 1)
		end
	end
end

function GridScrollHelper2:OnScroll(arg_17_1)
	local var_17_0 = self.scrollRect_.vertical

	if self.scrollRect_.vertical then
		local var_17_1 = arg_17_1.y or arg_17_1.x

		if var_17_1 < 0 then
			if var_17_0 then
				if self.tailIndex_ < self.maxNum_ then
					self:RecycleOnelineItem(true)
					self:GenerateOneLineItem(true)
					self.scrollRect_:AddContentPosition(self:CaculateOffset(true))
					self.objectPool_:ClearTmp()
				end
			elseif self.headIndex_ > 1 then
				self:RecycleOnelineItem(false)
				self:GenerateOneLineItem(false)
				self.scrollRect_:AddContentPosition(self:CaculateOffset(false))
				self.objectPool_:ClearTmp()
			end
		elseif var_17_1 > 1 then
			if var_17_0 then
				if self.headIndex_ > 1 then
					self:RecycleOnelineItem(false)
					self:GenerateOneLineItem(false)
					self.scrollRect_:AddContentPosition(self:CaculateOffset(false))
					self.objectPool_:ClearTmp()
				end
			elseif self.tailIndex_ < self.maxNum_ then
				self:RecycleOnelineItem(true)
				self:GenerateOneLineItem(true)
				self.scrollRect_:AddContentPosition(self:CaculateOffset(true))
				self.objectPool_:ClearTmp()
			end
		end

		if self.callBackFunc_ then
			self.callBackFunc_()
		end
	end
end

function GridScrollHelper2:GenerateOneLineItem(arg_18_1)
	local var_18_0 = 0

	for iter_18_0 = 1, self.perLineNum_ do
		if self:GenerateNewItem(arg_18_1) then
			var_18_0 = var_18_0 + 1
		end
	end

	return var_18_0 > 0
end

function GridScrollHelper2:RecycleOnelineItem(arg_19_1)
	local var_19_0 = 0
	local var_19_1 = 0

	if arg_19_1 then
		var_19_0 = self.headIndex_
		var_19_1 = self.headIndex_ + self.perLineNum_ - 1
	else
		var_19_0 = (math.ceil((self.tailIndex_ - self.headIndex_ + 1) / self.perLineNum_) - 1) * self.perLineNum_ + self.headIndex_
		var_19_1 = self.tailIndex_
	end

	for iter_19_0 = var_19_0, var_19_1 do
		if self.items_[iter_19_0] then
			self:RecycleItem(iter_19_0)
		end
	end

	if arg_19_1 then
		self.headIndex_ = self.headIndex_ + self.perLineNum_
	else
		self.tailIndex_ = self.tailIndex_ - (var_19_1 - var_19_0 + 1)
	end
end

function GridScrollHelper2:GetHeadAndTail()
	if self.headIndex_ > self.tailIndex_ then
		return 0, 0
	end

	return self.headIndex_, self.tailIndex_
end

function GridScrollHelper2:GetItemS()
	local var_21_0 = {}

	if self.headIndex_ > self.tailIndex_ then
		return var_21_0
	end

	for iter_21_0 = self.headIndex_, self.tailIndex_ do
		table.insert(var_21_0, self.items_[iter_21_0])
	end

	return var_21_0
end

function GridScrollHelper2:RecycleItem(arg_22_1, arg_22_2)
	if self.items_[arg_22_1] then
		if arg_22_2 then
			SetActive(self.items_[arg_22_1].gameObject_, false)
		end

		self.objectPool_:Release(self.items_[arg_22_1])

		self.items_[arg_22_1] = nil
	end
end

function GridScrollHelper2:RegistScrollCallBack(arg_23_1)
	self.callBackFunc_ = arg_23_1
end

function GridScrollHelper2:Dispose()
	for iter_24_0 = self.headIndex_, self.tailIndex_ do
		if self.items_[iter_24_0] and self.items_[iter_24_0].Dispose then
			Object.Destroy(self.items_[iter_24_0].gameObject_)
			self.items_[iter_24_0]:Dispose()
		end
	end

	self.scrollRect_.onValueChanged:RemoveAllListeners()

	self.items_ = nil
	self.headIndex_ = nil
	self.tailIndex_ = nil
	self.callBackFunc_ = nil

	self.objectPool_:Dispose()
	ReduxFactory.GetInstance():OnManagedObjDisposed(self)
end

function GridScrollHelper2:GenerateNewItem(arg_25_1)
	local var_25_0 = ((arg_25_1 or nil) and (self.tailIndex_ or self.headIndex_)) + (arg_25_1 and 1 or -1)

	if ((arg_25_1 or nil) and (self.tailIndex_ or self.headIndex_)) + (arg_25_1 and 1 or -1) < 1 or var_25_0 > self.maxNum_ then
		return false
	end

	local var_25_1 = self.objectPool_:Get()

	self.delegateFunc_(var_25_0, var_25_1)

	if arg_25_1 then
		self.tailIndex_ = var_25_0
	else
		self.headIndex_ = var_25_0
	end

	self.items_[var_25_0] = var_25_1

	self:RefreshItemSiblingIndex()

	return var_25_0
end

function GridScrollHelper2:StartScroll(arg_26_1, arg_26_2, arg_26_3)
	self.maxNum_ = arg_26_1

	self.scrollRect_.onValueChanged:RemoveAllListeners()
	self.scrollRect_.onValueChanged:AddListener(function(arg_27_0)
		self:OnScroll(arg_27_0)
	end)

	if self.headIndex_ and self.tailIndex_ then
		for iter_26_0 = self.headIndex_, self.tailIndex_ do
			if self.items_[iter_26_0] then
				self.objectPool_:Release(self.items_[iter_26_0])

				self.items_[iter_26_0] = nil
			end
		end
	end

	local var_26_0 = not arg_26_2 and 1 or self:RightStartIndex(arg_26_2)

	self.headIndex_ = nil
	self.tailIndex_ = var_26_0 - 1

	for iter_26_1 = 1, self.perPageNum_ do
		if self.tailIndex_ + 1 < 1 or self.tailIndex_ + 1 > self.maxNum_ then
			break
		end

		local var_26_3 = self.objectPool_:Get()

		SetActive(var_26_3.gameObject_, true)
		self.delegateFunc_(self.tailIndex_ + 1, var_26_3)

		self.tailIndex_ = self.tailIndex_ + 1
		self.items_[self.tailIndex_ + 1] = var_26_3

		var_26_3.gameObject_.transform:SetSiblingIndex(self.tailIndex_ + 1 - self.headIndex_ + 1)
	end

	self.objectPool_:ClearTmp()

	if not arg_26_3 then
		if arg_26_2 then
			local var_26_4 = math.ceil(arg_26_2 / self.perLineNum_)
			local var_26_5 = math.ceil(var_26_0 / self.perLineNum_)

			arg_26_3 = var_26_4 == var_26_5 and 0 or var_26_4 - var_26_5 > var_0_1 and 1 or (var_26_4 - var_26_5) / (var_0_1 + 1)
		else
			arg_26_3 = 0 or arg_26_3
		end
	end

	if self.scrollRect_.vertical then
		self.scrollRect_.verticalNormalizedPosition = 1 - arg_26_3
	else
		self.scrollRect_.horizontalNormalizedPosition = arg_26_3
	end
end

return GridScrollHelper2
