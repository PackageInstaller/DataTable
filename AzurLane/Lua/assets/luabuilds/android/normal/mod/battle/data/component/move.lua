ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleVariable

class = var_0_10001

local var_0_2 = var_0_10001("MoveComponent")

ys = var_2

local var_0_3 = var_2.Battle

var_0_3.MoveComponent = var_0_2
ys = var_0_3

local var_0_4 = var_0_3.Battle.BattleConst

ys = var_0_10003

local var_0_5 = var_0_10003.Battle.BattleFormulas

Vector3 = var_0_10004
var_0_2._pos = var_0_10004.zero
var_0_2._isForceMove = false
var_0_2._staticState = false
Vector3 = var_4
var_0_2._speed = var_4.zero
var_0_2._additiveSpeedList = {}
Vector3 = var_4
var_0_2._additiveSpeed = var_4.zero
var_0_2._corpsLimitSpeed = 0
var_0_2._leftCorpsBound = 0
var_0_2._rightCorpsBound = 0
var_0_2._immuneAreaLimit = false
var_0_2._immuneMaxAreaLimit = false
var_0_2._leftBorder = 0
var_0_2._rightBorder = 0
var_0_2._upBorder = 0
var_0_2._downBorder = 0
var_0_2._IFF = 0

function var_0_2.Ctor(arg_1_0)
	return
end

function var_0_2.GetPos(arg_2_0)
	return arg_2_0._pos
end

function var_0_2.SetPos(arg_3_0, arg_3_1)
	arg_3_0._pos = arg_3_1

	return
end

function var_0_2.Update(arg_4_0)
	arg_4_0._speed = arg_4_0:GetFinalSpeed()

	return
end

function var_0_2.FixSpeed(arg_5_0, arg_5_1)
	assert = var_1_10002

	if arg_5_1.FixSpeed ~= nil then
		type = var_3

		local var_5_0

		if var_3(arg_5_1.FixSpeed) ~= "function" then
			var_5_0 = false
		else
			var_5_0 = true
		end

		var_1_10002(var_5_0, " MoveComponent.FixSpeed 速度修正出错")
		arg_5_1:FixSpeed(arg_5_0._speed)

		return
	end
end

function var_0_2.Move(arg_6_0, arg_6_1)
	arg_6_1 = arg_6_1 or 1
	arg_6_0._pos.x = arg_6_0._pos.x + arg_6_0._speed.x * arg_6_1
	arg_6_0._pos.y = arg_6_0._pos.y + arg_6_0._speed.y * arg_6_1
	arg_6_0._pos.z = arg_6_0._pos.z + arg_6_0._speed.z * arg_6_1

	return
end

function var_0_2.GetSpeed(arg_7_0)
	return arg_7_0._speed
end

function var_0_2.SetCorpsArea(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0._leftCorpsBound = arg_8_1
	arg_8_0._rightCorpsBound = arg_8_2

	return
end

function var_0_2.SetBorder(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	arg_9_0._leftBorder = arg_9_1
	arg_9_0._rightBorder = arg_9_2
	arg_9_0._upBorder = arg_9_3
	arg_9_0._downBorder = arg_9_4

	return
end

function var_0_2.GetFinalSpeed(arg_10_0)
	local var_10_0 = arg_10_0:getInitialSpeed()

	if not arg_10_0._unstoppable then
		var_10_0 = arg_10_0:AdditiveForce(var_10_0)
	end

	return (arg_10_0:BorderLimit(var_10_0))
end

function var_0_2.CorpsAreaLimit(arg_11_0, arg_11_1)
	if arg_11_0._immuneAreaLimit then
		return arg_11_1
	end

	local var_11_0 = arg_11_0._pos.x
	local var_11_1 = arg_11_0._corpsLimitSpeed

	if var_11_0 < arg_11_0._leftCorpsBound then
		math = var_4
		var_11_1 = var_4.max(var_11_1, 0.1)

		if arg_11_1.x < 0 then
			math = var_4
			var_11_1 = var_4.min(10, var_11_1 * 1.04)
		end
	elseif arg_11_0._rightCorpsBound < var_11_0 then
		math = var_4
		var_11_1 = var_4.min(var_11_1, -0.1)

		if arg_11_1.x > 0 then
			math = var_4
			var_11_1 = var_4.max(-10, var_11_1 * 1.04)
		end
	else
		var_11_1 = var_11_1 < 0.1 and var_11_1 > -0.1 and 0 or var_11_1 * 0.8
	end

	arg_11_0._corpsLimitSpeed = var_11_1
	arg_11_1.x = arg_11_1.x + arg_11_0._corpsLimitSpeed

	return arg_11_1
end

function var_0_2.BorderLimit(arg_12_0, arg_12_1)
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

function var_0_2.ImmuneAreaLimit(arg_13_0, arg_13_1)
	arg_13_0._immuneAreaLimit = arg_13_1

	return
end

function var_0_2.ImmuneMaxAreaLimit(arg_14_0, arg_14_1)
	arg_14_0._immuneMaxAreaLimit = arg_14_1

	return
end

function var_0_2.getInitialSpeed(arg_15_0)
	if arg_15_0._isForceMove and not arg_15_0._unstoppable then
		local var_15_0 = arg_15_0._forceSpeed

		arg_15_0:UpdateForceMove()

		return var_15_0
	end

	if arg_15_0._moveProcess then
		return arg_15_0._moveProcess()
	end

	if arg_15_0._staticState then
		Vector3 = var_1

		return var_1.zero
	end

	if arg_15_0._manuallyMove then
		return arg_15_0:CorpsAreaLimit(arg_15_0._manuallyMove())
	end

	assert = var_1

	var_1(arg_15_0._autoMoveAi ~= nil, "角色缺少默认移动的ai")

	return arg_15_0._autoMoveAi()
end

function var_0_2.SetForceMove(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4, arg_16_5)
	arg_16_0._isForceMove = true
	arg_16_0._forceSpeed = arg_16_1.normalized * arg_16_2
	arg_16_0._forceReduce = arg_16_1 * arg_16_3
	arg_16_0._forceLastTime = arg_16_4
	arg_16_0._decayValve = arg_16_5 or 0

	return
end

function var_0_2.UpdateForceMove(arg_17_0)
	if arg_17_0._forceLastTime <= 0 then
		arg_17_0:ClearForceMove()

		return
	end

	arg_17_0._forceLastTime = var_1 - 1

	if var_1 < arg_17_0._decayValve then
		local var_17_0 = arg_17_0._forceSpeed

		var_2.Sub(var_17_0, arg_17_0._forceReduce)
	end

	return
end

function var_0_2.ClearForceMove(arg_18_0)
	arg_18_0._isForceMove = false
	arg_18_0._forceSpeed = nil
	arg_18_0._forceReduce = nil
	arg_18_0._forceLastTime = nil

	return
end

function var_0_2.SetMoveProcess(arg_19_0, arg_19_1)
	arg_19_0._moveProcess = arg_19_1

	return
end

function var_0_2.SetStaticState(arg_20_0, arg_20_1)
	arg_20_0._staticState = arg_20_1

	return
end

function var_0_2.SetAutoMoveAI(arg_21_0, arg_21_1, arg_21_2)
	function arg_21_0._autoMoveAi()
		local var_22_0 = arg_21_1
		local var_22_1 = var_0.GetDirection(var_22_0)
		local var_22_2 = var_0.Mul
		local var_22_3 = arg_21_2

		return var_22_2(var_22_1, var_3.GetAttrByName(var_22_3, "velocity"))
	end

	return
end

function var_0_2.SetFormationCtrlInfo(arg_23_0, arg_23_1)
	function arg_23_0._manuallyMove()
		local var_24_0 = arg_23_0

		return var_0.UpdateFleetInfo(var_24_0, arg_23_1)
	end

	return
end

function var_0_2.CancelFormationCtrl(arg_25_0)
	arg_25_0._manuallyMove = nil

	return
end

function var_0_2.SetMotionVO(arg_26_0, arg_26_1)
	arg_26_0._fleetMotionVO = arg_26_1

	return
end

function var_0_2.UpdateFleetInfo(arg_27_0, arg_27_1)
	local var_27_0 = arg_27_0._fleetMotionVO
	local var_27_1 = var_2.GetSpeed(var_27_0)

	if arg_27_1:EqualZero() then
		return var_27_1
	end

	local var_27_2 = var_2:GetPos()
	local var_27_3 = var_2:GetDirAngle() * arg_27_1
	local var_27_4 = var_5.Add(var_27_3, var_27_2)
	local var_27_5 = var_6.Sub(var_27_4, arg_27_0._pos)
	local var_27_6 = var_6.Div(var_27_5, 25)

	return var_6.Add(var_27_6, var_27_1)
end

function var_0_2.AdditiveForce(arg_28_0, arg_28_1)
	arg_28_1.x = arg_28_1.x + arg_28_0._additiveSpeed.x
	arg_28_1.z = arg_28_1.z + arg_28_0._additiveSpeed.z

	return arg_28_1
end

function var_0_2.UpdateAdditiveSpeed(arg_29_0, arg_29_1)
	arg_29_0._additiveSpeed = arg_29_1

	return
end

function var_0_2.RemoveAdditiveSpeed(arg_30_0)
	Vector3 = var_1_10001
	arg_30_0._additiveSpeed = var_1_10001.zero

	return
end

function var_0_2.ActiveUnstoppable(arg_31_0, arg_31_1)
	arg_31_0._unstoppable = arg_31_1

	return
end

return
