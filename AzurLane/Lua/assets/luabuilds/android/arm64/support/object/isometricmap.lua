pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
class = var_0_10001
var_0.IsometricMap = var_0_10001("IsometricMap")

function var_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
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

function var_1.SetAfterFunc(arg_2_0, arg_2_1)
	arg_2_0.afterSortFunc = arg_2_1

	return
end

function var_1.GetDepth(arg_3_0, arg_3_1, arg_3_2)
	return arg_3_0.depths[arg_3_0:GetIndex(arg_3_1, arg_3_2)]
end

function var_1.InsertChar(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0:GetDepth(arg_4_1.posX, arg_4_1.posY)

	arg_4_1:SetDepth(var_4_0)

	ipairs = var_3

	for iter_4_0, iter_4_1 in var_3(arg_4_0.sortedItems) do
		if iter_4_1.posZ < var_4_0 then
			table = var_8

			var_8.insert(arg_4_0.sortedItems, iter_4_0, arg_4_1)
			arg_4_0:checkCharByIndex()

			return iter_4_0 - 1
		end
	end

	local var_4_1 = #arg_4_0.sortedItems

	table = var_4

	var_4.insert(arg_4_0.sortedItems, var_4_1 + 1, arg_4_1)
	arg_4_0:checkCharByIndex()

	return var_4_1
end

function var_1.checkCharByIndex(arg_5_0)
	for iter_5_0 = 1, #arg_5_0.sortedItems do
		math = var_1_10005
		var_1_10005 = var_1_10005.min(iter_5_0 + 1, #arg_5_0.sortedItems)
		assert = var_1_10006

		var_1_10006(arg_5_0.sortedItems[iter_5_0].posZ >= arg_5_0.sortedItems[var_1_10005].posZ, "舰娘插入队列位置错误")
	end

	return
end

function var_1.RemoveChar(arg_6_0, arg_6_1)
	table = var_1_10002

	var_1_10002.removebyvalue(arg_6_0.sortedItems, arg_6_1)

	return
end

function var_1.CreateItem(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
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

function var_1.GetIndex(arg_10_0, arg_10_1, arg_10_2)
	return (arg_10_2 - 1) * arg_10_0.sizeX + arg_10_1
end

function var_1.ResetDepth(arg_11_0)
	local var_11_0 = arg_11_0.depths

	for iter_11_0 = 1, arg_11_0.sizeX do
		for iter_11_1 = 1, arg_11_0.sizeY do
			var_11_0[arg_11_0:GetIndex(iter_11_0, iter_11_1)] = iter_11_0 + iter_11_1 - 1
		end
	end

	return
end

function var_1.AddDepth(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = arg_12_0.depths

	for iter_12_0 = 1, arg_12_1 do
		for iter_12_1 = 1, arg_12_2 do
			var_12_0[var_13] = var_12_0[arg_12_0:GetIndex(iter_12_0, iter_12_1)] + arg_12_3
		end
	end

	return
end

function var_1.ModifyDepth(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0.depths
	local var_13_1 = arg_13_1.posX
	local var_13_2 = arg_13_1.posY
	local var_13_3 = arg_13_1.maxX
	local var_13_4 = arg_13_1.maxY

	if var_13_0[arg_13_0:GetIndex(var_13_3, var_13_2)] == var_13_0[arg_13_0:GetIndex(var_13_1, var_13_4)] then
		arg_13_1:SetDepth(var_7)

		return
	end

	if var_7 < var_8 then
		if var_13_1 > 1 and var_7 - 1 - var_13_0[arg_13_0:GetIndex(var_13_1 - 1, var_13_4)] < 0 then
			arg_13_0:AddDepth(var_13_1 - 1, var_13_4, var_9)
		end

		arg_13_1:SetDepth(var_7)

		return
	else
		if var_13_2 > 1 and var_8 - 1 - var_13_0[arg_13_0:GetIndex(var_13_3, var_13_2 - 1)] < 0 then
			arg_13_0:AddDepth(var_13_3, var_13_2 - 1, var_9)
		end

		arg_13_1:SetDepth(var_8)

		return
	end

	return
end

function var_1.PlaceItem(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	arg_14_3:SetPos(arg_14_1, arg_14_2)

	local var_14_0 = arg_14_3.maxX
	local var_14_1 = arg_14_3.maxY
	local var_14_2 = {}
	local var_14_3 = arg_14_0.dependInfo

	var_14_3[arg_14_3] = var_14_2
	ipairs = var_14_3

	for iter_14_0, iter_14_1 in var_14_3(arg_14_0.allItems) do
		if arg_14_1 <= iter_14_1.maxX and arg_14_2 <= iter_14_1.maxY then
			var_14_2[#var_14_2 + 1] = iter_14_1
		elseif var_14_0 >= iter_14_1.posX and iter_14_1.posY <= var_14_1 then
			table = var_12

			var_12.insert(arg_14_0.dependInfo[iter_14_1], arg_14_3)
		end
	end

	table = var_7

	var_7.insert(arg_14_0.allItems, arg_14_3)

	arg_14_3.sortedFlag = arg_14_0.sortedFlag

	arg_14_0:SortAndCalcDepth()

	if arg_14_0.afterSortFunc then
		var_7(arg_14_0.sortedItems)
	end

	return
end

function var_1.sortItemByDepth(arg_15_0, arg_15_1)
	return arg_15_0.posZ > arg_15_1.posZ
end

function var_1.SortAndCalcDepth(arg_16_0)
	arg_16_0.sortedItems = {}
	arg_16_0.sortedFlag = not arg_16_0.sortedFlag
	ipairs = var_2

	for iter_16_0, iter_16_1 in var_2(arg_16_0.allItems) do
		arg_16_0:AddItemAndDepend(iter_16_1)
	end

	arg_16_0:ResetDepth()

	ipairs = var_2

	for iter_16_2, iter_16_3 in var_2(var_1) do
		arg_16_0:ModifyDepth(iter_16_3)
	end

	table = var_2

	var_2.sort(var_1, var_0.sortItemByDepth)

	return
end

function var_1.AddItemAndDepend(arg_17_0, arg_17_1)
	if arg_17_1.sortedFlag == arg_17_0.sortedFlag then
		return
	end

	ipairs = var_2

	for iter_17_0, iter_17_1 in var_2(arg_17_0.dependInfo[arg_17_1]) do
		arg_17_0:AddItemAndDepend(iter_17_1)
	end

	table = var_2

	var_2.insert(arg_17_0.sortedItems, arg_17_1)

	assert = var_2

	var_2(arg_17_1.sortedFlag ~= arg_17_0.sortedFlag, "依赖关系产生了循环！")

	arg_17_1.sortedFlag = arg_17_0.sortedFlag

	return
end

function var_1.RemoveItem(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_1.posX
	local var_18_1 = arg_18_1.posY
	local var_18_2 = arg_18_1.maxX
	local var_18_3 = arg_18_1.maxY

	table = var_1_10006

	var_1_10006.removebyvalue(arg_18_0.allItems, arg_18_1)

	local var_18_4 = arg_18_0.dependInfo

	var_18_4[arg_18_1] = nil
	ipairs = var_7

	for iter_18_0, iter_18_1 in var_7(arg_18_0.allItems) do
		if var_18_2 >= iter_18_1.posX and iter_18_1.posY <= var_18_3 then
			table = var_12

			var_12.removebyvalue(var_18_4[iter_18_1], arg_18_1)
		end
	end

	arg_18_1:SetPos(0, 0)
	arg_18_0:SortAndCalcDepth()

	table = var_7

	var_7.removebyvalue(arg_18_0.sortedItems, arg_18_1)

	return
end

return
