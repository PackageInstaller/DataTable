class = var_0_10000

local var_0_0 = "MetaCharacterAttr"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..BaseVO"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.attr = arg_1_1.attr
	_ = var_2

	local var_1_0 = var_2.map
	local var_1_1

	if not arg_1_1.items then
		var_1_1 = {}
	end

	arg_1_0.items = var_1_0(var_1_1, function(arg_2_0)
		MetaRepairItem = var_2_10001

		return var_2_10001.New({
			id = arg_2_0
		})
	end)

	local var_1_2

	if not arg_1_1.level then
		var_1_2 = 1
	end

	arg_1_0.level = var_1_2

	return
end

function var_0_1.getLevelByItemId(arg_3_0, arg_3_1)
	local var_3_0 = 1

	pairs = var_1_10003

	for iter_3_0, iter_3_1 in var_1_10003(arg_3_0.items) do
		if iter_3_1.id == arg_3_1 then
			var_3_0 = iter_3_0 + 1

			break
		end
	end

	return var_3_0
end

function var_0_1.updateCount(arg_4_0, arg_4_1)
	if arg_4_1 > arg_4_0.level then
		arg_4_0.level = arg_4_1
	end

	return
end

function var_0_1.hasItemId(arg_5_0, arg_5_1)
	_ = var_1_10002

	return var_1_10002.any(arg_5_0.items, function(arg_6_0)
		return arg_6_0.id == arg_5_1
	end)
end

function var_0_1.getLevel(arg_7_0)
	return arg_7_0.level
end

function var_0_1.isMaxLevel(arg_8_0)
	return arg_8_0.level > #arg_8_0.items
end

function var_0_1.getAddition(arg_9_0)
	local var_9_0 = 0

	for iter_9_0 = 1, arg_9_0.level - 1 do
		local var_9_1 = arg_9_0.items[iter_9_0]

		var_9_0 = var_9_0 + var_6.getAdditionValue(var_9_1)
	end

	return var_9_0
end

function var_0_1.getMaxAddition(arg_10_0)
	local var_10_0 = 0

	ipairs = var_1_10002

	for iter_10_0, iter_10_1 in var_1_10002(arg_10_0.items) do
		var_10_0 = var_10_0 + iter_10_1:getAdditionValue()
	end

	return var_10_0
end

function var_0_1.getRepairExp(arg_11_0)
	local var_11_0 = 0

	for iter_11_0 = 1, arg_11_0.level - 1 do
		local var_11_1 = arg_11_0.items[iter_11_0]

		var_11_0 = var_11_0 + var_6.getRepairExp(var_11_1)
	end

	return var_11_0
end

function var_0_1.getItem(arg_12_0)
	assert = var_1_10001

	var_1_10001(arg_12_0.items[arg_12_0.level], "level : " .. arg_12_0.level)

	return arg_12_0.items[arg_12_0.level]
end

function var_0_1.getItemByLevel(arg_13_0, arg_13_1)
	return arg_13_0.items[arg_13_1]
end

function var_0_1.levelUp(arg_14_0)
	if not arg_14_0:isMaxLevel() then
		arg_14_0.level = arg_14_0.level + 1
	end

	return
end

function var_0_1.isCanRepair(arg_15_0)
	if arg_15_0:isMaxLevel() then
		return false
	end

	local var_15_0 = arg_15_0:getItem()
	local var_15_1 = var_2.getItemId(var_15_0)
	local var_15_2 = var_2:getTotalCnt()

	getProxy = var_15_0
	BagProxy = var_1_10007

	local var_15_3 = var_15_0(var_1_10007)

	if var_15_2 <= var_5.getItemCountById(var_15_3, var_15_1) then
		return true
	else
		return false
	end

	return
end

function var_0_1.getItemCount(arg_16_0)
	return #arg_16_0.items
end

function var_0_1.isLock(arg_17_0)
	return arg_17_0:getItemCount() == 0
end

return var_0_1
