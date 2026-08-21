local var_0_0 = class("ReserveHeroPosTemplate")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.pos = arg_1_1
	arg_1_0.hero_type = 1
	arg_1_0.trial_id = 0
	arg_1_0.hero_id = 0
end

function var_0_0.UpdateServerData(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.pos = arg_2_2
	arg_2_0.hero_type = arg_2_1.hero_type or 1

	if arg_2_0.hero_type == 1 then
		arg_2_0.trial_id = 0
		arg_2_0.hero_id = arg_2_1.hero_id
	elseif arg_2_0.hero_type == 2 then
		arg_2_0.trial_id = arg_2_1.hero_id
		arg_2_0.hero_id = HeroStandardSystemCfg[arg_2_1.hero_id].hero_id
	end
end

function var_0_0.GetHeroID(arg_3_0)
	return arg_3_0.hero_id
end

function var_0_0.SetHeroID(arg_4_0, arg_4_1)
	arg_4_0.hero_id = arg_4_1 or 0
end

function var_0_0.GetTrialID(arg_5_0)
	return arg_5_0.trial_id
end

function var_0_0.SetTrialID(arg_6_0, arg_6_1)
	arg_6_0.trial_id = arg_6_1 or 0
	arg_6_0.hero_type = arg_6_0.trial_id ~= 0 and 2 or 1
end

function var_0_0.GetHeroType(arg_7_0)
	return arg_7_0.hero_type
end

function var_0_0.ConvertToSendData(arg_8_0)
	local var_8_0 = {}

	if arg_8_0.hero_type == 1 then
		var_8_0.hero_id = arg_8_0.hero_id
	else
		var_8_0.hero_id = arg_8_0.trial_id
	end

	var_8_0.hero_type = arg_8_0.hero_type

	return var_8_0
end

function var_0_0.Reset(arg_9_0)
	arg_9_0.hero_type = 1
	arg_9_0.trial_id = 0
	arg_9_0.hero_id = 0
end

return var_0_0
