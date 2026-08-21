ys = ys or {}
pg = pg or {}

local var_0_1 = ys.Battle.BattleConst
local var_0_4 = class("BattleFleetMotionVO")

ys.Battle.BattleFleetMotionVO = var_0_4
var_0_4.__name = "BattleFleetMotionVO"

function var_0_4.Ctor(arg_1_0)
	arg_1_0._pos = Vector3.zero
	arg_1_0._speed = Vector3.zero
	arg_1_0._lastDir = var_0_1.NORMALIZE_FLEET_SPEED
	arg_1_0._rotateAngle = Quaternion.identity
	arg_1_0._isCalibrateAcc = false

	return
end

function var_0_4.GetPos(arg_2_0)
	return arg_2_0._pos
end

function var_0_4.GetSpeed(arg_3_0)
	return arg_3_0._speed:Clone()
end

function var_0_4.GetDirAngle(arg_4_0)
	return arg_4_0._rotateAngle
end

function var_0_4.UpdatePos(arg_5_0, arg_5_1)
	arg_5_0._pos = arg_5_1:GetPosition()

	return
end

function var_0_4.UpdateVelocityAndDirection(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0:UpdateSpeed((Vector3(arg_6_2, 0, arg_6_3):Mul(arg_6_1)))

	return
end

function var_0_4.UpdateSpeed(arg_7_0, arg_7_1)
	if arg_7_0._speed ~= arg_7_1 then
		arg_7_0._speed = arg_7_1

		if not arg_7_1:EqualZero() then
			arg_7_0._lastDir = arg_7_1
		end

		arg_7_0._rotateAngle:SetFromToRotation1(var_0_1.NORMALIZE_FLEET_SPEED, arg_7_0._lastDir)
	end

	return
end

function var_0_4.CalibrateAcc(arg_8_0, arg_8_1)
	arg_8_0._isCalibrateAcc = arg_8_1

	return
end

function var_0_4.SetPos(arg_9_0, arg_9_1)
	arg_9_0._pos = arg_9_1

	return
end

return
