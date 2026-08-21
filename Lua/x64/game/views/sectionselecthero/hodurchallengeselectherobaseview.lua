local var_0_0 = import("game.views.sectionSelectHero.NewSectionSelectHeroBaseView")
local var_0_1 = class("HodurChallengeSelectHeroBaseView", var_0_0)

function var_0_1.OnEnter(arg_1_0)
	arg_1_0:AddEventListener()
	arg_1_0:ProcessParams()
	arg_1_0:ProcessSubView()
	arg_1_0:SubViewOnEnter()
	arg_1_0:Refresh()
	HodurSystemData:ClearFinalHero()
end

return var_0_1
