local CommanderPaintingUtil = class("CommanderPaintingUtil")

function CommanderPaintingUtil:Ctor(arg_1_1)
	self.rect = arg_1_1.parent.rect

	local var_1_0 = arg_1_1.parent.parent:Find("background")

	self._tf = arg_1_1
	self.zoomDelegate = GetOrAddComponent(arg_1_1, "MultiTouchZoom")
	self.dragDelegate = GetOrAddComponent(arg_1_1, "EventTriggerListener")
	self.initPosition = self._tf.localPosition

	return
end

function CommanderPaintingUtil:Fold()
	self.zoomDelegate:SetZoomTarget(self._tf)

	self.zoomDelegate.enabled = true
	self.dragDelegate.enabled = true

	LeanTween.move(rtf(self._tf), Vector3.zero, 0.5)

	local var_2_0 = self._tf:Find("fitter"):GetChild(0)

	if var_2_0 then
		var_2_0:GetComponent(typeof(Image)).raycastTarget = true
	end

	local var_2_1 = self._tf
	local var_2_4 = self.rect.width / UnityEngine.Screen.width
	local var_2_5 = self.rect.height / UnityEngine.Screen.height
	local var_2_6 = self._tf.rect.width / 2
	local var_2_7 = self._tf.rect.height / 2
	local var_2_8
	local var_2_9
	local var_2_10 = true
	local var_2_11 = false

	self.dragDelegate:AddPointDownFunc(function(arg_3_0)
		if Input.touchCount == 1 or IsUnityEditor then
			var_2_11 = true
			var_2_10 = true
		elseif Input.touchCount >= 2 then
			var_2_10 = false
			var_2_11 = false
		end

		return
	end)
	self.dragDelegate:AddPointUpFunc(function(arg_4_0)
		if Input.touchCount <= 2 then
			var_2_10 = true
		end

		return
	end)
	self.dragDelegate:AddBeginDragFunc(function(arg_5_0, arg_5_1)
		var_2_11 = false
		var_2_8 = arg_5_1.position.x * var_2_4 - var_2_6 - var_2_1.localPosition.x
		var_2_9 = arg_5_1.position.y * var_2_5 - var_2_7 - var_2_1.localPosition.y

		return
	end)
	self.dragDelegate:AddDragFunc(function(arg_6_0, arg_6_1)
		if var_2_10 then
			self._tf.localPosition = Vector3(arg_6_1.position.x * var_2_4 - var_2_6 - var_2_8, arg_6_1.position.y * var_2_5 - var_2_7 - var_2_9, -22)
		end

		return
	end)

	return
end

function CommanderPaintingUtil:UnFold()
	LeanTween.move(rtf(self._tf), self.initPosition, 0.5)

	self.zoomDelegate.enabled = false
	self.dragDelegate.enabled = false

	self.dragDelegate:AddPointDownFunc(nil)
	self.dragDelegate:AddPointUpFunc(nil)
	self.dragDelegate:AddBeginDragFunc(nil)
	self.dragDelegate:AddDragFunc(nil)

	local var_7_0 = self._tf:Find("fitter"):GetChild(0)

	if var_7_0 then
		var_7_0:GetComponent(typeof(Image)).raycastTarget = false
	end

	return
end

function CommanderPaintingUtil:Dispose()
	self:UnFold()

	return
end

return CommanderPaintingUtil
