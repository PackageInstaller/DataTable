local var_0_0 = class("IslandSkinCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0.tf = arg_1_1.transform
	arg_1_0.selectGos = {
		arg_1_0.tf:Find("select")
	}
	arg_1_0.notGetTF = arg_1_0.tf:Find("not_get")
	arg_1_0.changeColorTF = arg_1_0.tf:Find("changeColor")
	arg_1_0.buyTF = arg_1_0.notGetTF:Find("buy")

	return
end

function var_0_0.Update(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.configId = arg_2_1

	setText(arg_2_0.tf:Find("Text"), pg.island_skin_template[arg_2_0.configId].name)

	if pg.island_skin_template[arg_2_0.configId].icon ~= "" then
		GetImageSpriteFromAtlasAsync(string.format("island/IslandDressIcon/%s", pg.island_skin_template[arg_2_0.configId].icon), "", arg_2_0.tf:Find("icon"))
	end

	arg_2_0:UpdateSelected(arg_2_2)

	return
end

function var_0_0.UpdateSelected(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1 == arg_3_0.configId

	for iter_3_0, iter_3_1 in ipairs(arg_3_0.selectGos) do
		setActive(iter_3_1, var_3_0)
	end

	return
end

function var_0_0.Dispose(arg_4_0)
	return
end

return var_0_0
