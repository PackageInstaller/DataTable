ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConfig

class = var_0_10002

local var_0_2 = var_0_10002("BattleBuffAddForce", var_0.Battle.BattleBuffEffect)

var_0.Battle.BattleBuffAddForce = var_0_2
var_0_2.__name = "BattleBuffAddForce"

function var_0_2.Ctor(arg_1_0, arg_1_1)
	var_0_2.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_2.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0

	if not arg_2_0._tempData.arg_list.singularity then
		var_2_0 = {
			x = 0,
			z = 0
		}
	end

	arg_2_0._singularity = var_2_0
	arg_2_0._casterGravity = arg_2_0._tempData.arg_list.gravitationalCaster
	arg_2_0._force = arg_2_0._tempData.arg_list.force
	arg_2_0._forceScalteRate = arg_2_0._tempData.arg_list.scale_rate

	if not arg_2_0._casterGravity then
		Vector3 = var_3
		arg_2_0._staticSingularity = var_3.New(arg_2_0._singularity.x, 0, arg_2_0._singularity.z)
	else
		local var_2_1 = arg_2_2
		local var_2_2 = arg_2_2.GetCaster(var_2_1)
		local var_2_3 = var_3.GetIFF(var_2_2)

		Vector3 = var_2_1
		arg_2_0._singularityOffset = var_2_1.New(arg_2_0._singularity.x * var_2_3, 0, arg_2_0._singularity.z)
	end

	return
end

function var_0_2.onUpdate(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0

	if arg_3_0._casterGravity then
		local var_3_1 = arg_3_2:GetCaster()

		var_3_0 = var_4.GetPosition(var_3_1) + arg_3_0._singularityOffset
	else
		var_3_0 = arg_3_0._staticSingularity
	end

	pg = var_4

	local var_3_2 = var_4.Tool.FilterY(var_3_0 - arg_3_1:GetPosition())
	local var_3_3 = arg_3_0._force

	if var_3_2.magnitude < 2 then
		var_3_3 = 1e-08
	elseif arg_3_0._forceScalteRate then
		math = var_7
		var_3_3 = var_7.min(var_6, 1 / var_6 * var_3_3)
	end

	arg_3_1:SetUncontrollableSpeed(var_3_2, var_3_3, 1e-18)

	arg_3_0._lastSingularityPos = var_3_0

	return
end

function var_0_2.onAttach(arg_4_0, arg_4_1, arg_4_2)
	return
end

function var_0_2.onRemove(arg_5_0, arg_5_1, arg_5_2)
	pg = var_1_10003

	local var_5_0 = var_1_10003.Tool.FilterY(arg_5_0._lastSingularityPos - arg_5_1:GetPosition())

	arg_5_1:SetUncontrollableSpeed(var_5_0, 0.1, 0.1)

	return
end

return
