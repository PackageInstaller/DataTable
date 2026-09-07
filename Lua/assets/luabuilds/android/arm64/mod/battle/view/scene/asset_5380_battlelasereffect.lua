ys = ys or {}

local BattleLaserEffect = class("BattleLaserEffect", ys.Battle.BattleEffectArea)

ys.Battle.BattleLaserEffect = BattleLaserEffect
BattleLaserEffect.__name = "BattleLaserEffect"

function BattleLaserEffect:Ctor(arg_1_1, arg_1_2)
	BattleLaserEffect.super.Ctor(self, arg_1_1, arg_1_2)

	return
end

function BattleLaserEffect:SetStatic()
	return
end

function BattleLaserEffect:Init()
	self._tf = self._go.transform
	self._laserScript = GetComponent(self._go, "LaserScript")
	self._waveCount = 0

	self:Update()

	return
end

function BattleLaserEffect:Update()
	self:updateLineRenderer()
	self:UpdatePosition()

	return
end

function BattleLaserEffect:updateLineRenderer()
	self._laserScript.width = self._aoeData:GetHeight() + math.cos(self._waveCount * math.deg2Rad * 3)
	self._waveCount = self._waveCount + 1
	self._laserScript.length = self._aoeData:GetWidth()

	local var_5_0 = self._aoeData:GetAngle() * math.deg2Rad

	if self._aoeData:GetIFF() == -1 then
		var_5_0 = var_5_0 + math.pi
	end

	self._laserScript.angle = var_5_0

	return
end

return
