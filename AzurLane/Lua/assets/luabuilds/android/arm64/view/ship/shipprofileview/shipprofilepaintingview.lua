local var_0_0 = class("ShipProfilePaintingView")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	pg.DelegateInfo.New(arg_1_0)

	arg_1_0.prefab = arg_1_1
	arg_1_0.painting = arg_1_2
	arg_1_0.cg = arg_1_0.painting:GetComponent("CanvasGroup")
	arg_1_0.bg = arg_1_0.prefab:Find("bg")
	arg_1_0.bgBtn = arg_1_0.bg:GetComponent("Button")
	arg_1_0.recorder = {}
	arg_1_0.hideObjList = {}
	arg_1_0.isPreview = false
	arg_1_0.zoomDelegate = GetOrAddComponent(arg_1_0.bg, "MultiTouchZoom")
	arg_1_0.zoomDelegate.enabled = false
	arg_1_0.dragTrigger = GetOrAddComponent(arg_1_0.bg, "EventTriggerListener")

	arg_1_0:SetHideObject()

	arg_1_0.isBanRotate = arg_1_3

	return
end

function var_0_0.SetHideObject(arg_2_0)
	while 0 < arg_2_0.prefab.childCount do
		local var_2_0 = arg_2_0.prefab:GetChild(0)

		if var_2_0.gameObject.activeSelf and var_2_0 ~= arg_2_0.painting and var_2_0 ~= arg_2_0.bg then
			arg_2_0.hideObjList[#arg_2_0.hideObjList + 1] = var_2_0
		end
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
	LeanTween.moveX(arg_4_0.painting, 0, 0.3):setEase(LeanTweenType.easeInOutSine):setOnComplete(System.Action(function()
		arg_4_0:TweenObjects()

		return
	end))

	arg_4_0.isPreview = true

	return
end

function var_0_0.EnableObjects(arg_6_0, arg_6_1)
	_.each(arg_6_0.hideObjList, function(arg_7_0)
		setActive(arg_7_0, arg_6_1)

		return
	end)

	return
end

function var_0_0.TweenObjects(arg_8_0)
	if not arg_8_0.isBanRotate then
		openPortrait(arg_8_0.prefab)
	end

	local var_8_0 = true

	arg_8_0.exitFlag = false

	local var_8_1
	local var_8_2

	arg_8_0.zoomDelegate:SetZoomTarget(arg_8_0.painting)

	arg_8_0.zoomDelegate.enabled = true
	arg_8_0.dragTrigger.enabled = true

	arg_8_0.dragTrigger:AddPointDownFunc(function(arg_9_0)
		if Input.touchCount == 1 or IsUnityEditor then
			arg_8_0.exitFlag = true
			var_8_0 = true
		elseif Input.touchCount >= 2 then
			var_8_0 = false
			arg_8_0.exitFlag = false
		end

		return
	end)
	arg_8_0.dragTrigger:AddPointUpFunc(function(arg_10_0)
		if Input.touchCount <= 2 then
			var_8_0 = true
		end

		return
	end)
	arg_8_0.dragTrigger:AddBeginDragFunc(function(arg_11_0, arg_11_1)
		arg_8_0.exitFlag = false
		var_8_1 = arg_11_1.position.x * arg_8_0.recorder.widthRate - arg_8_0.recorder.halfWidth - tf(arg_8_0.painting).localPosition.x
		var_8_2 = arg_11_1.position.y * arg_8_0.recorder.heightRate - arg_8_0.recorder.halfHeight - tf(arg_8_0.painting).localPosition.y

		return
	end)
	arg_8_0.dragTrigger:AddDragFunc(function(arg_12_0, arg_12_1)
		if var_8_0 then
			local var_12_0 = tf(arg_8_0.painting).localPosition

			tf(arg_8_0.painting).localPosition = Vector3(arg_12_1.position.x * arg_8_0.recorder.widthRate - arg_8_0.recorder.halfWidth - var_8_1 - 22, arg_12_1.position.y * arg_8_0.recorder.heightRate - arg_8_0.recorder.halfHeight - var_8_2, -22)
		end

		return
	end)

	arg_8_0.bgBtn.enabled = true

	onButton(arg_8_0, arg_8_0.bg, function()
		if arg_8_0.bgCallback then
			if arg_8_0.exitFlag then
				arg_8_0.bgCallback()
			end
		else
			arg_8_0:Finish()
		end

		return
	end, SFX_CANCEL)

	return
end

function var_0_0.RecodObjectInfo(arg_14_0)
	arg_14_0.recorder.srcPosX = arg_14_0.painting.anchoredPosition.x
	arg_14_0.recorder.srcPosY = arg_14_0.painting.anchoredPosition.y
	arg_14_0.recorder.srcWidth = arg_14_0.painting.rect.width
	arg_14_0.recorder.srcHeight = arg_14_0.painting.rect.height
	arg_14_0.recorder.widthRate = arg_14_0.prefab.rect.width / UnityEngine.Screen.width
	arg_14_0.recorder.heightRate = arg_14_0.prefab.rect.height / UnityEngine.Screen.height
	arg_14_0.recorder.halfWidth = arg_14_0.recorder.srcWidth / 2
	arg_14_0.recorder.halfHeight = arg_14_0.recorder.srcHeight / 2

	return
end

function var_0_0.Finish(arg_15_0, arg_15_1)
	if not arg_15_1 and not arg_15_0.exitFlag then
		return
	end

	arg_15_0.dragTrigger.enabled = false
	arg_15_0.zoomDelegate.enabled = false

	_.each(arg_15_0.hideObjList, function(arg_16_0)
		setActive(arg_16_0, true)

		return
	end)

	if not arg_15_0.isBanRotate then
		closePortrait(arg_15_0.prefab)
	end

	arg_15_0:EnableObjects(true)

	arg_15_0.painting.localScale = Vector3(1, 1, 1)

	setAnchoredPosition(arg_15_0.painting, {
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
		ClearEventTrigger(arg_17_0.dragTrigger)

		arg_17_0.dragTrigger = nil
	end

	arg_17_0.exitFlag = nil
	arg_17_0.recorder = nil
	arg_17_0.isPreview = nil

	pg.DelegateInfo.Dispose(arg_17_0)

	return
end

return var_0_0
