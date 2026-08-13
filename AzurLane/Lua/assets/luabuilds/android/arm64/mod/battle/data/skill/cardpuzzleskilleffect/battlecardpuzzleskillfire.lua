ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleDataFunction
local var_0_2 = var_0.Battle.BattleCardPuzzleFormulas
local var_0_3 = var_0.Battle.BattleConst

class = var_0_10004

local var_0_4 = var_0_10004("BattleCardPuzzleSkillFire", var_0.Battle.BattleCardPuzzleSkillEffect)

var_0.Battle.BattleCardPuzzleSkillFire = var_0_4
var_0_4.__name = "BattleCardPuzzleSkillFire"

function var_0_4.Ctor(arg_1_0, arg_1_1)
	var_0_4.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0._weaponID = arg_1_0._tempData.arg_list.weapon_id
	arg_1_0._emitter = arg_1_0._tempData.arg_list.emitter
	arg_1_0._useSkin = arg_1_0._tempData.arg_list.useSkin
	arg_1_0._enhance = arg_1_0._tempData.arg_list.enhance_formula

	return
end

function var_0_4.SetWeaponSkin(arg_2_0, arg_2_1)
	arg_2_0._modelID = arg_2_1

	return
end

function var_0_4.SkillEffectHandler(arg_3_0)
	if arg_3_0._weapon == nil then
		arg_3_0._weapon = var_0.Battle.BattleDataFunction.CreateWeaponUnit(arg_3_0._weaponID, arg_3_0._caster)

		if arg_3_0._modelID then
			local var_3_0 = arg_3_0._weapon

			var_1.SetModelID(var_3_0, arg_3_0._modelID)
		elseif arg_3_0._useSkin then
			local var_3_1 = arg_3_0._caster

			if var_1.GetPriorityWeaponSkin(var_3_1) then
				local var_3_2 = arg_3_0._weapon

				var_2.SetModelID(var_3_2, var_0_1.GetEquipSkin(var_1))
			end
		end

		local var_3_3 = {
			weapon = arg_3_0._weapon
		}
		local var_3_4 = var_0.Event.New(var_0.Battle.BattleUnitEvent.CREATE_TEMPORARY_WEAPON, var_3_3)
		local var_3_5 = arg_3_0._caster

		var_3.DispatchEvent(var_3_5, var_3_4)
	end

	local function var_3_6()
		local var_4_0 = arg_3_0._weapon

		var_0.Clear(var_4_0)

		local var_4_1 = arg_3_0

		var_0.Finale(var_4_1)

		return
	end

	if arg_3_0._enhance then
		local var_3_7 = var_0_2.parseFormula
		local var_3_8 = arg_3_0._enhance
		local var_3_9 = arg_3_0:GetCardPuzzleComponent()
		local var_3_10 = var_3_7(var_3_8, var_5.GetAttrManager(var_3_9))
		local var_3_11 = arg_3_0._weapon

		var_3.SetCardPuzzleDamageEnhance(var_3_11, var_3_10)
	end

	local var_3_12 = arg_3_0._weapon

	var_2.updateMovementInfo(var_3_12)

	if #arg_3_0:GetTarget() > 0 then
		ipairs = var_3

		for iter_3_0, iter_3_1 in var_3(var_2) do
			local var_3_13 = arg_3_0._weapon

			var_8.SingleFire(var_3_13, iter_3_1, arg_3_0._emitter, var_3_6)
		end
	else
		local var_3_14 = arg_3_0._weapon

		var_3.SingleFire(var_3_14, nil, arg_3_0._emitter, var_3_6)
	end

	return
end

function var_0_4.Clear(arg_5_0)
	var_0_4.super.Clear(arg_5_0)

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

function var_0_4.Interrupt(arg_6_0)
	var_0_4.super.Interrupt(arg_6_0)

	if arg_6_0._weapon then
		local var_6_0 = arg_6_0._weapon

		var_1.Cease(var_6_0)

		local var_6_1 = arg_6_0._weapon

		var_1.Clear(var_6_1)
	end

	return
end

return
