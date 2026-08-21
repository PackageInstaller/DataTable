ys = ys or {}

local var_0_0 = ys.Battle.BattleDataFunction
local var_0_1 = ys.Battle.BattleCardPuzzleFormulas
local var_0_3 = class("BattleCardPuzzleSkillFire", ys.Battle.BattleCardPuzzleSkillEffect)

ys.Battle.BattleCardPuzzleSkillFire = var_0_3
var_0_3.__name = "BattleCardPuzzleSkillFire"

function var_0_3.Ctor(arg_1_0, arg_1_1)
	var_0_3.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0._weaponID = arg_1_0._tempData.arg_list.weapon_id
	arg_1_0._emitter = arg_1_0._tempData.arg_list.emitter
	arg_1_0._useSkin = arg_1_0._tempData.arg_list.useSkin
	arg_1_0._enhance = arg_1_0._tempData.arg_list.enhance_formula

	return
end

function var_0_3.SetWeaponSkin(arg_2_0, arg_2_1)
	arg_2_0._modelID = arg_2_1

	return
end

function var_0_3.SkillEffectHandler(arg_3_0)
	if arg_3_0._weapon == nil then
		arg_3_0._weapon = var_0.Battle.BattleDataFunction.CreateWeaponUnit(arg_3_0._weaponID, arg_3_0._caster)

		if arg_3_0._modelID then
			arg_3_0._weapon:SetModelID(arg_3_0._modelID)
		elseif arg_3_0._useSkin then
			local var_3_0 = arg_3_0._caster:GetPriorityWeaponSkin()

			if var_3_0 then
				arg_3_0._weapon:SetModelID(var_0_0.GetEquipSkin(var_3_0))
			end
		end

		arg_3_0._caster:DispatchEvent((var_0.Event.New(var_0.Battle.BattleUnitEvent.CREATE_TEMPORARY_WEAPON, {
			weapon = arg_3_0._weapon
		})))
	end

	local function var_3_1()
		arg_3_0._weapon:Clear()
		arg_3_0:Finale()

		return
	end

	if arg_3_0._enhance then
		arg_3_0._weapon:SetCardPuzzleDamageEnhance((var_0_1.parseFormula(arg_3_0._enhance, arg_3_0:GetCardPuzzleComponent():GetAttrManager())))
	end

	arg_3_0._weapon:updateMovementInfo()

	local var_3_2 = arg_3_0:GetTarget()

	if #var_3_2 > 0 then
		for iter_3_0, iter_3_1 in ipairs(var_3_2) do
			arg_3_0._weapon:SingleFire(iter_3_1, arg_3_0._emitter, var_3_1)
		end
	else
		arg_3_0._weapon:SingleFire(nil, arg_3_0._emitter, var_3_1)
	end

	return
end

function var_0_3.Clear(arg_5_0)
	var_0_3.super.Clear(arg_5_0)

	if arg_5_0._weapon then
		if not arg_5_0._weapon:GetHost():IsAlive() then
			arg_5_0._weapon:Clear()
		end
	end

	return
end

function var_0_3.Interrupt(arg_6_0)
	var_0_3.super.Interrupt(arg_6_0)

	if arg_6_0._weapon then
		arg_6_0._weapon:Cease()
		arg_6_0._weapon:Clear()
	end

	return
end

return
