local SummerChessBoardBaseBtn = class("SummerChessBoardBaseBtn", ReduxView)

function SummerChessBoardBaseBtn:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.activityID_ = arg_1_2

	self:InitUI()
end

function SummerChessBoardBaseBtn:InitUI()
	self:BindCfgUI()
	self:AddListeners()

	self.stateController_ = self.controllerEx_:GetController("state")
	self.lockController_ = self.controllerEx_:GetController("lock")
end

function SummerChessBoardBaseBtn:Dispose()
	SummerChessBoardBaseBtn.super.Dispose(self)
end

function SummerChessBoardBaseBtn:AddListeners()
	self:AddBtnListener(self.button_, nil, function()
		local var_5_0, var_5_1 = self:IsUnlockActivity()

		if not var_5_0 then
			local var_5_2, var_5_3 = SummerChessBoardData:CallFun("GetUnlockTips", self.activityID_)

			ShowTips(var_5_2)

			if var_5_3 == 2 then
				manager.notify:CallUpdateFunc(SUMMER_CHESS_BOARD_CLICK_LOCK_ACTIVITY)
			end

			return
		end

		if var_5_0 and var_5_1 ~= 0 and ActivityUnlockStateData:GetUnlockState(var_5_1)[ActivityConst.ACTIVITY_OPERATION_KEY.HIGHT_LIGHT] ~= 1 then
			ActivityUnlockStateAction.UpdateState(var_5_1, ActivityConst.ACTIVITY_OPERATION_KEY.HIGHT_LIGHT, 1)
			manager.redPoint:setTip(SummerChessBoardData:CallFun("GetEntryRedPointKey", self.activityID_), 0, RedPointStyle.SHOW_NEW_TAG)
			self.stateController_:SetSelectedState("normal")
		end

		SummerChessBoardData:CallFun("GotoGameWindow", self.activityID_)
	end)
end

function SummerChessBoardBaseBtn:OnEnter()
	self:RefreshUI()
	self:AddTimer()
	manager.redPoint:bindUIandKey(self.transform_, SummerChessBoardData:CallFun("GetEntryRedPointKey", self.activityID_))

	if self.activityID_ == ActivityConst.SUMMER_CHESS_BOARD_NONSTER_COSPLAY and manager.redPoint:getTipValue(RedPointConst.MONSTER_COSPLAY_SKILL) > 0 then
		SetActive(self.redGo_, true)
	end
end

function SummerChessBoardBaseBtn:OnExit()
	self:StopTimer()
	manager.redPoint:unbindUIandKey(self.transform_, SummerChessBoardData:CallFun("GetEntryRedPointKey", self.activityID_))
end

function SummerChessBoardBaseBtn:AddTimer()
	self:StopTimer()

	local var_8_0 = ActivityData:GetActivityData(self.activityID_)
	local var_8_1 = manager.time:GetServerTime()

	if var_8_1 < var_8_0.startTime then
		self:RefreshTimeText(var_8_0.startTime)
	else
		self:RefreshTimeText(var_8_0.stopTime)
	end

	if var_8_1 >= var_8_0.stopTime then
		self:Show(false)

		return
	end

	self:Show(true)

	self.timer_ = Timer.New(function()
		local var_9_0 = ActivityData:GetActivityData(self.activityID_)
		local var_9_1 = manager.time:GetServerTime()

		if var_9_1 < var_9_0.startTime then
			self:RefreshTimeText(var_9_0.startTime)
		else
			self:RefreshTimeText(var_9_0.stopTime)
		end

		if var_9_1 >= var_9_0.stopTime then
			self:Show(false)
			self:StopTimer()
		end
	end, 1, -1)

	self.timer_:Start()
end

function SummerChessBoardBaseBtn:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function SummerChessBoardBaseBtn:RefreshUI()
	if ActivityCfg[self.activityID_] == nil then
		return
	end

	self.nameText_.text = ActivityCfg[self.activityID_].remark
end

function SummerChessBoardBaseBtn:IsUnlockActivity()
	return SummerChessBoardData:CallFun("CurrentUnlockStageID", self.activityID_)
end

function SummerChessBoardBaseBtn:Show(arg_13_1)
	if arg_13_1 then
		local var_13_0, var_13_1 = self:IsUnlockActivity()

		if var_13_0 and var_13_1 ~= 0 then
			if ActivityUnlockStateData:GetUnlockState(var_13_1)[ActivityConst.ACTIVITY_OPERATION_KEY.HIGHT_LIGHT] ~= 1 then
				self.stateController_:SetSelectedState("new")
			else
				self.stateController_:SetSelectedState("normal")
			end

			self.lockController_:SetSelectedState("false")
		else
			local var_13_2 = ActivitySummerChessConditionCfg.get_id_list_by_activity_id[self.activityID_] or {}

			if #var_13_2 <= 0 then
				self.stateController_:SetSelectedState("normal")
			else
				self.stateController_:SetSelectedState("lock")
			end

			if var_13_0 and #var_13_2 <= 0 then
				self.lockController_:SetSelectedState("false")
			elseif ActivityTools.GetActivityStatus(self.activityID_) == ActivityConst.ACTIVITY_STATE.ACTIVING then
				self.lockController_:SetSelectedState("true")
			else
				self.lockController_:SetSelectedState("timeLock")
			end
		end
	end

	SetActive(self.gameObject_, arg_13_1)
end

function SummerChessBoardBaseBtn:RefreshTimeText(arg_14_1)
	if self.timeText_ then
		self.timeText_.text = manager.time:GetLostTimeStrWith2Unit(arg_14_1)
	end
end

return SummerChessBoardBaseBtn
