local var_0_0 = class("BattleHellaPinBallTemplate", BattleBaseStageTemplate)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.id = arg_1_1
	arg_1_0.activityId = PinballData:GetActivityID()
	arg_1_0.data = arg_1_2
	arg_1_0.cfg = BattleHellaPinballStageCfg[arg_1_1]
	arg_1_0.roleDataInLua = {}
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitHeroList()
	arg_2_0:InitComboSkillID()
	arg_2_0:InitChipData()
end

function var_0_0.GetChipManagerID(arg_3_0)
	return 0
end

function var_0_0.InitChipData(arg_4_0)
	arg_4_0.charChipBaseID_ = nil
	arg_4_0.charChipExtraIDList_ = nil
	arg_4_0.chipList_ = {}
end

function var_0_0.GetDest(arg_5_0)
	return arg_5_0.id
end

function var_0_0.GetStageId(arg_6_0)
	return arg_6_0.id
end

function var_0_0.GetActivityID(arg_7_0)
	return arg_7_0.activityId
end

function var_0_0.GetType(arg_8_0)
	return BattleConst.STAGE_TYPE_NEW.HELLA_PINBALL_BATTLE
end

function var_0_0.GetMap(arg_9_0)
	return arg_9_0.cfg.map, false
end

function var_0_0.GetName(arg_10_0)
	return arg_10_0.cfg.name
end

function var_0_0.GetAILevel(arg_11_0)
	return arg_11_0.cfg.ai_level or 0
end

function var_0_0.GetEnemyLevel(arg_12_0)
	return arg_12_0.cfg.monster_level
end

function var_0_0.GetRevive(arg_13_0)
	if type(arg_13_0.cfg.is_revive) ~= "table" then
		return false, 0, 0, 0
	end

	local var_13_0 = arg_13_0.cfg.is_revive
	local var_13_1 = var_13_0[1] and true or false
	local var_13_2 = var_13_0[1] or 0
	local var_13_3 = var_13_0[1] and ItemTools.getItemNum(var_13_0[1]) or 0
	local var_13_4 = var_13_0[2] or 0

	return var_13_1, var_13_2, var_13_3, var_13_4
end

function var_0_0.GetHeroTeam(arg_14_0)
	return arg_14_0.heroList_, arg_14_0.heroTrialList_
end

return var_0_0
