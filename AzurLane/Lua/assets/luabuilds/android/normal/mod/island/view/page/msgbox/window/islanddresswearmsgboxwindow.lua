class = var_0_10000

local var_0_0 = "IslandDressWearMsgboxWindow"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".IslandCommonMsgboxWindow"))

function var_0_1.getUIName(arg_1_0)
	return "IslandCommonMsgBoxForDressWear"
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
	local var_2_1 = var_1.Find(var_2_0, "dress_container/dress")

	arg_2_0.dressRect = var_1.GetComponent(var_2_1, "LScrollRect")

	function arg_2_0.dressRect.onUpdateItem(arg_3_0, arg_3_1)
		local var_3_0 = arg_2_0

		var_2.OnDressUpdateItem(var_3_0, arg_3_0, arg_3_1)

		return
	end

	return
end

function var_0_1.OnShow(arg_4_0)
	var_0_1.super.OnShow(arg_4_0)

	local var_4_0 = arg_4_0.settings
	local var_4_1 = arg_4_0.dressRect

	var_2.SetTotalCount(var_4_1, #arg_4_0.settings.needconfirmDressList, 0)

	return
end

function var_0_1.OnDressUpdateItem(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_2.transform
	local var_5_1 = arg_5_0.settings.needconfirmDressList[arg_5_1 + 1]

	pg = var_5

	if var_5.island_dress_template[var_5_1.dress_id].icon ~= "" then
		GetImageSpriteFromAtlasAsync = var_6
		string = var_1_10007

		var_6(var_1_10007.format("island/IslandDressIcon/%s", var_5.icon), "", var_5_0:Find("icon"))
	end

	if var_5.quality ~= 0 then
		GetImageSpriteFromAtlasAsync = var_6
		string = var_1_10007

		var_6(var_1_10007.format("island/IslandDressIcon/%s", var_0_2[var_5.quality]), "", var_5_0:Find("frame"))
	end

	IslandShip = var_6

	local var_5_2 = var_6.StaticGetPrefab(var_5_1.ship_id)

	GetImageSpriteFromAtlasAsync = var_7

	var_7("island/IslandShipIcon/" .. var_5_2, "", var_5_0:Find("shipHold/ship_icon"))

	return
end

function var_0_1.OnDestroy(arg_6_0)
	var_0_1.super.OnDestroy(arg_6_0)

	ClearLScrollrect = var_1

	var_1(arg_6_0.dressRect)

	return
end

return var_0_1
