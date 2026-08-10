local var_0_0 = class("SummerWaterMainView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/SummerUI_3_4/SummerUI_3_4_SwimsuitUI/SummerUI_3_4_SwimsuitWaterGunUI"
end

local var_0_1 = 44

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
	arg_4_0:AddUIListeners()

	arg_4_0.modelShowController_ = arg_4_0.controller_:GetController("show")
	arg_4_0.singleSelectShowController_ = arg_4_0.singleSelectController_:GetController("select")
	arg_4_0.tabSelectController_ = {
		ControllerUtil.GetController(arg_4_0.singleTab_.transform, "select"),
		(ControllerUtil.GetController(arg_4_0.multiTab_.transform, "select"))
	}
	arg_4_0.btnShowController_ = arg_4_0.btnController_:GetController("btn")
	arg_4_0.multiLockController_ = arg_4_0.multiLockCon_:GetController("lock")
	arg_4_0.singleLockController_ = arg_4_0.singleBtnCon_:GetController("grey")
end

function var_0_0.CheckIsOpenCooperation(arg_5_0)
	local var_5_0 = manager.time:GetServerHour()

	if var_5_0 < GameSetting.activity_water_online_open.value[1] or var_5_0 >= GameSetting.activity_water_online_open.value[2] then
		ShowTips("ACTIVITY_WATER_ONLINE_OPEN")

		return false
	end

	return true
end

function var_0_0.AddUIListeners(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.multiPlayBtn_, nil, function()
		if not arg_6_0:CheckIsOpenCooperation() then
			return
		end

		local var_7_0 = CooperationData:GetIsMatching()
		local var_7_1 = ActivitySummerWaterData:GetCurrentScheduleData()
		local var_7_2 = CooperationData:GetCooperationHero(BattleConst.STAGE_TYPE_NEW.ACTIVITY_WATER_COOPERATION, var_7_1.open_online_stage_id, arg_6_0.activityID_)

		if var_7_0 then
			CooperationAction.CancelMatching()
		else
			CooperationAction.StartMatching(var_7_1.open_online_stage_id, BattleConst.STAGE_TYPE_NEW.ACTIVITY_WATER_COOPERATION, {
				var_7_2
			}, arg_6_0.activityID_)
		end

		arg_6_0:ShowMatching()
	end)
	arg_6_0:AddBtnListener(arg_6_0.singlePlayBtn_, nil, function()
		local var_8_0 = ActivitySummerWaterData.GetCurrentScheduleData()

		if not arg_6_0.selectHero_ or arg_6_0.selectHero_ == 0 then
			ShowTips("ACTIVITY_WATER_NEED_SELECT_HERO")

			return
		end

		JumpTools.OpenPageByJump("/summerWaterSectionSelectHero", {
			section = var_8_0.open_stage_id,
			sectionType = BattleConst.STAGE_TYPE_NEW.ACTIVITY_SUMMER_WATER,
			activityID = arg_6_0.activityID_,
			mainActivityID = arg_6_0.activityID_
		})
	end)
	arg_6_0:AddBtnListener(arg_6_0.singleTab_, nil, function()
		arg_6_0:SelectTab(1)
	end)
	arg_6_0:AddBtnListener(arg_6_0.multiTab_, nil, function()
		arg_6_0:SelectTab(2)
	end)
	arg_6_0:AddBtnListener(arg_6_0.cancelBtn_, nil, function()
		arg_6_0:HideMatching()
	end)
	arg_6_0:AddBtnListener(arg_6_0.rewardBtn_, nil, function()
		local var_12_0 = {}
		local var_12_1 = AssignmentCfg.get_id_list_by_activity_id[arg_6_0.activityID_]

		for iter_12_0, iter_12_1 in ipairs(var_12_1) do
			if not table.indexof(var_12_0, iter_12_1) then
				table.insert(var_12_0, iter_12_1)
			end
		end

		JumpTools.OpenPageByJump("summerQuestRewardPop", {
			activityIDList = var_12_0
		})
	end)
	arg_6_0:AddBtnListener(arg_6_0.createRoomBtn_, nil, function()
		if not arg_6_0:CheckIsOpenCooperation() then
			return
		end

		if CooperationData:GetRoomData() then
			CooperationTools.GotoCooperation()
		else
			local var_13_0 = ActivitySummerWaterData.GetCurrentScheduleData()
			local var_13_1 = CooperationData:GetCooperationHero(BattleConst.STAGE_TYPE_NEW.ACTIVITY_WATER_COOPERATION, var_13_0.open_online_stage_id, arg_6_0.activityID_)

			CooperationAction.CreateRoom(var_13_0.open_online_stage_id, BattleConst.STAGE_TYPE_NEW.ACTIVITY_WATER_COOPERATION, {
				var_13_1
			}, arg_6_0.activityID_)
		end
	end)
	arg_6_0:AddBtnListener(arg_6_0.roleBtn1_, nil, function()
		arg_6_0:SelectHero(arg_6_0.singleHeroList_[1])
	end)
	arg_6_0:AddBtnListener(arg_6_0.roleBtn2_, nil, function()
		arg_6_0:SelectHero(arg_6_0.singleHeroList_[2])
	end)
	arg_6_0:AddBtnListener(nil, arg_6_0.searchBtn_, function()
		if not arg_6_0:CheckIsOpenCooperation() then
			return
		end

		JumpTools.OpenPageByJump("cooperationApply", {
			room_type = BattleConst.STAGE_TYPE_NEW.ACTIVITY_WATER_COOPERATION
		})
	end)
end

function var_0_0.OnEnter(arg_17_0)
	arg_17_0.activityID_ = ActivitySummerWaterData:GetActivityID()

	if not arg_17_0.activityID_ then
		ShowTips("TIME_OVER")
		ActivityTools.JumpBackToActivityMainViewByTheme(ActivityCfg[ActivitySummerWaterData:GetMainActivityID()].activity_theme)

		return
	end

	arg_17_0:SetActiveData()
	arg_17_0:RefreshBar()
	arg_17_0:SelectTab(arg_17_0.selectModel_)
	arg_17_0:AddTimer()
	arg_17_0:RefreshUI()
	arg_17_0:BindRedPoint()
end

function var_0_0.SetActiveData(arg_18_0)
	local var_18_0 = ActivityData:GetActivityData(arg_18_0.activityID_)

	arg_18_0.startTime_ = var_18_0.startTime
	arg_18_0.stopTime_ = var_18_0.stopTime
	arg_18_0.scheduleCfg_ = ActivitySummerWaterData:GetCurrentScheduleCfg()
	arg_18_0.singleHeroList_ = arg_18_0.scheduleCfg_.hero_id_list
	arg_18_0.multiHeroList_ = arg_18_0.scheduleCfg_.online_hero_id_list
	arg_18_0.selectHero_ = SummerWaterTools.GetSingleSelectHero()
	arg_18_0.selectModel_ = getData("SummerWater", "selectModel") or 1
end

function var_0_0.BindRedPoint(arg_19_0)
	manager.redPoint:bindUIandKey(arg_19_0.rewardBtn_.transform, RedPointConst.ACTIVITY_WATER_ASSIGNMENT)
	manager.redPoint:bindUIandKey(arg_19_0.multiTab_.transform, RedPointConst.ACTIVITY_WATER_MULTIPLE_OPEN)
end

function var_0_0.UnBindRedPoint(arg_20_0)
	manager.redPoint:unbindUIandKey(arg_20_0.rewardBtn_.transform, RedPointConst.ACTIVITY_WATER_ASSIGNMENT)
	manager.redPoint:unbindUIandKey(arg_20_0.multiTab_.transform, RedPointConst.ACTIVITY_WATER_MULTIPLE_OPEN)
end

function var_0_0.OnWaterResult(arg_21_0)
	arg_21_0:OnTop()
end

function var_0_0.OnTop(arg_22_0)
	arg_22_0.activityID_ = ActivitySummerWaterData:GetActivityID()

	if not arg_22_0.activityID_ then
		ShowTips("TIME_OVER")
		ActivityTools.JumpBackToActivityMainViewByTheme(ActivityCfg[ActivitySummerWaterData:GetMainActivityID()].activity_theme)

		return
	end

	arg_22_0:RefreshBar()

	local var_22_0 = ActivityData:GetActivityData(arg_22_0.activityID_)

	arg_22_0.startTime_ = var_22_0.startTime
	arg_22_0.stopTime_ = var_22_0.stopTime
	arg_22_0.scheduleCfg_ = ActivitySummerWaterData:GetCurrentScheduleCfg()
	arg_22_0.singleHeroList_ = arg_22_0.scheduleCfg_.hero_id_list
	arg_22_0.multiHeroList_ = arg_22_0.scheduleCfg_.online_hero_id_list
	arg_22_0.selectHero_ = SummerWaterTools.GetSingleSelectHero()

	arg_22_0:SelectTab(arg_22_0.selectModel_)
	arg_22_0:AddTimer()
	arg_22_0:RefreshUI()
end

function var_0_0.RefreshBar(arg_23_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		INVITE_BAR,
		arg_23_0.scheduleCfg_.assistance_coin_id
	})
	manager.windowBar:SetBarCanAdd(arg_23_0.scheduleCfg_.assistance_coin_id, true)
	manager.windowBar:SetGameHelpKey("ACTIVITY_SWIMSUIT_EXPLAIN_WATER")
	manager.windowBar:RegistBackCallBack(function()
		ActivityTools.JumpBackToActivityMainViewByTheme(ActivityCfg[ActivitySummerWaterData:GetMainActivityID()].activity_theme)
	end)
end

function var_0_0.SelectTab(arg_25_0, arg_25_1)
	arg_25_0.selectModel_ = arg_25_1

	if arg_25_1 == 2 then
		saveData("Activity_Water", "time", manager.time:GetServerTime())
		ActivityWaterAction.UpdateCooperationRedPoint()
	end

	for iter_25_0, iter_25_1 in ipairs(arg_25_0.tabSelectController_) do
		iter_25_1:SetSelectedState(tostring(iter_25_0 == arg_25_1))
	end

	arg_25_0.modelShowController_:SetSelectedIndex(arg_25_1 - 1)

	if arg_25_0.selectModel_ == 1 then
		arg_25_0:RefreshRoleController()
	elseif arg_25_0.selectModel_ == 2 then
		arg_25_0:RefreshMultiController()
	end

	arg_25_0.btnShowController_:SetSelectedIndex(arg_25_1 - 1)
end

function var_0_0.RefreshMultiController(arg_26_0)
	local var_26_0 = true
	local var_26_1 = manager.time:GetServerHour()

	if var_26_1 < GameSetting.activity_water_online_open.value[1] or var_26_1 >= GameSetting.activity_water_online_open.value[2] then
		var_26_0 = false
	end

	arg_26_0.multiLockController_:SetSelectedState(tostring(not var_26_0))
end

function var_0_0.SelectHero(arg_27_0, arg_27_1)
	if arg_27_0.selectHero_ == arg_27_1 then
		return
	end

	arg_27_0.selectHero_ = arg_27_1

	SummerWaterTools.SetSingleSelectHero(arg_27_1)
	arg_27_0:RefreshRoleController()
end

function var_0_0.RefreshRoleController(arg_28_0)
	arg_28_0.singleSelectShowController_:SetSelectedIndex(0)
	arg_28_0.singleLockController_:SetSelectedState("true")

	for iter_28_0, iter_28_1 in ipairs(arg_28_0.singleHeroList_) do
		if arg_28_0.selectHero_ == iter_28_1 then
			arg_28_0.singleSelectShowController_:SetSelectedIndex(iter_28_0)
			arg_28_0.singleLockController_:SetSelectedState("false")
		end
	end
end

function var_0_0.RefreshUI(arg_29_0)
	if manager.time:GetServerTime() >= arg_29_0.stopTime_ then
		ShowTips("TIME_OVER")
		ActivityTools.JumpBackToActivityMainViewByTheme(ActivityCfg[ActivitySummerWaterData:GetMainActivityID()].activity_theme)
	end

	arg_29_0.roleImg1_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. HeroStandardSystemCfg[arg_29_0.singleHeroList_[1]].hero_id)
	arg_29_0.roleImg2_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. HeroStandardSystemCfg[arg_29_0.singleHeroList_[2]].hero_id)

	local var_29_0 = ActivitySummerWaterData:GetTotalGainCurrenyNum() .. "/" .. arg_29_0.scheduleCfg_.voting_ticket_limit

	arg_29_0.singleGetNumText_.text = var_29_0
	arg_29_0.multiGetNumText_.text = var_29_0
end

function var_0_0.AddTimer(arg_30_0)
	arg_30_0:StopTimer()
	arg_30_0:RefreshTimeText()

	local var_30_0 = ActivityData:GetActivityData(ActivitySummerWaterData:GetMainActivityID()).stopTime

	arg_30_0.timer_ = Timer.New(function()
		if manager.time:GetServerTime() > var_30_0 then
			return
		end

		arg_30_0:RefreshMultiController()
		arg_30_0:RefreshTimeText()
	end, 1, -1)

	arg_30_0.timer_:Start()
end

function var_0_0.RefreshTimeText(arg_32_0)
	local var_32_0 = ActivityData:GetActivityData(ActivitySummerWaterData:GetMainActivityID()).stopTime

	if arg_32_0.timeText_ then
		arg_32_0.timeText_.text = GetTips("REMAINING_TIME") .. manager.time:GetLostTimeStrWith2Unit(var_32_0, true)
	end
end

function var_0_0.OnExit(arg_33_0)
	arg_33_0:StopTimer()
	manager.windowBar:HideBar()
	arg_33_0:HideMatching()
	arg_33_0:UnBindRedPoint()
	saveData("SummerWater", "selectModel", arg_33_0.selectModel_)
end

function var_0_0.StopTimer(arg_34_0)
	if arg_34_0.timer_ then
		arg_34_0.timer_:Stop()

		arg_34_0.timer_ = nil
	end
end

function var_0_0.IsActivityTime(arg_35_0)
	if manager.time:GetServerTime() < arg_35_0.startTime_ then
		local var_35_0 = GetTips("OPEN_TIME")

		ShowTips(string.format(var_35_0, manager.time:GetLostTimeStrWith2Unit(arg_35_0.startTime_, true)))

		return false
	end

	if manager.time:GetServerTime() >= arg_35_0.stopTime_ then
		ShowTips("TIME_OVER")

		return false
	end

	return true
end

function var_0_0.ShowMatching(arg_36_0)
	SetActive(arg_36_0.popGo_, true)

	arg_36_0.curMatchingSeconds_ = 0
	arg_36_0.secondLabel_.text = string.format(GetTips("ACTIVITY_WATER_MATCHING"), arg_36_0.curMatchingSeconds_ .. "s")

	if arg_36_0.matchingTimer_ == nil then
		arg_36_0.matchingTimer_ = Timer.New(function()
			arg_36_0:OnMatchingTimer()
		end, 1, -1)
	end

	arg_36_0.matchingTimer_:Start()
end

function var_0_0.HideMatching(arg_38_0)
	if arg_38_0.matchingTimer_ then
		arg_38_0.matchingTimer_:Stop()

		arg_38_0.matchingTimer_ = nil
	end

	arg_38_0.curMatchingSeconds_ = 0

	CooperationAction.CancelMatching()
	SetActive(arg_38_0.popGo_, false)
end

function var_0_0.OnMatchingTimer(arg_39_0)
	arg_39_0.curMatchingSeconds_ = arg_39_0.curMatchingSeconds_ + 1
	arg_39_0.secondLabel_.text = string.format(GetTips("ACTIVITY_WATER_MATCHING"), arg_39_0.curMatchingSeconds_ .. "s")
end

return var_0_0
