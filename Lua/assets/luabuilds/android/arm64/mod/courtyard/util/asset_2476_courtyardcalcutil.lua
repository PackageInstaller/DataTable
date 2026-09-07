local CourtYardCalcUtil = class("CourtYardCalcUtil")
local var_0_1 = 78.2
local var_0_2 = 39

function CourtYardCalcUtil:Screen2Local(arg_1_1)
	return (LuaHelper.ScreenToLocal(self:GetComponent("RectTransform"), arg_1_1, (GameObject.Find("UICamera"):GetComponent("Camera"))))
end

function CourtYardCalcUtil:Map2Local()
	return Vector2((self.x - self.y) * (var_0_1 / 2), (self.x + self.y) * (var_0_2 / 2))
end

function CourtYardCalcUtil:Local2Map()
	return Vector2(math.floor(self.x / var_0_1 + self.y / var_0_2), (math.floor(self.y / var_0_2 - self.x / var_0_1)))
end

function CourtYardCalcUtil:World2Local(arg_4_1)
	local var_4_0 = self:InverseTransformPoint(arg_4_1)

	return Vector3(var_4_0.x, var_4_0.y, 0)
end

function CourtYardCalcUtil:local2RelativeLocal(arg_5_1, arg_5_2)
	return self + CourtYardCalcUtil.Map2Local(Vector2(arg_5_1, arg_5_2))
end

function CourtYardCalcUtil:TrPosition2LocalPos(arg_6_1, arg_6_2)
	if self == arg_6_1 then
		return arg_6_2
	else
		local var_6_0 = arg_6_1:InverseTransformPoint((self:TransformPoint(arg_6_2)))

		return Vector3(var_6_0.x, var_6_0.y, 0)
	end

	return
end

function CourtYardCalcUtil:IsHappen()
	return self >= math.random(0, 100)
end

function CourtYardCalcUtil.HalfProbability()
	return CourtYardCalcUtil.IsHappen(50)
end

function CourtYardCalcUtil:GetSign()
	if self <= 0 then
		return -1
	else
		return 1
	end

	return
end

function CourtYardCalcUtil:GetTransformSign(arg_10_1)
	local var_10_0 = self
	local var_10_1 = arg_10_1.localScale.x * self.localScale.x

	while var_10_0.parent ~= arg_10_1 do
		var_10_0 = var_10_0.parent
		var_10_1 = var_10_1 * var_10_0.localScale.x
	end

	return CourtYardCalcUtil.GetSign(var_10_1)
end

return CourtYardCalcUtil
