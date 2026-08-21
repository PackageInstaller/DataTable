GotoActivityBase = import("game.qworld.go.gotoActivityImpl.GotoActivityBase")

local var_0_0 = class("GotoZumaActivity", GotoActivityBase)

function var_0_0.OnEnter(arg_1_0, arg_1_1)
	JumpTools.OpenPageByJump("/springFestivalZumaMainView")
end

return var_0_0
