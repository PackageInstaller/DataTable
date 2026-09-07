ys = ys or {}
pg = pg or {}

local var_0_1 = ys.Battle.BattleConst
local BattleFleetMotionVO = class("BattleFleetMotionVO")

ys.Battle.BattleFleetMotionVO = BattleFleetMotionVO
BattleFleetMotionVO.__name = "BattleFleetMotionVO"

function BattleFleetMotionVO:Ctor()
	self._pos = Vector3.zero
	self._speed = Vector3.zero
	self._lastDir = var_0_1.NORMALIZE_FLEET_SPEED
	self._rotateAngle = Quaternion.identity
	self._isCalibrateAcc = false

	return
end

function BattleFleetMotionVO:GetPos()
	return self._pos
end

function BattleFleetMotionVO:GetSpeed()
	return self._speed:Clone()
end

function BattleFleetMotionVO:GetDirAngle()
	return self._rotateAngle
end

function BattleFleetMotionVO:UpdatePos(arg_5_1)
	self._pos = arg_5_1:GetPosition()

	return
end

function BattleFleetMotionVO:UpdateVelocityAndDirection(arg_6_1, arg_6_2, arg_6_3)
	self:UpdateSpeed((Vector3(arg_6_2, 0, arg_6_3):Mul(arg_6_1)))

	return
end

function BattleFleetMotionVO:UpdateSpeed(arg_7_1)
	if self._speed ~= arg_7_1 then
		self._speed = arg_7_1

		if not arg_7_1:EqualZero() then
			self._lastDir = arg_7_1
		end

		self._rotateAngle:SetFromToRotation1(var_0_1.NORMALIZE_FLEET_SPEED, self._lastDir)
	end

	return
end

function BattleFleetMotionVO:CalibrateAcc(arg_8_1)
	self._isCalibrateAcc = arg_8_1

	return
end

function BattleFleetMotionVO:SetPos(arg_9_1)
	self._pos = arg_9_1

	return
end

return
