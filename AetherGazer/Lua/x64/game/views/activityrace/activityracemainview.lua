local var_0_0 = class("ActivityRaceMainView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VolumeIIIDownUI/ActivityRace/ActivityRaceMainUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()

	arg_3_0.switchItemList_ = {}

	local var_3_0 = arg_3_0.switchPanelTrans_.childCount
	local var_3_1

	for iter_3_0 = 1, var_3_0 do
		local var_3_2 = arg_3_0.switchPanelTrans_:GetChild(iter_3_0 - 1).gameObject

		arg_3_0.switchItemList_[iter_3_0] = ActivityRaceSwitchItem.New(var_3_2)
	end
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.shopBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_5_0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		local var_6_0 = ActivityShopCfg[arg_5_0.activityID_]
		local var_6_1 = {}

		for iter_6_0, iter_6_1 in ipairs(ActivityShopCfg.get_id_list_by_activity_theme[var_6_0.activity_theme]) do
			table.insert(var_6_1, ActivityShopCfg[iter_6_1].shop_id)
		end

		local var_6_2, var_6_3 = ShopTools.IsShopOpen(var_6_0.shop_id)

		if var_6_2 then
			JumpTools.GoToSystem("/shop", {
				shopId = var_6_0.shop_id,
				showShops = var_6_1
			}, ViewConst.SYSTEM_ID.SHOP)
		elseif var_6_3 == 2 then
			ShowTips("SHOP_EXPIRED")
		elseif var_6_3 == 3 then
			ShowTips("SHOP_NOT_OPEN")
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.rewardBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_5_0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		JumpTools.OpenPageByJump("activityRaceRewardPanel", {
			activityID = arg_5_0.activityID_
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.rankBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_5_0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		arg_5_0:Go("/activityRaceRank", {
			activityID = arg_5_0.rankID_
		})
	end)
end

function var_0_0.OnEnter(arg_9_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_RACE_DESCRIPE")

	arg_9_0.activityID_ = arg_9_0.params_.activityID
	arg_9_0.rankID_ = arg_9_0.params_.rankID
	arg_9_0.stopTime_ = ActivityData:GetActivityData(arg_9_0.activityID_).stopTime

	arg_9_0:RegisterRedPoint()
	arg_9_0:RefreshUI()
	arg_9_0:AddTimer()
end

function var_0_0.OnExit(arg_10_0)
	manager.windowBar:HideBar()

	for iter_10_0, iter_10_1 in ipairs(arg_10_0.switchItemList_) do
		iter_10_1:OnExit()
	end

	arg_10_0:UnRegisterRedPoint()
	arg_10_0:StopTimer()
end

function var_0_0.Dispose(arg_11_0)
	for iter_11_0, iter_11_1 in ipairs(arg_11_0.switchItemList_) do
		iter_11_1:Dispose()
	end

	var_0_0.super.Dispose(arg_11_0)
end

function var_0_0.RefreshUI(arg_12_0)
	arg_12_0.subActivityList_ = ActivityCfg[arg_12_0.activityID_].sub_activity_list

	for iter_12_0, iter_12_1 in ipairs(arg_12_0.switchItemList_) do
		iter_12_1:SetData(arg_12_0.activityID_, arg_12_0.subActivityList_[iter_12_0])
	end

	arg_12_0:RefreshDesc()

	arg_12_0.scoreText_.text = ActivityRaceData:GetTotalScore(arg_12_0.activityID_) or 0
end

function var_0_0.RefreshDesc(arg_13_0)
	arg_13_0.descText_.text = GetTips("ACTIVITY_RACE_CONTENT")
end

function var_0_0.AddTimer(arg_14_0)
	arg_14_0.remainTimeText_.text = manager.time:GetLostTimeStr(arg_14_0.stopTime_)
	arg_14_0.timer_ = Timer.New(function()
		if manager.time:GetServerTime() >= arg_14_0.stopTime_ then
			arg_14_0:StopTimer()

			arg_14_0.remainTimeText_.text = GetTips("TIME_OVER")

			return
		end

		for iter_15_0, iter_15_1 in ipairs(arg_14_0.switchItemList_) do
			iter_15_1:RefreshLock()
		end

		arg_14_0.remainTimeText_.text = manager.time:GetLostTimeStr(arg_14_0.stopTime_)
	end, 1, -1)

	arg_14_0.timer_:Start()
end

function var_0_0.StopTimer(arg_16_0)
	if arg_16_0.timer_ then
		arg_16_0.timer_:Stop()

		arg_16_0.timer_ = nil
	end
end

function var_0_0.RegisterRedPoint(arg_17_0)
	manager.redPoint:bindUIandKey(arg_17_0.rewardBtnTrans_, string.format("%s_%s_reward", RedPointConst.ACTIVITY_RACE, arg_17_0.activityID_))
end

function var_0_0.UnRegisterRedPoint(arg_18_0)
	manager.redPoint:unbindUIandKey(arg_18_0.rewardBtnTrans_, string.format("%s_%s_reward", RedPointConst.ACTIVITY_RACE, arg_18_0.activityID_))
end

return var_0_0
