local var_0_0 = class("CaptureActivityMainView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/SummerUI_3_4/SummerUI_3_4_CaptureUI/Main/SummerUI_3_4_CaptureMainUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
end

function var_0_0.BuildContext(arg_4_0)
	arg_4_0.staticContext = {
		isInCamera = false,
		slot = {},
		checkPointCallback = handler(arg_4_0, arg_4_0.OnCheckPointClick),
		inCameraController = arg_4_0.controller_:GetController("IsInCamera"),
		stateController = arg_4_0.controller_:GetController("default3"),
		lockController = arg_4_0.controller_:GetController("default4"),
		freeUnlockController = arg_4_0.controller_:GetController("default5"),
		focusAnim = {
			focusScale = 1.3,
			originScale = 1,
			cameraFixedPos = {
				x = -500,
				y = -10
			}
		}
	}
	arg_4_0.page = {
		section = {
			entity = CaptureSectionModule.New(arg_4_0.rightSectionModule_)
		},
		sectionHero = {
			entity = CaptureGameSectionHeroModule.New(arg_4_0.heroTargetModule_)
		}
	}

	for iter_4_0 = 1, 7 do
		table.insert(arg_4_0.staticContext.slot, {
			id = iter_4_0
		})
	end
end

function var_0_0.InitRuntimeContext(arg_5_0)
	arg_5_0.runtimeContext = {
		gameMode = -1,
		gameList = {}
	}
end

function var_0_0.InitUI(arg_6_0)
	arg_6_0:BindCfgUI()
	arg_6_0:BuildContext()
	arg_6_0:AddListener()
end

function var_0_0.AddListener(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.singleModeBtn_, nil, function()
		arg_7_0:OnSingleModeBtnClick()
	end)
	arg_7_0:AddBtnListener(arg_7_0.multiModeBtn_, nil, function()
		arg_7_0:OnMultiModeBtnClick()
	end)
	arg_7_0:AddBtnListener(arg_7_0.taskBtn_, nil, function()
		arg_7_0:OnTaskBtnClick()
	end)
	arg_7_0:AddBtnListener(arg_7_0.maskBtn_, nil, function()
		arg_7_0:OnMaskBtnClick()
	end)
end

function var_0_0.OnMaskBtnClick(arg_12_0)
	arg_12_0:SwitchToCameraFocus(false, false)
	arg_12_0.page.section.entity:OnExit()
end

function var_0_0.OnSingleModeBtnClick(arg_13_0)
	if arg_13_0.runtimeContext.gameMode == CaptureGameConst.CaptureGameMode.Single then
		return
	end

	arg_13_0:SwitchGameMode(CaptureGameConst.CaptureGameMode.Single)
end

function var_0_0.OnMultiModeBtnClick(arg_14_0)
	if CaptureGameData:CheckCanEnterMulti() then
		if arg_14_0.runtimeContext.gameMode == CaptureGameConst.CaptureGameMode.Multiple then
			return
		end

		arg_14_0:SwitchGameMode(CaptureGameConst.CaptureGameMode.Multiple)
	end
end

function var_0_0.OnCheckPointClick(arg_15_0, arg_15_1)
	arg_15_0:SwitchToCameraFocus(true, false)
	arg_15_0:FocusOnAnim(arg_15_1)
	arg_15_0.page.section.entity:RenderView({
		gameData = arg_15_0.runtimeContext.gameList[arg_15_1]
	})
	arg_15_0.page.sectionHero.entity:RenderView(arg_15_0.runtimeContext.gameList[arg_15_1].sectionId)

	if arg_15_0.runtimeContext.gameList[arg_15_1].picture and arg_15_0.runtimeContext.gameList[arg_15_1].picture ~= "" then
		arg_15_0.sectionBg_.spriteSync = arg_15_0.runtimeContext.gameList[arg_15_1].picture
		arg_15_0.sectionBg2_.spriteSync = arg_15_0.runtimeContext.gameList[arg_15_1].picture
	end
end

function var_0_0.OnTaskBtnClick(arg_16_0)
	JumpTools.OpenPageByJump("captureGameTaskView")
end

function var_0_0.OnEnter(arg_17_0)
	arg_17_0:ChangeWindowBar(false)
	arg_17_0:InitRuntimeContext()

	arg_17_0.staticContext.isInCamera = false

	arg_17_0:CancelTween()
	arg_17_0:PostEnterView()
	arg_17_0:BindRedPoint()
	arg_17_0:AddCheckTimer()
end

function var_0_0.BindRedPoint(arg_18_0)
	manager.redPoint:bindUIandKey(arg_18_0.singleModeBtn_.transform, RedPointConst.CAPTURE_GAME_UNLOCK_SINGLE_ROOT)
	manager.redPoint:bindUIandKey(arg_18_0.multiModeBtn_.transform, RedPointConst.CAPTURE_GAME_UNLOCK_MULTI_ROOT)
	manager.redPoint:bindUIandKey(arg_18_0.taskBtn_.transform, RedPointConst.CAPTURE_GAME_TASK_REWARD)
end

function var_0_0.UnbindRedPoint(arg_19_0)
	manager.redPoint:unbindUIandKey(arg_19_0.singleModeBtn_.transform)
	manager.redPoint:unbindUIandKey(arg_19_0.multiModeBtn_.transform)
	manager.redPoint:unbindUIandKey(arg_19_0.taskBtn_.transform)
end

function var_0_0.PostEnterView(arg_20_0)
	local var_20_0 = CaptureGameData:GetSectionData()

	CaptureGameData:ClearSectionData()

	if var_20_0 then
		local var_20_1 = ActivitySwimSkinSectionCfg[var_20_0.mainStageId]

		arg_20_0:SwitchGameMode(var_20_1.mode, var_20_0.mainStageId)
	else
		arg_20_0:SwitchToCameraFocus(arg_20_0.staticContext.isInCamera, true)
		arg_20_0:SwitchGameMode(CaptureGameConst.CaptureGameMode.Single)
	end
end

function var_0_0.ChangeWindowBar(arg_21_0, arg_21_1)
	if not arg_21_1 then
		manager.windowBar:SwitchBar({
			BACK_BAR,
			INFO_BAR
		})
		manager.windowBar:SetGameHelpKey("ACTIVITY_CAPTURE_GAME_DESCRIPE")
	else
		manager.windowBar:SwitchBar({})
	end
end

function var_0_0.OnExit(arg_22_0)
	arg_22_0:CancelTween()
	arg_22_0:StopTimer()
	arg_22_0:UnbindRedPoint()
	arg_22_0:StopCheckTimer()

	for iter_22_0 = 1, 7 do
		if arg_22_0.staticContext.slot[iter_22_0].entity then
			arg_22_0.staticContext.slot[iter_22_0].entity:Exit()
		end
	end
end

function var_0_0.AddCheckTimer(arg_23_0)
	arg_23_0:StopCheckTimer()
	arg_23_0:CheckStop()

	arg_23_0.checkTimer_ = Timer.New(function()
		arg_23_0:CheckStop()
	end, 1, -1)

	arg_23_0.checkTimer_:Start()
end

function var_0_0.CheckStop(arg_25_0)
	local var_25_0 = manager.time:GetServerTime()
	local var_25_1 = ActivityData:GetActivityData(ActivityConst.ACTIVITY_SWIM_SKIN)

	if not var_25_1 or var_25_0 >= var_25_1.stopTime then
		arg_25_0:StopCheckTimer()
		ShowTips(GetTips("TIME_OVER"))
		arg_25_0:Back()
	end
end

function var_0_0.StopCheckTimer(arg_26_0)
	if arg_26_0.checkTimer_ then
		arg_26_0.checkTimer_:Stop()

		arg_26_0.checkTimer_ = nil
	end
end

function var_0_0.RenderView(arg_27_0, arg_27_1, arg_27_2)
	arg_27_0:RenderSlot(arg_27_1, arg_27_2)

	local var_27_0 = CaptureGameData:GetReachActivityCountByMode(arg_27_0.runtimeContext.gameMode)

	if var_27_0 == 7 then
		arg_27_0.staticContext.freeUnlockController:SetSelectedState("on")
	else
		arg_27_0.staticContext.freeUnlockController:SetSelectedState("off")
	end

	arg_27_0.lockTxt_.text = var_27_0 .. "/7"

	arg_27_0.staticContext.lockController:SetSelectedState(CaptureGameData:CheckCanEnterMulti() and "unlock" or "lock")
end

function var_0_0.RenderSlot(arg_28_0, arg_28_1, arg_28_2)
	if arg_28_1 then
		arg_28_0.runtimeContext.gameList = CaptureGameTools:GetActivityListByMode(arg_28_0.runtimeContext.gameMode)

		for iter_28_0 = 1, 7 do
			local var_28_0 = arg_28_0.staticContext.slot[iter_28_0].entity

			if var_28_0 then
				var_28_0:SetActive(false)
			end
		end
	end

	arg_28_0:StopTimer()

	local var_28_1 = 1

	arg_28_0.staticContext.showTimer = Timer.New(function()
		local var_29_0 = arg_28_0.runtimeContext.gameList[var_28_1]

		if var_29_0 then
			if PlayerPrefs.GetInt("openAllCaptureGame") ~= 1 and not CaptureGameTools:CaptureGameCanOpen(var_29_0.sectionId) then
				arg_28_0:RenderCheckPoint(var_28_1)
				arg_28_0:StopTimer()

				return
			end

			arg_28_0:RenderCheckPoint(var_28_1)

			if var_28_1 <= 7 and arg_28_2 and var_29_0.sectionId == arg_28_2 then
				arg_28_0:OnCheckPointClick(var_28_1)
			end
		end

		var_28_1 = var_28_1 + 1
	end, 0.01, 7):Start()
end

function var_0_0.StopTimer(arg_30_0)
	if arg_30_0.staticContext.showTimer then
		arg_30_0.staticContext.showTimer:Stop()

		arg_30_0.staticContext.showTimer = nil
	end
end

function var_0_0.RenderCheckPoint(arg_31_0, arg_31_1)
	if arg_31_1 > 7 then
		return
	end

	local var_31_0 = arg_31_0.staticContext.slot[arg_31_1]
	local var_31_1 = var_31_0.entity

	if not var_31_1 then
		var_31_1 = CaptureCheckPointModule.New(arg_31_0.checkPointModule_, arg_31_0.defocusSlot_)
		var_31_0.entity = var_31_1
	end

	var_31_1:SetActive(true)
	var_31_1:RenderView({
		id = var_31_0.id,
		gameData = arg_31_0.runtimeContext.gameList[arg_31_1]
	})
	var_31_1:RegisterClickEvent(arg_31_0.staticContext.checkPointCallback)
end

function var_0_0.SwitchToCameraFocus(arg_32_0, arg_32_1, arg_32_2)
	arg_32_0.staticContext.inCameraController:SetSelectedState(arg_32_1 and "yes" or "no")

	arg_32_0.staticContext.isInCamera = arg_32_1

	if not arg_32_1 then
		arg_32_0:ExitFocusAnim(arg_32_2)
	end
end

function var_0_0.SwitchGameMode(arg_33_0, arg_33_1, arg_33_2)
	arg_33_0.runtimeContext.gameMode = arg_33_1

	if arg_33_1 == CaptureGameConst.CaptureGameMode.Multiple then
		arg_33_0.staticContext.stateController:SetSelectedState("state1")
	else
		arg_33_0.staticContext.stateController:SetSelectedState("state0")
	end

	arg_33_0:RenderView(true, arg_33_2)
end

function var_0_0.FocusOnAnim(arg_34_0, arg_34_1, arg_34_2)
	local var_34_0 = arg_34_0.staticContext.slot[arg_34_1]
	local var_34_1 = arg_34_0.staticContext.focusAnim.focusScale
	local var_34_2 = {
		x = arg_34_0.staticContext.focusAnim.cameraFixedPos.x - var_34_0.entity.transform_.localPosition.x * var_34_1,
		y = arg_34_0.staticContext.focusAnim.cameraFixedPos.y - var_34_0.entity.transform_.localPosition.y * var_34_1
	}
	local var_34_3 = {
		x = arg_34_0.mapRoot_.localPosition.x,
		y = arg_34_0.mapRoot_.localPosition.y
	}
	local var_34_4 = {
		x = var_34_2.x - var_34_3.x,
		y = var_34_2.y - var_34_3.y
	}
	local var_34_5 = arg_34_0.mapRoot_.localScale.x
	local var_34_6 = 1.3 - var_34_5

	arg_34_0:CancelTween()

	if arg_34_2 then
		arg_34_0.mapRoot_.localPosition = Vector3.New(var_34_2.x, var_34_2.y, 0)
		arg_34_0.mapRoot_.localScale = Vector3.New(var_34_1, var_34_1, var_34_1)

		arg_34_0:Focus(arg_34_1)

		return
	end

	arg_34_0:Focus(arg_34_1)

	arg_34_0.staticContext.focusAnim.focusTweenId = LeanTween.value(0, 1, 0.3):setOnUpdate(LuaHelper.FloatAction(function(arg_35_0)
		if isNil(arg_34_0.gameObject_) then
			return
		end

		local var_35_0 = {
			x = var_34_3.x + arg_35_0 * var_34_4.x,
			y = var_34_3.y + arg_35_0 * var_34_4.y
		}
		local var_35_1 = var_34_5 + var_34_6 * arg_35_0

		arg_34_0.mapRoot_.localPosition = Vector3.New(var_35_0.x, var_35_0.y, 0)
		arg_34_0.mapRoot_.localScale = Vector3.New(var_35_1, var_35_1, var_35_1)
	end)):setOnComplete(LuaHelper.VoidAction(function()
		local var_36_0 = arg_34_0.staticContext.focusAnim.focusTweenId

		if var_36_0 then
			LeanTween.cancel(var_36_0)

			arg_34_0.staticContext.focusAnim.focusTweenId = nil
		end

		if not isNil(arg_34_0.gameObject_) then
			arg_34_0.mapRoot_.localPosition = Vector3.New(var_34_2.x, var_34_2.y, 0)
			arg_34_0.mapRoot_.localScale = Vector3.New(var_34_1, var_34_1, var_34_1)
		end
	end)):setEase(LeanTweenType.easeOutQuad).id
end

function var_0_0.ExitFocusAnim(arg_37_0, arg_37_1)
	local var_37_0 = {
		x = arg_37_0.mapRoot_.localPosition.x,
		y = arg_37_0.mapRoot_.localPosition.y
	}
	local var_37_1 = {
		x = -var_37_0.x,
		y = -var_37_0.y
	}
	local var_37_2 = arg_37_0.mapRoot_.localScale.x
	local var_37_3 = 1 - var_37_2

	arg_37_0:CancelTween()

	if arg_37_1 then
		arg_37_0.mapRoot_.localPosition = Vector3.zero
		arg_37_0.mapRoot_.localScale = Vector3.one

		arg_37_0:Defocus()

		return
	end

	arg_37_0:Defocus()

	arg_37_0.staticContext.focusAnim.exitTweenId = LeanTween.value(0, 1, 0.3):setOnUpdate(LuaHelper.FloatAction(function(arg_38_0)
		if isNil(arg_37_0.gameObject_) then
			return
		end

		local var_38_0 = {
			x = var_37_0.x + arg_38_0 * var_37_1.x,
			y = var_37_0.y + arg_38_0 * var_37_1.y
		}
		local var_38_1 = var_37_2 + var_37_3 * arg_38_0

		arg_37_0.mapRoot_.localPosition = Vector3.New(var_38_0.x, var_38_0.y, 0)
		arg_37_0.mapRoot_.localScale = Vector3.New(var_38_1, var_38_1, var_38_1)
	end)):setOnComplete(LuaHelper.VoidAction(function()
		local var_39_0 = arg_37_0.staticContext.focusAnim.exitTweenId

		if var_39_0 then
			LeanTween.cancel(var_39_0)

			arg_37_0.staticContext.focusAnim.exitTweenId = nil
		end

		if not isNil(arg_37_0.gameObject_) then
			arg_37_0.mapRoot_.localPosition = Vector3.zero
			arg_37_0.mapRoot_.localScale = Vector3.one
		end
	end)):setEase(LeanTweenType.easeOutQuad).id
end

function var_0_0.CancelTween(arg_40_0)
	if arg_40_0.staticContext.focusAnim.focusTweenId then
		LeanTween.cancel(arg_40_0.staticContext.focusAnim.focusTweenId)

		arg_40_0.staticContext.focusAnim.focusTweenId = nil
	end

	if arg_40_0.staticContext.focusAnim.exitTweenId then
		LeanTween.cancel(arg_40_0.staticContext.focusAnim.exitTweenId)

		arg_40_0.staticContext.focusAnim.exitTweenId = nil
	end
end

function var_0_0.Focus(arg_41_0, arg_41_1)
	arg_41_0.staticContext.curFocusIdx = arg_41_1

	local var_41_0 = arg_41_0.staticContext.slot[arg_41_1]

	var_41_0.entity:ChangeParent(arg_41_0.focusSlot_)

	arg_41_0.cameraSlotObj_.parent = var_41_0.entity:GetCameraPivot()
	arg_41_0.cameraSlotObj_.localScale = Vector3.one
	arg_41_0.cameraSlotObj_.localPosition = Vector3.zero
	arg_41_0.tipText_.text = var_41_0.entity:GetSectionCfg().description

	arg_41_0:ChangeWindowBar(true)
end

function var_0_0.Defocus(arg_42_0)
	local var_42_0 = arg_42_0.staticContext.curFocusIdx

	if var_42_0 then
		local var_42_1 = arg_42_0.staticContext.slot[var_42_0]

		arg_42_0.staticContext.curFocusIdx = nil

		var_42_1.entity:ChangeParent(arg_42_0.defocusSlot_)

		arg_42_0.cameraSlotObj_.parent = arg_42_0.inCameraPivot_
	end

	arg_42_0:ChangeWindowBar(false)
end

function var_0_0.Dispose(arg_43_0)
	arg_43_0:StopTimer()
	arg_43_0:StopCheckTimer()

	arg_43_0.staticContext = nil

	arg_43_0.page.section.entity:Dispose()
	arg_43_0.page.sectionHero.entity:Dispose()

	arg_43_0.page = nil

	var_0_0.super.Dispose(arg_43_0)
end

return var_0_0
