ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleUnitEvent
local var_0_2 = var_0.Battle

class = var_0_10003
var_0_2.BattleEnemyCharacter = var_0_10003("BattleEnemyCharacter", var_0.Battle.BattleCharacter)
var_0.Battle.BattleEnemyCharacter.__name = "BattleEnemyCharacter"

local var_0_3 = var_0.Battle.BattleEnemyCharacter

function var_0_3.Ctor(arg_1_0)
	var_0_3.super.Ctor(arg_1_0)

	arg_1_0._preCastBound = false
	Vector3 = var_1
	arg_1_0._prefabPos = var_1(0, 0, 0)

	return
end

function var_0_3.RegisterWeaponListener(arg_2_0, arg_2_1)
	var_0_3.super.RegisterWeaponListener(arg_2_0, arg_2_1)
	arg_2_1:RegisterEventListener(arg_2_0, var_0_1.WEAPON_PRE_CAST, arg_2_0.onWeaponPreCast)
	arg_2_1:RegisterEventListener(arg_2_0, var_0_1.WEAPON_PRE_CAST_FINISH, arg_2_0.onWeaponPrecastFinish)
	arg_2_1:RegisterEventListener(arg_2_0, var_0_1.WEAPON_INTERRUPT, arg_2_0.onWeaponInterrupted)

	return
end

function var_0_3.UnregisterWeaponListener(arg_3_0, arg_3_1)
	var_0_3.super.UnregisterWeaponListener(arg_3_0, arg_3_1)
	arg_3_1:UnregisterEventListener(arg_3_0, var_0_1.WEAPON_PRE_CAST)
	arg_3_1:UnregisterEventListener(arg_3_0, var_0_1.WEAPON_PRE_CAST_FINISH)
	arg_3_1:UnregisterEventListener(arg_3_0, var_0_1.WEAPON_INTERRUPT)

	return
end

function var_0_3.Update(arg_4_0)
	var_0_3.super.Update(arg_4_0)
	arg_4_0:UpdatePosition()
	arg_4_0:UpdateMatrix()
	arg_4_0:UpdateArrowBarPosition()
	arg_4_0:UpdateArrowBarRotation()

	if arg_4_0._vigilantBar then
		arg_4_0:UpdateVigilantBarPosition()

		local var_4_0 = arg_4_0._vigilantBar

		var_1.UpdateVigilantProgress(var_4_0)
	end

	return
end

function var_0_3.Dispose(arg_5_0)
	if arg_5_0._vigilantBar then
		local var_5_0 = arg_5_0._vigilantBar

		var_1.Dispose(var_5_0)

		arg_5_0._vigilantBar = nil
	end

	arg_5_0:AddShaderColor()

	local var_5_1 = arg_5_0._factory
	local var_5_2 = var_1.GetArrowPool(var_5_1)

	var_1.DestroyObj(var_5_2, arg_5_0._arrowBar)
	var_0_3.super.Dispose(arg_5_0)

	return
end

function var_0_3.GetModleID(arg_6_0)
	local var_6_0 = arg_6_0._unitData

	return var_1.GetTemplate(var_6_0).prefab
end

function var_0_3.onWeaponPreCast(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1.Data.fx

	arg_7_0:AddFX(var_7_0, true)

	arg_7_0._preCastBound = var_2.isBound

	return
end

function var_0_3.onWeaponPrecastFinish(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1.Data.fx

	arg_8_0:RemoveCacheFX(var_8_0)

	arg_8_0._preCastBound = false

	return
end

function var_0_3.OnUpdateHP(arg_9_0, arg_9_1)
	var_0_3.super.OnUpdateHP(arg_9_0, arg_9_1)

	if arg_9_1.Data.dHP <= 0 then
		arg_9_0:AddBlink(1, 1, 1, 0.1, 0.1, true)
	end

	return
end

function var_0_3.AddModel(arg_10_0, arg_10_1)
	var_0_3.super.AddModel(arg_10_0, arg_10_1)

	local var_10_0 = arg_10_0._unitData
	local var_10_1 = var_2.GetTemplate(var_10_0).hp_bar[2]

	Vector3 = var_10_0
	arg_10_0._hpBarOffset = var_10_0(0, var_10_1, 0)

	return
end

function var_0_3.GetSpecificFXScale(arg_11_0)
	local var_11_0 = arg_11_0._unitData

	return var_1.GetTemplate(var_11_0).specific_fx_scale
end

function var_0_3.OnAnimatorTrigger(arg_12_0)
	local var_12_0 = arg_12_0._unitData

	var_1.CharacterActionTriggerCallback(var_12_0)

	return
end

function var_0_3.OnAnimatorEnd(arg_13_0)
	local var_13_0 = arg_13_0._unitData

	var_1.CharacterActionEndCallback(var_13_0)

	return
end

function var_0_3.OnAnimatorStart(arg_14_0)
	local var_14_0 = arg_14_0._unitData

	var_1.CharacterActionStartCallback(var_14_0)

	return
end

function var_0_3.UpdateAimBiasBar(arg_15_0)
	var_0_3.super.UpdateAimBiasBar(arg_15_0)

	if arg_15_0._fogFx then
		local var_15_0 = arg_15_0:GetUnitData()
		local var_15_1 = var_1.GetAimBias(var_15_0)
		local var_15_2 = var_1.GetCurrentRate(var_15_1)
		local var_15_3 = arg_15_0._fogFx.transform

		Vector3 = var_1_10003
		var_15_3.localScale = var_1_10003(var_15_2, var_15_2, 1)
	end

	return
end

function var_0_3.getCharacterPos(arg_16_0)
	local var_16_0 = arg_16_0:GetUnitData()
	local var_16_1 = var_1.GetTemplate(var_16_0).prefab_offset
	local var_16_2 = arg_16_0._prefabPos

	var_2.Set(var_16_2, arg_16_0._characterPos.x + var_16_1[1], arg_16_0._characterPos.y + var_16_1[2], arg_16_0._characterPos.z + var_16_1[3])

	return arg_16_0._prefabPos
end

return
