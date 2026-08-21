ys = ys or {}

local var_0_1 = ys.Battle.BattleConfig
local var_0_2 = ys.Battle.BattleUnitEvent

ys.Battle.BattleMinionCharacter = class("BattleMinionCharacter", ys.Battle.BattleCharacter)
ys.Battle.BattleMinionCharacter.__name = "BattleMinionCharacter"

local var_0_3 = ys.Battle.BattleMinionCharacter

function ys.Battle.BattleMinionCharacter.Ctor(arg_1_0)
	var_0_3.super.Ctor(arg_1_0)

	arg_1_0._preCastBound = false

	return
end

function ys.Battle.BattleMinionCharacter.RegisterWeaponListener(arg_2_0, arg_2_1)
	var_0_3.super.RegisterWeaponListener(arg_2_0, arg_2_1)
	arg_2_1:RegisterEventListener(arg_2_0, var_0_2.WEAPON_PRE_CAST, arg_2_0.onWeaponPreCast)
	arg_2_1:RegisterEventListener(arg_2_0, var_0_2.WEAPON_PRE_CAST_FINISH, arg_2_0.onWeaponPrecastFinish)

	return
end

function ys.Battle.BattleMinionCharacter.UnregisterWeaponListener(arg_3_0, arg_3_1)
	var_0_3.super.UnregisterWeaponListener(arg_3_0, arg_3_1)
	arg_3_1:UnregisterEventListener(arg_3_0, var_0_2.WEAPON_PRE_CAST)
	arg_3_1:UnregisterEventListener(arg_3_0, var_0_2.WEAPON_PRE_CAST_FINISH)

	return
end

function ys.Battle.BattleMinionCharacter.Update(arg_4_0)
	var_0_3.super.Update(arg_4_0)
	arg_4_0:UpdatePosition()
	arg_4_0:UpdateMatrix()

	return
end

function ys.Battle.BattleMinionCharacter.updateComponentVisible(arg_5_0)
	if arg_5_0._unitData:GetIFF() ~= var_0_1.FOE_CODE then
		return
	end

	local var_5_0 = arg_5_0._unitData:GetExposed() and (not arg_5_0._unitData:GetDiveInvisible() or not not arg_5_0._unitData:GetDiveDetected())

	SetActive(arg_5_0._HPBarTf, var_5_0)
	SetActive(arg_5_0._FXAttachPoint, var_5_0)

	return
end

function ys.Battle.BattleMinionCharacter.updateComponentDiveInvisible(arg_6_0)
	local var_6_0 = arg_6_0._unitData:GetDiveDetected() and arg_6_0._unitData:GetIFF() == var_0_1.FOE_CODE
	local var_6_1 = arg_6_0._unitData:GetDiveInvisible()

	SetActive(arg_6_0._HPBarTf, (var_6_0 or not var_6_1) and true or false)
	SetActive(arg_6_0._FXAttachPoint, var_6_2)

	return
end

function ys.Battle.BattleMinionCharacter.Dispose(arg_7_0)
	arg_7_0:AddShaderColor()
	var_0_3.super.Dispose(arg_7_0)

	return
end

function ys.Battle.BattleMinionCharacter.GetModleID(arg_8_0)
	return arg_8_0._unitData:GetTemplate().prefab
end

function ys.Battle.BattleMinionCharacter.onWeaponPreCast(arg_9_0, arg_9_1)
	arg_9_0:AddFX(arg_9_1.Data.fx, true)

	arg_9_0._preCastBound = arg_9_1.Data.isBound

	return
end

function ys.Battle.BattleMinionCharacter.onWeaponPrecastFinish(arg_10_0, arg_10_1)
	arg_10_0:RemoveCacheFX(arg_10_1.Data.fx)

	arg_10_0._preCastBound = false

	return
end

function ys.Battle.BattleMinionCharacter.OnUpdateHP(arg_11_0, arg_11_1)
	var_0_3.super.OnUpdateHP(arg_11_0, arg_11_1)

	if arg_11_1.Data.dHP <= 0 then
		arg_11_0:AddBlink(1, 1, 1, 0.1, 0.1, true)
	end

	return
end

function ys.Battle.BattleMinionCharacter.AddModel(arg_12_0, arg_12_1)
	var_0_3.super.AddModel(arg_12_0, arg_12_1)

	arg_12_0._hpBarOffset = Vector3(0, arg_12_0._unitData:GetTemplate().hp_bar[2], 0)

	return
end

function ys.Battle.BattleMinionCharacter.GetSpecificFXScale(arg_13_0)
	return arg_13_0._unitData:GetTemplate().specific_fx_scale
end

function ys.Battle.BattleMinionCharacter.OnAnimatorTrigger(arg_14_0)
	arg_14_0._unitData:CharacterActionTriggerCallback()

	return
end

function ys.Battle.BattleMinionCharacter.OnAnimatorEnd(arg_15_0)
	arg_15_0._unitData:CharacterActionEndCallback()

	return
end

function ys.Battle.BattleMinionCharacter.OnAnimatorStart(arg_16_0)
	arg_16_0._unitData:CharacterActionStartCallback()

	return
end

function ys.Battle.BattleMinionCharacter.UpdateAimBiasBar(arg_17_0)
	var_0_3.super.UpdateAimBiasBar(arg_17_0)

	if arg_17_0._fogFx then
		local var_17_0 = arg_17_0:GetUnitData():GetAimBias():GetCurrentRate()

		arg_17_0._fogFx.transform.localScale = Vector3(var_17_0, var_17_0, 1)
	end

	return
end

return
