local var_0_0 = class("SpringWelfareTaskView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/IndiaUI_2_8/IndiaWishingTree/IndiaWishingTreeWishUIRewardsPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()

	arg_3_0.taskList_ = LuaList.New(handler(arg_3_0, arg_3_0.IndexItem), arg_3_0.taskListGo_, SpringWelfareTaskItem)
	arg_3_0.dailyRewardCon_ = ControllerUtil.GetController(arg_3_0.ptTaskRect_, "state")
	arg_3_0.allReceiveController_ = ControllerUtil.GetController(arg_3_0.transform_, "clear")
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.allReceiveBtn_, nil, function()
		arg_5_0:OnClickAllReceiveBtn()
	end)
	arg_5_0:AddBtnListener(arg_5_0.receiveDailyBtn_, nil, function()
		arg_5_0:OnClickReceiveDailyBtn()
	end)
	arg_5_0:AddBtnListener(arg_5_0.dailyPreviewBtn_, nil, function()
		arg_5_0:OnClickDailyBtn()
	end)
	arg_5_0:AddBtnListener(arg_5_0.maskBtn_, nil, function()
		arg_5_0:Back()
	end)
end

function var_0_0.OnEnter(arg_10_0)
	var_0_0.super.OnEnter(arg_10_0)
	arg_10_0:RefreshUI()
	arg_10_0:AddTimer()
end

function var_0_0.OnExit(arg_11_0)
	var_0_0.super.OnExit(arg_11_0)
	arg_11_0:StopTimer()
end

function var_0_0.OnTop(arg_12_0)
	SetActive(arg_12_0.gameObject_, true)
end

function var_0_0.OnBehind(arg_13_0)
	SetActive(arg_13_0.gameObject_, false)
end

function var_0_0.Dispose(arg_14_0)
	arg_14_0.taskList_:Dispose()
	var_0_0.super.Dispose(arg_14_0)
end

function var_0_0.OnClickAllReceiveBtn(arg_15_0)
	local var_15_0 = TaskTools:GetCanGetActivityTaskList(arg_15_0:GetActivityID())

	if not var_15_0 or #var_15_0 <= 0 then
		return
	end

	local var_15_1 = {}

	for iter_15_0, iter_15_1 in ipairs(var_15_0) do
		table.insert(var_15_1, iter_15_1.id)
	end

	arg_15_0:SubmitTaskList(var_15_1)
end

function var_0_0.OnClickReceiveDailyBtn(arg_16_0)
	local var_16_0 = SpringWelfareData:GetTodayPtCfg()

	SpringWelfareAction:AcquireDailyPointReward(var_16_0.id, function()
		arg_16_0:RefreshDailyTaskUI()
		SpringWelfareAction:UpdateRedPoint(arg_16_0:GetActivityID())
	end)
end

function var_0_0.OnClickDailyBtn(arg_18_0)
	local var_18_0 = SpringWelfareData:GetTodayPtCfg().reward_item_list

	if #var_18_0 > 1 then
		JumpTools.OpenPageByJump("rewardPreview", {
			rewardList = var_18_0
		}, ViewConst.SYSTEM_ID.REWARD_PREVIEW)
	else
		ShowPopItem(POP_ITEM, var_18_0[1])
	end
end

function var_0_0.RefreshUI(arg_19_0)
	arg_19_0:RefreshTimeUI()
	arg_19_0:RefreshTaskUI()
	arg_19_0:RefreshDailyTaskUI()
end

function var_0_0.RefreshTimeUI(arg_20_0)
	arg_20_0.timeText_.text = manager.time:GetLostTimeStr2(manager.time:GetNextFreshTime())
end

function var_0_0.IndexItem(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = arg_21_0.sortedTaskIDList_[arg_21_1]

	arg_21_2:SetData(var_21_0.id, arg_21_0:GetActivityID())
	arg_21_2:SetClickHandler(function(arg_22_0, arg_22_1)
		arg_21_0:SubmitTaskList({
			arg_22_1
		})
	end)
end

function var_0_0.RefreshTaskUI(arg_23_0)
	local var_23_0 = TaskData2:GetActivityTaskSortList(arg_23_0:GetActivityID())

	arg_23_0.sortedTaskIDList_ = var_23_0

	arg_23_0.taskList_:StartScroll(#var_23_0)

	local var_23_1 = SpringWelfareData:HasTaskCanAcquire()

	arg_23_0.allReceiveController_:SetSelectedState(var_23_1 and "true" or "false")
end

function var_0_0.RefreshDailyTaskUI(arg_24_0)
	local var_24_0 = SpringWelfareData:GetTodayPtCfg()
	local var_24_1 = var_24_0.need
	local var_24_2 = SpringWelfareData:GetTodayPtProgress()
	local var_24_3 = SpringWelfareData:GetPtItemId()
	local var_24_4 = var_24_0.reward_item_list[1]

	arg_24_0.ptNeedIcon_.sprite = ItemTools.getItemSprite(var_24_3)
	arg_24_0.ptTaskRewardIcon_.sprite = ItemTools.getItemSprite(var_24_4[1])
	arg_24_0.ptTaskRewardText_.text = string.format("x%d", var_24_4[2])
	arg_24_0.ptNeedText_.text = string.format("%d/%d", var_24_2, var_24_1)
	arg_24_0.ptTaskTitleText_.text = GetTips("SPRING_BLESSING_TASK_ITEM_TITLE")
	arg_24_0.ptTaskDescText_.text = GetTips("SPRING_BLESSING_TASK_ITEM_DESC")

	if SpringWelfareData:IsTodayPtAcquired() then
		arg_24_0.dailyRewardCon_:SetSelectedState("received")
	else
		local var_24_5 = SpringWelfareData:IsTodayPtCanAcquire()

		arg_24_0.dailyRewardCon_:SetSelectedState(var_24_5 and "complete" or "unfinish")
	end
end

function var_0_0.SubmitTaskList(arg_25_0, arg_25_1)
	arg_25_0.curSubmitIdList_ = arg_25_1

	TaskAction:SubmitTaskList(arg_25_1)
end

function var_0_0.OnTaskListChange(arg_26_0)
	local var_26_0 = arg_26_0.curSubmitIdList_ or {}

	arg_26_0.curSubmitIdList_ = {}

	local var_26_1 = 0

	for iter_26_0, iter_26_1 in ipairs(var_26_0) do
		local var_26_2 = AssignmentCfg[iter_26_1]

		if TaskData2:GetTask(iter_26_1).complete_flag >= 1 then
			for iter_26_2, iter_26_3 in ipairs(var_26_2.reward) do
				if iter_26_3[1] == 53089 then
					var_26_1 = var_26_1 + iter_26_3[2]
				end
			end
		end
	end

	SpringWelfareData:AddTodayPtProgress(var_26_1)
	arg_26_0:RefreshUI()
	arg_26_0.taskList_:Refresh()
end

function var_0_0.AddTimer(arg_27_0)
	arg_27_0:StopTimer()

	arg_27_0.timer_ = Timer.New(function()
		arg_27_0:RefreshTimeUI()
	end, 1, -1)

	arg_27_0.timer_:Start()
end

function var_0_0.StopTimer(arg_29_0)
	if arg_29_0.timer_ then
		arg_29_0.timer_:Stop()

		arg_29_0.timer_ = nil
	end
end

function var_0_0.GetActivityID(arg_30_0)
	return SpringWelfareData:GetActivityId()
end

return var_0_0
