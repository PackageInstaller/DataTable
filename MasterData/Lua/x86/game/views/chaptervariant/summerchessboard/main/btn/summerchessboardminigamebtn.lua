SummerChessBoardBaseBtn = import(".SummerChessBoardBaseBtn")

local SummerChessBoardMiniGameBtn = class("SummerChessBoardMiniGameBtn", SummerChessBoardBaseBtn)

function SummerChessBoardMiniGameBtn:OnEnter()
	SummerChessBoardMiniGameBtn.super.OnEnter(self)
end

function SummerChessBoardMiniGameBtn:OnExit()
	SummerChessBoardMiniGameBtn.super.OnExit(self)
end

function SummerChessBoardMiniGameBtn:Dispose()
	SummerChessBoardMiniGameBtn.super.Dispose(self)
end

function SummerChessBoardMiniGameBtn:AddListeners()
	SummerChessBoardMiniGameBtn.super.AddListeners(self)
end

return SummerChessBoardMiniGameBtn
