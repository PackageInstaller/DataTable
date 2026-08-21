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

function ys.Battle.BattleHammerHeadWeaponUnit.DoAttack(arg_2_0, arg_2_1)
	if arg_2_0._tmpData.bullet_ID[1] then
		local var_2_0 = var_0_1.GetBulletTmpDataFromID(arg_2_0._tmpData.bullet_ID[1]).type

		if var_2_0 == var_0_2.BulletType.DIRECT or var_2_0 == var_0_2.BulletType.ANTI_AIR or var_2_0 == var_0_2.BulletType.ANTI_SEA then
			local var_2_1 = arg_2_0:Spawn(arg_2_0._tmpData.bullet_ID[1], arg_2_1)

			var_2_1:SetDirectHitUnit(arg_2_1)
			arg_2_0:DispatchBulletEvent(var_2_1)
		else
			var_0_3.super.DoAttack(arg_2_0, arg_2_1)
			arg_2_0._host:HandleDamageToDeath()

			return
		end
	end

	var_0_0.Battle.PlayBattleSFX(arg_2_0._tmpData.fire_sfx)
	arg_2_0:TriggerBuffOnFire()
	arg_2_0:CheckAndShake()
	arg_2_0._host:HandleDamageToDeath()

	return
end

return
