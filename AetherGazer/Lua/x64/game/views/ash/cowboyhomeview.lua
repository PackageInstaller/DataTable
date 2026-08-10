local var_0_0 = class("CowboyHomeView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_EkChuah/EkChuah_MainUI/Activity_EkChuah_HomeUI"
end

function var_0_0.GetCustomScene(arg_2_0)
	return HeroRaiseTrackConst.CustomScene.Cowboy
end

function var_0_0.UIParent(arg_3_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListeners()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.infiniteTabController = arg_5_0.infiniteController_:GetController("select")
	arg_5_0.sectionTabController = arg_5_0.sectionController_:GetController("select")
	arg_5_0.lockInfiniteController = arg_5_0.infiniteController_:GetController("lock")
end

function var_0_0.AddUIListeners(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.pointBtn_, nil, function()
		JumpTools.OpenPageByJump("/ashPointView")
	end)
	arg_6_0:AddBtnListener(arg_6_0.taskBtn_, nil, function()
		LimitTimeTaskTools.JumpToLimitTimeTaskView(ActivityConst.ACTIVITY_ASH_LIMITED_TASK)
	end)
	arg_6_0:AddBtnListener(arg_6_0.infiniteBtn_, nil, function()
		if AshSystemData:IsInfiniteOpen() then
			arg_6_0:OnInfiniteClick()
		else
			ShowTips(GetTips("ASH_INFINITE_LOCK"))
		end
	end)
	arg_6_0:AddBtnListener(arg_6_0.InfiniteJumpBtn_, nil, function()
		JumpTools.OpenPageByJump("/ashInfinityView")
	end)
	arg_6_0:AddBtnListener(arg_6_0.processBtn_, nil, function()
		arg_6_0:GetCustomSceneController():ShowCutScene(function()
			JumpTools.OpenPageByJump("/ashProcessView")
		end)
	end)
	arg_6_0:AddBtnListener(arg_6_0.descBtn_, nil, function()
		arg_6_0:OnDescClick()
	end)
	arg_6_0:AddBtnListener(arg_6_0.sectionBtn_, nil, function()
		arg_6_0:OnSectionClick()
	end)
	arg_6_0:AddBtnListener(arg_6_0.sectionJumpBtn_, nil, function()
		local var_15_0 = 1

		for iter_15_0 = 2, 3 do
			if AshSystemData:CheckIsOpenArea(iter_15_0) then
				var_15_0 = iter_15_0
			else
				break
			end
		end

		JumpTools.OpenPageByJump("/ashSectionView", {
			lastOpenArea = var_15_0
		})
	end)
end

function var_0_0.OnAshAvgEnd(arg_16_0)
	local var_16_0 = arg_16_0:GetCustomSceneController()

	if var_16_0 then
		var_16_0:OnInit()
	end

	arg_16_0:OnEnter()
	arg_16_0:OnTop()
end

function var_0_0.OnEnter(arg_17_0)
	if AshSystemData:GetStoryState() then
		return
	end

	AshSystemData:UpdateTaskRedPoint()
	SetActive(arg_17_0.clickMaskObj_, true)

	local var_17_0 = PlayerData:GetStoryList()
	local var_17_1 = getData("ash", "start_avg") or var_17_0[GameSetting.ash_start_story.value[1]] == true
	local var_17_2 = getData("ash", "end_avg") or var_17_0[GameSetting.ash_end_story.value[1]] == true

	if not var_17_1 then
		local var_17_3 = arg_17_0:GetCustomSceneController()

		if var_17_3 then
			var_17_3:ReleaseHero("1083ui_dynamic")
		end

		saveData("ash", "start_avg", true)

		local var_17_4 = GameSetting.ash_start_story.value[1]

		AshSystemData:StartStory()
		manager.story:StartStoryById(var_17_4, function()
			AshSystemData:EndStory()
		end)
	elseif AshSystemData:GetEndStoryIsUnlock() and not var_17_2 then
		local var_17_5 = arg_17_0:GetCustomSceneController()

		if var_17_5 then
			var_17_5:ReleaseHero("1083ui_dynamic")
		end

		saveData("ash", "end_avg", true)

		local var_17_6 = GameSetting.ash_end_story.value[1]

		AshSystemData:StartStory()
		manager.story:StartStoryById(var_17_6, function()
			AshSystemData:EndStory()
		end)
	else
		arg_17_0:OnEnterFunc()
	end
end

function var_0_0.OnEnterFunc(arg_20_0)
	manager.ui.mainCamera:GetComponent("CameraExtension").shadowRotationImmediately = true

	SetActive(arg_20_0.clickMaskObj_, false)

	arg_20_0.infiniteAnimator_.enabled = false
	arg_20_0.activityID_ = ActivityConst.ACTIVITY_ASH_MAIN

	local var_20_0 = arg_20_0:GetCustomSceneController()

	var_20_0:CloseCutScene()

	local var_20_1 = var_20_0:GetPlayableLength()

	var_20_0:Restart()

	if var_20_0.SwitchBgState then
		var_20_0:SwitchBgState(0)
	end

	arg_20_0:RefreshLimitTime()
	manager.redPoint:bindUIandKey(arg_20_0.sectionObj_.transform, RedPointConst.ASH_ACTIVITY_SECTION)
	manager.redPoint:bindUIandKey(arg_20_0.rewardRedRoot_.transform, RedPointConst.ASH_ACTIVITY_LIMIT_TASK .. ActivityConst.ACTIVITY_ASH_LIMITED_TASK)
	manager.redPoint:bindUIandKey(arg_20_0.pointBtn_.transform, RedPointConst.ASH_ACTIVITY_RESIDENT_TASK .. ActivityConst.ACTIVITY_ASH_MAIN)
	arg_20_0:SetupInfinite()

	local var_20_2 = ItemTools.getItemNum(CurrencyIdMapCfg.CURRENCY_ASH_COIN_4_4.item_id)
	local var_20_3 = GameSetting.skuld_trust_max.value[1]
	local var_20_4 = "%d/%d"

	arg_20_0.processTxt_.text = string.format(var_20_4, var_20_2, var_20_3)
	arg_20_0.progressImg_.fillAmount = var_20_2 / var_20_3

	local var_20_5 = 1

	for iter_20_0 = 2, 3 do
		if AshSystemData:CheckIsOpenArea(iter_20_0) then
			var_20_5 = iter_20_0
		else
			break
		end
	end

	arg_20_0:GetCustomSceneController():SwitchBgStageIndex(var_20_5)
end

function var_0_0.OnTop(arg_21_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ASH_ENTRANCE_TIP")

	local var_21_0 = 1

	for iter_21_0 = 2, 3 do
		if AshSystemData:CheckIsOpenArea(iter_21_0) then
			var_21_0 = iter_21_0
		else
			break
		end
	end

	if AshSystemData:GetStoryState() then
		return
	end

	arg_21_0:GetCustomSceneController():SwitchBgStageIndex(var_21_0)
end

function var_0_0.OnBehind(arg_22_0)
	manager.windowBar:HideBar()
end

function var_0_0.OnExit(arg_23_0)
	arg_23_0:LimitStopTimer()
	manager.redPoint:unbindUIandKey(arg_23_0.sectionObj_.transform)
	manager.redPoint:unbindUIandKey(arg_23_0.rewardRedRoot_.transform)
	manager.redPoint:unbindUIandKey(arg_23_0.pointBtn_.transform)
end

function var_0_0.OnDescClick(arg_24_0)
	local var_24_0 = "ASH_ENTRANCE_TIP"

	JumpTools.OpenPageByJump("gameHelp", {
		content = GetTips(var_24_0),
		key = var_24_0
	})
end

function var_0_0.SetupInfinite(arg_25_0)
	if AshSystemData:IsInfiniteOpen() then
		arg_25_0.lockInfiniteController:SetSelectedState("unlock")

		local var_25_0 = "CowbotHomeViewInfiniteLock"

		if not getData("ash", var_25_0) then
			arg_25_0:OnSectionClick()
			FrameTimer.New(function()
				arg_25_0.aniTimer_ = Timer.New(function()
					if arg_25_0.infiniteAnimator_:GetCurrentAnimatorStateInfo(0).normalizedTime >= 1 then
						if arg_25_0.aniTimer_ then
							arg_25_0.aniTimer_:Stop()

							arg_25_0.aniTimer_ = nil
						end

						saveData("ash", var_25_0, true)
						manager.ui:UIEventEnabled(true)
					end
				end, 0.033, -1)

				manager.ui:UIEventEnabled(false)

				arg_25_0.infiniteAnimator_.enabled = true

				arg_25_0.infiniteAnimator_:Play("tabItem02", 0, 0)
				arg_25_0:OnInfiniteClick()
				arg_25_0.aniTimer_:Start()
			end, 1, 1):Start()
		else
			arg_25_0:OnInfiniteClick()
		end
	else
		arg_25_0.lockInfiniteController:SetSelectedState("lock")
		arg_25_0:OnSectionClick()
	end
end

function var_0_0.OnSectionClick(arg_28_0)
	arg_28_0.infiniteTabController:SetSelectedState("false")
	arg_28_0.sectionTabController:SetSelectedState("true")
	SetActive(arg_28_0.sectionObj_, true)
	SetActive(arg_28_0.infiniteObj_, false)

	local var_28_0 = 1

	for iter_28_0 = 2, 3 do
		if AshSystemData:CheckIsOpenArea(iter_28_0) then
			var_28_0 = iter_28_0
		else
			break
		end
	end

	arg_28_0.sectionIcon_.sprite = pureGetSpriteWithoutAtlas(GameSetting["ash_area_background_" .. var_28_0].value[1])
	arg_28_0.sectionImg_.sprite = getSprite("Atlas/Activity_EkChuahAtlas", GameSetting["ash_area_icon_" .. var_28_0].value[1])
	arg_28_0.sectionTxt_.text = GetTips("ASH_AREA_NAME_" .. var_28_0)
end

function var_0_0.OnInfiniteClick(arg_29_0)
	arg_29_0.infiniteTabController:SetSelectedState("true")
	arg_29_0.sectionTabController:SetSelectedState("false")
	SetActive(arg_29_0.sectionObj_, false)
	SetActive(arg_29_0.infiniteObj_, true)

	local var_29_0 = 0

	for iter_29_0, iter_29_1 in ipairs(AshShootStageCfg.all) do
		if AshShootStageCfg[iter_29_1].stage_group == 4 then
			var_29_0 = iter_29_1

			break
		end
	end

	local var_29_1 = AshSystemData:GetStagePoint(var_29_0)
	local var_29_2 = "-- --"

	if var_29_1 > 0 then
		var_29_2 = tostring(var_29_1)
	end

	arg_29_0.infiniteTxt_.text = tostring(var_29_2)
end

function var_0_0.RefreshLimitTime(arg_30_0)
	local var_30_0 = ActivityData:GetActivityData(ActivityConst.ACTIVITY_ASH_LIMITED_TASK)

	if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_ASH_LIMITED_TASK) then
		SetActive(arg_30_0.taskBtn_.gameObject, true)

		arg_30_0.limitTimeTxt_.text = manager.time:GetLostTimeStr2(var_30_0.stopTime)
	else
		SetActive(arg_30_0.taskBtn_.gameObject, false)
	end

	arg_30_0:LimitStopTimer()

	if arg_30_0.limittimer_ == nil then
		arg_30_0.limittimer_ = Timer.New(function()
			if ActivityData:GetActivityIsOpen(arg_30_0.activityID_) then
				arg_30_0.limitTimeTxt_.text = manager.time:GetLostTimeStr2(var_30_0.stopTime)
			else
				if manager.time:GetServerTime() < var_30_0.startTime then
					arg_30_0.limitTimeTxt_.text = string.format(GetTips("AFTER_TIME"), manager.time:GetLostTimeStr2(var_30_0.startTime))
				elseif manager.time:GetServerTime() > var_30_0.stopTime then
					arg_30_0.limitTimeTxt_.text = GetTips("TIME_OVER")
				end

				SetActive(arg_30_0.taskBtn_.gameObject, false)
			end
		end, 1, -1)
	end

	arg_30_0.limittimer_:Start()
end

function var_0_0.LimitStopTimer(arg_32_0)
	if arg_32_0.limittimer_ then
		arg_32_0.limittimer_:Stop()

		arg_32_0.limittimer_ = nil
	end
end

function var_0_0.Dispose(arg_33_0)
	if arg_33_0.aniTimer_ then
		manager.ui:UIEventEnabled(true)
		arg_33_0.aniTimer_:Stop()

		arg_33_0.aniTimer_ = nil
	end

	arg_33_0:LimitStopTimer()
	var_0_0.super.Dispose(arg_33_0)
end

return var_0_0
