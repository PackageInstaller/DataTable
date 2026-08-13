ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConst

class = var_0_10002

local var_0_2 = var_0_10002("BattleAOEMobilizedComponent")

var_0.Battle.BattleAOEMobilizedComponent = var_0_2
var_0_2.__name = "BattleAOEMobilizedComponent"
var_0_2.STAY = 0
var_0_2.FOLLOW = 1
var_0_2.REFERENCE = 2

function var_0_2.Ctor(arg_1_0, arg_1_1)
	arg_1_0._area = arg_1_1

	local var_1_0 = arg_1_0._area

	var_2.AppendComponent(var_1_0, arg_1_0)

	local var_1_1 = arg_1_0._area.Settle

	function arg_1_0._area.Settle()
		local var_2_0 = arg_1_0

		var_0.updatePosition(var_2_0)
		var_1_1(arg_1_0._area)

		return
	end

	return
end

function var_0_2.Dispose(arg_3_0)
	arg_3_0._area = nil
	arg_3_0._referenceUnit = nil

	return
end

function var_0_2.SetReferenceUnit(arg_4_0, arg_4_1)
	arg_4_0._referenceUnit = arg_4_1
	Clone = var_1_10002
	arg_4_0._referencePoint = var_1_10002(arg_4_1:GetPosition())

	return
end

function var_0_2.ConfigData(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_1 == var_0_2.STAY then
		arg_5_0.updatePosition = var_0_2.doStay
	elseif arg_5_1 == var_0_2.FOLLOW then
		arg_5_0.updatePosition = var_0_2.doFollow
	elseif arg_5_1 == var_0_2.REFERENCE then
		arg_5_0.updatePosition = var_0_2.doReference
		Vector3 = var_3
		arg_5_0._speedVector = var_3.New(arg_5_2.speedX, 0, 0)
	end

	return
end

function var_0_2.doStay()
	return
end

function var_0_2.doFollow(arg_7_0)
	setmetatable = var_1_10001

	local var_7_0 = {}
	local var_7_1 = {}
	local var_7_2 = arg_7_0._referenceUnit

	var_7_1.__index = var_5.GetPosition(var_7_2)

	local var_7_3 = var_1_10001(var_7_0, var_7_1)
	local var_7_4 = arg_7_0._area

	var_2.SetPosition(var_7_4, var_7_3)

	return
end

function var_0_2.doReference(arg_8_0)
	local var_8_0 = arg_8_0._referencePoint

	var_1.Add(var_8_0, arg_8_0._speedVector)

	local var_8_1 = arg_8_0._area

	var_1.SetPosition(var_8_1, arg_8_0._referencePoint)

	return
end

return
