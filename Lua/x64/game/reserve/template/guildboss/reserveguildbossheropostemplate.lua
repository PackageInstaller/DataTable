local var_0_0 = import("game.reserve.ReserveHeroPosTemplate")
local var_0_1 = class("ReserveGuildBossHeroPosTemplate", var_0_0)

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.pos = arg_1_1
	arg_1_0.hero_type = 1
	arg_1_0.trial_id = 0
	arg_1_0.hero_id = 0
	arg_1_0.owner_id = BattleTeamData.NO_OWNER
end

function var_0_1.SetOwnerID(arg_2_0, arg_2_1)
	arg_2_0.owner_id = arg_2_1
	arg_2_0.hero_type = 3
end

function var_0_1.UpdateServerData(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.pos = arg_3_2
	arg_3_0.hero_type = arg_3_1.hero_type or 1
	arg_3_0.trial_id = 0
	arg_3_0.hero_id = arg_3_1.hero_id or 0
	arg_3_0.owner_id = arg_3_1.owner_id or BattleTeamData.NO_OWNER
end

function var_0_1.UpdateClientData(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.pos = arg_4_2
	arg_4_0.hero_type = arg_4_1.hero_type or 1
	arg_4_0.trial_id = arg_4_1.trial_id
	arg_4_0.hero_id = arg_4_1.hero_id
	arg_4_0.owner_id = arg_4_1.owner_id or BattleTeamData.NO_OWNER
end

function var_0_1.GetOwnerID(arg_5_0)
	return arg_5_0.owner_id
end

function var_0_1.ConvertToSendData(arg_6_0)
	local var_6_0 = {
		hero_type = arg_6_0.hero_type
	}

	if arg_6_0.hero_type == 1 then
		var_6_0.hero_id = arg_6_0.hero_id
	else
		var_6_0.hero_id = arg_6_0.trial_id
	end

	var_6_0.owner_id = arg_6_0.owner_id

	return var_6_0
end

return var_0_1
