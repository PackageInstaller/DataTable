ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local ActivityPtScrollEnterView = class("ActivityPtScrollEnterView", ActivityMainBasePanel)

function ActivityPtScrollEnterView:GetUIName()
	return ActivityPtScrollTools.GetEnterUIName(self.activityID_)
end

function ActivityPtScrollEnterView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ActivityPtScrollEnterView:InitUI()
	self:BindCfgUI()
	self:RefreshDesc()
	self:RefreshShop()

	self.clearCon_ = self.stateCon_:GetController("clear")
	self.lockCon_ = self.stateCon_:GetController("lock")
	self.unlockCon_ = self.stateCon_:GetController("unlock")
	self.closeCon_ = self.stateCon_:GetController("close")
	self.scrollHelper_ = LuaList.New(handler(self, self.IndexItem), self.listGo_, ActivityPtScrollTaskItem)
end

function ActivityPtScrollEnterView:IndexItem(arg_4_1, arg_4_2)
	arg_4_2:Refresh(self.list_[arg_4_1], self.activityID_)
end

function ActivityPtScrollEnterView:AddUIListeners()
	self:AddBtnListener(self.exchangeBtn_, nil, function()
		local var_6_0 = ActivityShopCfg[ActivityPtScrollTools.GetShopActivityID(self.activityID_)]
		local var_6_1 = {}

		for iter_6_0, iter_6_1 in ipairs(ActivityShopCfg.get_id_list_by_activity_theme[var_6_0.activity_theme]) do
			local var_6_2 = ActivityData:GetActivityData(ShopListCfg[ActivityShopCfg[iter_6_1].shop_id].activity_id)

			if var_6_2 and var_6_2:IsActivitying() then
				table.insert(var_6_1, ActivityShopCfg[iter_6_1].shop_id)
			end
		end

		local var_6_3, var_6_4 = ShopTools.IsShopOpen(var_6_0.shop_id)

		if var_6_3 then
			JumpTools.GoToSystem("/activityShop", {
				shopId = var_6_0.shop_id,
				showShops = var_6_1
			}, ViewConst.SYSTEM_ID.SHOP)
		elseif var_6_4 == 2 then
			ShowTips("SHOP_EXPIRED")
		elseif var_6_4 == 3 then
			ShowTips("SHOP_NOT_OPEN")
		end
	end)
	self:AddBtnListener(self.goBtn_, nil, function()
		if ActivityTools.GetActivityTheme(self.activityID_) == ActivityConst.THEME.ACTIVITY_4_2 then
			JumpTools.OpenPageByJump("/activityPtScroll_4_2", {
				mainActivityID = self.activityID_
			})
		else
			JumpTools.OpenPageByJump("/activityPtScroll", {
				mainActivityID = self.activityID_
			})
		end
	end)
	self:AddBtnListener(self.allReceiveBtn_, nil, function()
		local var_8_0 = {}
		local var_8_1 = ActivityPtScrollTools.GetTaskActivityID(self.activityID_)

		for iter_8_0, iter_8_1 in ipairs(self.list_) do
			if iter_8_1 ~= 0 then
				local var_8_2 = TaskData2:GetTask(iter_8_1)

				if var_8_2.complete_flag < 1 and var_8_2.progress >= AssignmentCfg[iter_8_1].need then
					table.insert(var_8_0, iter_8_1)
				end
			end
		end

		if self:IsInfinityFinish() then
			ActivityPtScrollAction.TryToSubmitScrollTask(self.activityID_, var_8_0)
		else
			TaskAction:SubmitTaskList(var_8_0)
		end
	end)
	self:AddBtnListener(self.tipBtn_, nil, function()
		local var_9_0 = ActivityPtScrollTools.GetHelpKey(self.activityID_)

		if var_9_0 ~= "" then
			JumpTools.OpenPageByJump("gameHelp", {
				icon = "icon_i",
				iconColor = Color(1, 1, 1),
				title = GetTips("STAGE_DESCRIPE"),
				content = GetTips(var_9_0),
				key = var_9_0
			})
		end
	end)
end

function ActivityPtScrollEnterView:OnEnter()
	self:RefreshUI()
	self:BindRedPointUI()
	self:RegistEventListener(OSIRIS_TASK_UPDATE, handler(self, self.RefreshTask))
	manager.redPoint:setTip(RedPointConst.ACTIVITY_PT_SCROLL_OPEN .. "_" .. self.activityID_, 0)
	saveData(RedPointConst.ACTIVITY_PT_SCROLL_OPEN, tostring(self.activityID_), true)
end

function ActivityPtScrollEnterView:RefreshUI()
	self:RefreshActivityData()
	self:RefreshTime()
	self:RefreshTask()
end

function ActivityPtScrollEnterView:RefreshActivityData()
	self.activityData_ = ActivityData:GetActivityData(self.activityID_)
	self.startTime_ = self.activityData_.startTime
	self.stopTime_ = self.activityData_.stopTime

	local var_12_0 = ActivityPtScrollTools.GetLevelActivityID(self.activityID_)

	self.lock_.text = type(ActivityCfg[self.activityID_].unlock_condition) ~= "table" and "" or string.format(GetTips("ACTIVITY_XUHENG_PT_LOCK"), ChapterCfg[ActivityCfg[self.activityID_].unlock_condition[2][1]].subhead)
	self.isLock_ = not ActivityTools.IsUnlockActivity(self.activityID_)
	self.challengeCurrencyID_ = ActivityPtScrollTools.GetChallengeCurrencyID(self.activityID_)
end

function ActivityPtScrollEnterView:RefreshTime()
	local var_13_0
	local var_13_1 = manager.time:GetServerTime()
	local var_13_2 = ActivityData:GetActivityData((ActivityPtScrollTools.GetLevelActivityID(self.activityID_))).stopTime

	self:StopTimer()

	if var_13_1 < self.startTime_ then
		self.closeCon_:SetSelectedState("true")

		self.timeLable_.text = GetTips("SOLO_NOT_OPEN")
		self.timer_ = Timer.New(function()
			var_13_0 = self.startTime_ - manager.time:GetServerTime()

			if var_13_0 <= 0 then
				self:StopTimer()
				self:RefreshTime()

				return
			end
		end, 1, -1)

		self.timer_:Start()
	elseif var_13_1 < self.stopTime_ then
		var_13_0 = self.stopTime_ - var_13_1

		if self.stopTime_ - var_13_1 < GameSetting.time_remaining_show.value[1] * 86400 then
			self.shopTimeLable_.text = manager.time:GetLostTimeStr2(self.stopTime_, nil, false)

			SetActive(self.shopTimeGo_, true)
		else
			SetActive(self.shopTimeGo_, false)
		end

		if var_13_1 < var_13_2 then
			self.timeLable_.text = manager.time:GetLostTimeStrWith2UnitWithPrefix(var_13_2)

			if self.isLock_ then
				self.lockCon_:SetSelectedState("true")
			else
				self.unlockCon_:SetSelectedState("true")
			end
		else
			self.timeLable_.text = GetTips("TIME_OVER")
		end

		self.timer_ = Timer.New(function()
			var_13_1 = manager.time:GetServerTime()
			var_13_0 = self.stopTime_ - var_13_1

			if var_13_0 <= 0 then
				self:StopTimer()
				self:RefreshTime()

				return
			end

			if var_13_0 < GameSetting.time_remaining_show.value[1] * 86400 then
				self.shopTimeLable_.text = manager.time:GetLostTimeStr2(self.stopTime_, nil, false)

				SetActive(self.shopTimeGo_, true)
			else
				SetActive(self.shopTimeGo_, false)
			end

			if var_13_1 < var_13_2 then
				self.timeLable_.text = manager.time:GetLostTimeStrWith2UnitWithPrefix(var_13_2)

				if self.isLock_ then
					self.lockCon_:SetSelectedState("true")
				else
					self.unlockCon_:SetSelectedState("true")
				end
			else
				self.timeLable_.text = GetTips("TIME_OVER")
			end
		end, 1, -1)

		self.timer_:Start()
	else
		self.closeCon_:SetSelectedState("true")

		self.timeLable_.text = GetTips("TIME_OVER")
		self.shopTimeLable_.text = GetTips("TIME_OVER")
	end
end

function ActivityPtScrollEnterView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function ActivityPtScrollEnterView:RefreshTask()
	local var_17_0 = ActivityPtScrollTools.GetTaskActivityID(self.activityID_)

	self.list_ = {}

	local function var_17_1(arg_18_0, arg_18_1)
		if AssignmentCfg[arg_18_0].type ~= AssignmentCfg[arg_18_1].type then
			return AssignmentCfg[arg_18_0].type < AssignmentCfg[arg_18_1].type
		end

		return arg_18_0 < arg_18_1
	end

	local var_17_2 = {}
	local var_17_3 = {}
	local var_17_4 = {}

	for iter_17_0, iter_17_1 in pairs(TaskTools:GetActivityTaskList(var_17_0) or {}) do
		if AssignmentCfg[iter_17_1.id].activity_id == var_17_0 then
			if iter_17_1.complete_flag >= 1 then
				table.insert(var_17_4, iter_17_1.id)
			elseif iter_17_1.progress >= AssignmentCfg[iter_17_1.id].need then
				table.insert(var_17_2, iter_17_1.id)
			else
				table.insert(var_17_3, iter_17_1.id)
			end
		end
	end

	table.sort(var_17_2, var_17_1)
	table.sort(var_17_3, var_17_1)
	table.sort(var_17_4, var_17_1)

	if self:IsInfinityFinish() then
		table.insert(var_17_2, 1, 0)
	else
		table.insert(var_17_3, 1, 0)
	end

	table.insertto(self.list_, var_17_2)
	table.insertto(self.list_, var_17_3)
	table.insertto(self.list_, var_17_4)

	if #var_17_2 > 0 then
		self.clearCon_:SetSelectedState("true")
	else
		self.clearCon_:SetSelectedState("false")
	end

	self.scrollHelper_:StartScroll(#self.list_)
end

function ActivityPtScrollEnterView:IsInfinityFinish()
	return GameSetting.activity_pt_roulette_task_times.value[1] <= ActivityPtScrollData:GetClearTime(self.activityID_)
end

function ActivityPtScrollEnterView:Show(arg_20_1)
	ActivityPtScrollEnterView.super.Show(self, arg_20_1)

	if arg_20_1 then
		self:RefreshTask()
	end
end

function ActivityPtScrollEnterView:RefreshDesc()
	if self.activityDesc_ then
		local var_21_0 = ActivityPtScrollTools.GetDesc(self.activityID_)

		if var_21_0 ~= "" then
			self.activityDesc_.text = GetTips(var_21_0)
		end
	end
end

function ActivityPtScrollEnterView:RefreshShop()
	local var_22_0 = ActivityShopCfg[ActivityPtScrollTools.GetShopActivityID(self.activityID_)].shop_id

	if ShopListCfg[var_22_0] then
		self.shopName_.text = ShopListCfg[var_22_0].remark
	end
end

function ActivityPtScrollEnterView:UpdateBar()
	local var_23_0 = ActivityPtScrollTools.GetCurrencyID(self.activityID_)

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		self.challengeCurrencyID_,
		var_23_0
	})
	manager.windowBar:SetBarCanClick(self.challengeCurrencyID_, true)
	manager.windowBar:SetBarCanClick(var_23_0, true)
end

function ActivityPtScrollEnterView:BindRedPointUI()
	manager.redPoint:bindUIandKey(self.goBtn_.transform, RedPointConst.ACTIVITY_PT_SCROLL_UP_SELECT .. "_" .. self.activityID_)
end

function ActivityPtScrollEnterView:UnbindRedPointUI()
	manager.redPoint:unbindUIandKey(self.goBtn_.transform, RedPointConst.ACTIVITY_PT_SCROLL_UP_SELECT .. "_" .. self.activityID_)
end

function ActivityPtScrollEnterView:OnExit()
	self:UnbindRedPointUI()
	self:RemoveAllEventListener()
	self:StopTimer()
end

function ActivityPtScrollEnterView:Dispose()
	self:RemoveAllListeners()
	self.scrollHelper_:Dispose()
	self.super.Dispose(self)
end

return ActivityPtScrollEnterView
