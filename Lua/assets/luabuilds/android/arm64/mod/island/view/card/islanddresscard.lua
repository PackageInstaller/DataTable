local var_0_0 = class("IslandDressCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0.tf = arg_1_1.transform
	arg_1_0.selectGos = {
		arg_1_0.tf:Find("select")
	}
	arg_1_0.canSendTF = arg_1_0.tf:Find("canSend")
	arg_1_0.ownNumTF = arg_1_0.tf:Find("icon/count_bg")
	arg_1_0.ownNumText = arg_1_0.ownNumTF:Find("count")
	arg_1_0.redDot = arg_1_0.tf:Find("red_dot")
	arg_1_0.shipHoldTF = arg_1_0.tf:Find("shipHold")
	arg_1_0.shipIcon = arg_1_0.shipHoldTF:Find("ship_icon")
	arg_1_0.exclusionTF = arg_1_0.tf:Find("exclusion_item")

	return
end

local var_0_1 = {
	"white",
	"blue",
	"purple",
	"golden"
}

function var_0_0.Update(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.configId = arg_2_1
	arg_2_0.configType = pg.island_dress_template[arg_2_1].type

	setScrollText(arg_2_0.tf:Find("textMask/Text"), pg.island_dress_template[arg_2_1].name)

	if pg.island_dress_template[arg_2_1].icon ~= "" then
		GetImageSpriteFromAtlasAsync(string.format("island/IslandDressIcon/%s", pg.island_dress_template[arg_2_1].icon), "", arg_2_0.tf:Find("icon"))
	end

	if pg.island_dress_template[arg_2_1].quality ~= 0 then
		GetImageSpriteFromAtlasAsync(string.format("island/IslandDressIcon/%s", var_0_1[pg.island_dress_template[arg_2_1].quality]), "", arg_2_0.tf:Find("frame"))
	end

	arg_2_0:UpdateSelected(arg_2_2)

	return
end

function var_0_0.UpdateSelected(arg_3_0, arg_3_1)
	for iter_3_0, iter_3_1 in ipairs(arg_3_0.selectGos) do
		setActive(iter_3_1, arg_3_1)
	end

	return
end

function var_0_0.Dispose(arg_4_0)
	return
end

return var_0_0
