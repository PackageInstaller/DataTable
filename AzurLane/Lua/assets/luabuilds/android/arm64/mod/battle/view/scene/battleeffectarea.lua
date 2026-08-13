ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConst
local var_0_2 = var_0.Battle.BattleConfig

class = var_0_10003

local var_0_3 = var_0_10003("BattleEffectArea")

var_0.Battle.BattleEffectArea = var_0_3
var_0_3.__name = "BattleEffectArea"
Vector3 = var_4

local var_0_4 = var_4(0, 3.5, -5)

function var_0_3.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._go = arg_1_1
	arg_1_0._aoeData = arg_1_2
	arg_1_0._topCover = arg_1_3

	arg_1_0:Init()

	return
end

function var_0_3.Init(arg_2_0)
	arg_2_0._tf = arg_2_0._go.transform

	local var_2_0 = arg_2_0._aoeData

	arg_2_0._areaType = var_1.GetAreaType(var_2_0)

	if arg_2_0._areaType == var_0_1.AreaType.CUBE or arg_2_0._areaType == var_0_1.AreaType.ELLIPSE then
		arg_2_0.UpdateScale = arg_2_0.updateCubeScale
	elseif arg_2_0._areaType == var_0_1.AreaType.COLUMN then
		arg_2_0.UpdateScale = arg_2_0.updateColumnScale
	end

	local var_2_1 = arg_2_0._aoeData

	if var_1.GetIFF(var_2_1) == var_0_2.FOE_CODE then
		function arg_2_0.GetAngle()
			local var_3_0 = arg_2_0._aoeData

			return var_0.GetAngle(var_3_0) * -1 + 180
		end
	else
		function arg_2_0.GetAngle()
			local var_4_0 = arg_2_0._aoeData

			return var_0.GetAngle(var_4_0) * -1
		end
	end

	arg_2_0:Update()

	return
end

function var_0_3.Update(arg_5_0)
	arg_5_0:UpdateScale()
	arg_5_0:UpdatePosition()
	arg_5_0:UpdateRotation()

	return
end

function var_0_3.updateCubeScale(arg_6_0)
	local var_6_0 = 1
	local var_6_1 = 1
	local var_6_2 = arg_6_0._aoeData

	if not var_3.GetFXStatic(var_6_2) then
		local var_6_3 = arg_6_0._aoeData
		local var_6_4 = var_3.GetWidth(var_6_3)
		local var_6_5 = arg_6_0._aoeData

		var_6_0 = var_6_4 * var_1_10004.GetIFF(var_6_5)

		local var_6_6 = arg_6_0._aoeData

		var_6_1 = var_3.GetHeight(var_6_6)
	end

	if var_6_0 == arg_6_0._preWidth and var_6_1 == arg_6_0._preHeight then
		return
	end

	local var_6_7 = arg_6_0._tf

	Vector3 = var_1_10004
	var_6_7.localScale = var_1_10004(var_6_0, 1, var_6_1)
	arg_6_0._preWidth = var_6_0
	arg_6_0._preHeight = var_6_1

	return
end

function var_0_3.updateColumnScale(arg_7_0)
	local var_7_0 = arg_7_0._aoeData

	if var_1.GetRange(var_7_0) == arg_7_0._preRange then
		return
	end

	local var_7_1 = arg_7_0._tf

	Vector3 = var_7_0
	var_7_1.localScale = var_7_0(var_1, 1, var_1)
	arg_7_0._preRange = var_1

	return
end

function var_0_3.UpdatePosition(arg_8_0)
	if arg_8_0._topCover then
		local var_8_0 = arg_8_0._tf
		local var_8_1 = arg_8_0._aoeData

		var_8_0.position = var_2.GetPosition(var_8_1) + var_0_4
	else
		local var_8_2 = arg_8_0._tf
		local var_8_3 = arg_8_0._aoeData

		var_8_2.position = var_2.GetPosition(var_8_3)
	end

	return
end

function var_0_3.UpdateRotation(arg_9_0)
	local var_9_0 = arg_9_0
	local var_9_1 = arg_9_0.GetAngle(var_9_0)

	if arg_9_0._preAngle == var_9_1 then
		return
	end

	local var_9_2 = arg_9_0._tf

	Vector3 = var_9_0
	var_9_2.localEulerAngles = var_9_0(0, var_9_1, 0)
	arg_9_0._preAngle = var_9_1

	return
end

function var_0_3.Dispose(arg_10_0)
	local var_10_0 = var_0.Battle.BattleResourceManager.GetInstance()

	var_1.DestroyOb(var_10_0, arg_10_0._go)

	arg_10_0._go = nil

	return
end

return
