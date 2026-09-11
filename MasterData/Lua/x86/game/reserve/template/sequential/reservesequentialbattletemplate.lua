local ReserveSequentialBattleTemplate = class("ReserveSequentialBattleTemplate", (import("game.reserve.template.ReserveBaseTemplate")))

function ReserveSequentialBattleTemplate:GetLockHero(arg_1_1, arg_1_2)
	for iter_1_0 = 1, #SequentialBattleChapterCfg[arg_1_1.customData.activityID].stage_id do
		if iter_1_0 ~= arg_1_1.teamIndex then
			for iter_1_1, iter_1_2 in ipairs((self:GetContDataTemplateById(arg_1_1.contID):GetHeroList(iter_1_0))) do
				local var_1_0 = iter_1_2:GetHeroID()

				if var_1_0 ~= 0 then
					table.insert(arg_1_2.lockHeroList, var_1_0)
				end
			end
		end
	end
end

function ReserveSequentialBattleTemplate:SaveEnabledBuff(arg_2_1, arg_2_2)
	for iter_2_0 = 1, #SequentialBattleChapterCfg[arg_2_1].stage_id do
		self:RefreshEnabeldBuff(arg_2_1, arg_2_2)
	end
end

function ReserveSequentialBattleTemplate:RefreshEnabeldBuff(arg_3_1, arg_3_2)
	local var_3_0 = self:GetContDataTemplateById(arg_3_1)
	local var_3_1 = {}

	for iter_3_0, iter_3_1 in pairs((var_3_0:GetHeroList(arg_3_2))) do
		local var_3_2 = iter_3_1:GetHeroID()

		if var_3_2 and var_3_2 ~= 0 then
			table.insert(var_3_1, var_3_2)
		end
	end

	local var_3_3 = {}

	for iter_3_2, iter_3_3 in ipairs(SequentialBattleBuffCfg.get_id_list_by_activity_id[SequentialBattleChapterCfg[arg_3_1].main_id]) do
		local var_3_4 = SequentialBattleTools.GetConditionStatus(var_3_1, SequentialBattleBuffCfg[iter_3_3].type)
		local var_3_5 = true

		for iter_3_4, iter_3_5 in ipairs(SequentialBattleBuffCfg[iter_3_3].type) do
			if var_3_4[iter_3_4] < iter_3_5[3] then
				var_3_5 = false

				break
			end
		end

		if var_3_5 then
			table.insert(var_3_3, iter_3_3)
		end
	end

	var_3_0:SetAffixList(arg_3_2, var_3_3)
end

return ReserveSequentialBattleTemplate
