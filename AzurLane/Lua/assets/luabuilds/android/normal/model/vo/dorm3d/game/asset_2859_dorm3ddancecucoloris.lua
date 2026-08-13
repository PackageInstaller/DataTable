class = var_0_10000

local var_0_0 = "Dorm3dDanceCucoloris"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("model.vo.BaseVO"))

function var_0_1.bindConfigTable(arg_1_0)
	pg = var_1_10001

	return var_1_10001.dorm3d_dance_cucoloris
end

function var_0_1.GetTime(arg_2_0)
	return arg_2_0:getConfig("time")
end

function var_0_1.GetCamera(arg_3_0)
	return arg_3_0:getConfig("target_camera")
end

function var_0_1.GetIcon(arg_4_0)
	return "dorm3dcucoloris/" .. arg_4_0:getConfig("icon")
end

function var_0_1.GetOutline(arg_5_0)
	return arg_5_0:GetIcon() .. "_outline"
end

function var_0_1.CalcScore(arg_6_0, arg_6_1)
	math = var_1_10002

	local var_6_0 = var_1_10002.abs(arg_6_1.time - arg_6_0:GetTime())
	local var_6_1 = arg_6_1.camera
	local var_6_2 = arg_6_0

	if var_6_1 ~= arg_6_0.GetCamera(var_6_2) then
		return 0, 0, var_6_0
	end

	local var_6_3 = 100

	if 0.2 < var_6_0 then
		math = var_4

		local var_6_4 = var_4.floor

		math = var_6_2
		var_6_3 = var_6_3 - var_6_4(var_6_2.min(var_6_0 - 0.2, 0.8) / 0.04)
	end

	if 1 < var_6_0 then
		math = var_4
		var_6_3 = var_6_3 - var_4.floor((var_6_0 - 1) / 0.02)
	end

	if var_6_3 < 0 then
		var_6_3 = 0
	end

	return var_6_3 * 10, var_6_3, var_6_0
end

return var_0_1
