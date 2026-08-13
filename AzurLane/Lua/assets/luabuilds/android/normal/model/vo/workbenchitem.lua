class = var_0_10000

local var_0_0 = "WorkBenchItem"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("model.vo.BaseVO"))

function var_0_1.bindConfigTable(arg_1_0)
	pg = var_1_10001

	return var_1_10001.activity_workbench_item
end

function var_0_1.Ctor(arg_2_0, ...)
	var_0_1.super.Ctor(arg_2_0, ...)

	local var_2_0

	if not arg_2_0.count then
		var_2_0 = 0
	end

	arg_2_0.count = var_2_0

	return
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

function var_0_1.GetSource(arg_7_0)
	return arg_7_0:getConfig("get_access")
end

function var_0_1.UpdateDrop(arg_8_0, arg_8_1, arg_8_2)
	arg_8_2 = arg_8_2 or {}
	ItemRarity = var_1_10003

	local var_8_0 = var_1_10003.Rarity2Print
	local var_8_1 = arg_8_1
	local var_8_2 = var_8_0(arg_8_1.GetRarity(var_8_1))

	setImageSprite = var_4
	findTF = var_8_1

	local var_8_3 = var_8_1(arg_8_0, "icon_bg")

	GetSpriteFromAtlas = var_6

	var_4(var_8_3, var_6("weaponframes", "bg" .. var_8_2))

	setFrame = var_4
	findTF = var_8_3

	var_4(var_8_3(arg_8_0, "icon_bg/frame"), var_8_2)

	findTF = var_4

	local var_8_4 = var_4(arg_8_0, "icon_bg/icon")

	GetImageSpriteFromAtlasAsync = var_5

	var_5(arg_8_1:GetIconPath(), "", var_8_4)

	setIconStars = var_5

	var_5(arg_8_0, false)

	setIconName = var_5

	var_5(arg_8_0, arg_8_1:GetName(), arg_8_2)

	setIconColorful = var_5

	var_5(arg_8_0, arg_8_1:GetRarity(), arg_8_2)

	return
end

return var_0_1
