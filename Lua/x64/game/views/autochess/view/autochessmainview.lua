local var_0_0 = class("AutoChessMainView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_OsirisHorus/Activity_OsirisHorus_Main/Activity_OsirisHorus_HomeUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.statusController_ = arg_4_0.controllerEx_:GetController("status")
	arg_4_0.pvpLockController_ = arg_4_0.controllerEx_:GetController("pvpLock")
	arg_4_0.difficultyController_ = arg_4_0.controllerEx_:GetController("difficulty")
	arg_4_0.medalItems_ = {}

	for iter_4_0, iter_4_1 in ipairs(AutoChessMedalCfg.all) do
		local var_4_0 = AutoChessMedalItem.New(arg_4_0["medalItem" .. iter_4_0 .. "_"])

		arg_4_0.medalItems_[iter_4_1] = var_4_0
	end

	arg_4_0.commonPortrait_ = CommonHeadPortrait.New(arg_4_0.headItem_)
	arg_4_0.medalTips_ = AutoChessMedalTipsItem.New(arg_4_0.medalTipsGo_)
	arg_4_0.skinDlcController_ = arg_4_0.controller_:GetController("skinDLC")
	arg_4_0.skinGotController_ = arg_4_0.controller_:GetController("skinGot")
	arg_4_0.skinGiftController_ = arg_4_0.controller_:GetController("skinGift")
	arg_4_0.timebgController_ = arg_4_0.controller_:GetController("timebg")
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.rewardBtn_, nil, function()
		JumpTools.OpenPageByJump("/autoChessLimitTaskView", {
			activityID = ActivityConst.ACTIVITY_AUTO_CHESS_TASK
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.pveBtn_, nil, function()
		JumpTools.OpenPageByJump("/autoChessPVESelectStageView")
	end)
	arg_5_0:AddBtnListener(arg_5_0.pvpBtn_, nil, function()
		if not arg_5_0.isPassPvpStage_ then
			ShowTips("AUTO_CHESS_PVP_LOCKED_TIP")

			return
		end

		JumpTools.OpenPageByJump("/autoChessPVPEnterView")
	end)
	arg_5_0:AddBtnListener(arg_5_0.illustratedBtn_, nil, function()
		JumpTools.OpenPageByJump("/autoChessIllustratedWindow")
		OperationRecorder.RecordButtonTouch({
			source = 1,
			button_name = "activity_autochess_illustration_homepage_touch",
			activity_id = arg_5_0.activityId_
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.taskBtn_, nil, function()
		JumpTools.OpenPageByJump("/autoChessTaskView")
	end)
	arg_5_0:AddBtnListener(arg_5_0.skinBtn_, nil, function()
		JumpTools.OpenPageByJump("autoChessSkinDlcView")
	end)
	arg_5_0.commonPortrait_:RegisteClickCallback(handler(arg_5_0, arg_5_0.OnClickHeadBackCall))
end

function var_0_0.OnClickHeadBackCall(arg_12_0)
	OperationRecorder.RecordButtonTouch({
		source = 1,
		button_name = "activity_autochess_headshots_touch",
		activity_id = arg_12_0.activityId_
	})
	JumpTools.OpenPageByJump("autoChessHeadTipsPopView", {
		type = 1
	})
end

function var_0_0.OnTop(arg_13_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("AUTO_CHESS_ENTRANCE_TIP")
	arg_13_0:RefreshSkinGet()
end

function var_0_0.OnEnter(arg_14_0)
	AutoChessData:SetActivityID(ActivityConst.ACTIVITY_AUTO_CHESS_MAIN)

	arg_14_0.activityId_ = AutoChessData:GetActivityID()

	arg_14_0:RefreshUI()
	arg_14_0:RefreshMedalItmes()
	arg_14_0:RefreshTime()
	arg_14_0:RefreshSkinTime()
	arg_14_0:BindRedPoint()
	arg_14_0:RefreshPvpTime()

	if not arg_14_0.move then
		arg_14_0.move = Asset.Instantiate("Widget/System/Activity_OsirisHorus/Movie/Activity_OsirisHorus_Home_Movie")

		if arg_14_0.move then
			arg_14_0.move.transform.parent = arg_14_0.movieTrans_
			arg_14_0.move.transform.localScale = Vector3.one
			arg_14_0.move.transform.localPosition = Vector3.zero
		end
	end
end

function var_0_0.BindRedPoint(arg_15_0)
	manager.redPoint:bindUIandKey(arg_15_0.rewardBtn_.transform, RedPointConst.AUTO_CHESS_LIMIT_TASK .. ActivityConst.ACTIVITY_AUTO_CHESS_TASK)
	manager.redPoint:bindUIandKey(arg_15_0.pveBtn_.transform, RedPointConst.AUTO_CHESS_PVE_STAGE)
	manager.redPoint:bindUIandKey(arg_15_0.taskBtn_.transform, RedPointConst.AUTO_CHESS_RESIDENT_TASK .. arg_15_0.activityId_)
end

function var_0_0.UnBindRedPoint(arg_16_0)
	manager.redPoint:unbindUIandKey(arg_16_0.rewardBtn_.transform, RedPointConst.AUTO_CHESS_LIMIT_TASK .. ActivityConst.ACTIVITY_AUTO_CHESS_TASK)
	manager.redPoint:unbindUIandKey(arg_16_0.pveBtn_.transform, RedPointConst.AUTO_CHESS_PVE_STAGE)
	manager.redPoint:unbindUIandKey(arg_16_0.taskBtn_.transform, RedPointConst.AUTO_CHESS_RESIDENT_TASK .. arg_16_0.activityId_)
end

function var_0_0.RefreshUI(arg_17_0)
	arg_17_0.commonPortrait_:RenderHead(PlayerData:GetPlayerInfo().portrait)

	local var_17_0, var_17_1 = TaskTools.GetTaskNumInfo(arg_17_0.activityId_)

	arg_17_0.taskProgressText_.text = GetTipsF("AUTO_CHESS_PROGRESS_NUMBER_HOME", var_17_0, var_17_1)
	arg_17_0.isPassPvpStage_ = AutoChessTools.GetStageState(GameSetting.auto_chess_PVP_unlock.value[1]) == AutoChessConst.STAGE_STATE.COMPLETED

	arg_17_0.pvpLockController_:SetSelectedState(arg_17_0.isPassPvpStage_ and "unlock" or "lock")
	arg_17_0.statusController_:SetSelectedState(arg_17_0.isPassPvpStage_ and "pvp" or "pve")

	arg_17_0.pvpTitleText_.text = GetTips("AUTO_CHESS_PVP_ENTRANCE")
	arg_17_0.pveTitleText_.text = GetTips("AUTO_CHESS_PVE_ENTRANCE")
	arg_17_0.taskTitleText_.text = GetTips("AUTO_CHESS_CAREER_ENTRANCE")
	arg_17_0.illustratTitleText_.text = GetTips("AUTO_CHESS_INDEX_ENTRANCE")

	local var_17_2 = AutoChessTools.GetCurChallengeArea()
	local var_17_3 = AutoChessAreaCfg[var_17_2]

	if arg_17_0.isPassPvpStage_ then
		arg_17_0.pveSmallBg_.sprite = getSpriteWithoutAtlas("TextureConfig/Activity_OsirisHorus/Home_img/home_bg_s" .. var_17_3.entrance_picture)
	else
		arg_17_0.pveBg_.sprite = getSpriteWithoutAtlas("TextureConfig/Activity_OsirisHorus/Home_img/home_bg_m" .. var_17_3.entrance_picture)
	end

	if AutoChessTools.IsCanChallengeStage() and arg_17_0.isPassPvpStage_ then
		arg_17_0.difficultyController_:SetSelectedState("on")
	else
		arg_17_0.difficultyController_:SetSelectedState("off")
	end
end

function var_0_0.RefreshMedalItmes(arg_18_0)
	local var_18_0 = {}
	local var_18_1 = {}
	local var_18_2 = {}

	for iter_18_0, iter_18_1 in ipairs(AutoChessMedalCfg.all) do
		local var_18_3, var_18_4 = AutoChessData:FindMedalInfo(iter_18_1)
		local var_18_5 = AutoChessData.IsMedalUnlockedFromInfo(var_18_4)
		local var_18_6 = true

		if var_18_5 and (getData("auto_chess_main", "medal_id_" .. iter_18_1 .. "_1") or 0) == 0 then
			table.insert(var_18_0, iter_18_1)

			var_18_6 = false
		end

		if AutoChessData.IsMedalAdvancedFromInfo(var_18_4) and (getData("auto_chess_main", "medal_id_" .. iter_18_1 .. "_2") or 0) == 0 then
			table.insert(var_18_1, iter_18_1)

			var_18_6 = false
		end

		if var_18_6 then
			table.insert(var_18_2, iter_18_1)
		end
	end

	local var_18_7 = 1

	if #var_18_0 > 0 then
		arg_18_0.normalTimer = Timer.New(function()
			local var_19_0 = var_18_0[var_18_7]

			saveData("auto_chess_main", "medal_id_" .. var_19_0 .. "_1", 1)
			arg_18_0.medalTips_:SetCloseFunc(handler(arg_18_0, arg_18_0.OnRefreshMedel))
			arg_18_0.medalTips_:SetData(var_19_0, false)

			var_18_7 = var_18_7 + 1
		end, 2, #var_18_0)

		arg_18_0.normalTimer:Start()
	end

	local var_18_8 = 1

	if #var_18_1 > 0 then
		arg_18_0.advanceTimer = Timer.New(function()
			local var_20_0 = var_18_1[var_18_8]

			saveData("auto_chess_main", "medal_id_" .. var_20_0 .. "_2", 1)
			arg_18_0.medalTips_:SetCloseFunc(handler(arg_18_0, arg_18_0.OnRefreshMedel))
			arg_18_0.medalTips_:SetData(var_20_0, true)

			var_18_8 = var_18_8 + 1
		end, #var_18_0 * 2 + 2, #var_18_1)

		arg_18_0.advanceTimer:Start()
	end

	if #var_18_2 > 0 then
		for iter_18_2, iter_18_3 in ipairs(var_18_2) do
			arg_18_0:OnRefreshMedel(iter_18_3, false)
		end
	end
end

function var_0_0.OnRefreshMedel(arg_21_0, arg_21_1, arg_21_2)
	arg_21_0.medalItems_[arg_21_1]:SetData(arg_21_1, arg_21_2)
end

function var_0_0.RefreshTime(arg_22_0)
	local var_22_0 = ActivityData:GetActivityData(ActivityConst.ACTIVITY_AUTO_CHESS_TASK)

	arg_22_0.timeText_.text = manager.time:GetLostTimeStr2(var_22_0.stopTime)

	SetActive(arg_22_0.rewardBtn_.gameObject, ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_AUTO_CHESS_TASK))

	if arg_22_0.limittimer_ == nil then
		arg_22_0.limittimer_ = Timer.New(function()
			if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_AUTO_CHESS_TASK) then
				arg_22_0.timeText_.text = manager.time:GetLostTimeStr2(var_22_0.stopTime)
			else
				SetActive(arg_22_0.rewardBtn_.gameObject, false)
				arg_22_0:LimitStopTimer()
			end
		end, 1, -1)
	end

	arg_22_0.limittimer_:Start()
end

function var_0_0.RefreshPvpTime(arg_24_0)
	if not arg_24_0.isPassPvpStage_ then
		arg_24_0.timebgController_:SetSelectedState("un")

		return
	end

	arg_24_0.timebgController_:SetSelectedState("time")

	local var_24_0 = ActivityData:GetActivityData(ActivityConst.ACTIVITY_AUTO_CHESS_PVP_4_8)

	if manager.time:GetServerTime() > var_24_0.stopTime then
		arg_24_0:StopPvpTimeTimer()

		arg_24_0.txtPvPTime_.text = GetTips("TIME_OVER")

		return
	end

	arg_24_0.txtPvPTime_.text = GetTipsF("LEFT_TIME", manager.time:GetLostTimeStrWith2Unit(var_24_0.stopTime))

	if arg_24_0.pvpTimeTimer_ == nil then
		arg_24_0.pvpTimeTimer_ = Timer.New(function()
			if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_AUTO_CHESS_PVP_4_8) then
				arg_24_0.txtPvPTime_.text = GetTipsF("LEFT_TIME", manager.time:GetLostTimeStrWith2Unit(var_24_0.stopTime))
			else
				arg_24_0:StopPvpTimeTimer()

				arg_24_0.txtPvPTime_.text = GetTips("TIME_OVER")
			end
		end, 1, -1)
	end

	arg_24_0.pvpTimeTimer_:Start()
end

function var_0_0.LimitStopTimer(arg_26_0)
	if arg_26_0.limittimer_ then
		arg_26_0.limittimer_:Stop()

		arg_26_0.limittimer_ = nil
	end
end

function var_0_0.StopPvpTimeTimer(arg_27_0)
	if arg_27_0.pvpTimeTimer_ then
		arg_27_0.pvpTimeTimer_:Stop()

		arg_27_0.pvpTimeTimer_ = nil
	end
end

function var_0_0.DisposeSkinTimer(arg_28_0)
	if arg_28_0.skinTimer_ then
		arg_28_0.skinTimer_:Stop()

		arg_28_0.skinTimer_ = nil
	end
end

function var_0_0.RefreshSkinTime(arg_29_0)
	arg_29_0:RefreshSkinGet()
	arg_29_0:UpdateSkinTime()
	arg_29_0:DisposeSkinTimer()

	arg_29_0.skinTimer_ = Timer.New(function()
		arg_29_0:UpdateSkinTime()
	end, 1, -1)

	arg_29_0.skinTimer_:Start()
end

function var_0_0.UpdateSkinTime(arg_31_0)
	local var_31_0 = ActivityConst.ACTIVITY_AUTO_CHESS_SKIN
	local var_31_1 = ActivityData:GetActivityData(var_31_0)

	if ActivityData:GetActivityIsOpen(var_31_0) then
		arg_31_0.skinTimeText_.text = manager.time:GetLostTimeStr2(ActivityData:GetActivityData(var_31_0).stopTime)
	elseif manager.time:GetServerTime() < var_31_1.startTime then
		arg_31_0.skinTimeText_.text = string.format(GetTips("AFTER_TIME"), manager.time:GetLostTimeStr2(var_31_1.startTime))
	elseif manager.time:GetServerTime() > var_31_1.stopTime then
		arg_31_0.skinTimeText_.text = GetTips("TIME_OVER")
	end
end

function var_0_0.RefreshSkinGet(arg_32_0)
	local var_32_0 = ActivityConst.ACTIVITY_AUTO_CHESS_SKIN
	local var_32_1 = AssignmentCfg.get_id_list_by_activity_id[var_32_0] or {}

	if not ActivityData:GetActivityIsOpen(var_32_0) then
		arg_32_0.skinDlcController_:SetSelectedState("off")

		return
	else
		arg_32_0.skinDlcController_:SetSelectedState("on")
	end

	if TaskTools:GetFinishTaskNum(var_32_1) == #var_32_1 then
		arg_32_0.skinGotController_:SetSelectedState("on")
	else
		arg_32_0.skinGotController_:SetSelectedState("off")
	end

	if TaskTools:IsHasReceiveTask(var_32_1) then
		arg_32_0.skinGiftController_:SetSelectedState("on")
	else
		arg_32_0.skinGiftController_:SetSelectedState("off")
	end
end

function var_0_0.OnExit(arg_33_0)
	manager.windowBar:HideBar()
	arg_33_0:DisposeSkinTimer()
	arg_33_0:LimitStopTimer()
	arg_33_0:StopPvpTimeTimer()

	if arg_33_0.limittimer_ then
		arg_33_0.limittimer_:Stop()

		arg_33_0.limittimer_ = nil
	end

	if arg_33_0.normalTimer then
		arg_33_0.normalTimer:Stop()

		arg_33_0.normalTimer = nil
	end

	if arg_33_0.advanceTimer then
		arg_33_0.advanceTimer:Stop()

		arg_33_0.advanceTimer = nil
	end

	if arg_33_0.move then
		Object.Destroy(arg_33_0.move)

		arg_33_0.move = nil
	end

	arg_33_0:UnBindRedPoint()
end

function var_0_0.Dispose(arg_34_0)
	arg_34_0.commonPortrait_:Dispose()
	arg_34_0.medalTips_:Dispose()

	for iter_34_0, iter_34_1 in pairs(arg_34_0.medalItems_) do
		iter_34_1:Dispose()
	end

	arg_34_0.medalItems_ = nil

	var_0_0.super.Dispose(arg_34_0)
end

return var_0_0
