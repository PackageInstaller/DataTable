local var_0_0 = class("SummerRaceMainView", ReduxView)
local var_0_1 = "UI_car_1"
local var_0_2 = 1.5
local var_0_3 = "display"
local var_0_4 = "UI_Activity_SummerRace_MainUI"
local var_0_5 = 0.65
local var_0_6 = 0.5
local var_0_7 = "in"
local var_0_8 = "out"
local var_0_9 = "idle"
local var_0_10 = "UI_base2_cx"
local var_0_11 = 0.05
local var_0_12 = 0.2

local function var_0_13()
	return string.format("%s_%s", RedPointConst.SUMMER_RACE_LIMIT_TASK, SummerRaceConst.ACTIVITY_ID.MAIN)
end

local function var_0_14()
	return string.format("%s_%s", RedPointConst.SUMMER_RACE_CHAMPIONSHIP, SummerRaceConst.ACTIVITY_ID.MAIN)
end

local function var_0_15()
	return string.format("%s_%s", RedPointConst.SUMMER_RACE_NORMAL_TASK, SummerRaceConst.ACTIVITY_ID.MAIN)
end

local function var_0_16()
	return string.format("%s_%s", RedPointConst.SUMMER_RACE_CHALLENGE, SummerRaceConst.ACTIVITY_ID.MAIN)
end

local function var_0_17()
	return string.format("%s_%s", RedPointConst.SUMMER_RACE_MODIFY, SummerRaceConst.ACTIVITY_ID.MAIN)
end

local function var_0_18(arg_6_0)
	if arg_6_0.normalTabBtn_ == nil then
		return nil
	end

	return arg_6_0.normalTabBtn_.transform
end

local function var_0_19(arg_7_0)
	if arg_7_0.challengeTabBtn_ == nil then
		return nil
	end

	return arg_7_0.challengeTabBtn_.transform
end

local function var_0_20(arg_8_0)
	if arg_8_0.currentStageTabState_ == "challenge" and SummerRaceData:GetChallengeUnlockState().isUnlocked == true then
		return var_0_16()
	end

	return var_0_14()
end

local function var_0_21(arg_9_0)
	if arg_9_0.stageEntryBtn_ == nil then
		return
	end

	manager.redPoint:unbindUIandKey(arg_9_0.stageEntryBtn_.transform, var_0_14())
	manager.redPoint:unbindUIandKey(arg_9_0.stageEntryBtn_.transform, var_0_16())
end

local function var_0_22(arg_10_0)
	if arg_10_0.stageEntryBtn_ == nil then
		return
	end

	var_0_21(arg_10_0)
	manager.redPoint:bindUIandKey(arg_10_0.stageEntryBtn_.transform, var_0_20(arg_10_0))
end

local function var_0_23(arg_11_0)
	if arg_11_0.adminSpineCompleteHandler_ ~= nil and arg_11_0.adminSpine_ ~= nil and arg_11_0.adminSpine_.AnimationState ~= nil then
		arg_11_0.adminSpine_.AnimationState.Complete = arg_11_0.adminSpine_.AnimationState.Complete - arg_11_0.adminSpineCompleteHandler_
	end

	arg_11_0.adminSpineCompleteHandler_ = nil
end

local function var_0_24(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	var_0_23(arg_12_0)

	if arg_12_0.adminSpine_ == nil or arg_12_0.adminSpine_.AnimationState == nil then
		return false
	end

	local var_12_0, var_12_1 = pcall(function()
		arg_12_0.adminSpine_.AnimationState:SetAnimation(0, arg_12_1, arg_12_2 == true)
	end)

	if var_12_0 ~= true then
		Debug.LogWarning(string.format("[SummerRaceMainView] failed to play admin spine animation: %s, %s", tostring(arg_12_1), tostring(var_12_1)))

		return false
	end

	if arg_12_3 ~= nil and arg_12_2 ~= true then
		local var_12_2

		local function var_12_3()
			var_0_23(arg_12_0)
			arg_12_3()
		end

		arg_12_0.adminSpineCompleteHandler_ = var_12_3
		arg_12_0.adminSpine_.AnimationState.Complete = arg_12_0.adminSpine_.AnimationState.Complete + var_12_3
	end

	return true
end

local function var_0_25(arg_15_0)
	if arg_15_0.adminSpineModifyOpening_ == true then
		return
	end

	arg_15_0.adminSpineModifyOpening_ = true

	if arg_15_0.adminSpineGo_ ~= nil then
		SetActive(arg_15_0.adminSpineGo_, true)
	end

	local function var_15_0()
		arg_15_0.skipNextAdminSpineOutOnExit_ = true
		arg_15_0.adminSpineModifyOpening_ = nil

		SummerRaceAction.OpenModifyView("all")
	end

	if var_0_24(arg_15_0, var_0_8, false, var_15_0) ~= true then
		var_15_0()
	end
end

local function var_0_26(arg_17_0)
	if arg_17_0.isOpeningTournament_ == true then
		return
	end

	arg_17_0.isOpeningTournament_ = true

	SummerRaceAction.OpenCutScenesPop({
		mode = "enter",
		finishCb = function()
			arg_17_0.isOpeningTournament_ = nil

			SummerRaceAction.OpenTournamentView(nil, {
				playCutScenesExitOnEnter = true
			})
		end
	})
end

local function var_0_27()
	return gameContext:IsOpenRoute("summerRaceCutScenesPopView") ~= nil
end

local function var_0_28(arg_20_0, arg_20_1)
	if arg_20_0.adminPosController_ == nil then
		return
	end

	local var_20_0 = tonumber(arg_20_1 and arg_20_1.bodyType) or 1

	if var_20_0 ~= 1 and var_20_0 ~= 2 and var_20_0 ~= 3 then
		var_20_0 = 1
	end

	arg_20_0.adminPosController_:SetSelectedState("pos_" .. tostring(var_20_0))
end

local function var_0_29(arg_21_0)
	if arg_21_0.challengeUnlockAnimTimer_ ~= nil then
		arg_21_0.challengeUnlockAnimTimer_:Stop()

		arg_21_0.challengeUnlockAnimTimer_ = nil
	end
end

local function var_0_30(arg_22_0)
	if arg_22_0.vehicleModuleLayerFadeTween_ == nil then
		return
	end

	arg_22_0.vehicleModuleLayerFadeTween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
	LeanTween.cancel(arg_22_0.vehicleModuleLayerFadeTween_.id)

	arg_22_0.vehicleModuleLayerFadeTween_ = nil
end

local function var_0_31(arg_23_0)
	if arg_23_0.vehicleDisplayView_ == nil or type(arg_23_0.vehicleDisplayView_.GetModuleLayerGo) ~= "function" then
		return nil
	end

	return arg_23_0.vehicleDisplayView_:GetModuleLayerGo()
end

local function var_0_32(arg_24_0)
	local var_24_0 = var_0_31(arg_24_0)

	if var_24_0 == nil then
		arg_24_0.vehicleModuleLayerCanvasGroup_ = nil

		return nil
	end

	if arg_24_0.vehicleModuleLayerCanvasGroup_ == nil then
		arg_24_0.vehicleModuleLayerCanvasGroup_ = var_24_0:GetComponent(typeof(CanvasGroup))

		if arg_24_0.vehicleModuleLayerCanvasGroup_ == nil then
			arg_24_0.vehicleModuleLayerCanvasGroup_ = var_24_0:AddComponent(typeof(CanvasGroup))
		end
	end

	return arg_24_0.vehicleModuleLayerCanvasGroup_
end

local function var_0_33(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = var_0_32(arg_25_0)

	if var_25_0 == nil then
		return
	end

	local var_25_1 = arg_25_2 == true

	var_25_0.alpha = arg_25_1
	var_25_0.interactable = var_25_1
	var_25_0.blocksRaycasts = var_25_1
end

local function var_0_34(arg_26_0)
	if arg_26_0.bodyDisplayModuleLayerHidden_ ~= true then
		return
	end

	var_0_30(arg_26_0)

	arg_26_0.bodyDisplayModuleLayerHidden_ = nil

	var_0_33(arg_26_0, 1, true)
end

local function var_0_35(arg_27_0)
	var_0_30(arg_27_0)

	local var_27_0 = var_0_31(arg_27_0)

	if var_27_0 == nil then
		return
	end

	var_0_33(arg_27_0, 0, false)

	arg_27_0.vehicleModuleLayerFadeTween_ = LeanTween.value(var_27_0, 0, 1, var_0_6):setDelay(var_0_5):setEase(LeanTweenType.easeOutQuad):setOnUpdate(LuaHelper.FloatAction(function(arg_28_0)
		var_0_33(arg_27_0, arg_28_0, false)
	end)):setOnComplete(System.Action(function()
		arg_27_0.vehicleModuleLayerFadeTween_ = nil

		var_0_33(arg_27_0, 1, true)
	end))
end

local function var_0_36(arg_30_0)
	if arg_30_0.enterAni_ == nil then
		Debug.LogError("[SummerRaceMainView] missing ComponentCfger binding: enterAni_")

		return
	end

	arg_30_0.enterAni_:Play(var_0_4, -1, 0)
	arg_30_0.enterAni_:Update(0)
end

local function var_0_37(arg_31_0, arg_31_1)
	if arg_31_0 == nil or arg_31_0.runtimeAnimatorController == nil then
		return nil
	end

	local var_31_0 = arg_31_0.runtimeAnimatorController.animationClips

	if var_31_0 == nil then
		return nil
	end

	local var_31_1 = tostring(arg_31_1 or "")

	for iter_31_0 = 0, var_31_0.Length - 1 do
		local var_31_2 = var_31_0[iter_31_0]

		if var_31_2 ~= nil and tostring(var_31_2.name or "") == var_31_1 then
			return tonumber(var_31_2.length)
		end
	end

	return nil
end

local function var_0_38(arg_32_0)
	if not SummerRaceData:ShouldPlayChallengeUnlockAnim() then
		return
	end

	if arg_32_0.changeAni_ == nil then
		Debug.LogError("[SummerRaceMainView] missing ComponentCfger binding: changeAni_")

		return
	end

	arg_32_0.isBanTriggerClick_ = true

	arg_32_0.changeAni_:Play(var_0_10, -1, 0)
	arg_32_0.changeAni_:Update(0)
	var_0_29(arg_32_0)

	local var_32_0 = 0
	local var_32_1 = var_0_37(arg_32_0.changeAni_, var_0_10) or 0
	local var_32_2 = var_32_1 > 0 and var_32_1 + var_0_12 or nil

	arg_32_0.challengeUnlockAnimTimer_ = Timer.New(function()
		var_32_0 = var_32_0 + var_0_11

		if arg_32_0.changeAni_ == nil then
			var_0_29(arg_32_0)

			return
		end

		local var_33_0 = arg_32_0.changeAni_:GetCurrentAnimatorStateInfo(0)

		if var_33_0 ~= nil and var_33_0:IsName(var_0_10) and var_33_0.normalizedTime >= 1.1 or var_32_2 ~= nil and var_32_0 >= var_32_2 then
			arg_32_0.isBanTriggerClick_ = false

			arg_32_0.enterImgAni_:Play("UI_enterMask_cx", -1, 0)
			var_0_29(arg_32_0)
			arg_32_0:SetStageTabState("challenge")
			SummerRaceData:MarkChallengeUnlockAnimPlayed()
		end
	end, var_0_11, -1)

	arg_32_0.challengeUnlockAnimTimer_:Start()
end

local function var_0_39(arg_34_0)
	var_0_29(arg_34_0)
	var_0_34(arg_34_0)

	arg_34_0.isOpeningTournament_ = nil

	if arg_34_0.outGameUpdateHandler_ then
		manager.notify:RemoveListener(SummerRaceData.GetEventOutGameUpdated(), arg_34_0.outGameUpdateHandler_)

		arg_34_0.outGameUpdateHandler_ = nil
	end

	if arg_34_0.taskRefreshHandler_ then
		manager.notify:RemoveListener(ON_TASK_SUBMIT_RESPONSE, arg_34_0.taskRefreshHandler_)
		manager.notify:RemoveListener(ON_TASK_SUBMIT_LIST_RESPONSE, arg_34_0.taskRefreshHandler_)
		manager.notify:RemoveListener(TASK_LIST_CHANGE_NOTIFY, arg_34_0.taskRefreshHandler_)

		arg_34_0.taskRefreshHandler_ = nil
	end

	local var_34_0 = var_0_19(arg_34_0)
	local var_34_1 = var_0_18(arg_34_0)

	if var_34_0 ~= nil then
		manager.redPoint:unbindUIandKey(var_34_0, var_0_16())
	end

	if var_34_1 ~= nil then
		manager.redPoint:unbindUIandKey(var_34_1, var_0_14())
	end

	if arg_34_0.stageEntryBtn_ ~= nil then
		var_0_21(arg_34_0)
	end

	if arg_34_0.residentRewardBtn_ ~= nil then
		manager.redPoint:unbindUIandKey(arg_34_0.residentRewardBtn_.transform, var_0_15())
	end

	if arg_34_0.modifyBtn_ ~= nil then
		manager.redPoint:unbindUIandKey(arg_34_0.modifyBtn_.transform, var_0_17())
	end

	if arg_34_0.limitRewardEntryView_ ~= nil then
		arg_34_0.limitRewardEntryView_:OnExit()
		manager.redPoint:unbindUIandKey(arg_34_0.limitRewardEntryView_:GetBindingTransform(), var_0_13())
	end

	var_0_23(arg_34_0)
end

local function var_0_40(arg_35_0, arg_35_1)
	if arg_35_0.challengeTabBtn_ == nil then
		return
	end

	manager.redPoint:unbindUIandKey(arg_35_0.challengeTabBtn_.transform, var_0_16())

	if arg_35_1 == true then
		manager.redPoint:bindUIandKey(arg_35_0.challengeTabBtn_.transform, var_0_16())
	end
end

local function var_0_41(arg_36_0)
	if arg_36_0.windowBarBackHandler_ ~= nil and manager.windowBar:GetLastBackFunc() == arg_36_0.windowBarBackHandler_ then
		manager.windowBar:HideBar()
	end
end

function var_0_0.UIName(arg_37_0)
	return "Widget/System/Activity_SummerRace/Activity_SummerRace_MainUI/Activity_SummerRace_MainUI"
end

function var_0_0.UIParent(arg_38_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_39_0)
	arg_39_0:BindCfgUI()
	arg_39_0:BindViewRuntime()
	arg_39_0:AddUIListener()
end

function var_0_0.BindViewRuntime(arg_40_0)
	arg_40_0.stageTabController_ = arg_40_0.controllerEx_:GetController("stageTab")
	arg_40_0.lockController_ = arg_40_0.controllerEx_:GetController("challengeLock")
	arg_40_0.adminPosController_ = arg_40_0.controllerEx_:GetController("adminPos")
	arg_40_0.currentStageTabState_ = "normal"
	arg_40_0.vehicleDisplayView_ = SummerRaceVehicleDisplayView.New(arg_40_0.carRootGo_)
	arg_40_0.limitRewardEntryView_ = SummerRaceLimitRewardEntryView.New(arg_40_0.limitedRewardEntryGo_)
	arg_40_0.adminSpine_ = arg_40_0.adminSpineGo_ and arg_40_0.adminSpineGo_:GetComponent(typeof(Spine.Unity.SkeletonGraphic)) or nil

	arg_40_0.limitRewardEntryView_:SetClickHandler(function()
		SummerRaceAction.OpenRewardView(SummerRaceConst.REWARD_PAGE.LIMITED)
	end)
end

function var_0_0.OnEnter(arg_42_0)
	arg_42_0.playBodyDisplayOnEnterPending_ = arg_42_0.params_ and arg_42_0.params_.playBodyDisplayOnEnter == true

	if arg_42_0.params_ ~= nil then
		arg_42_0.params_.playBodyDisplayOnEnter = nil
	end

	var_0_24(arg_42_0, var_0_7, false, function()
		var_0_24(arg_42_0, var_0_9, true)
		var_0_38(arg_42_0)
	end)

	local var_42_0 = arg_42_0.params_ and arg_42_0.params_.preferredStageTab or nil

	if var_42_0 == "challenge" then
		arg_42_0.currentStageTabState_ = "challenge"
	elseif var_42_0 == "normal" then
		arg_42_0.currentStageTabState_ = "normal"
	end

	arg_42_0.params_.preferredStageTab = nil

	arg_42_0:UpdateBar()
	SummerRaceData:EnsureFrameworkRedPoints()

	local var_42_1 = var_0_18(arg_42_0)

	if var_42_1 ~= nil then
		manager.redPoint:bindUIandKey(var_42_1, var_0_14())
	end

	var_0_40(arg_42_0, SummerRaceData:GetChallengeUnlockState().isUnlocked == true)
	var_0_22(arg_42_0)
	manager.redPoint:bindUIandKey(arg_42_0.modifyBtn_.transform, var_0_17())
	manager.redPoint:bindUIandKey(arg_42_0.residentRewardBtn_.transform, var_0_15())
	manager.redPoint:bindUIandKey(arg_42_0.limitRewardEntryView_:GetBindingTransform(), var_0_13())
	arg_42_0.limitRewardEntryView_:OnEnter()

	arg_42_0.outGameUpdateHandler_ = handler(arg_42_0, arg_42_0.RefreshView)
	arg_42_0.taskRefreshHandler_ = handler(arg_42_0, arg_42_0.RefreshView)

	manager.notify:RegistListener(SummerRaceData.GetEventOutGameUpdated(), arg_42_0.outGameUpdateHandler_)
	manager.notify:RegistListener(ON_TASK_SUBMIT_RESPONSE, arg_42_0.taskRefreshHandler_)
	manager.notify:RegistListener(ON_TASK_SUBMIT_LIST_RESPONSE, arg_42_0.taskRefreshHandler_)
	manager.notify:RegistListener(TASK_LIST_CHANGE_NOTIFY, arg_42_0.taskRefreshHandler_)
	arg_42_0:RefreshView()
end

function var_0_0.OnExit(arg_44_0)
	if arg_44_0.skipNextAdminSpineOutOnExit_ == true then
		arg_44_0.skipNextAdminSpineOutOnExit_ = nil
	else
		var_0_24(arg_44_0, var_0_8, false)
	end

	arg_44_0.adminSpineModifyOpening_ = nil

	var_0_39(arg_44_0)
	var_0_41(arg_44_0)
end

function var_0_0.OnTop(arg_45_0)
	arg_45_0:UpdateBar()
	arg_45_0:RefreshView()
	arg_45_0:TryPlayReturnFromModifyBodyAnim()
end

function var_0_0.UpdateBar(arg_46_0)
	arg_46_0.windowBarBackHandler_ = arg_46_0.windowBarBackHandler_ or function()
		if var_0_27() then
			return
		end

		JumpTools.Back()
	end

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_TANK_DESC")
	manager.windowBar:RegistBackCallBack(arg_46_0.windowBarBackHandler_)
end

function var_0_0.OnBehind(arg_48_0)
	return
end

function var_0_0.CheckIsCanTriggerClick(arg_49_0)
	return not arg_49_0.isBanTriggerClick_
end

function var_0_0.IsChallengeUnlockAnimPlaying(arg_50_0)
	return arg_50_0.challengeUnlockAnimTimer_ ~= nil
end

function var_0_0.IsChallengeStageTabSelected(arg_51_0)
	return arg_51_0.currentStageTabState_ == "challenge"
end

function var_0_0.AddUIListener(arg_52_0)
	arg_52_0:AddBtnListener(arg_52_0.normalTabBtn_, nil, function()
		if not arg_52_0:CheckIsCanTriggerClick() then
			return
		end

		arg_52_0.enterImgAni_:Play("UI_enterMask_normal", -1, 0)
		arg_52_0:SetStageTabState("normal")
	end)
	arg_52_0:AddBtnListener(arg_52_0.challengeTabBtn_, nil, function()
		if not arg_52_0:CheckIsCanTriggerClick() then
			return
		end

		local var_54_0 = SummerRaceData:GetChallengeUnlockState()

		if var_54_0.isUnlocked ~= true then
			if var_54_0.tipText ~= "" then
				ShowTips(var_54_0.tipText)
			end

			arg_52_0:SetStageTabState("normal")

			return
		end

		arg_52_0:SetStageTabState("challenge")
	end)
	arg_52_0:AddBtnListener(arg_52_0.stageEntryBtn_, nil, function()
		if not arg_52_0:CheckIsCanTriggerClick() then
			return
		end

		if arg_52_0.currentStageTabState_ == "challenge" then
			SummerRaceAction.OpenChallengeView()

			return
		end

		var_0_26(arg_52_0)
	end)
	arg_52_0:AddBtnListener(arg_52_0.illustratedBtn_, nil, function()
		if not arg_52_0:CheckIsCanTriggerClick() then
			return
		end

		SummerRaceAction.OpenIllustratedView("body")
	end)
	arg_52_0:AddBtnListener(arg_52_0.residentRewardBtn_, nil, function()
		if not arg_52_0:CheckIsCanTriggerClick() then
			return
		end

		SummerRaceAction.OpenRewardView(SummerRaceConst.REWARD_PAGE.RESIDENT)
	end)
	arg_52_0:AddBtnListener(arg_52_0.modifyBtn_, nil, function()
		if not arg_52_0:CheckIsCanTriggerClick() then
			return
		end

		var_0_25(arg_52_0)
	end)
end

function var_0_0.TryPlayReturnFromModifyBodyAnim(arg_59_0)
	if arg_59_0.params_ == nil or arg_59_0.params_.returnFromModify ~= true then
		return
	end

	arg_59_0.params_.returnFromModify = nil

	if arg_59_0.vehicleDisplayView_ == nil then
		return
	end

	arg_59_0.vehicleDisplayView_:PlayBodyAnimation(var_0_1, false, nil, var_0_2)
	arg_59_0.enterAni_:Play("UI_Activity_SummerRace_MainUI_cx", -1, 0)
	arg_59_0.enterAni_:Update(0)
end

function var_0_0.TryPlayBodyDisplayOnEnter(arg_60_0)
	if arg_60_0.playBodyDisplayOnEnterPending_ ~= true then
		return
	end

	arg_60_0.playBodyDisplayOnEnterPending_ = nil

	if arg_60_0.vehicleDisplayView_ == nil then
		return
	end

	var_0_34(arg_60_0)

	arg_60_0.bodyDisplayModuleLayerHidden_ = true

	var_0_35(arg_60_0)
	var_0_36(arg_60_0)

	if arg_60_0.vehicleDisplayView_:PlayBodyAnimation(var_0_3, false, function()
		var_0_34(arg_60_0)
	end) ~= true then
		var_0_34(arg_60_0)
	end
end

function var_0_0.SetStageTabState(arg_62_0, arg_62_1)
	arg_62_0.currentStageTabState_ = arg_62_1 == "challenge" and "challenge" or "normal"

	arg_62_0.stageTabController_:SetSelectedState(arg_62_0.currentStageTabState_)
	var_0_22(arg_62_0)
end

function var_0_0.RefreshView(arg_63_0)
	local var_63_0 = SummerRaceData:GetMainPageModel()

	var_0_40(arg_63_0, var_63_0.challengeUnlocked == true)

	if var_63_0.challengeUnlocked ~= true then
		arg_63_0:SetStageTabState("normal")
	else
		arg_63_0:SetStageTabState(arg_63_0.currentStageTabState_)
	end

	arg_63_0.challengeTabBtn_.interactable = true

	arg_63_0.vehicleDisplayView_:AttachHost(arg_63_0.carRootGo_)
	arg_63_0.vehicleDisplayView_:SetData(var_63_0.vehicleDisplay)
	arg_63_0:TryPlayBodyDisplayOnEnter()
	var_0_28(arg_63_0, var_63_0.vehicleDisplay)
	arg_63_0.limitRewardEntryView_:SetData(var_63_0.rewardEntry.limited)

	if arg_63_0.residentProgressText_ ~= nil then
		arg_63_0.residentProgressText_.text = var_63_0.rewardEntry.resident.progressText
	end

	local var_63_1 = SummerRaceData:GetChallengeUnlockState()
	local var_63_2 = SummerRaceData:ShouldPlayChallengeUnlockAnim()

	if var_63_1.isUnlocked ~= true or var_63_2 then
		arg_63_0.lockController_:SetSelectedState("lock")
	else
		arg_63_0.lockController_:SetSelectedState("unlock")
	end
end

function var_0_0.Dispose(arg_64_0)
	var_0_39(arg_64_0)
	var_0_41(arg_64_0)
	var_0_23(arg_64_0)

	if arg_64_0.vehicleDisplayView_ ~= nil then
		arg_64_0.vehicleDisplayView_:Dispose()

		arg_64_0.vehicleDisplayView_ = nil
	end

	if arg_64_0.limitRewardEntryView_ ~= nil then
		arg_64_0.limitRewardEntryView_:Dispose()

		arg_64_0.limitRewardEntryView_ = nil
	end

	arg_64_0.windowBarBackHandler_ = nil
	arg_64_0.adminSpine_ = nil
	arg_64_0.adminPosController_ = nil
	arg_64_0.adminSpineModifyOpening_ = nil
	arg_64_0.skipNextAdminSpineOutOnExit_ = nil
	arg_64_0.challengeUnlockAnimTimer_ = nil
	arg_64_0.playBodyDisplayOnEnterPending_ = nil
	arg_64_0.bodyDisplayModuleLayerHidden_ = nil
	arg_64_0.vehicleModuleLayerCanvasGroup_ = nil
	arg_64_0.vehicleModuleLayerFadeTween_ = nil

	var_0_0.super.Dispose(arg_64_0)
end

return var_0_0
