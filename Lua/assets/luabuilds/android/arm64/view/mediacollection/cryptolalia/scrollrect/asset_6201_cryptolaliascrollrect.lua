local CryptolaliaScrollRect = class("CryptolaliaScrollRect")
local var_0_1 = 150

function CryptolaliaScrollRect:Ctor(arg_1_1, arg_1_2)
	pg.DelegateInfo.New(self)

	self.tpl = arg_1_1.gameObject
	self.tpls = {
		self.tpl
	}
	self.startPosition = arg_1_1.localPosition
	self.eventTriggerListener = arg_1_1.parent:GetComponent(typeof(EventTriggerListener))
	self.animation = arg_1_2
	self.items = {}

	return
end

local function var_0_2(arg_2_0)
	if #arg_2_0.tpls > 0 then
		return table.remove(arg_2_0.tpls, 1)
	else
		return Object.Instantiate(arg_2_0.tpl, arg_2_0.tpl.transform.parent)
	end

	return
end

function NewTpl(arg_3_0, arg_3_1)
	return Object.Instantiate(arg_3_1, arg_3_0.tpl.transform.parent)
end

function CryptolaliaScrollRect:Make(arg_4_1, arg_4_2)
	self.OnItemInit = arg_4_1
	self.OnSelect = arg_4_2

	return
end

function CryptolaliaScrollRect:Align(arg_5_1, arg_5_2)
	self.totalCnt = math.max(5, arg_5_1)
	self.midIndex = math.ceil(self.totalCnt / 2)

	local var_5_0 = {}

	for iter_5_0 = 1, self.totalCnt do
		table.insert(var_5_0, function(arg_6_0)
			local var_6_0 = CryptolaliaScrollRectItem.New(var_0_2(self), self.midIndex, iter_5_0)

			if self.OnItemInit then
				self.OnItemInit(var_6_0)
			end

			if var_6_0:IsMidIndex() and self.OnSelect then
				self.OnSelect(var_6_0)
			end

			table.insert(self.items, var_6_0)

			if iter_5_0 % 3 == 0 then
				onNextTick(arg_6_0)
			else
				arg_6_0()
			end

			return
		end)
	end

	seriesAsync(var_5_0, arg_5_2)

	return
end

function CryptolaliaScrollRect:SetUp()
	for iter_7_0, iter_7_1 in ipairs(self.items) do
		onButton(self, iter_7_1._go, function()
			if self.inAnimation then
				return
			end

			self:JumpToMid(iter_7_1:GetIndex())

			return
		end, SFX_PANEL)
	end

	self:AddDrag()

	return
end

function CryptolaliaScrollRect:AddDrag()
	self.eventTriggerListener:AddBeginDragFunc(function(arg_10_0, arg_10_1)
		self.position = arg_10_1.position

		return
	end)
	self.eventTriggerListener:AddDragEndFunc(function(arg_11_0, arg_11_1)
		if not self.position then
			return
		end

		local var_11_0 = arg_11_1.position - self.position

		if math.abs((arg_11_1.position - self.position).x) > var_0_1 and math.abs(var_11_0.y) > var_0_1 then
			if var_11_0.x >= 0 then
				self:OnListUp()
			end

			if var_11_0.x < 0 then
				self:OnListDown()
			end
		end

		self.position = nil

		return
	end)

	return
end

function CryptolaliaScrollRect:OnListUp()
	self:trigger(self.midIndex + 1)

	return
end

function CryptolaliaScrollRect:OnListDown()
	self:trigger(self.midIndex - 1)

	return
end

function CryptolaliaScrollRect:trigger(arg_14_1)
	local var_14_0

	for iter_14_0, iter_14_1 in ipairs(self.items) do
		if iter_14_1:GetIndex() == arg_14_1 then
			var_14_0 = iter_14_1

			break
		end
	end

	if var_14_0 and var_14_0:CanInteractable() then
		self:JumpToMid(var_14_0:GetIndex())
	end

	return
end

function CryptolaliaScrollRect:JumpToMid(arg_15_1)
	local var_15_0 = math.abs(self.midIndex - arg_15_1)
	local var_15_1 = self.midIndex - arg_15_1 <= 0
	local var_15_2 = {}

	for iter_15_0 = 1, var_15_0 do
		table.insert(var_15_2, function(arg_16_0)
			local var_16_0

			if var_15_1 then
				var_16_0 = self.midIndex + 1 or self.midIndex - 1

				if iter_15_0 == var_15_0 then
					self:Step(self.midIndex - var_16_0, arg_16_0)

					goto label_16_0
				end
			end

			self:Step(self.midIndex - var_16_0, onNextTick(arg_16_0))

			::label_16_0::

			return
		end)
	end

	seriesAsync(var_15_2)

	return
end

function CryptolaliaScrollRect:Step1(arg_17_1, arg_17_2)
	if self.inAnimation then
		self:ClearAnimation()
	end

	local var_17_0 = {}
	local var_17_1

	for iter_17_0, iter_17_1 in ipairs(self.items) do
		local var_17_2 = iter_17_1:GetIndex() + arg_17_1
		local var_17_3 = var_17_2

		if var_17_2 > self.totalCnt then
			var_17_3 = var_17_3 - self.totalCnt
			self.sinker = CryptolaliaScrollRectItem.New(NewTpl(self, iter_17_1._go), self.midIndex, 0)
		elseif var_17_3 <= 0 then
			var_17_3 = self.totalCnt - math.abs(var_17_3)
			self.sinker = CryptolaliaScrollRectItem.New(NewTpl(self, iter_17_1._go), self.midIndex, self.totalCnt + 1)
		end

		if var_17_3 == self.midIndex then
			var_17_1 = iter_17_1
		end

		table.insert(var_17_0, function(arg_18_0)
			iter_17_1:UpdateIndexWithAnim(var_17_3, var_17_2, arg_18_0)

			return
		end)
	end

	if self.sinker then
		table.insert(var_17_0, function(arg_19_0)
			local var_19_0 = self.sinker:GetIndex() + arg_17_1

			self.sinker:UpdateIndexWithAnim(var_19_0, var_19_0, arg_19_0)

			return
		end)
	end

	table.insert(var_17_0, function(arg_20_0)
		self.animation:Play(arg_17_1):OnComplete(arg_20_0):OnTrigger(function()
			if self.OnSelect then
				self.OnSelect(var_17_1)
			end

			return
		end)

		return
	end)

	self.inAnimation = true

	parallelAsync(var_17_0, function()
		self:ClearAnimation()
		arg_17_2()

		return
	end)

	return
end

function CryptolaliaScrollRect:Step(arg_23_1, arg_23_2)
	if self.inAnimation then
		self:ClearAnimation()
	end

	local var_23_0 = {}
	local var_23_1
	local var_23_2 = {}
	local var_23_3

	for iter_23_0, iter_23_1 in ipairs(self.items) do
		local var_23_4 = iter_23_1:GetIndex() + arg_23_1

		if var_23_4 > self.totalCnt then
			var_23_4 = var_23_4 - self.totalCnt
			self.sinker = CryptolaliaScrollRectItem.New(NewTpl(self, iter_23_1._go), self.midIndex, 0)
			var_23_3 = self.sinker:GetPosition()
		elseif var_23_4 <= 0 then
			var_23_4 = self.totalCnt - math.abs(var_23_4)
			self.sinker = CryptolaliaScrollRectItem.New(NewTpl(self, iter_23_1._go), self.midIndex, self.totalCnt + 1)
			var_23_3 = self.sinker:GetPosition()
		end

		if var_23_4 == self.midIndex then
			var_23_1 = iter_23_1
		end

		iter_23_1:UpdateIndexSilence(var_23_4)
		table.insert(var_23_2, iter_23_1:GetPosition())
	end

	table.insert(var_23_0, function(arg_24_0)
		self.animation:Play(arg_23_1):OnComplete(arg_24_0):OnUpdate(function(arg_25_0)
			for iter_25_0, iter_25_1 in ipairs(self.items) do
				iter_25_1:SetPosition(var_23_2[iter_25_0] + arg_25_0)
			end

			if self.sinker then
				self.sinker:SetPosition(var_23_3 + arg_25_0)
			end

			return
		end):OnLastUpdate(function()
			for iter_26_0, iter_26_1 in ipairs(self.items) do
				iter_26_1:Refresh()
			end

			return
		end):OnTrigger(function()
			if self.OnSelect then
				self.OnSelect(var_23_1)
			end

			return
		end)

		return
	end)

	self.inAnimation = true

	parallelAsync(var_23_0, function()
		self:ClearAnimation()
		arg_23_2()

		return
	end)

	return
end

function CryptolaliaScrollRect:ClearAnimation()
	if self.inAnimation then
		self.animation:Stop()

		for iter_29_0, iter_29_1 in ipairs(self.items) do
			iter_29_1:ClearAnimation()
		end

		if self.sinker then
			Object.Destroy(self.sinker._go)

			self.sinker = nil
		end

		self.inAnimation = false
	end

	return
end

function CryptolaliaScrollRect:Dispose()
	for iter_30_0, iter_30_1 in ipairs(self.items) do
		iter_30_1:Dispose()
	end

	self:ClearAnimation()

	self.items = nil
	self.OnItemInit = nil
	self.OnSelect = nil

	pg.DelegateInfo.Dispose(self)
	self.eventTriggerListener:AddBeginDragFunc(nil)
	self.eventTriggerListener:AddDragEndFunc(nil)

	self.eventTriggerListener = nil

	return
end

return CryptolaliaScrollRect
