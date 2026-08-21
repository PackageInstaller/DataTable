local var_0_0 = class("AtelierMaterial", import("model.vo.BaseVO"))

var_0_0.TYPE = {
	MOD = 3,
	SAIREN = 4,
	STRENGTHEN = 5,
	NEUTRALIZER = 2,
	TOOL = 6,
	NORMAL = 1
}
var_0_0.ELEMENT_TYPE = {
	PYRO = 1,
	SAIREN = 5,
	ELECTRO = 3,
	ANEMO = 4,
	CRYO = 2
}

function var_0_0.Ctor(arg_1_0, ...)
	var_0_0.super.Ctor(arg_1_0, ...)

	arg_1_0.count = arg_1_0.count or 0

	return
end

function var_0_0.bindConfigTable(arg_2_0)
	return pg.activity_ryza_item
end

function var_0_0.GetName(arg_3_0)
	return arg_3_0:getConfig("name")
end

function var_0_0.GetRarity(arg_4_0)
	return arg_4_0:getConfig("rarity")
end

function var_0_0.GetIconPath(arg_5_0)
	return "props/" .. arg_5_0:getConfig("icon")
end

function var_0_0.GetDesc(arg_6_0)
	return arg_6_0:getConfig("display")
end

function var_0_0.GetType(arg_7_0)
	return arg_7_0:getConfig("type")
end

function var_0_0.GetProps(arg_8_0)
	return arg_8_0:getConfig("prop")
end

function var_0_0.GetLevel(arg_9_0)
	return arg_9_0:getConfig("prop_level")
end

function var_0_0.GetSource(arg_10_0)
	return arg_10_0:getConfig("get_access")
end

function var_0_0.GetBuffs(arg_11_0)
	local var_11_0 = arg_11_0:getConfig("benefit_buff")

	return type(var_11_0) == "table" and var_11_0 or nil
end

function var_0_0.GetVoices(arg_12_0)
	return arg_12_0:getConfig("got_voice")
end

function var_0_0.GetCategory(arg_13_0)
	return arg_13_0:getConfig("prop_type")
end

function var_0_0.GetVersion(arg_14_0)
	return arg_14_0:getConfig("version")
end

function var_0_0.IsShow(arg_15_0)
	return arg_15_0:getConfig("is_show")
end

local var_0_1 = {
	1,
	1,
	1,
	0,
	0
}

function var_0_0.GetBaseCircleTransform(arg_16_0)
	local var_16_0 = arg_16_0:getConfig("base_circle")

	return type(var_16_0) == "table" and var_16_0 or var_0_1
end

function var_0_0.GetNormalCircleTransform(arg_17_0)
	local var_17_0 = arg_17_0:getConfig("normal_circle")

	return type(var_17_0) == "table" and var_17_0 or var_0_1
end

function var_0_0.IsNormal(arg_18_0)
	local var_18_0 = arg_18_0:GetType()

	return var_18_0 == var_0_0.TYPE.NORMAL or var_18_0 == var_0_0.TYPE.MOD or var_18_0 == var_0_0.TYPE.SAIREN
end

function var_0_0.UpdateRyzaItem(arg_19_0, arg_19_1, arg_19_2)
	arg_19_2 = arg_19_2 or {}

	local var_19_0 = ItemRarity.Rarity2Print(arg_19_1:GetRarity())

	setImageSprite(findTF(arg_19_0, "icon_bg"), GetSpriteFromAtlas("weaponframes", "bg" .. var_19_0))
	setFrame(findTF(arg_19_0, "icon_bg/frame"), var_19_0)
	GetImageSpriteFromAtlasAsync(arg_19_1:GetIconPath(), "", (findTF(arg_19_0, "icon_bg/icon")))
	setIconStars(arg_19_0, false)
	setIconName(arg_19_0, arg_19_1:GetName(), arg_19_2)
	setIconColorful(arg_19_0, arg_19_1:GetRarity(), arg_19_2)

	return
end

return var_0_0
