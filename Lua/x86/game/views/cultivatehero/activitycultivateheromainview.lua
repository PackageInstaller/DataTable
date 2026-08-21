local var_0_0 = class("ActivityCultivateHeroMainView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = Asset.Load(arg_1_0:UIName(arg_1_2))

	arg_1_0.gameObject_ = Object.Instantiate(var_1_0, arg_1_1.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.activityID_ = arg_1_2

	arg_1_0:Init()
end

function var_0_0.UIName(arg_2_0, arg_2_1)
	return CultivateHeroTools.GetMainUIName(arg_2_1)
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.roleImage_.immediate = true

	arg_3_0:AddListeners()

	arg_3_0.switchItemList_ = LuaList.New(handler(arg_3_0, arg_3_0.IndexItem), arg_3_0.switchListGo_, arg_3_0:GetSwitchItemClass())
	arg_3_0.heroTaskList_ = LuaList.New(handler(arg_3_0, arg_3_0.IndexHeroTask), arg_3_0.heroTaskListGo_, arg_3_0:GetHeroTaskClass())
	arg_3_0.accumulateRewardList_ = {}
	arg_3_0.itemDataList_ = {}
	arg_3_0.clickSwitchItemHandler_ = handler(arg_3_0, arg_3_0.OnClickSwitchItem)
	arg_3_0.receivedHeroTaskHandler_ = handler(arg_3_0, arg_3_0.OnReceiveHeroTask)

	arg_3_0:InitController()
end

function var_0_0.InitController(arg_4_0)
	arg_4_0.accumulateRewardState_ = ControllerUtil.GetController(arg_4_0.transform_, "accumulateRewardState")
	arg_4_0.dailyRewardState_ = ControllerUtil.GetController(arg_4_0.transform_, "dailyRewardState")
	arg_4_0.allReceiveBtnState_ = ControllerUtil.GetController(arg_4_0.transform_, "allReceive")
	arg_4_0.heroLockState_ = ControllerUtil.GetController(arg_4_0.transform_, "heroLock")
end

function var_0_0.UpdateBar(arg_5_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnEnter(arg_6_0)
	arg_6_0.stopTime_ = ActivityData:GetActivityData(arg_6_0.activityID_).stopTime

	arg_6_0:AddTimer()
	arg_6_0:BindRedPoint()
	arg_6_0:MoveSwitchItemInView()
end

function var_0_0.MoveSwitchItemInView(arg_7_0)
	if not arg_7_0.heroList_ or not arg_7_0.selectHeroID_ then
		return
	end

	local var_7_0 = table.indexof(arg_7_0.heroList_, arg_7_0.selectHeroID_)
	local var_7_1, var_7_2 = arg_7_0.switchItemList_:GetHeadAndTail()

	if var_7_0 <= var_7_1 or var_7_2 <= var_7_0 then
		arg_7_0.switchItemList_:ScrollToIndex(var_7_0, false, true)
	end
end

function var_0_0.AddListeners(arg_8_0)
	arg_8_0:AddBtnListener(arg_8_0.unlockHeroBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_8_0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		local var_9_0 = arg_8_0.selectHeroID_
		local var_9_1 = arg_8_0.heroList_
		local var_9_2 = table.indexof(var_9_1, var_9_0) or 1
		local var_9_3 = ActivityCultivateHeroCfg[arg_8_0.activityID_].source[var_9_2]

		JumpTools.JumpToPage2(var_9_3)
	end)
	arg_8_0:AddBtnListener(arg_8_0.rewardPreviewBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_8_0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		JumpTools.OpenPageByJump("cultivateAccumulateReward", {
			rewardActivityID = arg_8_0.activityID_
		})
	end)
	arg_8_0:AddBtnListener(arg_8_0.receiveAccumulateBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_8_0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		CultivateHeroAction.RequireReceiveAccumulateTask(arg_8_0.activityID_, arg_8_0.firstAccumulateTaskID_, function()
			arg_8_0:RefreshAccumulateTask()
		end)
	end)
	arg_8_0:AddBtnListener(arg_8_0.receiveDailyBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_8_0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		local var_13_0 = ActivityCultivateHeroCfg[arg_8_0.activityID_].daily_reward

		if arg_8_0.canReceiveDaily_ == true then
			CultivateHeroAction.RequireReceiveDailyTask(arg_8_0.activityID_, function()
				arg_8_0:RefreshDailyTask()
				arg_8_0:RefreshAccumulateTask()
			end)
		else
			local var_13_1 = {}

			for iter_13_0, iter_13_1 in pairs(var_13_0) do
				if not var_13_1[iter_13_1[1]] then
					var_13_1[iter_13_1[1]] = {}
				end
			end

			JumpTools.OpenPageByJump("rewardPreview", {
				rewardList = var_13_0,
				extraItemTemplateDataList = var_13_1
			}, ViewConst.SYSTEM_ID.REWARD_PREVIEW)
		end
	end)
	arg_8_0:AddBtnListener(arg_8_0.receiveAllHeroTaskBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_8_0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		local var_15_0 = CultivateHeroData:GetHeroTaskInfoList(arg_8_0.activityID_)
		local var_15_1 = CultivateHeroTaskCfg.get_id_list_by_group_id[arg_8_0.selectHeroID_]
		local var_15_2 = {}

		for iter_15_0, iter_15_1 in ipairs(var_15_1) do
			if var_15_0[iter_15_1].isCompleted == true and not var_15_0[iter_15_1].isReceived then
				var_15_2[#var_15_2 + 1] = iter_15_1
			end
		end

		CultivateHeroAction.RequireReceiveHeroTaskList(arg_8_0.activityID_, var_15_2, function()
			arg_8_0:OnReceiveHeroTask()
		end)
	end)
	arg_8_0:AddBtnListener(arg_8_0.descBtn_, nil, function()
		local var_17_0 = GetTips("CULTIVATE_HERO_DESC")

		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			key = "CULTIVATE_HERO_DESC",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = var_17_0
		})
	end)
end

function var_0_0.RefreshUI(arg_18_0, arg_18_1)
	arg_18_0.heroList_ = ActivityCultivateHeroCfg[arg_18_0.activityID_].group

	local var_18_0 = CultivateHeroData:GetSelectHeroID(arg_18_0.activityID_) or arg_18_0.heroList_[1]

	arg_18_0.selectHeroID_ = var_18_0

	if var_18_0 == nil then
		return
	end

	CultivateHeroData:SetSelectHeroID(arg_18_0.activityID_, var_18_0)

	local var_18_1 = CultivateHeroTaskCfg.get_id_list_by_group_id[var_18_0][1]
	local var_18_2 = CultivateHeroTaskCfg[var_18_1].hero
	local var_18_3 = not HeroTools.GetHeroIsUnlock(var_18_2)

	arg_18_0.heroLockState_:SetSelectedState(tostring(var_18_3))
	arg_18_0:RefreshSwitchItem()
	arg_18_0:RefreshRoleImage()
	arg_18_0:RefreshDesc()
	arg_18_0:RefreshHeroTask(arg_18_1)
	arg_18_0:RefreshAccumulateTask()
	arg_18_0:RefreshDailyTask()
end

function var_0_0.RefreshSwitchItem(arg_19_0)
	local var_19_0 = arg_19_0.selectHeroID_
	local var_19_1 = arg_19_0.heroList_
	local var_19_2 = table.indexof(var_19_1, var_19_0) or 1

	arg_19_0.switchItemList_:StartScroll(#var_19_1, var_19_2)
end

function var_0_0.GetSwitchItemClass(arg_20_0)
	return CultivateHeroTools.GetSwitchItemClass(arg_20_0.activityID_)
end

function var_0_0.IndexItem(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = arg_21_0.heroList_[arg_21_1]

	arg_21_2:SetData(arg_21_0.activityID_, var_21_0)
	arg_21_2:SetClickCallBack(arg_21_0.clickSwitchItemHandler_)
	arg_21_2:RefreshSelect(arg_21_0.selectHeroID_)
end

function var_0_0.OnClickSwitchItem(arg_22_0, arg_22_1)
	if arg_22_0.selectHeroID_ == arg_22_1 then
		return
	end

	arg_22_0.rolenodeAni_:Play("UI_ActivityReceivedUI_role_cx", 0, 0)
	arg_22_0.rolenodeAni_:Update(0)
	CultivateHeroData:SetSelectHeroID(arg_22_0.activityID_, arg_22_1)

	arg_22_0.selectHeroID_ = arg_22_1

	arg_22_0:MoveSwitchItemInView()

	local var_22_0 = arg_22_0.switchItemList_:GetItemList()

	for iter_22_0, iter_22_1 in pairs(var_22_0) do
		iter_22_1:RefreshSelect(arg_22_1)
	end

	arg_22_0:RefreshRoleImage()
	arg_22_0:RefreshHeroTask(false)

	local var_22_1 = CultivateHeroTaskCfg.get_id_list_by_group_id[arg_22_1][1]
	local var_22_2 = CultivateHeroTaskCfg[var_22_1].hero
	local var_22_3 = HeroData:GetHeroData(var_22_2).unlock == 0

	arg_22_0.heroLockState_:SetSelectedState(tostring(var_22_3))
end

function var_0_0.RefreshHeroTask(arg_23_0, arg_23_1)
	local var_23_0
	local var_23_1

	arg_23_0.sortedTaskIDList_, var_23_1 = CultivateHeroData:GetSortHeroTaskList(arg_23_0.selectHeroID_, arg_23_0.activityID_)

	arg_23_0.allReceiveBtnState_:SetSelectedState(tostring(var_23_1))

	local var_23_2 = CultivateHeroTaskCfg[arg_23_0.sortedTaskIDList_[1]].hero

	arg_23_0.heroNameText_.text = HeroTools.GetHeroFullName(var_23_2)
	arg_23_0.isEnter = arg_23_1

	if arg_23_1 then
		arg_23_0.heroTaskList_:SetAppearType(1)
	else
		arg_23_0.heroTaskList_:SetAppearType(0)
	end

	arg_23_0.heroTaskList_:StartScroll(#arg_23_0.sortedTaskIDList_)
end

function var_0_0.GetHeroTaskClass(arg_24_0)
	return CultivateHeroTools.GetTaskItemClass(arg_24_0.activityID_)
end

function var_0_0.IndexHeroTask(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = arg_25_0.sortedTaskIDList_[arg_25_1]

	arg_25_2:SetData(arg_25_0.activityID_, var_25_0)
	arg_25_2:SetReveivedHandler(arg_25_0.receivedHeroTaskHandler_)

	local var_25_1 = arg_25_0.isEnter and "UI_Activity_item_cx" or "XH1stReceived_item"

	arg_25_2:SetAni(var_25_1)
end

function var_0_0.OnReceiveHeroTask(arg_26_0)
	arg_26_0:RefreshHeroTask()
	arg_26_0:RefreshAccumulateTask()
end

function var_0_0.RefreshAccumulateTask(arg_27_0)
	local var_27_0 = ActivityPointRewardCfg.get_id_list_by_activity_id[arg_27_0.activityID_]
	local var_27_1 = ItemTools.getItemNum(ActivityCultivateHeroCfg[arg_27_0.activityID_].coin_id)
	local var_27_2 = CultivateHeroData:GetAccumulateTaskInfoList(arg_27_0.activityID_)

	arg_27_0.accumulateStatus_ = 0

	local var_27_3 = #var_27_0
	local var_27_4 = 0

	arg_27_0.firstAccumulateTaskID_ = nil

	for iter_27_0, iter_27_1 in ipairs(var_27_0) do
		local var_27_5 = ActivityPointRewardCfg[iter_27_1]
		local var_27_6 = var_27_2[iter_27_1] and var_27_2[iter_27_1].isReceived == true

		if var_27_1 < var_27_5.need then
			arg_27_0.accumulateStatus_ = 0

			if arg_27_0.firstAccumulateTaskID_ == nil then
				arg_27_0.firstAccumulateTaskID_ = iter_27_1
			end
		elseif not var_27_6 then
			arg_27_0.accumulateStatus_ = 1
			arg_27_0.firstAccumulateTaskID_ = iter_27_1

			break
		else
			var_27_4 = var_27_4 + 1
		end

		if iter_27_0 == var_27_3 and var_27_6 then
			arg_27_0.firstAccumulateTaskID_ = iter_27_1
			arg_27_0.accumulateStatus_ = 2
		end
	end

	local var_27_7 = ActivityPointRewardCfg[arg_27_0.firstAccumulateTaskID_]
	local var_27_8 = var_27_7.need

	arg_27_0.curAccumulateProgressText_.text = string.format(GetTips("VERIFY_ASSETS_PROCESSING_RATE"), var_27_1, var_27_8)
	arg_27_0.coinImage_.sprite = ItemTools.getItemSprite(ActivityCultivateHeroCfg[arg_27_0.activityID_].coin_id)

	arg_27_0:RefreshTotalAccumulateProgress(var_27_4, var_27_3)
	arg_27_0:RefreshAccumulateRewardItem(var_27_7)
	arg_27_0:RefreshAccumulateRewardState()
end

function var_0_0.RefreshTotalAccumulateProgress(arg_28_0, arg_28_1, arg_28_2)
	arg_28_0.totalAccumulateProgressText_.text = string.format(GetTips("VERIFY_ASSETS_PROCESSING_RATE"), arg_28_1, arg_28_2)
end

function var_0_0.RefreshAccumulateRewardItem(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_1.reward_item_list

	for iter_29_0, iter_29_1 in ipairs(var_29_0) do
		if not arg_29_0.accumulateRewardList_[iter_29_0] then
			arg_29_0.accumulateRewardList_[iter_29_0] = CommonItemPool.New(arg_29_0.goRewardPanel_, nil, true)
			arg_29_0.itemDataList_[iter_29_0] = clone(ItemTemplateData)
			arg_29_0.itemDataList_[iter_29_0].clickFun = function(arg_30_0)
				ShowPopItem(POP_ITEM, {
					arg_30_0.id,
					arg_30_0.number
				})
			end
		end

		arg_29_0.itemDataList_[iter_29_0].id = iter_29_1[1]
		arg_29_0.itemDataList_[iter_29_0].number = iter_29_1[2]

		arg_29_0.accumulateRewardList_[iter_29_0]:Show(true)
		arg_29_0.accumulateRewardList_[iter_29_0]:SetData(arg_29_0.itemDataList_[iter_29_0])
	end

	for iter_29_2 = #var_29_0 + 1, #arg_29_0.accumulateRewardList_ do
		arg_29_0.accumulateRewardList_[iter_29_2]:Show(false)
	end
end

function var_0_0.RefreshAccumulateRewardState(arg_31_0)
	if arg_31_0.accumulateStatus_ == 0 then
		arg_31_0.accumulateRewardState_:SetSelectedState("uncompleted")
	elseif arg_31_0.accumulateStatus_ == 2 then
		arg_31_0.accumulateRewardState_:SetSelectedState("received")
	else
		arg_31_0.accumulateRewardState_:SetSelectedState("unreceived")
	end
end

function var_0_0.RefreshDailyTask(arg_32_0)
	arg_32_0:RefreshDailyProgress()
	arg_32_0:RefreshDailyRewardState()
end

function var_0_0.RefreshDailyProgress(arg_33_0)
	local var_33_0 = 100
	local var_33_1 = ActivityPtData:GetCurrentActivityPt(ActivityPtConst.TASK_DAILY_ACTIVITY_PT)

	arg_33_0.dailyPrograssText_.text = string.format(GetTips("VERIFY_ASSETS_PROCESSING_RATE"), var_33_1, var_33_0)
end

function var_0_0.RefreshDailyRewardState(arg_34_0)
	local var_34_0 = 100
	local var_34_1 = ActivityPtData:GetCurrentActivityPt(ActivityPtConst.TASK_DAILY_ACTIVITY_PT)

	if CultivateHeroData:GetDailyTaskStatus()[arg_34_0.activityID_] then
		arg_34_0.dailyRewardState_:SetSelectedState("received")
	elseif var_34_0 <= var_34_1 then
		arg_34_0.canReceiveDaily_ = true

		arg_34_0.dailyRewardState_:SetSelectedState("unreceive")
	else
		arg_34_0.canReceiveDaily_ = false

		arg_34_0.dailyRewardState_:SetSelectedState("uncomplete")
	end
end

function var_0_0.OnActivityPtUpdate(arg_35_0)
	arg_35_0:RefreshDailyTask()
end

function var_0_0.RefreshRoleImage(arg_36_0)
	local var_36_0 = CultivateHeroTaskCfg.get_id_list_by_group_id[arg_36_0.selectHeroID_]
	local var_36_1 = CultivateHeroTaskCfg[var_36_0[1]].hero

	arg_36_0.roleImage_.spriteSync = "TextureConfig/Character/Portrait/" .. var_36_1
end

function var_0_0.RefreshDesc(arg_37_0)
	arg_37_0.descText_.text = GetTips("CULTIVATE_HERO_CONTENT")
end

function var_0_0.AddTimer(arg_38_0)
	if manager.time:GetServerTime() >= arg_38_0.stopTime_ then
		arg_38_0.textTime_.text = GetTips("TIME_OVER")

		return
	end

	arg_38_0:StopTimer()

	arg_38_0.textTime_.text = string.format(GetTips("LEFT_TIME"), manager.time:GetLostTimeStrWith2Unit(arg_38_0.stopTime_))
	arg_38_0.timer_ = Timer.New(function()
		if manager.time:GetServerTime() >= arg_38_0.stopTime_ then
			arg_38_0:StopTimer()

			arg_38_0.textTime_.text = GetTips("TIME_OVER")

			return
		end

		arg_38_0.textTime_.text = string.format(GetTips("LEFT_TIME"), manager.time:GetLostTimeStrWith2Unit(arg_38_0.stopTime_))
	end, 1, -1)

	arg_38_0.timer_:Start()
end

function var_0_0.StopTimer(arg_40_0)
	if arg_40_0.timer_ then
		arg_40_0.timer_:Stop()

		arg_40_0.timer_ = nil
	end
end

function var_0_0.OnExit(arg_41_0)
	arg_41_0:UnbindRedPoint()
	arg_41_0:StopTimer()
end

function var_0_0.Dispose(arg_42_0)
	var_0_0.super.Dispose(arg_42_0)
	arg_42_0:StopTimer()

	if arg_42_0.switchItemList_ then
		arg_42_0.switchItemList_:Dispose()

		arg_42_0.switchItemList_ = nil
	end

	if arg_42_0.heroTaskList_ then
		arg_42_0.heroTaskList_:Dispose()

		arg_42_0.heroTaskList_ = nil
	end

	if arg_42_0.accumulateRewardList_ then
		for iter_42_0, iter_42_1 in ipairs(arg_42_0.accumulateRewardList_) do
			iter_42_1:Dispose()
		end

		arg_42_0.accumulateRewardList_ = nil
	end

	arg_42_0.clickSwitchItemHandler_ = nil
	arg_42_0.receivedHeroTaskHandler_ = nil

	Object.Destroy(arg_42_0.gameObject_)

	arg_42_0.transform_ = nil
	arg_42_0.gameObject_ = nil
end

function var_0_0.BindRedPoint(arg_43_0)
	local var_43_0 = string.format("%s_%s_Daily_Reward", RedPointConst.CULTIVATE_HERO, arg_43_0.activityID_)

	manager.redPoint:bindUIandKey(arg_43_0.receiveDailyBtn_.transform, var_43_0)
end

function var_0_0.UnbindRedPoint(arg_44_0)
	local var_44_0 = string.format("%s_%s_Daily_Reward", RedPointConst.CULTIVATE_HERO, arg_44_0.activityID_)

	manager.redPoint:unbindUIandKey(arg_44_0.receiveDailyBtn_.transform, var_44_0)
end

function var_0_0.Show(arg_45_0, arg_45_1)
	SetActive(arg_45_0.gameObject_, arg_45_1)

	if arg_45_1 == true then
		arg_45_0:RefreshUI(true)
		arg_45_0:RegistEventListener(NEW_DAY, handler(arg_45_0, arg_45_0.OnNewDay))
	else
		arg_45_0:RemoveAllEventListener()
	end
end

function var_0_0.OnNewDay(arg_46_0)
	arg_46_0:RefreshUI(false)
end

return var_0_0
