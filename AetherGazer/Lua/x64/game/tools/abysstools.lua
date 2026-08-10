local var_0_0 = {
	bossTeamCacheFlagDic = {}
}

function var_0_0.SetLayerBossTeamCacheFlag(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.bossTeamCacheFlagDic[arg_1_0] = var_0_0.bossTeamCacheFlagDic[arg_1_0] or {}
	var_0_0.bossTeamCacheFlagDic[arg_1_0][arg_1_1] = arg_1_2
end

function var_0_0.GetLayerBossTeamCacheFlag(arg_2_0, arg_2_1)
	var_0_0.bossTeamCacheFlagDic[arg_2_0] = var_0_0.bossTeamCacheFlagDic[arg_2_0] or {}

	return var_0_0.bossTeamCacheFlagDic[arg_2_0][arg_2_1]
end

function var_0_0.GetTeamIndex(arg_3_0, arg_3_1)
	local var_3_0
	local var_3_1 = AbyssData:GetAbyssCfg(arg_3_0).stage_list[arg_3_1]

	if var_3_1[1] == 3 then
		local var_3_2 = var_0_0.GetLayerBossTeamCacheFlag(arg_3_0, arg_3_1)
		local var_3_3 = var_3_1[2]
		local var_3_4 = ReserveTools.GetReserveTemplateByReserveType(ReserveConst.RESERVE_TYPE.ABYSS):GetContDataTemplateById(var_3_3):GetTeamCount()

		if var_3_2 then
			var_3_0 = var_3_4
		else
			var_3_0 = var_3_4 + 1

			var_0_0.SetLayerBossTeamCacheFlag(arg_3_0, arg_3_1, true)
		end
	else
		var_3_0 = ReserveConst.DEFAULT_TEAM_INDEX
	end

	return var_3_0
end

function var_0_0.GetLayerLockHeroList(arg_4_0)
	return ReserveTools.GetReserveTemplateByReserveType(ReserveConst.RESERVE_TYPE.ABYSS):GetLayerLockHeroList(arg_4_0)
end

function var_0_0.GetGlobalBanHeroList()
	return ReserveTools.GetReserveTemplateByReserveType(ReserveConst.RESERVE_TYPE.ABYSS):GetGloalBanHeroList()
end

function var_0_0.GetStageLockHeroList(arg_6_0, arg_6_1)
	return ReserveTools.GetReserveTemplateByReserveType(ReserveConst.RESERVE_TYPE.ABYSS):GetStageLockHeroList(arg_6_0, arg_6_1)
end

function var_0_0.GetStageBanHeroList(arg_7_0, arg_7_1)
	return ReserveTools.GetReserveTemplateByReserveType(ReserveConst.RESERVE_TYPE.ABYSS):GetStageBanHeroList(arg_7_0, arg_7_1)
end

return var_0_0
