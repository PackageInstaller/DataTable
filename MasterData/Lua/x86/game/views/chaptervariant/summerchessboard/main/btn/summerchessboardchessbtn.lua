SummerChessBoardBaseBtn = import(".SummerChessBoardBaseBtn")

local SummerChessBoardChessBtn = class("SummerChessBoardChessBtn", SummerChessBoardBaseBtn)

function SummerChessBoardChessBtn:InitUI()
	SummerChessBoardChessBtn.super.InitUI(self)

	self.selectController_ = self.controllerEx_:GetController("explore")
	self.finishController_ = self.controllerEx_:GetController("finish")
end

function SummerChessBoardChessBtn:OnEnter()
	SummerChessBoardChessBtn.super.OnEnter(self)

	local var_2_0 = ChessBoardData:GetCurrentPlayingChessBoardLevelID()

	if ChessBoardLevelCfg[var_2_0] and ChessBoardLevelCfg[var_2_0].activity == self.activityID_ then
		self.selectController_:SetSelectedState("true")
	else
		self.selectController_:SetSelectedState("false")
	end

	local var_2_1 = true

	if ChessBoardLevelCfg.get_id_list_by_activity[self.activityID_] then
		for iter_2_0, iter_2_1 in pairs(ChessBoardLevelCfg.get_id_list_by_activity[self.activityID_]) do
			local var_2_2 = SummerChessBoardData:CallFun("GetTaskIDListInLevelID", self.activityID_, SummerChessBoardTools.GetTaskIDByChessBoardID(self.activityID_), iter_2_1)

			if table.isEmpty(var_2_2) then
				var_2_1 = false
			else
				for iter_2_2, iter_2_3 in pairs(var_2_2) do
					if AssignmentCfg[iter_2_3].need > TaskData2:GetTask(iter_2_3).progress then
						var_2_1 = false

						break
					end
				end

				if var_2_1 == false then
					break
				end
			end
		end
	else
		var_2_1 = false
	end

	if var_2_1 then
		self.finishController_:SetSelectedState("true")
	else
		self.finishController_:SetSelectedState("false")
	end
end

function SummerChessBoardChessBtn:OnExit()
	SummerChessBoardChessBtn.super.OnExit(self)
end

function SummerChessBoardChessBtn:Dispose()
	SummerChessBoardChessBtn.super.Dispose(self)
end

function SummerChessBoardChessBtn:AddListeners()
	SummerChessBoardChessBtn.super.AddListeners(self)
end

function SummerChessBoardChessBtn:AddTimer()
	self:StopTimer()

	local var_6_0 = manager.time:GetServerTime()

	if not self:IsUnlock() and ActivityData:GetActivityIsOpen(self.activityID_) == false then
		local var_6_1

		for iter_6_0, iter_6_1 in pairs(ActivityConst.SUMMER_CHESS_BOARD_SHOW_ACTIVITY) do
			for iter_6_2, iter_6_3 in pairs(iter_6_1) do
				if self.activityID_ == iter_6_3 then
					var_6_1 = iter_6_0
				end
			end
		end

		if not ActivityData:GetActivityIsOpen(var_6_1) then
			self:Show(false)

			return
		end
	end

	self:Show(true)
	self:RefreshTimeText(ActivityData:GetActivityData(self.activityID_).startTime)

	self.timer_ = Timer.New(function()
		local var_7_0 = ActivityData:GetActivityData(self.activityID_)
		local var_7_1 = manager.time:GetServerTime()
		local var_7_2 = ActivityData:GetActivityData(self.activityID_)

		if manager.time:GetServerTime() < var_7_2.startTime then
			self:RefreshTimeText(var_7_2.startTime)
		else
			self:RefreshTimeText(var_7_2.stopTime)
			self:Show(true)
			self:StopTimer()
		end
	end, 1, -1)

	self.timer_:Start()
end

function SummerChessBoardChessBtn:IsUnlock()
	return SummerChessBoardData:CallFun("IsUnlockGamePlay", self.activityID_)
end

function SummerChessBoardChessBtn:Show(arg_9_1)
	if arg_9_1 then
		local var_9_0, var_9_1 = self:IsUnlockActivity()

		if var_9_0 and var_9_1 ~= 0 then
			if ActivityUnlockStateData:GetUnlockState(var_9_1)[ActivityConst.ACTIVITY_OPERATION_KEY.HIGHT_LIGHT] ~= 1 then
				self.stateController_:SetSelectedState("new")
			else
				self.stateController_:SetSelectedState("normal")
			end
		elseif #(ActivitySummerChessConditionCfg.get_id_list_by_activity_id[self.activityID_] or {}) <= 0 then
			self.stateController_:SetSelectedState("normal")
		else
			self.stateController_:SetSelectedState("lock")
		end

		if not self:IsUnlock() then
			self.lockController_:SetSelectedState("true")
		elseif ActivityTools.GetActivityStatus(self.activityID_) == ActivityConst.ACTIVITY_STATE.ACTIVING then
			self.lockController_:SetSelectedState("false")
		else
			self.lockController_:SetSelectedState("timeLock")
		end
	end

	SetActive(self.gameObject_, arg_9_1)
end

return SummerChessBoardChessBtn
