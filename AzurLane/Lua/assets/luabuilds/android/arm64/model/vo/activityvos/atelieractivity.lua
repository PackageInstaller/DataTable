class = var_0_10000

local var_0_0 = "AtelierActivity"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".VirtualBagActivity"))

function var_0_1.Ctor(arg_1_0, ...)
	var_0_1.super.Ctor(arg_1_0, ...)

	arg_1_0.items = {}
	arg_1_0.completeAllTools = {}
	_ = var_1
	arg_1_0.slots = var_1.map({
		1,
		2,
		3,
		4,
		5
	}, function()
		return {
			0,
			0
		}
	end)

	arg_1_0:InitAllFormulas()

	return
end

function var_0_1.GetItems(arg_3_0)
	return arg_3_0.items
end

function var_0_1.InitItems(arg_4_0, arg_4_1)
	_ = var_1_10002

	var_1_10002.each(arg_4_1, function(arg_5_0)
		local var_5_0 = arg_5_0.key
		local var_5_1 = arg_5_0.value
		local var_5_2 = arg_4_0.items
		local var_5_3

		if not arg_4_0.items[var_5_0] then
			AtelierMaterial = var_5_3
			var_5_3 = var_5_3.New({
				configId = var_5_0
			})
		end

		var_5_2[var_5_0] = var_5_3
		arg_4_0.items[var_5_0].count = arg_4_0.items[var_5_0].count + var_5_1

		return
	end)

	return
end

function var_0_1.GetSlots(arg_6_0)
	return arg_6_0.slots
end

function var_0_1.UpdateBuffSlots(arg_7_0, arg_7_1)
	_ = var_1_10002

	var_1_10002.each(arg_7_1, function(arg_8_0)
		arg_7_0.slots[arg_8_0.pos] = {
			arg_8_0.itemid,
			arg_8_0.itemnum
		}

		return
	end)

	return
end

function var_0_1.AddItem(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1:GetConfigID()
	local var_9_1 = arg_9_1.count
	local var_9_2 = arg_9_0.items
	local var_9_3

	if not arg_9_0.items[var_9_0] then
		AtelierMaterial = var_9_3
		var_9_3 = var_9_3.New({
			configId = var_9_0
		})
	end

	var_9_2[var_9_0] = var_9_3
	arg_9_0.items[var_9_0].count = arg_9_0.items[var_9_0].count + var_9_1

	return
end

function var_0_1.GetItemById(arg_10_0, arg_10_1)
	return arg_10_0.items[arg_10_1]
end

function var_0_1.subItemCount(arg_11_0, arg_11_1, arg_11_2)
	if not arg_11_0.items[arg_11_1] then
		return
	end

	local var_11_0 = arg_11_0.items[arg_11_1]

	math = var_1_10004
	var_11_0.count = var_1_10004.max(0, arg_11_0.items[arg_11_1].count - arg_11_2)

	return
end

function var_0_1.GetAllVitems(arg_12_0)
	table = var_1_10001

	return var_1_10001.map(arg_12_0:GetItems(), function(arg_13_0)
		return arg_13_0.count
	end)
end

function var_0_1.getVitemNumber(arg_14_0, arg_14_1)
	local var_14_0

	if not arg_14_0:GetItemById(arg_14_1) or not var_2.count then
		var_14_0 = 0
	end

	return var_14_0
end

function var_0_1.addVitemNumber(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_0
	local var_15_1 = arg_15_0.AddItem

	AtelierMaterial = var_1_10006

	var_15_1(var_15_0, var_1_10006.New({
		configId = arg_15_1,
		count = arg_15_2
	}))

	return
end

function var_0_1.subVitemNumber(arg_16_0, arg_16_1, arg_16_2)
	arg_16_0:subItemCount(arg_16_1, arg_16_2)

	return
end

function var_0_1.GetFormulas(arg_17_0)
	return arg_17_0.formulas
end

function var_0_1.GetFormulasByVersion(arg_18_0, arg_18_1)
	local var_18_0 = {}

	pairs = var_1_10003

	for iter_18_0, iter_18_1 in var_1_10003(arg_18_0.formulas) do
		if iter_18_1:getConfig("version") == arg_18_1 then
			table = var_8

			var_8.insert(var_18_0, iter_18_1)
		end
	end

	return var_18_0
end

function var_0_1.InitAllFormulas(arg_19_0)
	arg_19_0.formulas = {}
	_ = var_1

	local var_19_0 = var_1.each

	pg = var_1_10003

	var_19_0(var_1_10003.activity_ryza_recipe.all, function(arg_20_0)
		local var_20_0 = arg_19_0.formulas

		AtelierFormula = var_2_10002
		var_20_0[arg_20_0] = var_2_10002.New({
			configId = arg_20_0
		})

		return
	end)

	return
end

function var_0_1.InitFormulaUseCounts(arg_21_0, arg_21_1)
	_ = var_1_10002

	var_1_10002.each(arg_21_1, function(arg_22_0)
		local var_22_0 = arg_22_0.key
		local var_22_1 = arg_22_0.value
		local var_22_2 = arg_21_0.formulas[var_22_0]

		var_3.SetUsedCount(var_22_2, var_22_1)

		return
	end)

	return
end

function var_0_1.AddFormulaUseCount(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = arg_23_0.formulas[arg_23_1]
	local var_23_1 = var_3.SetUsedCount
	local var_23_2 = arg_23_0.formulas[arg_23_1]

	var_23_1(var_23_0, var_6.GetUsedCount(var_23_2) + arg_23_2)

	return
end

function var_0_1.IsCompleteAllTools(arg_24_0, arg_24_1)
	arg_24_1 = arg_24_1 or 1

	if arg_24_0.completeAllTools[arg_24_1] then
		return true
	end

	local var_24_0 = arg_24_0.completeAllTools

	_ = var_1_10003

	local var_24_1 = var_1_10003.all

	_ = var_1_10005
	var_24_0[arg_24_1] = var_24_1(var_1_10005.values(arg_24_0.formulas), function(arg_25_0)
		if arg_25_0:getConfig("version") == arg_24_1 then
			local var_25_0 = arg_25_0:GetType()

			AtelierFormula = var_2

			if var_25_0 ~= var_2.TYPE.TOOL then
				return true
			end

			return not arg_25_0:IsAvaliable()
		end

		return true
	end)

	return arg_24_0.completeAllTools[arg_24_1]
end

return var_0_1
