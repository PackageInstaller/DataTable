local var_0_0 = class("CaptureCheckPointModule", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.BuildContext(arg_3_0)
	arg_3_0.staticContext = {
		slotId = -1
	}
	arg_3_0.runtimeCtx = {}
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
	arg_4_0:BuildContext()
	arg_4_0:AddListener()

	arg_4_0.controller = arg_4_0.scheduleController_:GetController("default0")
end

function var_0_0.AddListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.captureBtn_, nil, function()
		arg_5_0:OnSectionClick()
	end)
end

function var_0_0.OnSectionClick(arg_7_0)
	if not ActivityData:GetActivityIsOpen(arg_7_0.staticContext.sectionId) then
		ShowTips(GetTips("CAPTURE_GAME_TIME_UNREACHED"))

		return
	end

	if PlayerPrefs.GetInt("openAllCaptureGame") ~= 1 and not CaptureGameTools:CaptureGameCanOpen(arg_7_0.staticContext.sectionId) then
		ShowTips(GetTips("CAPTURE_GAME_PRE_SECTION_UNREACHED"))

		return
	end

	local var_7_0 = arg_7_0.staticContext.clickDispatch

	if var_7_0 then
		var_7_0(arg_7_0.staticContext.slotId)
	end
end

function var_0_0.RegisterClickEvent(arg_8_0, arg_8_1)
	arg_8_0.staticContext.clickDispatch = arg_8_1
end

function var_0_0.RenderView(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1.gameData

	arg_9_0.runtimeCtx.gameData = var_9_0
	arg_9_0.staticContext.slotId = arg_9_1.id
	arg_9_0.staticContext.sectionId = var_9_0.sectionId
	arg_9_0.regionTxt_.text = var_9_0.title

	arg_9_0:RenderLockStatus()

	arg_9_0.transform_.localPosition = Vector3.New(var_9_0.view_position[1], var_9_0.view_position[2], 0)

	local var_9_1 = arg_9_0:GetSectionCount()
	local var_9_2 = arg_9_0:GetSectionCompleteCount()

	arg_9_0.controller:SetSelectedState("state" .. var_9_2)

	for iter_9_0 = 1, 3 do
		SetActive(arg_9_0[string.format("schedule%d_", iter_9_0)], iter_9_0 <= var_9_1)
	end

	arg_9_0:UnbindRedPoint()
	arg_9_0:BindRedPoint()
end

function var_0_0.RenderLockStatus(arg_10_0)
	local var_10_0 = ActivityData:GetActivityIsOpen(arg_10_0.staticContext.sectionId)
	local var_10_1 = var_10_0

	if PlayerPrefs.GetInt("openAllCaptureGame") ~= 1 then
		var_10_1 = var_10_1 and CaptureGameTools:CaptureGameCanOpen(arg_10_0.staticContext.sectionId)
	end

	arg_10_0.lockObj_:SetActive(not var_10_1)

	if var_10_1 then
		local var_10_2 = arg_10_0:GetSectionCompleteCount() == arg_10_0:GetSectionCount()

		arg_10_0.compObj_:SetActive(var_10_2)
		arg_10_0.procObj_:SetActive(not var_10_2)
	else
		arg_10_0.compObj_:SetActive(false)
		arg_10_0.procObj_:SetActive(false)
	end

	if not var_10_0 then
		arg_10_0:AddTimer()
	elseif not var_10_1 then
		arg_10_0.lockTxt_.text = GetTips("CAPTURE_GAME_PRE_SECTION_UNREACHED_SMALL")
	end
end

function var_0_0.GetSectionCompleteCount(arg_11_0)
	local var_11_0 = 0
	local var_11_1 = arg_11_0.runtimeCtx.gameData
	local var_11_2 = var_11_1.sub_section_list or {}

	for iter_11_0 = 1, 3 do
		if var_11_2[iter_11_0] and CaptureGameData:CheckSectionTaskComplete(var_11_1.sectionId, var_11_2[iter_11_0]) then
			var_11_0 = var_11_0 + 1
		end
	end

	return var_11_0
end

function var_0_0.GetSectionCount(arg_12_0)
	return #(arg_12_0.runtimeCtx.gameData.sub_section_list or {})
end

function var_0_0.SetActive(arg_13_0, arg_13_1)
	arg_13_0.gameObject_:SetActive(arg_13_1)

	if not arg_13_1 then
		arg_13_0:UnbindRedPoint()
		arg_13_0:StopTimer()
	end
end

function var_0_0.ChangeParent(arg_14_0, arg_14_1)
	arg_14_0.transform_.parent = arg_14_1
end

function var_0_0.GetCameraPivot(arg_15_0)
	return arg_15_0.cameraPivot_
end

function var_0_0.GetSectionCfg(arg_16_0)
	return arg_16_0.runtimeCtx.gameData
end

function var_0_0.AddTimer(arg_17_0)
	arg_17_0:StopTimer()

	local var_17_0 = ActivityData:GetActivityData(arg_17_0.staticContext.sectionId)

	if manager.time:GetServerTime() < var_17_0.startTime then
		arg_17_0:RefreshTimeText(var_17_0.startTime)
	else
		arg_17_0:RefreshTimeText(var_17_0.stopTime)
	end

	arg_17_0.timer_ = Timer.New(function()
		local var_18_0 = ActivityData:GetActivityData(arg_17_0.staticContext.sectionId)
		local var_18_1 = manager.time:GetServerTime()

		if var_18_1 < var_18_0.startTime then
			arg_17_0:RefreshTimeText(var_18_0.startTime)
		else
			arg_17_0:RenderLockStatus()
			arg_17_0:StopTimer()
		end

		if var_18_1 >= var_18_0.stopTime then
			arg_17_0:RenderLockStatus()
			arg_17_0:StopTimer()
		end
	end, 1, -1)

	arg_17_0.timer_:Start()
end

function var_0_0.RefreshTimeText(arg_19_0, arg_19_1)
	arg_19_0.lockTxt_.text = manager.time:GetLostTimeStrWith2Unit(arg_19_1)
end

function var_0_0.StopTimer(arg_20_0)
	if arg_20_0.timer_ then
		arg_20_0.timer_:Stop()

		arg_20_0.timer_ = nil
	end
end

function var_0_0.BindRedPoint(arg_21_0)
	local var_21_0 = {
		RedPointConst.CAPTURE_GAME_UNLOCK_SECTION,
		"_",
		0,
		[3] = arg_21_0.staticContext.sectionId
	}

	manager.redPoint:bindUIandKey(arg_21_0.noticeContainer.transform, table.concat(var_21_0))
end

function var_0_0.UnbindRedPoint(arg_22_0)
	manager.redPoint:unbindUIandKey(arg_22_0.noticeContainer.transform)
end

function var_0_0.Exit(arg_23_0)
	arg_23_0:StopTimer()
	arg_23_0:UnbindRedPoint()
end

function var_0_0.Dispose(arg_24_0)
	arg_24_0:StopTimer()
	arg_24_0:UnbindRedPoint()
	var_0_0.super.Dispose(arg_24_0)
end

return var_0_0
