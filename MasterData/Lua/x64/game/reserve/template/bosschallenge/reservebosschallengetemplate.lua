local ReserveBossChallengeTemplate = class("ReserveBossChallengeTemplate", (import("game.reserve.template.ReserveBaseTemplate")))

function ReserveBossChallengeTemplate:GetLockHero(arg_1_1, arg_1_2)
	for iter_1_0, iter_1_1 in pairs((BossTools.GetLockHero())) do
		if iter_1_0 ~= arg_1_1.customData.bossIndex then
			table.insertto(arg_1_2.lockHeroList, iter_1_1)
		end
	end
end

return ReserveBossChallengeTemplate
