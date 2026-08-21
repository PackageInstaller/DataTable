local var_0_0 = class("TaskDailyContentView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.taskType_ = arg_1_2
	arg_1_0.pointType_ = arg_1_3
	arg_1_0.isShow = false

	arg_1_0:InitUI()

	arg_1_0.giftItems_ = {}
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.scrollHelper_ = LuaList.New(handler(arg_2_0, arg_2_0.indexItem), arg_2_0.scrollView_, TaskDailyItemView)
	arg_2_0.receiveBtnController_ = ControllerUtil.GetController(arg_2_0.transform_, "receiveBtn_all")
	arg_2_0.rectTrans = arg_2_0.scrollView_:GetComponent(typeof(RectTransform))
end

function var_0_0.Init(arg_3_0)
	arg_3_0._taskIDList = TaskData2:GetTypedTaskSortListCommonFilter(arg_3_0.taskType_)
	arg_3_0._finishList = TaskTools:GetFinishTaskIds(arg_3_0.taskType_)

	arg_3_0:RefreshActivityPoint()
	arg_3_0:RefreshTimeText()
	arg_3_0:RefreshGiftItems()
	arg_3_0:RefreshRecivedAll()
end

function var_0_0.RefreshScroll(arg_4_0, arg_4_1)
	arg_4_0:UpdateData()

	if arg_4_1 then
		if arg_4_0.lastPosition_ then
			local var_4_0 = clone(arg_4_0.lastPosition_)
			local var_4_1

			var_4_1 = FrameTimer.New(function()
				if isNil(arg_4_0.gameObject_) then
					return
				end

				arg_4_0.scrollHelper_:StartScrollWithoutAnimator(#arg_4_0._taskIDList, var_4_0)
				var_4_1:Stop()

				var_4_1 = nil
			end, 1, 1)

			var_4_1:Start()
		else
			arg_4_0.scrollHelper_:StartScrollWithoutAnimator(#arg_4_0._taskIDList)
		end
	else
		arg_4_0.scrollHelper_:StartScroll(#arg_4_0._taskIDList)
	end
end

function var_0_0.indexItem(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0._taskIDList[arg_6_1].id

	arg_6_2:ReEnter(var_6_0)
end

function var_0_0.Show(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_0.isShow == arg_7_1 then
		return
	end

	arg_7_0.isShow = arg_7_1

	if arg_7_1 and (not arg_7_2 or true) then
		arg_7_0:OnEnter()
	else
		arg_7_0:OnExit(true)
	end
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0.isShow = true

	arg_8_0:Init()
	arg_8_0:OnTaskListChange(true)
	SetActive(arg_8_0.gameObject_, true)
end

function var_0_0.OnExit(arg_9_0, arg_9_1)
	arg_9_0.isShow = false

	if arg_9_0.dailyTimer_ then
		arg_9_0.dailyTimer_:Stop()

		arg_9_0.dailyTimer_ = nil
	end

	if not arg_9_1 then
		arg_9_0.lastPosition_ = arg_9_0.scrollHelper_:GetScrolledPosition()
	end

	SetActive(arg_9_0.gameObject_, false)
end

function var_0_0.ClearCache(arg_10_0)
	arg_10_0.lastPosition_ = nil
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0.scrollHelper_:Dispose()

	if arg_11_0.giftItems_ then
		for iter_11_0, iter_11_1 in pairs(arg_11_0.giftItems_) do
			iter_11_1:Dispose()
		end
	end

	if arg_11_0.dailyTimer_ then
		arg_11_0.dailyTimer_:Stop()

		arg_11_0.dailyTimer_ = nil
	end

	arg_11_0.giftItems_ = nil
	arg_11_0.rectTrans = nil

	var_0_0.super.Dispose(arg_11_0)
end

function var_0_0.UpdateData(arg_12_0)
	arg_12_0._taskIDList = TaskData2:GetTypedTaskSortListCommonFilter(arg_12_0.taskType_)
end

function var_0_0.OnTaskListChange(arg_13_0, arg_13_1)
	if arg_13_0.isShow then
		arg_13_0._finishList = TaskTools:GetFinishTaskIds(arg_13_0.taskType_)

		arg_13_0:RefreshRecivedAll()

		if not arg_13_1 then
			arg_13_0:RefreshScroll(true)
		else
			arg_13_0:RefreshScroll(false)
		end

		arg_13_0.lastPosition_ = nil
	end
end

function var_0_0.OnSubActivityPtUpdate(arg_14_0)
	if arg_14_0.isShow then
		for iter_14_0, iter_14_1 in pairs(arg_14_0.giftItems_) do
			iter_14_1:RefreshGift()
		end

		arg_14_0:RefreshActivityPoint()
		arg_14_0:RefreshRecivedAll()
	end
end

function var_0_0.RefreshActivityPoint(arg_15_0)
	local var_15_0 = ActivityPtData:GetCurrentActivityPt(arg_15_0.pointType_)
	local var_15_1 = ActivityPtCfg[arg_15_0.pointType_].target[#ActivityPtCfg[arg_15_0.pointType_].target]

	arg_15_0.ptNumberText_.text = var_15_0 or 0
	arg_15_0.ptprogressbarImg_.value = Mathf.Clamp(var_15_0 / var_15_1, 0, 1)
end

function var_0_0.RefreshTimeText(arg_16_0)
	local var_16_0 = GameSetting.refresh_time1.value[1][1]
	local var_16_1 = TimeMgr.GetInstance():GetNextTime(var_16_0, 0, 0)
	local var_16_2 = var_16_1 - TimeMgr.GetInstance():GetServerTime()

	arg_16_0.timeText_.text = string.format(GetTips("TIME_DISPLAY_1"), arg_16_0:GetTimeText(var_16_2))

	if arg_16_0.dailyTimer_ then
		arg_16_0.dailyTimer_:Stop()
	end

	arg_16_0.dailyTimer_ = Timer.New(function()
		var_16_2 = var_16_1 - TimeMgr.GetInstance():GetServerTime()

		if var_16_2 < 0 then
			local var_17_0 = GameSetting.refresh_time1.value[1][1]

			var_16_2 = TimeMgr.GetInstance():GetNextTime(var_17_0, 0, 0) - TimeMgr.GetInstance():GetServerTime()
		end

		arg_16_0.timeText_.text = string.format(GetTips("TIME_DISPLAY_1"), arg_16_0:GetTimeText(var_16_2))
	end, 1, -1)

	arg_16_0.dailyTimer_:Start()
end

function var_0_0.RefreshGiftItems(arg_18_0)
	for iter_18_0, iter_18_1 in ipairs(ActivityPtCfg[arg_18_0.pointType_].target) do
		if arg_18_0.giftItems_[iter_18_0] then
			arg_18_0.giftItems_[iter_18_0]:SetIndex(iter_18_0)
		else
			arg_18_0.giftItems_[iter_18_0] = TaskDailyGiftItem.New(arg_18_0.ptGiftItem_, arg_18_0.ptGiftParent_, iter_18_0, arg_18_0.pointType_)
		end
	end
end

function var_0_0.IsGiftCanReceive(arg_19_0)
	local var_19_0 = ActivityPtCfg[arg_19_0.pointType_]

	for iter_19_0 = 1, #var_19_0.target do
		local var_19_1 = TaskTools.ActivityPtIsReceived(arg_19_0.pointType_, iter_19_0)
		local var_19_2 = TaskTools.ActivityPtCanReceive(arg_19_0.pointType_, iter_19_0)

		if not var_19_1 and var_19_2 then
			return true
		end
	end
end

function var_0_0.RefreshRecivedAll(arg_20_0)
	if #arg_20_0._finishList > 0 or arg_20_0:IsGiftCanReceive() then
		arg_20_0:RefreshOnceState(true)
	else
		arg_20_0:RefreshOnceState(false)
	end
end

function var_0_0.GetTimeText(arg_21_0, arg_21_1)
	local var_21_0 = math.ceil(arg_21_1 / 3600 / 24)
	local var_21_1 = math.floor(arg_21_1 / 3600)
	local var_21_2 = math.floor(arg_21_1 / 60 % 60)
	local var_21_3 = math.floor(arg_21_1 % 60)

	if var_21_0 > 1 then
		return var_21_0 .. GetTips("DAY")
	end

	if var_21_3 < 10 then
		var_21_3 = "0" .. var_21_3
	end

	if var_21_2 < 10 then
		var_21_2 = "0" .. var_21_2
	end

	if var_21_1 < 10 then
		var_21_1 = "0" .. var_21_1
	end

	return table.concat({
		var_21_1,
		":",
		var_21_2,
		":",
		var_21_3
	})
end

function var_0_0.RegisterRefreshOnceStateCallback(arg_22_0, arg_22_1)
	arg_22_0.refreshOnceCallback = arg_22_1
end

function var_0_0.RefreshOnceState(arg_23_0, arg_23_1)
	if arg_23_0.refreshOnceCallback then
		arg_23_0.refreshOnceCallback(arg_23_1)
	end

	local var_23_0 = arg_23_0.rectTrans.offsetMin.x

	if arg_23_1 then
		arg_23_0.rectTrans.offsetMin = Vector2.New(var_23_0, 70)
	else
		arg_23_0.rectTrans.offsetMin = Vector2.New(var_23_0, 0)
	end
end

function var_0_0.OnOnceClick(arg_24_0)
	TaskAction:SubmitTaskList(TaskTools:GetFinishTaskIds(arg_24_0.taskType_), arg_24_0.taskType_)
end

return var_0_0
