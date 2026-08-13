class = var_0_10000

local var_0_0 = var_0_10000("CourtYardDepthMap")

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

	ipairs = var_3

	for iter_4_0, iter_4_1 in var_3(arg_4_0.sortedItems) do
		if iter_4_1.posZ < var_4_0 then
			table = var_8

			var_8.insert(arg_4_0.sortedItems, iter_4_0, arg_4_1)
			arg_4_0:CheckCharByIndex()

			return iter_4_0 - 1
		end
	end

	local var_4_1 = #arg_4_0.sortedItems

	table = var_4

	var_4.insert(arg_4_0.sortedItems, var_4_1 + 1, arg_4_1)
	arg_4_0:CheckCharByIndex()

	return var_4_1
end

function var_0_0.CheckCharByIndex(arg_5_0)
	for iter_5_0 = 1, #arg_5_0.sortedItems do
		math = var_1_10005
		var_1_10005 = var_1_10005.min(iter_5_0 + 1, #arg_5_0.sortedItems)
		assert = var_6

		var_6(arg_5_0.sortedItems[iter_5_0].posZ >= arg_5_0.sortedItems[var_1_10005].posZ, "舰娘插入队列位置错误")
	end

	return
end

function var_0_0.RemoveChar(arg_6_0, arg_6_1)
	table = var_1_10002

	var_1_10002.removebyvalue(arg_6_0.sortedItems, arg_6_1)

	return
end

function var_0_0.GetIndex(arg_7_0, arg_7_1, arg_7_2)
	return (arg_7_2 - 1) * arg_7_0.sizeX + arg_7_1
end

function var_0_0.ResetDepth(arg_8_0)
	local var_8_0 = arg_8_0.depths

	for iter_8_0 = 1, arg_8_0.sizeX do
		for iter_8_1 = 1, arg_8_0.sizeY do
			var_8_0[arg_8_0:GetIndex(iter_8_0, iter_8_1)] = iter_8_0 + iter_8_1 - 1
		end
	end

	return
end

function var_0_0.AddDepth(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = arg_9_0.depths

	for iter_9_0 = 1, arg_9_1 do
		for iter_9_1 = 1, arg_9_2 do
			var_9_0[var_13] = var_9_0[arg_9_0:GetIndex(iter_9_0, iter_9_1)] + arg_9_3
		end
	end

	return
end

function var_0_0.ModifyDepth(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0.depths
	local var_10_1 = arg_10_1.posX
	local var_10_2 = arg_10_1.posY
	local var_10_3 = arg_10_1.maxX
	local var_10_4 = arg_10_1.maxY

	if var_10_0[arg_10_0:GetIndex(var_10_3, var_10_2)] == var_10_0[arg_10_0:GetIndex(var_10_1, var_10_4)] then
		arg_10_1:SetDepth(var_7)

		return
	end

	if var_7 < var_8 then
		if var_10_1 > 1 and var_7 - 1 - var_10_0[arg_10_0:GetIndex(var_10_1 - 1, var_10_4)] < 0 then
			arg_10_0:AddDepth(var_10_1 - 1, var_10_4, var_9)
		end

		arg_10_1:SetDepth(var_7)

		return
	else
		if var_10_2 > 1 and var_8 - 1 - var_10_0[arg_10_0:GetIndex(var_10_3, var_10_2 - 1)] < 0 then
			arg_10_0:AddDepth(var_10_3, var_10_2 - 1, var_9)
		end

		arg_10_1:SetDepth(var_8)

		return
	end

	return
end

function var_0_0.PlaceItem(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1.maxX
	local var_11_1 = arg_11_1.maxY
	local var_11_2 = arg_11_1.posX
	local var_11_3 = arg_11_1.posY
	local var_11_4 = {}
	local var_11_5 = arg_11_0.dependInfo

	var_11_5[arg_11_1] = var_11_4
	ipairs = var_11_5

	for iter_11_0, iter_11_1 in var_11_5(arg_11_0.allItems) do
		if var_11_2 <= iter_11_1.maxX and var_11_3 <= iter_11_1.maxY then
			var_11_4[#var_11_4 + 1] = iter_11_1
		elseif var_11_0 >= iter_11_1.posX and iter_11_1.posY <= var_11_1 then
			table = var_12

			var_12.insert(arg_11_0.dependInfo[iter_11_1], arg_11_1)
		end
	end

	table = var_7

	var_7.insert(arg_11_0.allItems, arg_11_1)

	arg_11_1.sortedFlag = arg_11_0.sortedFlag

	arg_11_0:SortAndCalcDepth()

	if arg_11_0.afterSortFunc then
		var_7(arg_11_0.sortedItems)
	end

	return
end

function var_0_0.sortItemByDepth(arg_12_0, arg_12_1)
	return arg_12_0.posZ > arg_12_1.posZ
end

function var_0_0.SortAndCalcDepth(arg_13_0)
	arg_13_0.sortedItems = {}
	arg_13_0.sortedFlag = not arg_13_0.sortedFlag
	ipairs = var_2

	for iter_13_0, iter_13_1 in var_2(arg_13_0.allItems) do
		arg_13_0:AddItemAndDepend(iter_13_1)
	end

	arg_13_0:ResetDepth()

	ipairs = var_2

	for iter_13_2, iter_13_3 in var_2(var_1) do
		arg_13_0:ModifyDepth(iter_13_3)
	end

	table = var_2

	var_2.sort(var_1, var_0_0.sortItemByDepth)

	return
end

function var_0_0.AddItemAndDepend(arg_14_0, arg_14_1)
	if arg_14_1.sortedFlag == arg_14_0.sortedFlag then
		return
	end

	ipairs = var_2

	for iter_14_0, iter_14_1 in var_2(arg_14_0.dependInfo[arg_14_1]) do
		arg_14_0:AddItemAndDepend(iter_14_1)
	end

	table = var_2

	var_2.insert(arg_14_0.sortedItems, arg_14_1)

	assert = var_2

	local var_14_0 = arg_14_1.sortedFlag

	sortedFlag = var_4

	var_2(var_14_0 ~= var_4, "依赖关系产生了循环！")

	arg_14_1.sortedFlag = arg_14_0.sortedFlag

	return
end

function var_0_0.RemoveItem(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_1.posX
	local var_15_1 = arg_15_1.posY
	local var_15_2 = arg_15_1.maxX
	local var_15_3 = arg_15_1.maxY

	table = var_1_10006

	var_1_10006.removebyvalue(arg_15_0.allItems, arg_15_1)

	local var_15_4 = arg_15_0.dependInfo

	var_15_4[arg_15_1] = nil
	ipairs = var_7

	for iter_15_0, iter_15_1 in var_7(arg_15_0.allItems) do
		if var_15_2 >= iter_15_1.posX and iter_15_1.posY <= var_15_3 then
			table = var_12

			var_12.removebyvalue(var_15_4[iter_15_1], arg_15_1)
		end
	end

	arg_15_0:SortAndCalcDepth()

	table = var_7

	var_7.removebyvalue(arg_15_0.sortedItems, arg_15_1)

	return
end

return var_0_0
