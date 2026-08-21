ys = ys or {}

local var_0_1 = class("BattleBuffAddForce", ys.Battle.BattleBuffEffect)

ys.Battle.BattleBuffAddForce = var_0_1
var_0_1.__name = "BattleBuffAddForce"

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_1.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._singularity = arg_2_0._tempData.arg_list.singularity or {
		x = 0,
		z = 0
	}
	arg_2_0._casterGravity = arg_2_0._tempData.arg_list.gravitationalCaster
	arg_2_0._force = arg_2_0._tempData.arg_list.force
	arg_2_0._forceScalteRate = arg_2_0._tempData.arg_list.scale_rate

	if not arg_2_0._casterGravity then
		arg_2_0._staticSingularity = Vector3.New(arg_2_0._singularity.x, 0, arg_2_0._singularity.z)
	else
		local var_2_0 = arg_2_2:GetCaster()

		arg_2_0._singularityOffset = Vector3.New(arg_2_0._singularity.x * var_2_0:GetIFF(), 0, arg_2_0._singularity.z)
	end

	return
end

function var_0_1.onUpdate(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_0._casterGravity and arg_3_2:GetCaster():GetPosition() + arg_3_0._singularityOffset or arg_3_0._staticSingularity
	local var_3_1 = pg.Tool.FilterY(var_3_0 - arg_3_1:GetPosition())
	local var_3_2 = arg_3_0._force

	if var_3_1.magnitude < 2 then
		var_3_2 = 1e-08
	elseif arg_3_0._forceScalteRate then
		var_3_2 = math.min(var_3_1.magnitude, 1 / var_3_1.magnitude * var_3_2)
	end

	arg_3_1:SetUncontrollableSpeed(var_3_1, var_3_2, 1e-18)

	arg_3_0._lastSingularityPos = var_3_0

	return
end

function var_0_1.onAttach(arg_4_0, arg_4_1, arg_4_2)
	return
end

function var_0_1.onRemove(arg_5_0, arg_5_1, arg_5_2)
	arg_5_1:SetUncontrollableSpeed(pg.Tool.FilterY(arg_5_0._lastSingularityPos - arg_5_1:GetPosition()), 0.1, 0.1)

	return
end

return
