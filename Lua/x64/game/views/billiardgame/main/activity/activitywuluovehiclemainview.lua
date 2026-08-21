local var_0_0 = class("ActivityWuluoVehicleMainView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_WuLuo/Activity_WuLuo_Main/Activity_WuLuo_HomeUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListner()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.bubbleController_ = arg_4_0.transCon_:GetController("bubble")
	arg_4_0.tabSelectControllerList_ = {}
	arg_4_0.tabLockControllerList_ = {}

	for iter_4_0 = 1, BilliardGameConst.StageCount do
		arg_4_0.tabSelectControllerList_[iter_4_0] = arg_4_0["tabCon_" .. iter_4_0]:GetController("select")
		arg_4_0.tabLockControllerList_[iter_4_0] = arg_4_0["tabCon_" .. iter_4_0]:GetController("lock")
	end

	arg_4_0.refreshVehicleHandler_ = handler(arg_4_0, arg_4_0.RefreshVehicle)
end

function var_0_0.AddUIListner(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.taskBtn_, nil, function()
		JumpTools.OpenPageByJump("/activityWuluoVehicleTaskView")
	end)
	arg_5_0:AddBtnListener(arg_5_0.illuBtn_, nil, function()
		JumpTools.OpenPageByJump("activityWuluoVehicleIllustratePopView")
	end)
	arg_5_0:AddBtnListener(arg_5_0.ballInfoBtn_, nil, function()
		JumpTools.OpenPageByJump("activityWuluoVehicleInfoPopView")
	end)
	arg_5_0:AddBtnListener(arg_5_0.goBtn_, nil, function()
		if arg_5_0.selectedStageCfg_ then
			LaunchBilliardGame_5_1(arg_5_0.selectedStageCfg_.id, arg_5_0.selectedVehicleId_)
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.rewardBtn_, nil, function()
		JumpTools.OpenPageByJump("/activityWuluoVehicleLimitTaskView", {
			activityID = ActivityConst.ACTIVITY_WULO_VEHICLE_BALL_LIMITED_TASK
		})
	end)

	for iter_5_0 = 1, BilliardGameConst.StageCount do
		arg_5_0:AddBtnListener(arg_5_0["tabBtn_" .. iter_5_0], nil, function()
			arg_5_0:OnSelectTab(iter_5_0)
		end)
	end
end

function var_0_0.OnEnter(arg_12_0)
	arg_12_0:RefreshView()
	arg_12_0:RefreshRewardTime()
	arg_12_0:OnSelectTab(#arg_12_0.openStageList_)
	arg_12_0:RefreshVehicle()
	arg_12_0:RegistEventListener(WULUO_SELECT_VEHICLE_UPDATE, arg_12_0.refreshVehicleHandler_)
	arg_12_0:BindRedPoint()
	arg_12_0:CheckPopView()
	arg_12_0:ShowBubbleTips()
end

function var_0_0.OnTop(arg_13_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.BindRedPoint(arg_14_0)
	manager.redPoint:bindUIandKey(arg_14_0.illuBtn_.transform, RedPointConst.WULO_ILLUSTRATE)
	manager.redPoint:bindUIandKey(arg_14_0.rewardBtn_.transform, RedPointConst.WULO_VEHICLE_BALL_LIMITED_TASK .. ActivityConst.ACTIVITY_WULO_VEHICLE_BALL_LIMITED_TASK)
	manager.redPoint:bindUIandKey(arg_14_0.taskBtn_.transform, RedPointConst.WULO_VEHICLE_BALL_RESIDENT_TASK .. ActivityConst.ACTIVITY_WULO_VEHICLE_BALL_MAIN)
end

function var_0_0.UnBindRedPoint(arg_15_0)
	manager.redPoint:unbindUIandKey(arg_15_0.illuBtn_.transform, RedPointConst.WULO_ILLUSTRATE)
	manager.redPoint:unbindUIandKey(arg_15_0.rewardBtn_.transform, RedPointConst.WULO_VEHICLE_BALL_LIMITED_TASK .. ActivityConst.ACTIVITY_WULO_VEHICLE_BALL_LIMITED_TASK)
	manager.redPoint:unbindUIandKey(arg_15_0.taskBtn_.transform, RedPointConst.WULO_VEHICLE_BALL_RESIDENT_TASK .. ActivityConst.ACTIVITY_WULO_VEHICLE_BALL_MAIN)
end

function var_0_0.RefreshView(arg_16_0)
	arg_16_0.openStageList_ = VehicleBallData:GetOpenStageList()
	arg_16_0.isLockList_ = {}

	for iter_16_0 = 1, BilliardGameConst.StageCount do
		arg_16_0.isLockList_[iter_16_0] = table.indexof(arg_16_0.openStageList_, MergeBallStageCfg.all[iter_16_0]) == false

		arg_16_0.tabLockControllerList_[iter_16_0]:SetSelectedIndex(arg_16_0.isLockList_[iter_16_0] and 1 or 0)
	end

	local var_16_0 = 0
	local var_16_1 = AssignmentCfg.get_id_list_by_activity_id[ActivityConst.ACTIVITY_WULO_VEHICLE_BALL_MAIN]

	for iter_16_1, iter_16_2 in ipairs(var_16_1) do
		if TaskData2:GetTaskComplete(iter_16_2) then
			var_16_0 = var_16_0 + 1
		end
	end

	arg_16_0.receivedTaskNumText_.text = string.format("%d/%d", var_16_0, #var_16_1)
end

function var_0_0.RefreshRewardTime(arg_17_0)
	local var_17_0 = ActivityData:GetActivityData(ActivityConst.ACTIVITY_WULO_VEHICLE_BALL_LIMITED_TASK)

	arg_17_0.limitTimeTxt_.text = manager.time:GetLostTimeStr2(var_17_0.stopTime)

	SetActive(arg_17_0.rewardBtn_.gameObject, ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_WULO_VEHICLE_BALL_LIMITED_TASK))

	if arg_17_0.limittimer_ == nil then
		arg_17_0.limittimer_ = Timer.New(function()
			if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_WULO_VEHICLE_BALL_LIMITED_TASK) then
				arg_17_0.limitTimeTxt_.text = manager.time:GetLostTimeStr2(var_17_0.stopTime)
			else
				SetActive(arg_17_0.rewardBtn_.gameObject, false)
				arg_17_0:LimitStopTimer()
			end
		end, 1, -1)
	end

	arg_17_0.limittimer_:Start()
end

function var_0_0.LimitStopTimer(arg_19_0)
	if arg_19_0.limittimer_ then
		arg_19_0.limittimer_:Stop()

		arg_19_0.limittimer_ = nil
	end
end

function var_0_0.OnSelectTab(arg_20_0, arg_20_1)
	if arg_20_0.isLockList_[arg_20_1] then
		ShowTips("MERGE_BALL_STAGE_LOCKED")

		return
	end

	if arg_20_0.selectedTabIndex_ ~= nil then
		arg_20_0.tabSelectControllerList_[arg_20_0.selectedTabIndex_]:SetSelectedIndex(0)
	end

	arg_20_0.selectedTabIndex_ = arg_20_1

	arg_20_0.tabSelectControllerList_[arg_20_1]:SetSelectedIndex(1)

	arg_20_0.selectedStageCfg_ = MergeBallStageCfg[MergeBallStageCfg.all[arg_20_1]]
	arg_20_0.titleText_.text = arg_20_0.selectedStageCfg_.name
	arg_20_0.descText_.text = arg_20_0.selectedStageCfg_.desc
end

function var_0_0.RefreshVehicle(arg_21_0)
	arg_21_0.selectedVehicleId_ = VehicleBallData:GetSelectedVehicleId()

	local var_21_0 = MergeBallVehicleCfg[arg_21_0.selectedVehicleId_]

	if var_21_0 then
		arg_21_0.vehicleIcon_.sprite = pureGetSpriteWithoutAtlas(var_21_0.icon)
	end
end

function var_0_0.CheckPopView(arg_22_0)
	local var_22_0 = VehicleBallData:GetLastPassedStage()

	if var_22_0 ~= 0 and not getData("BilliardVehicle", "billiardVehiclePop" .. var_22_0) then
		SetActive(arg_22_0.blockGo_, true)

		arg_22_0.popTimer_ = Timer.New(function()
			local var_23_0 = BilliardGameConst.ShowPopView[var_22_0]

			if var_23_0 then
				if var_23_0[1] == BilliardGameConst.VehicleType.VEHICLE then
					JumpTools.OpenPageByJump("activityWuluoVehicleUnlockPopView", {
						vehicleID = var_23_0[2]
					})
				else
					JumpTools.OpenPageByJump("activityWuluoBuffUnlockPopView", {
						buffIDList = var_23_0[2]
					})
				end

				saveData("BilliardVehicle", "billiardVehiclePop" .. var_22_0, true)
			end

			SetActive(arg_22_0.blockGo_, false)
		end, 1, 1)

		arg_22_0.popTimer_:Start()
	end
end

function var_0_0.ShowBubbleTips(arg_24_0)
	local var_24_0 = GameSetting.mergeball_home_bubble_cd.value[1]
	local var_24_1 = GameSetting.mergeball_home_bubble_cd.value[2]
	local var_24_2 = GameSetting.mergeball_home_bubble_tips.value

	arg_24_0.bubbleCG_.alpha = 0

	if type(var_24_2) ~= "table" or #var_24_2 == 0 or var_24_0 <= 0 then
		return
	end

	local function var_24_3()
		if type(var_24_2) ~= "table" or #var_24_2 == 0 then
			return
		end

		local var_25_0 = math.random(#var_24_2)

		if #var_24_2 > 1 then
			while var_25_0 == arg_24_0.bubbleTipIndex_ do
				var_25_0 = math.random(#var_24_2)
			end
		end

		arg_24_0.bubbleTipIndex_ = var_25_0
		arg_24_0.bubbleText_.text = GetTips(var_24_2[var_25_0])

		arg_24_0.bubbleAnim_:Play("show")
	end

	local function var_24_4()
		var_24_3()

		arg_24_0.bubbleTimer_ = Timer.New(function()
			arg_24_0.bubbleAnim_:Play("exit")

			arg_24_0.bubbleHideTimer_ = Timer.New(function()
				var_24_4()
			end, var_24_1, 1)

			arg_24_0.bubbleHideTimer_:Start()
		end, var_24_0, 1)

		arg_24_0.bubbleTimer_:Start()
	end

	var_24_4()
end

function var_0_0.OnExit(arg_29_0)
	arg_29_0:LimitStopTimer()

	if arg_29_0.bubbleTimer_ then
		arg_29_0.bubbleTimer_:Stop()

		arg_29_0.bubbleTimer_ = nil
	end

	if arg_29_0.bubbleHideTimer_ then
		arg_29_0.bubbleHideTimer_:Stop()

		arg_29_0.bubbleHideTimer_ = nil
	end

	arg_29_0.bubbleCG_.alpha = 0

	arg_29_0:UnBindRedPoint()
	arg_29_0:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_30_0)
	var_0_0.super.Dispose(arg_30_0)
end

return var_0_0
