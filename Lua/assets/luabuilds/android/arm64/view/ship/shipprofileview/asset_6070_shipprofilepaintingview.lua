local ShipProfilePaintingView = class("ShipProfilePaintingView")

function ShipProfilePaintingView:Ctor(arg_1_1, arg_1_2, arg_1_3)
	pg.DelegateInfo.New(self)

	self.prefab = arg_1_1
	self.painting = arg_1_2
	self.cg = self.painting:GetComponent("CanvasGroup")
	self.bg = self.prefab:Find("bg")
	self.bgBtn = self.bg:GetComponent("Button")
	self.recorder = {}
	self.hideObjList = {}
	self.isPreview = false
	self.zoomDelegate = GetOrAddComponent(self.bg, "MultiTouchZoom")
	self.zoomDelegate.enabled = false
	self.dragTrigger = GetOrAddComponent(self.bg, "EventTriggerListener")

	self:SetHideObject()

	self.isBanRotate = arg_1_3

	return
end

function ShipProfilePaintingView:SetHideObject()
	while 0 < self.prefab.childCount do
		local var_2_0 = self.prefab:GetChild(0)

		if var_2_0.gameObject.activeSelf and var_2_0 ~= self.painting and var_2_0 ~= self.bg then
			self.hideObjList[#self.hideObjList + 1] = var_2_0
		end
	end

	return
end

function ShipProfilePaintingView:setBGCallback(arg_3_1)
	self.bgCallback = arg_3_1

	return
end

function ShipProfilePaintingView:Start()
	self.cg.blocksRaycasts = false

	self:EnableObjects(false)
	self:RecodObjectInfo()
	LeanTween.moveX(self.painting, 0, 0.3):setEase(LeanTweenType.easeInOutSine):setOnComplete(System.Action(function()
		self:TweenObjects()

		return
	end))

	self.isPreview = true

	return
end

function ShipProfilePaintingView:EnableObjects(arg_6_1)
	_.each(self.hideObjList, function(arg_7_0)
		setActive(arg_7_0, arg_6_1)

		return
	end)

	return
end

function ShipProfilePaintingView:TweenObjects()
	if not self.isBanRotate then
		openPortrait(self.prefab)
	end

	local var_8_0 = true

	self.exitFlag = false

	local var_8_1
	local var_8_2

	self.zoomDelegate:SetZoomTarget(self.painting)

	self.zoomDelegate.enabled = true
	self.dragTrigger.enabled = true

	self.dragTrigger:AddPointDownFunc(function(arg_9_0)
		if Input.touchCount == 1 or IsUnityEditor then
			self.exitFlag = true
			var_8_0 = true
		elseif Input.touchCount >= 2 then
			var_8_0 = false
			self.exitFlag = false
		end

		return
	end)
	self.dragTrigger:AddPointUpFunc(function(arg_10_0)
		if Input.touchCount <= 2 then
			var_8_0 = true
		end

		return
	end)
	self.dragTrigger:AddBeginDragFunc(function(arg_11_0, arg_11_1)
		self.exitFlag = false
		var_8_1 = arg_11_1.position.x * self.recorder.widthRate - self.recorder.halfWidth - tf(self.painting).localPosition.x
		var_8_2 = arg_11_1.position.y * self.recorder.heightRate - self.recorder.halfHeight - tf(self.painting).localPosition.y

		return
	end)
	self.dragTrigger:AddDragFunc(function(arg_12_0, arg_12_1)
		if var_8_0 then
			local var_12_0 = tf(self.painting).localPosition

			tf(self.painting).localPosition = Vector3(arg_12_1.position.x * self.recorder.widthRate - self.recorder.halfWidth - var_8_1 - 22, arg_12_1.position.y * self.recorder.heightRate - self.recorder.halfHeight - var_8_2, -22)
		end

		return
	end)

	self.bgBtn.enabled = true

	onButton(self, self.bg, function()
		if self.bgCallback then
			if self.exitFlag then
				self.bgCallback()
			end
		else
			self:Finish()
		end

		return
	end, SFX_CANCEL)

	return
end

function ShipProfilePaintingView:RecodObjectInfo()
	self.recorder.srcPosX = self.painting.anchoredPosition.x
	self.recorder.srcPosY = self.painting.anchoredPosition.y
	self.recorder.srcWidth = self.painting.rect.width
	self.recorder.srcHeight = self.painting.rect.height
	self.recorder.widthRate = self.prefab.rect.width / UnityEngine.Screen.width
	self.recorder.heightRate = self.prefab.rect.height / UnityEngine.Screen.height
	self.recorder.halfWidth = self.recorder.srcWidth / 2
	self.recorder.halfHeight = self.recorder.srcHeight / 2

	return
end

function ShipProfilePaintingView:Finish(arg_15_1)
	if not arg_15_1 and not self.exitFlag then
		return
	end

	self.dragTrigger.enabled = false
	self.zoomDelegate.enabled = false

	_.each(self.hideObjList, function(arg_16_0)
		setActive(arg_16_0, true)

		return
	end)

	if not self.isBanRotate then
		closePortrait(self.prefab)
	end

	self:EnableObjects(true)

	self.painting.localScale = Vector3(1, 1, 1)

	setAnchoredPosition(self.painting, {
		x = self.recorder.srcPosX,
		y = self.recorder.srcPosY
	})

	self.bgBtn.enabled = false
	self.cg.blocksRaycasts = true
	self.isPreview = false
	self.exitFlag = false
	self.recorder = {}

	return
end

function ShipProfilePaintingView:Dispose()
	if self.isPreview then
		self:Finish(true)
	end

	if self.dragTrigger then
		ClearEventTrigger(self.dragTrigger)

		self.dragTrigger = nil
	end

	self.exitFlag = nil
	self.recorder = nil
	self.isPreview = nil

	pg.DelegateInfo.Dispose(self)

	return
end

return ShipProfilePaintingView
