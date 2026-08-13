ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

class = var_0_10002
var_0_1.BattleTorpedoUnit = var_0_10002("BattleTorpedoUnit", var_0.Battle.BattleWeaponUnit)
var_0.Battle.BattleTorpedoUnit.__name = "BattleTorpedoUnit"

local var_0_2 = var_0.Battle.BattleTorpedoUnit

function var_0_2.Ctor(arg_1_0)
	var_0.Battle.BattleTorpedoUnit.super.Ctor(arg_1_0)

	return
end

function var_0_2.TriggerBuffOnFire(arg_2_0)
	local var_2_0 = arg_2_0._host

	var_1.TriggerBuff(var_2_0, var_0.Battle.BattleConst.BuffEffectType.ON_TORPEDO_FIRE, {
		equipIndex = arg_2_0._equipmentIndex
	})

	return
end

function var_0_2.EnterCoolDown(arg_3_0)
	if arg_3_0._isSupportWeapon then
		arg_3_0._currentState = arg_3_0.STATE_DISABLE
	else
		var_0_2.super.EnterCoolDown(arg_3_0)
	end

	return
end

function var_0_2.TriggerBuffWhenSpawn(arg_4_0, arg_4_1)
	local var_4_0 = {
		_bullet = arg_4_1,
		equipIndex = arg_4_0._equipmentIndex,
		bulletTag = arg_4_1:GetExtraTag()
	}
	local var_4_1 = arg_4_0._host

	var_3.TriggerBuff(var_4_1, var_0.Battle.BattleConst.BuffEffectType.ON_BULLET_CREATE, var_4_0)

	local var_4_2 = arg_4_0._host

	var_3.TriggerBuff(var_4_2, var_0.Battle.BattleConst.BuffEffectType.ON_TORPEDO_BULLET_CREATE, var_4_0)

	return
end

return
