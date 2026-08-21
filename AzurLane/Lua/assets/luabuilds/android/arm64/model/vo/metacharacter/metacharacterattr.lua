local var_0_0 = class("MetaCharacterAttr", import("..BaseVO"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.attr = arg_1_1.attr

	local var_1_0 = arg_1_1.items or {}

	arg_1_0.items = _.map(var_1_0, function(arg_2_0)
		return MetaRepairItem.New({
			id = arg_2_0
		})
	end)
	arg_1_0.level = arg_1_1.level or 1

	return
end

function var_0_0.getLevelByItemId(arg_3_0, arg_3_1)
	local var_3_0 = 1

	for iter_3_0, iter_3_1 in pairs(arg_3_0.items) do
		if iter_3_1.id == arg_3_1 then
			var_3_0 = iter_3_0 + 1

			break
		end
	end

	return var_3_0
end

function var_0_0.updateCount(arg_4_0, arg_4_1)
	if arg_4_1 > arg_4_0.level then
		arg_4_0.level = arg_4_1
	end

	return
end

function var_0_0.hasItemId(arg_5_0, arg_5_1)
	return _.any(arg_5_0.items, function(arg_6_0)
		return arg_6_0.id == arg_5_1
	end)
end

function var_0_0.getLevel(arg_7_0)
	return arg_7_0.level
end

function var_0_0.isMaxLevel(arg_8_0)
	return arg_8_0.level > #arg_8_0.items
end

function var_0_0.getAddition(arg_9_0)
	local var_9_0 = 0

	for iter_9_0 = 1, arg_9_0.level - 1 do
		var_9_0 = var_9_0 + arg_9_0.items[iter_9_0]:getAdditionValue()
	end

	return var_9_0
end

function var_0_0.getMaxAddition(arg_10_0)
	local var_10_0 = 0

	for iter_10_0, iter_10_1 in ipairs(arg_10_0.items) do
		var_10_0 = var_10_0 + iter_10_1:getAdditionValue()
	end

	return var_10_0
end

function var_0_0.getRepairExp(arg_11_0)
	local var_11_0 = 0

	for iter_11_0 = 1, arg_11_0.level - 1 do
		var_11_0 = var_11_0 + arg_11_0.items[iter_11_0]:getRepairExp()
	end

	return var_11_0
end

function var_0_0.getItem(arg_12_0)
	assert(arg_12_0.items[arg_12_0.level], "level : " .. arg_12_0.level)

	return arg_12_0.items[arg_12_0.level]
end

function var_0_0.getItemByLevel(arg_13_0, arg_13_1)
	return arg_13_0.items[arg_13_1]
end

function var_0_0.levelUp(arg_14_0)
	if not arg_14_0:isMaxLevel() then
		arg_14_0.level = arg_14_0.level + 1
	end

	return
end

function var_0_0.isCanRepair(arg_15_0)
	if arg_15_0:isMaxLevel() then
		return false
	end

	local var_15_0 = arg_15_0:getItem()

	if var_15_0:getTotalCnt() <= getProxy(BagProxy):getItemCountById((var_15_0:getItemId())) then
		return true
	else
		return false
	end

	return
end

function var_0_0.getItemCount(arg_16_0)
	return #arg_16_0.items
end

function var_0_0.isLock(arg_17_0)
	return arg_17_0:getItemCount() == 0
end

return var_0_0
