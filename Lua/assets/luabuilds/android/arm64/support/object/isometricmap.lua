pg = pg or {}

local var_0_0 = class("IsometricMap")

pg.IsometricMap = var_0_0

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.sizeX = arg_1_1
	arg_1_0.sizeY = arg_1_2
	arg_1_0.depths = {}
	arg_1_0.dependInfo = {}
	arg_1_0.allItems = {}
	arg_1_0.sortedFlag = false
	arg_1_0.sortedItems = {}

	arg_1_0:ResetDepth()

	return
end

function var_0_0.SetAfterFunc(arg_2_0, arg_2_1)
	arg_2_0.afterSortFunc = arg_2_1

	return
end

function var_0_0.GetDepth(arg_3_0, arg_3_1, arg_3_2)
	return arg_3_0.depths[arg_3_0:GetIndex(arg_3_1, arg_3_2)]
end

function var_0_0.InsertChar(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0:GetDepth(arg_4_1.posX, arg_4_1.posY)

	arg_4_1:SetDepth(var_4_0)

	for iter_4_0, iter_4_1 in ipairs(arg_4_0.sortedItems) do
		if var_4_0 > iter_4_1.posZ then
			table.insert(arg_4_0.sortedItems, iter_4_0, arg_4_1)
			arg_4_0:checkCharByIndex()

			return iter_4_0 - 1
		end
	end

	table.insert(arg_4_0.sortedItems, #arg_4_0.sortedItems + 1, arg_4_1)
	arg_4_0:checkCharByIndex()

	return #arg_4_0.sortedItems
end

function var_0_0.checkCharByIndex(arg_5_0)
	for iter_5_0 = 1, #arg_5_0.sortedItems do
		assert(arg_5_0.sortedItems[iter_5_0].posZ >= arg_5_0.sortedItems[math.min(iter_5_0 + 1, #arg_5_0.sortedItems)].posZ, "舰娘插入队列位置错误")
	end

	return
end

function var_0_0.RemoveChar(arg_6_0, arg_6_1)
	table.removebyvalue(arg_6_0.sortedItems, arg_6_1)

	return
end

function var_0_0.CreateItem(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
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
		SetPos = function(arg_8_0, arg_8_1, arg_8_2)
			arg_8_0.posX = arg_8_1
			arg_8_0.posY = arg_8_2
			arg_8_0.maxX = arg_8_1 + arg_8_0.sizeX - 1
			arg_8_0.maxY = arg_8_2 + arg_8_0.sizeY - 1

			return
		end,
		SetDepth = function(arg_9_0, arg_9_1)
			arg_9_0.posZ = arg_9_1

			return
		end
	}
end

function var_0_0.GetIndex(arg_10_0, arg_10_1, arg_10_2)
	return (arg_10_2 - 1) * arg_10_0.sizeX + arg_10_1
end

function var_0_0.ResetDepth(arg_11_0)
	for iter_11_0 = 1, arg_11_0.sizeX do
		for iter_11_1 = 1, arg_11_0.sizeY do
			arg_11_0.depths[arg_11_0:GetIndex(iter_11_0, iter_11_1)] = iter_11_0 + iter_11_1 - 1
		end
	end

	return
end

function var_0_0.AddDepth(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	for iter_12_0 = 1, arg_12_1 do
		for iter_12_1 = 1, arg_12_2 do
			local var_12_0 = arg_12_0:GetIndex(iter_12_0, iter_12_1)

			arg_12_0.depths[var_12_0] = arg_12_0.depths[var_12_0] + arg_12_3
		end
	end

	return
end

function var_0_0.ModifyDepth(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0.depths[arg_13_0:GetIndex(arg_13_1.maxX, arg_13_1.posY)]
	local var_13_1 = arg_13_0.depths[arg_13_0:GetIndex(arg_13_1.posX, arg_13_1.maxY)]

	if var_13_0 == var_13_1 then
		arg_13_1:SetDepth(var_13_0)

		return
	end

	if var_13_0 < var_13_1 then
		if arg_13_1.posX > 1 then
			local var_13_2 = var_13_0 - 1 - arg_13_0.depths[arg_13_0:GetIndex(arg_13_1.posX - 1, arg_13_1.maxY)]

			if var_13_2 < 0 then
				arg_13_0:AddDepth(arg_13_1.posX - 1, arg_13_1.maxY, var_13_2)
			end
		end

		arg_13_1:SetDepth(var_13_0)

		return
	else
		if arg_13_1.posY > 1 then
			local var_13_3 = var_13_1 - 1 - arg_13_0.depths[arg_13_0:GetIndex(arg_13_1.maxX, arg_13_1.posY - 1)]

			if var_13_3 < 0 then
				arg_13_0:AddDepth(arg_13_1.maxX, arg_13_1.posY - 1, var_13_3)
			end
		end

		arg_13_1:SetDepth(var_13_1)

		return
	end

	return
end

function var_0_0.PlaceItem(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	arg_14_3:SetPos(arg_14_1, arg_14_2)

	arg_14_0.dependInfo[arg_14_3] = {}

	for iter_14_0, iter_14_1 in ipairs(arg_14_0.allItems) do
		if arg_14_1 <= iter_14_1.maxX and arg_14_2 <= iter_14_1.maxY then
			({})[#{} + 1] = iter_14_1
		elseif arg_14_3.maxX >= iter_14_1.posX and arg_14_3.maxY >= iter_14_1.posY then
			table.insert(arg_14_0.dependInfo[iter_14_1], arg_14_3)
		end
	end

	table.insert(arg_14_0.allItems, arg_14_3)

	arg_14_3.sortedFlag = arg_14_0.sortedFlag

	arg_14_0:SortAndCalcDepth()

	if arg_14_0.afterSortFunc then
		arg_14_0.afterSortFunc(arg_14_0.sortedItems)
	end

	return
end

function var_0_0.sortItemByDepth(arg_15_0, arg_15_1)
	return arg_15_0.posZ > arg_15_1.posZ
end

function var_0_0.SortAndCalcDepth(arg_16_0)
	arg_16_0.sortedItems = {}
	arg_16_0.sortedFlag = not arg_16_0.sortedFlag

	for iter_16_0, iter_16_1 in ipairs(arg_16_0.allItems) do
		arg_16_0:AddItemAndDepend(iter_16_1)
	end

	arg_16_0:ResetDepth()

	for iter_16_2, iter_16_3 in ipairs({}) do
		arg_16_0:ModifyDepth(iter_16_3)
	end

	table.sort({}, var_0_0.sortItemByDepth)

	return
end

function var_0_0.AddItemAndDepend(arg_17_0, arg_17_1)
	if arg_17_1.sortedFlag == arg_17_0.sortedFlag then
		return
	end

	for iter_17_0, iter_17_1 in ipairs(arg_17_0.dependInfo[arg_17_1]) do
		arg_17_0:AddItemAndDepend(iter_17_1)
	end

	table.insert(arg_17_0.sortedItems, arg_17_1)
	assert(arg_17_1.sortedFlag ~= arg_17_0.sortedFlag, "依赖关系产生了循环！")

	arg_17_1.sortedFlag = arg_17_0.sortedFlag

	return
end

function var_0_0.RemoveItem(arg_18_0, arg_18_1)
	table.removebyvalue(arg_18_0.allItems, arg_18_1)

	arg_18_0.dependInfo[arg_18_1] = nil

	for iter_18_0, iter_18_1 in ipairs(arg_18_0.allItems) do
		if arg_18_1.maxX >= iter_18_1.posX and arg_18_1.maxY >= iter_18_1.posY then
			table.removebyvalue(arg_18_0.dependInfo[iter_18_1], arg_18_1)
		end
	end

	arg_18_1:SetPos(0, 0)
	arg_18_0:SortAndCalcDepth()
	table.removebyvalue(arg_18_0.sortedItems, arg_18_1)

	return
end

return
