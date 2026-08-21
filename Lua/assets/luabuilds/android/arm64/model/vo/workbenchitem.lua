local var_0_0 = class("WorkBenchItem", import("model.vo.BaseVO"))

function var_0_0.bindConfigTable(arg_1_0)
	return pg.activity_workbench_item
end

function var_0_0.Ctor(arg_2_0, ...)
	var_0_0.super.Ctor(arg_2_0, ...)

	arg_2_0.count = arg_2_0.count or 0

	return
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

function var_0_0.GetSource(arg_7_0)
	return arg_7_0:getConfig("get_access")
end

function var_0_0.UpdateDrop(arg_8_0, arg_8_1, arg_8_2)
	arg_8_2 = arg_8_2 or {}

	local var_8_0 = ItemRarity.Rarity2Print(arg_8_1:GetRarity())

	setImageSprite(findTF(arg_8_0, "icon_bg"), GetSpriteFromAtlas("weaponframes", "bg" .. var_8_0))
	setFrame(findTF(arg_8_0, "icon_bg/frame"), var_8_0)
	GetImageSpriteFromAtlasAsync(arg_8_1:GetIconPath(), "", (findTF(arg_8_0, "icon_bg/icon")))
	setIconStars(arg_8_0, false)
	setIconName(arg_8_0, arg_8_1:GetName(), arg_8_2)
	setIconColorful(arg_8_0, arg_8_1:GetRarity(), arg_8_2)

	return
end

return var_0_0
