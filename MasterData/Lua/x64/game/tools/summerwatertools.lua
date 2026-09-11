local var_0_0 = {
	GetSingleMoleTeam = function()
		return ReserveTools.GetHeroList((ReserveParams.New(ReserveConst.RESERVE_TYPE.WATER)))
	end
}

function var_0_0.GetSingleSelectHero()
	local var_2_0, var_2_1, var_2_2, var_2_3 = var_0_0.GetSingleMoleTeam()

	return var_2_3[1]
end

function var_0_0.SetSingleSelectHero(arg_3_0)
	ReserveTools.SetHeroList(ReserveParams.New(ReserveConst.RESERVE_TYPE.WATER), {
		HeroStandardSystemCfg[arg_3_0].hero_id,
		0,
		0
	}, {
		arg_3_0,
		0,
		0
	})
end

function var_0_0.GetSingleMoleTrialHeroList()
	return ActivityWaterCfg[ActivitySummerWaterData.GetCurrentScheduleData().schedule_id].hero_id_list
end

return var_0_0
