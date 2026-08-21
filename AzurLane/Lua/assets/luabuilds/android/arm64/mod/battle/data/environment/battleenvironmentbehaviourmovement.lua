ys = ys or {}

local var_0_1 = ys.Battle.BattleConfig
local var_0_2 = class("BattleEnvironmentBehaviourMovement", ys.Battle.BattleEnvironmentBehaviour)

ys.Battle.BattleEnvironmentBehaviourMovement = var_0_2
var_0_2.__name = "BattleEnvironmentBehaviourMovement"

function var_0_2.Ctor(arg_1_0)
	arg_1_0._movebeginTime = nil
	arg_1_0._moveEndTime = nil
	arg_1_0._lastPosition = nil
	arg_1_0._destPosition = nil
	arg_1_0._targetIndex = 1

	var_0_2.super.Ctor(arg_1_0)

	return
end

function var_0_2.SetTemplate(arg_2_0, arg_2_1)
	var_0_2.super.SetTemplate(arg_2_0, arg_2_1)

	arg_2_0._route = arg_2_1.route or {}
	arg_2_0._random_duration = arg_2_1.random_duration or {
		1,
		5
	}
	arg_2_0._random_speed = arg_2_1.random_speed or 1

	local var_2_0 = arg_2_0._unit:GetTemplate()
	local var_2_1
	local var_2_2

	if #var_2_0.cld_data == 1 then
		var_2_1 = var_2_0.cld_data[1]
		var_2_2 = var_2_0.cld_data[1]
	elseif #var_2_0.cld_data == 2 then
		var_2_1, var_2_2 = unpack(var_2_0.cld_data)
	end

	local var_2_3 = {}

	var_2_3[1] = var_0.Battle.BattleDataProxy.GetInstance():GetFleetBoundByIFF(var_0_1.FRIENDLY_CODE)
	var_2_3[3] = var_2_3[3] + var_2_1
	var_2_3[4] = var_2_3[4] - var_2_1
	var_2_3[2] = var_2_3[2] + var_2_2
	var_2_3[1] = var_2_3[1] - var_2_2
	arg_2_0._bounds = var_2_3
	arg_2_0._lastPosition = Vector3(unpack(var_2_0.coordinate))

	if arg_2_1.random_range then
		arg_2_0._randomRangeX = arg_2_1.random_range[1]
		arg_2_0._randomRangeZ = arg_2_1.random_range[2]
		arg_2_0._resetRandomRange = true
	end

	return
end

function var_0_2.doBehaviour(arg_3_0)
	local var_3_0 = pg.TimeMgr.GetInstance():GetCombatTime()

	if not arg_3_0._moveEndTime then
		arg_3_0._movebeginTime = var_3_0

		if arg_3_0._route[arg_3_0._targetIndex] then
			arg_3_0._destPosition = Vector3(unpack(arg_3_0._route[arg_3_0._targetIndex]))
			arg_3_0._moveEndTime = var_3_0 + arg_3_0._route[arg_3_0._targetIndex][4]
			arg_3_0._targetIndex = arg_3_0._targetIndex + 1
		else
			local var_3_1 = arg_3_0:GenerateRandomPlayerAreaPoint()
			local var_3_2 = math.random(unpack(arg_3_0._random_duration))
			local var_3_3 = (var_3_1 - arg_3_0._lastPosition):Magnitude()

			if var_3_3 < var_3_2 * arg_3_0._random_speed then
				var_3_2 = var_3_3 / arg_3_0._random_speed
			else
				var_3_1 = Vector3.Lerp(arg_3_0._lastPosition, var_3_1, var_3_2 * arg_3_0._random_speed / var_3_3)
			end

			arg_3_0._moveEndTime = var_3_0 + var_3_2
			arg_3_0._destPosition = var_3_1
		end
	end

	if var_3_0 < arg_3_0._moveEndTime then
		arg_3_0._unit._aoeData:SetPosition((Vector3.Lerp(arg_3_0._lastPosition, arg_3_0._destPosition, (var_3_0 - arg_3_0._movebeginTime) / (arg_3_0._moveEndTime - arg_3_0._movebeginTime))))
	else
		arg_3_0._unit._aoeData:SetPosition(arg_3_0._destPosition)

		arg_3_0._lastPosition = arg_3_0._destPosition
		arg_3_0._moveEndTime = nil
	end

	var_0_2.super.doBehaviour(arg_3_0)

	return
end

function var_0_2.GenerateRandomPlayerAreaPoint(arg_4_0)
	local var_4_0 = math.random(arg_4_0._bounds[3], arg_4_0._bounds[4])
	local var_4_1 = math.random(arg_4_0._bounds[2], arg_4_0._bounds[1])

	if arg_4_0._resetRandomRange then
		arg_4_0:resetRandomBound(var_4_0, var_4_1)
	end

	return Vector3(var_4_0, 0, var_4_1)
end

function var_0_2.resetRandomBound(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0._bounds[3] = arg_5_1 - arg_5_0._randomRangeX
	arg_5_0._bounds[4] = arg_5_1 + arg_5_0._randomRangeX
	arg_5_0._bounds[2] = arg_5_2 - arg_5_0._randomRangeZ
	arg_5_0._bounds[1] = arg_5_2 + arg_5_0._randomRangeZ
	arg_5_0._resetRandomRange = false

	return
end

function var_0_2.Dispose(arg_6_0)
	var_0_2.super.Dispose(arg_6_0)
	table.clear(arg_6_0)

	return
end

return
