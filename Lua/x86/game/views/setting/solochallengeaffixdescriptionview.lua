local var_0_0 = import("game.views.setting.AffixDescriptionView")
local var_0_1 = class("SoloChallengeAffixDescriptionView", var_0_0)

function var_0_1.RenderItme(arg_1_0, arg_1_1, arg_1_2)
	arg_1_1.icon.sprite = getAffixSprite(arg_1_2)
	arg_1_1.name.text = getAffixName(arg_1_2)
	arg_1_1.desc.text = getAffixDesc(arg_1_2)
	arg_1_1.icon.color = Color.white
end

return var_0_1
