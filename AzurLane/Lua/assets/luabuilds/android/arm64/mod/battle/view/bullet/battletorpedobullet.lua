ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleTorpedoBullet
local var_0_2 = var_0.Battle.BattleResourceManager
local var_0_3 = var_0.Battle

class = var_0_10004
var_0_3.BattleTorpedoBullet = var_0_10004("BattleTorpedoBullet", var_0.Battle.BattleBullet)
var_0.Battle.BattleTorpedoBullet.__name = "BattleTorpedoBullet"

local var_0_4 = var_0.Battle.BattleTorpedoBullet

function var_0_4.Ctor(arg_1_0)
	var_0_4.super.Ctor(arg_1_0)

	return
end

function var_0_4.Dispose(arg_2_0)
	if arg_2_0._alert then
		local var_2_0 = arg_2_0._alert

		var_1.Dispose(var_2_0)
	end

	var_0_4.super.Dispose(arg_2_0)

	return
end

function var_0_4.Advance(arg_3_0)
	arg_3_0._speed = arg_3_0._speed * 2

	return
end

function var_0_4.GetZExtraOffset(arg_4_0)
	return 0
end

function var_0_4.MakeAlert(arg_5_0, arg_5_1)
	arg_5_0._alert = var_0.Battle.TorAlert.New(arg_5_1)

	local var_5_0 = arg_5_0._alert
	local var_5_1 = var_2.SetPosition
	local var_5_2 = arg_5_0._bulletData
	local var_5_3 = var_5.GetPosition(var_5_2)
	local var_5_4 = arg_5_0._bulletData

	var_5_1(var_5_0, var_5_3, var_6.GetYAngle(var_5_4))

	return
end

function var_0_4.Neutrailze(arg_6_0)
	SetActive = var_1_10001

	var_1_10001(arg_6_0._go, false)

	return
end

return
