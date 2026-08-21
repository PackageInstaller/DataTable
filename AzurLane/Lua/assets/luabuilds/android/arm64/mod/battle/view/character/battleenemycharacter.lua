ys = ys or {}

local var_0_0 = ys.Battle.BattleUnitEvent

ys.Battle.BattleEnemyCharacter = class("BattleEnemyCharacter", ys.Battle.BattleCharacter)
ys.Battle.BattleEnemyCharacter.__name = "BattleEnemyCharacter"

local var_0_1 = ys.Battle.BattleEnemyCharacter

function ys.Battle.BattleEnemyCharacter.Ctor(arg_1_0)
	var_0_1.super.Ctor(arg_1_0)

	arg_1_0._preCastBound = false
	arg_1_0._prefabPos = Vector3(0, 0, 0)

	return
end

function ys.Battle.BattleEnemyCharacter.RegisterWeaponListener(arg_2_0, arg_2_1)
	var_0_1.super.RegisterWeaponListener(arg_2_0, arg_2_1)
	arg_2_1:RegisterEventListener(arg_2_0, var_0_0.WEAPON_PRE_CAST, arg_2_0.onWeaponPreCast)
	arg_2_1:RegisterEventListener(arg_2_0, var_0_0.WEAPON_PRE_CAST_FINISH, arg_2_0.onWeaponPrecastFinish)
	arg_2_1:RegisterEventListener(arg_2_0, var_0_0.WEAPON_INTERRUPT, arg_2_0.onWeaponInterrupted)

	return
end

function ys.Battle.BattleEnemyCharacter.UnregisterWeaponListener(arg_3_0, arg_3_1)
	var_0_1.super.UnregisterWeaponListener(arg_3_0, arg_3_1)
	arg_3_1:UnregisterEventListener(arg_3_0, var_0_0.WEAPON_PRE_CAST)
	arg_3_1:UnregisterEventListener(arg_3_0, var_0_0.WEAPON_PRE_CAST_FINISH)
	arg_3_1:UnregisterEventListener(arg_3_0, var_0_0.WEAPON_INTERRUPT)

	return
end

function ys.Battle.BattleEnemyCharacter.Update(arg_4_0)
	var_0_1.super.Update(arg_4_0)
	arg_4_0:UpdatePosition()
	arg_4_0:UpdateMatrix()
	arg_4_0:UpdateArrowBarPosition()
	arg_4_0:UpdateArrowBarRotation()

	if arg_4_0._vigilantBar then
		arg_4_0:UpdateVigilantBarPosition()
		arg_4_0._vigilantBar:UpdateVigilantProgress()
	end

	return
end

function ys.Battle.BattleEnemyCharacter.Dispose(arg_5_0)
	if arg_5_0._vigilantBar then
		arg_5_0._vigilantBar:Dispose()

		arg_5_0._vigilantBar = nil
	end

	arg_5_0:AddShaderColor()
	arg_5_0._factory:GetArrowPool():DestroyObj(arg_5_0._arrowBar)
	var_0_1.super.Dispose(arg_5_0)

	return
end

function ys.Battle.BattleEnemyCharacter.GetModleID(arg_6_0)
	return arg_6_0._unitData:GetTemplate().prefab
end

function ys.Battle.BattleEnemyCharacter.onWeaponPreCast(arg_7_0, arg_7_1)
	arg_7_0:AddFX(arg_7_1.Data.fx, true)

	arg_7_0._preCastBound = arg_7_1.Data.isBound

	return
end

function ys.Battle.BattleEnemyCharacter.onWeaponPrecastFinish(arg_8_0, arg_8_1)
	arg_8_0:RemoveCacheFX(arg_8_1.Data.fx)

	arg_8_0._preCastBound = false

	return
end

function ys.Battle.BattleEnemyCharacter.OnUpdateHP(arg_9_0, arg_9_1)
	var_0_1.super.OnUpdateHP(arg_9_0, arg_9_1)

	if arg_9_1.Data.dHP <= 0 then
		arg_9_0:AddBlink(1, 1, 1, 0.1, 0.1, true)
	end

	return
end

function ys.Battle.BattleEnemyCharacter.AddModel(arg_10_0, arg_10_1)
	var_0_1.super.AddModel(arg_10_0, arg_10_1)

	arg_10_0._hpBarOffset = Vector3(0, arg_10_0._unitData:GetTemplate().hp_bar[2], 0)

	return
end

function ys.Battle.BattleEnemyCharacter.GetSpecificFXScale(arg_11_0)
	return arg_11_0._unitData:GetTemplate().specific_fx_scale
end

function ys.Battle.BattleEnemyCharacter.OnAnimatorTrigger(arg_12_0)
	arg_12_0._unitData:CharacterActionTriggerCallback()

	return
end

function ys.Battle.BattleEnemyCharacter.OnAnimatorEnd(arg_13_0)
	arg_13_0._unitData:CharacterActionEndCallback()

	return
end

function ys.Battle.BattleEnemyCharacter.OnAnimatorStart(arg_14_0)
	arg_14_0._unitData:CharacterActionStartCallback()

	return
end

function ys.Battle.BattleEnemyCharacter.UpdateAimBiasBar(arg_15_0)
	var_0_1.super.UpdateAimBiasBar(arg_15_0)

	if arg_15_0._fogFx then
		local var_15_0 = arg_15_0:GetUnitData():GetAimBias():GetCurrentRate()

		arg_15_0._fogFx.transform.localScale = Vector3(var_15_0, var_15_0, 1)
	end

	return
end

function ys.Battle.BattleEnemyCharacter.getCharacterPos(arg_16_0)
	local var_16_0 = arg_16_0:GetUnitData():GetTemplate().prefab_offset

	arg_16_0._prefabPos:Set(arg_16_0._characterPos.x + var_16_0[1], arg_16_0._characterPos.y + var_16_0[2], arg_16_0._characterPos.z + var_16_0[3])

	return arg_16_0._prefabPos
end

return
