ys = ys or {}

local var_0_1 = ys.Battle.BattleConfig
local var_0_2 = ys.Battle.BattleUnitEvent

ys.Battle.BattleSupportCharacter = class("BattleSupportCharacter", ys.Battle.BattleCharacter)
ys.Battle.BattleSupportCharacter.__name = "BattleSupportCharacter"

local var_0_3 = ys.Battle.BattleSupportCharacter

function ys.Battle.BattleSupportCharacter.Ctor(arg_1_0)
	var_0_3.super.Ctor(arg_1_0)

	arg_1_0._preCastBound = false

	return
end

function ys.Battle.BattleSupportCharacter.RegisterWeaponListener(arg_2_0, arg_2_1)
	var_0_3.super.RegisterWeaponListener(arg_2_0, arg_2_1)
	arg_2_1:RegisterEventListener(arg_2_0, var_0_2.WEAPON_PRE_CAST, arg_2_0.onWeaponPreCast)
	arg_2_1:RegisterEventListener(arg_2_0, var_0_2.WEAPON_PRE_CAST_FINISH, arg_2_0.onWeaponPrecastFinish)

	return
end

function ys.Battle.BattleSupportCharacter.UnregisterWeaponListener(arg_3_0, arg_3_1)
	var_0_3.super.UnregisterWeaponListener(arg_3_0, arg_3_1)
	arg_3_1:UnregisterEventListener(arg_3_0, var_0_2.WEAPON_PRE_CAST)
	arg_3_1:UnregisterEventListener(arg_3_0, var_0_2.WEAPON_PRE_CAST_FINISH)

	return
end

function ys.Battle.BattleSupportCharacter.Update(arg_4_0)
	return
end

function ys.Battle.BattleSupportCharacter.UpdateHPBarPosition(arg_5_0)
	return
end

function ys.Battle.BattleSupportCharacter.SpawnBullet(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	arg_6_0._bulletFactoryList[arg_6_1:GetTemplate().type]:CreateBullet(arg_6_0._tf, arg_6_1, arg_6_0._unitData:GetPosition(), arg_6_3, arg_6_0._unitData:GetDirection())

	return
end

function ys.Battle.BattleSupportCharacter.AddFX(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	if arg_7_4 then
		arg_7_4()
	end

	return
end

function ys.Battle.BattleSupportCharacter.updateComponentVisible(arg_8_0)
	if arg_8_0._unitData:GetIFF() ~= var_0_1.FOE_CODE then
		return
	end

	local var_8_0 = arg_8_0._unitData:GetExposed() and (not arg_8_0._unitData:GetDiveInvisible() or not not arg_8_0._unitData:GetDiveDetected())

	SetActive(arg_8_0._HPBarTf, var_8_0)
	SetActive(arg_8_0._FXAttachPoint, var_8_0)

	return
end

function ys.Battle.BattleSupportCharacter.updateComponentDiveInvisible(arg_9_0)
	local var_9_0 = arg_9_0._unitData:GetDiveDetected() and arg_9_0._unitData:GetIFF() == var_0_1.FOE_CODE
	local var_9_1 = arg_9_0._unitData:GetDiveInvisible()

	SetActive(arg_9_0._HPBarTf, (var_9_0 or not var_9_1) and true or false)
	SetActive(arg_9_0._FXAttachPoint, var_9_2)

	return
end

function ys.Battle.BattleSupportCharacter.Dispose(arg_10_0)
	arg_10_0:AddShaderColor()
	var_0_3.super.Dispose(arg_10_0)

	return
end

function ys.Battle.BattleSupportCharacter.GetModleID(arg_11_0)
	return arg_11_0._unitData:GetTemplate().prefab
end

function ys.Battle.BattleSupportCharacter.OnAnimatorTrigger(arg_12_0)
	arg_12_0._unitData:CharacterActionTriggerCallback()

	return
end

function ys.Battle.BattleSupportCharacter.OnAnimatorEnd(arg_13_0)
	arg_13_0._unitData:CharacterActionEndCallback()

	return
end

function ys.Battle.BattleSupportCharacter.OnAnimatorStart(arg_14_0)
	arg_14_0._unitData:CharacterActionStartCallback()

	return
end

function ys.Battle.BattleSupportCharacter.UpdateAimBiasBar(arg_15_0)
	var_0_3.super.UpdateAimBiasBar(arg_15_0)

	if arg_15_0._fogFx then
		local var_15_0 = arg_15_0:GetUnitData():GetAimBias():GetCurrentRate()

		arg_15_0._fogFx.transform.localScale = Vector3(var_15_0, var_15_0, 1)
	end

	return
end

return
