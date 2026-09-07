local AtelierFormulaCircle = class("AtelierFormulaCircle", import("model.vo.BaseVO"))

AtelierFormulaCircle.TYPE = {
	NONE = 5,
	SAIREN = 3,
	ELEMENT_CATEGORY = 8,
	BASE = 1,
	CATEGORY = 7,
	ELEMENT = 6,
	NORMAL = 2,
	ANY = 4
}
AtelierFormulaCircle.ELEMENT_TYPE = {
	CRYO = 2,
	SAIREN = 5,
	ELECTRO = 3,
	ANEMO = 4,
	PYRO = 1,
	ANY = 0
}
AtelierFormulaCircle.ELEMENT_NAME = {}

for iter_0_0, iter_0_1 in pairs(AtelierFormulaCircle.ELEMENT_TYPE) do
	AtelierFormulaCircle.ELEMENT_NAME[iter_0_1] = iter_0_0
end

AtelierFormulaCircle.ELEMENT_RING_COLOR = {
	[AtelierFormulaCircle.ELEMENT_TYPE.ANY] = "FFFED5",
	[AtelierFormulaCircle.ELEMENT_TYPE.PYRO] = "F74F41",
	[AtelierFormulaCircle.ELEMENT_TYPE.CRYO] = "64CAFF",
	[AtelierFormulaCircle.ELEMENT_TYPE.ELECTRO] = "FFDD3F",
	[AtelierFormulaCircle.ELEMENT_TYPE.ANEMO] = "B0E860",
	[AtelierFormulaCircle.ELEMENT_TYPE.SAIREN] = "AF97FF"
}
AtelierFormulaCircle.ELEMENT_LIGHT_COLOR = {
	[AtelierFormulaCircle.ELEMENT_TYPE.ANY] = "7F96FF",
	[AtelierFormulaCircle.ELEMENT_TYPE.PYRO] = "FF7072",
	[AtelierFormulaCircle.ELEMENT_TYPE.CRYO] = "73E2FF",
	[AtelierFormulaCircle.ELEMENT_TYPE.ELECTRO] = "FFD782",
	[AtelierFormulaCircle.ELEMENT_TYPE.ANEMO] = "75FB8F",
	[AtelierFormulaCircle.ELEMENT_TYPE.SAIREN] = "EB84FF"
}

function AtelierFormulaCircle:bindConfigTable()
	return pg.activity_ryza_recipe_circle
end

function AtelierFormulaCircle:GetConfigID()
	return self.configId
end

function AtelierFormulaCircle:GetIconPath()
	return self:getConfig("icon")
end

function AtelierFormulaCircle:GetType()
	return self:getConfig("type")
end

function AtelierFormulaCircle:GetProp()
	return self:getConfig("prop")
end

function AtelierFormulaCircle:GetCategory()
	return self:getConfig("prop_type")
end

function AtelierFormulaCircle:GetElement()
	if self:GetType() == AtelierFormulaCircle.TYPE.SAIREN then
		return AtelierFormulaCircle.ELEMENT_TYPE.SAIREN
	elseif self:GetType() == AtelierFormulaCircle.TYPE.ANY then
		return AtelierFormulaCircle.ELEMENT_TYPE.ANY
	end

	return self:GetProp()
end

function AtelierFormulaCircle:GetElementName()
	return AtelierFormulaCircle.ELEMENT_NAME[self:GetElement()]
end

function AtelierFormulaCircle:GetRingElement(arg_9_1)
	local var_9_0 = self:GetElement()

	return (self:GetType() == AtelierFormulaCircle.TYPE.ANY and arg_9_1 or nil) and (arg_9_1:GetType() == AtelierMaterial.TYPE.SAIREN and AtelierFormulaCircle.ELEMENT_TYPE.SAIREN or arg_9_1:GetProps()[1])
end

function AtelierFormulaCircle:GetElementRingColor(arg_10_1)
	return SummerFeastScene.TransformColor(AtelierFormulaCircle.ELEMENT_RING_COLOR[self:GetRingElement(arg_10_1)])
end

function AtelierFormulaCircle:GetElementLightColor(arg_11_1)
	return SummerFeastScene.TransformColor(AtelierFormulaCircle.ELEMENT_LIGHT_COLOR[self:GetRingElement(arg_11_1)])
end

function AtelierFormulaCircle:GetLevel()
	return self:getConfig("prop_level")
end

function AtelierFormulaCircle:GetLimitItemID()
	return self:getConfig("ryza_item_id")
end

function AtelierFormulaCircle:GetNeighbors()
	return self:getConfig("circle_connect")
end

function AtelierFormulaCircle:GetFormulaId()
	return self:getConfig("recipe_id")
end

function AtelierFormulaCircle:GetStarList()
	return self:getConfig("star_list")
end

function AtelierFormulaCircle:CanUseMaterial(arg_17_1, arg_17_2, arg_17_3)
	arg_17_3 = arg_17_3 or 1

	if arg_17_1:GetVersion() ~= arg_17_3 then
		return false
	end

	local var_17_0 = self:GetType()
	local var_17_1 = arg_17_1:GetType()
	local var_17_2 = arg_17_1:GetCategory()

	local function var_17_3()
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
	end

	local var_17_4 = self:GetLimitItemID()

	if var_17_4 ~= 0 then
		return var_17_4 == arg_17_1:GetConfigID()
	elseif var_17_0 == AtelierFormulaCircle.TYPE.NORMAL then
		if var_17_1 ~= AtelierMaterial.TYPE.NORMAL and var_17_1 ~= AtelierMaterial.TYPE.NEUTRALIZER then
			return false
		end

		if not table.contains(arg_17_1:GetProps(), self:GetElement()) then
			return false
		end

		if var_17_3() then
			return false
		end

		return arg_17_1:GetLevel() == self:GetLevel()
	elseif var_17_0 == AtelierFormulaCircle.TYPE.ANY then
		if var_17_1 ~= AtelierMaterial.TYPE.NORMAL and var_17_1 ~= AtelierMaterial.TYPE.NEUTRALIZER and var_17_1 ~= AtelierMaterial.TYPE.SAIREN then
			return false
		end

		if var_17_3() then
			return false
		end

		return arg_17_1:GetLevel() == self:GetLevel()
	elseif var_17_0 == AtelierFormulaCircle.TYPE.NONE then
		return var_17_2 ~= 0
	elseif var_17_0 == AtelierFormulaCircle.TYPE.ELEMENT then
		return table.contains(arg_17_1:GetProps(), self:GetElement()) and var_17_2 ~= 0
	elseif var_17_0 == AtelierFormulaCircle.TYPE.CATEGORY then
		return var_17_2 == self:GetCategory()
	elseif var_17_0 == AtelierFormulaCircle.TYPE.ELEMENT_CATEGORY then
		return table.contains(arg_17_1:GetProps(), self:GetElement()) and var_17_2 == self:GetCategory()
	end

	return
end

return AtelierFormulaCircle
