local CaptureGameMainView = class("CaptureGameMainView", ReduxView)

function CaptureGameMainView:UIName()
	return "Widget/Version/SummerUI_3_4/SummerUI_3_4_CaptureUI/SummerUI_3_4_CaptureUI"
end

function CaptureGameMainView:UIParent()
	return manager.ui.uiMain.transform
end

function CaptureGameMainView:BuildContext()
	self.context = {
		viewMode = "fullView",
		delta = 0.1,
		onTaskChangeHandler = handler(self, self.OnTaskChangeEvent),
		onCloseSettingPanel = handler(self, self.OnCloseSettingPanel),
		onOpenSettingPanel = handler(self, self.OnOpenSettingPanel),
		onFovChanged = handler(self, self.OnFovChanged),
		taskModule = {},
		taskList = {},
		viewController = self.controller_:GetController("viewMode"),
		optModeController = self.controller_:GetController("mode")
	}

	for iter_3_0 = 1, 4 do
		table.insert(self.context.taskModule, CaptureMainTaskModule.New(self[string.format("taskObj%d_", iter_3_0)]))
	end
end

function CaptureGameMainView:Init()
	self:InitUI()
	self:BuildContext()
end

function CaptureGameMainView:InitUI()
	self:BindCfgUI()
	self:AddListener()
end

function CaptureGameMainView:AddListener()
	self:AddBtnListener(self.btnSetting_, nil, function()
		self:OnSettingClick()
	end)
	self:AddBtnListener(self.btnCapture_, nil, function()
		self:OnCaptureClick()
	end)
	self:AddBtnListener(self.btnHide_, nil, function()
		self:OnHideClick()
	end)
	self:AddBtnListener(self.hideMaskBtn_, nil, function()
		self:OnHideMaskClick()
	end)
	self.fovSlider_.onValueChanged:AddListener(function(arg_11_0)
		self:OnFovSliderChanged(arg_11_0)
	end)
	self:AddBtnListener(self.sliderAddBtn_, nil, function()
		self:OnFovSliderAddClick()
	end)
	self:AddBtnListener(self.sliderSubBtn_, nil, function()
		self:OnFovSliderSubClick()
	end)
end

function CaptureGameMainView:OnEnter()
	manager.notify:RegistListener(CAPTURE_GAME_TASK_UPDATE, self.context.onTaskChangeHandler)
	manager.notify:RegistListener(CAPTURE_GAME_CLOSE_SETTING_PANEL, self.context.onCloseSettingPanel)
	manager.notify:RegistListener(CAPTURE_GAME_OPEN_SETTING_PANEL, self.context.onOpenSettingPanel)
	manager.notify:RegistListener(CAPTURE_GAME_CAMERA_FOV_CHANGED, self.context.onFovChanged)
	self:ShowBar()
	self:SwitchToViewMode("fullView")
	self:Render()
	self:CheckGameHelper()
end

function CaptureGameMainView:OnTop()
	self:ShowBar()
end

function CaptureGameMainView:OnExit()
	self:StopBarTimer()
	manager.notify:RemoveListener(CAPTURE_GAME_TASK_UPDATE, self.context.onTaskChangeHandler)
	manager.notify:RemoveListener(CAPTURE_GAME_CLOSE_SETTING_PANEL, self.context.onCloseSettingPanel)
	manager.notify:RemoveListener(CAPTURE_GAME_OPEN_SETTING_PANEL, self.context.onOpenSettingPanel)
	manager.notify:RemoveListener(CAPTURE_GAME_CAMERA_FOV_CHANGED, self.context.onFovChanged)

	if self.frameTimer then
		self.frameTimer:Stop()

		self.frameTimer = nil
	end
end

function CaptureGameMainView:CheckGameHelper()
	if not getData("CaptureGame", "showHelp" .. (CaptureGameMgr:IsSingleMode() and 1 or 0)) then
		self:GotoHelp()
		saveData("CaptureGame", "showHelp" .. (CaptureGameMgr:IsSingleMode() and 1 or 0), true)
	end
end

function CaptureGameMainView:OnFovChanged()
	self:RenderFovSlider()
end

function CaptureGameMainView:OnFovSliderChanged(arg_19_1)
	CaptureGameMgr:GetCameraMgr():ChangeFovRatio(arg_19_1)
end

function CaptureGameMainView:OnFovSliderAddClick()
	local var_20_0 = self.fovSlider_.value + self.context.delta

	if self.fovSlider_.value + self.context.delta > 1 then
		var_20_0 = 1
	end

	if var_20_0 < 0 then
		var_20_0 = 0
	end

	self.fovSlider_.value = var_20_0
end

function CaptureGameMainView:OnFovSliderSubClick()
	local var_21_0 = self.fovSlider_.value - self.context.delta

	if self.fovSlider_.value - self.context.delta > 1 then
		var_21_0 = 1
	end

	if var_21_0 < 0 then
		var_21_0 = 0
	end

	self.fovSlider_.value = var_21_0
end

function CaptureGameMainView:OnSettingClick()
	CaptureGameMgr:OpenSettingPanel(true)
end

function CaptureGameMainView:OnCaptureClick()
	manager.windowBar:HideBar()
	SetActive(self.gameObject_, false)

	local var_23_0 = ScreenSnap.New(Screen.width, Screen.height)

	CaptureGameMgr:GetTaskMgr():MakeTaskShot()
	CaptureGameMgr:HideAllNoNeed(true)
	manager.ui:ShowScreenTap(false)
	CaptureGameMgr:GetCameraMgr():ShowUserPanel(true)
	WaitRenderFrameUtil.inst.StartScreenShot(function()
		var_23_0:Take()
		SetActive(self.gameObject_, true)
		JumpTools.OpenPageByJump("/captureResultView", {
			sprite = var_23_0:GetSprite()
		})
		CaptureGameMgr:HideAllNoNeed(false)
		manager.ui:ShowScreenTap(true)
		CaptureGameMgr:GetCameraMgr():ShowUserPanel(false)
	end)
end

function CaptureGameMainView:OnTaskChangeEvent()
	self:RenderTask()
end

function CaptureGameMainView:OnHideMaskClick()
	self:StartBarTimer()
	self:ShowBar()
end

function CaptureGameMainView:OnHideClick()
	self:SwitchToViewMode("emptyView")
end

function CaptureGameMainView:OnCloseSettingPanel()
	self:SwitchToViewMode("fullView")
end

function CaptureGameMainView:OnOpenSettingPanel()
	self:SwitchToViewMode("settingView")
end

function CaptureGameMainView:SwitchToViewMode(arg_30_1)
	self.context.viewController:SetSelectedState(arg_30_1)

	if arg_30_1 == "emptyView" then
		manager.windowBar:HideBar()
	end

	self.context.viewMode = arg_30_1
end

function CaptureGameMainView:ShowBar()
	if self.context.viewMode == "fullView" then
		self:StopBarTimer()
		manager.windowBar:SwitchBar({
			BACK_BAR,
			INFO_BAR
		})
		manager.windowBar:RegistBackCallBack(function()
			if self.context.viewMode == "emptyView" then
				self:SwitchToViewMode("fullView")
			else
				CaptureGameBridge.LeaveCaptureGame()
			end
		end)
		manager.windowBar:RegistInfoCallBack(function()
			self:GotoHelp()
		end)
	elseif self.context.viewMode == "emptyView" then
		manager.windowBar:SwitchBar({
			BACK_BAR
		})
		manager.windowBar:RegistBackCallBack(function()
			if self.context.viewMode == "emptyView" then
				self:SwitchToViewMode("fullView")
				self:StartBarTimer()
				self:ShowBar()
			else
				CaptureGameBridge.LeaveCaptureGame()
			end
		end)
	end
end

function CaptureGameMainView:StartBarTimer()
	self:StopBarTimer()

	self.barTimer_ = Timer.New(function()
		manager.windowBar:HideBar()
		self:StopBarTimer()
	end, 3, -1)

	self.barTimer_:Start()
end

function CaptureGameMainView:StopBarTimer()
	if self.barTimer_ then
		self.barTimer_:Stop()

		self.barTimer_ = nil
	end
end

function CaptureGameMainView:GotoHelp()
	local var_38_0 = {}

	var_38_0 = CaptureGameMgr:IsSingleMode() and (GameSetting.swim_skin_capture_describe1 and GameSetting.swim_skin_capture_describe1.value or {
		"Widget/Version/SummerUI_3_4/SummerUI_3_4_CaptureUI/CaptureDescription_01",
		"Widget/Version/SummerUI_3_4/SummerUI_3_4_CaptureUI/CaptureDescription_02",
		"Widget/Version/SummerUI_3_4/SummerUI_3_4_CaptureUI/CaptureDescription_03"
	}) or GameSetting.swim_skin_capture_describe2 and GameSetting.swim_skin_capture_describe2.value or {
		"Widget/Version/SummerUI_3_4/SummerUI_3_4_CaptureUI/CaptureDescription_04",
		"Widget/Version/SummerUI_3_4/SummerUI_3_4_CaptureUI/CaptureDescription_05",
		"Widget/Version/SummerUI_3_4/SummerUI_3_4_CaptureUI/CaptureDescription_06",
		"Widget/Version/SummerUI_3_4/SummerUI_3_4_CaptureUI/CaptureDescription_07"
	}

	JumpTools.OpenPageByJump("gameHelpPro", {
		isPrefab = true,
		pages = var_38_0
	})
end

function CaptureGameMainView:Render()
	self:RenderFovSlider()
	self:RenderTask()
end

function CaptureGameMainView:RenderFovSlider()
	self.fovSlider_:SetValueWithoutNotify((CaptureGameMgr:GetCameraMgr():GetVirtualFovRatio()))
end

function CaptureGameMainView:RenderTask()
	if not CaptureGameMgr:IsFreeCapture() then
		SetActive(self.taskRootObj_, true)

		self.context.taskList = CaptureGameMgr:GetTaskMgr():GetTaskList()

		local var_41_0 = 1

		for iter_41_0 = 1, 4 do
			if self.context.taskList[iter_41_0] then
				var_41_0 = iter_41_0

				self.context.taskModule[iter_41_0]:RenderItem(self.context.taskList[iter_41_0])
			else
				self.context.taskModule[iter_41_0]:RenderItem(nil)
			end
		end

		self.context.taskModule[var_41_0]:HideLine()
	else
		SetActive(self.taskRootObj_, false)
	end
end

function CaptureGameMainView:Dispose()
	self:StopBarTimer()

	for iter_42_0, iter_42_1 in ipairs(self.context.taskModule) do
		iter_42_1:Dispose()
	end

	self.fovSlider_.onValueChanged:RemoveAllListeners()
	CaptureGameMainView.super.Dispose(self)
end

return CaptureGameMainView
