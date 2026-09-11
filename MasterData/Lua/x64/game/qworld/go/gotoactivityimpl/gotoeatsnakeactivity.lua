GotoActivityBase = import("game.qworld.go.gotoActivityImpl.GotoActivityBase")

local GotoEatSnakeActivity = class("GotoEatSnakeActivity", GotoActivityBase)

function GotoEatSnakeActivity:OnEnter(arg_1_1)
	JumpTools.OpenPageByJump("/eatSnakesMain")
end

return GotoEatSnakeActivity
