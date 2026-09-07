local BannerScrollRect = class("BannerScrollRect")

function BannerScrollRect:Ctor(arg_1_1, arg_1_2)
	self.container = arg_1_1
	self.dotContainer = arg_1_2

	local var_1_0 = arg_1_1:Find("item")

	self.items = {
		var_1_0
	}

	local var_1_1 = arg_1_2:Find("dot")

	self.dots = {
		var_1_1
	}
	self.itemWidth = var_1_0.sizeDelta.x
	self.dotStartPosX = var_1_1.localPosition.x
	self.dotWidth = var_1_1.sizeDelta.x
	self.total = 0
	self.index = 1
	self.dragEvent = self.container:GetComponent("EventTriggerListener")

	return
end

function BannerScrollRect:GetItem(arg_2_1)
	local var_2_0 = self.items[arg_2_1]

	if not self.items[arg_2_1] then
		var_2_0 = Object.Instantiate(self.items[1], self.items[1].transform.parent)
		self.items[arg_2_1] = var_2_0
	end

	return var_2_0
end

function BannerScrollRect:GetDot(arg_3_1)
	local var_3_0 = self.dots[arg_3_1]

	if not self.dots[arg_3_1] then
		var_3_0 = Object.Instantiate(self.dots[1], self.dots[1].transform.parent)
		self.dots[arg_3_1] = var_3_0
	end

	return var_3_0
end

function BannerScrollRect:AddChild()
	self.total = self.total + 1

	local var_4_0 = self:GetDot(self.total)
	local var_4_1 = self:GetItem(self.total)

	setActive(var_4_1, true)
	setActive(var_4_0, true)
	self:UpdateItemPosition(self.total, var_4_1)
	self:UpdateDotPosition(self.total, var_4_0)

	return var_4_1
end

function BannerScrollRect:UpdateItemPosition(arg_5_1, arg_5_2)
	arg_5_2.localPosition = Vector3((arg_5_1 - 1) * self.itemWidth, arg_5_2.localPosition.y, 0)

	return
end

function BannerScrollRect:UpdateDotPosition(arg_6_1, arg_6_2)
	arg_6_2.localPosition = Vector3(self.dotStartPosX + (arg_6_1 - 1) * (self.dotWidth + 15), arg_6_2.localPosition.y, 0)

	return
end

function BannerScrollRect:SetUp()
	if self.total == 0 then
		self:Disable()

		return
	end

	self.container.localPosition = Vector3(0, 0, 0)

	self:ScrollTo(1)
	self:AutoScroll()
	self:AddDrag()

	return
end

function BannerScrollRect:AutoScroll()
	self:RemoveTimer()

	self.timer = Timer.New(function()
		self:ScrollTo(((self.index + 1) % self.total == 0 or nil) and self.total)

		return
	end, 5, -1, true)

	self.timer:Start()

	return
end

function BannerScrollRect:ScrollTo(arg_10_1)
	local var_10_0 = self.index or 1

	self.animating = true

	LeanTween.moveLocalX(go(self.container), -1 * ((arg_10_1 - 1) * self.itemWidth), 0.2):setEase(LeanTweenType.easeInOutSine):setOnComplete(System.Action(function()
		self.animating = false

		return
	end))

	self.index = arg_10_1

	self:TriggerDot(self.dots[var_10_0], false)
	self:TriggerDot(self.dots[arg_10_1], true)

	return
end

function BannerScrollRect:TriggerDot(arg_12_1, arg_12_2)
	arg_12_1:GetComponent(typeof(Image)).color = arg_12_2 and Color.New(1, 1, 1, 1) or Color.New(0.4, 0.45, 0.55)

	return
end

function BannerScrollRect:AddDrag()
	local var_13_0 = 0
	local var_13_1

	self.dragEvent:AddBeginDragFunc(function(arg_14_0, arg_14_1)
		if self.animating then
			return
		end

		self:Pause()

		var_13_0 = arg_14_1.position.x
		var_13_1 = self.container.localPosition

		return
	end)
	self.dragEvent:AddDragFunc(function(arg_15_0, arg_15_1)
		if self.animating or not var_13_1 then
			return
		end

		self.container.localPosition = Vector3(var_13_1.x + (arg_15_1.position.x - var_13_0) * 0.5, var_13_1.y, 0)

		return
	end)
	self.dragEvent:AddDragEndFunc(function(arg_16_0, arg_16_1)
		local var_16_0

		if self.animating or not var_13_1 then
			do return end

			var_16_0 = math.floor(math.abs((arg_16_1.position.x - var_13_0) / self.itemWidth) + 0.5)
		end

		self:ScrollTo((math.clamp((arg_16_1.position.x - var_13_0 < 0 or nil) and (self.index + var_16_0 or self.index - var_16_0), 1, self.total)))
		self:Resume()

		return
	end)

	return
end

function BannerScrollRect:Reset()
	self:RemoveTimer()
	ClearEventTrigger(self.dragEvent)
	LeanTween.cancel(go(self.container))

	self.total = 0
	self.index = 1
	self.animating = false

	self:Disable()

	return
end

function BannerScrollRect:Disable()
	for iter_18_0, iter_18_1 in ipairs(self.items) do
		setActive(iter_18_1, false)
	end

	for iter_18_2, iter_18_3 in ipairs(self.dots) do
		self:TriggerDot(iter_18_3, false)
		setActive(iter_18_3, false)
	end

	return
end

function BannerScrollRect:Pause()
	self:RemoveTimer()

	return
end

function BannerScrollRect:Resume()
	if self.total == 0 then
		return
	end

	self:AutoScroll()

	return
end

function BannerScrollRect:RemoveTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function BannerScrollRect:Dispose()
	self:Reset()

	for iter_22_0, iter_22_1 in ipairs(self.items) do
		Object.Destroy(iter_22_1.gameObject)
	end

	for iter_22_2, iter_22_3 in ipairs(self.dots) do
		Object.Destroy(iter_22_3.gameObject)
	end

	self.items = nil
	self.dots = nil

	return
end

return BannerScrollRect
