ActivityChessView = import("game.views.activity.Submodule.Chess.ActivityChessView")

local SummerChessView = class("SummerChessView", ActivityChessView)

function SummerChessView:UIName()
	return "UI/BranchlineUI/SummerUI/SummerWarChessUI"
end

function SummerChessView:AddUIListener()
	return
end

function SummerChessView:GetChessItemView()
	return SummerChessItemView
end

return SummerChessView
