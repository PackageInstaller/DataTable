ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleDataFunction
local var_0_2 = var_0.Battle.BattleConst

class = var_0_10003

local var_0_3 = var_0_10003("BattleSkillFire", var_0.Battle.BattleSkillEffect)

var_0.Battle.BattleSkillFire = var_0_3
var_0_3.__name = "BattleSkillFire"

function var_0_3.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_3.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0._weaponID = arg_1_0._tempData.arg_list.weapon_id
	arg_1_0._emitter = arg_1_0._tempData.arg_list.emitter
	arg_1_0._useSkin = arg_1_0._tempData.arg_list.useSkin

	local var_1_0

	if not arg_1_0._tempData.arg_list.equip_index then
		var_1_0 = -1
	end

	arg_1_0._equipIndex = var_1_0
	arg_1_0._atkAttrConvert = arg_1_0._tempData.arg_list.attack_attribute_convert

	return
end

function var_0_3.SetWeaponSkin(arg_2_0, arg_2_1)
	arg_2_0._modelID = arg_2_1

	return
end

function var_0_3.IsFinaleEffect(arg_3_0)
	return true
end

function var_0_3.DoDataEffect(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_0._weapon == nil then
		arg_4_0._weapon = var_0.Battle.BattleDataFunction.CreateWeaponUnit(arg_4_0._weaponID, arg_4_1, nil, arg_4_0._equipIndex)
		BATTLE_DEBUG = var_3

		if var_3 then
			local var_4_0 = arg_4_0._weapon

			if var_3.GetType(var_4_0) ~= var_0_2.EquipmentType.INTERCEPT_AIRCRAFT then
				local var_4_1 = arg_4_0._weapon

				if var_3.GetType(var_4_1) == var_0_2.EquipmentType.STRIKE_AIRCRAFT then
					local var_4_2 = arg_4_0._weapon

					var_3.GetATKAircraftList(var_4_2)

					local var_4_3 = arg_4_0._weapon

					var_3.GetDEFAircraftList(var_4_3)
				end

				if arg_4_0._modelID then
					local var_4_4 = arg_4_0._weapon

					var_3.SetModelID(var_4_4, arg_4_0._modelID)
				elseif arg_4_0._useSkin and arg_4_1:GetPriorityWeaponSkin() then
					local var_4_5 = arg_4_0._weapon

					var_4.SetModelID(var_4_5, var_0_1.GetEquipSkin(var_3))
				end

				local var_4_6 = {
					weapon = arg_4_0._weapon
				}
				local var_4_7 = var_0.Event.New(var_0.Battle.BattleUnitEvent.CREATE_TEMPORARY_WEAPON, var_4_6)

				arg_4_1:DispatchEvent(var_4_7)

				local function var_4_8()
					local var_5_0 = arg_4_0._weapon

					var_0.Clear(var_5_0)

					if arg_4_0._finaleCallback then
						arg_4_0._finaleCallback()
					end

					return
				end

				if arg_4_0._atkAttrConvert then
					local var_4_9 = arg_4_0._weapon

					var_4.SetAtkAttrTrasnform(var_4_9, arg_4_0._atkAttrConvert.attr_type, arg_4_0._atkAttrConvert.A, arg_4_0._atkAttrConvert.B)
				end

				local var_4_10 = arg_4_0._weapon

				var_4.updateMovementInfo(var_4_10)

				local var_4_11 = arg_4_0._weapon

				var_4.SingleFire(var_4_11, arg_4_2, arg_4_0._emitter, var_4_8)

				return
			end
		end
	end
end

function var_0_3.DoDataEffectWithoutTarget(arg_6_0, arg_6_1)
	arg_6_0:DoDataEffect(arg_6_1)

	return
end

function var_0_3.Clear(arg_7_0)
	var_0_3.super.Clear(arg_7_0)

	if arg_7_0._weapon then
		local var_7_0 = arg_7_0._weapon
		local var_7_1 = var_1.GetHost(var_7_0)

		if not var_1.IsAlive(var_7_1) then
			local var_7_2 = arg_7_0._weapon

			var_1.Clear(var_7_2)
		end
	end

	return
end

function var_0_3.Interrupt(arg_8_0)
	var_0_3.super.Interrupt(arg_8_0)

	if arg_8_0._weapon then
		local var_8_0 = arg_8_0._weapon

		var_1.Cease(var_8_0)

		local var_8_1 = arg_8_0._weapon

		var_1.Clear(var_8_1)
	end

	return
end

function var_0_3.GetDamageSum(arg_9_0)
	local var_9_0 = 0

	if not arg_9_0._weapon then
		var_9_0 = 0

		goto label_9_0
	end

	local var_9_1 = arg_9_0._weapon

	if var_2.GetType(var_9_1) ~= var_0_2.EquipmentType.INTERCEPT_AIRCRAFT then
		do
			local var_9_2 = arg_9_0._weapon

			if var_2.GetType(var_9_2) == var_0_2.EquipmentType.STRIKE_AIRCRAFT then
				ipairs = var_2

				local var_9_3 = arg_9_0._weapon

				for iter_9_0, iter_9_1 in var_2(var_3.GetATKAircraftList(var_9_3)) do
					local var_9_4 = iter_9_1
					local var_9_5 = iter_9_1.GetWeapon(var_9_4)

					ipairs = var_9_4

					for iter_9_2, iter_9_3 in var_9_4(var_9_5) do
						var_9_0 = var_9_0 + iter_9_3:GetDamageSUM()
					end
				end
			else
				local var_9_6 = arg_9_0._weapon

				var_9_0 = var_2.GetDamageSUM(var_9_6)
			end
		end

		::label_9_0::

		return var_9_0
	end
end

return
