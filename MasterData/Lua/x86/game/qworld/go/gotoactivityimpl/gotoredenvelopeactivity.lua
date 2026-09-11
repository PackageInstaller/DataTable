GotoActivityBase = import("game.qworld.go.gotoActivityImpl.GotoActivityBase")

local GotoRedEnvelopActivity = class("GotoRedEnvelopActivity", GotoActivityBase)

function GotoRedEnvelopActivity:OnEnter(arg_1_1)
	JumpTools.OpenPageByJump("/redEnvelopeMainView", {
		isFirst = true
	})
end

return GotoRedEnvelopActivity
