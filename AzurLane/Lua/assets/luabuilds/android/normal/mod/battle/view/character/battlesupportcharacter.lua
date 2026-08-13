ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConst
local var_0_2 = var_0.Battle.BattleConfig
local var_0_3 = var_0.Battle.BattleUnitEvent
local var_0_4 = var_0.Battle

class = var_0_10005
var_0_4.BattleSupportCharacter = var_0_10005("BattleSupportCharacter", var_0.Battle.BattleCharacter)
var_0.Battle.BattleSupportCharacter.__name = "BattleSupportCharacter"

local var_0_5 = var_0.Battle.BattleSupportCharacter

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
	return
end

function var_0_5.UpdateHPBarPosition(arg_5_0)
	return
end

function var_0_5.SpawnBullet(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	local var_6_0 = arg_6_0._bulletFactoryList[arg_6_1:GetTemplate().type]
	local var_6_1 = arg_6_0._unitData
	local var_6_2 = var_6.GetPosition(var_6_1)
	local var_6_3 = var_6_0
	local var_6_4 = var_6_0.CreateBullet
	local var_6_5 = arg_6_0._tf
	local var_6_6 = arg_6_1
	local var_6_7 = var_6_2
	local var_6_8 = arg_6_3
	local var_6_9 = arg_6_0._unitData

	var_6_4(var_6_3, var_6_5, var_6_6, var_6_7, var_6_8, var_13.GetDirection(var_6_9))

	return
end

function var_0_5.AddFX(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	if arg_7_4 then
		arg_7_4()
	end

	return
end

function var_0_5.updateComponentVisible(arg_8_0)
	local var_8_0 = arg_8_0._unitData

	if var_1.GetIFF(var_8_0) ~= var_0_2.FOE_CODE then
		return
	end

	local var_8_1 = arg_8_0._unitData
	local var_8_2 = var_1.GetExposed(var_8_1)
	local var_8_3 = arg_8_0._unitData
	local var_8_4 = var_2.GetDiveDetected(var_8_3)
	local var_8_5 = arg_8_0._unitData
	local var_8_6 = var_3.GetDiveInvisible(var_8_5)
	local var_8_7 = var_8_2 and (not var_8_6 or not not var_8_4)

	SetActive = var_1_10005

	var_1_10005(arg_8_0._HPBarTf, var_8_7)

	SetActive = var_1_10005

	var_1_10005(arg_8_0._FXAttachPoint, var_8_7)

	return
end

function var_0_5.updateComponentDiveInvisible(arg_9_0)
	local var_9_0 = arg_9_0._unitData
	local var_9_2

	if var_1.GetDiveDetected(var_9_0) then
		local var_9_1 = arg_9_0._unitData

		var_9_2 = var_1.GetIFF(var_9_1) == var_0_2.FOE_CODE
	end

	local var_9_3 = arg_9_0._unitData
	local var_9_4 = var_2.GetDiveInvisible(var_9_3)
	local var_9_5
	local var_9_6 = (var_9_2 or not var_9_4) and true or false

	SetActive = var_1_10004

	var_1_10004(arg_9_0._HPBarTf, var_9_6)

	SetActive = var_1_10004

	var_1_10004(arg_9_0._FXAttachPoint, var_9_6)

	return
end

function var_0_5.Dispose(arg_10_0)
	arg_10_0:AddShaderColor()
	var_0_5.super.Dispose(arg_10_0)

	return
end

function var_0_5.GetModleID(arg_11_0)
	local var_11_0 = arg_11_0._unitData

	return var_1.GetTemplate(var_11_0).prefab
end

function var_0_5.OnAnimatorTrigger(arg_12_0)
	local var_12_0 = arg_12_0._unitData

	var_1.CharacterActionTriggerCallback(var_12_0)

	return
end

function var_0_5.OnAnimatorEnd(arg_13_0)
	local var_13_0 = arg_13_0._unitData

	var_1.CharacterActionEndCallback(var_13_0)

	return
end

function var_0_5.OnAnimatorStart(arg_14_0)
	local var_14_0 = arg_14_0._unitData

	var_1.CharacterActionStartCallback(var_14_0)

	return
end

function var_0_5.UpdateAimBiasBar(arg_15_0)
	var_0_5.super.UpdateAimBiasBar(arg_15_0)

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

return
