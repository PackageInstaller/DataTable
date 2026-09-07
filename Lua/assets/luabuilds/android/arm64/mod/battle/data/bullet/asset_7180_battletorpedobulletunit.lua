ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleFormulas
local BattleTorpedoBulletUnit = class("BattleTorpedoBulletUnit", ys.Battle.BattleBulletUnit)

ys.Battle.BattleTorpedoBulletUnit = BattleTorpedoBulletUnit
BattleTorpedoBulletUnit.__name = "BattleTorpedoBulletUnit"

function BattleTorpedoBulletUnit:Ctor(arg_1_1, arg_1_2)
	BattleTorpedoBulletUnit.super.Ctor(self, arg_1_1, arg_1_2)

	return
end

function BattleTorpedoBulletUnit:calcSpeed()
	local var_2_0 = var_0_1.ConvertBulletSpeed(math.max(0, self._velocity + var_0_0.Battle.BattleAttr.GetCurrent(self, "torpedoSpeedExtra")) * (1 + var_0_0.Battle.BattleAttr.GetCurrent(self, "bulletSpeedRatio")))

	self._speed = Vector3(var_2_0 * math.cos(math.deg2Rad * self._yAngle), 0, var_2_0 * math.sin(math.deg2Rad * self._yAngle))

	return
end

function BattleTorpedoBulletUnit:GetExplodePostion()
	return self._explodePos
end

function BattleTorpedoBulletUnit:SetExplodePosition(arg_4_1)
	self._explodePos = arg_4_1

	return
end

function BattleTorpedoBulletUnit:InitCldComponent()
	BattleTorpedoBulletUnit.super.InitCldComponent(self)
	self:ResetCldSurface()

	return
end

function BattleTorpedoBulletUnit:Hit(arg_6_1, arg_6_2)
	BattleTorpedoBulletUnit.super.Hit(self, arg_6_1, arg_6_2)

	self._pierceCount = self._pierceCount - 1

	return
end

return
