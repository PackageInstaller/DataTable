class = var_0_10000

local var_0_0 = "WorldBuff"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...BaseEntity"))

var_0_1.Fields = {
	config = "table",
	floor = "number",
	time = "number",
	id = "number",
	round = "number",
	step = "number"
}
var_0_1.TrapCompassInterference = 1
var_0_1.TrapVortex = 2
var_0_1.TrapFire = 3
var_0_1.TrapDisturbance = 4
var_0_1.TrapCripple = 5
var_0_1.TrapFrozen = 6

function var_0_1.GetTemplate(arg_1_0)
	assert = var_1_10001
	pg = var_1_10002

	var_1_10001(var_1_10002.world_SLGbuff_data[arg_1_0], "without this buff " .. arg_1_0)

	pg = var_1_10001

	return var_1_10001.world_SLGbuff_data[arg_1_0]
end

function var_0_1.Setup(arg_2_0, arg_2_1)
	arg_2_0.id = arg_2_1.id
	arg_2_0.config = var_0_1.GetTemplate(arg_2_0.id)
	assert = var_2

	var_2(arg_2_0.config, "world_SLGbuff_data not exist: " .. arg_2_0.id)

	math = var_2
	arg_2_0.floor = var_2.min(arg_2_1.floor, arg_2_0:GetMaxFloor())

	local var_2_0

	if arg_2_1.time == 0 or not arg_2_1.time then
		var_2_0 = nil
	end

	arg_2_0.time = var_2_0

	local var_2_1

	if arg_2_1.round == 0 or not arg_2_1.round then
		var_2_1 = nil
	end

	arg_2_0.round = var_2_1

	local var_2_2

	if arg_2_1.step == 0 or not arg_2_1.step then
		var_2_2 = nil
	end

	arg_2_0.step = var_2_2

	return
end

function var_0_1.IsValid(arg_3_0)
	local var_3_2

	if arg_3_0.time then
		local var_3_0 = arg_3_0.time

		pg = var_1_10002

		local var_3_1 = var_1_10002.TimeMgr.GetInstance()

		if not (var_3_0 > var_2.GetServerTime(var_3_1)) then
			var_3_2 = false

			goto label_3_0
		end
	end

	var_3_2 = true

	::label_3_0::

	return var_3_2
end

function var_0_1.CheckValid(arg_4_0)
	if not arg_4_0:IsValid() then
		arg_4_0.floor = 0
	end

	return
end

function var_0_1.GetMaxFloor(arg_5_0)
	return arg_5_0.config.buff_maxfloor
end

function var_0_1.GetTrapType(arg_6_0)
	return arg_6_0.config.trap_type
end

function var_0_1.GetTrapParams(arg_7_0)
	return arg_7_0.config.trap_parameter
end

function var_0_1.GetLost(arg_8_0)
	if arg_8_0.step and arg_8_0.round then
		math = var_1

		return var_1.min(arg_8_0.step, arg_8_0.round)
	else
		local var_8_0

		if not arg_8_0.step then
			var_8_0 = arg_8_0.round
		end

		return var_8_0
	end

	return
end

function var_0_1.AddFloor(arg_9_0, arg_9_1)
	arg_9_0:CheckValid()

	math = var_2
	arg_9_0.floor = var_2.clamp(arg_9_0.floor + arg_9_1, 0, 999)

	return
end

function var_0_1.GetFloor(arg_10_0)
	arg_10_0:CheckValid()

	math = var_1

	return var_1.min(arg_10_0.floor, arg_10_0:GetMaxFloor())
end

return var_0_1
