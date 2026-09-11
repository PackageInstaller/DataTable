local TouchView = class("TouchView")

function TouchView:Ctor()
	return
end

function TouchView:AddTimer()
	local var_2_0
	local var_2_1

	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end

	self.timer_ = FrameTimer.New(function()
		if UnityEngine.EventSystems.EventSystem.current.currentSelectedGameObject then
			return
		end

		if self.hideUIFlag_ == true then
			if Input.GetMouseButtonDown(0) then
				self.mousePosition_ = Input.mousePosition
			end

			if Input.GetMouseButtonUp(0) and self.mousePosition_ and Input.mousePosition.x == self.mousePosition_.x and Input.mousePosition.y == self.mousePosition_.y then
				manager.notify:Invoke(CLICK_TRIGGER)

				self.hideUIFlag_ = false
			end
		end

		if GameToSDK.IsEditorOrPcPlatform() then
			if UnityEngine.EventSystems.EventSystem.current:IsPointerOverGameObject() then
				return
			end

			if Input.GetMouseButton(0) then
				local var_3_0 = Input.GetAxis("Mouse X")
				local var_3_1 = Input.GetAxis("Mouse Y")

				if math.abs(var_3_0) >= math.abs(var_3_1) then
					manager.notify:Invoke(TOUCH_HORIZONTAL, var_3_0 * -10)
				else
					manager.notify:Invoke(TOUCH_VERTICAL, var_3_1 * -0.1)
				end
			elseif Input.GetAxis("Mouse ScrollWheel") < 0 then
				manager.notify:Invoke(MULTI_TOUCH_SCALE, 0.5)
			elseif Input.GetAxis("Mouse ScrollWheel") > 0 then
				manager.notify:Invoke(MULTI_TOUCH_SCALE, -0.5)
			end
		else
			if Input.touchCount <= 0 then
				return
			end

			if Input.touchCount == 1 then
				if not UnityEngine.EventSystems.EventSystem.current:IsPointerOverGameObject(Input.GetTouch(0).fingerId) then
					local var_3_2 = Input.GetTouch(0)

					if var_3_2.phase == UnityEngine.TouchPhase.Began then
						var_3_2.rawPosition = var_3_2.position
						var_3_2.deltaPosition = Vector2(0, 0)
						self.lastPosition_ = var_3_2.position
						self.touchBegan_ = true
					elseif var_3_2.phase == UnityEngine.TouchPhase.Ended then
						self.touchBegan_ = false
					end

					if self.touchBegan_ ~= true then
						return
					end

					local var_3_3 = (var_3_2.position - self.lastPosition_).y

					self.lastPosition_ = var_3_2.position

					if math.abs((var_3_2.position - self.lastPosition_).x) >= math.abs(var_3_3) then
						manager.notify:Invoke(TOUCH_HORIZONTAL, (var_3_2.position - self.lastPosition_).x * -0.25)
					else
						manager.notify:Invoke(TOUCH_VERTICAL, var_3_3 * -0.0008 * (Screen.dpi / 96) * manager.ui.mainCameraCom_.fieldOfView / 28)
					end
				end
			else
				local var_3_4 = Input.GetTouch(0)
				local var_3_5 = Input.GetTouch(1)

				if var_3_5.phase == UnityEngine.TouchPhase.Began then
					var_2_1 = var_3_5
					var_2_0 = var_3_4

					return
				end

				if not UnityEngine.EventSystems.EventSystem.current:IsPointerOverGameObject(Input.GetTouch(0).fingerId) and not UnityEngine.EventSystems.EventSystem.current:IsPointerOverGameObject(Input.GetTouch(1).fingerId) then
					manager.notify:Invoke(MULTI_TOUCH_SCALE, (Vector2.Distance(var_3_4.position, var_3_5.position) - Vector2.Distance(var_2_0.position, var_2_1.position)) / -20)
				end
			end
		end
	end, 1, -1)

	self.timer_:Start()
end

function TouchView:OnEnter()
	self:AddTimer()

	self.hideUIFlag_ = false
end

function TouchView:OnExit()
	self.timer_:Stop()

	self.timer_ = nil
end

function TouchView:Dispose()
	return
end

function TouchView:HideUI()
	self.hideUIFlag_ = true
	self.mousePosition_ = nil
end

return TouchView
