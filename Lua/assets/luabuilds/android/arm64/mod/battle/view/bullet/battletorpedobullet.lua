ys = ys or {}

local var_0_0 = ys

ys.Battle.BattleTorpedoBullet = class("BattleTorpedoBullet", ys.Battle.BattleBullet)
ys.Battle.BattleTorpedoBullet.__name = "BattleTorpedoBullet"

local var_0_3 = ys.Battle.BattleTorpedoBullet

function ys.Battle.BattleTorpedoBullet.Ctor(arg_1_0)
	var_0_3.super.Ctor(arg_1_0)

	return
end

function ys.Battle.BattleTorpedoBullet.Dispose(arg_2_0)
	if arg_2_0._alert then
		arg_2_0._alert:Dispose()
	end

	var_0_3.super.Dispose(arg_2_0)

	return
end

function ys.Battle.BattleTorpedoBullet.Advance(arg_3_0)
	arg_3_0._speed = arg_3_0._speed * 2

	return
end

function ys.Battle.BattleTorpedoBullet.GetZExtraOffset(arg_4_0)
	return 0
end

function ys.Battle.BattleTorpedoBullet.MakeAlert(arg_5_0, arg_5_1)
	arg_5_0._alert = var_0_0.Battle.TorAlert.New(arg_5_1)

	arg_5_0._alert:SetPosition(arg_5_0._bulletData:GetPosition(), arg_5_0._bulletData:GetYAngle())

	return
end

function ys.Battle.BattleTorpedoBullet.Neutrailze(arg_6_0)
	SetActive(arg_6_0._go, false)

	return
end

return
