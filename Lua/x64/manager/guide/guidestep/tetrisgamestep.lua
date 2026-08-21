local var_0_0 = class("TetrisGameStep", DragStep)

function var_0_0.Init(arg_1_0)
	var_0_0.super.Init(arg_1_0)
end

function var_0_0.Play(arg_2_0)
	var_0_0.super.Play(arg_2_0)
	TetrisGameRunTimeManager:SetTetrisPos(arg_2_0._params[1], arg_2_0._params[2])
end

function var_0_0.CheckDragSuccess(arg_3_0)
	return TetrisGameRunTimeManager:GetIsEndNowRound()
end

return var_0_0
