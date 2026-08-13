class = var_0_10000

local var_0_0 = var_0_10000("SkinAtlasPaintingView")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform
	arg_1_0.parentTF = arg_1_0._tf.parent

	local var_1_0 = {}
	local var_1_1 = arg_1_0.parentTF

	var_1_0[1] = var_3.Find(var_1_1, "main/right")

	local var_1_2 = arg_1_0.parentTF

	var_1_0[2] = var_3.Find(var_1_2, "main/left")
	arg_1_0.hideGos = var_1_0
	GetOrAddComponent = var_1_0

	local var_1_3 = arg_1_0.parentTF

	typeof = var_1_2
	PinchZoom = var_5
	arg_1_0.zoom = var_1_0(var_1_3, var_1_2(var_5))
	GetOrAddComponent = var_2

	local var_1_4 = arg_1_0.parentTF

	typeof = var_4
	EventTriggerListener = var_5
	arg_1_0.event = var_2(var_1_4, var_4(var_5))
	arg_1_0.zoom.enabled = false
	arg_1_0.event.enabled = false
	arg_1_0.lpos = arg_1_0._tf.localPosition
	arg_1_0.scale = arg_1_0._tf.localScale
	arg_1_0.isEnter = false

	return
end

function var_0_0.IsEnter(arg_2_0)
	return arg_2_0.isEnter
end

function var_0_0.Enter(arg_3_0)
	arg_3_0.isEnter = true

	arg_3_0:ShowOrHideGo(false)
	arg_3_0:EnableDragAndZoom()

	return
end

function var_0_0.ShowOrHideGo(arg_4_0, arg_4_1)
	pairs = var_1_10002

	for iter_4_0, iter_4_1 in var_1_10002(arg_4_0.hideGos) do
		setActive = var_1_10007

		var_1_10007(iter_4_1, arg_4_1)
	end

	return
end

function var_0_0.EnableDragAndZoom(arg_5_0)
	arg_5_0.isEnableDrag = true

	local var_5_0 = arg_5_0.parentTF.gameObject
	local var_5_1 = arg_5_0.zoom
	local var_5_2 = arg_5_0.event

	Vector3 = var_1_10004

	local var_5_3 = var_1_10004(0, 0, 0)

	var_5_2:AddBeginDragFunc(function(arg_6_0, arg_6_1)
		Application = var_2_10002

		if var_2_10002.isEditor then
			Input = var_2

			if var_2.GetMouseButton(2) then
				return
			end
		end

		if var_5_1.processing then
			return
		end

		setButtonEnabled = var_2

		var_2(var_5_0, false)

		Input = var_2

		if var_2.touchCount > 1 then
			return
		end

		local var_6_0 = var_0_0.Screen2Local(var_5_0.transform.parent, arg_6_1.position)

		var_5_3 = arg_5_0._tf.localPosition - var_6_0

		return
	end)
	var_5_2:AddDragFunc(function(arg_7_0, arg_7_1)
		Application = var_2_10002

		if var_2_10002.isEditor then
			Input = var_2

			if var_2.GetMouseButton(2) then
				return
			end
		end

		if var_5_1.processing then
			return
		end

		Input = var_2

		if var_2.touchCount > 1 then
			return
		end

		local var_7_0 = var_0_0.Screen2Local(var_5_0.transform.parent, arg_7_1.position)
		local var_7_1 = arg_5_0._tf
		local var_7_2 = arg_5_0

		if var_4.IslimitYPos(var_7_2) then
			Vector3 = var_7_3

			local var_7_3 = var_7_3(var_7_0.x, var_5_0.transform.localPosition.y, 0)

			Vector3 = var_5

			if not (var_7_3 + var_5(var_5_3.x, 0, 0)) then
				Vector3 = var_7_3
				var_7_3 = var_7_3(var_7_0.x, var_7_0.y, 0) + var_5_3
			end

			var_7_1.localPosition = var_7_3

			return
		end
	end)
	var_5_2:AddDragEndFunc(function()
		setButtonEnabled = var_2_10000

		var_2_10000(var_5_0, true)

		return
	end)

	if not arg_5_0:IslimitYPos() then
		var_5_1.enabled = true
	end

	var_5_2.enabled = true
	Input = var_5
	var_5.multiTouchEnabled = true

	return
end

function var_0_0.IslimitYPos(arg_9_0)
	return false
end

function var_0_0.Exit(arg_10_0)
	if arg_10_0.isEnter then
		arg_10_0.isEnter = false

		arg_10_0:ShowOrHideGo(true)
		arg_10_0:DisableDragAndZoom()

		arg_10_0._tf.localPosition = arg_10_0.lpos
		arg_10_0._tf.localScale = arg_10_0.scale
	end

	return
end

function var_0_0.DisableDragAndZoom(arg_11_0)
	if arg_11_0.isEnableDrag then
		local var_11_0 = arg_11_0.event

		ClearEventTrigger = var_1_10002

		var_1_10002(var_11_0)

		var_11_0.enabled = false
		arg_11_0.zoom.enabled = false
		arg_11_0.isEnableDrag = false
	end

	return
end

function var_0_0.Dispose(arg_12_0)
	if arg_12_0.isEnter then
		arg_12_0:Exit()
	end

	return
end

function var_0_0.Screen2Local(arg_13_0, arg_13_1)
	GameObject = var_1_10002

	local var_13_0 = var_1_10002.Find("UICamera")
	local var_13_1 = var_2.GetComponent(var_13_0, "Camera")
	local var_13_2 = arg_13_0
	local var_13_3 = arg_13_0.GetComponent(var_13_2, "RectTransform")

	LuaHelper = var_13_2

	local var_13_4 = var_13_2.ScreenToLocal(var_13_3, arg_13_1, var_13_1)

	Vector3 = var_5

	return var_5(var_13_4.x, var_13_4.y, 0)
end

return var_0_0
