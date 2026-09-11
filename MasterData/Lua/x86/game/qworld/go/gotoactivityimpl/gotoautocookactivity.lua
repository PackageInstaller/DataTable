GotoActivityBase = import("game.qworld.go.gotoActivityImpl.GotoActivityBase")

local GotoAutoCookActivity = class("GotoAutoCookActivity", GotoActivityBase)

function GotoAutoCookActivity:OnEnter(arg_1_1)
	JumpTools.OpenPageByJump("/activityAutoCookMainView")
end

return GotoAutoCookActivity
