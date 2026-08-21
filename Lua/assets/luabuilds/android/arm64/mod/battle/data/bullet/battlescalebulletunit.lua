ys = ys or {}
ys.Battle.BattleScaleBulletUnit = class("BattleScaleBulletUnit", ys.Battle.BattleBulletUnit)
ys.Battle.BattleScaleBulletUnit.__name = "BattleScaleBulletUnit"

local var_0_5 = ys.Battle.BattleScaleBulletUnit

function ys.Battle.BattleScaleBulletUnit.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_5.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0._scaleX = 0

	return
end

function ys.Battle.BattleScaleBulletUnit.Update(arg_2_0, arg_2_1)
	if arg_2_0._scaleX + arg_2_0._tempData.cld_box[1] > arg_2_0._scaleLimit then
		arg_2_0:calcSpeed()
	else
		arg_2_0:UpdateCLDBox()
	end

	var_0_5.super.Update(arg_2_0, arg_2_1)

	return
end

function ys.Battle.BattleScaleBulletUnit.SetTemplateData(arg_3_0, arg_3_1)
	var_0_5.super.SetTemplateData(arg_3_0, arg_3_1)

	arg_3_0._scaleSpeed = arg_3_0._tempData.extra_param.scaleSpeed
	arg_3_0._scaleLimit = arg_3_0._tempData.extra_param.cldMax

	return
end

function ys.Battle.BattleScaleBulletUnit.InitSpeed(arg_4_0, arg_4_1)
	var_0_5.super.InitSpeed(arg_4_0, arg_4_1)
	arg_4_0:calcScaleSpeed()

	return
end

function ys.Battle.BattleScaleBulletUnit.calcScaleSpeed(arg_5_0)
	arg_5_0._speed = Vector3(arg_5_0._scaleSpeed * 0.5 * math.cos(math.deg2Rad * arg_5_0._yAngle), 0, arg_5_0._scaleSpeed * 0.5 * math.sin(math.deg2Rad * arg_5_0._yAngle))

	return
end

function ys.Battle.BattleScaleBulletUnit.UpdateCLDBox(arg_6_0)
	arg_6_0._scaleX = arg_6_0._scaleX + arg_6_0._scaleSpeed

	arg_6_0._cldComponent:ResetSize(arg_6_0._tempData.cld_box[1] + arg_6_0._scaleX, arg_6_0._tempData.cld_box[2], arg_6_0._tempData.cld_box[3])

	return
end

function ys.Battle.BattleScaleBulletUnit.GetRadian(arg_7_0)
	local var_7_0 = arg_7_0._radCache or arg_7_0:GetYAngle() * math.deg2Rad
	local var_7_1 = arg_7_0._cosCache or math.cos(var_7_0)
	local var_7_2 = arg_7_0._sinCache or math.sin(var_7_0)

	return var_7_0, var_7_1, var_7_2
end

return
