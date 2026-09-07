local AtelierFormula = class("AtelierFormula", import("model.vo.BaseVO"))

AtelierFormula.TYPE = {
	TOOL = 3,
	OTHER = 4,
	EQUIP = 1,
	ITEM = 2
}

function AtelierFormula:bindConfigTable()
	return pg.activity_ryza_recipe
end

function AtelierFormula:Ctor(...)
	AtelierFormula.super.Ctor(self, ...)

	self.times = self.times or 0

	return
end

function AtelierFormula:GetConfigID()
	return self.configId
end

function AtelierFormula:GetName()
	return self:getConfig("name")
end

function AtelierFormula:GetIconPath()
	return self:getConfig("icon")
end

function AtelierFormula:GetType()
	return self:getConfig("type")
end

function AtelierFormula:GetDesc()
	return self:getConfig("display")
end

function AtelierFormula:GetMaxLimit()
	return self:getConfig("item_num")
end

function AtelierFormula:SetUsedCount(arg_9_1)
	self.times = arg_9_1

	return
end

function AtelierFormula:GetUsedCount()
	return self.times
end

function AtelierFormula:IsAvaliable()
	return self:GetMaxLimit() < 0 or self:GetUsedCount() < self:GetMaxLimit()
end

function AtelierFormula:GetProduction()
	return self:getConfig("item_id")
end

function AtelierFormula:GetCircleList()
	return self:getConfig("recipe_circle")
end

function AtelierFormula:GetShapeID()
	return self:getConfig("shape")
end

function AtelierFormula:IsFormualCanComposite(arg_15_1, arg_15_2)
	local var_15_0 = {}
	local var_15_1 = arg_15_1:GetItems()

	local function var_15_2(arg_16_0)
		local var_16_0 = var_15_0[arg_16_0:GetConfigID()] or Clone(var_15_1[arg_16_0:GetConfigID()])

		assert(var_16_0, "Using Unexist material")

		var_16_0.count = var_16_0.count - 1
		var_15_0[arg_16_0:GetConfigID()] = var_16_0

		return
	end

	local var_15_3 = _.map(self:GetCircleList(), function(arg_17_0)
		return AtelierFormulaCircle.New({
			configId = arg_17_0
		})
	end)

	if _.any(var_15_3, function(arg_18_0)
		local var_18_0 = arg_18_0:GetLimitItemID()

		if var_18_0 ~= 0 then
			local var_18_1 = var_15_0[var_18_0] or var_15_1[var_18_0]

			if var_18_1 and var_18_1.count > 0 then
				var_15_2(var_18_1)
			else
				return true
			end
		end

		return
	end) then
		return false
	end

	local var_15_4 = AtelierMaterial.bindConfigTable()

	local function var_15_5(arg_19_0)
		for iter_19_0, iter_19_1 in ipairs(var_15_4.all) do
			local var_19_0 = var_15_0[iter_19_1] or var_15_1[iter_19_1]

			if var_19_0 and var_19_0.count > 0 and arg_19_0:CanUseMaterial(var_19_0, self, arg_15_2) then
				var_15_2(var_19_0)

				return
			end
		end

		return true
	end

	for iter_15_0, iter_15_1 in ipairs({
		AtelierFormulaCircle.TYPE.NORMAL,
		AtelierFormulaCircle.TYPE.ANY,
		AtelierFormulaCircle.TYPE.ELEMENT_CATEGORY,
		AtelierFormulaCircle.TYPE.CATEGORY,
		AtelierFormulaCircle.TYPE.ELEMENT,
		AtelierFormulaCircle.TYPE.NONE
	}) do
		if _.any(var_15_3, function(arg_20_0)
			if arg_20_0:GetLimitItemID() == 0 then
				if arg_20_0:GetType() == iter_15_1 then
					return var_15_5(arg_20_0)
				end
			else
				return false
			end

			return
		end) then
			return false
		end
	end

	return true
end

return AtelierFormula
