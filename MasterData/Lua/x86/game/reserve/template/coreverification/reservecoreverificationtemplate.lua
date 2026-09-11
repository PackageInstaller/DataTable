local ReserveCoreVerificationTemplate = class("ReserveCoreVerificationTemplate", (import("game.reserve.template.ReserveBaseTemplate")))

function ReserveCoreVerificationTemplate:GetLockHero(arg_1_1, arg_1_2)
	for iter_1_0, iter_1_1 in pairs((CoreVerificationData:GetLockHeroByInfoID(arg_1_1.customData.activityID))) do
		table.insert(arg_1_2.lockHeroList, iter_1_1)
	end
end

return ReserveCoreVerificationTemplate
