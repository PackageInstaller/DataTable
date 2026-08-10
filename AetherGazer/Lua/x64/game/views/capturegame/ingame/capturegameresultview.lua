local var_0_0 = class("CaptureGameResultView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/SummerUI_3_4/SummerUI_3_4_CaptureUI/SummerUI_3_4_CaptureResultUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
	arg_4_0:AddListener()

	arg_4_0.taskModule = {}
	arg_4_0.modeController = arg_4_0.modeController_:GetController("mode")
	arg_4_0.animtor = arg_4_0.gameObject_:GetComponent(typeof(Animator))

	for iter_4_0 = 1, 4 do
		table.insert(arg_4_0.taskModule, CaptureResultTaskModule.New(arg_4_0[string.format("taskObj%d_", iter_4_0)]))
	end

	arg_4_0.retryTimes = 0
	arg_4_0.isInRerty = false
end

function var_0_0.AddListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.restartBtn_, nil, function()
		arg_5_0:OnRestartClick()
		arg_5_0:DisposeSprite()
	end)
	arg_5_0:AddBtnListener(arg_5_0.completeBtn_, nil, function()
		arg_5_0:OnCompleteClick()
		arg_5_0:DisposeSprite()
	end)
	arg_5_0:AddBtnListener(arg_5_0.shareBtn_, nil, function()
		arg_5_0:OnShareBtnClick()
	end)
	arg_5_0:AddBtnListener(arg_5_0.saveBtn_, nil, function()
		if GameToSDK.IsEditorOrPcPlatform() then
			local var_9_0 = manager.share:SaveTexture(arg_5_0.params_.sprite.texture)

			LuaForUtil.SaveScreenShot(var_9_0)
		else
			local var_9_1 = manager.share:SaveTexture(arg_5_0.params_.sprite.texture)

			LuaForUtil.SavePhotoToAlbum(var_9_1)
		end

		CaptureGameTools:SendShareSdk(6, 2)
	end)

	if GameToSDK.IsEditorOrPcPlatform() then
		arg_5_0:AddBtnListener(arg_5_0.visitBtn_, nil, function()
			LuaForUtil.OpenScreenShotFolder()
		end)
	end
end

function var_0_0.OnRestartClick(arg_11_0)
	arg_11_0:Back()
	CaptureGameMgr:ResetStartTime()
end

function var_0_0.OnCompleteClick(arg_12_0)
	CaptureGameBridge.LeaveCaptureGame()
end

function var_0_0.OnShareBtnClick(arg_13_0)
	manager.share:ShareWithSprite(function()
		return
	end, function()
		return
	end, arg_13_0.params_.sprite)
end

function var_0_0.CaptureSettlement(arg_16_0)
	local var_16_0 = false

	if manager.net ~= nil and manager.net.tcpConnection_ ~= nil then
		local var_16_1 = manager.net.tcpConnection_:GetMachineState()

		if var_16_1 and var_16_1 == "connected" then
			var_16_0 = true

			arg_16_0:PushStatus()
		end
	end

	if not var_16_0 then
		arg_16_0.clickMask:SetActive(true)
		arg_16_0:CheckNetStatus()
	end
end

function var_0_0.Check(arg_17_0)
	local var_17_0 = false
	local var_17_1 = false

	if manager.net ~= nil and manager.net.tcpConnection_ ~= nil then
		local var_17_2 = manager.net.tcpConnection_:GetMachineState()

		if var_17_2 and var_17_2 == "connected" then
			var_17_1 = true
		end
	end

	if not var_17_1 then
		if arg_17_0.retryTimes > 10 then
			arg_17_0:StopCheck()
			arg_17_0.clickMask:SetActive(false)
			SetForceShowQuanquan(false)
			ConnectionHelper.ShowReturnToLoginTip()

			return
		end

		if not arg_17_0.isInRerty then
			manager.net:ForceReconnect()
			SetForceShowQuanquan(true)
		end

		arg_17_0.retryTimes = arg_17_0.retryTimes + 1
	else
		SetForceShowQuanquan(false)
		arg_17_0.clickMask:SetActive(false)
		arg_17_0:PushStatus()
		arg_17_0:StopCheck()
	end
end

function var_0_0.CheckNetStatus(arg_18_0)
	arg_18_0.retryTimes = 0
	arg_18_0.isInRerty = false

	arg_18_0:Check()

	arg_18_0.frameTimer_ = Timer.New(function()
		arg_18_0:Check()
	end, 2, -1)

	arg_18_0.frameTimer_:Start()
end

function var_0_0.StopCheck(arg_20_0)
	if arg_20_0.frameTimer_ then
		arg_20_0.frameTimer_:Stop()

		arg_20_0.frameTimer_ = nil
	end
end

function var_0_0.PushStatus(arg_21_0)
	local var_21_0 = CaptureGameMgr:IsFreeCapture()
	local var_21_1 = CaptureGameMgr:IsSingleMode()

	if var_21_0 then
		local var_21_2 = 0

		if var_21_1 then
			var_21_2 = CaptureGameConst.ModeMainActivity.SingleFree
		else
			var_21_2 = CaptureGameConst.ModeMainActivity.MultiFree
		end

		CaptureGameAction.RecordSectionTask(var_21_2, {
			stage_id = CaptureGameMgr:GetSectionId(),
			task_id = {}
		}, CaptureGameConst.ServerNeedGameMode.FreeMode)
	elseif var_21_1 then
		CaptureGameAction.RecordSectionTask(CaptureGameMgr:GetMainActivityId(), arg_21_0:BuildTaskServerRecord(), CaptureGameConst.ServerNeedGameMode.Single)
	else
		CaptureGameAction.RecordSectionTask(CaptureGameMgr:GetMainActivityId(), arg_21_0:BuildTaskServerRecord(), CaptureGameConst.ServerNeedGameMode.Multiple)
	end
end

function var_0_0.DisposeSprite(arg_22_0)
	if not isNil(arg_22_0.params_.sprite) then
		Object.Destroy(arg_22_0.params_.sprite)
	end
end

function var_0_0.BuildTaskServerRecord(arg_23_0)
	local var_23_0 = {
		stage_id = CaptureGameMgr:GetSectionId(),
		task_id = {}
	}
	local var_23_1 = CaptureGameMgr:GetTaskMgr():GetTaskShot() or {}

	for iter_23_0, iter_23_1 in ipairs(var_23_1) do
		if iter_23_1.reached then
			table.insert(var_23_0.task_id, iter_23_1.taskId)
		end
	end

	return var_23_0
end

function var_0_0.OnEnter(arg_24_0)
	arg_24_0.clickMask:SetActive(false)
	manager.windowBar:HideBar()

	local var_24_0 = false

	if CaptureGameMgr:IsFreeCapture() then
		arg_24_0.modeController:SetSelectedState("result2")
		arg_24_0.animtor:Play("SummerUI_3_4_effect_photograph_1")
	else
		arg_24_0.modeController:SetSelectedState("result1")

		local var_24_1 = CaptureGameMgr:GetTaskMgr():GetTaskShot()

		for iter_24_0 = 1, 4 do
			if var_24_1[iter_24_0] then
				if not var_24_1[iter_24_0].reached then
					var_24_0 = true
				end

				arg_24_0.taskModule[iter_24_0]:RenderItem(var_24_1[iter_24_0].taskId, var_24_1[iter_24_0].reached)
			else
				arg_24_0.taskModule[iter_24_0]:RenderItem(nil)
			end
		end

		arg_24_0.animtor:Play("SummerUI_3_4_effect_photograph")
	end

	arg_24_0:RenderCaptureShot()
	arg_24_0:SendResultSdk()
	arg_24_0:ShowWinOrLose(var_24_0)
	arg_24_0:CaptureSettlement()
end

function var_0_0.OnExit(arg_25_0)
	arg_25_0:StopCheck()
end

function var_0_0.ShowWinOrLose(arg_26_0, arg_26_1)
	arg_26_0.winObj_:SetActive(not arg_26_1)
	arg_26_0.loseObj_:SetActive(arg_26_1)
end

function var_0_0.SendResultSdk(arg_27_0)
	local var_27_0 = CaptureGameMgr:IsFreeCapture()
	local var_27_1 = arg_27_0:BuildTaskServerRecord()
	local var_27_2 = {
		"",
		"",
		","
	}
	local var_27_3 = ""
	local var_27_4 = 1
	local var_27_5 = #var_27_1.task_id

	for iter_27_0, iter_27_1 in ipairs(var_27_1.task_id) do
		var_27_2[1] = var_27_3
		var_27_2[2] = iter_27_1

		if var_27_4 == var_27_5 then
			var_27_2[3] = ""
		else
			var_27_2[3] = ","
		end

		var_27_4 = var_27_4 + 1
		var_27_3 = table.concat(var_27_2)
	end

	local var_27_6 = ""
	local var_27_7 = CaptureGameMgr:GetCurUsingHeroList()
	local var_27_8 = 1
	local var_27_9 = #var_27_7

	for iter_27_2, iter_27_3 in ipairs(var_27_7) do
		var_27_2[1] = var_27_6
		var_27_2[2] = iter_27_3

		if var_27_8 == var_27_9 then
			var_27_2[3] = ""
		else
			var_27_2[3] = ","
		end

		var_27_8 = var_27_8 + 1
		var_27_6 = table.concat(var_27_2)
	end

	CaptureGameTools:SendResultSdk(CaptureGameMgr:GetMainActivityId(), CaptureGameMgr:GetSectionId(), var_27_0 and 2 or 1, 1, var_27_6, var_27_3, CaptureGameMgr:GetTimeDistance())
end

function var_0_0.RenderCaptureShot(arg_28_0)
	local var_28_0 = arg_28_0.spriteTrans_
	local var_28_1 = arg_28_0.screenShotImg_

	if CaptureGameMgr:IsFreeCapture() then
		var_28_0 = arg_28_0.spriteTrans2_
		var_28_1 = arg_28_0.screenShotImg2_
	end

	local var_28_2 = {
		x = Screen.width,
		y = Screen.height
	}
	local var_28_3 = {
		x = 960,
		y = 500
	}
	local var_28_4 = var_28_3.x / var_28_2.x
	local var_28_5 = var_28_3.y / var_28_2.y
	local var_28_6 = {
		x = var_28_2.x * var_28_4,
		y = var_28_2.y * var_28_4
	}
	local var_28_7 = {
		x = var_28_2.x * var_28_5,
		y = var_28_2.y * var_28_5
	}

	if var_28_6.x <= var_28_3.x + 1 and var_28_6.y < var_28_3.y + 1 then
		var_28_0:SetSizeWithCurrentAnchors(RectTransform.Axis.Vertical, var_28_6.y)
		var_28_0:SetSizeWithCurrentAnchors(RectTransform.Axis.Horizontal, var_28_6.x)
	else
		var_28_0:SetSizeWithCurrentAnchors(RectTransform.Axis.Vertical, var_28_7.y)
		var_28_0:SetSizeWithCurrentAnchors(RectTransform.Axis.Horizontal, var_28_7.x)
	end

	var_28_1.sprite = arg_28_0.params_.sprite
end

function var_0_0.Dispose(arg_29_0)
	arg_29_0:StopCheck()

	for iter_29_0 = 1, 4 do
		arg_29_0.taskModule[iter_29_0]:Dispose()
	end

	var_0_0.super.Dispose(arg_29_0)
end

return var_0_0
