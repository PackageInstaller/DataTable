local var_0_0 = class("IslandSendDressUpMsgboxWindow", import(".IslandCommonMsgboxWindow"))

function var_0_0.getUIName(arg_1_0)
	return "IslandCommonMsgBoxForSendDress"
end

local var_0_1 = {
	"white",
	"blue",
	"purple",
	"golden"
}

function var_0_0.OnLoaded(arg_2_0)
	var_0_0.super.OnLoaded(arg_2_0)

	arg_2_0.itemFrameTF = arg_2_0._tf:Find("item/icon_bg/frame")
	arg_2_0.itemIconTF = arg_2_0._tf:Find("item/icon_bg/icon")
	arg_2_0.ownNum = arg_2_0._tf:Find("own/ownCount")

	return
end

function var_0_0.OnShow(arg_3_0)
	var_0_0.super.OnShow(arg_3_0)
	arg_3_0:FlushDressItem(arg_3_0.settings)

	return
end

function var_0_0.FlushDressItem(arg_4_0, arg_4_1)
	if pg.island_dress_template[arg_4_1.configId].icon ~= "" then
		GetImageSpriteFromAtlasAsync(string.format("island/IslandDressIcon/%s", pg.island_dress_template[arg_4_1.configId].icon), "", arg_4_0.itemIconTF)
	end

	if pg.island_dress_template[arg_4_1.configId].quality ~= 0 then
		GetImageSpriteFromAtlasAsync(string.format("island/IslandDressIcon/%s", var_0_1[pg.island_dress_template[arg_4_1.configId].quality]), "", arg_4_0.itemFrameTF)
	end

	local var_4_0 = getProxy(IslandProxy):GetIsland():GetCharacterAgency()

	setText(arg_4_0.ownNum, var_4_0:GetOwnDressCountByDressId(arg_4_1.configId))

	return
end

return var_0_0
