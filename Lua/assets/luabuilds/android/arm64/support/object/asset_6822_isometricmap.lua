pg = pg or {}

local IsometricMap = class("IsometricMap")

pg.IsometricMap = IsometricMap

function IsometricMap:Ctor(arg_1_1, arg_1_2)
	self.sizeX = arg_1_1
	self.sizeY = arg_1_2
	self.depths = {}
	self.dependInfo = {}
	self.allItems = {}
	self.sortedFlag = false
	self.sortedItems = {}

	self:ResetDepth()

	return
end

function IsometricMap:SetAfterFunc(arg_2_1)
	self.afterSortFunc = arg_2_1

	return
end

function IsometricMap:GetDepth(arg_3_1, arg_3_2)
	return self.depths[self:GetIndex(arg_3_1, arg_3_2)]
end

function IsometricMap:InsertChar(arg_4_1)
	local var_4_0 = self:GetDepth(arg_4_1.posX, arg_4_1.posY)

	arg_4_1:SetDepth(var_4_0)

	for iter_4_0, iter_4_1 in ipairs(self.sortedItems) do
		if var_4_0 > iter_4_1.posZ then
			table.insert(self.sortedItems, iter_4_0, arg_4_1)
			self:checkCharByIndex()

			return iter_4_0 - 1
		end
	end

	table.insert(self.sortedItems, #self.sortedItems + 1, arg_4_1)
	self:checkCharByIndex()

	return #self.sortedItems
end

function IsometricMap:checkCharByIndex()
	for iter_5_0 = 1, #self.sortedItems do
		assert(self.sortedItems[iter_5_0].posZ >= self.sortedItems[math.min(iter_5_0 + 1, #self.sortedItems)].posZ, "舰娘插入队列位置错误")
	end

	return
end

function IsometricMap:RemoveChar(arg_6_1)
	table.removebyvalue(self.sortedItems, arg_6_1)

	return
end

function IsometricMap:CreateItem(arg_7_1, arg_7_2, arg_7_3)
	return {
		maxY = 0,
		sortedFlag = true,
		maxX = 0,
		posY = 0,
		posX = 0,
		posZ = 0,
		ob = arg_7_3,
		sizeX = arg_7_1,
		sizeY = arg_7_2,
		SetPos = function(self, arg_8_1, arg_8_2)
			self.posX = arg_8_1
			self.posY = arg_8_2
			self.maxX = arg_8_1 + self.sizeX - 1
			self.maxY = arg_8_2 + self.sizeY - 1

			return
		end,
		SetDepth = function(arg_9_0, arg_9_1)
			arg_9_0.posZ = arg_9_1

			return
		end
	}
end

function IsometricMap:GetIndex(arg_10_1, arg_10_2)
	return (arg_10_2 - 1) * self.sizeX + arg_10_1
end

function IsometricMap:ResetDepth()
	for iter_11_0 = 1, self.sizeX do
		for iter_11_1 = 1, self.sizeY do
			self.depths[self:GetIndex(iter_11_0, iter_11_1)] = iter_11_0 + iter_11_1 - 1
		end
	end

	return
end

function IsometricMap:AddDepth(arg_12_1, arg_12_2, arg_12_3)
	for iter_12_0 = 1, arg_12_1 do
		for iter_12_1 = 1, arg_12_2 do
			local var_12_0 = self:GetIndex(iter_12_0, iter_12_1)

			self.depths[var_12_0] = self.depths[var_12_0] + arg_12_3
		end
	end

	return
end

function IsometricMap:ModifyDepth(arg_13_1)
	local var_13_0 = self.depths[self:GetIndex(arg_13_1.maxX, arg_13_1.posY)]
	local var_13_1 = self.depths[self:GetIndex(arg_13_1.posX, arg_13_1.maxY)]

	if var_13_0 == var_13_1 then
		arg_13_1:SetDepth(var_13_0)

		return
	end

	if var_13_0 < var_13_1 then
		if arg_13_1.posX > 1 then
			local var_13_2 = var_13_0 - 1 - self.depths[self:GetIndex(arg_13_1.posX - 1, arg_13_1.maxY)]

			if var_13_2 < 0 then
				self:AddDepth(arg_13_1.posX - 1, arg_13_1.maxY, var_13_2)
			end
		end

		arg_13_1:SetDepth(var_13_0)

		return
	else
		if arg_13_1.posY > 1 then
			local var_13_3 = var_13_1 - 1 - self.depths[self:GetIndex(arg_13_1.maxX, arg_13_1.posY - 1)]

			if var_13_3 < 0 then
				self:AddDepth(arg_13_1.maxX, arg_13_1.posY - 1, var_13_3)
			end
		end

		arg_13_1:SetDepth(var_13_1)

		return
	end

	return
end

function IsometricMap:PlaceItem(arg_14_1, arg_14_2, arg_14_3)
	arg_14_3:SetPos(arg_14_1, arg_14_2)

	local var_14_0 = {}

	self.dependInfo[arg_14_3] = var_14_0

	for iter_14_0, iter_14_1 in ipairs(self.allItems) do
		if arg_14_1 <= iter_14_1.maxX and arg_14_2 <= iter_14_1.maxY then
			var_14_0[#var_14_0 + 1] = iter_14_1
		elseif arg_14_3.maxX >= iter_14_1.posX and arg_14_3.maxY >= iter_14_1.posY then
			table.insert(self.dependInfo[iter_14_1], arg_14_3)
		end
	end

	table.insert(self.allItems, arg_14_3)

	arg_14_3.sortedFlag = self.sortedFlag

	self:SortAndCalcDepth()

	if self.afterSortFunc then
		self.afterSortFunc(self.sortedItems)
	end

	return
end

function IsometricMap:sortItemByDepth(arg_15_1)
	return self.posZ > arg_15_1.posZ
end

function IsometricMap:SortAndCalcDepth()
	local var_16_0 = {}

	self.sortedItems = var_16_0
	self.sortedFlag = not self.sortedFlag

	for iter_16_0, iter_16_1 in ipairs(self.allItems) do
		self:AddItemAndDepend(iter_16_1)
	end

	self:ResetDepth()

	for iter_16_2, iter_16_3 in ipairs(var_16_0) do
		self:ModifyDepth(iter_16_3)
	end

	table.sort(var_16_0, IsometricMap.sortItemByDepth)

	return
end

function IsometricMap:AddItemAndDepend(arg_17_1)
	if arg_17_1.sortedFlag == self.sortedFlag then
		return
	end

	for iter_17_0, iter_17_1 in ipairs(self.dependInfo[arg_17_1]) do
		self:AddItemAndDepend(iter_17_1)
	end

	table.insert(self.sortedItems, arg_17_1)
	assert(arg_17_1.sortedFlag ~= self.sortedFlag, "依赖关系产生了循环！")

	arg_17_1.sortedFlag = self.sortedFlag

	return
end

function IsometricMap:RemoveItem(arg_18_1)
	table.removebyvalue(self.allItems, arg_18_1)

	self.dependInfo[arg_18_1] = nil

	for iter_18_0, iter_18_1 in ipairs(self.allItems) do
		if arg_18_1.maxX >= iter_18_1.posX and arg_18_1.maxY >= iter_18_1.posY then
			table.removebyvalue(self.dependInfo[iter_18_1], arg_18_1)
		end
	end

	arg_18_1:SetPos(0, 0)
	self:SortAndCalcDepth()
	table.removebyvalue(self.sortedItems, arg_18_1)

	return
end

return
