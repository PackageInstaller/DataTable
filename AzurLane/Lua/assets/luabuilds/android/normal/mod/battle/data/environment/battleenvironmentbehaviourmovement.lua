ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConst
local var_0_2 = var_0.Battle.BattleConfig

class = var_0_10003

local var_0_3 = var_0_10003("BattleEnvironmentBehaviourMovement", var_0.Battle.BattleEnvironmentBehaviour)

var_0.Battle.BattleEnvironmentBehaviourMovement = var_0_3
var_0_3.__name = "BattleEnvironmentBehaviourMovement"

function var_0_3.Ctor(arg_1_0)
	arg_1_0._movebeginTime = nil
	arg_1_0._moveEndTime = nil
	arg_1_0._lastPosition = nil
	arg_1_0._destPosition = nil
	arg_1_0._targetIndex = 1

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

	local var_2_1

	if not arg_2_1.random_duration then
		var_2_1 = {
			1,
			5
		}
	end

	arg_2_0._random_duration = var_2_1

	local var_2_2

	if not arg_2_1.random_speed then
		var_2_2 = 1
	end

	arg_2_0._random_speed = var_2_2

	local var_2_3 = arg_2_0._unit
	local var_2_4 = var_2.GetTemplate(var_2_3)
	local var_2_5
	local var_2_6

	if #var_2_4.cld_data == 1 then
		var_2_6 = var_2_4.cld_data[1]
	elseif #var_2_4.cld_data == 2 then
		unpack = var_5
		var_2_5, var_2_6 = var_5(var_2_4.cld_data)
	end

	local var_2_7 = {}
	local var_2_8 = var_0.Battle.BattleDataProxy.GetInstance()

	var_2_7[1] = var_6.GetFleetBoundByIFF(var_2_8, var_0_2.FRIENDLY_CODE)
	var_2_7[3] = var_2_7[3] + var_2_5
	var_2_7[4] = var_2_7[4] - var_2_5
	var_2_7[2] = var_2_7[2] + var_2_6
	var_2_7[1] = var_2_7[1] - var_2_6
	arg_2_0._bounds = var_2_7
	Vector3 = var_6
	unpack = var_2_8
	arg_2_0._lastPosition = var_6(var_2_8(var_2_4.coordinate))

	if arg_2_1.random_range then
		arg_2_0._randomRangeX = arg_2_1.random_range[1]
		arg_2_0._randomRangeZ = arg_2_1.random_range[2]
		arg_2_0._resetRandomRange = true
	end

	return
end

function var_0_3.doBehaviour(arg_3_0)
	pg = var_1_10001

	local var_3_0 = var_1_10001.TimeMgr.GetInstance()
	local var_3_1 = var_1.GetCombatTime(var_3_0)

	if not arg_3_0._moveEndTime then
		local var_3_2 = arg_3_0._route[arg_3_0._targetIndex]

		arg_3_0._movebeginTime = var_3_1

		if var_3_2 then
			Vector3 = var_3
			unpack = var_1_10004
			arg_3_0._destPosition = var_3(var_1_10004(var_3_2))
			arg_3_0._moveEndTime = var_3_1 + var_3_2[4]
			arg_3_0._targetIndex = arg_3_0._targetIndex + 1
		else
			local var_3_3 = arg_3_0
			local var_3_4 = arg_3_0.GenerateRandomPlayerAreaPoint(var_3_3)

			math = var_3_3

			local var_3_5 = var_3_3.random

			unpack = var_1_10005

			local var_3_6 = var_3_5(var_1_10005(arg_3_0._random_duration)) * arg_3_0._random_speed
			local var_3_7 = var_3_4 - arg_3_0._lastPosition
			local var_3_8

			if var_6.Magnitude(var_3_7) < var_3_6 then
				var_3_8 = var_6 / arg_3_0._random_speed
			else
				Vector3 = var_3_7
				var_3_4 = var_3_7.Lerp(arg_3_0._lastPosition, var_3_4, var_3_6 / var_6)
			end

			arg_3_0._moveEndTime = var_3_1 + var_3_8
			arg_3_0._destPosition = var_3_4
		end
	end

	if var_3_1 < arg_3_0._moveEndTime then
		Vector3 = var_2

		local var_3_9 = var_2.Lerp(arg_3_0._lastPosition, arg_3_0._destPosition, (var_3_1 - arg_3_0._movebeginTime) / (arg_3_0._moveEndTime - arg_3_0._movebeginTime))
		local var_3_10 = arg_3_0._unit._aoeData

		var_3.SetPosition(var_3_10, var_3_9)
	else
		local var_3_11 = arg_3_0._unit._aoeData

		var_2.SetPosition(var_3_11, arg_3_0._destPosition)

		arg_3_0._lastPosition = arg_3_0._destPosition
		arg_3_0._moveEndTime = nil
	end

	var_0_3.super.doBehaviour(arg_3_0)

	return
end

function var_0_3.GenerateRandomPlayerAreaPoint(arg_4_0)
	local var_4_0 = arg_4_0._bounds

	math = var_1_10002

	local var_4_1 = var_1_10002.random(var_4_0[3], var_4_0[4])

	math = var_3

	local var_4_2 = var_3.random(var_4_0[2], var_4_0[1])

	if arg_4_0._resetRandomRange then
		arg_4_0:resetRandomBound(var_4_1, var_4_2)
	end

	Vector3 = var_4

	return var_4(var_4_1, 0, var_4_2)
end

function var_0_3.resetRandomBound(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0._bounds[3] = arg_5_1 - arg_5_0._randomRangeX
	arg_5_0._bounds[4] = arg_5_1 + arg_5_0._randomRangeX
	arg_5_0._bounds[2] = arg_5_2 - arg_5_0._randomRangeZ
	arg_5_0._bounds[1] = arg_5_2 + arg_5_0._randomRangeZ
	arg_5_0._resetRandomRange = false

	return
end

function var_0_3.Dispose(arg_6_0)
	var_0_3.super.Dispose(arg_6_0)

	table = var_1

	var_1.clear(arg_6_0)

	return
end

return
