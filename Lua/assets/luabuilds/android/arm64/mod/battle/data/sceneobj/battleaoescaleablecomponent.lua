ys = ys or {}

local var_0_2 = class("BattleAOEScaleableComponent")

ys.Battle.BattleAOEScaleableComponent = var_0_2
var_0_2.__name = "BattleAOEScaleableComponent"
var_0_2.FILL = 1
var_0_2.EXPEND = 2

function var_0_2.Ctor(arg_1_0, arg_1_1)
	arg_1_0._area = arg_1_1

	arg_1_0._area:AppendComponent(arg_1_0)

	local var_1_0 = arg_1_0._area.Settle

	function arg_1_0._area.Settle()
		arg_1_0:updateScale()
		var_1_0(arg_1_0._area)

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
	arg_4_0._referencePoint = Clone(arg_4_1:GetPosition())

	return
end

function var_0_2.ConfigData(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_1 == var_0_2.FILL then
		arg_5_0.updateScale = var_0_2.doFill
		arg_5_0._upperBound = arg_5_2.upperBound
		arg_5_0._lowerBound = arg_5_2.lowerBound
		arg_5_0._rearBound = arg_5_2.rearBound
		arg_5_0._frontOffset = arg_5_2.frontOffset
	elseif arg_5_1 == var_0_2.EXPEND then
		arg_5_0._area:SetFXStatic(false)

		arg_5_0.updateScale = var_0_2.doExpend
		arg_5_0._expendDuration = arg_5_2.expendDuration
		arg_5_0._widthExpendSpeed = arg_5_2.widthSpeed
		arg_5_0._heightExpendSpeed = arg_5_2.heightSpeed
		arg_5_0._expendStartTime = pg.TimeMgr.GetInstance():GetCombatTime()
		arg_5_0._lastExpendTime = pg.TimeMgr.GetInstance():GetCombatTime()
	end

	return
end

function var_0_2.doFill(arg_6_0)
	local var_6_0 = arg_6_0._area:GetIFF()
	local var_6_1 = math.abs(arg_6_0._upperBound - arg_6_0._lowerBound)

	arg_6_0._area:SetWidth(arg_6_0._frontOffset * 2)
	arg_6_0._area:SetHeight(var_6_1)
	arg_6_0._area:GetCldComponent():ResetSize(arg_6_0._frontOffset * 2, 5, var_6_1)

	arg_6_0._referencePoint.x = setmetatable({}, {
		__index = arg_6_0._referenceUnit:GetPosition()
	}).x
	arg_6_0._referencePoint.z = var_6_1 * 0.5 + arg_6_0._lowerBound

	arg_6_0._area:SetPosition(arg_6_0._referencePoint)

	return
end

function var_0_2.doExpend(arg_7_0)
	local var_7_0 = pg.TimeMgr.GetInstance():GetCombatTime()

	if var_7_0 - arg_7_0._expendStartTime < arg_7_0._expendDuration then
		local var_7_1 = arg_7_0._area:GetWidth()
		local var_7_2 = arg_7_0._area:GetHeight()

		arg_7_0._area:SetWidth(var_7_1 + arg_7_0._widthExpendSpeed * (var_7_0 - arg_7_0._lastExpendTime))
		arg_7_0._area:SetHeight(var_7_2 + arg_7_0._heightExpendSpeed * (var_7_0 - arg_7_0._lastExpendTime))
		arg_7_0._area:GetCldComponent():ResetSize(var_7_1, 5, var_7_2)
	end

	return
end

return
