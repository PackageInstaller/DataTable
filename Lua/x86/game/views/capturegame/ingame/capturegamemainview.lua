local var_0_0 = class("CaptureGameMainView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/SummerUI_3_4/SummerUI_3_4_CaptureUI/SummerUI_3_4_CaptureUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.BuildContext(arg_3_0)
	arg_3_0.context = {
		viewMode = "fullView",
		delta = 0.1,
		onTaskChangeHandler = handler(arg_3_0, arg_3_0.OnTaskChangeEvent),
		onCloseSettingPanel = handler(arg_3_0, arg_3_0.OnCloseSettingPanel),
		onOpenSettingPanel = handler(arg_3_0, arg_3_0.OnOpenSettingPanel),
		onFovChanged = handler(arg_3_0, arg_3_0.OnFovChanged),
		taskModule = {},
		taskList = {},
		viewController = arg_3_0.controller_:GetController("viewMode"),
		optModeController = arg_3_0.controller_:GetController("mode")
	}

	for iter_3_0 = 1, 4 do
		table.insert(arg_3_0.context.taskModule, CaptureMainTaskModule.New(arg_3_0[string.format("taskObj%d_", iter_3_0)]))
	end
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:BuildContext()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()
	arg_5_0:AddListener()
end

function var_0_0.AddListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.btnSetting_, nil, function()
		arg_6_0:OnSettingClick()
	end)
	arg_6_0:AddBtnListener(arg_6_0.btnCapture_, nil, function()
		arg_6_0:OnCaptureClick()
	end)
	arg_6_0:AddBtnListener(arg_6_0.btnHide_, nil, function()
		arg_6_0:OnHideClick()
	end)
	arg_6_0:AddBtnListener(arg_6_0.hideMaskBtn_, nil, function()
		arg_6_0:OnHideMaskClick()
	end)
	arg_6_0.fovSlider_.onValueChanged:AddListener(function(arg_11_0)
		arg_6_0:OnFovSliderChanged(arg_11_0)
	end)
	arg_6_0:AddBtnListener(arg_6_0.sliderAddBtn_, nil, function()
		arg_6_0:OnFovSliderAddClick()
	end)
	arg_6_0:AddBtnListener(arg_6_0.sliderSubBtn_, nil, function()
		arg_6_0:OnFovSliderSubClick()
	end)
end

function var_0_0.OnEnter(arg_14_0)
	manager.notify:RegistListener(CAPTURE_GAME_TASK_UPDATE, arg_14_0.context.onTaskChangeHandler)
	manager.notify:RegistListener(CAPTURE_GAME_CLOSE_SETTING_PANEL, arg_14_0.context.onCloseSettingPanel)
	manager.notify:RegistListener(CAPTURE_GAME_OPEN_SETTING_PANEL, arg_14_0.context.onOpenSettingPanel)
	manager.notify:RegistListener(CAPTURE_GAME_CAMERA_FOV_CHANGED, arg_14_0.context.onFovChanged)
	arg_14_0:ShowBar()
	arg_14_0:SwitchToViewMode("fullView")
	arg_14_0:Render()
	arg_14_0:CheckGameHelper()
end

function var_0_0.OnTop(arg_15_0)
	arg_15_0:ShowBar()
end

function var_0_0.OnExit(arg_16_0)
	arg_16_0:StopBarTimer()
	manager.notify:RemoveListener(CAPTURE_GAME_TASK_UPDATE, arg_16_0.context.onTaskChangeHandler)
	manager.notify:RemoveListener(CAPTURE_GAME_CLOSE_SETTING_PANEL, arg_16_0.context.onCloseSettingPanel)
	manager.notify:RemoveListener(CAPTURE_GAME_OPEN_SETTING_PANEL, arg_16_0.context.onOpenSettingPanel)
	manager.notify:RemoveListener(CAPTURE_GAME_CAMERA_FOV_CHANGED, arg_16_0.context.onFovChanged)

	if arg_16_0.frameTimer then
		arg_16_0.frameTimer:Stop()

		arg_16_0.frameTimer = nil
	end
end

function var_0_0.CheckGameHelper(arg_17_0)
	if not getData("CaptureGame", "showHelp" .. (CaptureGameMgr:IsSingleMode() and 1 or 0)) then
		arg_17_0:GotoHelp()
		saveData("CaptureGame", "showHelp" .. (CaptureGameMgr:IsSingleMode() and 1 or 0), true)
	end
end

function var_0_0.OnFovChanged(arg_18_0)
	arg_18_0:RenderFovSlider()
end

function var_0_0.OnFovSliderChanged(arg_19_0, arg_19_1)
	CaptureGameMgr:GetCameraMgr():ChangeFovRatio(arg_19_1)
end

function var_0_0.OnFovSliderAddClick(arg_20_0)
	local var_20_0 = arg_20_0.fovSlider_.value + arg_20_0.context.delta

	if var_20_0 > 1 then
		var_20_0 = 1
	end

	if var_20_0 < 0 then
		var_20_0 = 0
	end

	arg_20_0.fovSlider_.value = var_20_0
end

function var_0_0.OnFovSliderSubClick(arg_21_0)
	local var_21_0 = arg_21_0.fovSlider_.value - arg_21_0.context.delta

	if var_21_0 > 1 then
		var_21_0 = 1
	end

	if var_21_0 < 0 then
		var_21_0 = 0
	end

	arg_21_0.fovSlider_.value = var_21_0
end

function var_0_0.OnSettingClick(arg_22_0)
	CaptureGameMgr:OpenSettingPanel(true)
end

function var_0_0.OnCaptureClick(arg_23_0)
	manager.windowBar:HideBar()
	SetActive(arg_23_0.gameObject_, false)

	local var_23_0 = Screen.width
	local var_23_1 = Screen.height
	local var_23_2 = ScreenSnap.New(var_23_0, var_23_1)

	CaptureGameMgr:GetTaskMgr():MakeTaskShot()
	CaptureGameMgr:HideAllNoNeed(true)
	manager.ui:ShowScreenTap(false)
	CaptureGameMgr:GetCameraMgr():ShowUserPanel(true)
	WaitRenderFrameUtil.inst.StartScreenShot(function()
		var_23_2:Take()
		SetActive(arg_23_0.gameObject_, true)
		JumpTools.OpenPageByJump("/captureResultView", {
			sprite = var_23_2:GetSprite()
		})
		CaptureGameMgr:HideAllNoNeed(false)
		manager.ui:ShowScreenTap(true)
		CaptureGameMgr:GetCameraMgr():ShowUserPanel(false)
	end)
end

function var_0_0.OnTaskChangeEvent(arg_25_0)
	arg_25_0:RenderTask()
end

function var_0_0.OnHideMaskClick(arg_26_0)
	arg_26_0:StartBarTimer()
	arg_26_0:ShowBar()
end

function var_0_0.OnHideClick(arg_27_0)
	arg_27_0:SwitchToViewMode("emptyView")
end

function var_0_0.OnCloseSettingPanel(arg_28_0)
	arg_28_0:SwitchToViewMode("fullView")
end

function var_0_0.OnOpenSettingPanel(arg_29_0)
	arg_29_0:SwitchToViewMode("settingView")
end

function var_0_0.SwitchToViewMode(arg_30_0, arg_30_1)
	arg_30_0.context.viewController:SetSelectedState(arg_30_1)

	if arg_30_1 == "emptyView" then
		manager.windowBar:HideBar()
	end

	arg_30_0.context.viewMode = arg_30_1
end

function var_0_0.ShowBar(arg_31_0)
	if arg_31_0.context.viewMode == "fullView" then
		arg_31_0:StopBarTimer()
		manager.windowBar:SwitchBar({
			BACK_BAR,
			INFO_BAR
		})
		manager.windowBar:RegistBackCallBack(function()
			if arg_31_0.context.viewMode == "emptyView" then
				arg_31_0:SwitchToViewMode("fullView")
			else
				CaptureGameBridge.LeaveCaptureGame()
			end
		end)
		manager.windowBar:RegistInfoCallBack(function()
			arg_31_0:GotoHelp()
		end)
	elseif arg_31_0.context.viewMode == "emptyView" then
		manager.windowBar:SwitchBar({
			BACK_BAR
		})
		manager.windowBar:RegistBackCallBack(function()
			if arg_31_0.context.viewMode == "emptyView" then
				arg_31_0:SwitchToViewMode("fullView")
				arg_31_0:StartBarTimer()
				arg_31_0:ShowBar()
			else
				CaptureGameBridge.LeaveCaptureGame()
			end
		end)
	end
end

function var_0_0.StartBarTimer(arg_35_0)
	arg_35_0:StopBarTimer()

	arg_35_0.barTimer_ = Timer.New(function()
		manager.windowBar:HideBar()
		arg_35_0:StopBarTimer()
	end, 3, -1)

	arg_35_0.barTimer_:Start()
end

function var_0_0.StopBarTimer(arg_37_0)
	if arg_37_0.barTimer_ then
		arg_37_0.barTimer_:Stop()

		arg_37_0.barTimer_ = nil
	end
end

function var_0_0.GotoHelp(arg_38_0)
	local var_38_0 = {}

	if CaptureGameMgr:IsSingleMode() then
		var_38_0 = GameSetting.swim_skin_capture_describe1 and GameSetting.swim_skin_capture_describe1.value or {
			"Widget/Version/SummerUI_3_4/SummerUI_3_4_CaptureUI/CaptureDescription_01",
			"Widget/Version/SummerUI_3_4/SummerUI_3_4_CaptureUI/CaptureDescription_02",
			"Widget/Version/SummerUI_3_4/SummerUI_3_4_CaptureUI/CaptureDescription_03"
		}
	else
		var_38_0 = GameSetting.swim_skin_capture_describe2 and GameSetting.swim_skin_capture_describe2.value or {
			"Widget/Version/SummerUI_3_4/SummerUI_3_4_CaptureUI/CaptureDescription_04",
			"Widget/Version/SummerUI_3_4/SummerUI_3_4_CaptureUI/CaptureDescription_05",
			"Widget/Version/SummerUI_3_4/SummerUI_3_4_CaptureUI/CaptureDescription_06",
			"Widget/Version/SummerUI_3_4/SummerUI_3_4_CaptureUI/CaptureDescription_07"
		}
	end

	JumpTools.OpenPageByJump("gameHelpPro", {
		isPrefab = true,
		pages = var_38_0
	})
end

function var_0_0.Render(arg_39_0)
	arg_39_0:RenderFovSlider()
	arg_39_0:RenderTask()
end

function var_0_0.RenderFovSlider(arg_40_0)
	local var_40_0 = CaptureGameMgr:GetCameraMgr():GetVirtualFovRatio()

	arg_40_0.fovSlider_:SetValueWithoutNotify(var_40_0)
end

function var_0_0.RenderTask(arg_41_0)
	if not CaptureGameMgr:IsFreeCapture() then
		SetActive(arg_41_0.taskRootObj_, true)

		arg_41_0.context.taskList = CaptureGameMgr:GetTaskMgr():GetTaskList()

		local var_41_0 = 1

		for iter_41_0 = 1, 4 do
			local var_41_1 = arg_41_0.context.taskList[iter_41_0]

			if var_41_1 then
				var_41_0 = iter_41_0

				arg_41_0.context.taskModule[iter_41_0]:RenderItem(var_41_1)
			else
				arg_41_0.context.taskModule[iter_41_0]:RenderItem(nil)
			end
		end

		arg_41_0.context.taskModule[var_41_0]:HideLine()
	else
		SetActive(arg_41_0.taskRootObj_, false)
	end
end

function var_0_0.Dispose(arg_42_0)
	arg_42_0:StopBarTimer()

	for iter_42_0, iter_42_1 in ipairs(arg_42_0.context.taskModule) do
		iter_42_1:Dispose()
	end

	arg_42_0.fovSlider_.onValueChanged:RemoveAllListeners()
	var_0_0.super.Dispose(arg_42_0)
end

return var_0_0
