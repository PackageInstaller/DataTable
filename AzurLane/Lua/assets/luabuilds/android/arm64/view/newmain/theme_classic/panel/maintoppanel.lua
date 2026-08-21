local var_0_0 = class("MainTopPanel", import("...base.MainBasePanel"))

function var_0_0.GetBtns(arg_1_0)
	return {
		MainPlayerInfoBtn.New(arg_1_0._tf, arg_1_0.event)
	}
end

function var_0_0.GetDirection(arg_2_0)
	return Vector2(0, 1)
end

return var_0_0
