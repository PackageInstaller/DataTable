local var_0_0 = import("game.views.heroClue.HeroClueDetailView")
local var_0_1 = class("HeroClueDetailView_3_6", var_0_0)

function var_0_1.RefreshUI(arg_1_0)
	local var_1_0 = HeroClueCfg[arg_1_0.clueID_]

	arg_1_0.nameText_.text = var_1_0.name
	arg_1_0.descText_.text = var_1_0.desc
	arg_1_0.iconImg_.sprite = pureGetSpriteWithoutAtlas(var_1_0.icon_path_3)
end

return var_0_1
