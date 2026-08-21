local var_0_0 = import("game.reserve.template.ReserveBaseTemplate")
local var_0_1 = class("ReserveSequentialBattleTemplate", var_0_0)

function var_0_1.GetLockHero(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = arg_1_1.customData.activityID
	local var_1_1 = arg_1_1.teamIndex

	for iter_1_0 = 1, #SequentialBattleChapterCfg[var_1_0].stage_id do
		if iter_1_0 ~= var_1_1 then
			local var_1_2 = arg_1_0:GetContDataTemplateById(arg_1_1.contID):GetHeroList(iter_1_0)

			for iter_1_1, iter_1_2 in ipairs(var_1_2) do
				local var_1_3 = iter_1_2:GetHeroID()

				if var_1_3 ~= 0 then
					table.insert(arg_1_2.lockHeroList, var_1_3)
				end
			end
		end
	end
end

function var_0_1.SaveEnabledBuff(arg_2_0, arg_2_1, arg_2_2)
	for iter_2_0 = 1, #SequentialBattleChapterCfg[arg_2_1].stage_id do
		arg_2_0:RefreshEnabeldBuff(arg_2_1, arg_2_2)
	end
end

function var_0_1.RefreshEnabeldBuff(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_1
	local var_3_1 = arg_3_2
	local var_3_2 = arg_3_0:GetContDataTemplateById(var_3_0)
	local var_3_3 = var_3_2:GetHeroList(var_3_1)
	local var_3_4 = SequentialBattleChapterCfg[arg_3_1].main_id
	local var_3_5 = SequentialBattleBuffCfg.get_id_list_by_activity_id[var_3_4]
	local var_3_6 = {}

	for iter_3_0, iter_3_1 in pairs(var_3_3) do
		local var_3_7 = iter_3_1:GetHeroID()

		if var_3_7 and var_3_7 ~= 0 then
			table.insert(var_3_6, var_3_7)
		end
	end

	local var_3_8 = {}

	for iter_3_2, iter_3_3 in ipairs(var_3_5) do
		local var_3_9 = SequentialBattleBuffCfg[iter_3_3].type
		local var_3_10 = SequentialBattleTools.GetConditionStatus(var_3_6, var_3_9)
		local var_3_11 = true

		for iter_3_4, iter_3_5 in ipairs(var_3_9) do
			if var_3_10[iter_3_4] < iter_3_5[3] then
				var_3_11 = false

				break
			end
		end

		if var_3_11 then
			table.insert(var_3_8, iter_3_3)
		end
	end

	var_3_2:SetAffixList(var_3_1, var_3_8)
end

return var_0_1
