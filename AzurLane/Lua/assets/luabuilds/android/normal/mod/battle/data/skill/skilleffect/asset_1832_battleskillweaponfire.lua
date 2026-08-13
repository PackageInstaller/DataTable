ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys
class = var_0_10001

local var_0_1 = var_0_10001("BattleSkillWeaponFire", var_0.Battle.BattleSkillEffect)

var_0.Battle.BattleSkillWeaponFire = var_0_1
var_0_1.__name = "BattleSkillWeaponFire"

function var_0_1.Ctor(arg_1_0, arg_1_1)
	local var_1_0 = var_0_1.super.Ctor
	local var_1_1 = arg_1_0
	local var_1_2 = arg_1_1

	lv = var_1_10005

	var_1_0(var_1_1, var_1_2, var_1_10005)

	arg_1_0._weaponType = arg_1_0._tempData.arg_list.weaponType
	arg_1_0._useTempBullet = arg_1_0._tempData.arg_list.preShiftBullet

	return
end

function var_0_1.DoDataEffect(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0._GetWeapon(var_2_0, arg_2_1)

	ipairs = var_2_0

	for iter_2_0, iter_2_1 in var_2_0(var_2_1) do
		iter_2_1:SingleFire(arg_2_2, nil, nil, arg_2_0._useTempBullet)
	end

	return
end

function var_0_1.DoDataEffectWithoutTarget(arg_3_0, arg_3_1)
	arg_3_0:DoDataEffect(arg_3_1, nil)

	return
end

function var_0_1._GetWeapon(arg_4_0, arg_4_1)
	local var_4_0 = {}

	if arg_4_0._weaponType == "ChargeWeapon" then
		table = var_3

		var_3.insert(var_4_0, arg_4_1:GetChargeList()[1])
	elseif arg_4_0._weaponType == "TorpedoWeapon" then
		table = var_3

		var_3.insert(var_4_0, arg_4_1:GetTorpedoList()[1])
	elseif arg_4_0._weaponType == "AirAssist" then
		table = var_3

		var_3.insert(var_4_0, arg_4_1:GetAirAssistList()[1])
	else
		local var_4_2

		if arg_4_0._weaponType == "Aircraft" then
			local var_4_1 = arg_4_1

			var_4_2 = arg_4_1.GetHiveList(var_4_1)
			ipairs = var_4_1

			for iter_4_0, iter_4_1 in var_4_1(var_4_2) do
				table = var_1_10009

				var_1_10009.insert(var_4_0, iter_4_1)
			end
		else
			table = var_4_2

			var_4_2.insert(var_4_0, arg_4_1:GetAutoWeapons()[1])
		end
	end

	return var_4_0
end

return
