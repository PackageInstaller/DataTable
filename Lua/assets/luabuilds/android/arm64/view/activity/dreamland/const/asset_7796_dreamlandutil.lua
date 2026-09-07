local DreamlandUtil = class("DreamlandUtil")

function DreamlandUtil:TrPosition2LocalPos(arg_1_1, arg_1_2)
	if self == arg_1_1 then
		return arg_1_2
	else
		local var_1_0 = arg_1_1:InverseTransformPoint((self:TransformPoint(arg_1_2)))

		return Vector3(var_1_0.x, var_1_0.y, 0)
	end

	return
end

function DreamlandUtil:GetRect(arg_2_1, arg_2_2)
	local var_2_0 = Vector2(self.x - arg_2_1 * 0.5, self.y + arg_2_2 * 0.5)
	local var_2_1 = Vector2(self.x + arg_2_1 * 0.5, self.y - arg_2_2 * 0.5)

	return {
		xMin = var_2_0.x,
		xMax = Vector2(self.x + arg_2_1 * 0.5, self.y + arg_2_2 * 0.5).x,
		yMin = var_2_0.y,
		yMax = Vector2(self.x - arg_2_1 * 0.5, self.y - arg_2_2 * 0.5).y
	}
end

function DreamlandUtil:CalcFocusPosition(arg_3_1, arg_3_2)
	local var_3_0 = DreamlandUtil.TrPosition2LocalPos(self, arg_3_1, arg_3_2)
	local var_3_1 = DreamlandUtil.GetRect(var_3_0, arg_3_1.rect.width, arg_3_1.rect.height)
	local var_3_2 = DreamlandUtil.GetRect(self.localPosition, self.rect.width, self.rect.height)
	local var_3_3 = 0
	local var_3_4 = 0

	if var_3_1.xMin < var_3_2.xMin then
		var_3_3 = var_3_1.xMin - var_3_2.xMin
	elseif var_3_1.xMax > var_3_2.xMax then
		var_3_3 = var_3_1.xMax - var_3_2.xMax
	end

	if var_3_1.yMin > var_3_2.yMin then
		var_3_4 = var_3_1.yMin - var_3_2.yMin
	elseif var_3_1.yMax < var_3_2.yMax then
		var_3_4 = var_3_1.yMax - var_3_2.yMax
	end

	return (var_3_0 - self.localPosition - Vector3(var_3_3, var_3_4, 0)) * -1
end

function DreamlandUtil:GetSpineNormalAction()
	if self == DreamlandData.EXPLORE_SUBTYPE_4RAN_NORMAL then
		local var_4_0 = {
			"normal1",
			"normal2",
			"normal3",
			"normal4"
		}

		return var_4_0[math.random(1, #var_4_0)]
	else
		return "normal"
	end

	return
end

function DreamlandUtil:GetSpineInterAction()
	local var_5_0 = {
		"action1",
		"action2",
		"action3"
	}

	if self == DreamlandData.EXPLORE_SUBTYPE_3RAN_ACTION then
		return var_5_0[math.random(1, 3)]
	elseif self == DreamlandData.EXPLORE_SUBTYPE_2RAN_ACTION then
		return var_5_0[math.random(1, 2)]
	else
		return "action"
	end

	return
end

function DreamlandUtil:List2Map(arg_6_1)
	local var_6_0 = {}

	for iter_6_0, iter_6_1 in ipairs(self) do
		var_6_0[iter_6_1[arg_6_1]] = iter_6_1
	end

	return var_6_0
end

return DreamlandUtil
