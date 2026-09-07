ys = ys or {}

local var_0_0 = ys

ys.Battle.BattleTorpedoUnit = class("BattleTorpedoUnit", ys.Battle.BattleWeaponUnit)
ys.Battle.BattleTorpedoUnit.__name = "BattleTorpedoUnit"

local var_0_1 = ys.Battle.BattleTorpedoUnit

function ys.Battle.BattleTorpedoUnit.Ctor(arg_1_0)
	var_0_0.Battle.BattleTorpedoUnit.super.Ctor(arg_1_0)

	return
end

function ys.Battle.BattleTorpedoUnit:TriggerBuffOnFire()
	self._host:TriggerBuff(var_0_0.Battle.BattleConst.BuffEffectType.ON_TORPEDO_FIRE, {
		equipIndex = self._equipmentIndex
	})

	return
end

function ys.Battle.BattleTorpedoUnit:EnterCoolDown()
	if self._isSupportWeapon then
		self._currentState = self.STATE_DISABLE
	else
		var_0_1.super.EnterCoolDown(self)
	end

	return
end

function ys.Battle.BattleTorpedoUnit:TriggerBuffWhenSpawn(arg_4_1)
	local var_4_0 = {
		_bullet = arg_4_1,
		equipIndex = self._equipmentIndex,
		bulletTag = arg_4_1:GetExtraTag()
	}

	self._host:TriggerBuff(var_0_0.Battle.BattleConst.BuffEffectType.ON_BULLET_CREATE, var_4_0)
	self._host:TriggerBuff(var_0_0.Battle.BattleConst.BuffEffectType.ON_TORPEDO_BULLET_CREATE, var_4_0)

	return
end

return
