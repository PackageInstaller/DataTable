class = var_0_10000

local var_0_0 = "AtelierFormulaCircle"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("model.vo.BaseVO"))

var_0_1.TYPE = {
	NONE = 5,
	SAIREN = 3,
	ELEMENT_CATEGORY = 8,
	BASE = 1,
	CATEGORY = 7,
	ELEMENT = 6,
	NORMAL = 2,
	ANY = 4
}
var_0_1.ELEMENT_TYPE = {
	CRYO = 2,
	SAIREN = 5,
	ELECTRO = 3,
	ANEMO = 4,
	PYRO = 1,
	ANY = 0
}
var_0_1.ELEMENT_NAME = {}
pairs = var_1

for iter_0_0, iter_0_1 in var_1(var_0_1.ELEMENT_TYPE) do
	var_0_1.ELEMENT_NAME[iter_0_1] = iter_0_0
end

var_0_1.ELEMENT_RING_COLOR = {
	[var_0_1.ELEMENT_TYPE.ANY] = "FFFED5",
	[var_0_1.ELEMENT_TYPE.PYRO] = "F74F41",
	[var_0_1.ELEMENT_TYPE.CRYO] = "64CAFF",
	[var_0_1.ELEMENT_TYPE.ELECTRO] = "FFDD3F",
	[var_0_1.ELEMENT_TYPE.ANEMO] = "B0E860",
	[var_0_1.ELEMENT_TYPE.SAIREN] = "AF97FF"
}
var_0_1.ELEMENT_LIGHT_COLOR = {
	[var_0_1.ELEMENT_TYPE.ANY] = "7F96FF",
	[var_0_1.ELEMENT_TYPE.PYRO] = "FF7072",
	[var_0_1.ELEMENT_TYPE.CRYO] = "73E2FF",
	[var_0_1.ELEMENT_TYPE.ELECTRO] = "FFD782",
	[var_0_1.ELEMENT_TYPE.ANEMO] = "75FB8F",
	[var_0_1.ELEMENT_TYPE.SAIREN] = "EB84FF"
}

function var_0_1.bindConfigTable(arg_1_0)
	pg = var_1_10001

	return var_1_10001.activity_ryza_recipe_circle
end

function var_0_1.GetConfigID(arg_2_0)
	return arg_2_0.configId
end

function var_0_1.GetIconPath(arg_3_0)
	return arg_3_0:getConfig("icon")
end

function var_0_1.GetType(arg_4_0)
	return arg_4_0:getConfig("type")
end

function var_0_1.GetProp(arg_5_0)
	return arg_5_0:getConfig("prop")
end

function var_0_1.GetCategory(arg_6_0)
	return arg_6_0:getConfig("prop_type")
end

function var_0_1.GetElement(arg_7_0)
	if arg_7_0:GetType() == var_0_1.TYPE.SAIREN then
		return var_0_1.ELEMENT_TYPE.SAIREN
	elseif arg_7_0:GetType() == var_0_1.TYPE.ANY then
		return var_0_1.ELEMENT_TYPE.ANY
	end

	return arg_7_0:GetProp()
end

function var_0_1.GetElementName(arg_8_0)
	return var_0_1.ELEMENT_NAME[arg_8_0:GetElement()]
end

function var_0_1.GetRingElement(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0:GetElement()

	if arg_9_0:GetType() == var_0_1.TYPE.ANY and arg_9_1 then
		local var_9_1 = arg_9_1:GetType()

		AtelierMaterial = var_4

		if var_9_1 == var_4.TYPE.SAIREN then
			var_9_0 = var_0_1.ELEMENT_TYPE.SAIREN
		else
			var_9_0 = arg_9_1:GetProps()[1]
		end
	end

	return var_9_0
end

function var_0_1.GetElementRingColor(arg_10_0, arg_10_1)
	local var_10_0 = var_0_1.ELEMENT_RING_COLOR[arg_10_0:GetRingElement(arg_10_1)]

	SummerFeastScene = var_3

	return var_3.TransformColor(var_10_0)
end

function var_0_1.GetElementLightColor(arg_11_0, arg_11_1)
	local var_11_0 = var_0_1.ELEMENT_LIGHT_COLOR[arg_11_0:GetRingElement(arg_11_1)]

	SummerFeastScene = var_3

	return var_3.TransformColor(var_11_0)
end

function var_0_1.GetLevel(arg_12_0)
	return arg_12_0:getConfig("prop_level")
end

function var_0_1.GetLimitItemID(arg_13_0)
	return arg_13_0:getConfig("ryza_item_id")
end

function var_0_1.GetNeighbors(arg_14_0)
	return arg_14_0:getConfig("circle_connect")
end

function var_0_1.GetFormulaId(arg_15_0)
	return arg_15_0:getConfig("recipe_id")
end

function var_0_1.GetStarList(arg_16_0)
	return arg_16_0:getConfig("star_list")
end

function var_0_1.CanUseMaterial(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	arg_17_3 = arg_17_3 or 1

	if arg_17_1:GetVersion() ~= arg_17_3 then
		return false
	end

	local var_17_0 = arg_17_0:GetType()
	local var_17_1 = arg_17_1:GetType()
	local var_17_2 = arg_17_1:GetCategory()

	local function var_17_3()
		local var_18_0 = arg_17_2
		local var_18_1 = var_0.GetProduction(var_18_0)[1]

		DROP_TYPE_RYZA_DROP = var_2_10001

		if var_18_1 ~= var_2_10001 then
			return false
		end

		local var_18_2 = arg_17_2
		local var_18_3 = var_0.GetProduction(var_18_2)[2]
		local var_18_4 = arg_17_1

		if var_18_3 == var_1.GetConfigID(var_18_4) then
			return true
		end

		AtelierMaterial = var_18_3

		local var_18_5 = var_18_3.New
		local var_18_6 = {}
		local var_18_7 = arg_17_2

		var_18_6.configId = var_3.GetProduction(var_18_7)[2]

		local var_18_8 = var_18_5(var_18_6)
		local var_18_9 = var_0.GetType(var_18_8)

		AtelierMaterial = var_18_6

		if var_18_9 == var_18_6.TYPE.NEUTRALIZER then
			local var_18_10 = var_17_1

			AtelierMaterial = var_2

			if var_18_10 == var_2.TYPE.NEUTRALIZER then
				local var_18_11 = var_0:GetLevel()
				local var_18_12 = arg_17_1
				local var_18_13

				if var_18_11 ~= var_2.GetLevel(var_18_12) then
					var_18_13 = false
				else
					var_18_13 = true
				end

				return var_18_13
			end
		end
	end

	if arg_17_0:GetLimitItemID() ~= 0 then
		return var_8 == arg_17_1:GetConfigID()
	elseif var_17_0 == var_0_1.TYPE.NORMAL then
		AtelierMaterial = var_9

		if var_17_1 ~= var_9.TYPE.NORMAL then
			AtelierMaterial = var_9

			if var_17_1 ~= var_9.TYPE.NEUTRALIZER then
				return false
			end
		end

		table = var_9

		if not var_9.contains(arg_17_1:GetProps(), arg_17_0:GetElement()) then
			return false
		end

		if var_17_3() then
			return false
		end

		return arg_17_1:GetLevel() == arg_17_0:GetLevel()
	elseif var_17_0 == var_0_1.TYPE.ANY then
		AtelierMaterial = var_9

		if var_17_1 ~= var_9.TYPE.NORMAL then
			AtelierMaterial = var_9

			if var_17_1 ~= var_9.TYPE.NEUTRALIZER then
				AtelierMaterial = var_9

				if var_17_1 ~= var_9.TYPE.SAIREN then
					return false
				end
			end
		end

		if var_17_3() then
			return false
		end

		return arg_17_1:GetLevel() == arg_17_0:GetLevel()
	elseif var_17_0 == var_0_1.TYPE.NONE then
		return var_17_2 ~= 0
	elseif var_17_0 == var_0_1.TYPE.ELEMENT then
		table = var_9

		local var_17_4

		if var_9.contains(arg_17_1:GetProps(), arg_17_0:GetElement()) then
			var_17_4 = var_17_2 ~= 0
		end

		return var_17_4
	elseif var_17_0 == var_0_1.TYPE.CATEGORY then
		return var_17_2 == arg_17_0:GetCategory()
	elseif var_17_0 == var_0_1.TYPE.ELEMENT_CATEGORY then
		table = var_9

		local var_17_5

		if var_9.contains(arg_17_1:GetProps(), arg_17_0:GetElement()) then
			var_17_5 = var_17_2 == arg_17_0:GetCategory()
		end

		return var_17_5
	end

	return
end

return var_0_1
