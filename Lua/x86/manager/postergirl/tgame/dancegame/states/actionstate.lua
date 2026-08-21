local var_0_0 = import("...StateBase")
local var_0_1 = class("DrawCardGameManager.ActionState", var_0_0)

local function var_0_2(arg_1_0, arg_1_1, arg_1_2)
	if arg_1_2 then
		return string.format("action1_2_dance_%s_%d_game", arg_1_0, arg_1_1)
	end

	return string.format("game_sofa_%s_%d", arg_1_0, arg_1_1)
end

function var_0_1.Enter(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_1:DoAction(arg_2_2, arg_2_3)
end

return var_0_1
