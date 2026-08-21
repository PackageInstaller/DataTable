ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleConst
local var_0_2 = ys.Battle.BattleFormulas

ys.Battle.BattleSkillSummon = class("BattleSkillSummon", ys.Battle.BattleSkillEffect)
ys.Battle.BattleSkillSummon.__name = "BattleSkillSummon"

local var_0_3 = ys.Battle.BattleSkillSummon

function ys.Battle.BattleSkillSummon.Ctor(arg_1_0, arg_1_1)
	var_0_3.super.Ctor(arg_1_0, arg_1_1, lv)

	arg_1_0._spawnData = arg_1_0._tempData.arg_list.spawnData

	return
end

function ys.Battle.BattleSkillSummon.DoDataEffectWithoutTarget(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0:DoSummon(arg_2_1, arg_2_2)

	return
end

function ys.Battle.BattleSkillSummon.DoDataEffect(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	arg_3_0:DoSummon(arg_3_1, arg_3_3)

	return
end

function ys.Battle.BattleSkillSummon.DoSummon(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = var_0_0.Battle.BattleDataProxy.GetInstance()
	local var_4_1

	if arg_4_1:GetUnitType() == var_0_1.UnitType.PLAYER_UNIT then
		var_4_1 = var_4_0:SpawnNPC(arg_4_0._spawnData, arg_4_1)
	else
		var_4_1 = var_4_0:SpawnMonster(arg_4_0._spawnData, arg_4_1:GetWaveIndex(), var_0_1.UnitType.ENEMY_UNIT, (arg_4_1:GetIFF()))

		var_4_1:SetMaster(arg_4_1)

		if arg_4_0._spawnData.relativeCorrdinate then
			local var_4_2 = arg_4_1:GetPosition()
			local var_4_3 = var_0_2.RandomPos(arg_4_0._spawnData.relativeCorrdinate)

			var_4_3.x = var_4_3.x + var_4_2.x
			var_4_3.y = var_4_3.y + var_4_2.y
			var_4_3.z = var_4_3.z + var_4_2.z

			var_4_1:SetPosition(var_4_3)
		end
	end

	if arg_4_0._spawnData.damageSrcWarp then
		var_0_0.Battle.BattleAttr.SetCurrent(var_4_1, "id", nil)
	end

	return
end

return
