local IslandBookFishPage = class("IslandBookFishPage", import(".IslandBookItemPage"))

function IslandBookFishPage:getUIName()
	return "IslandBookFishUI"
end

function IslandBookFishPage:GetIllustrationType()
	return IslandIllustration.TYPES.FISH
end

function IslandBookFishPage:GetHelpTip()
	return i18n("island_guide_help_fish")
end

function IslandBookFishPage:OnLoaded()
	IslandBookFishPage.super.OnLoaded(self)

	self.weightTF = self.rightTF:Find("weight")
	self.minWeightTF = self.weightTF:Find("min")

	setText(self.minWeightTF:Find("Text"), i18n("island_guide_fish_min_weight"))

	self.maxWeightTF = self.weightTF:Find("max")

	setText(self.maxWeightTF:Find("Text"), i18n("island_guide_fish_max_weight"))

	return
end

function IslandBookFishPage:FlushRightPanel()
	IslandBookFishPage.super.FlushRightPanel(self)

	if not self.showIllustration then
		return
	end

	local var_5_0 = self.showIllustration:GetStatus() == IslandIllustration.STATUS.UNLOCK

	setActive(self.weightTF, var_5_0)

	if not var_5_0 then
		return
	end

	local var_5_1 = getProxy(IslandProxy):GetIsland():GetFishingAgency():GetFish((self.showIllustration:GetLinkConfigID()))

	setText(self.minWeightTF:Find("value"), var_5_1:GetMinWeight() / 1000 .. "KG")
	setText(self.maxWeightTF:Find("value"), var_5_1:GetMaxWeight() / 1000 .. "KG")
	setActive(self.minWeightTF:Find("Image"), var_5_1:ReachMinCup())
	setActive(self.maxWeightTF:Find("Image"), var_5_1:ReachMaxCup())

	return
end

return IslandBookFishPage
