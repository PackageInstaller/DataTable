local var_0_0 = import("game.reserve.template.ReserveBaseTemplate")
local var_0_1 = class("ReserveBossChallengeTemplate", var_0_0)

function var_0_1.GetLockHero(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = arg_1_1.customData.bossIndex
	local var_1_1 = BossTools.GetLockHero()

	for iter_1_0, iter_1_1 in pairs(var_1_1) do
		if iter_1_0 ~= var_1_0 then
			table.insertto(arg_1_2.lockHeroList, iter_1_1)
		end
	end
end

return var_0_1
