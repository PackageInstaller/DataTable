ActivityChessView = import("game.views.activity.Submodule.Chess.ActivityChessView")

local var_0_0 = class("SummerChessView", ActivityChessView)

function var_0_0.UIName(arg_1_0)
	return "UI/BranchlineUI/SummerUI/SummerWarChessUI"
end

function var_0_0.AddUIListener(arg_2_0)
	return
end

function var_0_0.GetChessItemView(arg_3_0)
	return SummerChessItemView
end

return var_0_0
