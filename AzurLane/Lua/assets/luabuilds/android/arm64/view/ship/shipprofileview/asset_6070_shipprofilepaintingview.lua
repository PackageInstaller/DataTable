class = var_0_10000

local var_0_0 = var_0_10000("ShipProfilePaintingView")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	pg = var_1_10004

	var_1_10004.DelegateInfo.New(arg_1_0)

	arg_1_0.prefab = arg_1_1
	arg_1_0.painting = arg_1_2

	local var_1_0 = arg_1_0.painting

	arg_1_0.cg = var_4.GetComponent(var_1_0, "CanvasGroup")

	local var_1_1 = arg_1_0.prefab

	arg_1_0.bg = var_4.Find(var_1_1, "bg")

	local var_1_2 = arg_1_0.bg

	arg_1_0.bgBtn = var_4.GetComponent(var_1_2, "Button")
	arg_1_0.recorder = {}
	arg_1_0.hideObjList = {}
	arg_1_0.isPreview = false
	GetOrAddComponent = var_4
	arg_1_0.zoomDelegate = var_4(arg_1_0.bg, "MultiTouchZoom")

	local var_1_3 = arg_1_0.zoomDelegate

	var_1_3.enabled = false
	GetOrAddComponent = var_1_3
	arg_1_0.dragTrigger = var_1_3(arg_1_0.bg, "EventTriggerListener")

	arg_1_0:SetHideObject()

	arg_1_0.isBanRotate = arg_1_3

	return
end

function var_0_0.SetHideObject(arg_2_0)
	local var_2_0 = arg_2_0.prefab.childCount
	local var_2_1 = 0

	while var_2_1 < var_2_0 do
		local var_2_2 = arg_2_0.prefab

		if var_3.GetChild(var_2_2, var_2_1).gameObject.activeSelf and var_3 ~= arg_2_0.painting and var_3 ~= arg_2_0.bg then
			arg_2_0.hideObjList[#arg_2_0.hideObjList + 1] = var_3
		end

		var_2_1 = var_2_1 + 1
	end

	return
end

function var_0_0.setBGCallback(arg_3_0, arg_3_1)
	arg_3_0.bgCallback = arg_3_1

	return
end

function var_0_0.Start(arg_4_0)
	arg_4_0.cg.blocksRaycasts = false

	arg_4_0:EnableObjects(false)
	arg_4_0:RecodObjectInfo()

	LeanTween = var_1

	local var_4_0 = var_1.moveX(arg_4_0.painting, 0, 0.3)
	local var_4_1 = var_1.setEase

	LeanTweenType = var_4

	local var_4_2 = var_4_1(var_4_0, var_4.easeInOutSine)
	local var_4_3 = var_1.setOnComplete

	System = var_4

	var_4_3(var_4_2, var_4.Action(function()
		local var_5_0 = arg_4_0

		var_0.TweenObjects(var_5_0)

		return
	end))

	arg_4_0.isPreview = true

	return
end

function var_0_0.EnableObjects(arg_6_0, arg_6_1)
	_ = var_1_10002

	var_1_10002.each(arg_6_0.hideObjList, function(arg_7_0)
		setActive = var_2_10001

		var_2_10001(arg_7_0, arg_6_1)

		return
	end)

	return
end

function var_0_0.TweenObjects(arg_8_0)
	if not arg_8_0.isBanRotate then
		openPortrait = var_1

		var_1(arg_8_0.prefab)
	end

	local var_8_0 = true

	arg_8_0.exitFlag = false

	local var_8_1
	local var_8_2
	local var_8_3 = arg_8_0.zoomDelegate

	var_4.SetZoomTarget(var_8_3, arg_8_0.painting)

	arg_8_0.zoomDelegate.enabled = true

	local var_8_4 = arg_8_0.dragTrigger

	var_8_4.enabled = true

	var_8_4:AddPointDownFunc(function(arg_9_0)
		Input = var_2_10001

		if var_2_10001.touchCount ~= 1 then
			IsUnityEditor = var_9_0

			local var_9_0

			if var_9_0 then
				var_9_0 = arg_8_0
				var_9_0.exitFlag = true
				var_8_0 = true
			else
				Input = var_9_0

				if var_9_0.touchCount >= 2 then
					var_8_0 = false
					arg_8_0.exitFlag = false
				end
			end

			return
		end
	end)
	var_8_4:AddPointUpFunc(function(arg_10_0)
		Input = var_2_10001

		if var_2_10001.touchCount <= 2 then
			var_8_0 = true
		end

		return
	end)
	var_8_4:AddBeginDragFunc(function(arg_11_0, arg_11_1)
		arg_8_0.exitFlag = false

		local var_11_0 = arg_11_1.position.x * arg_8_0.recorder.widthRate - arg_8_0.recorder.halfWidth

		tf = var_3
		var_8_1 = var_11_0 - var_3(arg_8_0.painting).localPosition.x

		local var_11_1 = arg_11_1.position.y * arg_8_0.recorder.heightRate - arg_8_0.recorder.halfHeight

		tf = var_3
		var_8_2 = var_11_1 - var_3(arg_8_0.painting).localPosition.y

		return
	end)
	var_8_4:AddDragFunc(function(arg_12_0, arg_12_1)
		if var_8_0 then
			tf = var_2

			local var_12_0 = var_2(arg_8_0.painting).localPosition

			tf = var_2_10003

			local var_12_1 = var_2_10003(arg_8_0.painting)

			Vector3 = var_4
			var_12_1.localPosition = var_4(arg_12_1.position.x * arg_8_0.recorder.widthRate - arg_8_0.recorder.halfWidth - var_8_1 - 22, arg_12_1.position.y * arg_8_0.recorder.heightRate - arg_8_0.recorder.halfHeight - var_8_2, -22)
		end

		return
	end)

	local var_8_5 = arg_8_0.bgBtn

	var_8_5.enabled = true
	onButton = var_8_5

	local var_8_6 = arg_8_0
	local var_8_7 = arg_8_0.bg

	local function var_8_8()
		if arg_8_0.bgCallback then
			if arg_8_0.exitFlag then
				arg_8_0.bgCallback()
			end
		else
			local var_13_0 = arg_8_0

			var_0.Finish(var_13_0)
		end

		return
	end

	SFX_CANCEL = var_1_10010

	var_8_5(var_8_6, var_8_7, var_8_8, var_1_10010)

	return
end

function var_0_0.RecodObjectInfo(arg_14_0)
	arg_14_0.recorder.srcPosX = arg_14_0.painting.anchoredPosition.x
	arg_14_0.recorder.srcPosY = arg_14_0.painting.anchoredPosition.y
	arg_14_0.recorder.srcWidth = arg_14_0.painting.rect.width
	arg_14_0.recorder.srcHeight = arg_14_0.painting.rect.height

	local var_14_0 = arg_14_0.recorder
	local var_14_1 = arg_14_0.prefab.rect.width

	UnityEngine = var_1_10003
	var_14_0.widthRate = var_14_1 / var_1_10003.Screen.width

	local var_14_2 = arg_14_0.recorder
	local var_14_3 = arg_14_0.prefab.rect.height

	UnityEngine = var_3
	var_14_2.heightRate = var_14_3 / var_3.Screen.height
	arg_14_0.recorder.halfWidth = arg_14_0.recorder.srcWidth / 2
	arg_14_0.recorder.halfHeight = arg_14_0.recorder.srcHeight / 2

	return
end

function var_0_0.Finish(arg_15_0, arg_15_1)
	if not arg_15_1 and not arg_15_0.exitFlag then
		return
	end

	arg_15_0.dragTrigger.enabled = false

	local var_15_0 = arg_15_0.zoomDelegate

	var_15_0.enabled = false
	_ = var_15_0

	var_15_0.each(arg_15_0.hideObjList, function(arg_16_0)
		setActive = var_2_10001

		var_2_10001(arg_16_0, true)

		return
	end)

	if not arg_15_0.isBanRotate then
		closePortrait = var_2

		var_2(arg_15_0.prefab)
	end

	arg_15_0:EnableObjects(true)

	local var_15_1 = arg_15_0.painting

	Vector3 = var_3
	var_15_1.localScale = var_3(1, 1, 1)
	setAnchoredPosition = var_15_1

	var_15_1(arg_15_0.painting, {
		x = arg_15_0.recorder.srcPosX,
		y = arg_15_0.recorder.srcPosY
	})

	arg_15_0.bgBtn.enabled = false
	arg_15_0.cg.blocksRaycasts = true
	arg_15_0.isPreview = false
	arg_15_0.exitFlag = false
	arg_15_0.recorder = {}

	return
end

function var_0_0.Dispose(arg_17_0)
	if arg_17_0.isPreview then
		arg_17_0:Finish(true)
	end

	if arg_17_0.dragTrigger then
		ClearEventTrigger = var_1

		var_1(arg_17_0.dragTrigger)

		arg_17_0.dragTrigger = nil
	end

	arg_17_0.exitFlag = nil
	arg_17_0.recorder = nil
	arg_17_0.isPreview = nil
	pg = var_1

	var_1.DelegateInfo.Dispose(arg_17_0)

	return
end

return var_0_0
