class = var_0_10000

local var_0_0 = "AtelierMaterial"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("model.vo.BaseVO"))

var_0_1.TYPE = {
	MOD = 3,
	SAIREN = 4,
	STRENGTHEN = 5,
	NEUTRALIZER = 2,
	TOOL = 6,
	NORMAL = 1
}
var_0_1.ELEMENT_TYPE = {
	PYRO = 1,
	SAIREN = 5,
	ELECTRO = 3,
	ANEMO = 4,
	CRYO = 2
}

function var_0_1.Ctor(arg_1_0, ...)
	var_0_1.super.Ctor(arg_1_0, ...)

	local var_1_0

	if not arg_1_0.count then
		var_1_0 = 0
	end

	arg_1_0.count = var_1_0

	return
end

function var_0_1.bindConfigTable(arg_2_0)
	pg = var_1_10001

	return var_1_10001.activity_ryza_item
end

function var_0_1.GetName(arg_3_0)
	return arg_3_0:getConfig("name")
end

function var_0_1.GetRarity(arg_4_0)
	return arg_4_0:getConfig("rarity")
end

function var_0_1.GetIconPath(arg_5_0)
	return "props/" .. arg_5_0:getConfig("icon")
end

function var_0_1.GetDesc(arg_6_0)
	return arg_6_0:getConfig("display")
end

function var_0_1.GetType(arg_7_0)
	return arg_7_0:getConfig("type")
end

function var_0_1.GetProps(arg_8_0)
	return arg_8_0:getConfig("prop")
end

function var_0_1.GetLevel(arg_9_0)
	return arg_9_0:getConfig("prop_level")
end

function var_0_1.GetSource(arg_10_0)
	return arg_10_0:getConfig("get_access")
end

function var_0_1.GetBuffs(arg_11_0)
	local var_11_0 = arg_11_0
	local var_11_1 = arg_11_0.getConfig(var_11_0, "benefit_buff")

	type = var_11_0

	return var_11_0(var_11_1) == "table" and var_11_1 or nil
end

function var_0_1.GetVoices(arg_12_0)
	return arg_12_0:getConfig("got_voice")
end

function var_0_1.GetCategory(arg_13_0)
	return arg_13_0:getConfig("prop_type")
end

function var_0_1.GetVersion(arg_14_0)
	return arg_14_0:getConfig("version")
end

function var_0_1.IsShow(arg_15_0)
	return arg_15_0:getConfig("is_show")
end

local var_0_2 = {
	1,
	1,
	1,
	0,
	0
}

function var_0_1.GetBaseCircleTransform(arg_16_0)
	local var_16_0 = arg_16_0
	local var_16_1 = arg_16_0.getConfig(var_16_0, "base_circle")

	type = var_16_0

	return var_16_0(var_16_1) == "table" and var_16_1 or var_0_2
end

function var_0_1.GetNormalCircleTransform(arg_17_0)
	local var_17_0 = arg_17_0
	local var_17_1 = arg_17_0.getConfig(var_17_0, "normal_circle")

	type = var_17_0

	return var_17_0(var_17_1) == "table" and var_17_1 or var_0_2
end

function var_0_1.IsNormal(arg_18_0)
	return arg_18_0:GetType() == var_0_1.TYPE.NORMAL or var_1 == var_0_1.TYPE.MOD or var_1 == var_0_1.TYPE.SAIREN
end

function var_0_1.UpdateRyzaItem(arg_19_0, arg_19_1, arg_19_2)
	arg_19_2 = arg_19_2 or {}
	ItemRarity = var_1_10003

	local var_19_0 = var_1_10003.Rarity2Print
	local var_19_1 = arg_19_1
	local var_19_2 = var_19_0(arg_19_1.GetRarity(var_19_1))

	setImageSprite = var_4
	findTF = var_19_1

	local var_19_3 = var_19_1(arg_19_0, "icon_bg")

	GetSpriteFromAtlas = var_6

	var_4(var_19_3, var_6("weaponframes", "bg" .. var_19_2))

	setFrame = var_4
	findTF = var_19_3

	var_4(var_19_3(arg_19_0, "icon_bg/frame"), var_19_2)

	findTF = var_4

	local var_19_4 = var_4(arg_19_0, "icon_bg/icon")

	GetImageSpriteFromAtlasAsync = var_5

	var_5(arg_19_1:GetIconPath(), "", var_19_4)

	setIconStars = var_5

	var_5(arg_19_0, false)

	setIconName = var_5

	var_5(arg_19_0, arg_19_1:GetName(), arg_19_2)

	setIconColorful = var_5

	var_5(arg_19_0, arg_19_1:GetRarity(), arg_19_2)

	return
end

return var_0_1
