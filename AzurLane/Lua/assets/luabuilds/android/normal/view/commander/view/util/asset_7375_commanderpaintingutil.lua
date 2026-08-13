class = var_0_10000

local var_0_0 = var_0_10000("CommanderPaintingUtil")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.rect = arg_1_1.parent.rect

	local var_1_0 = arg_1_1.parent.parent
	local var_1_1 = var_2.Find(var_1_0, "background")

	arg_1_0._tf = arg_1_1
	GetOrAddComponent = var_1_0
	arg_1_0.zoomDelegate = var_1_0(arg_1_1, "MultiTouchZoom")
	GetOrAddComponent = var_3
	arg_1_0.dragDelegate = var_3(arg_1_1, "EventTriggerListener")
	arg_1_0.initPosition = arg_1_0._tf.localPosition

	return
end

function var_0_0.Fold(arg_2_0)
	local var_2_0 = arg_2_0.zoomDelegate

	var_1.SetZoomTarget(var_2_0, arg_2_0._tf)

	arg_2_0.zoomDelegate.enabled = true

	local var_2_1 = arg_2_0.dragDelegate

	var_2_1.enabled = true
	LeanTween = var_2_1

	local var_2_2 = var_2_1.move

	rtf = var_2

	local var_2_3 = var_2(arg_2_0._tf)

	Vector3 = var_3

	var_2_2(var_2_3, var_3.zero, 0.5)

	local var_2_4 = arg_2_0._tf
	local var_2_5 = var_1.Find(var_2_4, "fitter")

	if var_1.GetChild(var_2_5, 0) then
		local var_2_6 = var_1
		local var_2_7 = var_1.GetComponent

		typeof = var_4
		Image = var_1_10005
		var_2_7(var_2_6, var_4(var_1_10005)).raycastTarget = true
	end

	local var_2_8 = arg_2_0._tf.anchoredPosition.x
	local var_2_9 = var_2.anchoredPosition.y
	local var_2_10 = var_2.rect.width
	local var_2_11 = var_2.rect.height
	local var_2_12 = arg_2_0.rect.width

	UnityEngine = var_1_10008

	local var_2_13 = var_2_12 / var_1_10008.Screen.width
	local var_2_14 = arg_2_0.rect.height

	UnityEngine = var_1_10009

	local var_2_15 = var_2_14 / var_1_10009.Screen.height
	local var_2_16 = var_2_10 / 2
	local var_2_17 = var_2_11 / 2
	local var_2_18
	local var_2_19
	local var_2_20 = true
	local var_2_21 = false
	local var_2_22 = arg_2_0.dragDelegate

	var_15.AddPointDownFunc(var_2_22, function(arg_3_0)
		Input = var_2_10001

		if var_2_10001.touchCount ~= 1 then
			IsUnityEditor = var_1

			if var_1 then
				var_2_21 = true
				var_2_20 = true
			else
				Input = var_1

				if var_1.touchCount >= 2 then
					var_2_20 = false
					var_2_21 = false
				end
			end

			return
		end
	end)

	local var_2_23 = arg_2_0.dragDelegate

	var_15.AddPointUpFunc(var_2_23, function(arg_4_0)
		Input = var_2_10001

		if var_2_10001.touchCount <= 2 then
			var_2_20 = true
		end

		return
	end)

	local var_2_24 = arg_2_0.dragDelegate

	var_15.AddBeginDragFunc(var_2_24, function(arg_5_0, arg_5_1)
		var_2_21 = false
		var_2_18 = arg_5_1.position.x * var_2_13 - var_2_16 - var_0.localPosition.x
		var_2_19 = arg_5_1.position.y * var_2_15 - var_2_17 - var_0.localPosition.y

		return
	end)

	local var_2_25 = arg_2_0.dragDelegate

	var_15.AddDragFunc(var_2_25, function(arg_6_0, arg_6_1)
		if var_2_20 then
			local var_6_0 = arg_2_0._tf.localPosition
			local var_6_1 = arg_2_0._tf

			Vector3 = var_2_10004
			var_6_1.localPosition = var_2_10004(arg_6_1.position.x * var_2_13 - var_2_16 - var_2_18, arg_6_1.position.y * var_2_15 - var_2_17 - var_2_19, -22)
		end

		return
	end)

	return
end

function var_0_0.UnFold(arg_7_0)
	LeanTween = var_1_10001

	local var_7_0 = var_1_10001.move

	rtf = var_1_10002

	var_7_0(var_1_10002(arg_7_0._tf), arg_7_0.initPosition, 0.5)

	arg_7_0.zoomDelegate.enabled = false
	arg_7_0.dragDelegate.enabled = false

	local var_7_1 = arg_7_0.dragDelegate

	var_1.AddPointDownFunc(var_7_1, nil)

	local var_7_2 = arg_7_0.dragDelegate

	var_1.AddPointUpFunc(var_7_2, nil)

	local var_7_3 = arg_7_0.dragDelegate

	var_1.AddBeginDragFunc(var_7_3, nil)

	local var_7_4 = arg_7_0.dragDelegate

	var_1.AddDragFunc(var_7_4, nil)

	local var_7_5 = arg_7_0._tf
	local var_7_6 = var_1.Find(var_7_5, "fitter")

	if var_1.GetChild(var_7_6, 0) then
		local var_7_7 = var_1
		local var_7_8 = var_1.GetComponent

		typeof = var_4
		Image = var_1_10005
		var_7_8(var_7_7, var_4(var_1_10005)).raycastTarget = false
	end

	return
end

function var_0_0.Dispose(arg_8_0)
	arg_8_0:UnFold()

	return
end

return var_0_0
