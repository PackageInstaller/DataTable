class = var_0_10000

local var_0_0 = "WSDragProxy"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...BaseEntity"))

var_0_1.Fields = {
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

function var_0_1.Setup(arg_1_0, arg_1_1)
	arg_1_0.callInfo = arg_1_1
	GetOrAddComponent = var_1_10002

	local var_1_0 = arg_1_0.transform

	typeof = var_1_10004
	EventTriggerListener = var_1_10005
	arg_1_0.dragTrigger = var_1_10002(var_1_0, var_1_10004(var_1_10005))

	local var_1_1 = arg_1_0.dragTrigger

	var_2.AddBeginDragFunc(var_1_1, function()
		arg_1_0.isDraging = true

		return
	end)

	local var_1_2 = arg_1_0.dragTrigger

	var_2.AddDragEndFunc(var_1_2, function()
		arg_1_0.isDraging = false

		return
	end)

	local var_1_3 = arg_1_0.dragTrigger

	var_2.AddPointClickFunc(var_1_3, function(arg_4_0, arg_4_1)
		if not arg_1_0.isDraging then
			arg_1_0.callInfo.clickCall(arg_4_0, arg_4_1)
		end

		return
	end)

	local var_1_4 = arg_1_0.dragTrigger

	var_1_4.enabled = true
	GetOrAddComponent = var_1_4

	local var_1_5 = arg_1_0.transform

	typeof = var_4
	UILongPressTrigger = var_1_10005
	arg_1_0.longPressTrigger = var_1_4(var_1_5, var_4(var_1_10005))

	local var_1_6 = arg_1_0.callInfo.longPressCall

	function arg_1_0.callInfo.longPressCall(...)
		if arg_1_0.isDraging then
			return
		end

		var_1_6(...)

		return
	end

	local var_1_7 = arg_1_0.longPressTrigger.onLongPressed

	var_3.AddListener(var_1_7, arg_1_0.callInfo.longPressCall)

	arg_1_0.longPressTrigger.enabled = true

	return
end

function var_0_1.Dispose(arg_6_0)
	local var_6_0 = arg_6_0.transform

	Vector3 = var_1_10002
	var_6_0.localPosition = var_1_10002.zero

	if arg_6_0.map then
		local var_6_1 = arg_6_0.dragTrigger

		var_1.RemoveDragFunc(var_6_1)
	end

	local var_6_2 = arg_6_0.dragTrigger

	var_1.RemoveBeginDragFunc(var_6_2)

	local var_6_3 = arg_6_0.dragTrigger

	var_1.RemoveDragEndFunc(var_6_3)

	local var_6_4 = arg_6_0.dragTrigger

	var_1.RemovePointClickFunc(var_6_4)

	arg_6_0.dragTrigger.enabled = true

	local var_6_5 = arg_6_0.longPressTrigger.onLongPressed

	var_1.RemoveListener(var_6_5, arg_6_0.callInfo.longPressCall)

	arg_6_0.longPressTrigger.enabled = true

	arg_6_0:Clear()

	return
end

function var_0_1.Focus(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	local var_7_0 = arg_7_0.map.theme
	local var_7_1 = arg_7_0.transform
	local var_7_2 = var_6.Find(var_7_1, "plane")

	assert = var_7_1

	var_7_1(var_7_2, "plane not exist.")

	local var_7_3 = arg_7_0.transform.parent

	var_7.x = var_7.InverseTransformVector(var_7_3, arg_7_1 - var_7_2.position).x + var_7_2.localPosition.x

	local var_7_4 = var_7.y + var_7_2.localPosition.y
	local var_7_5 = var_7_2.localPosition.z

	math = var_1_10010

	local var_7_6 = var_1_10010.tan

	math = var_1_10011
	var_7.y = var_7_4 - var_7_5 * var_7_6(var_1_10011.pi / 180 * var_7_0.angle)
	math = var_8
	var_7.x = var_8.clamp(-var_7.x, -arg_7_0.rightExtend, arg_7_0.leftExtend)
	math = var_8
	var_7.y = var_8.clamp(-var_7.y, -arg_7_0.topExtend, arg_7_0.bottomExtend)
	var_7.z = 0

	local var_7_7

	if arg_7_0.twFocusId then
		var_7_7 = arg_7_0.wsTimer

		var_8.RemoveInMapTween(var_7_7, arg_7_0.twFocusId)
	end

	local var_7_8 = {}

	if arg_7_3 then
		table = var_7_7

		var_7_7.insert(var_7_8, function(arg_8_0)
			if arg_7_0.isDraging then
				arg_7_0.isDraging = false
			end

			arg_7_0.dragTrigger.enabled = false
			arg_7_0.longPressTrigger.enabled = false

			if not arg_7_2 then
				local var_8_0 = (arg_7_0.transform.localPosition - var_0).magnitude

				if 0 < var_8_0 then
					math = var_8_1

					local var_8_1

					if not (var_8_0 / (40 * var_8_1.sqrt(var_8_0))) then
						var_8_1 = 0
					end

					arg_7_2 = var_8_1

					local var_8_2 = arg_7_0

					LeanTween = var_8_1

					local var_8_3 = var_8_1.moveLocal(arg_7_0.transform.gameObject, var_0, arg_7_2)
					local var_8_4 = var_2.setEase(var_8_3, arg_7_3)
					local var_8_5 = var_2.setOnComplete

					System = var_4
					var_8_2.twFocusId = var_8_5(var_8_4, var_4.Action(arg_8_0)).uniqueId

					local var_8_6 = arg_7_0.wsTimer

					var_1.AddInMapTween(var_8_6, arg_7_0.twFocusId)

					return
				end
			end
		end)
	else
		var_7_7 = arg_7_0.transform
		var_7_7.localPosition = var_7
	end

	seriesAsync = var_7_7

	var_7_7(var_7_8, function()
		arg_7_0.dragTrigger.enabled = true
		arg_7_0.longPressTrigger.enabled = true

		if arg_7_4 then
			arg_7_4()
		end

		return
	end)

	return
end

function var_0_1.UpdateMap(arg_10_0, arg_10_1)
	if arg_10_0.map ~= arg_10_1 or arg_10_0.gid ~= arg_10_1.gid then
		arg_10_0.map = arg_10_1
		arg_10_0.gid = arg_10_1.gid

		arg_10_0:UpdateDrag()
	end

	return
end

function var_0_1.UpdateDrag(arg_11_0)
	getSizeRate = var_1_10001

	local var_11_0, var_11_1, var_11_2 = var_1_10001()
	local var_11_3 = arg_11_0.map.theme
	local var_11_4 = var_11_2 * 0.5

	math = var_1_10006

	local var_11_5 = var_1_10006.tan

	math = var_1_10007

	local var_11_6 = var_11_4 / var_11_5(var_1_10007.deg2Rad * var_11_3.fov * 0.5)

	math = var_6

	local var_11_7 = var_6.deg2Rad * var_11_3.angle

	Vector3 = var_7

	local var_11_8 = 0

	math = var_1_10009

	local var_11_9 = -var_1_10009.sin(var_11_7)

	math = var_10

	local var_11_10 = var_7(var_11_8, var_11_9, -var_10.cos(var_11_7))

	Vector3 = var_11_8

	local var_11_11 = var_11_8(var_11_3.offsetx, var_11_3.offsety, var_11_3.offsetz)

	WorldConst = var_9

	local var_11_12 = var_11_11 + var_9.DefaultMapOffset

	Vector3 = var_9

	local var_11_13 = var_9.Dot(var_11_10, var_11_12)

	math = var_10

	local var_11_14 = var_11_0 * var_10.clamp((var_11_6 - var_11_13) / var_11_6, 0, 1)
	local var_11_15, var_11_16, var_11_17, var_11_18 = arg_11_0:GetDragExtend(var_11_1, var_11_2)

	arg_11_0.bottomExtend = var_11_18
	arg_11_0.topExtend = var_11_17
	arg_11_0.rightExtend = var_11_16
	arg_11_0.leftExtend = var_11_15

	local var_11_19 = arg_11_0.transform

	Vector2 = var_11_16
	math = var_11_17

	local var_11_20 = var_11_1 + var_11_17.max(arg_11_0.leftExtend, arg_11_0.rightExtend) * 2

	math = var_13
	var_11_19.sizeDelta = var_11_16(var_11_20, var_11_2 + var_13.max(arg_11_0.topExtend, arg_11_0.bottomExtend) * 2)

	local var_11_21 = arg_11_0.dragTrigger

	var_10.RemoveDragFunc(var_11_21)

	local var_11_22 = arg_11_0.dragTrigger

	var_10.AddDragFunc(var_11_22, function(arg_12_0, arg_12_1)
		if arg_11_0.onDragFunction then
			arg_11_0.onDragFunction()
		end

		local var_12_0 = arg_11_0.transform.localPosition

		math = var_2_10003
		var_12_0.x = var_2_10003.clamp(var_12_0.x + arg_12_1.delta.x * var_11_14.x, -arg_11_0.rightExtend, arg_11_0.leftExtend)
		math = var_3

		local var_12_1 = var_3.clamp
		local var_12_2 = var_12_0.y
		local var_12_3 = arg_12_1.delta.y * var_11_14.y

		math = var_6
		var_12_0.y = var_12_1(var_12_2 + var_12_3 / var_6.cos(var_11_7), -arg_11_0.topExtend, arg_11_0.bottomExtend)
		arg_11_0.transform.localPosition = var_12_0

		return
	end)

	return
end

function var_0_1.GetDragExtend(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_0.map.theme
	local var_13_1 = arg_13_0.transform
	local var_13_2 = var_5.Find(var_13_1, "plane")

	assert = var_13_1

	var_13_1(var_13_2, "plane not exist.")

	local var_13_3 = var_13_2.localPosition.x
	local var_13_4 = var_13_2.localPosition.y
	local var_13_5 = var_13_2.localPosition.z

	math = var_1_10009

	local var_13_6 = var_1_10009.tan

	math = var_1_10010

	local var_13_7 = var_13_4 - var_13_5 * var_13_6(var_1_10010.pi / 180 * var_13_0.angle)
	local var_13_8 = 99999999
	local var_13_9 = 0
	local var_13_10 = 0

	pairs = var_11

	for iter_13_0, iter_13_1 in var_11(var_3.cells) do
		if var_13_8 > iter_13_1.row then
			var_13_8 = iter_13_1.row
		end

		if var_13_9 < iter_13_1.row then
			var_13_9 = iter_13_1.row
		end

		if var_13_10 < iter_13_1.column then
			var_13_10 = iter_13_1.column
		end
	end

	local var_13_11 = var_3.theme.cellSize + var_3.theme.cellSpace

	math = var_12

	local var_13_12 = var_12.max(var_13_10 * var_13_11.x - arg_13_1 * 0.5, 0)

	math = var_13

	local var_13_13 = var_13.max

	WorldConst = var_14

	local var_13_14 = var_13_13((var_14.MaxRow * 0.5 - var_13_8) * var_13_11.y, 0)

	math = var_14

	local var_13_15 = var_14.max

	WorldConst = var_15

	local var_13_16 = var_13_15((var_13_9 - var_15.MaxRow * 0.5) * var_13_11.y, 0)

	return 1000 - var_13_3, var_13_12 + var_13_3, var_13_14 + var_13_7, var_13_16 - var_13_7
end

function var_0_1.ShakePlane(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4, arg_14_5)
	math = var_1_10006
	arg_14_2 = var_1_10006.clamp(arg_14_2, 0, 90)
	math = var_6
	arg_14_3 = var_6.max(arg_14_3, 1)
	math = var_6
	arg_14_4 = var_6.max(arg_14_4, 1)
	math = var_6

	local var_14_0 = var_6.pi / 180 * arg_14_2

	Vector3 = var_7
	math = var_8

	local var_14_1 = var_8.cos(var_14_0)

	math = var_9

	local var_14_2 = var_7(var_14_1, var_9.sin(var_14_0), 0) * arg_14_1
	local var_14_3 = arg_14_0.transform.anchoredPosition3D + var_14_2
	local var_14_4 = var_8 - var_14_2
	local var_14_5 = 0.0333 * arg_14_3 * 0.5
	local var_14_6 = var_11 * arg_14_3
	local var_14_7 = var_11 * arg_14_3 * 0.5

	arg_14_0.dragTrigger.enabled = false

	local var_14_8 = arg_14_0.longPressTrigger

	var_14_8.enabled = false
	LeanTween = var_14_8

	local var_14_9 = var_14_8.moveLocal(arg_14_0.transform.gameObject, var_14_3, var_14_5)

	LeanTween = var_16

	local var_14_10 = var_16.moveLocal(arg_14_0.transform.gameObject, var_14_4, var_14_6)
	local var_14_11 = var_16.setDelay(var_14_10, var_14_5)
	local var_14_12 = var_16.setLoopPingPong(var_14_11, arg_14_4)

	LeanTween = var_14_11

	local var_14_13 = var_14_11.moveLocal(arg_14_0.transform.gameObject, var_8, var_14_7)
	local var_14_14 = var_17.setDelay(var_14_13, var_14_5 + var_14_6 * arg_14_4 * 2)
	local var_14_15 = var_17.setOnComplete

	System = var_19

	local var_14_16 = var_14_15(var_14_14, var_19.Action(function()
		arg_14_0.dragTrigger.enabled = true
		arg_14_0.longPressTrigger.enabled = true

		arg_14_5()

		return
	end))
	local var_14_17 = arg_14_0.wsTimer

	var_18.AddInMapTween(var_14_17, var_14_9.uniqueId)

	local var_14_18 = arg_14_0.wsTimer

	var_18.AddInMapTween(var_14_18, var_14_12.uniqueId)

	local var_14_19 = arg_14_0.wsTimer

	var_18.AddInMapTween(var_14_19, var_14_16.uniqueId)

	return
end

return var_0_1
