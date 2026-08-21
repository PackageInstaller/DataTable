local var_0_0 = {
	ToggleTextInverse = function(arg_1_0, arg_1_1, arg_1_2)
		local var_1_0 = arg_1_0:FindCom(typeof(Text), "" .. arg_1_2, arg_1_1)

		var_1_0.color = Color(math.abs(255 - var_1_0.color.r), math.abs(255 - var_1_0.color.g), math.abs(255 - var_1_0.color.b), var_1_0.color.a)
	end,
	GetOrAddComponent = function(arg_2_0, arg_2_1)
		local var_2_0 = arg_2_0:GetComponent(arg_2_1)

		if var_2_0 ~= nil then
			return var_2_0
		else
			return arg_2_0:AddComponent(arg_2_1)
		end
	end
}
local var_0_1 = 1920
local var_0_2 = 1080

function var_0_0.GetAdaptedLocalPosition(arg_3_0, arg_3_1)
	local var_3_0 = Vector3(arg_3_1.x, arg_3_1.y, arg_3_1.z)
	local var_3_1 = arg_3_0:GetComponent("RectTransform")
	local var_3_2 = var_3_1.parent:GetComponent("RectTransform")
	local var_3_3 = manager.ui:GetCanvasSize()

	if var_3_2.anchorMin.x == 0 and var_3_2.anchorMin.y == 0 and var_3_2.anchorMax.x == 1 and var_3_2.anchorMax.y == 1 and var_3_2.sizeDelta.x == 0 and var_3_2.sizeDelta.y == 0 and var_3_2.anchoredPosition.x == 0 and var_3_2.anchoredPosition.y == 0 then
		if var_3_1.anchorMin.x == var_3_1.anchorMax.x then
			var_3_0.x = var_0_1 * (0.5 - var_3_1.anchorMin.x) + var_3_0.x - var_3_3.x * (0.5 - var_3_1.anchorMin.x)
		end

		if var_3_1.anchorMin.y == var_3_1.anchorMax.y then
			var_3_0.y = var_0_2 * (0.5 - var_3_1.anchorMin.y) + var_3_0.y - var_3_3.y * (0.5 - var_3_1.anchorMin.y)
		end
	end

	return var_3_0
end

return var_0_0
