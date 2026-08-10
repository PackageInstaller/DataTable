local var_0_0 = class("QWorldBookletEntryView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/SandPlay_QuanZhou/QuanZhou_Com/QuanZhou_CollectBookMainUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()

	arg_3_0.rewardBtnActive_ = true
	arg_3_0.curLv_ = 0
	arg_3_0.maxLv_ = 0
	arg_3_0.ndnavigationController_ = arg_3_0.mainControllerEx_:GetController("ndnavigation")
	arg_3_0.seaWarfareTitle_.text = SandPlaySystemCfg[QWorldSystemConst.SEA_WARFARE].name
	arg_3_0.seaWarfareTitle_2.text = SandPlaySystemCfg[QWorldSystemConst.SEA_WARFARE].name
	arg_3_0.bookNameText.text = QWorldBookletTools.GetBookletSystemName()
	arg_3_0.bookNameText_.text = QWorldBookletTools.GetBookletSystemName()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.rewardBtn_, nil, function()
		JumpTools.OpenPageByJump("/quanZhouLimitTimeTaskView", {
			activityID = ActivityConst.ACTIVITY_QUANZHOU_TASK
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.mainBtn_, nil, function()
		JumpTools.OpenPageByJump("/qWorldBookletMain")
	end)
	arg_5_0:AddBtnListener(arg_5_0.sailingBtn_, nil, function()
		if not arg_5_0.seawarfareUnlock_ then
			ShowTips("GOON_STORY_TO_GET")

			return
		end

		SeaWarfareTools.GotoChallengeStage()
	end)
end

function var_0_0.OnEnter(arg_9_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		arg_9_0:Back()
	end)
	QWorldMgr:GetQWorldPerformMgr():ForceStopPlayerPerform(nil, true)
	QWorldMgr:EnableCamera(QWorldCameraFlag.FocusPlayer, "", QWorldCameraLayer.FocusPlayer)
	QWorldLuaBridge.HidePlayer(false)
	QWorldLuaBridge.EnterPlayerFocus(true)
	arg_9_0:RefreshBookletPart()

	local var_9_0 = getData("QWorldBookletAnimData", "EntrySeaUnlockAnimHasPlayed") or 0

	arg_9_0.seawarfareUnlock_ = SeaWarfareTools.IsSystemUnLock()

	if arg_9_0.seawarfareUnlock_ then
		if var_9_0 == 1 then
			arg_9_0.ndnavigationController_:SetSelectedState("unlock")
		else
			saveData("QWorldBookletAnimData", "EntrySeaUnlockAnimHasPlayed", 1)
			arg_9_0.ndnavigationController_:SetSelectedState("lock")

			local var_9_1

			var_9_1 = FrameTimer.New(function()
				var_9_1:Stop()

				if arg_9_0.ndnavigationController_ then
					arg_9_0.ndnavigationController_:SetSelectedState("unlock")
				end
			end, 20, 1)

			var_9_1:Start()
		end
	else
		arg_9_0.ndnavigationController_:SetSelectedState("lock")
	end

	arg_9_0:AwardRemainTime()
	manager.redPoint:bindUIandKey(arg_9_0.rewardBtn_.transform, RedPointConst.QUANZHOU_LIMIT_TASK_ALL)
	manager.redPoint:bindUIandKey(arg_9_0.bookletStageTrs_, RedPointConst.QWORLD_BOOKLET_LEVEL_REWARD)
end

function var_0_0.RefreshBookletPart(arg_12_0)
	arg_12_0.curLv_, arg_12_0.maxLv_ = QWorldBookletTools.GetNdLevelInfo()
	arg_12_0.mainLvText.text = arg_12_0.curLv_ .. "<size=60>/" .. arg_12_0.maxLv_ .. "</size>"
	arg_12_0.mainLvText_.text = arg_12_0.curLv_ .. "<size=60>/" .. arg_12_0.maxLv_ .. "</size>"
	arg_12_0.curStage_ = QWorldData:GetNowPhaseId()

	local var_12_0 = getData("QWorldBookletAnimData", "EntryViewStage") or 1

	if var_12_0 < arg_12_0.curStage_ then
		saveData("QWorldBookletAnimData", "EntryViewStage", arg_12_0.curStage_)

		arg_12_0.stageImg_.spriteAsync = QuanzhouPhaseCfg[var_12_0].pic
		arg_12_0.nextImg_.spriteAsync = QuanzhouPhaseCfg[arg_12_0.curStage_].pic
		arg_12_0.stageIconImg_.spriteAsync = QuanzhouPhaseCfg[var_12_0].icon
		arg_12_0.nextIconImg_.spriteAsync = QuanzhouPhaseCfg[arg_12_0.curStage_].icon
		arg_12_0.stageNameText_.text = QuanzhouPhaseCfg[var_12_0].name
		arg_12_0.nextNameText_.text = QuanzhouPhaseCfg[arg_12_0.curStage_].name

		arg_12_0.changePD_:Play()
		SetActive(arg_12_0.yanhuaGo_, false)
		SetActive(arg_12_0.yanhuaNextGo_, false)

		if arg_12_0.curStage_ == 4 then
			local var_12_1

			var_12_1 = FrameTimer.New(function()
				var_12_1:Stop()

				if arg_12_0.yanhuaNextGo_ then
					SetActive(arg_12_0.yanhuaNextGo_, true)
				end
			end, 45, 1)

			var_12_1:Start()
		end
	else
		SetActive(arg_12_0.nextGo_, false)

		arg_12_0.stageImg_.spriteAsync = QuanzhouPhaseCfg[arg_12_0.curStage_].pic
		arg_12_0.stageIconImg_.spriteAsync = QuanzhouPhaseCfg[arg_12_0.curStage_].icon
		arg_12_0.stageNameText_.text = QuanzhouPhaseCfg[arg_12_0.curStage_].name

		arg_12_0.normalPD_:Play()
		SetActive(arg_12_0.yanhuaGo_, arg_12_0.curStage_ == 4)
	end

	arg_12_0.taskAnimator_.enabled = false

	local var_12_2 = ActivityCfg[ActivityConst.ACTIVITY_QUANZHOU_TASK].sub_activity_list

	for iter_12_0, iter_12_1 in ipairs(var_12_2) do
		local var_12_3 = TaskTools:GetActivityTaskList(iter_12_1) or {}

		for iter_12_2, iter_12_3 in pairs(var_12_3) do
			if iter_12_3.progress >= AssignmentCfg[iter_12_3.id].need and iter_12_3.complete_flag < 1 then
				arg_12_0.taskAnimator_.enabled = true

				break
			end
		end
	end

	arg_12_0:AwardRemainTime()
end

function var_0_0.AwardRemainTime(arg_14_0)
	local var_14_0 = ActivityData:GetActivityData(ActivityConst.ACTIVITY_QUANZHOU_TASK)

	if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_QUANZHOU_TASK) then
		arg_14_0.rewardTimeText_.text = manager.time:GetLostTimeStr2(var_14_0.stopTime)
	else
		if manager.time:GetServerTime() < var_14_0.startTime then
			arg_14_0.rewardTimeText_.text = string.format(GetTips("AFTER_TIME"), manager.time:GetLostTimeStrWith2Unit(var_14_0.startTime))
		elseif manager.time:GetServerTime() > var_14_0.stopTime then
			arg_14_0.rewardTimeText_.text = GetTips("TIME_OVER")
		end

		if arg_14_0.rewardBtnActive_ then
			SetActive(arg_14_0.rewardBtn_.gameObject, false)

			arg_14_0.rewardBtnActive_ = false
		end
	end

	arg_14_0:StopAwardTimer()

	if arg_14_0.awardTimer_ == nil then
		arg_14_0.awardTimer_ = Timer.New(function()
			if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_QUANZHOU_TASK) then
				arg_14_0.rewardTimeText_.text = manager.time:GetLostTimeStr2(var_14_0.stopTime)
			else
				if manager.time:GetServerTime() < var_14_0.startTime then
					arg_14_0.rewardTimeText_.text = string.format(GetTips("AFTER_TIME"), manager.time:GetLostTimeStrWith2Unit(var_14_0.startTime))
				elseif manager.time:GetServerTime() > var_14_0.stopTime then
					arg_14_0.rewardTimeText_.text = GetTips("TIME_OVER")
				end

				if arg_14_0.rewardBtnActive_ then
					SetActive(arg_14_0.rewardBtn_.gameObject, false)

					arg_14_0.rewardBtnActive_ = false
				end
			end
		end, 1, -1)
	end

	arg_14_0.awardTimer_:Start()
end

function var_0_0.StopAwardTimer(arg_16_0)
	if arg_16_0.awardTimer_ then
		arg_16_0.awardTimer_:Stop()

		arg_16_0.awardTimer_ = nil
	end
end

function var_0_0.OnExit(arg_17_0)
	manager.redPoint:unbindUIandKey(arg_17_0.rewardBtn_.transform, RedPointConst.QUANZHOU_LIMIT_TASK_ALL)
	manager.redPoint:unbindUIandKey(arg_17_0.bookletStageTrs_, RedPointConst.QWORLD_BOOKLET_LEVEL_REWARD)
	arg_17_0:StopAwardTimer()
	QWorldMgr:ExitFocusCamera()
	QWorldLuaBridge.EnterPlayerFocus(false)
	arg_17_0:StopAwardTimer()
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_18_0)
	var_0_0.super.Dispose(arg_18_0)
end

return var_0_0
