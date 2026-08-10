local var_0_0 = import("...StateBase")
local var_0_1 = class("DrawCardGameManager.ExitState", var_0_0)

function var_0_1.Enter(arg_1_0, arg_1_1, arg_1_2)
	var_0_1.super.Enter(arg_1_0, arg_1_1)
	JumpTools.OpenPageByJump("/home", nil, nil, true)
	arg_1_1.ExitGame(PosterGirlConst.StateKay.init_no_blend, arg_1_2 and DrawCardGameManager.GameResult.Win or DrawCardGameManager.GameResult.Lose)
end

return var_0_1
