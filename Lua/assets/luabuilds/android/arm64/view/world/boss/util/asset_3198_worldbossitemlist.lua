local WorldBossItemList = class("WorldBossItemList")
local var_0_1 = 18
local var_0_2 = -15
local var_0_3 = 100

function WorldBossItemList:Ctor(arg_1_1, arg_1_2)
	self.tpl = arg_1_2
	self.container = arg_1_1
	self.angle = var_0_1
	self.space = var_0_2
	self.distance = var_0_3
	self.tplHeight = self.tpl.rect.height
	self.trigger = self.container:GetComponent(typeof(EventTriggerListener))
	self.hrzOffset = (self.tplHeight + self.space) / math.tan((90 - self.angle) * math.rad(1))
	self.capacity = math.ceil(self.container.parent.parent.rect.height / (self.tplHeight + self.space))

	for iter_1_0 = 1, self.capacity do
		cloneTplTo(self.tpl, self.container, iter_1_0)
	end

	self.OnSwitch = nil
	self.OnRelease = nil

	setActive(self.tpl, false)

	self.tweens = {}

	self:AddListener()

	return
end

function WorldBossItemList:Make(arg_2_1, arg_2_2, arg_2_3)
	self.OnInit = arg_2_1
	self.OnSwitch = arg_2_2
	self.OnRelease = arg_2_3

	return
end

function WorldBossItemList:ClearTweens()
	for iter_3_0, iter_3_1 in ipairs(self.tweens) do
		if LeanTween.isTweening(iter_3_1) then
			LeanTween.cancel(iter_3_1)
		end
	end

	self.tweens = {}

	return
end

function WorldBossItemList:Align(arg_4_1, arg_4_2)
	self:ClearTweens()

	self.childs = {}
	self.padding = 0
	self.animFlag = false
	self.totalCnt = arg_4_1
	self.index = 0
	self.value = arg_4_2 and arg_4_2 or 0
	self.midIndex = math.ceil(self.capacity * 0.5)
	self.ranges = {
		math.huge,
		math.huge,
		self.capacity - self.midIndex + 1,
		self.midIndex - 1
	}

	if arg_4_1 < self.capacity then
		local var_4_0 = math.floor(arg_4_1 * 0.5) + 1

		self.ranges[1] = arg_4_1 - var_4_0
		self.ranges[2] = var_4_0
	end

	self:InitList()

	return
end

function WorldBossItemList:InitList()
	for iter_5_0 = 1, self.capacity do
		local var_5_0 = self.container:GetChild(iter_5_0 - 1)

		var_5_0.localScale = Vector3.one

		var_5_0.gameObject:SetActive(true)
		table.insert(self.childs, {
			index = -9999,
			tr = var_5_0
		})
	end

	self.animTime = 0

	self:Switch()

	local var_5_1 = self.value - 1
	local var_5_2 = 1

	if self.totalCnt < self.capacity and self.value > self.ranges[2] then
		var_5_2 = -1
		var_5_1 = self.totalCnt - self.value + 1
	end

	for iter_5_1 = 1, var_5_1 do
		self:Switch(var_5_2)
	end

	self:Release()

	self.animTime = 0.05

	return
end

function WorldBossItemList:AddListener()
	local var_6_0 = Vector2.zero
	local var_6_1 = 0
	local var_6_2 = 0
	local var_6_3 = 0
	local var_6_4 = true

	local function var_6_5(arg_7_0)
		if arg_7_0 > 0 then
			return self.index < self.ranges[2] - 1
		else
			return self.index > -self.ranges[1]
		end

		return
	end

	self.trigger:AddBeginDragFunc(function(arg_8_0, arg_8_1)
		if self.animFlag then
			return
		end

		var_6_1, var_6_2 = 0, 0
		var_6_0 = arg_8_1.position
		var_6_3 = var_6_0.y
		var_6_4 = true

		return
	end)
	self.trigger:AddDragFunc(function(arg_9_0, arg_9_1)
		if self.animFlag then
			return
		end

		if var_6_3 > arg_9_1.position.y and var_6_1 ~= 0 then
			var_6_0, var_6_1 = arg_9_1.position, 0
		end

		if var_6_3 < arg_9_1.position.y and var_6_2 ~= 0 then
			var_6_0, var_6_2 = arg_9_1.position, 0
		end

		local var_9_0 = arg_9_1.position.y - var_6_0.y

		if not var_6_5(arg_9_1.position.y - var_6_0.y) then
			var_6_4 = false

			return
		end

		local var_9_1 = math.abs(var_9_0 / self.distance)

		if var_9_1 > var_6_2 then
			var_6_2 = var_9_1

			self:Switch(var_9_0)
		end

		if var_9_1 < var_6_1 then
			var_6_1 = var_9_1

			self:Switch(var_9_0)
		end

		var_6_3 = var_6_0.y

		return
	end)
	self.trigger:AddDragEndFunc(function(arg_10_0, arg_10_1)
		if not var_6_4 then
			return
		end

		self:Release()

		return
	end)

	return
end

function WorldBossItemList:RefreshChildPos(arg_11_1)
	self.animFlag, self.padding = true, 0

	local var_11_0 = self.midIndex

	for iter_11_0 = 1, #self.childs do
		local var_11_1 = self.childs[iter_11_0].tr

		if not IsNil(self.childs[iter_11_0].tr) then
			local var_11_2 = iter_11_0 - 1

			if iter_11_0 == var_11_0 or iter_11_0 == var_11_0 + 1 then
				self.padding = self.padding + math.abs(self.space) * 2
			end

			if self.totalCnt == 0 then
				self.padding = 0
			end

			local var_11_3 = Vector3(-self.hrzOffset * var_11_2 - self.padding / math.tan((90 - self.angle) * math.rad(1)), -1 * (self.tplHeight + self.space) * var_11_2 - self.padding, 0)
			local var_11_4 = var_11_3

			if arg_11_1 and var_11_3.y < var_11_1.localPosition.y then
				var_11_4 = Vector3(self.hrzOffset, self.tplHeight + self.space, 0)
			elseif not arg_11_1 and var_11_3.y > var_11_1.localPosition.y then
				var_11_1.localPosition = Vector3(self.hrzOffset, self.tplHeight + self.space, 0)
			end

			if iter_11_0 == var_11_0 or self.animTime <= 0 then
				var_11_1:SetAsLastSibling()

				var_11_1.localPosition = var_11_3
			end

			table.insert(self.tweens, var_11_1.gameObject)
			LeanTween.moveLocal(var_11_1.gameObject, var_11_4, self.animTime):setOnComplete(System.Action(function()
				if not IsNil(var_11_1) then
					var_11_1.localPosition = var_11_3
				end

				self.animFlag = false

				return
			end))
		end
	end

	return
end

function WorldBossItemList:Switch(arg_13_1)
	if arg_13_1 then
		table.insert(self.childs, (arg_13_1 > 0 or nil) and (#self.childs + 1 or 1), (table.remove(self.childs, arg_13_1 > 0 and 1 or #self.childs)))

		self.index = (arg_13_1 > 0 and 1 or -1) + self.index
	end

	local var_13_1 = 0
	local var_13_2 = 0

	if self.totalCnt < self.capacity then
		var_13_2 = math.min(self.ranges[4] - self.ranges[1] - self.index, self.ranges[4])
		var_13_1 = math.min(self.ranges[3] - self.ranges[2] + self.index, self.ranges[3])
	end

	local var_13_3 = self.index % self.totalCnt

	for iter_13_0, iter_13_1 in ipairs(self.childs) do
		iter_13_1.index = (var_13_2 > 0 and iter_13_0 <= var_13_2 or var_13_1 > 0 and var_13_1 > self.capacity - iter_13_0) and -1 or (iter_13_0 - self.midIndex + var_13_3) % self.totalCnt

		if iter_13_1.index ~= iter_13_1.index and self.OnInit then
			self.OnInit(iter_13_1.tr, iter_13_1.index)
		end
	end

	self:RefreshChildPos((arg_13_1 or 0) > 0)

	if self.OnSwitch ~= nil then
		self.OnSwitch(self.childs[self.midIndex].tr, self.childs[self.midIndex].index)
	end

	return
end

function WorldBossItemList:SliceTo(arg_14_1)
	if self.animFlag then
		return
	end

	local var_14_0 = -1

	for iter_14_0, iter_14_1 in ipairs(self.childs) do
		if iter_14_1.tr == arg_14_1 then
			var_14_0 = iter_14_0

			break
		end
	end

	local var_14_2

	if var_14_0 == -1 then
		do return end

		local var_14_1 = Mathf.Sign(var_14_0 - self.midIndex)

		var_14_2 = {}
	end

	for iter_14_2 = 1, math.abs(var_14_0 - self.midIndex) do
		table.insert(var_14_2, function(arg_15_0)
			self:Switch(var_14_1)
			Timer.New(arg_15_0, self.animTime * 2, 1):Start()

			return
		end)
	end

	seriesAsync(var_14_2, function()
		self:Release()

		return
	end)

	return
end

function WorldBossItemList:Release()
	if self.OnRelease ~= nil then
		self.OnRelease(self.childs[self.midIndex].tr, self.childs[self.midIndex].index)
	end

	return
end

function WorldBossItemList:Dispose()
	self:ClearTweens()

	self.OnSwitch = nil
	self.OnRelease = nil
	self.OnInit = nil

	return
end

return WorldBossItemList
