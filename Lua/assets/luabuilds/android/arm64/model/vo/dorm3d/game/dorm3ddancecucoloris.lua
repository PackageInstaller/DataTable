local var_0_0 = class("Dorm3dDanceCucoloris", import("model.vo.BaseVO"))

function var_0_0.bindConfigTable(arg_1_0)
	return pg.dorm3d_dance_cucoloris
end

function var_0_0.GetTime(arg_2_0)
	return arg_2_0:getConfig("time")
end

function var_0_0.GetCamera(arg_3_0)
	return arg_3_0:getConfig("target_camera")
end

function var_0_0.GetIcon(arg_4_0)
	return "dorm3dcucoloris/" .. arg_4_0:getConfig("icon")
end

function var_0_0.GetOutline(arg_5_0)
	return arg_5_0:GetIcon() .. "_outline"
end

function var_0_0.CalcScore(arg_6_0, arg_6_1)
	local var_6_0 = math.abs(arg_6_1.time - arg_6_0:GetTime())

	if arg_6_1.camera ~= arg_6_0:GetCamera() then
		return 0, 0, var_6_0
	end

	local var_6_1 = 100

	if var_6_0 > 0.2 then
		var_6_1 = var_6_1 - math.floor(math.min(var_6_0 - 0.2, 0.8) / 0.04)
	end

	if var_6_0 > 1 then
		var_6_1 = var_6_1 - math.floor((var_6_0 - 1) / 0.02)
	end

	if var_6_1 < 0 then
		var_6_1 = 0
	end

	return var_6_1 * 10, var_6_1, var_6_0
end

return var_0_0
