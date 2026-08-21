local var_0_0 = import("game.qworld.go.gotoActivityImpl.GotoActivityBase")
local var_0_1 = class("GotoQuizActivity", var_0_0)

function var_0_1.OnEnter(arg_1_0, arg_1_1)
	JumpTools.OpenPageByJump("/activityQuizEnter", {
		activityID = arg_1_1[1] or ActivityConst.ACTIVITY_SPRING_QUIZ
	})
end

return var_0_1
