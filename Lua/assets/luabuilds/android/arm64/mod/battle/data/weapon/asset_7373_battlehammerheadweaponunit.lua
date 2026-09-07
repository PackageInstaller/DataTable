ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleDataFunction
local var_0_2 = ys.Battle.BattleConst

ys.Battle.BattleHammerHeadWeaponUnit = class("BattleHammerHeadWeaponUnit", ys.Battle.BattleWeaponUnit)
ys.Battle.BattleHammerHeadWeaponUnit.__name = "BattleHammerHeadWeaponUnit"

local var_0_3 = ys.Battle.BattleHammerHeadWeaponUnit

function ys.Battle.BattleHammerHeadWeaponUnit.Ctor(arg_1_0)
	var_0_3.super.Ctor(arg_1_0)

	return
end

function ys.Battle.BattleHammerHeadWeaponUnit:DoAttack(arg_2_1)
	if self._tmpData.bullet_ID[1] then
		local var_2_0 = var_0_1.GetBulletTmpDataFromID(self._tmpData.bullet_ID[1]).type

		if var_2_0 == var_0_2.BulletType.DIRECT or var_2_0 == var_0_2.BulletType.ANTI_AIR or var_2_0 == var_0_2.BulletType.ANTI_SEA then
			local var_2_1 = self:Spawn(self._tmpData.bullet_ID[1], arg_2_1)

			var_2_1:SetDirectHitUnit(arg_2_1)
			self:DispatchBulletEvent(var_2_1)
		else
			var_0_3.super.DoAttack(self, arg_2_1)
			self._host:HandleDamageToDeath()

			return
		end
	end

	var_0_0.Battle.PlayBattleSFX(self._tmpData.fire_sfx)
	self:TriggerBuffOnFire()
	self:CheckAndShake()
	self._host:HandleDamageToDeath()

	return
end

return
