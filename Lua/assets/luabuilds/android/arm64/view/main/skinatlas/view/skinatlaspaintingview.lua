local var_0_0 = class("SkinAtlasPaintingView")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform
	arg_1_0.parentTF = arg_1_0._tf.parent
	arg_1_0.hideGos = {
		arg_1_0.parentTF:Find("main/right"),
		arg_1_0.parentTF:Find("main/left")
	}
	arg_1_0.zoom = GetOrAddComponent(arg_1_0.parentTF, typeof(PinchZoom))
	arg_1_0.event = GetOrAddComponent(arg_1_0.parentTF, typeof(EventTriggerListener))
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
	for iter_4_0, iter_4_1 in pairs(arg_4_0.hideGos) do
		setActive(iter_4_1, arg_4_1)
	end

	return
end

function var_0_0.EnableDragAndZoom(arg_5_0)
	arg_5_0.isEnableDrag = true

	local var_5_0 = arg_5_0.parentTF.gameObject
	local var_5_1 = arg_5_0.zoom
	local var_5_2 = Vector3(0, 0, 0)

	arg_5_0.event:AddBeginDragFunc(function(arg_6_0, arg_6_1)
		if Application.isEditor and Input.GetMouseButton(2) then
			return
		end

		if var_5_1.processing then
			return
		end

		setButtonEnabled(var_5_0, false)

		if Input.touchCount > 1 then
			return
		end

		var_5_2 = arg_5_0._tf.localPosition - var_0_0.Screen2Local(var_5_0.transform.parent, arg_6_1.position)

		return
	end)
	arg_5_0.event:AddDragFunc(function(arg_7_0, arg_7_1)
		if Application.isEditor and Input.GetMouseButton(2) then
			return
		end

		if var_5_1.processing then
			return
		end

		if Input.touchCount > 1 then
			return
		end

		local var_7_0 = var_0_0.Screen2Local(var_5_0.transform.parent, arg_7_1.position)
		local var_7_1 = arg_5_0._tf

		var_7_1.localPosition = arg_5_0:IslimitYPos() and Vector3(var_7_0.x, var_5_0.transform.localPosition.y, 0) + Vector3(var_5_2.x, 0, 0) or Vector3(var_7_0.x, var_7_0.y, 0) + var_5_2

		return
	end)
	arg_5_0.event:AddDragEndFunc(function()
		setButtonEnabled(var_5_0, true)

		return
	end)

	if not arg_5_0:IslimitYPos() then
		arg_5_0.zoom.enabled = true
	end

	arg_5_0.event.enabled = true
	Input.multiTouchEnabled = true

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
		ClearEventTrigger(arg_11_0.event)

		arg_11_0.event.enabled = false
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
	local var_13_9000
	local var_13_0 = GameObject.Find("UICamera")

	return Vector3(var_13_0.x, LuaHelper.ScreenToLocal(arg_13_0:GetComponent("RectTransform"), arg_13_1, (var_13_0.GetComponent(var_13_9000, "Camera"))).y, 0)
end

return var_0_0
