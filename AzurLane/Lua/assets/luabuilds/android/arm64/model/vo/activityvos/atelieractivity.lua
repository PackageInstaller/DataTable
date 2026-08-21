local var_0_0 = class("AtelierActivity", import(".VirtualBagActivity"))

function var_0_0.Ctor(arg_1_0, ...)
	var_0_0.super.Ctor(arg_1_0, ...)

	arg_1_0.items = {}
	arg_1_0.completeAllTools = {}
	arg_1_0.slots = _.map({
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

function var_0_0.GetItems(arg_3_0)
	return arg_3_0.items
end

function var_0_0.InitItems(arg_4_0, arg_4_1)
	_.each(arg_4_1, function(arg_5_0)
		arg_4_0.items[arg_5_0.key] = arg_4_0.items[arg_5_0.key] or AtelierMaterial.New({
			configId = arg_5_0.key
		})
		arg_4_0.items[arg_5_0.key].count = arg_4_0.items[arg_5_0.key].count + arg_5_0.value

		return
	end)

	return
end

function var_0_0.GetSlots(arg_6_0)
	return arg_6_0.slots
end

function var_0_0.UpdateBuffSlots(arg_7_0, arg_7_1)
	_.each(arg_7_1, function(arg_8_0)
		arg_7_0.slots[arg_8_0.pos] = {
			arg_8_0.itemid,
			arg_8_0.itemnum
		}

		return
	end)

	return
end

function var_0_0.AddItem(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1:GetConfigID()

	arg_9_0.items[var_9_0] = arg_9_0.items[var_9_0] or AtelierMaterial.New({
		configId = var_9_0
	})
	arg_9_0.items[var_9_0].count = arg_9_0.items[var_9_0].count + arg_9_1.count

	return
end

function var_0_0.GetItemById(arg_10_0, arg_10_1)
	return arg_10_0.items[arg_10_1]
end

function var_0_0.subItemCount(arg_11_0, arg_11_1, arg_11_2)
	if not arg_11_0.items[arg_11_1] then
		return
	end

	arg_11_0.items[arg_11_1].count = math.max(0, arg_11_0.items[arg_11_1].count - arg_11_2)

	return
end

function var_0_0.GetAllVitems(arg_12_0)
	return table.map(arg_12_0:GetItems(), function(arg_13_0)
		return arg_13_0.count
	end)
end

function var_0_0.getVitemNumber(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0:GetItemById(arg_14_1)

	if var_14_0 then
		return var_14_0.count or 0
	end
end

function var_0_0.addVitemNumber(arg_15_0, arg_15_1, arg_15_2)
	arg_15_0:AddItem(AtelierMaterial.New({
		configId = arg_15_1,
		count = arg_15_2
	}))

	return
end

function var_0_0.subVitemNumber(arg_16_0, arg_16_1, arg_16_2)
	arg_16_0:subItemCount(arg_16_1, arg_16_2)

	return
end

function var_0_0.GetFormulas(arg_17_0)
	return arg_17_0.formulas
end

function var_0_0.GetFormulasByVersion(arg_18_0, arg_18_1)
	for iter_18_0, iter_18_1 in pairs(arg_18_0.formulas) do
		if iter_18_1:getConfig("version") == arg_18_1 then
			table.insert({}, iter_18_1)
		end
	end

	return {}
end

function var_0_0.InitAllFormulas(arg_19_0)
	arg_19_0.formulas = {}

	_.each(pg.activity_ryza_recipe.all, function(arg_20_0)
		arg_19_0.formulas[arg_20_0] = AtelierFormula.New({
			configId = arg_20_0
		})

		return
	end)

	return
end

function var_0_0.InitFormulaUseCounts(arg_21_0, arg_21_1)
	_.each(arg_21_1, function(arg_22_0)
		arg_21_0.formulas[arg_22_0.key]:SetUsedCount(arg_22_0.value)

		return
	end)

	return
end

function var_0_0.AddFormulaUseCount(arg_23_0, arg_23_1, arg_23_2)
	arg_23_0.formulas[arg_23_1]:SetUsedCount(arg_23_0.formulas[arg_23_1]:GetUsedCount() + arg_23_2)

	return
end

function var_0_0.IsCompleteAllTools(arg_24_0, arg_24_1)
	arg_24_1 = arg_24_1 or 1

	if arg_24_0.completeAllTools[arg_24_1] then
		return true
	end

	arg_24_0.completeAllTools[arg_24_1] = _.all(_.values(arg_24_0.formulas), function(arg_25_0)
		if arg_25_0:getConfig("version") == arg_24_1 then
			if arg_25_0:GetType() ~= AtelierFormula.TYPE.TOOL then
				return true
			end

			return not arg_25_0:IsAvaliable()
		end

		return true
	end)

	return arg_24_0.completeAllTools[arg_24_1]
end

return var_0_0
