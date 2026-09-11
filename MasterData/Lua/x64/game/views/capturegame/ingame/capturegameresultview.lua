local CaptureGameResultView = class("CaptureGameResultView", ReduxView)

function CaptureGameResultView:UIName()
	return "Widget/Version/SummerUI_3_4/SummerUI_3_4_CaptureUI/SummerUI_3_4_CaptureResultUI"
end

function CaptureGameResultView:UIParent()
	return manager.ui.uiMain.transform
end

function CaptureGameResultView:Init()
	self:InitUI()
end

function CaptureGameResultView:InitUI()
	self:BindCfgUI()
	self:AddListener()

	self.taskModule = {}
	self.modeController = self.modeController_:GetController("mode")
	self.animtor = self.gameObject_:GetComponent(typeof(Animator))

	for iter_4_0 = 1, 4 do
		table.insert(self.taskModule, CaptureResultTaskModule.New(self[string.format("taskObj%d_", iter_4_0)]))
	end

	self.retryTimes = 0
	self.isInRerty = false
end

function CaptureGameResultView:AddListener()
	self:AddBtnListener(self.restartBtn_, nil, function()
		self:OnRestartClick()
		self:DisposeSprite()
	end)
	self:AddBtnListener(self.completeBtn_, nil, function()
		self:OnCompleteClick()
		self:DisposeSprite()
	end)
	self:AddBtnListener(self.shareBtn_, nil, function()
		self:OnShareBtnClick()
	end)
	self:AddBtnListener(self.saveBtn_, nil, function()
		if GameToSDK.IsEditorOrPcPlatform() then
			LuaForUtil.SaveScreenShot((manager.share:SaveTexture(self.params_.sprite.texture)))
		else
			LuaForUtil.SavePhotoToAlbum((manager.share:SaveTexture(self.params_.sprite.texture)))
		end

		CaptureGameTools:SendShareSdk(6, 2)
	end)

	if GameToSDK.IsEditorOrPcPlatform() then
		self:AddBtnListener(self.visitBtn_, nil, function()
			LuaForUtil.OpenScreenShotFolder()
		end)
	end
end

function CaptureGameResultView:OnRestartClick()
	self:Back()
	CaptureGameMgr:ResetStartTime()
end

function CaptureGameResultView:OnCompleteClick()
	CaptureGameBridge.LeaveCaptureGame()
end

function CaptureGameResultView:OnShareBtnClick()
	manager.share:ShareWithSprite(function()
		return
	end, function()
		return
	end, self.params_.sprite)
end

function CaptureGameResultView:CaptureSettlement()
	local var_16_0 = false

	if manager.net ~= nil and manager.net.tcpConnection_ ~= nil then
		local var_16_1 = manager.net.tcpConnection_:GetMachineState()

		if var_16_1 and var_16_1 == "connected" then
			var_16_0 = true

			self:PushStatus()
		end
	end

	if not var_16_0 then
		self.clickMask:SetActive(true)
		self:CheckNetStatus()
	end
end

function CaptureGameResultView:Check()
	local var_17_1 = false

	if manager.net ~= nil and manager.net.tcpConnection_ ~= nil then
		local var_17_2 = manager.net.tcpConnection_:GetMachineState()

		if var_17_2 and var_17_2 == "connected" then
			var_17_1 = true
		end
	end

	if not var_17_1 then
		if self.retryTimes > 10 then
			self:StopCheck()
			self.clickMask:SetActive(false)
			SetForceShowQuanquan(false)
			ConnectionHelper.ShowReturnToLoginTip()

			return
		end

		if not self.isInRerty then
			manager.net:ForceReconnect()
			SetForceShowQuanquan(true)
		end

		self.retryTimes = self.retryTimes + 1
	else
		SetForceShowQuanquan(false)
		self.clickMask:SetActive(false)
		self:PushStatus()
		self:StopCheck()
	end
end

function CaptureGameResultView:CheckNetStatus()
	self.retryTimes = 0
	self.isInRerty = false

	self:Check()

	self.frameTimer_ = Timer.New(function()
		self:Check()
	end, 2, -1)

	self.frameTimer_:Start()
end

function CaptureGameResultView:StopCheck()
	if self.frameTimer_ then
		self.frameTimer_:Stop()

		self.frameTimer_ = nil
	end
end

function CaptureGameResultView:PushStatus()
	local var_21_0 = CaptureGameMgr:IsSingleMode()

	if CaptureGameMgr:IsFreeCapture() then
		CaptureGameAction.RecordSectionTask(var_21_0 and CaptureGameConst.ModeMainActivity.SingleFree or CaptureGameConst.ModeMainActivity.MultiFree, {
			stage_id = CaptureGameMgr:GetSectionId(),
			task_id = {}
		}, CaptureGameConst.ServerNeedGameMode.FreeMode)
	elseif var_21_0 then
		CaptureGameAction.RecordSectionTask(CaptureGameMgr:GetMainActivityId(), self:BuildTaskServerRecord(), CaptureGameConst.ServerNeedGameMode.Single)
	else
		CaptureGameAction.RecordSectionTask(CaptureGameMgr:GetMainActivityId(), self:BuildTaskServerRecord(), CaptureGameConst.ServerNeedGameMode.Multiple)
	end
end

function CaptureGameResultView:DisposeSprite()
	if not isNil(self.params_.sprite) then
		Object.Destroy(self.params_.sprite)
	end
end

function CaptureGameResultView:BuildTaskServerRecord()
	local var_23_0 = {
		stage_id = CaptureGameMgr:GetSectionId(),
		task_id = {}
	}
	local var_23_1 = CaptureGameMgr:GetTaskMgr():GetTaskShot()

	var_23_1 = var_23_1 or {}

	for iter_23_0, iter_23_1 in ipairs(var_23_1) do
		if iter_23_1.reached then
			table.insert(var_23_0.task_id, iter_23_1.taskId)
		end
	end

	return var_23_0
end

function CaptureGameResultView:OnEnter()
	self.clickMask:SetActive(false)
	manager.windowBar:HideBar()

	local var_24_0 = false

	if CaptureGameMgr:IsFreeCapture() then
		self.modeController:SetSelectedState("result2")
		self.animtor:Play("SummerUI_3_4_effect_photograph_1")
	else
		self.modeController:SetSelectedState("result1")

		local var_24_1 = CaptureGameMgr:GetTaskMgr():GetTaskShot()

		for iter_24_0 = 1, 4 do
			if var_24_1[iter_24_0] then
				if not var_24_1[iter_24_0].reached then
					var_24_0 = true
				end

				self.taskModule[iter_24_0]:RenderItem(var_24_1[iter_24_0].taskId, var_24_1[iter_24_0].reached)
			else
				self.taskModule[iter_24_0]:RenderItem(nil)
			end
		end

		self.animtor:Play("SummerUI_3_4_effect_photograph")
	end

	self:RenderCaptureShot()
	self:SendResultSdk()
	self:ShowWinOrLose(var_24_0)
	self:CaptureSettlement()
end

function CaptureGameResultView:OnExit()
	self:StopCheck()
end

function CaptureGameResultView:ShowWinOrLose(arg_26_1)
	self.winObj_:SetActive(not arg_26_1)
	self.loseObj_:SetActive(arg_26_1)
end

function CaptureGameResultView:SendResultSdk()
	local var_27_0 = CaptureGameMgr:IsFreeCapture()
	local var_27_1 = self:BuildTaskServerRecord()
	local var_27_2 = {
		"",
		"",
		","
	}
	local var_27_3 = ""
	local var_27_4 = 1

	for iter_27_0, iter_27_1 in ipairs(var_27_1.task_id) do
		var_27_2[1] = var_27_3
		var_27_2[2] = iter_27_1
		var_27_2[3] = var_27_4 == #var_27_1.task_id and "" or ","
		var_27_4 = var_27_4 + 1
		var_27_3 = table.concat(var_27_2)
	end

	local var_27_5 = ""
	local var_27_6 = CaptureGameMgr:GetCurUsingHeroList()
	local var_27_7 = 1

	for iter_27_2, iter_27_3 in ipairs(var_27_6) do
		var_27_2[1] = var_27_5
		var_27_2[2] = iter_27_3
		var_27_2[3] = var_27_7 == #var_27_6 and "" or ","
		var_27_7 = var_27_7 + 1
		var_27_5 = table.concat(var_27_2)
	end

	CaptureGameTools:SendResultSdk(CaptureGameMgr:GetMainActivityId(), CaptureGameMgr:GetSectionId(), var_27_0 and 2 or 1, 1, var_27_5, var_27_3, CaptureGameMgr:GetTimeDistance())
end

function CaptureGameResultView:RenderCaptureShot()
	local var_28_0 = self.spriteTrans_
	local var_28_1 = self.screenShotImg_

	if CaptureGameMgr:IsFreeCapture() then
		var_28_0 = self.spriteTrans2_
		var_28_1 = self.screenShotImg2_
	end

	local var_28_2 = {
		x = Screen.width,
		y = Screen.height
	}
	local var_28_3 = {
		x = 960,
		y = 500
	}
	local var_28_4 = {
		x = var_28_2.x * (var_28_3.x / var_28_2.x),
		y = var_28_2.y * (var_28_3.x / var_28_2.x)
	}
	local var_28_5 = {
		x = var_28_2.x * (var_28_3.y / var_28_2.y),
		y = var_28_2.y * (var_28_3.y / var_28_2.y)
	}

	if var_28_4.x <= var_28_3.x + 1 and var_28_4.y < var_28_3.y + 1 then
		var_28_0:SetSizeWithCurrentAnchors(RectTransform.Axis.Vertical, var_28_4.y)
		var_28_0:SetSizeWithCurrentAnchors(RectTransform.Axis.Horizontal, var_28_4.x)
	else
		var_28_0:SetSizeWithCurrentAnchors(RectTransform.Axis.Vertical, var_28_5.y)
		var_28_0:SetSizeWithCurrentAnchors(RectTransform.Axis.Horizontal, var_28_5.x)
	end

	var_28_1.sprite = self.params_.sprite
end

function CaptureGameResultView:Dispose()
	self:StopCheck()

	for iter_29_0 = 1, 4 do
		self.taskModule[iter_29_0]:Dispose()
	end

	CaptureGameResultView.super.Dispose(self)
end

return CaptureGameResultView
