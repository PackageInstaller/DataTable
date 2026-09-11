local ScrollPartner = class("ScrollPartner")

function ScrollPartner:Ctor(arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	self.gameObject_ = arg_1_1
	self.partner_ = arg_1_2
	self.scrollRect_ = arg_1_1:GetComponent("ScrollRectEx")
	self.grid_ = arg_1_1.transform:Find("Grid").gameObject
	self.rect_ = self.grid_.gameObject:GetComponent("RectTransform")
	self.partnerRect_ = arg_1_3:GetComponent("RectTransform")
	self.gameObject_.transform.localPosition = arg_1_2.transform.localPosition
	self.gameObject_:GetComponent("RectTransform").sizeDelta = arg_1_2:GetComponent("RectTransform").sizeDelta
	self.helper_ = arg_1_4
	self.childCnt_ = self.grid_.transform.childCount
	self.ceilPos_ = arg_1_5

	self:OnCtor()
end

function ScrollPartner:OnCtor()
	self.children_ = {}

	for iter_2_0 = 1, self.childCnt_ do
		local var_2_0 = self.grid_.transform:Find("item" .. iter_2_0)

		self.children_[iter_2_0] = {
			trs = var_2_0,
			x = var_2_0.localPosition.x
		}

		if iter_2_0 == 1 then
			self.startPos_ = -var_2_0.localPosition.y
		end
	end

	local var_2_1 = self.partner_:GetComponent("ScrollRectEx")

	self.timer_ = FrameTimer.New(function()
		self:OnScroll(var_2_1.normalizedPosition)
	end, 1, -1)

	self.timer_:Start()
end

function ScrollPartner:OnScroll(arg_4_1)
	self:SetPage()

	self.scrollRect_.normalizedPosition = arg_4_1
end

function ScrollPartner:SetPage()
	local var_5_1 = (self.helper_.layOutGroup_.spacing.y + self.helper_.layOutGroup_.cellSize.y) * math.floor(self.helper_.headIndex_ / self.helper_.perLineNum_)
	local var_5_2 = math.ceil((var_5_1 - self.startPos_) / self.ceilPos_) + 1

	if var_5_2 < 1 then
		var_5_2 = 1
	end

	local var_5_3 = self.startPos_ + (var_5_2 - 1) * self.ceilPos_ - var_5_1

	if self.startPos_ + (var_5_2 - 1) * self.ceilPos_ - var_5_1 < 0 then
		var_5_3 = 0
	end

	local var_5_4 = (var_5_2 - 1) % self.childCnt_ + 1
	local var_5_5 = self.helper_.perPageNum_ / self.helper_.perLineNum_

	if self.helper_.maxNum_ <= self.helper_.perPageNum_ then
		var_5_5 = math.ceil(self.helper_.maxNum_ / self.helper_.perLineNum_)
	end

	self.pageSize_ = var_5_5 * self.helper_.layOutGroup_.cellSize.y + (var_5_5 - 1) * self.helper_.layOutGroup_.spacing.y

	if self.pageSize_ ~= self.pageSize_ then
		self.rect_.sizeDelta = Vector2(self.rect_.sizeDelta.x, self.pageSize_)
	end

	if self.head_ == self.helper_.headIndex_ then
		return
	end

	self.head_ = self.helper_.headIndex_

	local var_5_7 = 0

	for iter_5_0 = var_5_4, self.childCnt_ do
		self.children_[iter_5_0].trs.localPosition = Vector3(self.children_[iter_5_0].x, -var_5_7 * self.ceilPos_ - var_5_3, 0)
		var_5_7 = var_5_7 + 1
	end

	for iter_5_1 = 1, var_5_4 - 1 do
		self.children_[iter_5_1].trs.localPosition = Vector3(self.children_[iter_5_1].x, -var_5_7 * self.ceilPos_ - var_5_3, 0)
		var_5_7 = var_5_7 + 1
	end
end

function ScrollPartner:Dispose()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

return ScrollPartner
