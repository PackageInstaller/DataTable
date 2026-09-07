local SkinAtlasPaintingView = class("SkinAtlasPaintingView")

function SkinAtlasPaintingView:Ctor(arg_1_1)
	self._go = arg_1_1
	self._tf = arg_1_1.transform
	self.parentTF = self._tf.parent
	self.hideGos = {
		self.parentTF:Find("main/right"),
		self.parentTF:Find("main/left")
	}
	self.zoom = GetOrAddComponent(self.parentTF, typeof(PinchZoom))
	self.event = GetOrAddComponent(self.parentTF, typeof(EventTriggerListener))
	self.zoom.enabled = false
	self.event.enabled = false
	self.lpos = self._tf.localPosition
	self.scale = self._tf.localScale
	self.isEnter = false

	return
end

function SkinAtlasPaintingView:IsEnter()
	return self.isEnter
end

function SkinAtlasPaintingView:Enter()
	self.isEnter = true

	self:ShowOrHideGo(false)
	self:EnableDragAndZoom()

	return
end

function SkinAtlasPaintingView:ShowOrHideGo(arg_4_1)
	for iter_4_0, iter_4_1 in pairs(self.hideGos) do
		setActive(iter_4_1, arg_4_1)
	end

	return
end

function SkinAtlasPaintingView:EnableDragAndZoom()
	self.isEnableDrag = true

	local var_5_0 = self.parentTF.gameObject
	local var_5_1 = self.zoom
	local var_5_2 = Vector3(0, 0, 0)

	self.event:AddBeginDragFunc(function(arg_6_0, arg_6_1)
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

		var_5_2 = self._tf.localPosition - SkinAtlasPaintingView.Screen2Local(var_5_0.transform.parent, arg_6_1.position)

		return
	end)
	self.event:AddDragFunc(function(arg_7_0, arg_7_1)
		if Application.isEditor and Input.GetMouseButton(2) then
			return
		end

		if var_5_1.processing then
			return
		end

		if Input.touchCount > 1 then
			return
		end

		local var_7_0 = SkinAtlasPaintingView.Screen2Local(var_5_0.transform.parent, arg_7_1.position)

		self._tf.localPosition = self:IslimitYPos() and Vector3(var_7_0.x, var_5_0.transform.localPosition.y, 0) + Vector3(var_5_2.x, 0, 0) or Vector3(var_7_0.x, var_7_0.y, 0) + var_5_2

		return
	end)
	self.event:AddDragEndFunc(function()
		setButtonEnabled(var_5_0, true)

		return
	end)

	if not self:IslimitYPos() then
		self.zoom.enabled = true
	end

	self.event.enabled = true
	Input.multiTouchEnabled = true

	return
end

function SkinAtlasPaintingView:IslimitYPos()
	return false
end

function SkinAtlasPaintingView:Exit()
	if self.isEnter then
		self.isEnter = false

		self:ShowOrHideGo(true)
		self:DisableDragAndZoom()

		self._tf.localPosition = self.lpos
		self._tf.localScale = self.scale
	end

	return
end

function SkinAtlasPaintingView:DisableDragAndZoom()
	if self.isEnableDrag then
		ClearEventTrigger(self.event)

		self.event.enabled = false
		self.zoom.enabled = false
		self.isEnableDrag = false
	end

	return
end

function SkinAtlasPaintingView:Dispose()
	if self.isEnter then
		self:Exit()
	end

	return
end

function SkinAtlasPaintingView:Screen2Local(arg_13_1)
	local var_13_0 = GameObject.Find("UICamera")

	return Vector3(var_13_0.x, LuaHelper.ScreenToLocal(self:GetComponent("RectTransform"), arg_13_1, (var_13_0:GetComponent("Camera"))).y, 0)
end

return SkinAtlasPaintingView
