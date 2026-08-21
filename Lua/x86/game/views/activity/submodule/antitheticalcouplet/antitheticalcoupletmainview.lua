local var_0_0 = class("AntitheticalCoupletMainView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return AntitheticalCoupletTools.GetMainUIName(arg_1_0.params_.activityID)
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

	arg_4_0.levelData_ = {}
	arg_4_0.rewardList_ = {}
	arg_4_0.levelList_ = ActivityCfg[arg_4_0.params_.activityID].sub_activity_list or {}
	arg_4_0.toggles_ = {}
	arg_4_0.tglLock_ = {}
	arg_4_0.toggleCon_ = {}
	arg_4_0.cToggleCon_ = {}
	arg_4_0.toggleTime_ = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_0.levelList_) do
		arg_4_0.toggles_[iter_4_0] = arg_4_0["tgl_" .. iter_4_0]
		arg_4_0.tglLock_[iter_4_0] = arg_4_0["lock_" .. iter_4_0]
		arg_4_0.toggleCon_[iter_4_0] = ControllerUtil.GetController(arg_4_0.toggles_[iter_4_0].transform, "state")
		arg_4_0.cToggleCon_[iter_4_0] = ControllerUtil.GetController(arg_4_0.toggles_[iter_4_0].transform, "toggle")
		arg_4_0.toggleTime_[iter_4_0] = arg_4_0["tglTime_" .. iter_4_0]
	end

	arg_4_0.rewardCon_ = ControllerUtil.GetController(arg_4_0.gameObject_.transform, "reward")
	arg_4_0.stateCon_ = ControllerUtil.GetController(arg_4_0.gameObject_.transform, "state")
	arg_4_0.titleCon_ = ControllerUtil.GetController(arg_4_0.gameObject_.transform, "title")
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.rewardBtn_, nil, function()
		if ActivityData:GetActivityData(arg_5_0.curId_):IsActivitying() then
			AntitheticalCoupletAction:GetReward(arg_5_0.curId_)
		else
			ShowTips("TIME_OVER")
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.goBtn_, nil, function()
		local var_7_0 = table.indexof(arg_5_0.levelList_, arg_5_0.curId_)
		local var_7_1 = manager.time:GetServerTime()
		local var_7_2 = arg_5_0.levelData_[var_7_0]

		if var_7_1 >= var_7_2.startTime and var_7_1 < var_7_2.stopTime then
			local var_7_3 = ActivitySpringFestivalCoupletsCfg[arg_5_0.curId_].story_id

			manager.story:StartStoryById(var_7_3, function(arg_8_0)
				JumpTools.OpenPageByJump("/antitheticalCoupletResult", {
					activityID = arg_5_0.activityID_,
					id = arg_5_0.curId_
				})
			end, true)
		elseif var_7_1 >= var_7_2.stopTime then
			ShowTips("TIME_OVER")
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.reviewBtn_, nil, function()
		local var_9_0 = table.indexof(arg_5_0.levelList_, arg_5_0.curId_)
		local var_9_1 = manager.time:GetServerTime()
		local var_9_2 = arg_5_0.levelData_[var_9_0]

		if var_9_1 >= var_9_2.startTime and var_9_1 < var_9_2.stopTime then
			JumpTools.OpenPageByJump("/antitheticalCoupletResult", {
				isComplet = true,
				activityID = arg_5_0.activityID_,
				id = arg_5_0.curId_
			})
		elseif var_9_1 >= var_9_2.stopTime then
			ShowTips("TIME_OVER")
		end
	end)

	for iter_5_0, iter_5_1 in ipairs(arg_5_0.toggles_) do
		arg_5_0:AddToggleListener(iter_5_1, function(arg_10_0)
			if arg_10_0 then
				arg_5_0.curId_ = arg_5_0.levelList_[iter_5_0]

				arg_5_0:RefreshReward()
				AntitheticalCoupletData:SetOpen(arg_5_0.levelList_[iter_5_0])
			end
		end)
		arg_5_0:AddBtnListener(arg_5_0.tglLock_[iter_5_0], nil, function()
			local var_11_0 = manager.time:GetServerTime()
			local var_11_1 = arg_5_0.levelData_[iter_5_0].startTime

			if var_11_0 < var_11_1 then
				ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(var_11_1)))
			end
		end)
	end
end

function var_0_0.OnEnter(arg_12_0)
	arg_12_0:BindUIRedPoint()
	arg_12_0:RefreshData()
	arg_12_0:RefreshUI()
end

function var_0_0.RefreshData(arg_13_0)
	arg_13_0.activityID_ = arg_13_0.params_.activityID
	arg_13_0.activityData_ = ActivityData:GetActivityData(arg_13_0.activityID_)
	arg_13_0.startTime_ = arg_13_0.activityData_.startTime
	arg_13_0.stopTime_ = arg_13_0.activityData_.stopTime

	for iter_13_0, iter_13_1 in ipairs(arg_13_0.levelList_) do
		arg_13_0.levelData_[iter_13_0] = ActivityData:GetActivityData(iter_13_1)
	end
end

function var_0_0.RefreshUI(arg_14_0)
	arg_14_0:RefreshTime()
	arg_14_0:RefreshList()
	arg_14_0:RefreshReward()
end

function var_0_0.RefreshTime(arg_15_0)
	local var_15_0
	local var_15_1 = manager.time:GetServerTime()

	arg_15_0:StopTimer()
	arg_15_0:RefreshLevelTime()

	if var_15_1 < arg_15_0.startTime_ then
		arg_15_0.timeTxt_.text = GetTips("SOLO_NOT_OPEN")
		arg_15_0.timer_ = Timer.New(function()
			var_15_0 = arg_15_0.startTime_ - manager.time:GetServerTime()

			arg_15_0:RefreshLevelTime()

			if var_15_0 <= 0 then
				arg_15_0:StopTimer()
				arg_15_0:RefreshTime()

				return
			end
		end, 1, -1)

		arg_15_0.timer_:Start()
	elseif var_15_1 < arg_15_0.stopTime_ then
		arg_15_0.timeTxt_.text = manager.time:GetLostTimeStr(arg_15_0.stopTime_)
		arg_15_0.timer_ = Timer.New(function()
			var_15_0 = arg_15_0.stopTime_ - manager.time:GetServerTime()

			arg_15_0:RefreshLevelTime()

			if var_15_0 <= 0 then
				arg_15_0:StopTimer()
				arg_15_0:RefreshTime()

				return
			end

			arg_15_0.timeTxt_.text = manager.time:GetLostTimeStr(arg_15_0.stopTime_)
		end, 1, -1)

		arg_15_0.timer_:Start()
	else
		arg_15_0.timeTxt_.text = GetTips("TIME_OVER")
	end
end

function var_0_0.RefreshLevelTime(arg_18_0)
	local var_18_0 = manager.time:GetServerTime()

	for iter_18_0, iter_18_1 in ipairs(arg_18_0.levelList_) do
		local var_18_1 = arg_18_0.levelData_[iter_18_0].startTime

		if var_18_0 < var_18_1 then
			arg_18_0.toggles_[iter_18_0].interactable = false

			arg_18_0.toggleCon_[iter_18_0]:SetSelectedState("lock")

			arg_18_0.toggleTime_[iter_18_0].text = string.format(GetTips("UNLOCK"), manager.time:GetLostTimeStr(var_18_1))
		else
			arg_18_0.toggles_[iter_18_0].interactable = true

			local var_18_2 = AntitheticalCoupletData:GetData(arg_18_0.levelList_[iter_18_0])

			if var_18_2 and var_18_2.chooseID ~= 0 then
				arg_18_0.toggleCon_[iter_18_0]:SetSelectedState("complete")
			else
				arg_18_0.toggleCon_[iter_18_0]:SetSelectedState("nor")
			end
		end
	end
end

function var_0_0.RefreshList(arg_19_0)
	arg_19_0.curId_ = AntitheticalCoupletData:GetLastLevel(arg_19_0.activityID_) or arg_19_0.levelList_[1]

	local var_19_0 = table.indexof(arg_19_0.levelList_, arg_19_0.curId_)

	arg_19_0.toggles_[var_19_0].isOn = true

	AntitheticalCoupletData:SetOpen(arg_19_0.levelList_[var_19_0])
end

function var_0_0.RefreshReward(arg_20_0)
	local var_20_0 = ActivitySpringFestivalCoupletsCfg[arg_20_0.curId_]

	arg_20_0.desc_.text = GetI18NText(var_20_0.desc)

	local var_20_1 = table.indexof(arg_20_0.levelList_, arg_20_0.curId_)

	arg_20_0.titleCon_:SetSelectedState(var_20_1)

	local var_20_2 = var_20_0.reward_item_list

	for iter_20_0, iter_20_1 in ipairs(var_20_2) do
		if arg_20_0.rewardList_[iter_20_0] then
			arg_20_0.rewardList_[iter_20_0]:SetData(iter_20_1)
		else
			arg_20_0.rewardList_[iter_20_0] = RewardPoolItem.New(arg_20_0.rewardPanel_, iter_20_1, true, POP_SOURCE_ITEM)
		end
	end

	for iter_20_2 = #var_20_2 + 1, #arg_20_0.rewardList_ do
		arg_20_0.rewardList_[iter_20_2]:Show(false)
	end

	arg_20_0.curData_ = AntitheticalCoupletData:GetData(arg_20_0.curId_)

	arg_20_0:RefreshRewardType()
	arg_20_0:RefreshStateType()
end

function var_0_0.RefreshRewardType(arg_21_0)
	if arg_21_0.curData_ and arg_21_0.curData_.isReward then
		arg_21_0.rewardCon_:SetSelectedState("finish")
	elseif arg_21_0.curData_ and arg_21_0.curData_.chooseID ~= 0 then
		arg_21_0.rewardCon_:SetSelectedState("complete")
	else
		arg_21_0.rewardCon_:SetSelectedState("false")
	end
end

function var_0_0.RefreshStateType(arg_22_0)
	if arg_22_0.curData_ and arg_22_0.curData_.chooseID ~= 0 then
		arg_22_0.stateCon_:SetSelectedState("true")
	else
		arg_22_0.stateCon_:SetSelectedState("false")
	end
end

function var_0_0.StopTimer(arg_23_0)
	if arg_23_0.timer_ then
		arg_23_0.timer_:Stop()

		arg_23_0.timer_ = nil
	end
end

function var_0_0.BindUIRedPoint(arg_24_0)
	for iter_24_0, iter_24_1 in ipairs(arg_24_0.levelList_) do
		manager.redPoint:bindUIandKey(arg_24_0["tglPos_" .. iter_24_0], RedPointConst.ANTITHETICAL_COUPLET .. "_" .. iter_24_1, {
			x = 0,
			y = 0
		})
	end
end

function var_0_0.UnBindUIRedPoint(arg_25_0)
	for iter_25_0, iter_25_1 in ipairs(arg_25_0.levelList_) do
		manager.redPoint:unbindUIandKey(arg_25_0["tglPos_" .. iter_25_0], RedPointConst.ANTITHETICAL_COUPLET .. "_" .. iter_25_1)
	end
end

function var_0_0.OnAntitheticalCoupletReward(arg_26_0)
	arg_26_0:RefreshRewardType()
end

function var_0_0.OnTop(arg_27_0)
	local var_27_0 = AntitheticalCoupletTools.GetGameHelpKey(arg_27_0.activityID_)

	if var_27_0 ~= "" then
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR,
			INFO_BAR
		})
		manager.windowBar:SetGameHelpKey(var_27_0)
	else
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR
		})
	end
end

function var_0_0.OnExit(arg_28_0)
	arg_28_0:StopTimer()
	arg_28_0:UnBindUIRedPoint()
	manager.windowBar:HideBar()
	AntitheticalCoupletData:SaveLastSelect(arg_28_0.activityID_, arg_28_0.curId_)
end

function var_0_0.Dispose(arg_29_0)
	arg_29_0:RemoveAllListeners()
	arg_29_0.super.Dispose(arg_29_0)
end

return var_0_0
