local var_0_0 = class("DrawCardGameManager.ExitState", (import("...StateBase")))

function var_0_0:Enter(arg_1_1, arg_1_2)
	var_0_0.super.Enter(self, arg_1_1)
	JumpTools.OpenPageByJump("/home", nil, nil, true)
	arg_1_1.ExitGame(PosterGirlConst.StateKay.init_no_blend, (arg_1_2 or nil) and (DrawCardGameManager.GameResult.Win or DrawCardGameManager.GameResult.Lose))
end

return var_0_0
