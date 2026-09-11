local CaptureActivityMainView = class("CaptureActivityMainView", ReduxView)

function CaptureActivityMainView:UIName()
	return "Widget/Version/SummerUI_3_4/SummerUI_3_4_CaptureUI/Main/SummerUI_3_4_CaptureMainUI"
end

function CaptureActivityMainView:UIParent()
	return manager.ui.uiMain.transform
end

function CaptureActivityMainView:Init()
	self:InitUI()
end

function CaptureActivityMainView:BuildContext()
	self.staticContext = {
		isInCamera = false,
		slot = {},
		checkPointCallback = handler(self, self.OnCheckPointClick),
		inCameraController = self.controller_:GetController("IsInCamera"),
		stateController = self.controller_:GetController("default3"),
		lockController = self.controller_:GetController("default4"),
		freeUnlockController = self.controller_:GetController("default5"),
		focusAnim = {
			focusScale = 1.3,
			originScale = 1,
			cameraFixedPos = {
				x = -500,
				y = -10
			}
		}
	}
	self.page = {
		section = {
			entity = CaptureSectionModule.New(self.rightSectionModule_)
		},
		sectionHero = {
			entity = CaptureGameSectionHeroModule.New(self.heroTargetModule_)
		}
	}

	for iter_4_0 = 1, 7 do
		table.insert(self.staticContext.slot, {
			id = iter_4_0
		})
	end
end

function CaptureActivityMainView:InitRuntimeContext()
	self.runtimeContext = {
		gameMode = -1,
		gameList = {}
	}
end

function CaptureActivityMainView:InitUI()
	self:BindCfgUI()
	self:BuildContext()
	self:AddListener()
end

function CaptureActivityMainView:AddListener()
	self:AddBtnListener(self.singleModeBtn_, nil, function()
		self:OnSingleModeBtnClick()
	end)
	self:AddBtnListener(self.multiModeBtn_, nil, function()
		self:OnMultiModeBtnClick()
	end)
	self:AddBtnListener(self.taskBtn_, nil, function()
		self:OnTaskBtnClick()
	end)
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:OnMaskBtnClick()
	end)
end

function CaptureActivityMainView:OnMaskBtnClick()
	self:SwitchToCameraFocus(false, false)
	self.page.section.entity:OnExit()
end

function CaptureActivityMainView:OnSingleModeBtnClick()
	if self.runtimeContext.gameMode == CaptureGameConst.CaptureGameMode.Single then
		return
	end

	self:SwitchGameMode(CaptureGameConst.CaptureGameMode.Single)
end

function CaptureActivityMainView:OnMultiModeBtnClick()
	if CaptureGameData:CheckCanEnterMulti() then
		if self.runtimeContext.gameMode == CaptureGameConst.CaptureGameMode.Multiple then
			return
		end

		self:SwitchGameMode(CaptureGameConst.CaptureGameMode.Multiple)
	end
end

function CaptureActivityMainView:OnCheckPointClick(arg_15_1)
	self:SwitchToCameraFocus(true, false)
	self:FocusOnAnim(arg_15_1)
	self.page.section.entity:RenderView({
		gameData = self.runtimeContext.gameList[arg_15_1]
	})
	self.page.sectionHero.entity:RenderView(self.runtimeContext.gameList[arg_15_1].sectionId)

	if self.runtimeContext.gameList[arg_15_1].picture and self.runtimeContext.gameList[arg_15_1].picture ~= "" then
		self.sectionBg_.spriteSync = self.runtimeContext.gameList[arg_15_1].picture
		self.sectionBg2_.spriteSync = self.runtimeContext.gameList[arg_15_1].picture
	end
end

function CaptureActivityMainView:OnTaskBtnClick()
	JumpTools.OpenPageByJump("captureGameTaskView")
end

function CaptureActivityMainView:OnEnter()
	self:ChangeWindowBar(false)
	self:InitRuntimeContext()

	self.staticContext.isInCamera = false

	self:CancelTween()
	self:PostEnterView()
	self:BindRedPoint()
	self:AddCheckTimer()
end

function CaptureActivityMainView:BindRedPoint()
	manager.redPoint:bindUIandKey(self.singleModeBtn_.transform, RedPointConst.CAPTURE_GAME_UNLOCK_SINGLE_ROOT)
	manager.redPoint:bindUIandKey(self.multiModeBtn_.transform, RedPointConst.CAPTURE_GAME_UNLOCK_MULTI_ROOT)
	manager.redPoint:bindUIandKey(self.taskBtn_.transform, RedPointConst.CAPTURE_GAME_TASK_REWARD)
end

function CaptureActivityMainView:UnbindRedPoint()
	manager.redPoint:unbindUIandKey(self.singleModeBtn_.transform)
	manager.redPoint:unbindUIandKey(self.multiModeBtn_.transform)
	manager.redPoint:unbindUIandKey(self.taskBtn_.transform)
end

function CaptureActivityMainView:PostEnterView()
	local var_20_0 = CaptureGameData:GetSectionData()

	CaptureGameData:ClearSectionData()

	if var_20_0 then
		self:SwitchGameMode(ActivitySwimSkinSectionCfg[var_20_0.mainStageId].mode, var_20_0.mainStageId)
	else
		self:SwitchToCameraFocus(self.staticContext.isInCamera, true)
		self:SwitchGameMode(CaptureGameConst.CaptureGameMode.Single)
	end
end

function CaptureActivityMainView:ChangeWindowBar(arg_21_1)
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

function CaptureActivityMainView:OnExit()
	self:CancelTween()
	self:StopTimer()
	self:UnbindRedPoint()
	self:StopCheckTimer()

	for iter_22_0 = 1, 7 do
		if self.staticContext.slot[iter_22_0].entity then
			self.staticContext.slot[iter_22_0].entity:Exit()
		end
	end
end

function CaptureActivityMainView:AddCheckTimer()
	self:StopCheckTimer()
	self:CheckStop()

	self.checkTimer_ = Timer.New(function()
		self:CheckStop()
	end, 1, -1)

	self.checkTimer_:Start()
end

function CaptureActivityMainView:CheckStop()
	local var_25_0 = ActivityData:GetActivityData(ActivityConst.ACTIVITY_SWIM_SKIN)

	if not var_25_0 or manager.time:GetServerTime() >= var_25_0.stopTime then
		self:StopCheckTimer()
		ShowTips(GetTips("TIME_OVER"))
		self:Back()
	end
end

function CaptureActivityMainView:StopCheckTimer()
	if self.checkTimer_ then
		self.checkTimer_:Stop()

		self.checkTimer_ = nil
	end
end

function CaptureActivityMainView:RenderView(arg_27_1, arg_27_2)
	self:RenderSlot(arg_27_1, arg_27_2)

	local var_27_0 = CaptureGameData:GetReachActivityCountByMode(self.runtimeContext.gameMode)

	if var_27_0 == 7 then
		self.staticContext.freeUnlockController:SetSelectedState("on")
	else
		self.staticContext.freeUnlockController:SetSelectedState("off")
	end

	self.lockTxt_.text = var_27_0 .. "/7"

	self.staticContext.lockController:SetSelectedState(CaptureGameData:CheckCanEnterMulti() and "unlock" or "lock")
end

function CaptureActivityMainView:RenderSlot(arg_28_1, arg_28_2)
	if arg_28_1 then
		self.runtimeContext.gameList = CaptureGameTools:GetActivityListByMode(self.runtimeContext.gameMode)

		for iter_28_0 = 1, 7 do
			if self.staticContext.slot[iter_28_0].entity then
				self.staticContext.slot[iter_28_0].entity:SetActive(false)
			end
		end
	end

	self:StopTimer()

	local var_28_0 = 1

	self.staticContext.showTimer = Timer.New(function()
		if self.runtimeContext.gameList[var_28_0] then
			if PlayerPrefs.GetInt("openAllCaptureGame") ~= 1 and not CaptureGameTools:CaptureGameCanOpen(self.runtimeContext.gameList[var_28_0].sectionId) then
				self:RenderCheckPoint(var_28_0)
				self:StopTimer()

				return
			end

			self:RenderCheckPoint(var_28_0)

			if var_28_0 <= 7 and arg_28_2 and self.runtimeContext.gameList[var_28_0].sectionId == arg_28_2 then
				self:OnCheckPointClick(var_28_0)
			end
		end

		var_28_0 = var_28_0 + 1
	end, 0.01, 7):Start()
end

function CaptureActivityMainView:StopTimer()
	if self.staticContext.showTimer then
		self.staticContext.showTimer:Stop()

		self.staticContext.showTimer = nil
	end
end

function CaptureActivityMainView:RenderCheckPoint(arg_31_1)
	if arg_31_1 > 7 then
		return
	end

	local var_31_0 = self.staticContext.slot[arg_31_1]
	local var_31_1 = self.staticContext.slot[arg_31_1].entity

	if not self.staticContext.slot[arg_31_1].entity then
		var_31_1 = CaptureCheckPointModule.New(self.checkPointModule_, self.defocusSlot_)
		var_31_0.entity = var_31_1
	end

	var_31_1:SetActive(true)
	var_31_1:RenderView({
		id = var_31_0.id,
		gameData = self.runtimeContext.gameList[arg_31_1]
	})
	var_31_1:RegisterClickEvent(self.staticContext.checkPointCallback)
end

function CaptureActivityMainView:SwitchToCameraFocus(arg_32_1, arg_32_2)
	self.staticContext.inCameraController:SetSelectedState(arg_32_1 and "yes" or "no")

	self.staticContext.isInCamera = arg_32_1

	if not arg_32_1 then
		self:ExitFocusAnim(arg_32_2)
	end
end

function CaptureActivityMainView:SwitchGameMode(arg_33_1, arg_33_2)
	self.runtimeContext.gameMode = arg_33_1

	if arg_33_1 == CaptureGameConst.CaptureGameMode.Multiple then
		self.staticContext.stateController:SetSelectedState("state1")
	else
		self.staticContext.stateController:SetSelectedState("state0")
	end

	self:RenderView(true, arg_33_2)
end

function CaptureActivityMainView:FocusOnAnim(arg_34_1, arg_34_2)
	local var_34_0 = self.staticContext.focusAnim.focusScale
	local var_34_1 = {
		x = self.staticContext.focusAnim.cameraFixedPos.x - self.staticContext.slot[arg_34_1].entity.transform_.localPosition.x * self.staticContext.focusAnim.focusScale,
		y = self.staticContext.focusAnim.cameraFixedPos.y - self.staticContext.slot[arg_34_1].entity.transform_.localPosition.y * self.staticContext.focusAnim.focusScale
	}
	local var_34_2 = {
		x = self.mapRoot_.localPosition.x,
		y = self.mapRoot_.localPosition.y
	}
	local var_34_3 = {
		x = var_34_1.x - var_34_2.x,
		y = var_34_1.y - var_34_2.y
	}
	local var_34_4 = self.mapRoot_.localScale.x
	local var_34_5 = 1.3 - self.mapRoot_.localScale.x

	self:CancelTween()

	if arg_34_2 then
		self.mapRoot_.localPosition = Vector3.New(var_34_1.x, var_34_1.y, 0)
		self.mapRoot_.localScale = Vector3.New(self.staticContext.focusAnim.focusScale, self.staticContext.focusAnim.focusScale, self.staticContext.focusAnim.focusScale)

		self:Focus(arg_34_1)

		return
	end

	self:Focus(arg_34_1)

	self.staticContext.focusAnim.focusTweenId = LeanTween.value(0, 1, 0.3):setOnUpdate(LuaHelper.FloatAction(function(arg_35_0)
		if isNil(self.gameObject_) then
			return
		end

		local var_35_0 = {
			x = var_34_2.x + arg_35_0 * var_34_3.x,
			y = var_34_2.y + arg_35_0 * var_34_3.y
		}

		self.mapRoot_.localPosition = Vector3.New(var_35_0.x, var_35_0.y, 0)
		self.mapRoot_.localScale = Vector3.New(var_34_4 + var_34_5 * arg_35_0, var_34_4 + var_34_5 * arg_35_0, var_34_4 + var_34_5 * arg_35_0)
	end)):setOnComplete(LuaHelper.VoidAction(function()
		if self.staticContext.focusAnim.focusTweenId then
			LeanTween.cancel(self.staticContext.focusAnim.focusTweenId)

			self.staticContext.focusAnim.focusTweenId = nil
		end

		if not isNil(self.gameObject_) then
			self.mapRoot_.localPosition = Vector3.New(var_34_1.x, var_34_1.y, 0)
			self.mapRoot_.localScale = Vector3.New(var_34_0, var_34_0, var_34_0)
		end
	end)):setEase(LeanTweenType.easeOutQuad).id
end

function CaptureActivityMainView:ExitFocusAnim(arg_37_1)
	local var_37_0 = {
		x = self.mapRoot_.localPosition.x,
		y = self.mapRoot_.localPosition.y
	}
	local var_37_1 = {
		x = -var_37_0.x,
		y = -var_37_0.y
	}
	local var_37_2 = self.mapRoot_.localScale.x
	local var_37_3 = 1 - self.mapRoot_.localScale.x

	self:CancelTween()

	if arg_37_1 then
		self.mapRoot_.localPosition = Vector3.zero
		self.mapRoot_.localScale = Vector3.one

		self:Defocus()

		return
	end

	self:Defocus()

	self.staticContext.focusAnim.exitTweenId = LeanTween.value(0, 1, 0.3):setOnUpdate(LuaHelper.FloatAction(function(arg_38_0)
		if isNil(self.gameObject_) then
			return
		end

		local var_38_0 = {
			x = var_37_0.x + arg_38_0 * var_37_1.x,
			y = var_37_0.y + arg_38_0 * var_37_1.y
		}

		self.mapRoot_.localPosition = Vector3.New(var_38_0.x, var_38_0.y, 0)
		self.mapRoot_.localScale = Vector3.New(var_37_2 + var_37_3 * arg_38_0, var_37_2 + var_37_3 * arg_38_0, var_37_2 + var_37_3 * arg_38_0)
	end)):setOnComplete(LuaHelper.VoidAction(function()
		if self.staticContext.focusAnim.exitTweenId then
			LeanTween.cancel(self.staticContext.focusAnim.exitTweenId)

			self.staticContext.focusAnim.exitTweenId = nil
		end

		if not isNil(self.gameObject_) then
			self.mapRoot_.localPosition = Vector3.zero
			self.mapRoot_.localScale = Vector3.one
		end
	end)):setEase(LeanTweenType.easeOutQuad).id
end

function CaptureActivityMainView:CancelTween()
	if self.staticContext.focusAnim.focusTweenId then
		LeanTween.cancel(self.staticContext.focusAnim.focusTweenId)

		self.staticContext.focusAnim.focusTweenId = nil
	end

	if self.staticContext.focusAnim.exitTweenId then
		LeanTween.cancel(self.staticContext.focusAnim.exitTweenId)

		self.staticContext.focusAnim.exitTweenId = nil
	end
end

function CaptureActivityMainView:Focus(arg_41_1)
	self.staticContext.curFocusIdx = arg_41_1

	self.staticContext.slot[arg_41_1].entity:ChangeParent(self.focusSlot_)

	self.cameraSlotObj_.parent = self.staticContext.slot[arg_41_1].entity:GetCameraPivot()
	self.cameraSlotObj_.localScale = Vector3.one
	self.cameraSlotObj_.localPosition = Vector3.zero
	self.tipText_.text = self.staticContext.slot[arg_41_1].entity:GetSectionCfg().description

	self:ChangeWindowBar(true)
end

function CaptureActivityMainView:Defocus()
	if self.staticContext.curFocusIdx then
		self.staticContext.curFocusIdx = nil

		self.staticContext.slot[self.staticContext.curFocusIdx].entity:ChangeParent(self.defocusSlot_)

		self.cameraSlotObj_.parent = self.inCameraPivot_
	end

	self:ChangeWindowBar(false)
end

function CaptureActivityMainView:Dispose()
	self:StopTimer()
	self:StopCheckTimer()

	self.staticContext = nil

	self.page.section.entity:Dispose()
	self.page.sectionHero.entity:Dispose()

	self.page = nil

	CaptureActivityMainView.super.Dispose(self)
end

return CaptureActivityMainView
