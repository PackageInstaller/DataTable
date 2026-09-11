local TaskDailyContentView = class("TaskDailyContentView", ReduxView)

function TaskDailyContentView:OnCtor(arg_1_1, arg_1_2, arg_1_3)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform
	self.taskType_ = arg_1_2
	self.pointType_ = arg_1_3
	self.isShow = false

	self:InitUI()

	self.giftItems_ = {}
end

function TaskDailyContentView:InitUI()
	self:BindCfgUI()

	self.scrollHelper_ = LuaList.New(handler(self, self.indexItem), self.scrollView_, TaskDailyItemView)
	self.receiveBtnController_ = ControllerUtil.GetController(self.transform_, "receiveBtn_all")
	self.rectTrans = self.scrollView_:GetComponent(typeof(RectTransform))
end

function TaskDailyContentView:Init()
	self._taskIDList = TaskData2:GetTypedTaskSortListCommonFilter(self.taskType_)
	self._finishList = TaskTools:GetFinishTaskIds(self.taskType_)

	self:RefreshActivityPoint()
	self:RefreshTimeText()
	self:RefreshGiftItems()
	self:RefreshRecivedAll()
end

function TaskDailyContentView:RefreshScroll(arg_4_1)
	self:UpdateData()

	if arg_4_1 then
		if self.lastPosition_ then
			local var_4_0 = clone(self.lastPosition_)
			local var_4_1

			var_4_1 = FrameTimer.New(function()
				if isNil(self.gameObject_) then
					return
				end

				self.scrollHelper_:StartScrollWithoutAnimator(#self._taskIDList, var_4_0)
				var_4_1:Stop()

				var_4_1 = nil
			end, 1, 1)

			;(nil):Start()
		else
			self.scrollHelper_:StartScrollWithoutAnimator(#self._taskIDList)
		end
	else
		self.scrollHelper_:StartScroll(#self._taskIDList)
	end
end

function TaskDailyContentView:indexItem(arg_6_1, arg_6_2)
	arg_6_2:ReEnter(self._taskIDList[arg_6_1].id)
end

function TaskDailyContentView:Show(arg_7_1, arg_7_2)
	if self.isShow == arg_7_1 then
		return
	end

	self.isShow = arg_7_1

	if arg_7_1 and (not arg_7_2 or true) then
		self:OnEnter()
	else
		self:OnExit(true)
	end
end

function TaskDailyContentView:OnEnter()
	self.isShow = true

	self:Init()
	self:OnTaskListChange(true)
	SetActive(self.gameObject_, true)
end

function TaskDailyContentView:OnExit(arg_9_1)
	self.isShow = false

	if self.dailyTimer_ then
		self.dailyTimer_:Stop()

		self.dailyTimer_ = nil
	end

	if not arg_9_1 then
		self.lastPosition_ = self.scrollHelper_:GetScrolledPosition()
	end

	SetActive(self.gameObject_, false)
end

function TaskDailyContentView:ClearCache()
	self.lastPosition_ = nil
end

function TaskDailyContentView:Dispose()
	self.scrollHelper_:Dispose()

	if self.giftItems_ then
		for iter_11_0, iter_11_1 in pairs(self.giftItems_) do
			iter_11_1:Dispose()
		end
	end

	if self.dailyTimer_ then
		self.dailyTimer_:Stop()

		self.dailyTimer_ = nil
	end

	self.giftItems_ = nil
	self.rectTrans = nil

	TaskDailyContentView.super.Dispose(self)
end

function TaskDailyContentView:UpdateData()
	self._taskIDList = TaskData2:GetTypedTaskSortListCommonFilter(self.taskType_)
end

function TaskDailyContentView:OnTaskListChange(arg_13_1)
	if self.isShow then
		self._finishList = TaskTools:GetFinishTaskIds(self.taskType_)

		self:RefreshRecivedAll()

		if not arg_13_1 then
			self:RefreshScroll(true)
		else
			self:RefreshScroll(false)
		end

		self.lastPosition_ = nil
	end
end

function TaskDailyContentView:OnSubActivityPtUpdate()
	if self.isShow then
		for iter_14_0, iter_14_1 in pairs(self.giftItems_) do
			iter_14_1:RefreshGift()
		end

		self:RefreshActivityPoint()
		self:RefreshRecivedAll()
	end
end

function TaskDailyContentView:RefreshActivityPoint()
	local var_15_0 = ActivityPtData:GetCurrentActivityPt(self.pointType_)

	self.ptNumberText_.text = var_15_0 or 0
	self.ptprogressbarImg_.value = Mathf.Clamp(var_15_0 / ActivityPtCfg[self.pointType_].target[#ActivityPtCfg[self.pointType_].target], 0, 1)
end

function TaskDailyContentView:RefreshTimeText()
	local var_16_0 = TimeMgr.GetInstance():GetNextTime(GameSetting.refresh_time1.value[1][1], 0, 0)
	local var_16_1 = var_16_0 - TimeMgr.GetInstance():GetServerTime()

	self.timeText_.text = string.format(GetTips("TIME_DISPLAY_1"), self:GetTimeText(var_16_0 - TimeMgr.GetInstance():GetServerTime()))

	if self.dailyTimer_ then
		self.dailyTimer_:Stop()
	end

	self.dailyTimer_ = Timer.New(function()
		var_16_1 = var_16_0 - TimeMgr.GetInstance():GetServerTime()

		if var_16_1 < 0 then
			var_16_1 = TimeMgr.GetInstance():GetNextTime(GameSetting.refresh_time1.value[1][1], 0, 0) - TimeMgr.GetInstance():GetServerTime()
		end

		self.timeText_.text = string.format(GetTips("TIME_DISPLAY_1"), self:GetTimeText(var_16_1))
	end, 1, -1)

	self.dailyTimer_:Start()
end

function TaskDailyContentView:RefreshGiftItems()
	for iter_18_0, iter_18_1 in ipairs(ActivityPtCfg[self.pointType_].target) do
		if self.giftItems_[iter_18_0] then
			self.giftItems_[iter_18_0]:SetIndex(iter_18_0)
		else
			self.giftItems_[iter_18_0] = TaskDailyGiftItem.New(self.ptGiftItem_, self.ptGiftParent_, iter_18_0, self.pointType_)
		end
	end
end

function TaskDailyContentView:IsGiftCanReceive()
	for iter_19_0 = 1, #ActivityPtCfg[self.pointType_].target do
		if not TaskTools.ActivityPtIsReceived(self.pointType_, iter_19_0) and TaskTools.ActivityPtCanReceive(self.pointType_, iter_19_0) then
			return true
		end
	end
end

function TaskDailyContentView:RefreshRecivedAll()
	if #self._finishList > 0 or self:IsGiftCanReceive() then
		self:RefreshOnceState(true)
	else
		self:RefreshOnceState(false)
	end
end

function TaskDailyContentView:GetTimeText(arg_21_1)
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

function TaskDailyContentView:RegisterRefreshOnceStateCallback(arg_22_1)
	self.refreshOnceCallback = arg_22_1
end

function TaskDailyContentView:RefreshOnceState(arg_23_1)
	if self.refreshOnceCallback then
		self.refreshOnceCallback(arg_23_1)
	end

	local var_23_0 = self.rectTrans.offsetMin.x

	self.rectTrans.offsetMin = arg_23_1 and Vector2.New(var_23_0, 70) or Vector2.New(var_23_0, 0)
end

function TaskDailyContentView:OnOnceClick()
	TaskAction:SubmitTaskList(TaskTools:GetFinishTaskIds(self.taskType_), self.taskType_)
end

return TaskDailyContentView
