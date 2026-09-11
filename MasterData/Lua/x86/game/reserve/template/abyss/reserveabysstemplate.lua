local ReserveAbyssTemplate = class("ReserveAbyssTemplate", (import("game.reserve.template.ReserveBaseTemplate")))

function ReserveAbyssTemplate:FilterInvalidTeamData(arg_1_1, arg_1_2)
	local var_1_0 = clone(arg_1_2.resultHeroList)

	if arg_1_1.customData.layer ~= nil then
		for iter_1_0, iter_1_1 in pairs((self:GetLayerLockHeroList(arg_1_1.customData.layer))) do
			for iter_1_2, iter_1_3 in pairs(var_1_0) do
				if iter_1_3 == iter_1_1 then
					var_1_0[iter_1_2] = 0
					arg_1_2.isInvaild = true
				end
			end
		end
	end

	for iter_1_4, iter_1_5 in pairs((self:GetGloalBanHeroList())) do
		for iter_1_6, iter_1_7 in pairs(var_1_0) do
			if iter_1_7 == iter_1_5 then
				var_1_0[iter_1_6] = 0
				arg_1_2.isInvaild = true
			end
		end
	end

	local var_1_1 = {}

	for iter_1_8, iter_1_9 in pairs(var_1_0) do
		if iter_1_9 ~= 0 then
			table.insert(var_1_1, iter_1_9)
		end
	end

	for iter_1_10 = 1, 3 do
		arg_1_2.resultHeroList[iter_1_10] = var_1_1[iter_1_10] == nil and 0 or var_1_1[iter_1_10]
	end
end

function ReserveAbyssTemplate:GetLayerLockHeroList(arg_2_1)
	local var_2_0 = {}

	for iter_2_0, iter_2_1 in ipairs(AbyssData:GetAbyssCfg(arg_2_1).stage_list) do
		table.insertto(var_2_0, self:GetStageLockHeroList(arg_2_1, iter_2_0))
	end

	return var_2_0
end

function ReserveAbyssTemplate:GetStageLockHeroList(arg_3_1, arg_3_2)
	local var_3_0 = {}
	local var_3_1 = AbyssData:GetAbyssCfg(arg_3_1).stage_list[arg_3_2]

	if AbyssData:GetStageData(arg_3_1, arg_3_2).is_completed == true then
		local var_3_2 = self:GetContDataTemplateById(var_3_1[2])

		for iter_3_0, iter_3_1 in ipairs(var_3_1[1] ~= 3 and self:GetContDataTemplateById(var_3_1[2]):GetHeroList(ReserveConst.DEFAULT_TEAM_INDEX) or var_3_2:GetHeroList((var_3_2:GetTeamCount()))) do
			local var_3_4 = iter_3_1:GetHeroID()

			if var_3_4 ~= 0 then
				var_3_0[#var_3_0 + 1] = var_3_4
			end
		end
	end

	return var_3_0
end

function ReserveAbyssTemplate:GetGloalBanHeroList()
	local var_4_0 = {}

	for iter_4_0, iter_4_1 in ipairs(AbyssCfg.get_id_list_by_activity_id[AbyssData:GetActivityId()]) do
		if AbyssData:IsLayerUnlock(AbyssCfg[iter_4_1].level) then
			for iter_4_2, iter_4_3 in ipairs(AbyssCfg[iter_4_1].stage_list) do
				table.insertto(var_4_0, self:GetStageBanHeroList(AbyssCfg[iter_4_1].level, iter_4_2))
			end
		end
	end

	return var_4_0
end

function ReserveAbyssTemplate:GetStageBanHeroList(arg_5_1, arg_5_2)
	local var_5_0 = {}

	if AbyssData:IsLayerUnlock(arg_5_1) then
		local var_5_1 = AbyssData:GetAbyssCfg(arg_5_1).stage_list[arg_5_2]

		if var_5_1[1] == 3 then
			local var_5_2 = self:GetContDataTemplateById(var_5_1[2])
			local var_5_3 = var_5_2:GetTeamCount()

			for iter_5_0 = 1, AbyssTools.GetLayerBossTeamCacheFlag(arg_5_1, arg_5_2) and var_5_3 - 1 or AbyssData:GetStageData(arg_5_1, arg_5_2).is_completed and var_5_3 - 1 or var_5_3 do
				for iter_5_1, iter_5_2 in ipairs((var_5_2:GetHeroList(iter_5_0))) do
					local var_5_5 = iter_5_2:GetHeroID()

					if var_5_5 ~= 0 then
						var_5_0[#var_5_0 + 1] = var_5_5
					end
				end
			end
		end
	end

	return var_5_0
end

return ReserveAbyssTemplate
