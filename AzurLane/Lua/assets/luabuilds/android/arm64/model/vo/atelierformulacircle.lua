local var_0_0 = class("AtelierFormulaCircle", import("model.vo.BaseVO"))

var_0_0.TYPE = {
	NONE = 5,
	SAIREN = 3,
	ELEMENT_CATEGORY = 8,
	BASE = 1,
	CATEGORY = 7,
	ELEMENT = 6,
	NORMAL = 2,
	ANY = 4
}
var_0_0.ELEMENT_TYPE = {
	CRYO = 2,
	SAIREN = 5,
	ELECTRO = 3,
	ANEMO = 4,
	PYRO = 1,
	ANY = 0
}
var_0_0.ELEMENT_NAME = {}

for iter_0_0, iter_0_1 in pairs(var_0_0.ELEMENT_TYPE) do
	var_0_0.ELEMENT_NAME[iter_0_1] = iter_0_0
end

var_0_0.ELEMENT_RING_COLOR = {
	[var_0_0.ELEMENT_TYPE.ANY] = "FFFED5",
	[var_0_0.ELEMENT_TYPE.PYRO] = "F74F41",
	[var_0_0.ELEMENT_TYPE.CRYO] = "64CAFF",
	[var_0_0.ELEMENT_TYPE.ELECTRO] = "FFDD3F",
	[var_0_0.ELEMENT_TYPE.ANEMO] = "B0E860",
	[var_0_0.ELEMENT_TYPE.SAIREN] = "AF97FF"
}
var_0_0.ELEMENT_LIGHT_COLOR = {
	[var_0_0.ELEMENT_TYPE.ANY] = "7F96FF",
	[var_0_0.ELEMENT_TYPE.PYRO] = "FF7072",
	[var_0_0.ELEMENT_TYPE.CRYO] = "73E2FF",
	[var_0_0.ELEMENT_TYPE.ELECTRO] = "FFD782",
	[var_0_0.ELEMENT_TYPE.ANEMO] = "75FB8F",
	[var_0_0.ELEMENT_TYPE.SAIREN] = "EB84FF"
}

function var_0_0.bindConfigTable(arg_1_0)
	return pg.activity_ryza_recipe_circle
end

function var_0_0.GetConfigID(arg_2_0)
	return arg_2_0.configId
end

function var_0_0.GetIconPath(arg_3_0)
	return arg_3_0:getConfig("icon")
end

function var_0_0.GetType(arg_4_0)
	return arg_4_0:getConfig("type")
end

function var_0_0.GetProp(arg_5_0)
	return arg_5_0:getConfig("prop")
end

function var_0_0.GetCategory(arg_6_0)
	return arg_6_0:getConfig("prop_type")
end

function var_0_0.GetElement(arg_7_0)
	if arg_7_0:GetType() == var_0_0.TYPE.SAIREN then
		return var_0_0.ELEMENT_TYPE.SAIREN
	elseif arg_7_0:GetType() == var_0_0.TYPE.ANY then
		return var_0_0.ELEMENT_TYPE.ANY
	end

	return arg_7_0:GetProp()
end

function var_0_0.GetElementName(arg_8_0)
	return var_0_0.ELEMENT_NAME[arg_8_0:GetElement()]
end

function var_0_0.GetRingElement(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0:GetElement()

	if arg_9_0:GetType() == var_0_0.TYPE.ANY and arg_9_1 then
		var_9_0 = arg_9_1:GetType() == AtelierMaterial.TYPE.SAIREN and var_0_0.ELEMENT_TYPE.SAIREN or arg_9_1:GetProps()[1]
	end

	return var_9_0
end

function var_0_0.GetElementRingColor(arg_10_0, arg_10_1)
	return SummerFeastScene.TransformColor(var_0_0.ELEMENT_RING_COLOR[arg_10_0:GetRingElement(arg_10_1)])
end

function var_0_0.GetElementLightColor(arg_11_0, arg_11_1)
	return SummerFeastScene.TransformColor(var_0_0.ELEMENT_LIGHT_COLOR[arg_11_0:GetRingElement(arg_11_1)])
end

function var_0_0.GetLevel(arg_12_0)
	return arg_12_0:getConfig("prop_level")
end

function var_0_0.GetLimitItemID(arg_13_0)
	return arg_13_0:getConfig("ryza_item_id")
end

function var_0_0.GetNeighbors(arg_14_0)
	return arg_14_0:getConfig("circle_connect")
end

function var_0_0.GetFormulaId(arg_15_0)
	return arg_15_0:getConfig("recipe_id")
end

function var_0_0.GetStarList(arg_16_0)
	return arg_16_0:getConfig("star_list")
end

function var_0_0.CanUseMaterial(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	arg_17_3 = arg_17_3 or 1

	if arg_17_1:GetVersion() ~= arg_17_3 then
		return false
	end

	local var_17_0 = arg_17_0:GetType()
	local var_17_1 = arg_17_1:GetType()
	local var_17_2 = arg_17_1:GetCategory()
	local var_17_3 = arg_17_0:GetLimitItemID()

	if var_17_3 ~= 0 then
		return var_17_3 == arg_17_1:GetConfigID()
	elseif var_17_0 == var_0_0.TYPE.NORMAL then
		if var_17_1 ~= AtelierMaterial.TYPE.NORMAL and var_17_1 ~= AtelierMaterial.TYPE.NEUTRALIZER then
			return false
		end

		if not table.contains(arg_17_1:GetProps(), arg_17_0:GetElement()) then
			return false
		end

		if (function()
			if arg_17_2:GetProduction()[1] ~= DROP_TYPE_RYZA_DROP then
				return false
			end

			if arg_17_2:GetProduction()[2] == arg_17_1:GetConfigID() then
				return true
			end

			local var_18_0 = AtelierMaterial.New({
				configId = arg_17_2:GetProduction()[2]
			})

			return var_18_0:GetType() == AtelierMaterial.TYPE.NEUTRALIZER and var_17_1 == AtelierMaterial.TYPE.NEUTRALIZER and var_18_0:GetLevel() == arg_17_1:GetLevel()
		end)() then
			return false
		end

		return arg_17_1:GetLevel() == arg_17_0:GetLevel()
	elseif var_17_0 == var_0_0.TYPE.ANY then
		if var_17_1 ~= AtelierMaterial.TYPE.NORMAL and var_17_1 ~= AtelierMaterial.TYPE.NEUTRALIZER and var_17_1 ~= AtelierMaterial.TYPE.SAIREN then
			return false
		end

		if (function()
			if arg_17_2:GetProduction()[1] ~= DROP_TYPE_RYZA_DROP then
				return false
			end

			if arg_17_2:GetProduction()[2] == arg_17_1:GetConfigID() then
				return true
			end

			local var_18_0 = AtelierMaterial.New({
				configId = arg_17_2:GetProduction()[2]
			})

			return var_18_0:GetType() == AtelierMaterial.TYPE.NEUTRALIZER and var_17_1 == AtelierMaterial.TYPE.NEUTRALIZER and var_18_0:GetLevel() == arg_17_1:GetLevel()
		end)() then
			return false
		end

		return arg_17_1:GetLevel() == arg_17_0:GetLevel()
	elseif var_17_0 == var_0_0.TYPE.NONE then
		return var_17_2 ~= 0
	elseif var_17_0 == var_0_0.TYPE.ELEMENT then
		return table.contains(arg_17_1:GetProps(), arg_17_0:GetElement()) and var_17_2 ~= 0
	elseif var_17_0 == var_0_0.TYPE.CATEGORY then
		return var_17_2 == arg_17_0:GetCategory()
	elseif var_17_0 == var_0_0.TYPE.ELEMENT_CATEGORY then
		return table.contains(arg_17_1:GetProps(), arg_17_0:GetElement()) and var_17_2 == arg_17_0:GetCategory()
	end

	return
end

return var_0_0
