ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConst
local var_0_2 = var_0.Battle.BattleConfig
local var_0_3 = var_0.Battle.BattleUnitEvent
local var_0_4 = var_0.Battle

class = var_0_10005
var_0_4.BattleMinionCharacter = var_0_10005("BattleMinionCharacter", var_0.Battle.BattleCharacter)
var_0.Battle.BattleMinionCharacter.__name = "BattleMinionCharacter"

local var_0_5 = var_0.Battle.BattleMinionCharacter

function var_0_5.Ctor(arg_1_0)
	var_0_5.super.Ctor(arg_1_0)

	arg_1_0._preCastBound = false

	return
end

function var_0_5.RegisterWeaponListener(arg_2_0, arg_2_1)
	var_0_5.super.RegisterWeaponListener(arg_2_0, arg_2_1)
	arg_2_1:RegisterEventListener(arg_2_0, var_0_3.WEAPON_PRE_CAST, arg_2_0.onWeaponPreCast)
	arg_2_1:RegisterEventListener(arg_2_0, var_0_3.WEAPON_PRE_CAST_FINISH, arg_2_0.onWeaponPrecastFinish)

	return
end

function var_0_5.UnregisterWeaponListener(arg_3_0, arg_3_1)
	var_0_5.super.UnregisterWeaponListener(arg_3_0, arg_3_1)
	arg_3_1:UnregisterEventListener(arg_3_0, var_0_3.WEAPON_PRE_CAST)
	arg_3_1:UnregisterEventListener(arg_3_0, var_0_3.WEAPON_PRE_CAST_FINISH)

	return
end

function var_0_5.Update(arg_4_0)
	var_0_5.super.Update(arg_4_0)
	arg_4_0:UpdatePosition()
	arg_4_0:UpdateMatrix()

	return
end

function var_0_5.updateComponentVisible(arg_5_0)
	local var_5_0 = arg_5_0._unitData

	if var_1.GetIFF(var_5_0) ~= var_0_2.FOE_CODE then
		return
	end

	local var_5_1 = arg_5_0._unitData
	local var_5_2 = var_1.GetExposed(var_5_1)
	local var_5_3 = arg_5_0._unitData
	local var_5_4 = var_2.GetDiveDetected(var_5_3)
	local var_5_5 = arg_5_0._unitData
	local var_5_6 = var_3.GetDiveInvisible(var_5_5)
	local var_5_7 = var_5_2 and (not var_5_6 or not not var_5_4)

	SetActive = var_5_5

	var_5_5(arg_5_0._HPBarTf, var_5_7)

	SetActive = var_5_5

	var_5_5(arg_5_0._FXAttachPoint, var_5_7)

	return
end

function var_0_5.updateComponentDiveInvisible(arg_6_0)
	local var_6_0 = arg_6_0._unitData
	local var_6_2

	if var_1.GetDiveDetected(var_6_0) then
		local var_6_1 = arg_6_0._unitData

		var_6_2 = var_1.GetIFF(var_6_1) == var_0_2.FOE_CODE
	end

	local var_6_3 = arg_6_0._unitData
	local var_6_4 = var_2.GetDiveInvisible(var_6_3)
	local var_6_5
	local var_6_6 = (var_6_2 or not var_6_4) and true or false

	SetActive = var_6_3

	var_6_3(arg_6_0._HPBarTf, var_6_6)

	SetActive = var_6_3

	var_6_3(arg_6_0._FXAttachPoint, var_6_6)

	return
end

function var_0_5.Dispose(arg_7_0)
	arg_7_0:AddShaderColor()
	var_0_5.super.Dispose(arg_7_0)

	return
end

function var_0_5.GetModleID(arg_8_0)
	local var_8_0 = arg_8_0._unitData

	return var_1.GetTemplate(var_8_0).prefab
end

function var_0_5.onWeaponPreCast(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1.Data.fx

	arg_9_0:AddFX(var_9_0, true)

	arg_9_0._preCastBound = var_2.isBound

	return
end

function var_0_5.onWeaponPrecastFinish(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1.Data.fx

	arg_10_0:RemoveCacheFX(var_10_0)

	arg_10_0._preCastBound = false

	return
end

function var_0_5.OnUpdateHP(arg_11_0, arg_11_1)
	var_0_5.super.OnUpdateHP(arg_11_0, arg_11_1)

	if arg_11_1.Data.dHP <= 0 then
		arg_11_0:AddBlink(1, 1, 1, 0.1, 0.1, true)
	end

	return
end

function var_0_5.AddModel(arg_12_0, arg_12_1)
	var_0_5.super.AddModel(arg_12_0, arg_12_1)

	local var_12_0 = arg_12_0._unitData
	local var_12_1 = var_2.GetTemplate(var_12_0).hp_bar[2]

	Vector3 = var_1_10003
	arg_12_0._hpBarOffset = var_1_10003(0, var_12_1, 0)

	return
end

function var_0_5.GetSpecificFXScale(arg_13_0)
	local var_13_0 = arg_13_0._unitData

	return var_1.GetTemplate(var_13_0).specific_fx_scale
end

function var_0_5.OnAnimatorTrigger(arg_14_0)
	local var_14_0 = arg_14_0._unitData

	var_1.CharacterActionTriggerCallback(var_14_0)

	return
end

function var_0_5.OnAnimatorEnd(arg_15_0)
	local var_15_0 = arg_15_0._unitData

	var_1.CharacterActionEndCallback(var_15_0)

	return
end

function var_0_5.OnAnimatorStart(arg_16_0)
	local var_16_0 = arg_16_0._unitData

	var_1.CharacterActionStartCallback(var_16_0)

	return
end

function var_0_5.UpdateAimBiasBar(arg_17_0)
	var_0_5.super.UpdateAimBiasBar(arg_17_0)

	if arg_17_0._fogFx then
		local var_17_0 = arg_17_0:GetUnitData()
		local var_17_1 = var_1.GetAimBias(var_17_0)
		local var_17_2 = var_1.GetCurrentRate(var_17_1)
		local var_17_3 = arg_17_0._fogFx.transform

		Vector3 = var_17_1
		var_17_3.localScale = var_17_1(var_17_2, var_17_2, 1)
	end

	return
end

return
