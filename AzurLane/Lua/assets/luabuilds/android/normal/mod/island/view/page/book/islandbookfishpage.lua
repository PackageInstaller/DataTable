class = var_0_10000

local var_0_0 = "IslandBookFishPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".IslandBookItemPage"))

function var_0_1.getUIName(arg_1_0)
	return "IslandBookFishUI"
end

function var_0_1.GetIllustrationType(arg_2_0)
	IslandIllustration = var_1_10001

	return var_1_10001.TYPES.FISH
end

function var_0_1.GetHelpTip(arg_3_0)
	i18n = var_1_10001

	return var_1_10001("island_guide_help_fish")
end

function var_0_1.OnLoaded(arg_4_0)
	var_0_1.super.OnLoaded(arg_4_0)

	local var_4_0 = arg_4_0.rightTF

	arg_4_0.weightTF = var_1.Find(var_4_0, "weight")

	local var_4_1 = arg_4_0.weightTF

	arg_4_0.minWeightTF = var_1.Find(var_4_1, "min")
	setText = var_1

	local var_4_2 = arg_4_0.minWeightTF
	local var_4_3 = var_2.Find(var_4_2, "Text")

	i18n = var_4_2

	var_1(var_4_3, var_4_2("island_guide_fish_min_weight"))

	local var_4_4 = arg_4_0.weightTF

	arg_4_0.maxWeightTF = var_1.Find(var_4_4, "max")
	setText = var_1

	local var_4_5 = arg_4_0.maxWeightTF
	local var_4_6 = var_2.Find(var_4_5, "Text")

	i18n = var_4_5

	var_1(var_4_6, var_4_5("island_guide_fish_max_weight"))

	return
end

function var_0_1.FlushRightPanel(arg_5_0)
	var_0_1.super.FlushRightPanel(arg_5_0)

	if not arg_5_0.showIllustration then
		return
	end

	local var_5_0 = arg_5_0.showIllustration
	local var_5_1 = var_1.GetStatus(var_5_0)

	IslandIllustration = var_5_0

	local var_5_2 = var_5_1 == var_5_0.STATUS.UNLOCK

	setActive = var_2

	var_2(arg_5_0.weightTF, var_5_2)

	if not var_5_2 then
		return
	end

	local var_5_3 = arg_5_0.showIllustration
	local var_5_4 = var_2.GetLinkConfigID(var_5_3)

	getProxy = var_5_3
	IslandProxy = var_4

	local var_5_5 = var_5_3(var_4)
	local var_5_6 = var_3.GetIsland(var_5_5)
	local var_5_7 = var_3.GetFishingAgency(var_5_6)
	local var_5_8 = var_3.GetFish(var_5_7, var_5_4)

	setText = var_5_7

	local var_5_9 = arg_5_0.minWeightTF

	var_5_7(var_5.Find(var_5_9, "value"), var_5_8:GetMinWeight() / 1000 .. "KG")

	setText = var_5_7

	local var_5_10 = arg_5_0.maxWeightTF

	var_5_7(var_5.Find(var_5_10, "value"), var_5_8:GetMaxWeight() / 1000 .. "KG")

	setActive = var_5_7

	local var_5_11 = arg_5_0.minWeightTF

	var_5_7(var_5.Find(var_5_11, "Image"), var_5_8:ReachMinCup())

	setActive = var_5_7

	local var_5_12 = arg_5_0.maxWeightTF

	var_5_7(var_5.Find(var_5_12, "Image"), var_5_8:ReachMaxCup())

	return
end

return var_0_1
