local ReserveGuildActivityTemplate = class("ReserveGuildActivityTemplate", (import("game.reserve.template.ReserveBaseTemplate")))

function ReserveGuildActivityTemplate:FilterInvalidTeamData(arg_1_1, arg_1_2)
	ReserveGuildActivityTemplate.super.FilterInvalidTeamData(self, arg_1_1, arg_1_2)

	local var_1_0 = arg_1_1.stageType == BattleConst.STAGE_TYPE_NEW.GUILD_ACTIVITY and GuildActivityData:GetFightHeroList() or GuildActivitySPData:GetFightHeroList()

	for iter_1_0, iter_1_1 in ipairs(arg_1_2.resultHeroList) do
		local var_1_1 = false

		for iter_1_2, iter_1_3 in ipairs(var_1_0) do
			if iter_1_3.id == iter_1_1 then
				var_1_1 = true

				break
			end
		end

		if not var_1_1 then
			self:ResetHeroInTeamAtPos(arg_1_2, iter_1_0)
		end
	end
end

function ReserveGuildActivityTemplate:GetLockHero(arg_2_1, arg_2_2)
	if arg_2_1.stageType == BattleConst.STAGE_TYPE_NEW.GUILD_ACTIVITY_SP then
		arg_2_2.lockHeroList = GuildActivitySpTools.GetCantUseHeroList()
	end
end

return ReserveGuildActivityTemplate
