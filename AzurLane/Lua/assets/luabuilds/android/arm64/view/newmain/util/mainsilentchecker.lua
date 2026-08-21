local var_0_0 = class("MainSilentChecker", import("view.base.BaseEventLogic"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0._silentRunFlag = true

	return
end

function var_0_0.SetUp(arg_2_0)
	arg_2_0:Clear()

	arg_2_0.inactivityTimeout = SettingsMainScenePanel.GetEnterFlagShipTime()
	arg_2_0.lastActivityTime = Time.time
	arg_2_0.handle = arg_2_0.handle or UpdateBeat:CreateListener(arg_2_0.Update, arg_2_0)

	UpdateBeat:AddListener(arg_2_0.handle)

	arg_2_0.isFoldState = false

	arg_2_0:bind(NewMainScene.FOLD, function(arg_3_0, arg_3_1)
		arg_2_0.isFoldState = arg_3_1

		return
	end)

	return
end

function var_0_0.Update(arg_4_0)
	if IsUnityEditor then
		if Input.anyKeyDown then
			arg_4_0.lastActivityTime = Time.time
		end
	elseif Input.touchCount > 0 then
		arg_4_0.lastActivityTime = Time.time
	end

	if Time.time - arg_4_0.lastActivityTime > arg_4_0.inactivityTimeout then
		arg_4_0:EnterState()
	end

	return
end

function var_0_0.EnterState(arg_5_0)
	if arg_5_0:AnyOverlayShowing() then
		arg_5_0.lastActivityTime = Time.time

		return
	end

	if arg_5_0._silentRunFlag then
		arg_5_0:Clear()
		arg_5_0:emit(NewMainScene.ENTER_SILENT_VIEW)
	end

	return
end

function var_0_0.AnyOverlayShowing(arg_6_0)
	local var_6_9000
	local var_6_0 = getProxy(ContextProxy)
	local var_6_1 = var_6_0.getCurrentContext(var_6_9000)
	local var_6_2 = pg.NewStoryMgr.GetInstance().IsRunning(var_6_0)

	if not var_6_2 then
		var_6_2 = pg.NewGuideMgr.GetInstance():IsBusy()

		if not var_6_2 then
			var_6_2 = isActive(pg.MsgboxMgr.GetInstance()._tf)

			if not var_6_2 then
				var_6_2 = var_6_1:hasChild()
				var_6_2 = var_6_2 or pg.LayerWeightMgr.GetInstance().uiOrigin.childCount > 0 or arg_6_0.isFoldState
			end
		end
	end

	return var_6_2
end

function var_0_0.Clear(arg_7_0)
	if arg_7_0.handle then
		UpdateBeat:RemoveListener(arg_7_0.handle)

		arg_7_0.handle = nil
	end

	arg_7_0:disposeEvent()

	arg_7_0.isFoldState = false

	return
end

function var_0_0.Disable(arg_8_0)
	arg_8_0:Clear()

	return
end

function var_0_0.SetSilentRun(arg_9_0, arg_9_1)
	arg_9_0._silentRunFlag = arg_9_1

	return
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0:Disable()

	return
end

return var_0_0
