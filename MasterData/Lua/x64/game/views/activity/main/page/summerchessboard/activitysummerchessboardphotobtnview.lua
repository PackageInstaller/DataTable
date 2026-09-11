local ActivitySummerChessBoardPhotoBtnView = class("ActivitySummerChessBoardPhotoBtnView", ReduxView)

function ActivitySummerChessBoardPhotoBtnView:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.activityID_ = arg_1_2
	self.updateActivityHandler_ = handler(self, self.RefreshUI)
end

function ActivitySummerChessBoardPhotoBtnView:OnEnter()
	self:AddPhotoTimer()
	self:BindRedPoint()
end

function ActivitySummerChessBoardPhotoBtnView:OnExit()
	self:StopPhotoTimer()
	self:UnbindRedPoint()
end

function ActivitySummerChessBoardPhotoBtnView:Dispose()
	self.updateActivityHandler_ = nil

	ActivitySummerChessBoardPhotoBtnView.super.Dispose(self)
end

function ActivitySummerChessBoardPhotoBtnView:BindRedPoint()
	manager.redPoint:bindUIandKey(self.transform_, RedPointConst.CAPTURE_GAME_UNLOCK_ROOT)
end

function ActivitySummerChessBoardPhotoBtnView:UnbindRedPoint()
	manager.redPoint:unbindUIandKey(self.transform_)
end

function ActivitySummerChessBoardPhotoBtnView:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		JumpTools.OpenPageByJump("/captureGameActivityMain")
	end)
end

function ActivitySummerChessBoardPhotoBtnView:RefreshTimeText(arg_9_1)
	self.timeText_.text = string.format(GetTips("LEFT_TIME"), manager.time:GetLostTimeStrWith2Unit(arg_9_1, true))
end

function ActivitySummerChessBoardPhotoBtnView:AddPhotoTimer()
	self:StopPhotoTimer()

	local var_10_0 = ActivityData:GetActivityData(self.activityID_)
	local var_10_1 = manager.time:GetServerTime()

	if var_10_1 >= var_10_0.stopTime then
		SetActive(self.gameObject_, false)

		return
	end

	if var_10_1 >= var_10_0.startTime then
		SetActive(self.gameObject_, false)
	else
		SetActive(self.gameObject_, true)
		self:RefreshTimeText(var_10_0.stopTime)
	end

	self:RefreshTime()

	self.photoTimer_ = Timer.New(function()
		self:RefreshTime()
	end, 1, -1)

	self.photoTimer_:Start()
end

function ActivitySummerChessBoardPhotoBtnView:RefreshTime()
	local var_12_0 = ActivityData:GetActivityData(self.activityID_)
	local var_12_1 = manager.time:GetServerTime()

	if var_12_1 >= var_12_0.stopTime then
		self:StopPhotoTimer()
		SetActive(self.gameObject_, false)

		return
	end

	if var_12_1 > var_12_0.startTime then
		if self.gameObject_.activeSelf == false then
			SetActive(self.gameObject_, true)
		end

		self:RefreshTimeText(var_12_0.stopTime)
	end
end

function ActivitySummerChessBoardPhotoBtnView:StopPhotoTimer()
	if self.photoTimer_ then
		self.photoTimer_:Stop()

		self.photoTimer_ = nil
	end
end

return ActivitySummerChessBoardPhotoBtnView
