ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleDataFunction
local var_0_2 = var_0.Battle.BattleFormulas
local var_0_3 = var_0.Battle.BattleAttr
local var_0_4 = var_0.Battle.BattleConst.EquipmentType
local var_0_5 = var_0.Battle.BattleConfig
local var_0_6 = var_0.Battle

class = var_0_10008
var_0_6.BattleSubUnit = var_0_10008("BattleSubUnit", var_0.Battle.BattlePlayerUnit)
var_0.Battle.BattleSubUnit.__name = "BattleSubUnit"

local var_0_7 = var_0.Battle.BattleSubUnit

function var_0_7.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_7.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0._type = var_0.UnitType.PLAYER_UNIT

	return
end

function var_0_7.setWeapon(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0._tmpData.default_equip_list
	local var_2_1 = arg_2_0._tmpData.base_list
	local var_2_2 = arg_2_0._proficiencyList
	local var_2_3 = arg_2_0._tmpData.preload_count
	local var_2_4 = 0

	ipairs = var_1_10007

	for iter_2_0, iter_2_1 in var_1_10007(arg_2_1) do
		Ship = var_1_10012

		if var_1_10012.WEAPON_COUNT < iter_2_0 and iter_2_1 then
			var_2_4 = var_2_4 + iter_2_1.torpedoAmmo
		end
	end

	local var_2_5 = {}

	ipairs = var_8

	for iter_2_2, iter_2_3 in var_8(arg_2_1) do
		if iter_2_3 and iter_2_3.skin and iter_2_3.skin ~= 0 then
			Equipment = var_1_10013

			if var_1_10013.IsOrbitSkin(iter_2_3.skin) then
				if not arg_2_0._orbitSkinIDList then
					var_1_10013 = {}
				end

				arg_2_0._orbitSkinIDList = var_1_10013
				table = var_1_10013

				var_1_10013.insert(arg_2_0._orbitSkinIDList, iter_2_3.skin)
			end
		end

		Ship = var_1_10013

		if iter_2_2 <= var_1_10013.WEAPON_COUNT then
			var_1_10013 = var_2_2[iter_2_2]

			local function var_2_6(arg_3_0, arg_3_1, arg_3_2)
				if var_0_1.GetWeaponPropertyDataFromID(arg_3_0).type == var_0.EquipmentType.TORPEDO then
					return var_3.torpedo_ammo
				else
					local var_3_0 = var_2_1[iter_2_2]

					for iter_3_0 = 1, var_3_0 do
						local var_3_1 = arg_2_0

						var_10.AddWeapon(var_3_1, arg_3_0, arg_3_1, arg_3_2, var_1_10013, iter_2_2)
					end

					return false
				end

				return
			end

			if iter_2_3.equipment then
				local var_2_7 = iter_2_3.equipment.weapon_id

				ipairs = var_1_10016

				for iter_2_4, iter_2_5 in var_1_10016(var_2_7) do
					if iter_2_5 and iter_2_5 ~= -1 and var_2_6(iter_2_5, iter_2_3.equipment.label, iter_2_3.skin) then
						table = var_22

						var_22.insert(var_2_5, {
							id = iter_2_5,
							ammo = var_21,
							index = iter_2_2
						})
					end
				end
			else
				local var_2_8 = var_2_0[iter_2_2]

				if var_2_6(var_2_8) then
					table = var_17

					var_17.insert(var_2_5, {
						id = var_2_8,
						ammo = var_1_10016,
						index = iter_2_2
					})
				end
			end
		end
	end

	local function var_2_9(arg_4_0, arg_4_1)
		local var_4_0 = arg_2_1[arg_4_1]
		local var_4_1
		local var_4_2

		if var_4_0.equipment then
			var_4_1 = var_4_0.equipment.label
			var_4_2 = var_4_0.skin
		end

		local var_4_3 = var_2_2[arg_4_1]
		local var_4_4 = arg_2_0
		local var_4_5 = var_6.AddDisposableTorpedo(var_4_4, arg_4_0, var_4_1, var_4_2, var_4_3, arg_4_1)

		var_6.SetModifyInitialCD(var_4_5)

		return
	end

	repeat
		local var_2_10 = 0

		ipairs = var_10

		for iter_2_6, iter_2_7 in var_10(var_2_5) do
			if iter_2_7.ammo <= 0 and var_2_4 > 0 then
				iter_2_7.ammo = iter_2_7.ammo + 1
				var_2_4 = var_2_4 - 1
			end

			if iter_2_7.ammo > 0 then
				var_2_9(iter_2_7.id, iter_2_7.index)

				iter_2_7.ammo = iter_2_7.ammo - 1
			end

			var_2_10 = var_2_10 + iter_2_7.ammo
		end
	until var_2_10 == 0 and var_2_4 == 0

	return
end

function var_0_7.AddDisposableTorpedo(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5)
	local var_5_0 = var_0.Battle.BattleDataFunction.CreateWeaponUnit(arg_5_1, arg_5_0, arg_5_4, arg_5_5, var_0.EquipmentType.DISPOSABLE_TORPEDO)

	arg_5_0._totalWeapon[#arg_5_0._totalWeapon + 1] = var_5_0

	if arg_5_2 then
		var_5_0:SetEquipmentLabel(arg_5_2)
	end

	arg_5_0._manualTorpedoList[#arg_5_0._manualTorpedoList + 1] = var_5_0

	local var_5_1 = arg_5_0._weaponQueue

	var_7.AppendManualTorpedo(var_5_1, var_5_0)

	if arg_5_3 and arg_5_3 ~= 0 then
		var_5_0:SetSkinData(arg_5_3)
		arg_5_0:SetPriorityWeaponSkin(arg_5_3)
	end

	return var_5_0
end

return
