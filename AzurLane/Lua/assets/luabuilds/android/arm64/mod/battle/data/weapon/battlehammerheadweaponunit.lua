ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleDataFunction
local var_0_2 = var_0.Battle.BattleConst
local var_0_3 = var_0.Battle

class = var_0_10004
var_0_3.BattleHammerHeadWeaponUnit = var_0_10004("BattleHammerHeadWeaponUnit", var_0.Battle.BattleWeaponUnit)
var_0.Battle.BattleHammerHeadWeaponUnit.__name = "BattleHammerHeadWeaponUnit"

local var_0_4 = var_0.Battle.BattleHammerHeadWeaponUnit

function var_0_4.Ctor(arg_1_0)
	var_0_4.super.Ctor(arg_1_0)

	return
end

function var_0_4.DoAttack(arg_2_0, arg_2_1)
	if arg_2_0._tmpData.bullet_ID[1] then
		if var_0_1.GetBulletTmpDataFromID(arg_2_0._tmpData.bullet_ID[1]).type == var_0_2.BulletType.DIRECT or var_2 == var_0_2.BulletType.ANTI_AIR or var_2 == var_0_2.BulletType.ANTI_SEA then
			local var_2_0 = arg_2_0:Spawn(arg_2_0._tmpData.bullet_ID[1], arg_2_1)

			var_3.SetDirectHitUnit(var_2_0, arg_2_1)
			arg_2_0:DispatchBulletEvent(var_3)
		else
			var_0_4.super.DoAttack(arg_2_0, arg_2_1)

			local var_2_1 = arg_2_0._host

			var_3.HandleDamageToDeath(var_2_1)

			return
		end
	end

	var_0.Battle.PlayBattleSFX(arg_2_0._tmpData.fire_sfx)
	arg_2_0:TriggerBuffOnFire()
	arg_2_0:CheckAndShake()

	local var_2_2 = arg_2_0._host

	var_2.HandleDamageToDeath(var_2_2)

	return
end

return
