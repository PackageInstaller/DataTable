local GotoQuizActivity = class("GotoQuizActivity", (import("game.qworld.go.gotoActivityImpl.GotoActivityBase")))

function GotoQuizActivity:OnEnter(arg_1_1)
	local var_1_0 = {}

	var_1_0.activityID = arg_1_1[1] or ActivityConst.ACTIVITY_SPRING_QUIZ

	JumpTools.OpenPageByJump("/activityQuizEnter", var_1_0)
end

return GotoQuizActivity
