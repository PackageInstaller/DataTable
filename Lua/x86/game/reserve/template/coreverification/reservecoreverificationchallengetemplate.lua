local var_0_0 = import("game.reserve.template.ReserveBaseTemplate")
local var_0_1 = class("ReserveCoreVerificationChallengeTemplate", var_0_0)

function var_0_1.GetLockHero(arg_1_0, arg_1_1, arg_1_2)
	CoreVerificationChallengeTools.PushStageLockedHero(arg_1_1, arg_1_2.lockHeroList)
end

return var_0_1
