local var_0_0 = class("TouchView")

function var_0_0.Ctor(arg_1_0)
	return
end

function var_0_0.AddTimer(arg_2_0)
	local var_2_0
	local var_2_1

	if arg_2_0.timer_ then
		arg_2_0.timer_:Stop()

		arg_2_0.timer_ = nil
	end

	arg_2_0.timer_ = FrameTimer.New(function()
		if UnityEngine.EventSystems.EventSystem.current.currentSelectedGameObject then
			return
		end

		if arg_2_0.hideUIFlag_ == true then
			if Input.GetMouseButtonDown(0) then
				arg_2_0.mousePosition_ = Input.mousePosition
			end

			if Input.GetMouseButtonUp(0) and arg_2_0.mousePosition_ and Input.mousePosition.x == arg_2_0.mousePosition_.x and Input.mousePosition.y == arg_2_0.mousePosition_.y then
				manager.notify:Invoke(CLICK_TRIGGER)

				arg_2_0.hideUIFlag_ = false
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
					local var_3_2 = var_3_1 * -0.1

					manager.notify:Invoke(TOUCH_VERTICAL, var_3_2)
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
					local var_3_3 = Input.GetTouch(0)

					if var_3_3.phase == UnityEngine.TouchPhase.Began then
						var_3_3.rawPosition = var_3_3.position
						var_3_3.deltaPosition = Vector2(0, 0)
						arg_2_0.lastPosition_ = var_3_3.position
						arg_2_0.touchBegan_ = true
					elseif var_3_3.phase == UnityEngine.TouchPhase.Ended then
						arg_2_0.touchBegan_ = false
					end

					if arg_2_0.touchBegan_ ~= true then
						return
					end

					local var_3_4 = var_3_3.position - arg_2_0.lastPosition_
					local var_3_5 = var_3_4.x
					local var_3_6 = var_3_4.y

					arg_2_0.lastPosition_ = var_3_3.position

					if math.abs(var_3_5) >= math.abs(var_3_6) then
						manager.notify:Invoke(TOUCH_HORIZONTAL, var_3_5 * -0.25)
					else
						local var_3_7 = var_3_6 * -0.0008 * (Screen.dpi / 96) * manager.ui.mainCameraCom_.fieldOfView / 28

						manager.notify:Invoke(TOUCH_VERTICAL, var_3_7)
					end
				end
			else
				local var_3_8 = Input.GetTouch(0)
				local var_3_9 = Input.GetTouch(1)

				if var_3_9.phase == UnityEngine.TouchPhase.Began then
					var_2_1 = var_3_9
					var_2_0 = var_3_8

					return
				end

				local var_3_10 = Vector2.Distance(var_2_0.position, var_2_1.position)
				local var_3_11 = Vector2.Distance(var_3_8.position, var_3_9.position) - var_3_10

				if not UnityEngine.EventSystems.EventSystem.current:IsPointerOverGameObject(Input.GetTouch(0).fingerId) and not UnityEngine.EventSystems.EventSystem.current:IsPointerOverGameObject(Input.GetTouch(1).fingerId) then
					local var_3_12 = var_3_11 / -20

					manager.notify:Invoke(MULTI_TOUCH_SCALE, var_3_12)
				end
			end
		end
	end, 1, -1)

	arg_2_0.timer_:Start()
end

function var_0_0.OnEnter(arg_4_0)
	arg_4_0:AddTimer()

	arg_4_0.hideUIFlag_ = false
end

function var_0_0.OnExit(arg_5_0)
	arg_5_0.timer_:Stop()

	arg_5_0.timer_ = nil
end

function var_0_0.Dispose(arg_6_0)
	return
end

function var_0_0.HideUI(arg_7_0)
	arg_7_0.hideUIFlag_ = true
	arg_7_0.mousePosition_ = nil
end

return var_0_0
