ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleConfig
local var_0_2 = ys.Battle.BattleConst.EquipmentType

ys.Battle.BattleChargeWeaponVO = class("BattleChargeWeaponVO", ys.Battle.BattlePlayerWeaponVO)
ys.Battle.BattleChargeWeaponVO.__name = "BattleChargeWeaponVO"

local var_0_3 = ys.Battle.BattleChargeWeaponVO

ys.Battle.BattleChargeWeaponVO.GCD = ys.Battle.BattleConfig.ChargeWeaponConfig.GCD

function ys.Battle.BattleChargeWeaponVO.Ctor(arg_1_0)
	var_0_3.super.Ctor(arg_1_0, var_0_3.GCD)

	return
end

function ys.Battle.BattleChargeWeaponVO.AppendWeapon(arg_2_0, arg_2_1)
	var_0_3.super.AppendWeapon(arg_2_0, arg_2_1)
	arg_2_1:SetPlayerChargeWeaponVO(arg_2_0)

	return
end

function ys.Battle.BattleChargeWeaponVO:GetCurrentWeaponIconIndex()
	local var_3_0 = self:GetHeadWeapon()

	if var_3_0 == nil then
		return 1
	else
		local var_3_1 = var_3_0:GetType()

		if var_3_1 == var_0_2.POINT_HIT_AND_LOCK then
			return 1
		elseif var_3_1 == var_0_2.MANUAL_MISSILE then
			return 10
		elseif var_3_1 == var_0_2.MANUAL_METEOR then
			return 11
		elseif var_3_1 == var_0_2.POINT_AIR_STRIKE then
			return 12
		end
	end

	return
end

function ys.Battle.BattleChargeWeaponVO:Deduct(arg_4_1)
	var_0_3.super.Deduct(self, arg_4_1)
	self:ResetFocus()

	return
end

function ys.Battle.BattleChargeWeaponVO:ResetFocus()
	if self._focus then
		local var_5_0 = var_0_0.Battle.BattleCameraUtil.GetInstance()

		var_5_0:FocusCharacter(nil, var_0_1.CAST_CAM_ZOOM_OUT_DURATION_CANNON, var_0_1.CAST_CAM_ZOOM_OUT_EXTRA_DELAY_CANNON)
		var_5_0:ZoomCamara(var_0_1.CAST_CAM_ZOOM_SIZE, var_0_1.CAST_CAM_OVERLOOK_SIZE, var_0_1.CAST_CAM_ZOOM_OUT_DURATION_CANNON)
		LeanTween.delayedCall(go(var_5_0:GetCamera()), var_0_1.CAST_CAM_ZOOM_OUT_DURATION_CANNON + var_0_1.CAST_CAM_ZOOM_OUT_EXTRA_DELAY_CANNON, System.Action(function()
			self._focus = false

			var_5_0:BulletTime(var_0_1.SPEED_FACTOR_FOCUS_CHARACTER, nil)
			var_5_0:ZoomCamara(nil, nil, var_0_1.CAST_CAM_OVERLOOK_REVERT_DURATION)

			return
		end))
	end

	return
end

return
