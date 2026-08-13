ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConst
local var_0_2 = var_0.Battle

class = var_0_10003
var_0_2.BattleSkillSummon = var_0_10003("BattleSkillSummon", var_0.Battle.BattleSkillEffect)
var_0.Battle.BattleSkillSummon.__name = "BattleSkillSummon"

local var_0_3 = var_0.Battle.BattleSkillSummon

function var_0_3.Ctor(arg_1_0, arg_1_1)
	local var_1_0 = var_0_3.super.Ctor
	local var_1_1 = arg_1_0
	local var_1_2 = arg_1_1

	lv = var_1_10006

	var_1_0(var_1_1, var_1_2, var_1_10006)

	arg_1_0._spawnData = arg_1_0._tempData.arg_list.spawnData

	return
end

function var_0_3.DoDataEffectWithoutTarget(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0:DoSummon(arg_2_1, arg_2_2)

	return
end

function var_0_3.DoDataEffect(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	arg_3_0:DoSummon(arg_3_1, arg_3_3)

	return
end

function var_0_3.DoSummon(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = var_0.Battle.BattleDataProxy.GetInstance()
	local var_4_1 = arg_4_1:GetIFF()
	local var_4_2

	if arg_4_1:GetUnitType() == var_0_1.UnitType.PLAYER_UNIT then
		var_4_2 = var_4_0:SpawnNPC(arg_4_0._spawnData, arg_4_1)
	else
		local var_4_3 = arg_4_1:GetWaveIndex()
		local var_4_4 = var_4_0:SpawnMonster(arg_4_0._spawnData, var_4_3, var_0_1.UnitType.ENEMY_UNIT, var_4_1)

		var_4_2.SetMaster(var_4_4, arg_4_1)
	end

	if arg_4_0._spawnData.damageSrcWarp then
		var_0.Battle.BattleAttr.SetCurrent(var_4_2, "id", nil)
	end

	return
end

return
