GotoActivityBase = import("game.qworld.go.gotoActivityImpl.GotoActivityBase")

local GotoZumaActivity = class("GotoZumaActivity", GotoActivityBase)

function GotoZumaActivity:OnEnter(arg_1_1)
	JumpTools.OpenPageByJump("/springFestivalZumaMainView")
end

return GotoZumaActivity
