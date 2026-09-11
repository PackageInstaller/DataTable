SummerChessBoardBaseBtn = import(".SummerChessBoardBaseBtn")

local SummerChessBoardPermanentGameBtn = class("SummerChessBoardPermanentGameBtn", SummerChessBoardBaseBtn)

function SummerChessBoardPermanentGameBtn:OnEnter()
	SummerChessBoardPermanentGameBtn.super.OnEnter(self)
end

function SummerChessBoardPermanentGameBtn:OnExit()
	SummerChessBoardPermanentGameBtn.super.OnExit(self)
end

function SummerChessBoardPermanentGameBtn:Dispose()
	SummerChessBoardPermanentGameBtn.super.Dispose(self)
end

function SummerChessBoardPermanentGameBtn:AddListeners()
	SummerChessBoardPermanentGameBtn.super.AddListeners(self)
end

return SummerChessBoardPermanentGameBtn
