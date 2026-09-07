ys = ys or {}

local var_0_0 = ys

ys.Battle.BattleTorpedoBullet = class("BattleTorpedoBullet", ys.Battle.BattleBullet)
ys.Battle.BattleTorpedoBullet.__name = "BattleTorpedoBullet"

local var_0_3 = ys.Battle.BattleTorpedoBullet

function ys.Battle.BattleTorpedoBullet.Ctor(arg_1_0)
	var_0_3.super.Ctor(arg_1_0)

	return
end

function ys.Battle.BattleTorpedoBullet:Dispose()
	if self._alert then
		self._alert:Dispose()
	end

	var_0_3.super.Dispose(self)

	return
end

function ys.Battle.BattleTorpedoBullet:Advance()
	self._speed = self._speed * 2

	return
end

function ys.Battle.BattleTorpedoBullet.GetZExtraOffset(arg_4_0)
	return 0
end

function ys.Battle.BattleTorpedoBullet:MakeAlert(arg_5_1)
	self._alert = var_0_0.Battle.TorAlert.New(arg_5_1)

	self._alert:SetPosition(self._bulletData:GetPosition(), self._bulletData:GetYAngle())

	return
end

function ys.Battle.BattleTorpedoBullet:Neutrailze()
	SetActive(self._go, false)

	return
end

return
