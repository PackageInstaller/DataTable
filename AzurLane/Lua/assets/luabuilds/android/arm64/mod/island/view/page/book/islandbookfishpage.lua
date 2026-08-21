local var_0_0 = class("IslandBookFishPage", import(".IslandBookItemPage"))

function var_0_0.getUIName(arg_1_0)
	return "IslandBookFishUI"
end

function var_0_0.GetIllustrationType(arg_2_0)
	return IslandIllustration.TYPES.FISH
end

function var_0_0.GetHelpTip(arg_3_0)
	return i18n("island_guide_help_fish")
end

function var_0_0.OnLoaded(arg_4_0)
	var_0_0.super.OnLoaded(arg_4_0)

	arg_4_0.weightTF = arg_4_0.rightTF:Find("weight")
	arg_4_0.minWeightTF = arg_4_0.weightTF:Find("min")

	setText(arg_4_0.minWeightTF:Find("Text"), i18n("island_guide_fish_min_weight"))

	arg_4_0.maxWeightTF = arg_4_0.weightTF:Find("max")

	setText(arg_4_0.maxWeightTF:Find("Text"), i18n("island_guide_fish_max_weight"))

	return
end

function var_0_0.FlushRightPanel(arg_5_0)
	var_0_0.super.FlushRightPanel(arg_5_0)

	if not arg_5_0.showIllustration then
		return
	end

	local var_5_0 = arg_5_0.showIllustration:GetStatus() == IslandIllustration.STATUS.UNLOCK

	setActive(arg_5_0.weightTF, var_5_0)

	if not var_5_0 then
		return
	end

	local var_5_1 = getProxy(IslandProxy):GetIsland():GetFishingAgency():GetFish((arg_5_0.showIllustration:GetLinkConfigID()))

	setText(arg_5_0.minWeightTF:Find("value"), var_5_1:GetMinWeight() / 1000 .. "KG")
	setText(arg_5_0.maxWeightTF:Find("value"), var_5_1:GetMaxWeight() / 1000 .. "KG")
	setActive(arg_5_0.minWeightTF:Find("Image"), var_5_1:ReachMinCup())
	setActive(arg_5_0.maxWeightTF:Find("Image"), var_5_1:ReachMaxCup())

	return
end

return var_0_0
