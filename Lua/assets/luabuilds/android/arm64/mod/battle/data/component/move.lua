ys = ys or {}

local var_0_1 = class("MoveComponent")

ys.Battle.MoveComponent = var_0_1
var_0_1._pos = Vector3.zero
var_0_1._isForceMove = false
var_0_1._staticState = false
var_0_1._speed = Vector3.zero
var_0_1._additiveSpeedList = {}
var_0_1._additiveSpeed = Vector3.zero
var_0_1._corpsLimitSpeed = 0
var_0_1._leftCorpsBound = 0
var_0_1._rightCorpsBound = 0
var_0_1._immuneAreaLimit = false
var_0_1._immuneMaxAreaLimit = false
var_0_1._leftBorder = 0
var_0_1._rightBorder = 0
var_0_1._upBorder = 0
var_0_1._downBorder = 0
var_0_1._IFF = 0

function var_0_1.Ctor(arg_1_0)
	return
end

function var_0_1.GetPos(arg_2_0)
	return arg_2_0._pos
end

function var_0_1.SetPos(arg_3_0, arg_3_1)
	arg_3_0._pos = arg_3_1

	return
end

function var_0_1.Update(arg_4_0)
	arg_4_0._speed = arg_4_0:GetFinalSpeed()

	return
end

function var_0_1.FixSpeed(arg_5_0, arg_5_1)
	assert(arg_5_1.FixSpeed ~= nil and type(arg_5_1.FixSpeed) == "function", " MoveComponent.FixSpeed 速度修正出错")
	arg_5_1:FixSpeed(arg_5_0._speed)

	return
end

function var_0_1.Move(arg_6_0, arg_6_1)
	arg_6_1 = arg_6_1 or 1
	arg_6_0._pos.x = arg_6_0._pos.x + arg_6_0._speed.x * arg_6_1
	arg_6_0._pos.y = arg_6_0._pos.y + arg_6_0._speed.y * arg_6_1
	arg_6_0._pos.z = arg_6_0._pos.z + arg_6_0._speed.z * arg_6_1

	return
end

function var_0_1.GetSpeed(arg_7_0)
	return arg_7_0._speed
end

function var_0_1.SetCorpsArea(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0._leftCorpsBound = arg_8_1
	arg_8_0._rightCorpsBound = arg_8_2

	return
end

function var_0_1.SetBorder(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	arg_9_0._leftBorder = arg_9_1
	arg_9_0._rightBorder = arg_9_2
	arg_9_0._upBorder = arg_9_3
	arg_9_0._downBorder = arg_9_4

	return
end

function var_0_1.GetFinalSpeed(arg_10_0)
	local var_10_0 = arg_10_0:getInitialSpeed()

	if not arg_10_0._unstoppable then
		var_10_0 = arg_10_0:AdditiveForce(var_10_0)
	end

	return (arg_10_0:BorderLimit(var_10_0))
end

function var_0_1.CorpsAreaLimit(arg_11_0, arg_11_1)
	if arg_11_0._immuneAreaLimit then
		return arg_11_1
	end

	local var_11_0 = arg_11_0._pos.x
	local var_11_1 = arg_11_0._corpsLimitSpeed

	if arg_11_0._pos.x < arg_11_0._leftCorpsBound then
		var_11_1 = math.max(var_11_1, 0.1)

		if arg_11_1.x < 0 then
			var_11_1 = math.min(10, var_11_1 * 1.04)
		end
	elseif var_11_0 > arg_11_0._rightCorpsBound then
		var_11_1 = math.min(var_11_1, -0.1)

		if arg_11_1.x > 0 then
			var_11_1 = math.max(-10, var_11_1 * 1.04)
		end
	else
		var_11_1 = var_11_1 < 0.1 and var_11_1 > -0.1 and 0 or var_11_1 * 0.8
	end

	arg_11_0._corpsLimitSpeed = var_11_1
	arg_11_1.x = arg_11_1.x + arg_11_0._corpsLimitSpeed

	return arg_11_1
end

function var_0_1.BorderLimit(arg_12_0, arg_12_1)
	if arg_12_0._immuneMaxAreaLimit then
		return arg_12_1
	end

	local var_12_0 = arg_12_0._pos

	if arg_12_1.x < 0 and var_12_0.x <= arg_12_0._leftBorder or arg_12_1.x > 0 and var_12_0.x >= arg_12_0._rightBorder then
		arg_12_1.x = 0
	end

	if arg_12_1.z < 0 and var_12_0.z <= arg_12_0._downBorder or arg_12_1.z > 0 and var_12_0.z >= arg_12_0._upBorder then
		arg_12_1.z = 0
	end

	return arg_12_1
end

function var_0_1.ImmuneAreaLimit(arg_13_0, arg_13_1)
	arg_13_0._immuneAreaLimit = arg_13_1

	return
end

function var_0_1.ImmuneMaxAreaLimit(arg_14_0, arg_14_1)
	arg_14_0._immuneMaxAreaLimit = arg_14_1

	return
end

function var_0_1.getInitialSpeed(arg_15_0)
	if arg_15_0._isForceMove and not arg_15_0._unstoppable then
		arg_15_0:UpdateForceMove()

		return arg_15_0._forceSpeed
	end

	if arg_15_0._staticState and not arg_15_0._unstoppable then
		return Vector3.zero
	end

	if arg_15_0._manuallyMove then
		return arg_15_0:CorpsAreaLimit(arg_15_0._manuallyMove())
	end

	assert(arg_15_0._autoMoveAi ~= nil, "角色缺少默认移动的ai")

	return arg_15_0._autoMoveAi()
end

function var_0_1.SetForceMove(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4, arg_16_5)
	arg_16_0._isForceMove = true
	arg_16_1 = arg_16_1.normalized
	arg_16_0._forceSpeed = arg_16_1 * arg_16_2
	arg_16_0._forceReduce = arg_16_1 * arg_16_3
	arg_16_0._forceLastTime = arg_16_4
	arg_16_0._decayValve = arg_16_5 or 0

	return
end

function var_0_1.UpdateForceMove(arg_17_0)
	if arg_17_0._forceLastTime <= 0 then
		arg_17_0:ClearForceMove()

		return
	end

	arg_17_0._forceLastTime = arg_17_0._forceLastTime - 1

	if arg_17_0._forceLastTime < arg_17_0._decayValve then
		arg_17_0._forceSpeed:Sub(arg_17_0._forceReduce)
	end

	return
end

function var_0_1.ClearForceMove(arg_18_0)
	arg_18_0._isForceMove = false
	arg_18_0._forceSpeed = nil
	arg_18_0._forceReduce = nil
	arg_18_0._forceLastTime = nil

	return
end

function var_0_1.SetStaticState(arg_19_0, arg_19_1)
	arg_19_0._staticState = arg_19_1

	return
end

function var_0_1.SetAutoMoveAI(arg_20_0, arg_20_1, arg_20_2)
	function arg_20_0._autoMoveAi()
		return arg_20_1:GetDirection():Mul(arg_20_2:GetAttrByName("velocity"))
	end

	return
end

function var_0_1.SetFormationCtrlInfo(arg_22_0, arg_22_1)
	function arg_22_0._manuallyMove()
		return arg_22_0:UpdateFleetInfo(arg_22_1)
	end

	return
end

function var_0_1.CancelFormationCtrl(arg_24_0)
	arg_24_0._manuallyMove = nil

	return
end

function var_0_1.SetMotionVO(arg_25_0, arg_25_1)
	arg_25_0._fleetMotionVO = arg_25_1

	return
end

function var_0_1.UpdateFleetInfo(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_0._fleetMotionVO:GetSpeed()

	if arg_26_1:EqualZero() then
		return var_26_0
	end

	return (arg_26_0._fleetMotionVO:GetDirAngle() * arg_26_1):Add((arg_26_0._fleetMotionVO:GetPos())):Sub(arg_26_0._pos):Div(25):Add(var_26_0)
end

function var_0_1.AdditiveForce(arg_27_0, arg_27_1)
	arg_27_1.x = arg_27_1.x + arg_27_0._additiveSpeed.x
	arg_27_1.z = arg_27_1.z + arg_27_0._additiveSpeed.z

	return arg_27_1
end

function var_0_1.UpdateAdditiveSpeed(arg_28_0, arg_28_1)
	arg_28_0._additiveSpeed = arg_28_1

	return
end

function var_0_1.RemoveAdditiveSpeed(arg_29_0)
	arg_29_0._additiveSpeed = Vector3.zero

	return
end

function var_0_1.ActiveUnstoppable(arg_30_0, arg_30_1)
	arg_30_0._unstoppable = arg_30_1

	return
end

return
