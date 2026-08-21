ys = ys or {}

local var_0_1 = class("BattleAOEMobilizedComponent")

ys.Battle.BattleAOEMobilizedComponent = var_0_1
var_0_1.__name = "BattleAOEMobilizedComponent"
var_0_1.STAY = 0
var_0_1.FOLLOW = 1
var_0_1.REFERENCE = 2

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0._area = arg_1_1

	arg_1_0._area:AppendComponent(arg_1_0)

	local var_1_0 = arg_1_0._area.Settle

	function arg_1_0._area.Settle()
		arg_1_0:updatePosition()
		var_1_0(arg_1_0._area)

		return
	end

	return
end

function var_0_1.Dispose(arg_3_0)
	arg_3_0._area = nil
	arg_3_0._referenceUnit = nil

	return
end

function var_0_1.SetReferenceUnit(arg_4_0, arg_4_1)
	arg_4_0._referenceUnit = arg_4_1
	arg_4_0._referencePoint = Clone(arg_4_1:GetPosition())

	return
end

function var_0_1.ConfigData(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_1 == var_0_1.STAY then
		arg_5_0.updatePosition = var_0_1.doStay
	elseif arg_5_1 == var_0_1.FOLLOW then
		arg_5_0.updatePosition = var_0_1.doFollow
	elseif arg_5_1 == var_0_1.REFERENCE then
		arg_5_0.updatePosition = var_0_1.doReference
		arg_5_0._speedVector = Vector3.New(arg_5_2.speedX, 0, 0)
	end

	return
end

function var_0_1.doStay()
	return
end

function var_0_1.doFollow(arg_7_0)
	arg_7_0._area:SetPosition((setmetatable({}, {
		__index = arg_7_0._referenceUnit:GetPosition()
	})))

	return
end

function var_0_1.doReference(arg_8_0)
	arg_8_0._referencePoint:Add(arg_8_0._speedVector)
	arg_8_0._area:SetPosition(arg_8_0._referencePoint)

	return
end

return
