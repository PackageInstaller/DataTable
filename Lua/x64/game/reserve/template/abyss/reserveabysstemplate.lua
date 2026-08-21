local var_0_0 = import("game.reserve.template.ReserveBaseTemplate")
local var_0_1 = class("ReserveAbyssTemplate", var_0_0)

function var_0_1.FilterInvalidTeamData(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = clone(arg_1_2.resultHeroList)

	if arg_1_1.customData.layer ~= nil then
		local var_1_1 = arg_1_0:GetLayerLockHeroList(arg_1_1.customData.layer)

		for iter_1_0, iter_1_1 in pairs(var_1_1) do
			for iter_1_2, iter_1_3 in pairs(var_1_0) do
				if iter_1_3 == iter_1_1 then
					var_1_0[iter_1_2] = 0
					arg_1_2.isInvaild = true
				end
			end
		end
	end

	local var_1_2 = arg_1_0:GetGloalBanHeroList()

	for iter_1_4, iter_1_5 in pairs(var_1_2) do
		for iter_1_6, iter_1_7 in pairs(var_1_0) do
			if iter_1_7 == iter_1_5 then
				var_1_0[iter_1_6] = 0
				arg_1_2.isInvaild = true
			end
		end
	end

	local var_1_3 = {}

	for iter_1_8, iter_1_9 in pairs(var_1_0) do
		if iter_1_9 ~= 0 then
			table.insert(var_1_3, iter_1_9)
		end
	end

	for iter_1_10 = 1, 3 do
		if var_1_3[iter_1_10] == nil then
			arg_1_2.resultHeroList[iter_1_10] = 0
		else
			arg_1_2.resultHeroList[iter_1_10] = var_1_3[iter_1_10]
		end
	end
end

function var_0_1.GetLayerLockHeroList(arg_2_0, arg_2_1)
	local var_2_0 = AbyssData:GetAbyssCfg(arg_2_1).stage_list
	local var_2_1 = {}

	for iter_2_0, iter_2_1 in ipairs(var_2_0) do
		table.insertto(var_2_1, arg_2_0:GetStageLockHeroList(arg_2_1, iter_2_0))
	end

	return var_2_1
end

function var_0_1.GetStageLockHeroList(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = {}
	local var_3_1 = AbyssData:GetAbyssCfg(arg_3_1).stage_list[arg_3_2]

	if AbyssData:GetStageData(arg_3_1, arg_3_2).is_completed == true then
		local var_3_2 = var_3_1[2]
		local var_3_3 = arg_3_0:GetContDataTemplateById(var_3_2)
		local var_3_4

		if var_3_1[1] ~= 3 then
			local var_3_5 = var_3_1[2]

			var_3_4 = arg_3_0:GetContDataTemplateById(var_3_5):GetHeroList(ReserveConst.DEFAULT_TEAM_INDEX)
		else
			local var_3_6 = var_3_3:GetTeamCount()

			var_3_4 = var_3_3:GetHeroList(var_3_6)
		end

		for iter_3_0, iter_3_1 in ipairs(var_3_4) do
			local var_3_7 = iter_3_1:GetHeroID()

			if var_3_7 ~= 0 then
				var_3_0[#var_3_0 + 1] = var_3_7
			end
		end
	end

	return var_3_0
end

function var_0_1.GetGloalBanHeroList(arg_4_0)
	local var_4_0 = {}

	for iter_4_0, iter_4_1 in ipairs(AbyssCfg.get_id_list_by_activity_id[AbyssData:GetActivityId()]) do
		local var_4_1 = AbyssCfg[iter_4_1].level

		if AbyssData:IsLayerUnlock(var_4_1) then
			local var_4_2 = AbyssCfg[iter_4_1].stage_list

			for iter_4_2, iter_4_3 in ipairs(var_4_2) do
				table.insertto(var_4_0, arg_4_0:GetStageBanHeroList(var_4_1, iter_4_2))
			end
		end
	end

	return var_4_0
end

function var_0_1.GetStageBanHeroList(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = {}

	if AbyssData:IsLayerUnlock(arg_5_1) then
		local var_5_1 = AbyssData:GetAbyssCfg(arg_5_1).stage_list[arg_5_2]

		if var_5_1[1] == 3 then
			local var_5_2 = AbyssData:GetStageData(arg_5_1, arg_5_2)
			local var_5_3 = var_5_1[2]
			local var_5_4 = arg_5_0:GetContDataTemplateById(var_5_3)
			local var_5_5 = var_5_4:GetTeamCount()
			local var_5_6

			if AbyssTools.GetLayerBossTeamCacheFlag(arg_5_1, arg_5_2) then
				var_5_6 = var_5_5 - 1
			elseif var_5_2.is_completed then
				var_5_6 = var_5_5 - 1
			else
				var_5_6 = var_5_5
			end

			for iter_5_0 = 1, var_5_6 do
				local var_5_7 = var_5_4:GetHeroList(iter_5_0)

				for iter_5_1, iter_5_2 in ipairs(var_5_7) do
					local var_5_8 = iter_5_2:GetHeroID()

					if var_5_8 ~= 0 then
						var_5_0[#var_5_0 + 1] = var_5_8
					end
				end
			end
		end
	end

	return var_5_0
end

return var_0_1
