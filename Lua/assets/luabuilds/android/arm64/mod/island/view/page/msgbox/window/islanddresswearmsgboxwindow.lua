local var_0_0 = class("IslandDressWearMsgboxWindow", import(".IslandCommonMsgboxWindow"))

function var_0_0.getUIName(arg_1_0)
	return "IslandCommonMsgBoxForDressWear"
end

local var_0_1 = {
	"white",
	"blue",
	"purple",
	"golden"
}

function var_0_0.OnLoaded(arg_2_0)
	var_0_0.super.OnLoaded(arg_2_0)

	arg_2_0.dressRect = arg_2_0._tf:Find("dress_container/dress"):GetComponent("LScrollRect")

	function arg_2_0.dressRect.onUpdateItem(arg_3_0, arg_3_1)
		arg_2_0:OnDressUpdateItem(arg_3_0, arg_3_1)

		return
	end

	return
end

function var_0_0.OnShow(arg_4_0)
	var_0_0.super.OnShow(arg_4_0)
	arg_4_0.dressRect:SetTotalCount(#arg_4_0.settings.needconfirmDressList, 0)

	return
end

function var_0_0.OnDressUpdateItem(arg_5_0, arg_5_1, arg_5_2)
	if pg.island_dress_template[arg_5_0.settings.needconfirmDressList[arg_5_1 + 1].dress_id].icon ~= "" then
		GetImageSpriteFromAtlasAsync(string.format("island/IslandDressIcon/%s", pg.island_dress_template[arg_5_0.settings.needconfirmDressList[arg_5_1 + 1].dress_id].icon), "", arg_5_2.transform:Find("icon"))
	end

	if pg.island_dress_template[arg_5_0.settings.needconfirmDressList[arg_5_1 + 1].dress_id].quality ~= 0 then
		GetImageSpriteFromAtlasAsync(string.format("island/IslandDressIcon/%s", var_0_1[pg.island_dress_template[arg_5_0.settings.needconfirmDressList[arg_5_1 + 1].dress_id].quality]), "", arg_5_2.transform:Find("frame"))
	end

	GetImageSpriteFromAtlasAsync("island/IslandShipIcon/" .. IslandShip.StaticGetPrefab(arg_5_0.settings.needconfirmDressList[arg_5_1 + 1].ship_id), "", arg_5_2.transform:Find("shipHold/ship_icon"))

	return
end

function var_0_0.OnDestroy(arg_6_0)
	var_0_0.super.OnDestroy(arg_6_0)
	ClearLScrollrect(arg_6_0.dressRect)

	return
end

return var_0_0
