class = var_0_10000

local var_0_0 = "IslandSendDressUpMsgboxWindow"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".IslandCommonMsgboxWindow"))

function var_0_1.getUIName(arg_1_0)
	return "IslandCommonMsgBoxForSendDress"
end

local var_0_2 = {
	"white",
	"blue",
	"purple",
	"golden"
}

function var_0_1.OnLoaded(arg_2_0)
	var_0_1.super.OnLoaded(arg_2_0)

	local var_2_0 = arg_2_0._tf

	arg_2_0.itemFrameTF = var_1.Find(var_2_0, "item/icon_bg/frame")

	local var_2_1 = arg_2_0._tf

	arg_2_0.itemIconTF = var_1.Find(var_2_1, "item/icon_bg/icon")

	local var_2_2 = arg_2_0._tf

	arg_2_0.ownNum = var_1.Find(var_2_2, "own/ownCount")

	return
end

function var_0_1.OnShow(arg_3_0)
	var_0_1.super.OnShow(arg_3_0)

	local var_3_0 = arg_3_0.settings

	arg_3_0:FlushDressItem(var_3_0)

	return
end

function var_0_1.FlushDressItem(arg_4_0, arg_4_1)
	pg = var_1_10002

	if var_1_10002.island_dress_template[arg_4_1.configId].icon ~= "" then
		GetImageSpriteFromAtlasAsync = var_3
		string = var_1_10005

		var_3(var_1_10005.format("island/IslandDressIcon/%s", var_2.icon), "", arg_4_0.itemIconTF)
	end

	if var_2.quality ~= 0 then
		GetImageSpriteFromAtlasAsync = var_3
		string = var_1_10005

		var_3(var_1_10005.format("island/IslandDressIcon/%s", var_0_2[var_2.quality]), "", arg_4_0.itemFrameTF)
	end

	getProxy = var_3
	IslandProxy = var_1_10005

	local var_4_0 = var_3(var_1_10005)
	local var_4_1 = var_3.GetIsland(var_4_0)
	local var_4_2 = var_3.GetCharacterAgency(var_4_1)

	setText = var_4_0

	var_4_0(arg_4_0.ownNum, var_4_2:GetOwnDressCountByDressId(arg_4_1.configId))

	return
end

return var_0_1
