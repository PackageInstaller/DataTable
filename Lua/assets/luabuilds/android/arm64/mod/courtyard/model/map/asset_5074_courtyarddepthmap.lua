local CourtYardDepthMap = class("CourtYardDepthMap")

function CourtYardDepthMap:Ctor(arg_1_1, arg_1_2)
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

function CourtYardDepthMap:SetAfterFunc(arg_2_1)
	self.afterSortFunc = arg_2_1

	return
end

function CourtYardDepthMap:GetDepth(arg_3_1, arg_3_2)
	return self.depths[self:GetIndex(arg_3_1, arg_3_2)]
end

function CourtYardDepthMap:InsertChar(arg_4_1)
	local var_4_0 = self:GetDepth(arg_4_1.posX, arg_4_1.posY)

	arg_4_1:SetDepth(var_4_0)

	for iter_4_0, iter_4_1 in ipairs(self.sortedItems) do
		if var_4_0 > iter_4_1.posZ then
			table.insert(self.sortedItems, iter_4_0, arg_4_1)
			self:CheckCharByIndex()

			return iter_4_0 - 1
		end
	end

	table.insert(self.sortedItems, #self.sortedItems + 1, arg_4_1)
	self:CheckCharByIndex()

	return #self.sortedItems
end

function CourtYardDepthMap:CheckCharByIndex()
	for iter_5_0 = 1, #self.sortedItems do
		assert(self.sortedItems[iter_5_0].posZ >= self.sortedItems[math.min(iter_5_0 + 1, #self.sortedItems)].posZ, "舰娘插入队列位置错误")
	end

	return
end

function CourtYardDepthMap:RemoveChar(arg_6_1)
	table.removebyvalue(self.sortedItems, arg_6_1)

	return
end

function CourtYardDepthMap:GetIndex(arg_7_1, arg_7_2)
	return (arg_7_2 - 1) * self.sizeX + arg_7_1
end

function CourtYardDepthMap:ResetDepth()
	for iter_8_0 = 1, self.sizeX do
		for iter_8_1 = 1, self.sizeY do
			self.depths[self:GetIndex(iter_8_0, iter_8_1)] = iter_8_0 + iter_8_1 - 1
		end
	end

	return
end

function CourtYardDepthMap:AddDepth(arg_9_1, arg_9_2, arg_9_3)
	for iter_9_0 = 1, arg_9_1 do
		for iter_9_1 = 1, arg_9_2 do
			local var_9_0 = self:GetIndex(iter_9_0, iter_9_1)

			self.depths[var_9_0] = self.depths[var_9_0] + arg_9_3
		end
	end

	return
end

function CourtYardDepthMap:ModifyDepth(arg_10_1)
	local var_10_0 = self.depths[self:GetIndex(arg_10_1.maxX, arg_10_1.posY)]
	local var_10_1 = self.depths[self:GetIndex(arg_10_1.posX, arg_10_1.maxY)]

	if var_10_0 == var_10_1 then
		arg_10_1:SetDepth(var_10_0)

		return
	end

	if var_10_0 < var_10_1 then
		if arg_10_1.posX > 1 then
			local var_10_2 = var_10_0 - 1 - self.depths[self:GetIndex(arg_10_1.posX - 1, arg_10_1.maxY)]

			if var_10_2 < 0 then
				self:AddDepth(arg_10_1.posX - 1, arg_10_1.maxY, var_10_2)
			end
		end

		arg_10_1:SetDepth(var_10_0)

		return
	else
		if arg_10_1.posY > 1 then
			local var_10_3 = var_10_1 - 1 - self.depths[self:GetIndex(arg_10_1.maxX, arg_10_1.posY - 1)]

			if var_10_3 < 0 then
				self:AddDepth(arg_10_1.maxX, arg_10_1.posY - 1, var_10_3)
			end
		end

		arg_10_1:SetDepth(var_10_1)

		return
	end

	return
end

function CourtYardDepthMap:PlaceItem(arg_11_1)
	local var_11_0 = {}

	self.dependInfo[arg_11_1] = var_11_0

	for iter_11_0, iter_11_1 in ipairs(self.allItems) do
		if arg_11_1.posX <= iter_11_1.maxX and arg_11_1.posY <= iter_11_1.maxY then
			var_11_0[#var_11_0 + 1] = iter_11_1
		elseif arg_11_1.maxX >= iter_11_1.posX and arg_11_1.maxY >= iter_11_1.posY then
			table.insert(self.dependInfo[iter_11_1], arg_11_1)
		end
	end

	table.insert(self.allItems, arg_11_1)

	arg_11_1.sortedFlag = self.sortedFlag

	self:SortAndCalcDepth()

	if self.afterSortFunc then
		self.afterSortFunc(self.sortedItems)
	end

	return
end

function CourtYardDepthMap:sortItemByDepth(arg_12_1)
	return self.posZ > arg_12_1.posZ
end

function CourtYardDepthMap:SortAndCalcDepth()
	local var_13_0 = {}

	self.sortedItems = var_13_0
	self.sortedFlag = not self.sortedFlag

	for iter_13_0, iter_13_1 in ipairs(self.allItems) do
		self:AddItemAndDepend(iter_13_1)
	end

	self:ResetDepth()

	for iter_13_2, iter_13_3 in ipairs(var_13_0) do
		self:ModifyDepth(iter_13_3)
	end

	table.sort(var_13_0, CourtYardDepthMap.sortItemByDepth)

	return
end

function CourtYardDepthMap:AddItemAndDepend(arg_14_1)
	if arg_14_1.sortedFlag == self.sortedFlag then
		return
	end

	for iter_14_0, iter_14_1 in ipairs(self.dependInfo[arg_14_1]) do
		self:AddItemAndDepend(iter_14_1)
	end

	table.insert(self.sortedItems, arg_14_1)
	assert(arg_14_1.sortedFlag ~= sortedFlag, "依赖关系产生了循环！")

	arg_14_1.sortedFlag = self.sortedFlag

	return
end

function CourtYardDepthMap:RemoveItem(arg_15_1)
	table.removebyvalue(self.allItems, arg_15_1)

	self.dependInfo[arg_15_1] = nil

	for iter_15_0, iter_15_1 in ipairs(self.allItems) do
		if arg_15_1.maxX >= iter_15_1.posX and arg_15_1.maxY >= iter_15_1.posY then
			table.removebyvalue(self.dependInfo[iter_15_1], arg_15_1)
		end
	end

	self:SortAndCalcDepth()
	table.removebyvalue(self.sortedItems, arg_15_1)

	return
end

return CourtYardDepthMap
