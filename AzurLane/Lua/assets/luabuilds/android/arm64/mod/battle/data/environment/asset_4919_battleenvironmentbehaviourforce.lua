ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConst
local var_0_2 = var_0.Battle.BattleConfig

class = var_0_10003

local var_0_3 = var_0_10003("BattleEnvironmentBehaviourForce", var_0.Battle.BattleEnvironmentBehaviour)

var_0.Battle.BattleEnvironmentBehaviourForce = var_0_3
var_0_3.__name = "BattleEnvironmentBehaviourForce"

function var_0_3.Ctor(arg_1_0)
	arg_1_0._moveEndTime = nil
	arg_1_0._lastSpeed = nil
	Vector3 = var_1
	arg_1_0._speed = var_1.zero
	arg_1_0._targetIndex = 0

	var_0_3.super.Ctor(arg_1_0)

	return
end

function var_0_3.SetTemplate(arg_2_0, arg_2_1)
	var_0_3.super.SetTemplate(arg_2_0, arg_2_1)

	local var_2_0

	if not arg_2_1.route then
		var_2_0 = {}
	end

	arg_2_0._route = var_2_0
	pg = var_2_0

	local var_2_1 = var_2_0.TimeMgr.GetInstance()

	arg_2_0._moveEndTime = var_2.GetCombatTime(var_2_1)

	local var_2_2 = arg_2_0._unit
	local var_2_3 = var_2.GetTemplate(var_2_2)
	local var_2_4
	local var_2_5

	if #var_2_3.cld_data == 1 then
		var_2_5 = var_2_3.cld_data[1]
	elseif #var_2_3.cld_data == 2 then
		unpack = var_5
		var_2_4, var_2_5 = var_5(var_2_3.cld_data)
	end

	local var_2_6 = {}
	local var_2_7 = var_0.Battle.BattleDataProxy.GetInstance()

	var_2_6[1] = var_6.GetTotalBounds(var_2_7)
	var_2_6[3] = var_2_6[3] + var_2_4
	var_2_6[4] = var_2_6[4] - var_2_4
	var_2_6[2] = var_2_6[2] + var_2_5
	var_2_6[1] = var_2_6[1] - var_2_5
	arg_2_0._bounds = var_2_6

	return
end

function var_0_3.doBehaviour(arg_3_0)
	pg = var_1_10001

	local var_3_0 = var_1_10001.TimeMgr.GetInstance()
	local var_3_1 = var_1.GetCombatTime(var_3_0)

	if arg_3_0._moveEndTime and var_3_1 >= arg_3_0._moveEndTime then
		arg_3_0._targetIndex = arg_3_0._targetIndex + 1
		arg_3_0._moveEndTime = nil

		if arg_3_0._lastSpeed then
			local var_3_2 = arg_3_0._speed

			var_2.Add(var_3_2, arg_3_0._lastSpeed)

			arg_3_0._lastSpeed = nil
		end

		if arg_3_0._route[arg_3_0._targetIndex] then
			Vector3 = var_3
			unpack = var_1_10005

			local var_3_3 = var_3(var_1_10005(var_2))

			arg_3_0._lastSpeed = var_3.Normalize(var_3_3) * var_2[4]
			arg_3_0._moveEndTime = var_3_1 + var_2[5]
		end
	end

	local var_3_4 = arg_3_0._unit._aoeData
	local var_3_5 = var_2.GetPosition(var_3_4)
	local var_3_6 = arg_3_0:UpdateAndRestrictPosition(var_3_5)
	local var_3_7 = arg_3_0._unit._aoeData

	var_4.SetPosition(var_3_7, var_3_6)
	var_0_3.super.doBehaviour(arg_3_0)

	return
end

function var_0_3.UpdateAndRestrictPosition(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0._speed

	if var_2.SqrMagnitude(var_4_0) < 0.01 then
		return arg_4_1
	end

	local var_4_1 = arg_4_0._bounds

	if (arg_4_1 + arg_4_0._speed).x < var_4_1[3] then
		local var_4_2 = arg_4_0._speed

		math = var_5
		var_4_2.x = var_5.abs(arg_4_0._speed.x)

		local var_4_3 = var_4_1[3]

		math = var_5
		var_3.x = var_4_3 + var_5.abs(var_3.x - var_4_1[3])
	elseif var_4_1[4] < var_3.x then
		local var_4_4 = arg_4_0._speed

		math = var_5
		var_4_4.x = -var_5.abs(arg_4_0._speed.x)

		local var_4_5 = var_4_1[4]

		math = var_5
		var_3.x = var_4_5 - var_5.abs(var_3.x - var_4_1[4])
	end

	if var_3.z < var_4_1[2] then
		local var_4_6 = arg_4_0._speed

		math = var_5
		var_4_6.z = var_5.abs(arg_4_0._speed.z)

		local var_4_7 = var_4_1[2]

		math = var_5
		var_3.z = var_4_7 + var_5.abs(var_3.z - var_4_1[2])
	elseif var_4_1[1] < var_3.z then
		local var_4_8 = arg_4_0._speed

		math = var_5
		var_4_8.z = -var_5.abs(arg_4_0._speed.z)

		local var_4_9 = var_4_1[1]

		math = var_5
		var_3.z = var_4_9 - var_5.abs(var_3.z - var_4_1[1])
	end

	return var_3
end

function var_0_3.Dispose(arg_5_0)
	var_0_3.super.Dispose(arg_5_0)

	table = var_1

	var_1.clear(arg_5_0)

	return
end

return
