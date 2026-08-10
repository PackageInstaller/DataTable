local var_0_0 = import("game.views.sectionSelectHero.SelectHeroProxy.SelectHeroBaseProxy")
local var_0_1 = class("SoloChallengeSelectHeroProxy", var_0_0)

function var_0_1.InitCustomParams(arg_1_0)
	arg_1_0.needMimirPanel = false
	arg_1_0.canChangeTeam = false
end

return var_0_1
