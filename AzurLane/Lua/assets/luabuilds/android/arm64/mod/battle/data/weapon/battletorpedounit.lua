ys = ys or {}

local var_0_0 = ys

ys.Battle.BattleTorpedoUnit = class("BattleTorpedoUnit", ys.Battle.BattleWeaponUnit)
ys.Battle.BattleTorpedoUnit.__name = "BattleTorpedoUnit"

local var_0_1 = ys.Battle.BattleTorpedoUnit

function ys.Battle.BattleTorpedoUnit.Ctor(arg_1_0)
	var_0_0.Battle.BattleTorpedoUnit.super.Ctor(arg_1_0)

	return
end

function ys.Battle.BattleTorpedoUnit.TriggerBuffOnFire(arg_2_0)
	arg_2_0._host:TriggerBuff(var_0_0.Battle.BattleConst.BuffEffectType.ON_TORPEDO_FIRE, {
		equipIndex = arg_2_0._equipmentIndex
	})

	return
end

function ys.Battle.BattleTorpedoUnit.EnterCoolDown(arg_3_0)
	if arg_3_0._isSupportWeapon then
		arg_3_0._currentState = arg_3_0.STATE_DISABLE
	else
		var_0_1.super.EnterCoolDown(arg_3_0)
	end

	return
end

function ys.Battle.BattleTorpedoUnit.TriggerBuffWhenSpawn(arg_4_0, arg_4_1)
	local var_4_0 = {
		_bullet = arg_4_1,
		equipIndex = arg_4_0._equipmentIndex,
		bulletTag = arg_4_1:GetExtraTag()
	}

	arg_4_0._host:TriggerBuff(var_0_0.Battle.BattleConst.BuffEffectType.ON_BULLET_CREATE, var_4_0)
	arg_4_0._host:TriggerBuff(var_0_0.Battle.BattleConst.BuffEffectType.ON_TORPEDO_BULLET_CREATE, var_4_0)

	return
end

return
