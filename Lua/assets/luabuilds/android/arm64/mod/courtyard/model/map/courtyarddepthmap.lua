local var_0_0 = class("CourtYardDepthMap")

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
			arg_4_0:CheckCharByIndex()

			return iter_4_0 - 1
		end
	end

	table.insert(arg_4_0.sortedItems, #arg_4_0.sortedItems + 1, arg_4_1)
	arg_4_0:CheckCharByIndex()

	return #arg_4_0.sortedItems
end

function var_0_0.CheckCharByIndex(arg_5_0)
	for iter_5_0 = 1, #arg_5_0.sortedItems do
		assert(arg_5_0.sortedItems[iter_5_0].posZ >= arg_5_0.sortedItems[math.min(iter_5_0 + 1, #arg_5_0.sortedItems)].posZ, "舰娘插入队列位置错误")
	end

	return
end

function var_0_0.RemoveChar(arg_6_0, arg_6_1)
	table.removebyvalue(arg_6_0.sortedItems, arg_6_1)

	return
end

function var_0_0.GetIndex(arg_7_0, arg_7_1, arg_7_2)
	return (arg_7_2 - 1) * arg_7_0.sizeX + arg_7_1
end

function var_0_0.ResetDepth(arg_8_0)
	for iter_8_0 = 1, arg_8_0.sizeX do
		for iter_8_1 = 1, arg_8_0.sizeY do
			arg_8_0.depths[arg_8_0:GetIndex(iter_8_0, iter_8_1)] = iter_8_0 + iter_8_1 - 1
		end
	end

	return
end

function var_0_0.AddDepth(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	for iter_9_0 = 1, arg_9_1 do
		for iter_9_1 = 1, arg_9_2 do
			local var_9_0 = arg_9_0:GetIndex(iter_9_0, iter_9_1)

			arg_9_0.depths[var_9_0] = arg_9_0.depths[var_9_0] + arg_9_3
		end
	end

	return
end

function var_0_0.ModifyDepth(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0.depths[arg_10_0:GetIndex(arg_10_1.maxX, arg_10_1.posY)]
	local var_10_1 = arg_10_0.depths[arg_10_0:GetIndex(arg_10_1.posX, arg_10_1.maxY)]

	if var_10_0 == var_10_1 then
		arg_10_1:SetDepth(var_10_0)

		return
	end

	if var_10_0 < var_10_1 then
		if arg_10_1.posX > 1 then
			local var_10_2 = var_10_0 - 1 - arg_10_0.depths[arg_10_0:GetIndex(arg_10_1.posX - 1, arg_10_1.maxY)]

			if var_10_2 < 0 then
				arg_10_0:AddDepth(arg_10_1.posX - 1, arg_10_1.maxY, var_10_2)
			end
		end

		arg_10_1:SetDepth(var_10_0)

		return
	else
		if arg_10_1.posY > 1 then
			local var_10_3 = var_10_1 - 1 - arg_10_0.depths[arg_10_0:GetIndex(arg_10_1.maxX, arg_10_1.posY - 1)]

			if var_10_3 < 0 then
				arg_10_0:AddDepth(arg_10_1.maxX, arg_10_1.posY - 1, var_10_3)
			end
		end

		arg_10_1:SetDepth(var_10_1)

		return
	end

	return
end

function var_0_0.PlaceItem(arg_11_0, arg_11_1)
	arg_11_0.dependInfo[arg_11_1] = {}

	for iter_11_0, iter_11_1 in ipairs(arg_11_0.allItems) do
		if arg_11_1.posX <= iter_11_1.maxX and arg_11_1.posY <= iter_11_1.maxY then
			({})[#{} + 1] = iter_11_1
		elseif arg_11_1.maxX >= iter_11_1.posX and arg_11_1.maxY >= iter_11_1.posY then
			table.insert(arg_11_0.dependInfo[iter_11_1], arg_11_1)
		end
	end

	table.insert(arg_11_0.allItems, arg_11_1)

	arg_11_1.sortedFlag = arg_11_0.sortedFlag

	arg_11_0:SortAndCalcDepth()

	if arg_11_0.afterSortFunc then
		arg_11_0.afterSortFunc(arg_11_0.sortedItems)
	end

	return
end

function var_0_0.sortItemByDepth(arg_12_0, arg_12_1)
	return arg_12_0.posZ > arg_12_1.posZ
end

function var_0_0.SortAndCalcDepth(arg_13_0)
	arg_13_0.sortedItems = {}
	arg_13_0.sortedFlag = not arg_13_0.sortedFlag

	for iter_13_0, iter_13_1 in ipairs(arg_13_0.allItems) do
		arg_13_0:AddItemAndDepend(iter_13_1)
	end

	arg_13_0:ResetDepth()

	for iter_13_2, iter_13_3 in ipairs({}) do
		arg_13_0:ModifyDepth(iter_13_3)
	end

	table.sort({}, var_0_0.sortItemByDepth)

	return
end

function var_0_0.AddItemAndDepend(arg_14_0, arg_14_1)
	if arg_14_1.sortedFlag == arg_14_0.sortedFlag then
		return
	end

	for iter_14_0, iter_14_1 in ipairs(arg_14_0.dependInfo[arg_14_1]) do
		arg_14_0:AddItemAndDepend(iter_14_1)
	end

	table.insert(arg_14_0.sortedItems, arg_14_1)
	assert(arg_14_1.sortedFlag ~= sortedFlag, "依赖关系产生了循环！")

	arg_14_1.sortedFlag = arg_14_0.sortedFlag

	return
end

function var_0_0.RemoveItem(arg_15_0, arg_15_1)
	table.removebyvalue(arg_15_0.allItems, arg_15_1)

	arg_15_0.dependInfo[arg_15_1] = nil

	for iter_15_0, iter_15_1 in ipairs(arg_15_0.allItems) do
		if arg_15_1.maxX >= iter_15_1.posX and arg_15_1.maxY >= iter_15_1.posY then
			table.removebyvalue(arg_15_0.dependInfo[iter_15_1], arg_15_1)
		end
	end

	arg_15_0:SortAndCalcDepth()
	table.removebyvalue(arg_15_0.sortedItems, arg_15_1)

	return
end

return var_0_0
