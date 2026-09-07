local Dorm3dDanceCucoloris = class("Dorm3dDanceCucoloris", import("model.vo.BaseVO"))

function Dorm3dDanceCucoloris:bindConfigTable()
	return pg.dorm3d_dance_cucoloris
end

function Dorm3dDanceCucoloris:GetTime()
	return self:getConfig("time")
end

function Dorm3dDanceCucoloris:GetCamera()
	return self:getConfig("target_camera")
end

function Dorm3dDanceCucoloris:GetIcon()
	return "dorm3dcucoloris/" .. self:getConfig("icon")
end

function Dorm3dDanceCucoloris:GetOutline()
	return self:GetIcon() .. "_outline"
end

function Dorm3dDanceCucoloris:CalcScore(arg_6_1)
	local var_6_0 = math.abs(arg_6_1.time - self:GetTime())

	if arg_6_1.camera ~= self:GetCamera() then
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

return Dorm3dDanceCucoloris
