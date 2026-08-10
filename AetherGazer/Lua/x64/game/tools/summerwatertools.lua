local var_0_0 = {
	GetSingleMoleTeam = function()
		local var_1_0 = ReserveParams.New(ReserveConst.RESERVE_TYPE.WATER)

		return ReserveTools.GetHeroList(var_1_0)
	end
}

function var_0_0.GetSingleSelectHero()
	local var_2_0, var_2_1, var_2_2, var_2_3 = var_0_0.GetSingleMoleTeam()

	return var_2_3[1]
end

function var_0_0.SetSingleSelectHero(arg_3_0)
	local var_3_0 = ReserveParams.New(ReserveConst.RESERVE_TYPE.WATER)
	local var_3_1 = HeroStandardSystemCfg[arg_3_0].hero_id

	ReserveTools.SetHeroList(var_3_0, {
		var_3_1,
		0,
		0
	}, {
		arg_3_0,
		0,
		0
	})
end

function var_0_0.GetSingleMoleTrialHeroList()
	local var_4_0 = ActivitySummerWaterData.GetCurrentScheduleData()

	return ActivityWaterCfg[var_4_0.schedule_id].hero_id_list
end

return var_0_0
