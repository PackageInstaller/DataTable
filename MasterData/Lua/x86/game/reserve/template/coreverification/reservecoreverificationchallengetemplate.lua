local ReserveCoreVerificationChallengeTemplate = class("ReserveCoreVerificationChallengeTemplate", (import("game.reserve.template.ReserveBaseTemplate")))

function ReserveCoreVerificationChallengeTemplate:GetLockHero(arg_1_1, arg_1_2)
	CoreVerificationChallengeTools.PushStageLockedHero(arg_1_1, arg_1_2.lockHeroList)
end

return ReserveCoreVerificationChallengeTemplate
