local var_0_0 = class("WSDragProxy", import("...BaseEntity"))

var_0_0.Fields = {
	map = "table",
	gid = "number",
	topExtend = "number",
	transform = "userdata",
	longPressTrigger = "userdata",
	leftExtend = "number",
	twFocusId = "number",
	dragTrigger = "userdata",
	wsTimer = "table",
	onDragFunction = "function",
	isDraging = "boolean",
	bottomExtend = "number",
	callInfo = "table",
	rightExtend = "number"
}

function var_0_0.Setup(arg_1_0, arg_1_1)
	arg_1_0.callInfo = arg_1_1
	arg_1_0.dragTrigger = GetOrAddComponent(arg_1_0.transform, typeof(EventTriggerListener))

	arg_1_0.dragTrigger:AddBeginDragFunc(function()
		arg_1_0.isDraging = true

		return
	end)
	arg_1_0.dragTrigger:AddDragEndFunc(function()
		arg_1_0.isDraging = false

		return
	end)
	arg_1_0.dragTrigger:AddPointClickFunc(function(arg_4_0, arg_4_1)
		if not arg_1_0.isDraging then
			arg_1_0.callInfo.clickCall(arg_4_0, arg_4_1)
		end

		return
	end)

	arg_1_0.dragTrigger.enabled = true
	arg_1_0.longPressTrigger = GetOrAddComponent(arg_1_0.transform, typeof(UILongPressTrigger))

	local var_1_0 = arg_1_0.callInfo.longPressCall

	function arg_1_0.callInfo.longPressCall(...)
		if arg_1_0.isDraging then
			return
		end

		var_1_0(...)

		return
	end

	arg_1_0.longPressTrigger.onLongPressed:AddListener(arg_1_0.callInfo.longPressCall)

	arg_1_0.longPressTrigger.enabled = true

	return
end

function var_0_0.Dispose(arg_6_0)
	arg_6_0.transform.localPosition = Vector3.zero

	if arg_6_0.map then
		arg_6_0.dragTrigger:RemoveDragFunc()
	end

	arg_6_0.dragTrigger:RemoveBeginDragFunc()
	arg_6_0.dragTrigger:RemoveDragEndFunc()
	arg_6_0.dragTrigger:RemovePointClickFunc()

	arg_6_0.dragTrigger.enabled = true

	arg_6_0.longPressTrigger.onLongPressed:RemoveListener(arg_6_0.callInfo.longPressCall)

	arg_6_0.longPressTrigger.enabled = true

	arg_6_0:Clear()

	return
end

function var_0_0.Focus(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	local var_7_0 = arg_7_0.transform:Find("plane")

	assert(var_7_0, "plane not exist.")

	local var_7_1 = arg_7_0.transform.parent:InverseTransformVector(arg_7_1 - var_7_0.position)

	var_7_1.x = var_7_1.x + var_7_0.localPosition.x
	var_7_1.y = var_7_1.y + var_7_0.localPosition.y - var_7_0.localPosition.z * math.tan(math.pi / 180 * arg_7_0.map.theme.angle)
	var_7_1.x = math.clamp(-var_7_1.x, -arg_7_0.rightExtend, arg_7_0.leftExtend)
	var_7_1.y = math.clamp(-var_7_1.y, -arg_7_0.topExtend, arg_7_0.bottomExtend)
	var_7_1.z = 0

	if arg_7_0.twFocusId then
		arg_7_0.wsTimer:RemoveInMapTween(arg_7_0.twFocusId)
	end

	local var_7_2 = {}

	if arg_7_3 then
		table.insert(var_7_2, function(arg_8_0)
			if arg_7_0.isDraging then
				arg_7_0.isDraging = false
			end

			arg_7_0.dragTrigger.enabled = false
			arg_7_0.longPressTrigger.enabled = false
			arg_7_2 = arg_7_2 or (arg_7_0.transform.localPosition - var_7_1).magnitude > 0 and (arg_7_0.transform.localPosition - var_7_1).magnitude / (40 * math.sqrt((arg_7_0.transform.localPosition - var_7_1).magnitude)) or 0

			local var_8_0 = arg_7_0

			var_8_0.twFocusId = LeanTween.moveLocal(arg_7_0.transform.gameObject, var_7_1, arg_7_2):setEase(arg_7_3):setOnComplete(System.Action(arg_8_0)).uniqueId

			arg_7_0.wsTimer:AddInMapTween(arg_7_0.twFocusId)

			return
		end)
	else
		arg_7_0.transform.localPosition = var_7_1
	end

	seriesAsync(var_7_2, function()
		arg_7_0.dragTrigger.enabled = true
		arg_7_0.longPressTrigger.enabled = true

		if arg_7_4 then
			arg_7_4()
		end

		return
	end)

	return
end

function var_0_0.UpdateMap(arg_10_0, arg_10_1)
	if arg_10_0.map ~= arg_10_1 or arg_10_0.gid ~= arg_10_1.gid then
		arg_10_0.map = arg_10_1
		arg_10_0.gid = arg_10_1.gid

		arg_10_0:UpdateDrag()
	end

	return
end

function var_0_0.UpdateDrag(arg_11_0)
	local var_11_0, var_11_1, var_11_2 = getSizeRate()
	local var_11_3 = var_11_2 * 0.5 / math.tan(math.deg2Rad * arg_11_0.map.theme.fov * 0.5)
	local var_11_4 = var_11_0 * math.clamp((var_11_3 - Vector3.Dot(Vector3(0, -math.sin(math.deg2Rad * arg_11_0.map.theme.angle), -math.cos(math.deg2Rad * arg_11_0.map.theme.angle)), Vector3(arg_11_0.map.theme.offsetx, arg_11_0.map.theme.offsety, arg_11_0.map.theme.offsetz) + WorldConst.DefaultMapOffset)) / var_11_3, 0, 1)

	arg_11_0.leftExtend, arg_11_0.rightExtend, arg_11_0.topExtend, arg_11_0.bottomExtend = arg_11_0:GetDragExtend(var_11_1, var_11_2)
	arg_11_0.transform.sizeDelta = Vector2(var_11_1 + math.max(arg_11_0.leftExtend, arg_11_0.rightExtend) * 2, var_11_2 + math.max(arg_11_0.topExtend, arg_11_0.bottomExtend) * 2)

	arg_11_0.dragTrigger:RemoveDragFunc()
	arg_11_0.dragTrigger:AddDragFunc(function(arg_12_0, arg_12_1)
		if arg_11_0.onDragFunction then
			arg_11_0.onDragFunction()
		end

		local var_12_0 = arg_11_0.transform.localPosition

		var_12_0.x = math.clamp(arg_11_0.transform.localPosition.x + arg_12_1.delta.x * var_11_4.x, -arg_11_0.rightExtend, arg_11_0.leftExtend)
		var_12_0.y = math.clamp(var_12_0.y + arg_12_1.delta.y * var_11_4.y / math.cos(var_0), -arg_11_0.topExtend, arg_11_0.bottomExtend)
		arg_11_0.transform.localPosition = var_12_0

		return
	end)

	return
end

function var_0_0.GetDragExtend(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_0.transform:Find("plane")

	assert(var_13_0, "plane not exist.")

	local var_13_1 = var_13_0.localPosition.y - var_13_0.localPosition.z * math.tan(math.pi / 180 * arg_13_0.map.theme.angle)
	local var_13_2 = 99999999
	local var_13_3 = 0
	local var_13_4 = 0

	for iter_13_0, iter_13_1 in pairs(arg_13_0.map.cells) do
		if var_13_2 > iter_13_1.row then
			var_13_2 = iter_13_1.row
		end

		if var_13_3 < iter_13_1.row then
			var_13_3 = iter_13_1.row
		end

		if var_13_4 < iter_13_1.column then
			var_13_4 = iter_13_1.column
		end
	end

	return 1000 - var_13_0.localPosition.x, math.max(var_13_4 * (arg_13_0.map.theme.cellSize + arg_13_0.map.theme.cellSpace).x - arg_13_1 * 0.5, 0) + var_13_0.localPosition.x, math.max((WorldConst.MaxRow * 0.5 - var_13_2) * (arg_13_0.map.theme.cellSize + arg_13_0.map.theme.cellSpace).y, 0) + var_13_1, math.max((var_13_3 - WorldConst.MaxRow * 0.5) * (arg_13_0.map.theme.cellSize + arg_13_0.map.theme.cellSpace).y, 0) - var_13_1
end

function var_0_0.ShakePlane(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4, arg_14_5)
	arg_14_2 = math.clamp(arg_14_2, 0, 90)
	arg_14_3 = math.max(arg_14_3, 1)
	arg_14_4 = math.max(arg_14_4, 1)

	local var_14_0 = Vector3(math.cos(math.pi / 180 * arg_14_2), math.sin(math.pi / 180 * arg_14_2), 0) * arg_14_1

	arg_14_0.dragTrigger.enabled = false
	arg_14_0.longPressTrigger.enabled = false

	arg_14_0.wsTimer:AddInMapTween(LeanTween.moveLocal(arg_14_0.transform.gameObject, arg_14_0.transform.anchoredPosition3D + var_14_0, 0.0333 * arg_14_3 * 0.5).uniqueId)
	arg_14_0.wsTimer:AddInMapTween(LeanTween.moveLocal(arg_14_0.transform.gameObject, arg_14_0.transform.anchoredPosition3D - var_14_0, 0.0333 * arg_14_3):setDelay(0.0333 * arg_14_3 * 0.5):setLoopPingPong(arg_14_4).uniqueId)
	arg_14_0.wsTimer:AddInMapTween(LeanTween.moveLocal(arg_14_0.transform.gameObject, arg_14_0.transform.anchoredPosition3D, 0.0333 * arg_14_3 * 0.5):setDelay(0.0333 * arg_14_3 * 0.5 + 0.0333 * arg_14_3 * arg_14_4 * 2):setOnComplete(System.Action(function()
		arg_14_0.dragTrigger.enabled = true
		arg_14_0.longPressTrigger.enabled = true

		arg_14_5()

		return
	end)).uniqueId)

	return
end

return var_0_0
