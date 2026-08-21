ys = ys or {}

local var_0_0 = class("BattleSkillWeaponFire", ys.Battle.BattleSkillEffect)

ys.Battle.BattleSkillWeaponFire = var_0_0
var_0_0.__name = "BattleSkillWeaponFire"

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1, lv)

	arg_1_0._weaponType = arg_1_0._tempData.arg_list.weaponType
	arg_1_0._useTempBullet = arg_1_0._tempData.arg_list.preShiftBullet

	return
end

function var_0_0.DoDataEffect(arg_2_0, arg_2_1, arg_2_2)
	for iter_2_0, iter_2_1 in ipairs((arg_2_0:_GetWeapon(arg_2_1))) do
		iter_2_1:SingleFire(arg_2_2, nil, nil, arg_2_0._useTempBullet)
	end

	return
end

function var_0_0.DoDataEffectWithoutTarget(arg_3_0, arg_3_1)
	arg_3_0:DoDataEffect(arg_3_1, nil)

	return
end

function var_0_0._GetWeapon(arg_4_0, arg_4_1)
	if arg_4_0._weaponType == "ChargeWeapon" then
		table.insert({}, arg_4_1:GetChargeList()[1])
	elseif arg_4_0._weaponType == "TorpedoWeapon" then
		table.insert({}, arg_4_1:GetTorpedoList()[1])
	elseif arg_4_0._weaponType == "AirAssist" then
		table.insert({}, arg_4_1:GetAirAssistList()[1])
	elseif arg_4_0._weaponType == "Aircraft" then
		for iter_4_0, iter_4_1 in ipairs((arg_4_1:GetHiveList())) do
			table.insert({}, iter_4_1)
		end
	else
		table.insert({}, arg_4_1:GetAutoWeapons()[1])
	end

	return {}
end

return
