local CaptureActivityMainView = class("CaptureActivityMainView", ReduxView)

function CaptureActivityMainView:UIName()
	return "Widget/Version/SummerUI_3_4/SummerUI_3_4_CaptureUI/Main/SummerUI_3_4_CaptureModeUI"
end

function CaptureActivityMainView:UIParent()
	return manager.ui.uiMain.transform
end

function CaptureActivityMainView:Init()
	self:InitUI()
end

function CaptureActivityMainView:BuildContext()
	self.staticContext = {
		isInFreeCapture = false,
		freeTabController = self.controller_:GetController("default5"),
		freeBtnController = self.controller_:GetController("default2"),
		completeTabController = self.controller_:GetController("default0"),
		lockPictureController = self.controller_:GetController("default4")
	}
	self.runtimeContext = {
		id = -1,
		mainStageId = -1,
		taskList = {},
		gameMode = CaptureGameConst.CaptureGameMode.Single
	}
	self.scrollHelper = LuaList.New(handler(self, self.RenderItem), self.taskListObj_, CaptureSectionTaskModule)
end

function CaptureActivityMainView:InitUI()
	self:BindCfgUI()
	self:BuildContext()
	self:AddListener()
end

function CaptureActivityMainView:AddListener()
	self:AddBtnListener(self.captureBtn_, nil, function()
		self:OnCaptureClick()
	end)
	self:AddBtnListener(self.normalBtn_, nil, function()
		self:OnNormalBtnClick()
	end)
	self:AddBtnListener(self.freeBtn_, nil, function()
		self:OnFreeBtnClick()
	end)
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:Back()
	end)
end

function CaptureActivityMainView:OnCaptureClick()
	CaptureGameTools:EnterCaptureGame(self.runtimeContext.mainStageId, self.runtimeContext.id, self:IsOnFree())
end

function CaptureActivityMainView:RenderItem(arg_12_1, arg_12_2)
	arg_12_2:RenderView(self.runtimeContext.taskList[arg_12_1], self.runtimeContext.mainStageId, self.runtimeContext.id)
end

function CaptureActivityMainView:OnNormalBtnClick()
	if not self:IsOnFree() then
		return
	end

	self:SwitchToFreeStyle(false)
end

function CaptureActivityMainView:OnFreeBtnClick()
	if not CaptureGameData:CheckFreeCaptureOpen(self.runtimeContext.gameMode == CaptureGameConst.CaptureGameMode.Single) then
		return
	end

	if self:IsOnFree() then
		return
	end

	self:SwitchToFreeStyle(true)
end

function CaptureActivityMainView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		self:Back()
	end)
	self:RenderView()
end

function CaptureActivityMainView:OnExit()
	return
end

function CaptureActivityMainView:RenderView()
	local var_18_0 = CaptureGameData:GetSectionData()

	if var_18_0 then
		self.runtimeContext.id = var_18_0.subSectionId
		self.runtimeContext.mainStageId = var_18_0.mainStageId
		self.runtimeContext.gameMode = ActivitySwimSkinSectionCfg[var_18_0.mainStageId].mode

		if not var_18_0.isFree then
			self.runtimeContext.taskList = CaptureGameHelper:GetTaskBySectionId(var_18_0.subSectionId)

			self.scrollHelper:StartScroll(#self.runtimeContext.taskList)
		end

		self:SwitchToFreeStyle(var_18_0.isFree)
	else
		self.runtimeContext.id = self.params_.id
		self.runtimeContext.mainStageId = self.params_.mainStageId
		self.runtimeContext.gameMode = self.params_.mode
		self.runtimeContext.taskList = CaptureGameHelper:GetTaskBySectionId(self.params_.id)

		self.scrollHelper:StartScroll(#self.runtimeContext.taskList)
		self:SwitchToFreeStyle(false)
	end

	self.staticContext.completeTabController:SetSelectedState(CaptureGameData:CheckSectionTaskComplete(self.runtimeContext.mainStageId, self.runtimeContext.id) and "state1" or "state0")
	self.staticContext.lockPictureController:SetSelectedState(CaptureGameData:CheckFreeCaptureOpen(self.runtimeContext.gameMode == CaptureGameConst.CaptureGameMode.Single) and "state1" or "state0")
end

function CaptureActivityMainView:SwitchToFreeStyle(arg_19_1)
	if arg_19_1 then
		SetActive(self.taskListObj_, false)
		SetActive(self.noTaskObj_, true)
		self.staticContext.freeBtnController:SetSelectedState("state1")
		self.staticContext.freeTabController:SetSelectedState("state1")
	else
		SetActive(self.taskListObj_, true)
		SetActive(self.noTaskObj_, false)
		self.staticContext.freeBtnController:SetSelectedState("state0")
		self.staticContext.freeTabController:SetSelectedState("state0")
	end

	self.staticContext.isInFreeCapture = arg_19_1
end

function CaptureActivityMainView:IsOnFree()
	return self.staticContext.isInFreeCapture
end

function CaptureActivityMainView:CheckCanFree()
	return
end

function CaptureActivityMainView:Dispose()
	self.scrollHelper:Dispose()
	CaptureActivityMainView.super.Dispose(self)
end

return CaptureActivityMainView
