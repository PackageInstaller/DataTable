ys = ys or {}

local var_0_1 = class("BattleLaserEffect", ys.Battle.BattleEffectArea)

ys.Battle.BattleLaserEffect = var_0_1
var_0_1.__name = "BattleLaserEffect"

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	return
end

function var_0_1.SetStatic(arg_2_0)
	return
end

function var_0_1.Init(arg_3_0)
	arg_3_0._tf = arg_3_0._go.transform
	arg_3_0._laserScript = GetComponent(arg_3_0._go, "LaserScript")
	arg_3_0._waveCount = 0

	arg_3_0:Update()

	return
end

function var_0_1.Update(arg_4_0)
	arg_4_0:updateLineRenderer()
	arg_4_0:UpdatePosition()

	return
end

function var_0_1.updateLineRenderer(arg_5_0)
	arg_5_0._laserScript.width = arg_5_0._aoeData:GetHeight() + math.cos(arg_5_0._waveCount * math.deg2Rad * 3)
	arg_5_0._waveCount = arg_5_0._waveCount + 1
	arg_5_0._laserScript.length = arg_5_0._aoeData:GetWidth()

	local var_5_0 = arg_5_0._aoeData:GetAngle() * math.deg2Rad

	if arg_5_0._aoeData:GetIFF() == -1 then
		var_5_0 = var_5_0 + math.pi
	end

	arg_5_0._laserScript.angle = var_5_0

	return
end

return
