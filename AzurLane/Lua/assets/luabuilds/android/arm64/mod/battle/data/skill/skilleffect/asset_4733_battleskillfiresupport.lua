ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleDataFunction
local var_0_2 = var_0.Battle.BattleConst

class = var_0_10003

local var_0_3 = var_0_10003("BattleSkillFireSupport", var_0.Battle.BattleSkillEffect)

var_0.Battle.BattleSkillFireSupport = var_0_3
var_0_3.__name = "BattleSkillFireSupport"

function var_0_3.Ctor(arg_1_0, arg_1_1)
	local var_1_0 = var_0_3.super.Ctor
	local var_1_1 = arg_1_0
	local var_1_2 = arg_1_1

	lv = var_1_10006

	var_1_0(var_1_1, var_1_2, var_1_10006)

	arg_1_0._weaponID = arg_1_0._tempData.arg_list.weapon_id
	arg_1_0._supportTargetFilter = arg_1_0._tempData.arg_list.supportTarget.targetChoice
	arg_1_0._supportTargetArgList = arg_1_0._tempData.arg_list.supportTarget.arg_list

	return
end

function var_0_3.DoDataEffect(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_0._weapon == nil then
		local var_2_0

		ipairs = var_1_10004

		for iter_2_0, iter_2_1 in var_1_10004(arg_2_0._supportTargetFilter) do
			var_2_0 = var_0.Battle.BattleTargetChoise[iter_2_1](arg_2_1, arg_2_0._supportTargetArgList, var_2_0)
		end

		local var_2_1 = var_2_0[1]

		arg_2_0._weapon = var_0.Battle.BattleDataFunction.CreateWeaponUnit(arg_2_0._weaponID, arg_2_1)
		BATTLE_DEBUG = var_5

		if var_5 then
			local var_2_2 = arg_2_0._weapon

			if var_5.GetType(var_2_2) ~= var_0_2.EquipmentType.INTERCEPT_AIRCRAFT then
				local var_2_3 = arg_2_0._weapon

				if var_5.GetType(var_2_3) == var_0_2.EquipmentType.STRIKE_AIRCRAFT then
					local var_2_4 = arg_2_0._weapon

					var_5.GetATKAircraftList(var_2_4)
				end

				if var_2_1 then
					local var_2_5 = arg_2_0._weapon

					var_5.SetStandHost(var_2_5, var_2_1)
				end

				local var_2_6 = {
					weapon = arg_2_0._weapon
				}
				local var_2_7 = var_0.Event.New(var_0.Battle.BattleUnitEvent.CREATE_TEMPORARY_WEAPON, var_2_6)

				arg_2_1:DispatchEvent(var_2_7)

				local function var_2_8()
					local var_3_0 = arg_2_0._weapon

					var_0.Clear(var_3_0)

					return
				end

				local var_2_9 = arg_2_0._weapon

				var_4.updateMovementInfo(var_2_9)

				local var_2_10 = arg_2_0._weapon

				var_4.SingleFire(var_2_10, arg_2_2, arg_2_0._emitter, var_2_8)

				return
			end
		end
	end
end

function var_0_3.DoDataEffectWithoutTarget(arg_4_0, arg_4_1)
	arg_4_0:DoDataEffect(arg_4_1)

	return
end

function var_0_3.Clear(arg_5_0)
	var_0_3.super.Clear(arg_5_0)

	if arg_5_0._weapon then
		local var_5_0 = arg_5_0._weapon
		local var_5_1 = var_1.GetHost(var_5_0)

		if not var_1.IsAlive(var_5_1) then
			local var_5_2 = arg_5_0._weapon

			var_1.Clear(var_5_2)
		end
	end

	return
end

function var_0_3.Interrupt(arg_6_0)
	var_0_3.super.Interrupt(arg_6_0)

	if arg_6_0._weapon then
		local var_6_0 = arg_6_0._weapon

		var_1.Cease(var_6_0)

		local var_6_1 = arg_6_0._weapon

		var_1.Clear(var_6_1)
	end

	return
end

function var_0_3.GetDamageSum(arg_7_0)
	local var_7_0 = 0

	if not arg_7_0._weapon then
		var_7_0 = 0

		goto label_7_0
	end

	local var_7_1 = arg_7_0._weapon

	if var_2.GetType(var_7_1) ~= var_0_2.EquipmentType.INTERCEPT_AIRCRAFT then
		do
			local var_7_2 = arg_7_0._weapon

			if var_2.GetType(var_7_2) == var_0_2.EquipmentType.STRIKE_AIRCRAFT then
				ipairs = var_2

				local var_7_3 = arg_7_0._weapon

				for iter_7_0, iter_7_1 in var_2(var_4.GetATKAircraftList(var_7_3)) do
					local var_7_4 = iter_7_1:GetWeapon()

					ipairs = var_1_10008

					for iter_7_2, iter_7_3 in var_1_10008(var_7_4) do
						var_7_0 = var_7_0 + iter_7_3:GetDamageSUM()
					end
				end
			else
				local var_7_5 = arg_7_0._weapon

				var_7_0 = var_2.GetDamageSUM(var_7_5)
			end
		end

		::label_7_0::

		return var_7_0
	end
end

return
