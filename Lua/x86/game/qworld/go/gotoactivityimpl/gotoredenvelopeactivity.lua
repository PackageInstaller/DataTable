GotoActivityBase = import("game.qworld.go.gotoActivityImpl.GotoActivityBase")

local var_0_0 = class("GotoRedEnvelopActivity", GotoActivityBase)

function var_0_0.OnEnter(arg_1_0, arg_1_1)
	JumpTools.OpenPageByJump("/redEnvelopeMainView", {
		isFirst = true
	})
end

return var_0_0
