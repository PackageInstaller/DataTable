local RaceTrialAffixDescriptionView = class("RaceTrialAffixDescriptionView", (import("game.views.setting.AffixDescriptionView")))

function RaceTrialAffixDescriptionView:ItemRenderer(arg_1_1, arg_1_2)
	arg_1_2:GetComponent("UIList")

	arg_1_2.transform:Find("icon"):GetComponent("Image").sprite = getAffixSprite(self.data[arg_1_1 + 1])
	arg_1_2.transform:Find("name"):GetComponent("Text").text = getAffixName(self.data[arg_1_1 + 1]) .. NumberTools.IntToRomam(self.data[arg_1_1 + 1][2])
	arg_1_2.transform:Find("text"):GetComponent("Text").text = getAffixDesc(self.data[arg_1_1 + 1])
end

return RaceTrialAffixDescriptionView
