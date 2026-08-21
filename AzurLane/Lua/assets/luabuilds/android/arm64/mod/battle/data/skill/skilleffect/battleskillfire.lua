ys = ys or {}

local var_0_0 = ys.Battle.BattleDataFunction
local var_0_1 = ys.Battle.BattleConst
local var_0_2 = class("BattleSkillFire", ys.Battle.BattleSkillEffect)

ys.Battle.BattleSkillFire = var_0_2
var_0_2.__name = "BattleSkillFire"

function var_0_2.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_2.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0._weaponID = arg_1_0._tempData.arg_list.weapon_id
	arg_1_0._emitter = arg_1_0._tempData.arg_list.emitter
	arg_1_0._useSkin = arg_1_0._tempData.arg_list.useSkin
	arg_1_0._equipIndex = arg_1_0._tempData.arg_list.equip_index or -1
	arg_1_0._atkAttrConvert = arg_1_0._tempData.arg_list.attack_attribute_convert

	return
end

function var_0_2.SetWeaponSkin(arg_2_0, arg_2_1)
	arg_2_0._modelID = arg_2_1

	return
end

function var_0_2.IsFinaleEffect(arg_3_0)
	return true
end

function var_0_2.DoDataEffect(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_0._weapon == nil then
		arg_4_0._weapon = var_0.Battle.BattleDataFunction.CreateWeaponUnit(arg_4_0._weaponID, arg_4_1, nil, arg_4_0._equipIndex)

		if BATTLE_DEBUG and (arg_4_0._weapon:GetType() == var_0_1.EquipmentType.INTERCEPT_AIRCRAFT or arg_4_0._weapon:GetType() == var_0_1.EquipmentType.STRIKE_AIRCRAFT) then
			arg_4_0._weapon:GetATKAircraftList()
			arg_4_0._weapon:GetDEFAircraftList()
		end

		if arg_4_0._modelID then
			arg_4_0._weapon:SetModelID(arg_4_0._modelID)
		elseif arg_4_0._useSkin then
			local var_4_0 = arg_4_1:GetPriorityWeaponSkin()

			if var_4_0 then
				arg_4_0._weapon:SetModelID(var_0_0.GetEquipSkin(var_4_0))
			end
		end

		arg_4_1:DispatchEvent((var_0.Event.New(var_0.Battle.BattleUnitEvent.CREATE_TEMPORARY_WEAPON, {
			weapon = arg_4_0._weapon
		})))
	end

	local function var_4_1()
		arg_4_0._weapon:Clear()

		if arg_4_0._finaleCallback then
			arg_4_0._finaleCallback()
		end

		return
	end

	if arg_4_0._atkAttrConvert then
		arg_4_0._weapon:SetAtkAttrTrasnform(arg_4_0._atkAttrConvert.attr_type, arg_4_0._atkAttrConvert.A, arg_4_0._atkAttrConvert.B)
	end

	arg_4_0._weapon:updateMovementInfo()
	arg_4_0._weapon:SingleFire(arg_4_2, arg_4_0._emitter, var_4_1)

	return
end

function var_0_2.DoDataEffectWithoutTarget(arg_6_0, arg_6_1)
	arg_6_0:DoDataEffect(arg_6_1)

	return
end

function var_0_2.Clear(arg_7_0)
	var_0_2.super.Clear(arg_7_0)

	if arg_7_0._weapon then
		if not arg_7_0._weapon:GetHost():IsAlive() then
			arg_7_0._weapon:Clear()
		end
	end

	return
end

function var_0_2.Interrupt(arg_8_0)
	var_0_2.super.Interrupt(arg_8_0)

	if arg_8_0._weapon then
		arg_8_0._weapon:Cease()
		arg_8_0._weapon:Clear()
	end

	return
end

function var_0_2.GetDamageSum(arg_9_0)
	local var_9_0 = 0

	if not arg_9_0._weapon then
		var_9_0 = 0
	elseif arg_9_0._weapon:GetType() == var_0_1.EquipmentType.INTERCEPT_AIRCRAFT or arg_9_0._weapon:GetType() == var_0_1.EquipmentType.STRIKE_AIRCRAFT then
		for iter_9_0, iter_9_1 in ipairs(arg_9_0._weapon:GetATKAircraftList()) do
			for iter_9_2, iter_9_3 in ipairs((iter_9_1:GetWeapon())) do
				var_9_0 = var_9_0 + iter_9_3:GetDamageSUM()
			end
		end
	else
		var_9_0 = arg_9_0._weapon:GetDamageSUM()
	end

	return var_9_0
end

return
