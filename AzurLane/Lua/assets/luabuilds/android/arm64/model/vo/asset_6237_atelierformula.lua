class = var_0_10000

local var_0_0 = "AtelierFormula"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("model.vo.BaseVO"))

var_0_1.TYPE = {
	TOOL = 3,
	OTHER = 4,
	EQUIP = 1,
	ITEM = 2
}

function var_0_1.bindConfigTable(arg_1_0)
	pg = var_1_10001

	return var_1_10001.activity_ryza_recipe
end

function var_0_1.Ctor(arg_2_0, ...)
	var_0_1.super.Ctor(arg_2_0, ...)

	local var_2_0

	if not arg_2_0.times then
		var_2_0 = 0
	end

	arg_2_0.times = var_2_0

	return
end

function var_0_1.GetConfigID(arg_3_0)
	return arg_3_0.configId
end

function var_0_1.GetName(arg_4_0)
	return arg_4_0:getConfig("name")
end

function var_0_1.GetIconPath(arg_5_0)
	return arg_5_0:getConfig("icon")
end

function var_0_1.GetType(arg_6_0)
	return arg_6_0:getConfig("type")
end

function var_0_1.GetDesc(arg_7_0)
	return arg_7_0:getConfig("display")
end

function var_0_1.GetMaxLimit(arg_8_0)
	return arg_8_0:getConfig("item_num")
end

function var_0_1.SetUsedCount(arg_9_0, arg_9_1)
	arg_9_0.times = arg_9_1

	return
end

function var_0_1.GetUsedCount(arg_10_0)
	return arg_10_0.times
end

function var_0_1.IsAvaliable(arg_11_0)
	return arg_11_0:GetMaxLimit() < 0 or arg_11_0:GetUsedCount() < arg_11_0:GetMaxLimit()
end

function var_0_1.GetProduction(arg_12_0)
	return arg_12_0:getConfig("item_id")
end

function var_0_1.GetCircleList(arg_13_0)
	return arg_13_0:getConfig("recipe_circle")
end

function var_0_1.GetShapeID(arg_14_0)
	return arg_14_0:getConfig("shape")
end

function var_0_1.IsFormualCanComposite(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = {}
	local var_15_1 = arg_15_1
	local var_15_2 = arg_15_1.GetItems(var_15_1)

	local function var_15_3(arg_16_0)
		local var_16_0

		if not var_15_0[arg_16_0:GetConfigID()] then
			Clone = var_16_0
			var_16_0 = var_16_0(var_15_2[arg_16_0:GetConfigID()])
		end

		assert = var_2

		var_2(var_16_0, "Using Unexist material")

		var_16_0.count = var_16_0.count - 1
		var_15_0[arg_16_0:GetConfigID()] = var_16_0

		return
	end

	_ = var_15_1

	local var_15_4 = var_15_1.map(arg_15_0:GetCircleList(), function(arg_17_0)
		AtelierFormulaCircle = var_2_10001

		return var_2_10001.New({
			configId = arg_17_0
		})
	end)

	_ = var_1_10007

	if var_1_10007.any(var_15_4, function(arg_18_0)
		if arg_18_0:GetLimitItemID() ~= 0 then
			local var_18_0

			if not var_15_0[var_1] then
				var_18_0 = var_15_2[var_1]
			end

			if var_18_0 and var_18_0.count > 0 then
				var_15_3(var_18_0)
			else
				return true
			end
		end

		return
	end) then
		return false
	end

	AtelierMaterial = var_7

	local var_15_5 = var_7.bindConfigTable()

	local function var_15_6(arg_19_0)
		ipairs = var_2_10001

		for iter_19_0, iter_19_1 in var_2_10001(var_15_5.all) do
			local var_19_0

			if not var_15_0[iter_19_1] then
				var_19_0 = var_15_2[iter_19_1]
			end

			if var_19_0 and var_19_0.count > 0 and arg_19_0:CanUseMaterial(var_19_0, arg_15_0, arg_15_2) then
				var_15_3(var_19_0)

				return
			end
		end

		return true
	end

	local var_15_7 = {}

	AtelierFormulaCircle = var_10
	var_15_7[1] = var_10.TYPE.NORMAL
	AtelierFormulaCircle = var_10
	var_15_7[2] = var_10.TYPE.ANY
	AtelierFormulaCircle = var_10
	var_15_7[3] = var_10.TYPE.ELEMENT_CATEGORY
	AtelierFormulaCircle = var_10
	var_15_7[4] = var_10.TYPE.CATEGORY
	AtelierFormulaCircle = var_10
	var_15_7[5] = var_10.TYPE.ELEMENT
	AtelierFormulaCircle = var_10
	var_15_7[6] = var_10.TYPE.NONE
	ipairs = var_10

	for iter_15_0, iter_15_1 in var_10(var_15_7) do
		_ = var_1_10015

		if var_1_10015.any(var_15_4, function(arg_20_0)
			if arg_20_0:GetLimitItemID() == 0 then
				if arg_20_0:GetType() == iter_15_1 then
					return var_15_6(arg_20_0)
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

return var_0_1
