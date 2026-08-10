local var_0_0 = import("game.views.setting.AffixDescriptionView")
local var_0_1 = class("RaceTrialAffixDescriptionView", var_0_0)

function var_0_1.ItemRenderer(arg_1_0, arg_1_1, arg_1_2)
	arg_1_2:GetComponent("UIList")

	local var_1_0 = arg_1_2.transform:Find("text"):GetComponent("Text")
	local var_1_1 = arg_1_2.transform:Find("name"):GetComponent("Text")
	local var_1_2 = arg_1_2.transform:Find("icon"):GetComponent("Image")
	local var_1_3 = arg_1_0.data[arg_1_1 + 1]

	var_1_2.sprite = getAffixSprite(var_1_3)
	var_1_1.text = getAffixName(var_1_3) .. NumberTools.IntToRomam(var_1_3[2])
	var_1_0.text = getAffixDesc(var_1_3)
end

return var_0_1
