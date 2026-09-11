local var_0_0 = {}
local var_0_1 = false

manager.net:Bind(11035, function(arg_1_0)
	if not var_0_1 then
		var_0_1 = true

		HeroTrialTools.InitConst()
	end

	HeroTrialData:InitData(arg_1_0)
	manager.notify:Invoke(HERO_TRIAL_UPDATE)
end)

function var_0_0.GetTrialReward(arg_2_0, arg_2_1, arg_2_2)
	manager.net:SendWithLoadingNew(11036, {
		activity_id = arg_2_0,
		id = arg_2_1
	}, 11037, function(arg_3_0)
		if isSuccess(arg_3_0.result) then
			HeroTrialData:ReceiveReward(arg_2_1)
		end

		arg_2_2(arg_3_0)
	end)
end

manager.net:Bind(12123, function(arg_4_0)
	if not var_0_1 then
		var_0_1 = true

		HeroTrialTools.InitConst()
	end

	HeroTrialData:InitHeroTrialedData(arg_4_0)
end)

return var_0_0
