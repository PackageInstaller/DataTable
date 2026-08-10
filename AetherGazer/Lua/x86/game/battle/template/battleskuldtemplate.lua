local var_0_0 = class("BattleSkuldTemplate", BattleBaseStageTemplate)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.id = arg_1_1
	arg_1_0.cfg = BattleSkuldStageCfg[arg_1_1]
	arg_1_0.startNext_ = false
end

function var_0_0.Init(arg_2_0)
	if BattleConst.BATTLE_TAG.STORY == arg_2_0.cfg.tag then
		arg_2_0.heroList_ = {}
		arg_2_0.heroTrialList_ = {}
	else
		arg_2_0:InitHeroList()
	end

	arg_2_0:InitComboSkillID()
	arg_2_0:InitChipData()
end

function var_0_0.GetDest(arg_3_0)
	return SkuldSystemData:GetLevelIDByStageID(arg_3_0.id)
end

function var_0_0.GetStageId(arg_4_0)
	return arg_4_0.id
end

function var_0_0.GetType(arg_5_0)
	return BattleConst.STAGE_TYPE_NEW.SKULD
end

function var_0_0.GetMap(arg_6_0)
	return arg_6_0.cfg.map, false
end

function var_0_0.GetAILevel(arg_7_0)
	return arg_7_0.cfg.ai_level
end

function var_0_0.GetEnemyLevel(arg_8_0)
	return arg_8_0.cfg.monster_level
end

function var_0_0.GetHeroTeam(arg_9_0)
	return arg_9_0.heroList_, arg_9_0.heroTrialList_
end

function var_0_0.GetIsStartNext(arg_10_0)
	return arg_10_0.startNext_
end

function var_0_0.SetStartNext(arg_11_0)
	arg_11_0.startNext_ = true
end

function var_0_0.GetRevive(arg_12_0)
	if type(arg_12_0.cfg.is_revive) ~= "table" then
		return false, 0, 0, 0
	end

	local var_12_0 = arg_12_0.cfg.is_revive
	local var_12_1 = var_12_0[1] and true or false
	local var_12_2 = var_12_0[1] or 0
	local var_12_3 = var_12_0[1] and ItemTools.getItemNum(var_12_0[1]) or 0
	local var_12_4 = var_12_0[2] or 0

	return var_12_1, var_12_2, var_12_3, var_12_4
end

return var_0_0
