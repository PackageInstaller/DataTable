local var_0_0 = import("game.views.cooperation.HeroTeamInfoCooperationView")
local var_0_1 = class("XH3rdWaterCooperationTeamInfoView", var_0_0)

function var_0_1.OnEnter(arg_1_0)
	var_0_1.super.OnEnter(arg_1_0)
	SetActive(arg_1_0.filterGo_, false)
end

return var_0_1
