local SoloChallengeAffixDescriptionView = class("SoloChallengeAffixDescriptionView", (import("game.views.setting.AffixDescriptionView")))

function SoloChallengeAffixDescriptionView:RenderItme(arg_1_1, arg_1_2)
	arg_1_1.icon.sprite = getAffixSprite(arg_1_2)
	arg_1_1.name.text = getAffixName(arg_1_2)
	arg_1_1.desc.text = getAffixDesc(arg_1_2)
	arg_1_1.icon.color = Color.white
end

return SoloChallengeAffixDescriptionView
