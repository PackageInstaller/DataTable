local AtelierMaterial = class("AtelierMaterial", import("model.vo.BaseVO"))

AtelierMaterial.TYPE = {
	MOD = 3,
	SAIREN = 4,
	STRENGTHEN = 5,
	NEUTRALIZER = 2,
	TOOL = 6,
	NORMAL = 1
}
AtelierMaterial.ELEMENT_TYPE = {
	PYRO = 1,
	SAIREN = 5,
	ELECTRO = 3,
	ANEMO = 4,
	CRYO = 2
}

function AtelierMaterial:Ctor(...)
	AtelierMaterial.super.Ctor(self, ...)

	self.count = self.count or 0

	return
end

function AtelierMaterial:bindConfigTable()
	return pg.activity_ryza_item
end

function AtelierMaterial:GetName()
	return self:getConfig("name")
end

function AtelierMaterial:GetRarity()
	return self:getConfig("rarity")
end

function AtelierMaterial:GetIconPath()
	return "props/" .. self:getConfig("icon")
end

function AtelierMaterial:GetDesc()
	return self:getConfig("display")
end

function AtelierMaterial:GetType()
	return self:getConfig("type")
end

function AtelierMaterial:GetProps()
	return self:getConfig("prop")
end

function AtelierMaterial:GetLevel()
	return self:getConfig("prop_level")
end

function AtelierMaterial:GetSource()
	return self:getConfig("get_access")
end

function AtelierMaterial:GetBuffs()
	local var_11_0 = self:getConfig("benefit_buff")

	return type(var_11_0) == "table" and var_11_0 or nil
end

function AtelierMaterial:GetVoices()
	return self:getConfig("got_voice")
end

function AtelierMaterial:GetCategory()
	return self:getConfig("prop_type")
end

function AtelierMaterial:GetVersion()
	return self:getConfig("version")
end

function AtelierMaterial:IsShow()
	return self:getConfig("is_show")
end

local var_0_1 = {
	1,
	1,
	1,
	0,
	0
}

function AtelierMaterial:GetBaseCircleTransform()
	local var_16_0 = self:getConfig("base_circle")

	return type(var_16_0) == "table" and var_16_0 or var_0_1
end

function AtelierMaterial:GetNormalCircleTransform()
	local var_17_0 = self:getConfig("normal_circle")

	return type(var_17_0) == "table" and var_17_0 or var_0_1
end

function AtelierMaterial:IsNormal()
	local var_18_0 = self:GetType()

	return var_18_0 == AtelierMaterial.TYPE.NORMAL or var_18_0 == AtelierMaterial.TYPE.MOD or var_18_0 == AtelierMaterial.TYPE.SAIREN
end

function AtelierMaterial:UpdateRyzaItem(arg_19_1, arg_19_2)
	arg_19_2 = arg_19_2 or {}

	local var_19_0 = ItemRarity.Rarity2Print(arg_19_1:GetRarity())

	setImageSprite(findTF(self, "icon_bg"), GetSpriteFromAtlas("weaponframes", "bg" .. var_19_0))
	setFrame(findTF(self, "icon_bg/frame"), var_19_0)
	GetImageSpriteFromAtlasAsync(arg_19_1:GetIconPath(), "", (findTF(self, "icon_bg/icon")))
	setIconStars(self, false)
	setIconName(self, arg_19_1:GetName(), arg_19_2)
	setIconColorful(self, arg_19_1:GetRarity(), arg_19_2)

	return
end

return AtelierMaterial
