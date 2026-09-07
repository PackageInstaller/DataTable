local RollingCircleRect = class("RollingCircleRect")

function RollingCircleRect:Ctor(arg_1_1, arg_1_2)
	pg.DelegateInfo.New(self)

	self.childs = {}
	self.tpl = arg_1_1
	self.parent = arg_1_2

	self:AddDragListener()

	return
end

function RollingCircleRect:SetCallback(arg_2_1, arg_2_2, arg_2_3)
	self.binder = arg_2_1
	self.OnSelected = arg_2_2
	self.OnRelease = arg_2_3

	return
end

function RollingCircleRect:AddItem(arg_3_1)
	local var_3_0

	if #self.childs <= 0 then
		var_3_0 = RollingCircleItem.New(self.tpl, #self.childs + 1, arg_3_1)

		var_3_0:Init()
	else
		var_3_0 = RollingCircleItem.New(Object.Instantiate(self.tpl, self.tpl.parent), #self.childs + 1, arg_3_1)

		var_3_0:SetPrev(self.childs[#self.childs])
		var_3_0:SetNext(self.childs[1])
		self.childs[1]:SetPrev(var_3_0)
		self.childs[#self.childs]:SetNext(var_3_0)
		var_3_0:Init()
	end

	table.insert(self.childs, var_3_0)
	onButton(self, var_3_0._tr, function()
		self:ScrollToCenter(var_3_0)

		if self.OnRelease then
			self.OnRelease(self.binder, var_3_0)
		end

		return
	end, SFX_PANEL)

	return var_3_0
end

function RollingCircleRect:ScrollTo(arg_5_1)
	Canvas.ForceUpdateCanvases()

	local var_5_0 = _.detect(self.childs, function(arg_6_0)
		return arg_6_0:GetID() == arg_5_1
	end)

	if var_5_0 then
		triggerButton(var_5_0._tr)
	end

	return
end

function RollingCircleRect:AddDragListener()
	RollingCircleRect.AddVerticalDrag(self.parent, function(arg_8_0)
		self:Step(arg_8_0 > 0 and -1 or 1)

		return
	end, function()
		if self.OnRelease then
			self.OnRelease(self.binder, (_.detect(self.childs, function(arg_10_0)
				return arg_10_0:IsCenter(self:GetCenterIndex())
			end)))
		end

		return
	end)

	return
end

function RollingCircleRect:GetCenterIndex()
	return math.min(4, (math.ceil(#self.childs / 2)))
end

function RollingCircleRect:ScrollToCenter(arg_12_1)
	local var_12_0 = self:GetCenterIndex() - arg_12_1:GetIndex()

	if var_12_0 == 0 then
		return
	end

	self:Step(var_12_0)

	return
end

function RollingCircleRect:Step(arg_13_1)
	local var_13_0 = arg_13_1 > 0 and "GoForward" or "GoBack"
	local var_13_1 = self:GetCenterIndex()

	for iter_13_0 = 1, math.abs(arg_13_1) do
		for iter_13_1, iter_13_2 in ipairs(self.childs) do
			iter_13_2:Record()
		end

		local var_13_2

		for iter_13_3, iter_13_4 in ipairs(self.childs) do
			iter_13_4[var_13_0](iter_13_4)

			if iter_13_4:IsCenter(var_13_1) then
				var_13_2 = iter_13_4
			end
		end

		if self.OnSelected then
			self.OnSelected(self.binder, var_13_2)
		end
	end

	return
end

function RollingCircleRect:AddVerticalDrag(arg_14_1, arg_14_2)
	local var_14_0 = GetOrAddComponent(self, "EventTriggerListener")
	local var_14_1 = 90
	local var_14_2
	local var_14_3 = 0
	local var_14_4 = 0
	local var_14_5 = 0

	var_14_0:AddBeginDragFunc(function(arg_15_0, arg_15_1)
		var_14_3 = 0
		var_14_4 = 0
		var_14_2 = arg_15_1.position
		var_14_5 = var_14_2.y

		return
	end)
	var_14_0:AddDragFunc(function(arg_16_0, arg_16_1)
		if var_14_5 > arg_16_1.position.y and var_14_4 ~= 0 then
			var_14_2 = arg_16_1.position
			var_14_4 = 0
		elseif var_14_5 < arg_16_1.position.y and var_14_3 ~= 0 then
			var_14_2 = arg_16_1.position
			var_14_3 = 0
		end

		local var_16_0 = arg_16_1.position.y - var_14_2.y
		local var_16_1 = math.abs(math.floor((arg_16_1.position.y - var_14_2.y) / var_14_1))

		if arg_14_1 and var_16_1 > var_14_3 then
			var_14_3 = var_16_1

			arg_14_1(var_16_0)
		end

		if arg_14_1 and var_16_1 < var_14_4 then
			var_14_4 = var_16_1

			arg_14_1(var_16_0)
		end

		var_14_5 = var_14_2.y

		return
	end)
	var_14_0:AddDragEndFunc(function(arg_17_0, arg_17_1)
		if arg_14_2 then
			arg_14_2()
		end

		return
	end)

	return
end

function RollingCircleRect:Dispose()
	pg.DelegateInfo.Dispose(self)

	for iter_18_0, iter_18_1 in ipairs(self.childs) do
		iter_18_1:Dispose()
	end

	ClearEventTrigger(GetOrAddComponent(self.parent, "EventTriggerListener"))

	self.binder = nil
	self.OnSelected = nil
	self.OnRelease = nil
	self.childs = nil

	return
end

return RollingCircleRect
