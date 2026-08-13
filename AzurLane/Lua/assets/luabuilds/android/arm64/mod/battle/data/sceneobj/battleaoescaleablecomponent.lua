ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConst
local var_0_2 = var_0.Battle.BattleConfig

class = var_0_10003

local var_0_3 = var_0_10003("BattleAOEScaleableComponent")

var_0.Battle.BattleAOEScaleableComponent = var_0_3
var_0_3.__name = "BattleAOEScaleableComponent"
var_0_3.FILL = 1
var_0_3.EXPEND = 2

function var_0_3.Ctor(arg_1_0, arg_1_1)
	arg_1_0._area = arg_1_1

	local var_1_0 = arg_1_0._area

	var_2.AppendComponent(var_1_0, arg_1_0)

	local var_1_1 = arg_1_0._area.Settle

	function arg_1_0._area.Settle()
		local var_2_0 = arg_1_0

		var_0.updateScale(var_2_0)
		var_1_1(arg_1_0._area)

		return
	end

	return
end

function var_0_3.Dispose(arg_3_0)
	arg_3_0._area = nil
	arg_3_0._referenceUnit = nil

	return
end

function var_0_3.SetReferenceUnit(arg_4_0, arg_4_1)
	arg_4_0._referenceUnit = arg_4_1
	Clone = var_1_10002
	arg_4_0._referencePoint = var_1_10002(arg_4_1:GetPosition())

	return
end

function var_0_3.ConfigData(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_1 == var_0_3.FILL then
		arg_5_0.updateScale = var_0_3.doFill
		arg_5_0._upperBound = arg_5_2.upperBound
		arg_5_0._lowerBound = arg_5_2.lowerBound
		arg_5_0._rearBound = arg_5_2.rearBound
		arg_5_0._frontOffset = arg_5_2.frontOffset
	elseif arg_5_1 == var_0_3.EXPEND then
		local var_5_0 = arg_5_0._area

		var_3.SetFXStatic(var_5_0, false)

		arg_5_0.updateScale = var_0_3.doExpend
		arg_5_0._expendDuration = arg_5_2.expendDuration
		arg_5_0._widthExpendSpeed = arg_5_2.widthSpeed
		arg_5_0._heightExpendSpeed = arg_5_2.heightSpeed
		pg = var_3

		local var_5_1 = var_3.TimeMgr.GetInstance()

		arg_5_0._expendStartTime = var_3.GetCombatTime(var_5_1)
		pg = var_3

		local var_5_2 = var_3.TimeMgr.GetInstance()

		arg_5_0._lastExpendTime = var_3.GetCombatTime(var_5_2)
	end

	return
end

function var_0_3.doFill(arg_6_0)
	setmetatable = var_1_10001

	local var_6_0 = {}
	local var_6_1 = {}
	local var_6_2 = arg_6_0._referenceUnit

	var_6_1.__index = var_5.GetPosition(var_6_2)

	local var_6_3 = var_1_10001(var_6_0, var_6_1)
	local var_6_4 = arg_6_0._area
	local var_6_5 = var_2.GetIFF(var_6_4)

	math = var_6_0

	local var_6_6 = var_6_0.abs(arg_6_0._upperBound - arg_6_0._lowerBound)
	local var_6_7 = arg_6_0._frontOffset * 2
	local var_6_8 = arg_6_0._area

	var_5.SetWidth(var_6_8, var_6_7)

	local var_6_9 = arg_6_0._area

	var_5.SetHeight(var_6_9, var_6_6)

	local var_6_10 = arg_6_0._area
	local var_6_11 = var_5.GetCldComponent(var_6_10)

	var_5.ResetSize(var_6_11, var_6_7, 5, var_6_6)

	local var_6_12 = var_6_6 * 0.5 + arg_6_0._lowerBound
	local var_6_13 = var_6_3.x

	arg_6_0._referencePoint.x = var_6_13
	arg_6_0._referencePoint.z = var_6_12

	local var_6_14 = arg_6_0._area

	var_8.SetPosition(var_6_14, arg_6_0._referencePoint)

	return
end

function var_0_3.doExpend(arg_7_0)
	pg = var_1_10001

	local var_7_0 = var_1_10001.TimeMgr.GetInstance()

	if var_1.GetCombatTime(var_7_0) - arg_7_0._expendStartTime < arg_7_0._expendDuration then
		local var_7_1 = arg_7_0._area
		local var_7_2 = var_2.GetWidth(var_7_1)
		local var_7_3 = arg_7_0._area
		local var_7_4 = var_3.GetHeight(var_7_3)
		local var_7_5 = var_1 - arg_7_0._lastExpendTime
		local var_7_6 = var_7_2 + arg_7_0._widthExpendSpeed * var_7_5
		local var_7_7 = var_7_4 + arg_7_0._heightExpendSpeed * var_7_5
		local var_7_8 = arg_7_0._area

		var_7.SetWidth(var_7_8, var_7_6)

		local var_7_9 = arg_7_0._area

		var_7.SetHeight(var_7_9, var_7_7)

		local var_7_10 = arg_7_0._area
		local var_7_11 = var_7.GetCldComponent(var_7_10)

		var_7.ResetSize(var_7_11, var_7_2, 5, var_7_4)
	end

	return
end

return
