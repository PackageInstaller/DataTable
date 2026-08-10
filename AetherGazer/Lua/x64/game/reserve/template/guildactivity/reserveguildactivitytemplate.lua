local var_0_0 = import("game.reserve.template.ReserveBaseTemplate")
local var_0_1 = class("ReserveGuildActivityTemplate", var_0_0)

function var_0_1.FilterInvalidTeamData(arg_1_0, arg_1_1, arg_1_2)
	var_0_1.super.FilterInvalidTeamData(arg_1_0, arg_1_1, arg_1_2)

	local var_1_0

	if arg_1_1.stageType == BattleConst.STAGE_TYPE_NEW.GUILD_ACTIVITY then
		var_1_0 = GuildActivityData:GetFightHeroList()
	else
		var_1_0 = GuildActivitySPData:GetFightHeroList()
	end

	for iter_1_0, iter_1_1 in ipairs(arg_1_2.resultHeroList) do
		local var_1_1 = false

		for iter_1_2, iter_1_3 in ipairs(var_1_0) do
			if iter_1_3.id == iter_1_1 then
				var_1_1 = true

				break
			end
		end

		if not var_1_1 then
			arg_1_0:ResetHeroInTeamAtPos(arg_1_2, iter_1_0)
		end
	end
end

function var_0_1.GetLockHero(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1.stageType == BattleConst.STAGE_TYPE_NEW.GUILD_ACTIVITY_SP then
		arg_2_2.lockHeroList = GuildActivitySpTools.GetCantUseHeroList()
	end
end

return var_0_1
