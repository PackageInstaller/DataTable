local AtelierActivity = class("AtelierActivity", import(".VirtualBagActivity"))

function AtelierActivity:Ctor(...)
	AtelierActivity.super.Ctor(self, ...)

	self.items = {}
	self.completeAllTools = {}
	self.slots = _.map({
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

	self:InitAllFormulas()

	return
end

function AtelierActivity:GetItems()
	return self.items
end

function AtelierActivity:InitItems(arg_4_1)
	_.each(arg_4_1, function(arg_5_0)
		self.items[arg_5_0.key] = self.items[arg_5_0.key] or AtelierMaterial.New({
			configId = arg_5_0.key
		})
		self.items[arg_5_0.key].count = self.items[arg_5_0.key].count + arg_5_0.value

		return
	end)

	return
end

function AtelierActivity:GetSlots()
	return self.slots
end

function AtelierActivity:UpdateBuffSlots(arg_7_1)
	_.each(arg_7_1, function(arg_8_0)
		self.slots[arg_8_0.pos] = {
			arg_8_0.itemid,
			arg_8_0.itemnum
		}

		return
	end)

	return
end

function AtelierActivity:AddItem(arg_9_1)
	local var_9_0 = arg_9_1:GetConfigID()

	self.items[var_9_0] = self.items[var_9_0] or AtelierMaterial.New({
		configId = var_9_0
	})
	self.items[var_9_0].count = self.items[var_9_0].count + arg_9_1.count

	return
end

function AtelierActivity:GetItemById(arg_10_1)
	return self.items[arg_10_1]
end

function AtelierActivity:subItemCount(arg_11_1, arg_11_2)
	if not self.items[arg_11_1] then
		return
	end

	self.items[arg_11_1].count = math.max(0, self.items[arg_11_1].count - arg_11_2)

	return
end

function AtelierActivity:GetAllVitems()
	return table.map(self:GetItems(), function(arg_13_0)
		return arg_13_0.count
	end)
end

function AtelierActivity:getVitemNumber(arg_14_1)
	local var_14_0 = self:GetItemById(arg_14_1)

	return (var_14_0 or nil) and (var_14_0.count or 0)
end

function AtelierActivity:addVitemNumber(arg_15_1, arg_15_2)
	self:AddItem(AtelierMaterial.New({
		configId = arg_15_1,
		count = arg_15_2
	}))

	return
end

function AtelierActivity:subVitemNumber(arg_16_1, arg_16_2)
	self:subItemCount(arg_16_1, arg_16_2)

	return
end

function AtelierActivity:GetFormulas()
	return self.formulas
end

function AtelierActivity:GetFormulasByVersion(arg_18_1)
	local var_18_0 = {}

	for iter_18_0, iter_18_1 in pairs(self.formulas) do
		if iter_18_1:getConfig("version") == arg_18_1 then
			table.insert(var_18_0, iter_18_1)
		end
	end

	return var_18_0
end

function AtelierActivity:InitAllFormulas()
	self.formulas = {}

	_.each(pg.activity_ryza_recipe.all, function(arg_20_0)
		self.formulas[arg_20_0] = AtelierFormula.New({
			configId = arg_20_0
		})

		return
	end)

	return
end

function AtelierActivity:InitFormulaUseCounts(arg_21_1)
	_.each(arg_21_1, function(arg_22_0)
		self.formulas[arg_22_0.key]:SetUsedCount(arg_22_0.value)

		return
	end)

	return
end

function AtelierActivity:AddFormulaUseCount(arg_23_1, arg_23_2)
	self.formulas[arg_23_1]:SetUsedCount(self.formulas[arg_23_1]:GetUsedCount() + arg_23_2)

	return
end

function AtelierActivity:IsCompleteAllTools(arg_24_1)
	arg_24_1 = arg_24_1 or 1

	if self.completeAllTools[arg_24_1] then
		return true
	end

	self.completeAllTools[arg_24_1] = _.all(_.values(self.formulas), function(arg_25_0)
		if arg_25_0:getConfig("version") == arg_24_1 then
			if arg_25_0:GetType() ~= AtelierFormula.TYPE.TOOL then
				return true
			end

			return not arg_25_0:IsAvaliable()
		end

		return true
	end)

	return self.completeAllTools[arg_24_1]
end

return AtelierActivity
