ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConfig
local var_0_2 = var_0.Battle

class = var_0_10003
var_0_2.BattleOpticalSightView = var_0_10003("BattleOpticalSightView")

local var_0_3 = var_0.Battle.BattleOpticalSightView

var_0_3.__name = "BattleOpticalSightView"
var_0_3.SIGHT_A = var_0_1.ChargeWeaponConfig.SIGHT_A
var_0_3.SIGHT_B = var_0_1.ChargeWeaponConfig.SIGHT_B
var_0_3.SIGHT_C = var_0_1.ChargeWeaponConfig.SIGHT_C

function var_0_3.Ctor(arg_1_0, arg_1_1)
	arg_1_0._sightTF = arg_1_1:Find("Sight")
	arg_1_0._rulerTF = arg_1_1:Find("Ruler")
	arg_1_0._cornerTF = arg_1_1:Find("Corners")
	arg_1_0._active = false

	return
end

function var_0_3.SetAreaBound(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._totalLeftBound = arg_2_1
	arg_2_0._totalRightBound = arg_2_2

	return
end

function var_0_3.SetActive(arg_3_0, arg_3_1)
	arg_3_0._active = arg_3_1
	SetActive = var_1_10002

	var_1_10002(arg_3_0._sightTF, arg_3_1)

	SetActive = var_1_10002

	var_1_10002(arg_3_0._rulerTF, arg_3_1)

	SetActive = var_1_10002

	var_1_10002(arg_3_0._cornerTF, arg_3_1)

	return
end

function var_0_3.Update(arg_4_0)
	if not arg_4_0._active then
		return
	end

	local var_4_0 = arg_4_0._fleetVO
	local var_4_1 = var_1.GetMotion(var_4_0)
	local var_4_2 = var_1.GetPos(var_4_1).x + var_0_3.SIGHT_C

	math = var_2

	local var_4_3 = var_2.min(var_4_2, arg_4_0._totalRightBound)
	local var_4_4 = var_0.Battle.BattleVariable.CameraPosToUICamera

	Vector3 = var_4

	local var_4_5 = var_4.New
	local var_4_6 = var_4_3
	local var_4_7 = 0
	local var_4_8 = arg_4_0._fleetVO
	local var_4_9 = var_8.GetMotion(var_4_8)
	local var_4_10 = var_4_4(var_4_5(var_4_6, var_4_7, 5 + var_8.GetPos(var_4_9).z))
	local var_4_11 = arg_4_0._sightTF

	var_4_11.position = var_4_10
	Vector3 = var_4_11

	local var_4_12 = var_4_11.New(0, var_4_10.y)

	arg_4_0._rulerTF.position = var_4_12

	return
end

function var_0_3.SetFleetVO(arg_5_0, arg_5_1)
	arg_5_0._fleetVO = arg_5_1

	return
end

function var_0_3.Dispose(arg_6_0)
	arg_6_0._sightTF = nil
	arg_6_0._rulerTF = nil
	arg_6_0._cornerTF = nil
	arg_6_0._fleetVO = nil

	return
end

return
