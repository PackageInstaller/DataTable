local var_0_0 = class("DreamlandUtil")

function var_0_0.TrPosition2LocalPos(arg_1_0, arg_1_1, arg_1_2)
	if arg_1_0 == arg_1_1 then
		return arg_1_2
	else
		local var_1_0 = arg_1_1:InverseTransformPoint((arg_1_0:TransformPoint(arg_1_2)))

		return Vector3(var_1_0.x, var_1_0.y, 0)
	end

	return
end

function var_0_0.GetRect(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = Vector2(arg_2_0.x - arg_2_1 * 0.5, arg_2_0.y + arg_2_2 * 0.5)
	local var_2_1 = Vector2(arg_2_0.x + arg_2_1 * 0.5, arg_2_0.y - arg_2_2 * 0.5)

	return {
		xMin = var_2_0.x,
		xMax = Vector2(arg_2_0.x + arg_2_1 * 0.5, arg_2_0.y + arg_2_2 * 0.5).x,
		yMin = var_2_0.y,
		yMax = Vector2(arg_2_0.x - arg_2_1 * 0.5, arg_2_0.y - arg_2_2 * 0.5).y
	}
end

function var_0_0.CalcFocusPosition(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = var_0_0.TrPosition2LocalPos(arg_3_0, arg_3_1, arg_3_2)
	local var_3_1 = var_0_0.GetRect(var_3_0, arg_3_1.rect.width, arg_3_1.rect.height)
	local var_3_2 = var_0_0.GetRect(arg_3_0.localPosition, arg_3_0.rect.width, arg_3_0.rect.height)
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

	return (var_3_0 - arg_3_0.localPosition - Vector3(var_3_3, var_3_4, 0)) * -1
end

function var_0_0.GetSpineNormalAction(arg_4_0)
	if arg_4_0 == DreamlandData.EXPLORE_SUBTYPE_4RAN_NORMAL then
		return ({
			"normal1",
			"normal2",
			"normal3",
			"normal4"
		})[math.random(1, #{
			"normal1",
			"normal2",
			"normal3",
			"normal4"
		})]
	else
		return "normal"
	end

	return
end

function var_0_0.GetSpineInterAction(arg_5_0)
	if arg_5_0 == DreamlandData.EXPLORE_SUBTYPE_3RAN_ACTION then
		return ({
			"action1",
			"action2",
			"action3"
		})[math.random(1, 3)]
	elseif arg_5_0 == DreamlandData.EXPLORE_SUBTYPE_2RAN_ACTION then
		return ({
			"action1",
			"action2",
			"action3"
		})[math.random(1, 2)]
	else
		return "action"
	end

	return
end

function var_0_0.List2Map(arg_6_0, arg_6_1)
	for iter_6_0, iter_6_1 in ipairs(arg_6_0) do
		({})[iter_6_1[arg_6_1]] = iter_6_1
	end

	return {}
end

return var_0_0
