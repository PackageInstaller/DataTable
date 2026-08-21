ys = ys or {}

local var_0_1 = ys.Battle.BattleConst
local var_0_2 = class("BattleSkillFireSupport", ys.Battle.BattleSkillEffect)

ys.Battle.BattleSkillFireSupport = var_0_2
var_0_2.__name = "BattleSkillFireSupport"

function var_0_2.Ctor(arg_1_0, arg_1_1)
	var_0_2.super.Ctor(arg_1_0, arg_1_1, lv)

	arg_1_0._weaponID = arg_1_0._tempData.arg_list.weapon_id
	arg_1_0._supportTargetFilter = arg_1_0._tempData.arg_list.supportTarget.targetChoice
	arg_1_0._supportTargetArgList = arg_1_0._tempData.arg_list.supportTarget.arg_list

	return
end

function var_0_2.DoDataEffect(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_0._weapon == nil then
		local var_2_0

		for iter_2_0, iter_2_1 in ipairs(arg_2_0._supportTargetFilter) do
			var_2_0 = var_0.Battle.BattleTargetChoise[iter_2_1](arg_2_1, arg_2_0._supportTargetArgList, var_2_0)
		end

		arg_2_0._weapon = var_0.Battle.BattleDataFunction.CreateWeaponUnit(arg_2_0._weaponID, arg_2_1)

		if BATTLE_DEBUG and (arg_2_0._weapon:GetType() == var_0_1.EquipmentType.INTERCEPT_AIRCRAFT or arg_2_0._weapon:GetType() == var_0_1.EquipmentType.STRIKE_AIRCRAFT) then
			arg_2_0._weapon:GetATKAircraftList()
		end

		if var_2_0[1] then
			arg_2_0._weapon:SetStandHost(var_2_0[1])
		end

		arg_2_1:DispatchEvent((var_0.Event.New(var_0.Battle.BattleUnitEvent.CREATE_TEMPORARY_WEAPON, {
			weapon = arg_2_0._weapon
		})))
	end

	local function var_2_1()
		arg_2_0._weapon:Clear()

		return
	end

	arg_2_0._weapon:updateMovementInfo()
	arg_2_0._weapon:SingleFire(arg_2_2, arg_2_0._emitter, var_2_1)

	return
end

function var_0_2.DoDataEffectWithoutTarget(arg_4_0, arg_4_1)
	arg_4_0:DoDataEffect(arg_4_1)

	return
end

function var_0_2.Clear(arg_5_0)
	var_0_2.super.Clear(arg_5_0)

	if arg_5_0._weapon then
		if not arg_5_0._weapon:GetHost():IsAlive() then
			arg_5_0._weapon:Clear()
		end
	end

	return
end

function var_0_2.Interrupt(arg_6_0)
	var_0_2.super.Interrupt(arg_6_0)

	if arg_6_0._weapon then
		arg_6_0._weapon:Cease()
		arg_6_0._weapon:Clear()
	end

	return
end

function var_0_2.GetDamageSum(arg_7_0)
	local var_7_0 = 0

	if not arg_7_0._weapon then
		var_7_0 = 0
	elseif arg_7_0._weapon:GetType() == var_0_1.EquipmentType.INTERCEPT_AIRCRAFT or arg_7_0._weapon:GetType() == var_0_1.EquipmentType.STRIKE_AIRCRAFT then
		for iter_7_0, iter_7_1 in ipairs(arg_7_0._weapon:GetATKAircraftList()) do
			for iter_7_2, iter_7_3 in ipairs((iter_7_1:GetWeapon())) do
				var_7_0 = var_7_0 + iter_7_3:GetDamageSUM()
			end
		end
	else
		var_7_0 = arg_7_0._weapon:GetDamageSUM()
	end

	return var_7_0
end

return
