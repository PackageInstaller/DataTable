class = var_0_10000

local var_0_0 = "MainSilentChecker"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseEventLogic"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0._silentRunFlag = true

	return
end

function var_0_1.SetUp(arg_2_0)
	local var_2_0 = arg_2_0

	arg_2_0.Clear(var_2_0)

	SettingsMainScenePanel = var_1
	arg_2_0.inactivityTimeout = var_1.GetEnterFlagShipTime()
	Time = var_2_0
	arg_2_0.lastActivityTime = var_2_0.time

	if not arg_2_0.handle then
		UpdateBeat = var_2
		arg_2_0.handle = var_2:CreateListener(arg_2_0.Update, arg_2_0)
	end

	UpdateBeat = var_2

	var_2:AddListener(arg_2_0.handle)

	arg_2_0.isFoldState = false

	local var_2_1 = arg_2_0
	local var_2_2 = arg_2_0.bind

	NewMainScene = var_4

	var_2_2(var_2_1, var_4.FOLD, function(arg_3_0, arg_3_1)
		arg_2_0.isFoldState = arg_3_1

		return
	end)

	return
end

function var_0_1.Update(arg_4_0)
	IsUnityEditor = var_1_10001

	if var_1_10001 then
		Input = var_1_10001

		if var_1_10001.anyKeyDown then
			Time = var_1_10001
			arg_4_0.lastActivityTime = var_1_10001.time
		end
	else
		Input = var_1_10001

		if var_1_10001.touchCount > 0 then
			Time = var_1_10001
			arg_4_0.lastActivityTime = var_1_10001.time
		end
	end

	Time = var_1_10001

	if var_1_10001.time - arg_4_0.lastActivityTime > arg_4_0.inactivityTimeout then
		arg_4_0:EnterState()
	end

	return
end

function var_0_1.EnterState(arg_5_0)
	if arg_5_0:AnyOverlayShowing() then
		Time = var_1
		arg_5_0.lastActivityTime = var_1.time

		return
	end

	if arg_5_0._silentRunFlag then
		arg_5_0:Clear()

		local var_5_0 = arg_5_0
		local var_5_1 = arg_5_0.emit

		NewMainScene = var_1_10003

		var_5_1(var_5_0, var_1_10003.ENTER_SILENT_VIEW)
	end

	return
end

function var_0_1.AnyOverlayShowing(arg_6_0)
	getProxy = var_1_10001
	ContextProxy = var_1_10002

	local var_6_0 = var_1_10001(var_1_10002)
	local var_6_1 = var_1.getCurrentContext(var_6_0)

	pg = var_6_0

	local var_6_2 = var_6_0.LayerWeightMgr.GetInstance().uiOrigin

	pg = var_1_10003

	local var_6_3 = var_1_10003.NewStoryMgr.GetInstance()
	local var_6_5

	if not var_3.IsRunning(var_6_3) then
		pg = var_6_5

		local var_6_4 = var_6_5.NewGuideMgr.GetInstance()

		if not var_6_5.IsBusy(var_6_4) then
			isActive = var_6_5
			pg = var_6_4

			if not var_6_5(var_6_4.MsgboxMgr.GetInstance()._tf) and not var_6_1:hasChild() then
				var_6_5 = var_6_2.childCount > 0 or arg_6_0.isFoldState
			end
		end
	end

	return var_6_5
end

function var_0_1.Clear(arg_7_0)
	if arg_7_0.handle then
		UpdateBeat = var_1

		var_1:RemoveListener(arg_7_0.handle)

		arg_7_0.handle = nil
	end

	arg_7_0:disposeEvent()

	arg_7_0.isFoldState = false

	return
end

function var_0_1.Disable(arg_8_0)
	arg_8_0:Clear()

	return
end

function var_0_1.SetSilentRun(arg_9_0, arg_9_1)
	arg_9_0._silentRunFlag = arg_9_1

	return
end

function var_0_1.Dispose(arg_10_0)
	arg_10_0:Disable()

	return
end

return var_0_1
