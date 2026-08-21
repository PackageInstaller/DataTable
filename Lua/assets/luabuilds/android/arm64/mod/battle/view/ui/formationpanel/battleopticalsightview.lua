ys = ys or {}

local var_0_0 = ys

ys.Battle.BattleOpticalSightView = class("BattleOpticalSightView")

local var_0_1 = ys.Battle.BattleOpticalSightView

ys.Battle.BattleOpticalSightView.__name = "BattleOpticalSightView"
ys.Battle.BattleOpticalSightView.SIGHT_A = ys.Battle.BattleConfig.ChargeWeaponConfig.SIGHT_A
ys.Battle.BattleOpticalSightView.SIGHT_B = ys.Battle.BattleConfig.ChargeWeaponConfig.SIGHT_B
ys.Battle.BattleOpticalSightView.SIGHT_C = ys.Battle.BattleConfig.ChargeWeaponConfig.SIGHT_C

function ys.Battle.BattleOpticalSightView.Ctor(arg_1_0, arg_1_1)
	arg_1_0._sightTF = arg_1_1:Find("Sight")
	arg_1_0._rulerTF = arg_1_1:Find("Ruler")
	arg_1_0._cornerTF = arg_1_1:Find("Corners")
	arg_1_0._active = false

	return
end

function ys.Battle.BattleOpticalSightView.SetAreaBound(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._totalLeftBound = arg_2_1
	arg_2_0._totalRightBound = arg_2_2

	return
end

function ys.Battle.BattleOpticalSightView.SetActive(arg_3_0, arg_3_1)
	arg_3_0._active = arg_3_1

	SetActive(arg_3_0._sightTF, arg_3_1)
	SetActive(arg_3_0._rulerTF, arg_3_1)
	SetActive(arg_3_0._cornerTF, arg_3_1)

	return
end

function ys.Battle.BattleOpticalSightView.Update(arg_4_0)
	if not arg_4_0._active then
		return
	end

	local var_4_0 = arg_4_0._fleetVO:GetMotion()
	local var_4_1 = var_0_0.Battle.BattleVariable.CameraPosToUICamera(Vector3.New(math.min(var_4_0:GetPos().x + var_0_1.SIGHT_C, arg_4_0._totalRightBound), 0, 5 + arg_4_0._fleetVO:GetMotion():GetPos().z))

	arg_4_0._sightTF.position = var_4_1
	arg_4_0._rulerTF.position = Vector3.New(0, var_4_1.y)

	return
end

function ys.Battle.BattleOpticalSightView.SetFleetVO(arg_5_0, arg_5_1)
	arg_5_0._fleetVO = arg_5_1

	return
end

function ys.Battle.BattleOpticalSightView.Dispose(arg_6_0)
	arg_6_0._sightTF = nil
	arg_6_0._rulerTF = nil
	arg_6_0._cornerTF = nil
	arg_6_0._fleetVO = nil

	return
end

return
