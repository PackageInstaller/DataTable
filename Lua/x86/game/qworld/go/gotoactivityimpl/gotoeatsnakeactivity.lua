GotoActivityBase = import("game.qworld.go.gotoActivityImpl.GotoActivityBase")

local var_0_0 = class("GotoEatSnakeActivity", GotoActivityBase)

function var_0_0.OnEnter(arg_1_0, arg_1_1)
	JumpTools.OpenPageByJump("/eatSnakesMain")
end

return var_0_0
