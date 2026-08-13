ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConst
local var_0_2 = var_0.Battle.BattleDataFunction

class = var_0_10003

local var_0_3 = var_0_10003("BattleBuffNewWeapon", var_0.Battle.BattleBuffEffect)

var_0.Battle.BattleBuffNewWeapon = var_0_3
var_0_3.__name = "BattleBuffNewWeapon"

function var_0_3.Ctor(arg_1_0, arg_1_1)
	var_0_3.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_3.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._weaponID = arg_2_0._tempData.arg_list.weapon_id
	arg_2_0._reverse = arg_2_0._tempData.arg_list.reverse

	return
end

function var_0_3.onAttach(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_0._reverse then
		arg_3_1:RemoveAutoWeaponByWeaponID(arg_3_0._weaponID)
	elseif var_0_2.GetWeaponPropertyDataFromID(arg_3_0._weaponID).type == var_0_1.EquipmentType.FLEET_ANTI_AIR then
		arg_3_1:AddWeapon(arg_3_0._weaponID)

		local var_3_0 = arg_3_1:GetFleetVO()
		local var_3_1 = var_4.GetFleetAntiAirWeapon(var_3_0)

		var_4.FlushCrewUnit(var_3_1, arg_3_1)
	else
		arg_3_0._weapon = arg_3_1:AddNewAutoWeapon(arg_3_0._weaponID)
	end

	return
end

function var_0_3.onRemove(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_0._reverse then
		arg_4_1:AddNewAutoWeapon(arg_4_0._weaponID)
	elseif arg_4_0._weapon then
		if var_0_2.GetWeaponPropertyDataFromID(arg_4_0._weaponID).type == var_0_1.EquipmentType.FLEET_ANTI_AIR then
			arg_4_1:RemoveWeapon(arg_4_0._weaponID)
			arg_4_1:RemoveFleetAntiAirWeapon(arg_4_0._weapon)

			local var_4_0 = arg_4_1:GetFleetVO()
			local var_4_1 = var_4.GetFleetAntiAirWeapon(var_4_0)

			var_4.FlushCrewUnit(var_4_1, arg_4_1)
		else
			local var_4_2 = arg_4_0._weapon

			var_4.Clear(var_4_2)
			arg_4_1:RemoveAutoWeapon(arg_4_0._weapon)
		end
	end

	return
end

function var_0_3.Dispose(arg_5_0)
	var_0_3.super.Dispose(arg_5_0)

	arg_5_0._weapon = nil

	return
end

return
