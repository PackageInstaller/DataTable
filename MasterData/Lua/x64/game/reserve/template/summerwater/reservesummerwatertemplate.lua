local ReserveSummerWaterTemplate = class("ReserveSummerWaterTemplate", (import("game.reserve.template.ReserveBaseTemplate")))

function ReserveSummerWaterTemplate:GetTrialHeroList()
	return SummerWaterTools.GetSingleMoleTrialHeroList()
end

return ReserveSummerWaterTemplate
