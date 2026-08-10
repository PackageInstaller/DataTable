local var_0_0 = import("game.reserve.template.ReserveBaseTemplate")
local var_0_1 = class("ReserveCoreVerificationTemplate", var_0_0)

function var_0_1.GetLockHero(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = arg_1_1.customData.activityID
	local var_1_1 = CoreVerificationData:GetLockHeroByInfoID(var_1_0)

	for iter_1_0, iter_1_1 in pairs(var_1_1) do
		table.insert(arg_1_2.lockHeroList, iter_1_1)
	end
end

return var_0_1
