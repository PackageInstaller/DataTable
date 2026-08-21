local var_0_0 = class("AtelierFormula", import("model.vo.BaseVO"))

var_0_0.TYPE = {
	TOOL = 3,
	OTHER = 4,
	EQUIP = 1,
	ITEM = 2
}

function var_0_0.bindConfigTable(arg_1_0)
	return pg.activity_ryza_recipe
end

function var_0_0.Ctor(arg_2_0, ...)
	var_0_0.super.Ctor(arg_2_0, ...)

	arg_2_0.times = arg_2_0.times or 0

	return
end

function var_0_0.GetConfigID(arg_3_0)
	return arg_3_0.configId
end

function var_0_0.GetName(arg_4_0)
	return arg_4_0:getConfig("name")
end

function var_0_0.GetIconPath(arg_5_0)
	return arg_5_0:getConfig("icon")
end

function var_0_0.GetType(arg_6_0)
	return arg_6_0:getConfig("type")
end

function var_0_0.GetDesc(arg_7_0)
	return arg_7_0:getConfig("display")
end

function var_0_0.GetMaxLimit(arg_8_0)
	return arg_8_0:getConfig("item_num")
end

function var_0_0.SetUsedCount(arg_9_0, arg_9_1)
	arg_9_0.times = arg_9_1

	return
end

function var_0_0.GetUsedCount(arg_10_0)
	return arg_10_0.times
end

function var_0_0.IsAvaliable(arg_11_0)
	return arg_11_0:GetMaxLimit() < 0 or arg_11_0:GetUsedCount() < arg_11_0:GetMaxLimit()
end

function var_0_0.GetProduction(arg_12_0)
	return arg_12_0:getConfig("item_id")
end

function var_0_0.GetCircleList(arg_13_0)
	return arg_13_0:getConfig("recipe_circle")
end

function var_0_0.GetShapeID(arg_14_0)
	return arg_14_0:getConfig("shape")
end

function var_0_0.IsFormualCanComposite(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = {}
	local var_15_1 = arg_15_1:GetItems()

	local function var_15_2(arg_16_0)
		local var_16_0 = var_15_0[arg_16_0:GetConfigID()] or Clone(var_15_1[arg_16_0:GetConfigID()])

		assert(var_16_0, "Using Unexist material")

		var_16_0.count = var_16_0.count - 1
		var_15_0[arg_16_0:GetConfigID()] = var_16_0

		return
	end

	local var_15_3 = _.map(arg_15_0:GetCircleList(), function(arg_17_0)
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

			if var_19_0 and var_19_0.count > 0 and arg_19_0:CanUseMaterial(var_19_0, arg_15_0, arg_15_2) then
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

return var_0_0
