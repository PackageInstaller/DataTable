local var_0_0 = class("CommanderPaintingUtil")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.rect = arg_1_1.parent.rect

	local var_1_0 = arg_1_1.parent.parent:Find("background")

	arg_1_0._tf = arg_1_1
	arg_1_0.zoomDelegate = GetOrAddComponent(arg_1_1, "MultiTouchZoom")
	arg_1_0.dragDelegate = GetOrAddComponent(arg_1_1, "EventTriggerListener")
	arg_1_0.initPosition = arg_1_0._tf.localPosition

	return
end

function var_0_0.Fold(arg_2_0)
	arg_2_0.zoomDelegate:SetZoomTarget(arg_2_0._tf)

	arg_2_0.zoomDelegate.enabled = true
	arg_2_0.dragDelegate.enabled = true

	LeanTween.move(rtf(arg_2_0._tf), Vector3.zero, 0.5)

	local var_2_0 = arg_2_0._tf:Find("fitter"):GetChild(0)
	local var_2_1, var_2_2, var_2_3, var_2_4, var_2_5

	if var_2_0 then
		var_2_0:GetComponent(typeof(Image)).raycastTarget = true
		var_2_1 = arg_2_0._tf.anchoredPosition.x
		var_2_2 = arg_2_0._tf.anchoredPosition.y
		var_2_3 = arg_2_0.rect.width / UnityEngine.Screen.width
		var_2_4 = arg_2_0.rect.height / UnityEngine.Screen.height
		var_2_5 = arg_2_0._tf.rect.width / 2
	end

	local var_2_6 = arg_2_0._tf.rect.height / 2
	local var_2_7
	local var_2_8
	local var_2_9 = true
	local var_2_10 = false

	arg_2_0.dragDelegate:AddPointDownFunc(function(arg_3_0)
		if Input.touchCount == 1 or IsUnityEditor then
			var_2_10 = true
			var_2_9 = true
		elseif Input.touchCount >= 2 then
			var_2_9 = false
			var_2_10 = false
		end

		return
	end)
	arg_2_0.dragDelegate:AddPointUpFunc(function(arg_4_0)
		if Input.touchCount <= 2 then
			var_2_9 = true
		end

		return
	end)
	arg_2_0.dragDelegate:AddBeginDragFunc(function(arg_5_0, arg_5_1)
		var_2_10 = false
		var_2_7 = arg_5_1.position.x * var_2_3 - var_2_5 - var_0.localPosition.x
		var_2_8 = arg_5_1.position.y * var_2_4 - var_2_6 - var_0.localPosition.y

		return
	end)
	arg_2_0.dragDelegate:AddDragFunc(function(arg_6_0, arg_6_1)
		if var_2_9 then
			arg_2_0._tf.localPosition = Vector3(arg_6_1.position.x * var_2_3 - var_2_5 - var_2_7, arg_6_1.position.y * var_2_4 - var_2_6 - var_2_8, -22)
		end

		return
	end)

	return
end

function var_0_0.UnFold(arg_7_0)
	LeanTween.move(rtf(arg_7_0._tf), arg_7_0.initPosition, 0.5)

	arg_7_0.zoomDelegate.enabled = false
	arg_7_0.dragDelegate.enabled = false

	arg_7_0.dragDelegate:AddPointDownFunc(nil)
	arg_7_0.dragDelegate:AddPointUpFunc(nil)
	arg_7_0.dragDelegate:AddBeginDragFunc(nil)
	arg_7_0.dragDelegate:AddDragFunc(nil)

	local var_7_0 = arg_7_0._tf:Find("fitter"):GetChild(0)

	if var_7_0 then
		var_7_0:GetComponent(typeof(Image)).raycastTarget = false
	end

	return
end

function var_0_0.Dispose(arg_8_0)
	arg_8_0:UnFold()

	return
end

return var_0_0
