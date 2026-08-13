ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConfig
local var_0_2 = var_0.Battle.BattleConst.EquipmentType
local var_0_3 = var_0.Battle

class = var_0_10005
var_0_3.BattleChargeWeaponVO = var_0_10005("BattleChargeWeaponVO", var_0.Battle.BattlePlayerWeaponVO)
var_0.Battle.BattleChargeWeaponVO.__name = "BattleChargeWeaponVO"

local var_0_4 = var_0.Battle.BattleChargeWeaponVO

var_0_4.GCD = var_0_1.ChargeWeaponConfig.GCD

function var_0_4.Ctor(arg_1_0)
	var_0_4.super.Ctor(arg_1_0, var_0_4.GCD)

	return
end

function var_0_4.AppendWeapon(arg_2_0, arg_2_1)
	var_0_4.super.AppendWeapon(arg_2_0, arg_2_1)
	arg_2_1:SetPlayerChargeWeaponVO(arg_2_0)

	return
end

function var_0_4.GetCurrentWeaponIconIndex(arg_3_0)
	if arg_3_0:GetHeadWeapon() == nil then
		return 1
	elseif var_1:GetType() == var_0_2.POINT_HIT_AND_LOCK then
		return 1
	elseif var_2 == var_0_2.MANUAL_MISSILE then
		return 10
	elseif var_2 == var_0_2.MANUAL_METEOR then
		return 11
	elseif var_2 == var_0_2.POINT_AIR_STRIKE then
		return 12
	end

	return
end

function var_0_4.Deduct(arg_4_0, arg_4_1)
	var_0_4.super.Deduct(arg_4_0, arg_4_1)
	arg_4_0:ResetFocus()

	return
end

function var_0_4.ResetFocus(arg_5_0)
	if arg_5_0._focus then
		local var_5_0 = var_0.Battle.BattleCameraUtil.GetInstance()

		var_1.FocusCharacter(var_5_0, nil, var_0_1.CAST_CAM_ZOOM_OUT_DURATION_CANNON, var_0_1.CAST_CAM_ZOOM_OUT_EXTRA_DELAY_CANNON)
		var_1:ZoomCamara(var_0_1.CAST_CAM_ZOOM_SIZE, var_0_1.CAST_CAM_OVERLOOK_SIZE, var_0_1.CAST_CAM_ZOOM_OUT_DURATION_CANNON)

		local var_5_1 = var_0_1.CAST_CAM_ZOOM_OUT_DURATION_CANNON + var_0_1.CAST_CAM_ZOOM_OUT_EXTRA_DELAY_CANNON

		LeanTween = var_3

		local var_5_2 = var_3.delayedCall

		go = var_4

		local var_5_3 = var_1
		local var_5_4 = var_4(var_1.GetCamera(var_5_3))
		local var_5_5 = var_5_1

		System = var_5_3

		var_5_2(var_5_4, var_5_5, var_5_3.Action(function()
			arg_5_0._focus = false

			local var_6_0 = var_0

			var_0.BulletTime(var_6_0, var_0_1.SPEED_FACTOR_FOCUS_CHARACTER, nil)

			local var_6_1 = var_0

			var_0.ZoomCamara(var_6_1, nil, nil, var_0_1.CAST_CAM_OVERLOOK_REVERT_DURATION)

			return
		end))
	end

	return
end

return
