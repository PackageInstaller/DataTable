local var_0_0 = class("BattleCooperationDemoTemplate", BattleBaseCooperationTemplate)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.activityID_ = arg_1_1

	local var_1_0 = ActivityCooperationDemoCfg[arg_1_1].stage_id

	var_0_0.super.Ctor(arg_1_0)

	arg_1_0.id_ = var_1_0
	arg_1_0.cfg = BattleCooperationDemoCfg[var_1_0]
end

function var_0_0.GetStageId(arg_2_0)
	return arg_2_0.id_
end

function var_0_0.GetType(arg_3_0)
	return BattleConst.STAGE_TYPE_NEW.COOPERATION_DEMO
end

function var_0_0.GetMap(arg_4_0)
	return arg_4_0.cfg.map, false
end

function var_0_0.GetEnemyLevel(arg_5_0)
	return arg_5_0.cfg.monster_level
end

function var_0_0.GetRevive(arg_6_0)
	if type(arg_6_0.cfg.is_revive) ~= "table" then
		return false, 0, 0, 0
	end

	local var_6_0 = arg_6_0.cfg.is_revive
	local var_6_1 = var_6_0[1] and true or false
	local var_6_2 = var_6_0[1] or 0
	local var_6_3 = var_6_0[1] and ItemTools.getItemNum(var_6_0[1]) or 0
	local var_6_4 = var_6_0[2] or 0

	return var_6_1, var_6_2, var_6_3, var_6_4
end

function var_0_0.GetStageAffix(arg_7_0)
	local var_7_0 = {}
	local var_7_1 = {}
	local var_7_2 = {}
	local var_7_3 = {
		{
			9491,
			3,
			3
		},
		{
			9492,
			3,
			3
		},
		{
			9493,
			3,
			3
		}
	}

	for iter_7_0, iter_7_1 in pairs(var_7_3 or {}) do
		table.insert(var_7_0, iter_7_1[1])
		table.insert(var_7_1, iter_7_1[2])
		table.insert(var_7_2, iter_7_1[3])
	end

	return var_7_0, var_7_1, var_7_2
end

return var_0_0
